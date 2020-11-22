from __future__ import annotations

from typing import List, Tuple, NewType, Optional, Mapping

from .kore import ast as kore
from .kore.visitors import FreePatternVariableVisitor
from .kore.utils import KoreUtils, PatternPath

from .metamath.composer import Proof

from .env import ProofGenerator, ProofEnvironment
from .equality import EqualityProofGenerator


class UnificationResult:
    def __init__(
        self,
        substitution: List[Tuple[kore.Pattern, kore.Pattern]]=[],
        applied_equations: List[Tuple[Equation, PatternPath]]=[]):
        self.substitution = substitution
        self.applied_equations = applied_equations

    def merge(self, other: UnificationResult) -> UnificationResult:
        # check consistency of the substitution
        return UnificationResult(self.substitution + other.substitution, self.applied_equations + other.applied_equations)

    def prepend_path(self, prefix: int) -> UnificationResult:
        return UnificationResult(self.substitution, [ (eqn, [ prefix ] + path) for eqn, path in self.applied_equations ])

    def prepend_equation(self, equation: Equation, path: PatternPath) -> UnificationResult:
        return UnificationResult(self.substitution, [ (equation, path) ] + self.applied_equations)

    """
    Check consistency and check if in the original
    unification problem, the rhs is an instance of lhs;
    if so, return the substitution

    Otherwise return None
    """
    def get_lhs_substitution_as_instance(self) -> Optional[Mapping[kore.Variable, kore.Pattern]]:
        substitution_map = {}

        for lhs, rhs in self.substitution:
            if not isinstance(lhs, kore.Variable):
                return None

            if lhs in substitution_map:
                if substitution_map[lhs] != rhs:
                    return None
            else:
                substitution_map[lhs] = rhs
        
        return substitution_map

    def __str__(self):
        return "sigma = {{ {} }}, T = [ {} ]".format(
            ", ".join([ f"{a} = {b}" for a, b in self.substitution ]),
            ", ".join([ f"({e}, {p})" for e, p in self.applied_equations ])
        )


class Equation:
    def __init__(self, env: ProofEnvironment):
        self.env = env

    def __str__(self):
        return type(self).__name__

    """
    Given a valid pattern |- phi and a path pointing to a subpattern
    apply the equation to the subpattern to get an equivalent patten phi'
    and return phi' and the proof of it
    """
    def prove_validity(self, pattern: kore.Pattern, pattern_proof: Proof, path: PatternPath) -> Tuple[kore.Pattern, Proof]:
        raise NotImplementedError()


r"""
phi /\ phi = phi
"""
class DuplicateConjunction(Equation):
    def prove_validity(self, pattern: kore.Pattern, pattern_proof: Proof, path: PatternPath) -> Tuple[kore.Pattern, Proof]:
        subpattern = KoreUtils.get_subpattern_by_path(pattern, path)

        assert isinstance(subpattern, kore.MLPattern) and subpattern.construct == kore.MLPattern.AND
        assert subpattern.arguments[0] == subpattern.arguments[1]

        encoded_sort = self.env.encode_pattern(subpattern.sorts[0])
        encoded_pattern = self.env.encode_pattern(subpattern.arguments[0])

        equal_gen = EqualityProofGenerator(self.env)
        return equal_gen.prove_validity(
            pattern,
            pattern_proof,
            path,
            subpattern.arguments[0],
            self.env.get_theorem("kore-dup-and").apply(
                x=self.env.get_theorem("x-element-var").as_proof(),
                ph0=encoded_sort,
                ph1=encoded_pattern,
            ),
        )


