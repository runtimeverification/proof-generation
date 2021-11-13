from typing import Dict, Callable, Optional, Union
from dataclasses import dataclass, field

import z3  # type: ignore

from ml.kore import ast as kore
from ml.kore.utils import KoreUtils

from .env import KoreComposer, ProofGenerator, ProvableClaim


@dataclass
class SMTOption:
    prelude_file: Optional[str] = None
    tactic: str = "default"
    timeout: Optional[int] = None  # in ms


class SMTProofGenerator(ProofGenerator):
    HOOKED_FUNCTION_TO_SMT_FUNCTION: Dict[str, Callable[..., z3.AstRef]] = {
        "Lbl'UndsPlus'Int'Unds'": lambda a, b: a + b,
        "Lbl'Unds'-Int'Unds'": lambda a, b: a - b,
        "Lbl'UndsStar'Int'Unds'": lambda a, b: a * b,
        "Lbl'UndsSlsh'Int'Unds'": lambda a, b: a / b,
        "Lbl'UndsPerc'Int'Unds'": lambda a, b: a % b,
        "Lbl'Unds-GT-Eqls'Int'Unds'": lambda a, b: a >= b,
        "Lbl'Unds-LT-Eqls'Int'Unds'": lambda a, b: a <= b,
        "Lbl'Unds-GT-'Int'Unds'": lambda a, b: a > b,
        "Lbl'Unds-LT-'Int'Unds'": lambda a, b: a < b,
        "Lbl'UndsEqlsEqls'Int'Unds'": lambda a, b: a == b,
        "Lbl'UndsEqlsSlshEqls'Int'Unds'": lambda a, b: a != b,
        "Lbl'Unds'andBool'Unds'": lambda a, b: z3.And(a, b),
        "LblnotBool'Unds'": lambda a: z3.Not(a),
        "Lbl'UndsEqlsEqls'K'Unds'": lambda a, b: a == b,
        "Lbl'UndsEqlsSlshEqls'K'Unds'": lambda a, b: z3.Not(a == b),
    }

    SMT_HOOK_TO_SMT_FUNCTION: Dict[str, Callable[..., z3.AstRef]] = {
        "(^ #1 #2)": lambda x, y: x**y,
        "(gcd #1 #2)": lambda x, y: z3.Function("gcd", z3.IntSort(), z3.IntSort(), z3.IntSort())(x, y),
        "(ite (< #1 0) (- 0 #1) #1)": lambda x: z3.If(x < 0, -x, x),
        "distinct": lambda *args: z3.Distinct(*args),
    }

    SEED_0 = z3.ParamsRef()
    SEED_0.set("random_seed", 0)

    # TODO: actually write a parser
    TACTIC_MAP = {
        "default":
        z3.Tactic("default"),
        "(and-then qfnra-nlsat default)":
        z3.AndThen(z3.Tactic("qfnra-nlsat"), z3.Tactic("default")),
        "(! default :random_seed 0)":
        z3.WithParams(z3.Tactic("default"), SEED_0),
        "(! (and-then qfnra-nlsat default) :random_seed 0)":
        z3.WithParams(z3.AndThen(z3.Tactic("qfnra-nlsat"), z3.Tactic("default")), SEED_0),
    }

    def __init__(
        self,
        composer: KoreComposer,
        option: SMTOption = SMTOption(),
    ):
        super().__init__(composer)

        assert option.tactic in SMTProofGenerator.TACTIC_MAP, \
               f"unsupported tactic {option.tactic}"
        tactic = SMTProofGenerator.TACTIC_MAP[option.tactic]

        self.solver = tactic.solver()
        if option.timeout is not None:
            self.solver.set("timeout", option.timeout)
        self.prelude_formulas = []

        # TODO: this only supports formulas (but no declarations and options)
        if option.prelude_file is not None:
            for formula in z3.parse_smt2_file(option.prelude_file):
                self.prelude_formulas.append(formula)

    def check_validity(self, predicate: Union[kore.Pattern, kore.Claim]) -> Optional[ProvableClaim]:
        """
        Check that the given predicate, when encoded in FOL, is valid
        Return a claim of |- predicate with proof omitted
        """

        if isinstance(predicate, kore.Claim):
            predicate = predicate.pattern

        encoded_predicate = self.encode_predicate(predicate, {})

        self.solver.push()

        for formula in self.prelude_formulas:
            self.solver.add(formula)
        self.solver.add(z3.Not(encoded_predicate))

        result = self.solver.check()
        print(f"smt query {result}:", encoded_predicate)

        self.solver.pop()

        if result == z3.unsat:
            return self.composer.load_fresh_claim_placeholder(f"smt-query", predicate)
        else:
            return None

    def encode_predicate(self, predicate: kore.Pattern, abstraction_map: Dict[kore.Pattern, z3.BoolRef]) -> z3.BoolRef:
        """
        Encode a kore predicate as a boolean term
        """

        if isinstance(predicate, kore.MLPattern):
            if KoreUtils.is_equals(predicate):
                left, right = KoreUtils.destruct_equals(predicate)
                return self.encode_term(left, abstraction_map) == self.encode_term(right, abstraction_map)

            elif KoreUtils.is_and(predicate):
                left, right = KoreUtils.destruct_and(predicate)
                return z3.And(
                    self.encode_predicate(left, abstraction_map), self.encode_predicate(right, abstraction_map)
                )

            elif KoreUtils.is_or(predicate):
                left, right = KoreUtils.destruct_or(predicate)
                return z3.Or(
                    self.encode_predicate(left, abstraction_map), self.encode_predicate(right, abstraction_map)
                )

            elif KoreUtils.is_implies(predicate):
                left, right = KoreUtils.destruct_implies(predicate)
                return z3.Implies(
                    self.encode_predicate(left, abstraction_map), self.encode_predicate(right, abstraction_map)
                )

            elif KoreUtils.is_not(predicate):
                subterm, = KoreUtils.destruct_not(predicate)
                return z3.Not(self.encode_predicate(subterm, abstraction_map))

            elif KoreUtils.is_top(predicate):
                return True

            elif KoreUtils.is_bottom(predicate):
                return False

        # abstract the predicate using a Boolean variable
        if predicate in abstraction_map:
            return abstraction_map[predicate]

        abstraction_map[predicate] = z3.FreshBool()
        print(f"abstracting predicate with variable {abstraction_map[predicate]}: {predicate}")
        return abstraction_map[predicate]

        # assert False, f"unable to encode predicate {predicate}"

    def encode_term(self, term: kore.Pattern, abstraction_map: Dict[kore.Pattern, z3.BoolRef]) -> z3.AstRef:
        """
        Encode a (functional) pattern as a FOL term

        TODO: currently only supports integers and booleans
        """

        if KoreUtils.is_dv(term):
            sort, literal = KoreUtils.destruct_dv(term)
            assert isinstance(sort, kore.SortInstance)

            sort_id = sort.get_sort_id()

            if sort_id == "SortInt":
                return int(literal.content)

            elif sort_id == "SortBool":
                assert literal.content == "true" or literal.content == "false"
                return literal.content == "true"

        elif isinstance(term, kore.Application):
            symbol_name = term.symbol.get_symbol_name()

            if symbol_name in SMTProofGenerator.HOOKED_FUNCTION_TO_SMT_FUNCTION:
                function = SMTProofGenerator.HOOKED_FUNCTION_TO_SMT_FUNCTION[symbol_name]
                subterms = tuple(self.encode_term(argument, abstraction_map) for argument in term.arguments)
                return function(*subterms)

            definition = term.symbol.definition

            # TODO: hacky, fix this
            if isinstance(definition, kore.SymbolDefinition) and definition.has_attribute("smt-hook"):
                smt_hook = definition.get_attribute_by_symbol("smt-hook")
                assert smt_hook is not None

                smt_hook_arg = smt_hook.arguments[0]
                assert isinstance(smt_hook_arg, kore.StringLiteral)
                template = smt_hook_arg.content

                assert template in SMTProofGenerator.SMT_HOOK_TO_SMT_FUNCTION, \
                       f"unsupported SMT hook {template} for {term}"

                return SMTProofGenerator.SMT_HOOK_TO_SMT_FUNCTION[template](
                    *(self.encode_term(arg, abstraction_map) for arg in term.arguments)
                )

        elif isinstance(term, kore.Variable):
            assert isinstance(term.sort, kore.SortInstance)
            sort_id = term.sort.get_sort_id()

            if sort_id == "SortInt":
                return z3.Int(term.name)

            elif sort_id == "SortBool":
                return z3.Bool(term.name)

        sort = KoreUtils.infer_sort(term)

        if isinstance(sort, kore.SortInstance) and sort.get_sort_id() == "SortBool":
            if term in abstraction_map:
                return abstraction_map[term]

            abstraction_map[term] = z3.FreshBool()
            print(f"abstracting term with variable {abstraction_map[term]}: {term}")
            return abstraction_map[term]

        assert False, f"unable to encode term {term}"
