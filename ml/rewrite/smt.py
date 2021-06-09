from typing import Dict, Callable, Optional, Union

import z3  # type: ignore

from ml.kore import ast as kore
from ml.kore.utils import KoreUtils

from .env import KoreComposer, ProofGenerator, ProvableClaim


class SMTProofGenerator(ProofGenerator):
    HOOKED_FUNCTION_TO_SMT_FUNCTION: Dict[str, Callable[..., z3.AstRef]] = {
        "Lbl'UndsPlus'Int'Unds'": lambda a, b: a + b,
        "Lbl'Unds'-Int'Unds'": lambda a, b: a - b,
        "Lbl'UndsStar'Int'Unds'": lambda a, b: a * b,
        "Lbl'UndsSlsh'Int'Unds'": lambda a, b: a / b,
        "Lbl'Unds-GT-Eqls'Int'Unds'": lambda a, b: a >= b,
        "Lbl'Unds-LT-Eqls'Int'Unds'": lambda a, b: a <= b,
        "Lbl'UndsEqlsEqls'Int'Unds'": lambda a, b: a == b,
        "Lbl'Unds'andBool'Unds'": lambda a, b: z3.And(a, b),
        "LblnotBool'Unds'": lambda a: z3.Not(a),
        "Lbl'UndsEqlsEqls'K'Unds'": lambda a, b: a == b,
        "Lbl'UndsEqlsSlshEqls'K'Unds'": lambda a, b: z3.Not(a == b),
    }

    def __init__(self, composer: KoreComposer):
        super().__init__(composer)
        self.smt_query_counter = 0

    def check_validity(self, predicate: Union[kore.Pattern, kore.Claim]) -> Optional[ProvableClaim]:
        """
        Check that the given predicate, when encoded in FOL, is valid
        Return a claim of |- predicate with proof omitted
        """

        if isinstance(predicate, kore.Claim):
            predicate = predicate.pattern

        encoded_predicate = self.encode_predicate(predicate)

        solver = z3.Solver()
        solver.add(z3.Not(encoded_predicate))

        if solver.check() == z3.unsat:
            print("smt query unsat:", encoded_predicate)
            counter = self.smt_query_counter
            self.smt_query_counter += 1
            return self.composer.load_fresh_claim_placeholder(f"smt-query-{counter}", predicate)
        else:
            print("smt query sat:", encoded_predicate)
            return None

    def encode_predicate(self, predicate: kore.Pattern) -> z3.BoolRef:
        """
        Encode a kore predicate as a boolean term
        """

        if isinstance(predicate, kore.MLPattern):
            if KoreUtils.is_equals(predicate):
                left, right = KoreUtils.destruct_equals(predicate)
                return self.encode_term(left) == self.encode_term(right)

            elif KoreUtils.is_and(predicate):
                left, right = KoreUtils.destruct_and(predicate)
                return z3.And(self.encode_predicate(left), self.encode_predicate(right))

            elif KoreUtils.is_or(predicate):
                left, right = KoreUtils.destruct_or(predicate)
                return z3.Or(self.encode_predicate(left), self.encode_predicate(right))

            elif KoreUtils.is_implies(predicate):
                left, right = KoreUtils.destruct_implies(predicate)
                return z3.Implies(self.encode_predicate(left), self.encode_predicate(right))

            elif KoreUtils.is_not(predicate):
                subterm, = KoreUtils.destruct_not(predicate)
                return z3.Not(self.encode_predicate(subterm))

            elif KoreUtils.is_top(predicate):
                return True

            elif KoreUtils.is_bottom(predicate):
                return False

        assert False, f"unable to encode predicate {predicate}"

    def encode_term(self, term: kore.Pattern) -> z3.AstRef:
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
                subterms = tuple(self.encode_term(argument) for argument in term.arguments)
                return function(*subterms)

        elif isinstance(term, kore.Variable):
            assert isinstance(term.sort, kore.SortInstance)
            sort_id = term.sort.get_sort_id()

            if sort_id == "SortInt":
                return z3.Int(term.name)

            elif sort_id == "SortBool":
                return z3.Bool(term.name)

        assert False, f"unable to encode term {term}"
