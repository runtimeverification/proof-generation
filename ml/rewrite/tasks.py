from __future__ import annotations

from typing import Mapping, List, Optional, Any, Dict, Callable, Tuple, TypeVar, Type, Set
from dataclasses import dataclass, field

import schema  # type: ignore

from ml.kore import ast as kore
from ml.kore.parser import parse_pattern
from ml.kore.utils import KoreUtils

from .templates import KoreTemplates

T = TypeVar("T", bound="WithSchema")

Schema = Any


class WithSchema:
    @staticmethod
    def get_raw_schema() -> Schema:
        raise NotImplementedError()

    @staticmethod
    def parse_from_object(obj: Any) -> Any:
        raise NotImplementedError()

    @classmethod
    def get_schema(cls) -> Any:
        return schema.And(cls.get_raw_schema(), schema.Use(cls.parse_from_object))

    @classmethod
    def load_from_object(cls: Type[T], obj: Any) -> T:
        return schema.Schema(cls.get_schema()).validate(obj)  # type: ignore


@dataclass
class Substitution(WithSchema):
    substitution: Dict[kore.Variable, kore.Pattern] = field(default_factory=lambda: {})

    def is_empty(self) -> bool:
        return len(self.substitution) == 0

    def resolve(self, module: kore.Module) -> None:
        for k, v in self.substitution.items():
            k.resolve(module)
            v.resolve(module)

    def as_predicate(self, sort: kore.Sort) -> kore.Pattern:
        r"""
        Encode a substitution as a predicate
        { k |-> v }
        =>
        k = v /\ ...
        """

        items = list(self.substitution.items())
        items.sort(key=lambda t: t[0], reverse=True)

        constraint = KoreUtils.construct_top(sort)

        for k, v in items:
            constraint = KoreUtils.construct_and(
                KoreUtils.construct_equals(sort, k, v),
                constraint,
            )

        return constraint

    @staticmethod
    def from_predicate(predicate: kore.Pattern) -> Substitution:
        assert isinstance(predicate, kore.MLPattern), \
               f"{predicate} is not a substitution constraint"

        if predicate.construct == kore.MLPattern.AND:
            left, right = predicate.arguments
            return Substitution.from_predicate(left).merge(Substitution.from_predicate(right))
        elif KoreUtils.is_equals(predicate):
            left, right = KoreUtils.destruct_equals(predicate)
            assert isinstance(left, kore.Variable), \
                   f"{predicate} is not a substitution constraint"
            return Substitution({left: right})
        elif KoreUtils.is_top(predicate):
            return Substitution({})
        else:
            assert False, f"unexpected predicate {predicate}"

    def merge(self, other: Substitution) -> Substitution:
        return Substitution({**self.substitution, **other.substitution})

    def orient(self, preferable_value: Set[kore.Variable]) -> Substitution:
        """
        Orient mappings in the substitution such that if we have
        v1 |-> v2 in substitution
        if v1 is in <preferable_value> but v2 is not in <preferable_value>
        then we switch it to v2 |-> v1
        """
        subst: Dict[kore.Variable, kore.Pattern] = {}

        for k, v in self.substitution.items():
            if isinstance(v, kore.Variable) and k in preferable_value and v not in preferable_value:
                subst[v] = k
            else:
                subst[k] = v

        return Substitution(subst)

    def split(self, variables: Set[kore.Variable]) -> Tuple[Substitution, Substitution]:
        """
        Split the subsitution to two parts:
        - sigma1 where the variables are all in <variables>
        - sigma2 where the variables are not in <variables>
        """

        subst1 = {}
        subst2 = {}

        for k, v in self.substitution.items():
            if k in variables:
                subst1[k] = v
            else:
                subst2[k] = v

        return Substitution(subst1), Substitution(subst2)

    @staticmethod
    def get_raw_schema() -> Any:
        return [
            {
                "key": schema.And(str, schema.Use(parse_pattern)),
                "value": schema.And(str, schema.Use(parse_pattern)),
            }
        ]

    @staticmethod
    def parse_from_object(obj: Any) -> Substitution:
        assert isinstance(obj, list)
        substitution: Dict[kore.Variable, kore.Pattern] = {}

        for item in obj:
            assert isinstance(item, dict)
            assert "key" in item and isinstance(item["key"], kore.Variable)
            assert "value" in item and isinstance(item["value"], kore.Pattern)
            substitution[item["key"]] = item["value"]

        return Substitution(substitution)


