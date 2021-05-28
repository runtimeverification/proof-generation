from __future__ import annotations

from typing import Mapping, List, Optional, Any, Dict, Callable, Tuple, TypeVar, Type
from dataclasses import dataclass, field

import schema  # type: ignore

from ml.kore import ast as kore
from ml.kore.parser import parse_pattern

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

    def assume_concrete(self) -> kore.Pattern:
        assert isinstance(self.constraint, kore.MLPattern) and \
               self.constraint.construct == kore.MLPattern.TOP and \
               self.substitution.is_empty()
        return self.pattern

    def get_substitution(self) -> Mapping[kore.Variable, kore.Pattern]:
        return self.substitution.substitution if self.substitution is not None else {}

    def resolve(self, module: kore.Module) -> None:
        self.pattern.resolve(module)
        self.constraint.resolve(module)

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


#####################################

# class RewritingStep:
#     """
#     Hints for a rewriting step, with the following fields
#       - expected initial term (optional)
#       - rewriting rule used (optional)
#       - substitution used (optional)
#     """
#     def __init__(
#         self,
#         initial: Optional[kore.Pattern] = None,
#         rule_id: Optional[str] = None,
#         substitution: Optional[Mapping[kore.Variable, kore.Pattern]] = None,
#         results: Tuple[kore.Pattern, ...] = (),
#     ):
#         self.initial = initial
#         self.rule_id = rule_id
#         self.substitution = substitution
#         self.results = results

# class RewritingTask:
#     """
#     Rewriting task aims to prove a rewriting claim
#     """
#     def __init__(
#         self,
#         initial: kore.Pattern,
#         final: kore.Pattern,
#         steps: List[RewritingStep],
#     ):
#         self.initial = initial
#         self.final = final
#         self.steps = steps

#     @staticmethod
#     def load_from_object(module: kore.Module, obj: Dict[str, Any]) -> RewritingTask:
#         parse: Callable[[str], kore.Pattern] = lambda src: parse_pattern(src, module)
#         parse_and_strip_inj = lambda src: KoreTemplates.strip_inj(parse(src))

#         validated = schema.Schema(
#             {
#                 "task":
#                 "rewriting",
#                 "initial":
#                 schema.And(
#                     str,
#                     schema.Use(parse_and_strip_inj),
#                 ),
#                 "final":
#                 schema.And(
#                     str,
#                     schema.Use(parse_and_strip_inj),
#                 ),
#                 schema.Optional("steps"): [
#                     schema.Or(
#                         {
#                             "type":
#                             "rewriting",
#                             schema.Optional("from"):
#                             schema.And(str, schema.Use(parse_and_strip_inj)),
#                             schema.Optional("rule-id"):
#                             str,
#                             schema.Optional("substitution"): [
#                                 {
#                                     "key": schema.And(
#                                         str,
#                                         schema.Use(parse),
#                                     ),
#                                     "value": schema.And(
#                                         str,
#                                         schema.Use(parse),
#                                     ),
#                                 }
#                             ],
#                         }
#                     )
#                 ],
#             }
#         ).validate(obj)

#         # construct each step from validated object
#         steps = []
#         for step_obj in validated.get("steps", []):
#             substitution: Optional[Mapping[kore.Variable, kore.Pattern]] = None

#             if "substitution" in step_obj:
#                 substitution = {}
#                 for item in step_obj["substitution"]:
#                     substitution[item["key"]] = item["value"]

#             step = RewritingStep(step_obj.get("from"), step_obj.get("rule-id"), substitution)
#             steps.append(step)

#         return RewritingTask(validated["initial"], validated["final"], steps)
