from __future__ import annotations

import copy

from typing import List, Tuple, NewType, Optional, Mapping, Dict

from ml.kore import ast as kore
from ml.kore.visitors import FreePatternVariableVisitor
from ml.kore.utils import KoreUtils, PatternPath

from ml.metamath import ast as mm
from ml.metamath.composer import Proof, TypecodeProver

from .env import ProofGenerator, ProofEnvironment, ProvableClaim
from .equality import EqualityProofGenerator
from .sort import SortProofGenerator
from .quantifier import QuantifierProofGenerator

# AppliedEquation = List[Tuple[Equation, PatternPath]]


class UnificationResult:
    def __init__(
        self,
        substitution: Dict[kore.Variable, kore.Pattern]={},
        applied_equations: List[Tuple[Equation, PatternPath]]=[]):
        self.substitution = substitution
        self.applied_equations = applied_equations

    def merge(self, other: UnificationResult) -> Optional[UnificationResult]:
        # check consistency of the substitution

        new_subst = self.substitution.copy()

        for k, v in other.substitution.items():
            if k in new_subst:
                if v != new_subst[k]:
                    return None
            else:
                new_subst[k] = v

        return UnificationResult(new_subst, self.applied_equations + other.applied_equations)

    def prepend_path(self, prefix: int) -> UnificationResult:
        return UnificationResult(self.substitution, [ (eqn, [ prefix ] + path) for eqn, path in self.applied_equations ])

    def append_equation(self, equation: Equation, path: PatternPath) -> UnificationResult:
        return UnificationResult(self.substitution, self.applied_equations + [ (equation, path) ])

    def __str__(self):
        return "sigma = {{ {} }}, T = [ {} ]".format(
            ", ".join([ f"{a} = {b}" for a, b in self.substitution.items() ]),
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
    def replace_equal_subpattern(self, provable: ProvableClaim, path: PatternPath) -> ProvableClaim:
        raise NotImplementedError()


r"""
phi /\ phi = phi
"""
class DuplicateConjunction(Equation):
    def replace_equal_subpattern(self, provable: ProvableClaim, path: PatternPath) -> ProvableClaim:
        subpattern = KoreUtils.get_subpattern_by_path(provable.claim, path)

        assert isinstance(subpattern, kore.MLPattern) and subpattern.construct == kore.MLPattern.AND
        assert subpattern.arguments[0] == subpattern.arguments[1]

        encoded_sort = self.env.encode_pattern(subpattern.sorts[0])
        encoded_pattern = self.env.encode_pattern(subpattern.arguments[0])

        equal_gen = EqualityProofGenerator(self.env)
        return equal_gen.replace_equal_subpattern(
            provable,
            path,
            subpattern.arguments[0],
            self.env.get_theorem("kore-dup-and").apply(
                x=TypecodeProver.prove_typecode(self.env.composer, "#ElementVariable", mm.Metavariable("x")),
                ph0=encoded_sort,
                ph1=encoded_pattern,
            ),
        )


r"""
If A < B < C
inj{B, C}(inj{A, B}(X)) === inj{A, C}(X)
"""
class InjectionCombine(Equation):
    def replace_equal_subpattern(self, provable: ProvableClaim, path: PatternPath) -> ProvableClaim:
        subpattern = KoreUtils.get_subpattern_by_path(provable.claim, path)
        assert isinstance(subpattern, kore.Application) and \
               subpattern.symbol.definition == self.env.sort_injection_symbol

        sort_b, sort_c = subpattern.symbol.sort_arguments

        subsubpattern = subpattern.arguments[0]
        assert isinstance(subsubpattern, kore.Application) and \
               subsubpattern.symbol.definition == self.env.sort_injection_symbol

        sort_a, sort_b1 = subsubpattern.symbol.sort_arguments
        assert sort_b1 == sort_b, f"ill-sorted injection {subpattern}"

        # sort_a < sort_b < sort_c
        inj_axiom_instance = SortProofGenerator(self.env).get_inj_instance(sort_a, sort_b, sort_c)
        inj_axiom_instance = QuantifierProofGenerator(self.env).prove_forall_elim_single(inj_axiom_instance, subsubpattern.arguments[0])
        
        return EqualityProofGenerator(self.env).replace_equal_subpattern(
            provable, path,
            inj_axiom_instance.claim.pattern.arguments[1], # RHS of the inj axiom
            inj_axiom_instance.proof,
        )

r"""
mapmerge(M1, M2) === mapmerge(M2, M1)
"""
class MapCommutativity(Equation):
    def replace_equal_subpattern(self, provable: ProvableClaim, path: PatternPath) -> ProvableClaim:
        subpattern = KoreUtils.get_subpattern_by_path(provable.claim, path)
        # TODO:: assert here that subpattern is a mapmerge

        # get the two variable (names) in the commutativity axiom
        comm_axiom = self.env.map_commutativity_axiom
        var1, var2 = KoreUtils.strip_forall(comm_axiom.claim).arguments[0].arguments

        subst = { var1 : subpattern.arguments[0] , var2 : subpattern.arguments[1] }
        axiom_instance = QuantifierProofGenerator(self.env).prove_forall_elim(self.env.map_commutativity_axiom, subst)

        return EqualityProofGenerator(self.env).replace_equal_subpattern_with_equation(
            provable, 
            path, 
            axiom_instance,
        )
"""
Unify two patterns modulo certain equations
NOTE: this generator currently only supports
unifying a pattern with a CONCRETE pattern
"""
class UnificationProofGenerator(ProofGenerator):
    """
    Losely following https://github.com/kframework/kore/blob/master/docs/2018-11-12-Unification.md
    """
    def unify_patterns(self, pattern1: kore.Pattern, pattern2: kore.Pattern) -> Optional[UnificationResult]:

        # print("\n")
        # print("unify_patterns begins")
        # print("pattern1", pattern1)
        # print("pattern2", pattern2)
        # print("\n")

        algorithms = [
            self.unify_vars,
            self.unify_applications,
            self.unify_ml_patterns,
            self.unify_string_literals,
            self.unify_left_duplicate_conjunction,
            self.unify_right_splittable_inj,
            self.unify_concrete_map_patterns,
        ]
        for algo in algorithms:
            # print("trying algo", algo, "\n")
            result = algo(pattern1, pattern2)
            # print("tried" + str(algo) + "result is" + str(result), "\n")
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

            return UnificationResult({ pattern1: pattern2 })
        else:
            if pattern2 in FreePatternVariableVisitor().visit(pattern1):
                return None
            
            return UnificationResult({ pattern2: pattern1 })

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
            if unification is None:
                return None
        
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
            if unification is None:
                return None
        
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
                return result1.prepend_path(0).merge(result2.prepend_path(1)).append_equation(DuplicateConjunction(self.env), [])
        
        return None

    r"""
    If left pattern is inj{A, C}(X) and
    the right pattern is inj{B, C}(X)
    such that B < A, we can split the
    right pattern to inj{A, C}(inj{B, A}(X))
    and keep unifying
    """
    def unify_right_splittable_inj(self, pattern1: kore.Pattern, pattern2: kore.Pattern) -> Optional[UnificationResult]:
        if isinstance(pattern1, kore.Application) and \
           isinstance(pattern2, kore.Application) and \
           pattern1.symbol.definition == self.env.sort_injection_symbol and \
           pattern2.symbol.definition == self.env.sort_injection_symbol:

            sort_a = pattern1.symbol.sort_arguments[0]
            sort_b = pattern2.symbol.sort_arguments[0]
            sort_c1 = pattern1.symbol.sort_arguments[1]
            sort_c2 = pattern2.symbol.sort_arguments[1]

            if sort_c1 == sort_c2 and sort_a != sort_b and \
               self.env.subsort_relation.get_subsort_chain(sort_b, sort_a) is not None:

                split_right_inj = kore.Application(
                    kore.SymbolInstance(
                        self.env.sort_injection_symbol,
                        [ sort_b, sort_a ],
                    ),
                    [ pattern2.arguments[0] ]
                )
                split_right_inj.resolve(self.env.module)

                result = self.unify_patterns(pattern1.arguments[0], split_right_inj)
                if result is None: return None

                return result.prepend_path(0).append_equation(InjectionCombine(self.env), [])

        return None

    def swap_map_pattern(self, pattern: kore.Pattern) -> Tuple[kore.Pattern, List[Tuple[Equation, PatternPath]]]:
        # TODO::
        # check that pattern has the form merge(pattern1, pattern2)

        if isinstance(pattern, kore.Application) and pattern.symbol.definition.symbol == "Lbl'UndsPipe'-'-GT-Unds'":
            # print("----")
            # print("swap_map_pattern:", pattern)
            swapped_pattern = copy.deepcopy(pattern)
            swapped_pattern.arguments[0] = pattern.arguments[1]
            swapped_pattern.arguments[1] = pattern.arguments[0]
            # print("swapped:", swapped_pattern)
            return (swapped_pattern, [(MapCommutativity(self.env), [])])


    
    def sort_map_pattern(self, pattern: kore.Pattern) -> Tuple[kore.Pattern, List[Tuple[Equation, PatternPath]]]:

        self.swap_map_pattern(pattern)

        # We sort @pattern using merge sort.

        # if pattern.symbol.definition.symbol != "Lbl'Unds'Map'Unds'":

        # return merge( pattern1 pattern2 ) 

        # applied_eqs1 applied_eqs2

        # applied_eqs = 

        # merge(kv, merge(kv', merge(...)))

        # merge(merge(p1,p2),p3) =assoc=> merge(p1, merge(p2,p3)) =*=> merge(k_min, merge(p2',p3'))

    r"""
    Unify two concrete map patterns. 
    """
    def unify_concrete_map_patterns(self, pattern1: kore.Pattern, pattern2: kore.Pattern) -> Optional[UnificationResult]:
        print("unify_concrete_map_patterns:", pattern1, pattern2, "\n")
        if isinstance(pattern1, kore.Application) and \
           isinstance(pattern2, kore.Application) and \
           pattern1.symbol.definition.symbol == "Lbl'Unds'Map'Unds'" and \
           pattern2.symbol.definition.symbol == "Lbl'Unds'Map'Unds'":

           self.swap_map_pattern(pattern1)
           return None

           # 2. sort pattern1 and pattern2
           # pattern1_sorted, applied_eqs1 = self.sort_map_pattern(pattern1)
           # pattern2_sorted, applied_eqs2 = self.sort_map_pattern(pattern2)
           # applied_eqs2_rev = self.reverse_equations(applied_eqs2)

           # applied_eqs = applied_eqs1 + applied_eqs2

           # return UnificationResult([], applied_eqs)
           return None

        print("unify_concrete_map_patterns, else branch")
        return None


        