@dataclass
class ConstrainedPattern(WithSchema):
    pattern: kore.Pattern
    constraint: kore.Pattern
    substitution: Substitution

    def get_free_variables(self) -> Set[kore.Variable]:
        return KoreUtils.get_free_variables(self.pattern)

    def assume_unconstrained(self) -> kore.Pattern:
        assert isinstance(self.constraint, kore.MLPattern) and \
               self.constraint.construct == kore.MLPattern.TOP and \
               self.substitution.is_empty()
        return self.pattern

    def get_substitution(self) -> Mapping[kore.Variable, kore.Pattern]:
        return self.substitution.substitution if self.substitution is not None else {}

    def get_constraint_as_pattern(self) -> kore.Pattern:
        """
        Encode the constraint and substitution as a kore pattern
        """
        sort = KoreUtils.infer_sort(self.pattern)
        return KoreUtils.construct_and(self.constraint, self.substitution.as_predicate(sort))

    def resolve(self, module: kore.Module) -> None:
        self.pattern.resolve(module)
        self.constraint.resolve(module)
        self.substitution.resolve(module)

    def as_pattern(self) -> kore.Pattern:
        """
        Encode as a kore pattern
        """
        return KoreUtils.construct_and(self.get_constraint_as_pattern(), self.pattern)

    @staticmethod
    def from_pattern(pattern: kore.Pattern) -> ConstrainedPattern:
        constraint, term = KoreUtils.destruct_and(pattern)
        constraint_left, constraint_right = KoreUtils.destruct_and(constraint)
        return ConstrainedPattern(term, constraint_left, Substitution.from_predicate(constraint_right))

    @staticmethod
    def get_raw_schema() -> Any:
        parse_and_strip_inj = lambda src: KoreTemplates.strip_inj(parse_pattern(src))
        default_constraint = parse_pattern("\\top{SortGeneratedTopCell{}}()")
        return schema.Or(
            {
                "term": schema.And(str, schema.Use(parse_and_strip_inj)),
                schema.Optional("constraint", default=default_constraint): schema.And(str, schema.Use(parse_pattern)),
                schema.Optional("substitution", default=Substitution()): Substitution.get_schema(),
            },

            # or we allow a term without constraint
            schema.And(str, schema.Use(parse_and_strip_inj)),
        )

    @staticmethod
    def parse_from_object(obj: Any) -> ConstrainedPattern:
        if isinstance(obj, kore.Pattern):
            return ConstrainedPattern(obj, parse_pattern("\\top{SortGeneratedTopCell{}}()"), Substitution())

        assert isinstance(obj, dict)
        assert "term" in obj and isinstance(obj["term"], kore.Pattern)
        assert "constraint" in obj and isinstance(obj["constraint"], kore.Pattern)
        assert "substitution" in obj and isinstance(obj["substitution"], Substitution)
        return ConstrainedPattern(obj["term"], obj["constraint"], obj["substitution"])


