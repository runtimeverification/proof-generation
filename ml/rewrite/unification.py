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
from .templates import KoreTemplates

# AppliedEquation = List[Tuple[Equation, PatternPath]]


class UnificationResult:
    def __init__(
        self,
        substitution: Dict[kore.Variable, kore.Pattern] = {},
        applied_equations: List[Tuple[Equation, PatternPath]] = [],
    ):
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

        return UnificationResult(
            new_subst, self.applied_equations + other.applied_equations
        )

    @staticmethod
    def prepend_path_to_applied_eqs(
        applied_eqs: List[Tuple[Equation, PatternPath]], prefix: int
    ) -> List[Tuple[Equation, PatternPath]]:
        return [(eqn, [prefix] + path) for eqn, path in applied_eqs]

    def prepend_path(self, prefix: int) -> UnificationResult:
        return UnificationResult(
            self.substitution,
            [(eqn, [prefix] + path) for eqn, path in self.applied_equations],
        )

    def append_equation(
        self, equation: Equation, path: PatternPath
    ) -> UnificationResult:
        return UnificationResult(
            self.substitution, self.applied_equations + [(equation, path)]
        )

    def __str__(self):
        return "sigma = {{ {} }}, T = [ {} ]".format(
            ", ".join([f"{a} = {b}" for a, b in self.substitution.items()]),
            ", ".join([f"({e}, {p})" for e, p in self.applied_equations]),
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

    def replace_equal_subpattern(
        self, provable: ProvableClaim, path: PatternPath
    ) -> ProvableClaim:
        raise NotImplementedError()


r"""
phi /\ phi = phi
"""


class DuplicateConjunction(Equation):
    def replace_equal_subpattern(
        self, provable: ProvableClaim, path: PatternPath
    ) -> ProvableClaim:
        subpattern = KoreUtils.get_subpattern_by_path(provable.claim, path)

        assert (
            isinstance(subpattern, kore.MLPattern)
            and subpattern.construct == kore.MLPattern.AND
        )
        assert subpattern.arguments[0] == subpattern.arguments[1]

        encoded_sort = self.env.encode_pattern(subpattern.sorts[0])
        encoded_pattern = self.env.encode_pattern(subpattern.arguments[0])

        equal_gen = EqualityProofGenerator(self.env)
        return equal_gen.replace_equal_subpattern(
            provable,
            path,
            subpattern.arguments[0],
            self.env.get_theorem("kore-dup-and").apply(
                x=TypecodeProver.prove_typecode(
                    self.env.composer, "#ElementVariable", mm.Metavariable("x")
                ),
                ph0=encoded_sort,
                ph1=encoded_pattern,
            ),
        )


r"""
If A < B < C
inj{B, C}(inj{A, B}(X)) === inj{A, C}(X)
"""


class InjectionCombine(Equation):
    def replace_equal_subpattern(
        self, provable: ProvableClaim, path: PatternPath
    ) -> ProvableClaim:
        subpattern = KoreUtils.get_subpattern_by_path(provable.claim, path)
        assert (
            isinstance(subpattern, kore.Application)
            and subpattern.symbol.definition == self.env.sort_injection_symbol
        )

        sort_b, sort_c = subpattern.symbol.sort_arguments

        subsubpattern = subpattern.arguments[0]
        assert (
            isinstance(subsubpattern, kore.Application)
            and subsubpattern.symbol.definition == self.env.sort_injection_symbol
        )

        sort_a, sort_b1 = subsubpattern.symbol.sort_arguments
        assert sort_b1 == sort_b, f"ill-sorted injection {subpattern}"

        # sort_a < sort_b < sort_c
        inj_axiom_instance = SortProofGenerator(self.env).get_inj_instance(
            sort_a, sort_b, sort_c
        )
        inj_axiom_instance = QuantifierProofGenerator(
            self.env
        ).prove_forall_elim_single(inj_axiom_instance, subsubpattern.arguments[0])

        assert isinstance(inj_axiom_instance.claim.pattern, kore.MLPattern)

        return EqualityProofGenerator(self.env).replace_equal_subpattern(
            provable,
            path,
            inj_axiom_instance.claim.pattern.arguments[1],  # RHS of the inj axiom
            inj_axiom_instance.proof,
        )


class MapCommutativity(Equation):
    r"""
    mapmerge(M1, M2) === mapmerge(M2, M1)
    """

    # def __init__(self, *args, **kwargs):
    #     super().__init__(*args, **kwargs)
    #     # If flag is true, apply the commutativity equation from left to right
    #     # If flag is false, apply the equation from right to left
    #     self.flag_left_to_right: bool = True

    def replace_equal_subpattern(
        self, provable: ProvableClaim, path: PatternPath
    ) -> ProvableClaim:
        subpattern = KoreUtils.get_subpattern_by_path(provable.claim, path)
        assert isinstance(subpattern, kore.Application)
        # TODO:: assert here that subpattern is a mapmerge

        # get the two variable (names) in the commutativity axiom
        assert self.env.map_commutativity_axiom is not None
        comm_axiom = self.env.map_commutativity_axiom

        comm_axiom_body = KoreUtils.strip_forall(comm_axiom.claim.pattern)
        assert isinstance(comm_axiom_body, kore.MLPattern)
        assert isinstance(comm_axiom_body.arguments[0], kore.Application)

        var1, var2 = comm_axiom_body.arguments[0].arguments
        assert isinstance(var1, kore.Variable) and isinstance(var2, kore.Variable)

        subst = {var1: subpattern.arguments[0], var2: subpattern.arguments[1]}
        axiom_instance = QuantifierProofGenerator(self.env).prove_forall_elim(
            comm_axiom, subst
        )

        return EqualityProofGenerator(self.env).replace_equal_subpattern_with_equation(
            provable,
            path,
            axiom_instance,
        )


class MapAssociativity(Equation):
    r"""
    mapmerge(mapmerge(M1, M2), M3) <==> mapmerge(M1, mapmerge(M2, M3))
    We use a boolean rotate_right to control the direction.
    """

    def __init__(self, rotate_right, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.rotate_right: bool = rotate_right

    def replace_equal_subpattern(
        self, provable: ProvableClaim, path: PatternPath
    ) -> ProvableClaim:
        # TODO::
        subpattern = KoreUtils.get_subpattern_by_path(provable.claim, path)
        assert isinstance(subpattern, kore.Application)
        # TODO:: assert here that subpattern is a mapmerge

        # get the two variable (names) in the commutativity axiom
        assert self.env.map_commutativity_axiom is not None
        assoc_axiom = self.env.map_commutativity_axiom

        assoc_axiom_body = KoreUtils.strip_forall(assoc_axiom.claim.pattern)
        assert isinstance(assoc_axiom_body, kore.Application)
        assert isinstance(assoc_axiom_body.arguments[0], kore.Application)

        var1, var2 = assoc_axiom_body.arguments[0].arguments
        assert isinstance(var1, kore.Variable) and isinstance(var2, kore.Variable)

        subst = {var1: subpattern.arguments[0], var2: subpattern.arguments[1]}
        axiom_instance = QuantifierProofGenerator(self.env).prove_forall_elim(
            assoc_axiom, subst
        )

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

    def unify_patterns(
        self, pattern1: kore.Pattern, pattern2: kore.Pattern
    ) -> Optional[UnificationResult]:
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
            result = algo(pattern1, pattern2)
            if result is not None:
                return result

        return None

    def unify_vars(
        self, pattern1: kore.Pattern, pattern2: kore.Pattern
    ) -> Optional[UnificationResult]:
        """
        Check if any one of the patterns is a variable, if so try to unify
        otherwise return failure
        """

        if not isinstance(pattern1, kore.Variable) and not isinstance(
            pattern2, kore.Variable
        ):
            return None

        if pattern1 == pattern2:
            return UnificationResult()

        if isinstance(pattern1, kore.Variable):
            if pattern1 in FreePatternVariableVisitor().visit(pattern2):
                return None

            return UnificationResult({pattern1: pattern2})
        else:
            assert isinstance(pattern2, kore.Variable)

            if pattern2 in FreePatternVariableVisitor().visit(pattern1):
                return None

            return UnificationResult({pattern2: pattern1})

    def unify_applications(
        self, pattern1: kore.Pattern, pattern2: kore.Pattern
    ) -> Optional[UnificationResult]:
        """
        Try to unify two applications, expecting symbols and the number
        of arguments to be exactly the same
        """
        if not isinstance(pattern1, kore.Application) or not isinstance(
            pattern2, kore.Application
        ):
            return None

        if pattern1.symbol != pattern2.symbol or len(pattern1.arguments) != len(
            pattern2.arguments
        ):
            return None

        # unify subpatterns
        unification: UnificationResult = UnificationResult()

        for index, (subpattern1, subpattern2) in enumerate(
            zip(pattern1.arguments, pattern2.arguments)
        ):
            subunification = self.unify_patterns(subpattern1, subpattern2)
            if subunification is None:
                return None

            merged = unification.merge(subunification.prepend_path(index))
            if merged is None:
                return None

            unification = merged

        return unification

    def unify_ml_patterns(
        self, pattern1: kore.Pattern, pattern2: kore.Pattern
    ) -> Optional[UnificationResult]:
        """
        Try to unify two ML patterns. Currently
        we are conservatively assuming that the two patterns'
        top level constructs have to be exactly the same
        """
        if not isinstance(pattern1, kore.MLPattern) or not isinstance(
            pattern2, kore.MLPattern
        ):
            return None

        if (
            pattern1.construct != pattern2.construct
            or pattern1.sorts != pattern2.sorts
            or len(pattern1.arguments) != len(pattern2.arguments)
        ):
            return None

        # TODO: this is probably too conservative
        if (
            pattern1.construct == kore.MLPattern.FORALL
            or pattern1.construct == kore.MLPattern.EXISTS
        ):
            if pattern1.get_binding_variable() != pattern1.get_binding_variable():
                return None

        # unify subpatterns
        unification = UnificationResult()

        for index, (subpattern1, subpattern2) in enumerate(
            zip(pattern1.arguments, pattern2.arguments)
        ):
            subunification = self.unify_patterns(subpattern1, subpattern2)
            if subunification is None:
                return None

            merged = unification.merge(subunification.prepend_path(index))
            if merged is None:
                return None

            unification = merged

        return unification

    def unify_string_literals(
        self, pattern1: kore.Pattern, pattern2: kore.Pattern
    ) -> Optional[UnificationResult]:
        if (
            isinstance(pattern1, kore.StringLiteral)
            and isinstance(pattern2, kore.StringLiteral)
            and pattern1 == pattern2
        ):
            return UnificationResult()
        else:
            return None

    def unify_left_duplicate_conjunction(
        self, pattern1: kore.Pattern, pattern2: kore.Pattern
    ) -> Optional[UnificationResult]:
        r"""
        Assuming pattern1 is of the form phi /\ var
        and if pattern2 is unifiable with phi, then we
        can apply DuplicateConjunction to reduce
        phi /\ phi to phi after substitution
        """
        if (
            isinstance(pattern1, kore.MLPattern)
            and pattern1.construct == kore.MLPattern.AND
            and isinstance(pattern1.arguments[1], kore.Variable)
        ):
            result1 = self.unify_patterns(pattern1.arguments[0], pattern2)
            result2 = self.unify_patterns(pattern1.arguments[1], pattern2)
            if result1 is not None and result2 is not None:
                merged = result1.prepend_path(0).merge(result2.prepend_path(1))
                if merged is None:
                    return None

                return merged.append_equation(DuplicateConjunction(self.env), [])

        return None

    def unify_right_splittable_inj(
        self, pattern1: kore.Pattern, pattern2: kore.Pattern
    ) -> Optional[UnificationResult]:
        r"""
        If left pattern is inj{A, C}(X) and
        the right pattern is inj{B, C}(X)
        such that B < A, we can split the
        right pattern to inj{A, C}(inj{B, A}(X))
        and keep unifying
        """

        if (
            isinstance(pattern1, kore.Application)
            and isinstance(pattern2, kore.Application)
            and pattern1.symbol.definition == self.env.sort_injection_symbol
            and pattern2.symbol.definition == self.env.sort_injection_symbol
        ):

            sort_a = pattern1.symbol.sort_arguments[0]
            sort_b = pattern2.symbol.sort_arguments[0]
            sort_c1 = pattern1.symbol.sort_arguments[1]
            sort_c2 = pattern2.symbol.sort_arguments[1]

            if (
                sort_c1 == sort_c2
                and sort_a != sort_b
                and isinstance(sort_a, kore.SortInstance)
                and isinstance(sort_b, kore.SortInstance)
                and self.env.subsort_relation.get_subsort_chain(sort_b, sort_a)
                is not None
            ):

                split_right_inj = kore.Application(
                    kore.SymbolInstance(
                        self.env.sort_injection_symbol,
                        [sort_b, sort_a],
                    ),
                    [pattern2.arguments[0]],
                )
                split_right_inj.resolve(self.env.module)

                result = self.unify_patterns(pattern1.arguments[0], split_right_inj)
                if result is None:
                    return None

                return result.prepend_path(0).append_equation(
                    InjectionCombine(self.env), []
                )

        return None

    def swap_map_pattern(
        self, pattern: kore.Pattern
    ) -> Tuple[kore.Pattern, List[Tuple[Equation, PatternPath]]]:
        assert KoreTemplates.is_map_merge_pattern(pattern)
        assert isinstance(pattern, kore.Application)
        swapped_pattern = KoreUtils.copy_pattern(pattern)
        swapped_pattern.arguments[0] = pattern.arguments[1]
        swapped_pattern.arguments[1] = pattern.arguments[0]
        return (swapped_pattern, [(MapCommutativity(self.env), [])])

    def rotate_left_map_pattern(
        self, pattern: kore.Pattern
    ) -> Tuple[kore.Pattern, List[Tuple[Equation, PatternPath]]]:
        r"""
        merge(a, merge(b,c)) => merge(merge(a,b), c)
        """

        assert KoreTemplates.is_map_merge_pattern(pattern)
        assert isinstance(pattern, kore.Application)

        assert KoreTemplates.is_map_merge_pattern(pattern.arguments[1])
        assert isinstance(pattern.arguments[0], kore.Application)
        assert isinstance(pattern.arguments[1], kore.Application)

        rotated_pattern_left = kore.Application(
            pattern.symbol, [pattern.arguments[0], pattern.arguments[1].arguments[0]]
        )
        rotated_pattern = kore.Application(
            pattern.symbol, [rotated_pattern_left, pattern.arguments[1].arguments[1]]
        )
        rotated_pattern.resolve(self.env.module)
        return (rotated_pattern, [(MapAssociativity(self.env, False), [])])

    def rotate_right_map_pattern(
        self, pattern: kore.Pattern
    ) -> Tuple[kore.Pattern, List[Tuple[Equation, PatternPath]]]:
        r"""
        merge(merge(a,b), c) => merge(a, merge(b,c))
        """
        assert KoreTemplates.is_map_merge_pattern(pattern)
        assert isinstance(pattern, kore.Application)

        assert KoreTemplates.is_map_merge_pattern(pattern.arguments[0])
        assert isinstance(pattern.arguments[0], kore.Application)

        rotated_pattern_right = kore.Application(
            pattern.symbol, [pattern.arguments[0].arguments[1], pattern.arguments[1]]
        )
        rotated_pattern = kore.Application(
            pattern.symbol, [pattern.arguments[0].arguments[0], rotated_pattern_right]
        )
        rotated_pattern.resolve(self.env.module)
        return (rotated_pattern, [(MapAssociativity(self.env, True), [])])

    def bubble_smallest_map_pattern(
        self, pattern: kore.Pattern
    ) -> Tuple[kore.Pattern, List[Tuple[Equation, PatternPath]]]:
        assert KoreTemplates.is_map_pattern(pattern)

        if KoreTemplates.is_map_mapsto_pattern(pattern):
            return (pattern, [])

        _, path = KoreTemplates.get_path_to_smallest_key_in_map_pattern(pattern)

        # from path we can create applied_eqs
        applied_eqs_comm: List[Tuple[Equation, PatternPath]] = [
            (MapCommutativity(self.env), [0] * depth)
            for depth, direct in enumerate(path)
            if direct == 1
        ]

        leftmost_depth = 0
        pp = pattern
        while KoreTemplates.is_map_merge_pattern(
            pp
        ) and KoreTemplates.is_map_merge_pattern(KoreTemplates.get_map_merge_left(pp)):
            pp = KoreTemplates.get_map_merge_left(pp)
            leftmost_depth = leftmost_depth + 1

        applied_eqs_assoc: List[Tuple[Equation, PatternPath]] = [
            (MapAssociativity(self.env, True), [])
        ] * leftmost_depth

        # create the return pattern

        ret_pattern = KoreUtils.copy_pattern(pattern)
        ret_pattern_pointer = ret_pattern
        comm_depths = [len(lst) for _, lst in applied_eqs_comm]
        for d in range(len(applied_eqs_comm)):
            if d in comm_depths:
                KoreTemplates.deep_swap_map_merge_pattern(ret_pattern_pointer)
                ret_pattern_pointer = KoreTemplates.get_map_merge_left(
                    ret_pattern_pointer
                )

        # Now, the leftmost leaf node of ret_pattern has the smallest key.
        while KoreTemplates.is_map_merge_pattern(
            ret_pattern
        ) and KoreTemplates.is_map_merge_pattern(
            KoreTemplates.get_map_merge_left(ret_pattern)
        ):
            KoreTemplates.deep_rotate_right_map_merge_pattern(ret_pattern)

        return ret_pattern, applied_eqs_comm + applied_eqs_assoc

    def sort_map_pattern(
        self, pattern: kore.Pattern
    ) -> Tuple[kore.Pattern, List[Tuple[Equation, PatternPath]]]:
        assert KoreTemplates.is_map_pattern(pattern)
        assert isinstance(pattern, kore.Application)

        if KoreTemplates.is_map_mapsto_pattern(pattern):
            return (pattern, [])

        if KoreTemplates.is_map_merge_pattern(pattern):
            pattern_bubbled, applied_eqs_bubbled = self.bubble_smallest_map_pattern(
                pattern
            )
            assert isinstance(pattern_bubbled, kore.Application)

            pattern_bubbled_right = KoreTemplates.get_map_merge_right(pattern_bubbled)
            pattern_bubbled_right_sorted, applied_eqs_right = self.sort_map_pattern(
                pattern_bubbled_right
            )

            sorted_pattern = KoreUtils.copy_pattern(pattern)
            sorted_pattern.arguments[0] = pattern_bubbled.arguments[0]
            sorted_pattern.arguments[1] = pattern_bubbled_right_sorted
            applied_eqs = (
                applied_eqs_bubbled
                + UnificationResult.prepend_path_to_applied_eqs(applied_eqs_right, 1)
            )
            return (sorted_pattern, applied_eqs)
        raise NotImplementedError(
            "Unexpected. A map pattern is either a mapsto or a merge."
        )

    def unify_concrete_map_patterns(
        self, pattern1: kore.Pattern, pattern2: kore.Pattern
    ) -> Optional[UnificationResult]:
        r"""
        Unify two concrete map patterns.
        """

        if not KoreTemplates.is_map_pattern(
            pattern1
        ) or not KoreTemplates.is_map_merge_pattern(pattern2):
            return None

        if KoreTemplates.is_map_mapsto_pattern(pattern1):
            if not KoreTemplates.is_map_mapsto_pattern(pattern2):
                return None
            if pattern1 == pattern2:
                return UnificationResult()
            else:
                return None

        assert KoreTemplates.is_map_merge_pattern(pattern1)
        assert KoreTemplates.is_map_merge_pattern(pattern2)

        pattern1_sorted, applied_eqs1 = self.sort_map_pattern(pattern1)
        pattern2_sorted, applied_eqs2 = self.sort_map_pattern(pattern2)

        if pattern1_sorted != pattern2_sorted:
            return None

        # reverse applied_eq2
        applied_eqs2_reversed: List[Tuple[Equation, PatternPath]] = []
        for eq, path in reversed(applied_eqs2):
            if isinstance(eq, MapAssociativity):
                eq.rotate_right = not eq.rotate_right
            applied_eqs2_reversed = applied_eqs2_reversed + [(eq, path)]

        return UnificationResult({}, applied_eqs1 + applied_eqs2_reversed)