"""
Unify two patterns modulo certain equations
"""
class UnificationProofGenerator(ProofGenerator):
    """
    Losely following https://github.com/kframework/kore/blob/master/docs/2018-11-12-Unification.md
    """
    def unify_patterns(self, pattern1: kore.Pattern, pattern2: kore.Pattern) -> Optional[UnificationResult]:
        algorithms = [
            self.unify_vars,
            self.unify_applications,
            self.unify_ml_patterns,
            self.unify_string_literals,
            self.unify_left_duplicate_conjunction,
        ]

        for algo in algorithms:
            result = algo(pattern1, pattern2)
            if result is not None:
                return result

        return None

    """
    Check if any one of the patterns is a variable, if so try to unify
    otherwise return failure
    """
    def unify_vars(self, pattern1: kore.Pattern, pattern2: kore.Pattern) -> Optional[UnificationResult]:
        if not isinstance(pattern1, kore.Variable) and \
           not isinstance(pattern2, kore.Variable):
            return None

        if pattern1 == pattern2: return UnificationResult()

        if isinstance(pattern1, kore.Variable):
            if pattern1 in FreePatternVariableVisitor().visit(pattern2):
                return None
        else:
            if pattern2 in FreePatternVariableVisitor().visit(pattern1):
                return None

        return UnificationResult([ (pattern1, pattern2) ])

    """
    Try to unify two applications, expecting symbols and the number
    of arguments to be exactly the same
    """
    def unify_applications(self, pattern1: kore.Pattern, pattern2: kore.Pattern) -> Optional[UnificationResult]:
        if not isinstance(pattern1, kore.Application) or not isinstance(pattern2, kore.Application):
            return None

        if pattern1.symbol != pattern2.symbol or \
           len(pattern1.arguments) != len(pattern2.arguments):
            return None

        # unify subpatterns
        unification = UnificationResult()

        for index, (subpattern1, subpattern2) in enumerate(zip(pattern1.arguments, pattern2.arguments)):
            subunification = self.unify_patterns(subpattern1, subpattern2)
            if subunification is None:
                return None
            unification = unification.merge(subunification.prepend_path(index))
        
        return unification

    """
    Try to unify two ML patterns. Currently
    we are conservatively assuming that the two patterns'
    top level constructs have to be exactly the same
    """
    def unify_ml_patterns(self, pattern1: kore.Pattern, pattern2: kore.Pattern) -> Optional[UnificationResult]:
        if not isinstance(pattern1, kore.MLPattern) or not isinstance(pattern2, kore.MLPattern):
            return None

        if pattern1.construct != pattern2.construct or \
           pattern1.sorts != pattern2.sorts or \
           len(pattern1.arguments) != len(pattern2.arguments):
            return None

        # TODO: this is probably too conservative
        if pattern1.construct == kore.MLPattern.FORALL or \
           pattern1.construct == kore.MLPattern.EXISTS:
            if pattern1.get_binding_variable() != pattern1.get_binding_variable():
                return None

        # unify subpatterns
        unification = UnificationResult()

        for index, (subpattern1, subpattern2) in enumerate(zip(pattern1.arguments, pattern2.arguments)):
            subunification = self.unify_patterns(subpattern1, subpattern2)
            if subunification is None:
                return None
            unification = unification.merge(subunification.prepend_path(index))
        
        return unification

    def unify_string_literals(self, pattern1: kore.Pattern, pattern2: kore.Pattern) -> Optional[UnificationResult]:
        if isinstance(pattern1, kore.StringLiteral) and \
           isinstance(pattern2, kore.StringLiteral) and \
           pattern1 == pattern2:
            return UnificationResult()
        else:
            return None

    r"""
    Assuming pattern1 is of the form phi /\ var
    and if pattern2 is unifiable with phi, then we
    can apply DuplicateConjunction to reduce
    phi /\ phi to phi after substitution
    """
    def unify_left_duplicate_conjunction(self, pattern1: kore.Pattern, pattern2: kore.Pattern) -> Optional[UnificationResult]:
        if isinstance(pattern1, kore.MLPattern) and \
           pattern1.construct == kore.MLPattern.AND and \
           isinstance(pattern1.arguments[1], kore.Variable):
            result1 = self.unify_patterns(pattern1.arguments[0], pattern2)
            result2 = self.unify_patterns(pattern1.arguments[1], pattern2)
            if result1 is not None and result2 is not None:
                return result1.prepend_path(0).merge(result2.prepend_path(1)).prepend_equation(DuplicateConjunction(self.env), [])
        
        return None