@dataclass
class AppliedRule(WithSchema):
    results: Tuple[ConstrainedPattern, ...]
    rule_id: Optional[str] = None
    substitution: Optional[Substitution] = None

    def get_substitution(self) -> Mapping[kore.Variable, kore.Pattern]:
        return self.substitution.substitution if self.substitution is not None else {}

    def resolve(self, module: kore.Module) -> None:
        for result in self.results:
            result.resolve(module)

        if self.substitution is not None:
            self.substitution.resolve(module)

    @staticmethod
    def get_raw_schema() -> Any:
        return {
            "results": schema.And([ConstrainedPattern.get_schema()], schema.Use(tuple)),
            schema.Optional("rule-id"): str,
            schema.Optional("substitution"): Substitution.get_schema(),
        }

    @staticmethod
    def parse_from_object(obj: Any) -> AppliedRule:
        assert isinstance(obj, dict)
        assert "results" in obj and isinstance(obj["results"], tuple)

        if "rule-id" in obj:
            assert isinstance(obj["rule-id"], str)
            rule_id: Optional[str] = obj["rule-id"]
        else:
            rule_id = None

        if "substitution" in obj:
            assert isinstance(obj["substitution"], Substitution)
            substitution: Optional[Substitution] = obj["substitution"]
        else:
            substitution = None

        return AppliedRule(obj["results"], rule_id, substitution)


@dataclass
class RewritingStep(WithSchema):
    initial: ConstrainedPattern
    applied_rules: Tuple[AppliedRule, ...]
    remainders: Tuple[ConstrainedPattern, ...]

    def is_final(self) -> bool:
        return len(self.applied_rules) == 0

    def get_initial_pattern(self) -> ConstrainedPattern:
        return self.initial

    def get_rewritten_patterns(self) -> Tuple[ConstrainedPattern, ...]:
        return sum((rule.results for rule in self.applied_rules), start=())

    def resolve(self, module: kore.Module) -> None:
        self.initial.resolve(module)

        for rule in self.applied_rules:
            rule.resolve(module)

        for remainder in self.remainders:
            remainder.resolve(module)

    @staticmethod
    def get_raw_schema() -> Any:
        return {
            "initial": ConstrainedPattern.get_schema(),
            "applied-rules": schema.And([AppliedRule.get_schema()], schema.Use(tuple)),
            "remainders": schema.And([ConstrainedPattern.get_schema()], schema.Use(tuple)),
        }

    @staticmethod
    def parse_from_object(obj: Any) -> RewritingStep:
        assert isinstance(obj, dict)
        assert "initial" in obj and isinstance(obj["initial"], ConstrainedPattern)
        assert "applied-rules" in obj and isinstance(obj["applied-rules"], tuple)
        assert "remainders" in obj and isinstance(obj["remainders"], tuple)
        return RewritingStep(obj["initial"], obj["applied-rules"], obj["remainders"])


@dataclass
class RewritingTask(WithSchema):
    initial: ConstrainedPattern
    finals: Tuple[ConstrainedPattern, ...]
    steps: Tuple[RewritingStep, ...]

    def get_all_steps(self) -> Tuple[RewritingStep, ...]:
        """
        Get all non-final steps
        """
        return tuple(step for step in self.steps if not step.is_final())

    def get_initial_pattern(self) -> ConstrainedPattern:
        return self.initial

    def get_final_patterns(self) -> Tuple[ConstrainedPattern, ...]:
        return self.finals

    def resolve(self, module: kore.Module) -> None:
        """
        Resolve all Kore AST in the task object in the context of the given module
        """
        self.initial.resolve(module)

        for final in self.finals:
            final.resolve(module)

        for step in self.steps:
            step.resolve(module)

    @staticmethod
    def get_raw_schema() -> Any:
        return {
            "task": "rewriting",
            "initial": ConstrainedPattern.get_schema(),
            "finals": schema.And([ConstrainedPattern.get_schema()], schema.Use(tuple)),
            "steps": schema.Or(
                None,
                schema.And([RewritingStep.get_schema()], schema.Use(tuple)),
            ),
        }

    @staticmethod
    def parse_from_object(obj: Any) -> RewritingTask:
        assert isinstance(obj, dict)
        assert "initial" in obj and isinstance(obj["initial"], ConstrainedPattern)
        assert "finals" in obj and isinstance(obj["finals"], tuple)
        assert "steps" in obj and (isinstance(obj["steps"], tuple) or obj["steps"] is None)
        steps = () if obj["steps"] is None else obj["steps"]
        return RewritingTask(obj["initial"], obj["finals"], steps)
