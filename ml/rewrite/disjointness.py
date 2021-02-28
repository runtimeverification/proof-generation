
from typing import Optional

from ml.kore import ast as kore
from ml.kore.utils import KoreUtils
from ml.kore.visitors import FreePatternVariableVisitor

from ml.metamath import ast as mm

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
    Return the kore pattern
    not (<left> /\ exists x1, ..., xn. <right>)
    all free variables should be exitentially quantified
    """
    def get_disjointness_pattern(self, left: kore.Pattern, right: kore.Pattern) -> kore.Pattern:
        left = self.existentially_quantify_free_variables(left)
        right = self.existentially_quantify_free_variables(right)

        sort = KoreUtils.infer_sort(left)

        disjointness = kore.MLPattern(kore.MLPattern.NOT, [ sort ], [
            kore.MLPattern(kore.MLPattern.AND, [ sort ], [ left, right ])
        ])

        disjointness.resolve(left.get_module())

        return disjointness

    """
    Same as above but wraps it in a kore claim
    """
    def get_disjointness_claim(self, left: kore.Pattern, right: kore.Pattern) -> kore.Pattern:
        disjointness = self.get_disjointness_pattern(left, right)
        disjointness_claim = kore.Claim([], disjointness, [])
        disjointness_claim.resolve(left.get_module())
        return disjointness_claim

    """
    Given an integer i, left and right (applicatoin) patterns f(...), g(...)
    and a proof that the ith argument is disjoint, return a proof that
    f(...) and exists x1, ..., xn. g(...) are disjoint
    """
    def prove_argument_disjointness(self, left: kore.Application, right: kore.Application, i: int, argument_disjointness: ProvableClaim) -> ProvableClaim:
        assert left.symbol == right.symbol

        # TODO: actually prove this from the no confusion axiom for same constructors
        assumption = argument_disjointness.proof.statement

        disjointness_claim = self.get_disjointness_claim(left, right)

        label = f"arg-disjointness-assumption-{self.arg_disjointness_counter}"

        assumption = mm.StructuredStatement(
            mm.Statement.ESSENTITAL,
            assumption.terms,
            label=f"{label}.0",
        )

        disjointness_claim_mm = mm.StructuredStatement(
            mm.Statement.PROVABLE,
            [ mm.Application("|-"), self.env.encode_pattern(disjointness_claim) ],
            label=label,
        )

        self.arg_disjointness_counter += 1

        full_statement = mm.Block([ assumption, disjointness_claim_mm ])

        self.env.load_metamath_statement(full_statement)
        theorem = self.env.get_theorem(label)

        proof = theorem.apply(argument_disjointness.proof)

        return ProvableClaim(disjointness_claim, proof)

    r"""
    Prove that the given patterns are disjoint, that is
    not (<left> /\ exists x. <right>)

    Currently only <right> is allowed to have free variables
    which are existentially quantified
    """
    def prove_disjointness(self, left: kore.Pattern, right: kore.Pattern) -> Optional[ProvableClaim]:
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

        if left_symbol == right_symbol:
            # same symbol, try to find a argument pair that is disjoint
            # then use no confusion to show that the full patterns are disjoint

            assert len(left.arguments) == len(right.arguments), \
                   f"same head but different numbers of arguments: {left} vs {right}"

            for i, (left_arg, right_arg) in enumerate(zip(left.arguments, right.arguments)):
                subproof = self.prove_disjointness(left_arg, right_arg)
                if subproof is not None:
                    return self.prove_argument_disjointness(left, right, i, subproof)

        elif right_symbol is not None:
            # different symbols, use no confusion axiom for different constructors
            # TODO: for now we just assume that it's true...
            disjointness_claim = self.get_disjointness_claim(left, right)
            disjointness_claim_theorem = self.env.load_axiom(
                disjointness_claim,
                f"diff-constructor-disjointness-assumption-{self.diff_constructor_disjointness_counter}",
                comment=False, provable=True,
            )

            self.diff_constructor_disjointness_counter += 1

            return ProvableClaim(disjointness_claim, disjointness_claim_theorem.as_proof())

        else:
            assert isinstance(right, kore.Variable)
            # right is a variable use no junk of the sort
            # to decompose it to multiple queries

            # TODO: assumes it for now as well
            disjointness_claim = self.get_disjointness_claim(left, right)
            disjointness_claim_theorem = self.env.load_axiom(
                disjointness_claim,
                f"var-disjointness-assumption-{self.var_disjointness_assumption}",
                comment=False, provable=True,
            )

            self.var_disjointness_assumption += 1

            return ProvableClaim(disjointness_claim, disjointness_claim_theorem.as_proof())
