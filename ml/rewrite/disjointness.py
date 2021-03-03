
from typing import Optional

from ml.kore import ast as kore
from ml.kore.utils import KoreUtils
from ml.kore.visitors import FreePatternVariableVisitor

from ml.metamath import ast as mm
from ml.metamath.composer import Proof

from .env import ProofEnvironment, ProofGenerator, ProvableClaim


r"""
The disjointness proof generator generates proof for
patterns of the form

phi /\ not (exists x1, ..., xn. psi(x1, ..., xn))

where phi is expected to be a functional pattern

The primary usage of it is to prove conditions for
[owise] rules, which assumes that a pattern
does NOT unify with a pattern.
"""
class DisjointnessProofGenerator(ProofGenerator):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.arg_disjointness_counter = 0
        self.diff_constructor_disjointness_counter = 0
        self.var_disjointness_assumption = 0

    def existentially_quantify_free_variables(self, pattern: kore.Pattern) -> kore.Pattern:
        free_vars = FreePatternVariableVisitor().visit(pattern)
        free_vars = list(free_vars)
        free_vars.sort(key=lambda v: v.name, reverse=True)

        module = pattern.get_module()
        pattern_sort = KoreUtils.infer_sort(pattern)

        for var in free_vars:
            pattern = kore.MLPattern(kore.MLPattern.EXISTS, [ pattern_sort ], [ var, pattern ])

        pattern.resolve(module)

        return pattern

    r"""
    Return the metamath term
    not (<left> /\ exists x1, ..., xn. <right>)
    all free variables should be exitentially quantified
    """
    def get_disjointness_pattern(self, left: kore.Pattern, right: kore.Pattern) -> mm.Term:
        left = self.existentially_quantify_free_variables(left)
        right = self.existentially_quantify_free_variables(right)

        left_term = self.env.encode_pattern(left)
        right_term = self.env.encode_pattern(right)

        return mm.Application("\\not", [
            mm.Application("\\and", [
                left_term,
                right_term
            ])
        ])

    """
    Same as above but wraps it in a metamath statement
    """
    def get_disjointness_statement(self, left: kore.Pattern, right: kore.Pattern, label: str) -> mm.StructuredStatement:
        disjointness = self.get_disjointness_pattern(left, right)
        return mm.StructuredStatement(
            mm.Statement.PROVABLE,
            [ mm.Application("|-"), disjointness ],
            label=label,
        )

    """
    Given an integer i, left and right (applicatoin) patterns f(...), g(...)
    and a proof that the ith argument is disjoint, return a proof that
    f(...) and exists x1, ..., xn. g(...) are disjoint
    """
    def prove_argument_disjointness(self, left: kore.Application, right: kore.Application, i: int, argument_disjointness: Proof) -> ProvableClaim:
        assert left.symbol == right.symbol

        # TODO: actually prove this

        label = f"arg-disjointness-assumption-{self.arg_disjointness_counter}"
        disjointness_stmt = self.get_disjointness_statement(left, right, label)

        assumption = mm.StructuredStatement(
            mm.Statement.ESSENTITAL,
            argument_disjointness.statement.terms,
            label=f"{label}.0",
        )

        self.arg_disjointness_counter += 1

        full_statement = mm.Block([ assumption, disjointness_stmt ])

        self.env.load_metamath_statement(full_statement)
        theorem = self.env.get_theorem(label)

        proof = theorem.apply(argument_disjointness)

        return proof

    r"""
    Prove that the given patterns are disjoint, that is
    not (<left> /\ exists x. <right>)

    Currently only <right> is allowed to have free variables
    which are existentially quantified
    """
    def prove_disjointness(self, left: kore.Pattern, right: kore.Pattern) -> Proof:
        assert KoreUtils.is_concrete(left), \
               f"currently only supports concrete left pattern, but {left} is given"

        right = KoreUtils.strip_exists(right)

        assert isinstance(left, kore.Application), \
               f"left pattern {left} should be an application"
        assert isinstance(right, kore.Application) or isinstance(right, kore.Variable), \
               f"right pattern {right} should be an application or a variable"

        left_symbol = left.symbol

        if isinstance(right, kore.Application):
            right_symbol = right.symbol
        else:
            right_symbol = None

        # if both symbols are injections
        # it's enough to prove that the inner patterns are disjoint
        if left_symbol.definition == self.env.sort_injection_symbol and \
           right_symbol.definition == self.env.sort_injection_symbol:
            assert len(left.arguments) == 1 and len(right.arguments) == 1
            subproof = self.prove_disjointness(left.arguments[0], right.arguments[0])
            
            left_input_sort, left_output_sort = left_symbol.sort_arguments
            right_input_sort, right_output_sort = right_symbol.sort_arguments

            proof = self.env.get_theorem("eq-lemma-for-disjointness").apply(
                self.env.get_theorem("kore-inj-id").apply(
                    ph0=self.env.encode_pattern(left_input_sort),
                    ph1=self.env.encode_pattern(left_output_sort),
                    ph2=self.env.encode_pattern(self.existentially_quantify_free_variables(left.arguments[0])),
                ),
                self.env.get_theorem("kore-inj-id").apply(
                    ph0=self.env.encode_pattern(right_input_sort),
                    ph1=self.env.encode_pattern(right_output_sort),
                    ph2=self.env.encode_pattern(self.existentially_quantify_free_variables(right.arguments[0])),
                ),
                subproof,
            )

            return proof

        if left_symbol == right_symbol:
            # same symbol, try to find a argument pair that is disjoint
            # then use no confusion to show that the full patterns are disjoint

            assert len(left.arguments) == len(right.arguments), \
                   f"same head but different numbers of arguments: {left} vs {right}"

            for i, (left_arg, right_arg) in enumerate(zip(left.arguments, right.arguments)):
                try:
                    subproof = self.prove_disjointness(left_arg, right_arg)
                except:
                    continue
                else:
                    return self.prove_argument_disjointness(left, right, i, subproof)

            assert False, f"failed to show disjointness of {left} and {right}"

        elif right_symbol is not None:
            # different symbols, use no confusion axiom for different constructors
            # TODO: for now we just assume that it's true...
            disjointness_stmt = self.get_disjointness_statement(
                left, right,
                f"diff-constructor-disjointness-assumption-{self.diff_constructor_disjointness_counter}",
            )
            self.diff_constructor_disjointness_counter += 1

            theorem = self.env.load_metamath_statement(disjointness_stmt)
            return theorem.as_proof()

        else:
            assert isinstance(right, kore.Variable)
            # right is a variable use no junk of the sort
            # to decompose it to multiple queries

            # TODO: assumes it for now as well
            disjointness_stmt = self.get_disjointness_statement(
                left, right,
                f"var-disjointness-assumption-{self.var_disjointness_assumption}",
            )
            self.var_disjointness_assumption += 1

            theorem = self.env.load_metamath_statement(disjointness_stmt)
            return theorem.as_proof()
