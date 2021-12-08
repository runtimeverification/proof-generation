from __future__ import annotations

import copy

from typing import List, Tuple, NewType, Optional, Mapping, Dict, Union, Iterable
from dataclasses import dataclass, field
from abc import ABC, abstractmethod

from ml.kore import ast as kore
from ml.kore.visitors import FreePatternVariableVisitor
from ml.kore.utils import KoreUtils, PatternPath

from ml.metamath import ast as mm
from ml.metamath.composer import Proof
from ml.metamath.auto.typecode import TypecodeProver

from .env import ProofGenerator, KoreComposer, ProvableClaim
from .fol import FOLProofGenerator
from .templates import KoreTemplates

# AppliedEquation = List[Tuple[Equation, PatternPath]]


@dataclass
class UnificationResult:
    substitution: Dict[kore.Variable, kore.Pattern] = field(default_factory=lambda: {})
    applied_equations: List[Tuple[Equation, PatternPath]] = field(default_factory=lambda: [])

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

    @staticmethod
    def prepend_path_to_applied_eqs(applied_eqs: List[Tuple[Equation, PatternPath]],
                                    prefix: int) -> List[Tuple[Equation, PatternPath]]:
        return [(eqn, [prefix] + path) for eqn, path in applied_eqs]

    def prepend_path(self, prefix: Union[int, Iterable[int]]) -> UnificationResult:
        if isinstance(prefix, int):
            return UnificationResult(
                self.substitution,
                [(eqn, [prefix] + path) for eqn, path in self.applied_equations],
            )
        else:
            return UnificationResult(
                self.substitution,
                [(eqn, list(prefix) + path) for eqn, path in self.applied_equations],
            )

    def append_equation(self, equation: Equation, path: PatternPath) -> UnificationResult:
        return UnificationResult(self.substitution, self.applied_equations + [(equation, path)])

    def prepend_equation(self, equation: Equation, path: PatternPath) -> UnificationResult:
        return UnificationResult(self.substitution, [(equation, path)] + self.applied_equations)

    def append_equations(self, equations: List[Tuple[Equation, PatternPath]]) -> UnificationResult:
        return UnificationResult(self.substitution, self.applied_equations + equations)

    def prepend_equations(self, equations: List[Tuple[Equation, PatternPath]]) -> UnificationResult:
        return UnificationResult(self.substitution, equations + self.applied_equations)

    def inverse_equations(self) -> UnificationResult:
        return UnificationResult(self.substitution, [(eqn.get_inverse(), path) for eqn, path in self.applied_equations])

    def __str__(self) -> str:
        return "sigma = {{ {} }}, T = [ {} ]".format(
            ", ".join([f"{a} = {b}" for a, b in self.substitution.items()]),
            ", ".join([f"({e}, {p})" for e, p in self.applied_equations]),
        )


class Equation:
    def __init__(self, composer: KoreComposer):
        self.composer = composer

    def __str__(self) -> str:
        return type(self).__name__

    def get_inverse(self) -> Equation:
        raise NotImplementedError()

    def replace_equal_subpattern(self, provable: ProvableClaim, path: PatternPath) -> ProvableClaim:
        """
        Given a valid pattern |- phi and a path pointing to a subpattern
        apply the equation to the subpattern to get an equivalent patten phi'
        and return phi' and the proof of it
        """
        raise NotImplementedError()


class DuplicateConjunction(Equation):
    r"""
    phi /\ phi = phi
    """
    def __init__(self, composer: KoreComposer, inverse: bool = False):
        super().__init__(composer)
        self.inverse = inverse

    def get_inverse(self) -> Equation:
        return DuplicateConjunction(self.composer, not self.inverse)

    def replace_equal_subpattern(self, provable: ProvableClaim, path: PatternPath) -> ProvableClaim:
        subpattern = KoreUtils.get_subpattern_by_path(provable.claim, path)
        assert isinstance(subpattern, kore.Pattern)

        if self.inverse:
            # phi -> phi /\ phi
            argument = subpattern
        else:
            # phi /\ phi -> phi
            argument, _ = KoreUtils.destruct_and(subpattern)

        sort_var = kore.SortVariable("R")
        equality = self.composer.construct_claim(
            KoreUtils.construct_equals(sort_var, KoreUtils.construct_and(argument, argument), argument),
            sort_variables=[sort_var],
        )

        provable_equality = self.composer.apply_kore_lemma(
            "kore-dup-and",
            goal=equality,
        )

        fol_gen = FOLProofGenerator(self.composer)

        if self.inverse:
            provable_equality = fol_gen.apply_symmetry(provable_equality)

        return fol_gen.replace_equal_subpattern(provable, path, provable_equality)


class InjectionCombine(Equation):
    r"""
    If A < B < C
    inj{B, C}(inj{A, B}(X)) => inj{A, C}(X)
    """
    def replace_equal_subpattern(self, provable: ProvableClaim, path: PatternPath) -> ProvableClaim:
        subpattern = KoreUtils.get_subpattern_by_path(provable.claim, path)
        assert (
            isinstance(subpattern, kore.Application)
            and subpattern.symbol.definition == self.composer.sort_injection_symbol
        )

        sort_b, sort_c = subpattern.symbol.sort_arguments

        subsubpattern = subpattern.arguments[0]
        assert (
            isinstance(subsubpattern, kore.Application)
            and subsubpattern.symbol.definition == self.composer.sort_injection_symbol
        )

        sort_a, sort_b1 = subsubpattern.symbol.sort_arguments
        assert sort_b1 == sort_b, f"ill-sorted injection {subpattern}"

        fol_gen = FOLProofGenerator(self.composer)

        # sort_a < sort_b < sort_c
        inj_axiom_instance = fol_gen.get_inj_instance(sort_a, sort_b, sort_c)

        # the injection axiom should only have one free variable
        free_vars = list(KoreUtils.get_free_variables(inj_axiom_instance.claim))
        assert len(free_vars) == 1
        free_var, = free_vars

        inj_axiom_instance = fol_gen.apply_functional_substitution(
            inj_axiom_instance, {free_var: subsubpattern.arguments[0]}
        )

        return fol_gen.replace_equal_subpattern(provable, path, inj_axiom_instance)


class InjectionSplit(Equation):
    r"""
    If A < B < C
    inj{A, C}(X) => inj{B, C}(inj{A, B}(X))
    """
    def __init__(self, composer: KoreComposer, sort_a: kore.Sort, sort_b: kore.Sort, sort_c: kore.Sort):
        super().__init__(composer)
        self.sort_a = sort_a
        self.sort_b = sort_b
        self.sort_c = sort_c

    def replace_equal_subpattern(self, provable: ProvableClaim, path: PatternPath) -> ProvableClaim:
        subpattern = KoreUtils.get_subpattern_by_path(provable.claim, path)
        assert (
            isinstance(subpattern, kore.Application)
            and subpattern.symbol.definition == self.composer.sort_injection_symbol
        )

        argument = subpattern.arguments[0]

        sort_a, sort_c = subpattern.symbol.sort_arguments
        assert sort_a == self.sort_a and sort_c == self.sort_c

        fol_gen = FOLProofGenerator(self.composer)

        # sort_a < sort_b < sort_c
        inj_axiom_instance = fol_gen.get_inj_instance(self.sort_a, self.sort_b, self.sort_c)

        # the injection axiom should only have one free variable
        free_vars = list(KoreUtils.get_free_variables(inj_axiom_instance.claim))
        assert len(free_vars) == 1
        free_var, = free_vars

        inj_axiom_instance = fol_gen.apply_functional_substitution(inj_axiom_instance, {free_var: argument})

        # reverse the equation
        inj_axiom_instance = fol_gen.apply_symmetry(inj_axiom_instance)

        return fol_gen.replace_equal_subpattern(provable, path, inj_axiom_instance)


class MapCommutativity(Equation):
    r"""
    mapmerge(M1, M2) === mapmerge(M2, M1)
    """
    def get_inverse(self) -> MapCommutativity:
        return self

    def replace_equal_subpattern(self, provable: ProvableClaim, path: PatternPath) -> ProvableClaim:
        subpattern = KoreUtils.get_subpattern_by_path(provable.claim, path)
        assert isinstance(subpattern, kore.Application)
        # TODO:: assert here that subpattern is a mapmerge

        # get the two variable (names) in the commutativity axiom
        map_sort = KoreUtils.infer_sort(subpattern)
        assert map_sort in self.composer.map_commutativity_axiom, f"unable to find commutativity axiom for {map_sort}"
        assert isinstance(map_sort, kore.SortInstance)
        comm_axiom = self.composer.map_commutativity_axiom[map_sort]

        comm_axiom_body = KoreUtils.strip_forall(comm_axiom.claim.pattern)
        assert isinstance(comm_axiom_body, kore.MLPattern)
        assert isinstance(comm_axiom_body.arguments[0], kore.Application)

        var1, var2 = comm_axiom_body.arguments[0].arguments
        assert isinstance(var1, kore.Variable) and isinstance(var2, kore.Variable)

        fol_gen = FOLProofGenerator(self.composer)

        subst = {var1: subpattern.arguments[0], var2: subpattern.arguments[1]}
        axiom_instance = fol_gen.apply_functional_substitution(comm_axiom, subst)

        return fol_gen.replace_equal_subpattern(
            provable,
            path,
            axiom_instance,
        )


class MapAssociativity(Equation):
    r"""
    mapmerge(mapmerge(M1, M2), M3) <==> mapmerge(M1, mapmerge(M2, M3))
    We use a boolean rotate_right to control the direction.
    """
    def __init__(self, composer: KoreComposer, rotate_right: bool):
        super().__init__(composer)
        self.rotate_right: bool = rotate_right

    def get_inverse(self) -> MapAssociativity:
        return MapAssociativity(self.composer, not self.rotate_right)

    def replace_equal_subpattern(self, provable: ProvableClaim, path: PatternPath) -> ProvableClaim:
        subpattern = KoreUtils.get_subpattern_by_path(provable.claim, path)
        assert isinstance(subpattern, kore.Application)
        assert KoreTemplates.is_map_merge_pattern(subpattern)

        map_sort = KoreUtils.infer_sort(subpattern)
        assert map_sort in self.composer.map_associativity_axiom, f"unable to find associativity axiom for {map_sort}"
        assert isinstance(map_sort, kore.SortInstance)
        assoc_axiom = self.composer.map_associativity_axiom[map_sort]

        assoc_axiom_body = KoreUtils.strip_forall(assoc_axiom.claim.pattern)
        assert isinstance(assoc_axiom_body, kore.MLPattern)
        assert isinstance(assoc_axiom_body.arguments[0], kore.Application)

        # get the universally quantified variables of the associativity axiom
        left, var3 = assoc_axiom_body.arguments[0].arguments
        assert isinstance(left, kore.Application) and isinstance(var3, kore.Variable)
        var1, var2 = left.arguments
        assert isinstance(var1, kore.Variable) and isinstance(var2, kore.Variable)

        # depending on the direction, instantiate differently
        if self.rotate_right:
            assert isinstance(subpattern.arguments[0], kore.Application)
            assert KoreTemplates.is_map_merge_pattern(subpattern.arguments[0])

            subst = {
                var1: subpattern.arguments[0].arguments[0],
                var2: subpattern.arguments[0].arguments[1],
                var3: subpattern.arguments[1],
            }
        else:
            assert isinstance(subpattern.arguments[1], kore.Application)
            assert KoreTemplates.is_map_merge_pattern(subpattern.arguments[1])

            subst = {
                var1: subpattern.arguments[0],
                var2: subpattern.arguments[1].arguments[0],
                var3: subpattern.arguments[1].arguments[1],
            }

        fol_gen = FOLProofGenerator(self.composer)

        axiom_instance = fol_gen.apply_functional_substitution(assoc_axiom, subst)

        # apply symmetry
        if not self.rotate_right:
            axiom_instance = fol_gen.apply_symmetry(axiom_instance)

        return fol_gen.replace_equal_subpattern(
            provable,
            path,
            axiom_instance,
        )


class MapRightUnit(Equation):
    """
    merge(M, .Map) == M
    """
    def __init__(self, composer: KoreComposer, inverse: bool = False):
        """
        When inverse is true, apply the equation from left to right:
        M => merge(M, .Map)
        """
        super().__init__(composer)
        self.inverse = inverse

    def get_inverse(self) -> MapRightUnit:
        return MapRightUnit(self.composer, not self.inverse)

    def replace_equal_subpattern(self, provable: ProvableClaim, path: PatternPath) -> ProvableClaim:
        subpattern = KoreUtils.get_subpattern_by_path(provable.claim, path)
        assert isinstance(subpattern, kore.Pattern)
        assert KoreTemplates.is_map_pattern(subpattern)

        map_sort = KoreUtils.infer_sort(subpattern)
        assert map_sort in self.composer.map_right_unit_axiom, f"unable to find right unit axiom for {map_sort}"
        assert isinstance(map_sort, kore.SortInstance)
        right_unit_axiom = self.composer.map_right_unit_axiom[map_sort]

        right_unit_axiom_body = KoreUtils.strip_forall(right_unit_axiom.claim.pattern)
        assert isinstance(right_unit_axiom_body, kore.MLPattern)
        assert isinstance(right_unit_axiom_body.arguments[1], kore.Variable)

        var = right_unit_axiom_body.arguments[1]

        if self.inverse:
            subst = {var: subpattern}
        else:
            assert KoreTemplates.is_map_merge_pattern(subpattern)
            assert KoreTemplates.is_map_unit_pattern(KoreTemplates.get_map_merge_right(subpattern))
            subst = {var: KoreTemplates.get_map_merge_left(subpattern)}

        fol_gen = FOLProofGenerator(self.composer)

        axiom_instance = fol_gen.apply_functional_substitution(right_unit_axiom, subst)

        if self.inverse:
            axiom_instance = fol_gen.apply_symmetry(axiom_instance)

        return fol_gen.replace_equal_subpattern(
            provable,
            path,
            axiom_instance,
        )


class MapUnificationMixin(ABC):
    """
    A mixin class for map unification
    """

    composer = None  # type: KoreComposer

    @abstractmethod
    def unify_patterns(self, pattern1: kore.Pattern, pattern2: kore.Pattern) -> Optional[UnificationResult]:
        ...

    def bubble_item(self, pattern: kore.Pattern,
                    path: PatternPath) -> Tuple[kore.Pattern, List[Tuple[Equation, PatternPath]]]:
        """
        Swap item at the given path to the leftmost, topmost node
        """
        equations: List[Tuple[Equation, PatternPath]] = []

        if KoreTemplates.is_map_mapsto_pattern(pattern) or \
           KoreTemplates.is_map_unit_pattern(pattern):
            assert path == []
            return pattern, []

        # swap branch where the smallest element is located, to the leftmost branch
        copied = KoreUtils.copy_pattern(pattern)
        pointer = copied
        for depth, left_or_right in enumerate(path):
            if left_or_right == 1:  # if it's at the RHS, swap
                equations.append((MapCommutativity(self.composer), [0] * depth))
                KoreTemplates.in_place_swap_map_merge_pattern(pointer)

            pointer = KoreTemplates.get_map_merge_left(pointer)

        # rotate right until the smallest element is at the topmost level
        pointer = copied
        while KoreTemplates.is_map_merge_pattern(pointer) and \
              KoreTemplates.is_map_merge_pattern(KoreTemplates.get_map_merge_left(pointer)):
            KoreTemplates.in_place_rotate_right_map_merge_pattern(pointer)
            equations.append((MapAssociativity(self.composer, True), []))

        return copied, equations

    def sort_map_pattern(self, pattern: kore.Pattern) -> Tuple[kore.Pattern, List[Tuple[Equation, PatternPath]]]:
        """
        Sort the given map pattern to the following "linear" form
        merge(m_1, merge(m_2, ... merge(m_k-1, m_k) ...))
        such that
        key(m_1) < ... < key(m_k)
        """
        assert isinstance(pattern, kore.Application)

        if KoreTemplates.is_map_mapsto_pattern(pattern) or \
           KoreTemplates.is_map_unit_pattern(pattern):
            return pattern, []

        assert KoreTemplates.is_map_merge_pattern(pattern), \
               f"expecting map merge, got {pattern}"

        # swap & rotate such that the resulting map is of the form
        # merge(a, rest)
        # where a is the item with the smallest key
        _, smallest_path = KoreTemplates.get_path_to_smallest_key_in_map_pattern(pattern)
        pattern_bubbled, applied_eqs_bubbled = self.bubble_item(pattern, smallest_path)
        assert isinstance(pattern_bubbled, kore.Application)

        pattern_bubbled_right = KoreTemplates.get_map_merge_right(pattern_bubbled)

        # recursively sort submaps
        pattern_bubbled_right_sorted, applied_eqs_right = self.sort_map_pattern(pattern_bubbled_right)

        sorted_pattern = KoreUtils.copy_pattern(pattern)
        sorted_pattern.arguments[0] = pattern_bubbled.arguments[0]
        sorted_pattern.arguments[1] = pattern_bubbled_right_sorted

        # aggregate all equations applied
        applied_eqs = applied_eqs_bubbled + UnificationResult.prepend_path_to_applied_eqs(applied_eqs_right, 1)

        if KoreTemplates.is_map_unit_pattern(pattern_bubbled_right_sorted):
            applied_eqs.append((MapRightUnit(self.composer), []))
            return pattern_bubbled.arguments[0], applied_eqs

        return sorted_pattern, applied_eqs

    def unify_concrete_map_pattern_children(self, pattern1: kore.Pattern,
                                            pattern2: kore.Pattern) -> Optional[UnificationResult]:
        if KoreTemplates.is_map_unit_pattern(pattern1) and \
           KoreTemplates.is_map_unit_pattern(pattern2):
            return UnificationResult()

        if KoreTemplates.is_map_mapsto_pattern(pattern1) and \
           KoreTemplates.is_map_mapsto_pattern(pattern2):
            assert isinstance(pattern1, kore.Application) and \
                   isinstance(pattern2, kore.Application)
            k1, v1 = pattern1.arguments
            k2, v2 = pattern2.arguments

            if k1 != k2:
                return None

            result = self.unify_patterns(v1, v2)
            if result is None:
                return result

            return result.prepend_path(1)

        if KoreTemplates.is_map_merge_pattern(pattern1) and \
           KoreTemplates.is_map_merge_pattern(pattern2):
            left1 = KoreTemplates.get_map_merge_left(pattern1)
            left2 = KoreTemplates.get_map_merge_left(pattern2)

            right1 = KoreTemplates.get_map_merge_right(pattern1)
            right2 = KoreTemplates.get_map_merge_right(pattern2)

            unification1 = self.unify_concrete_map_pattern_children(left1, left2)
            if unification1 is None:
                return None
            unification1 = unification1.prepend_path(0)

            unification2 = self.unify_concrete_map_pattern_children(right1, right2)
            if unification2 is None:
                return None
            unification2 = unification2.prepend_path(1)

            return unification1.merge(unification2)

        return None

    def unify_concrete_map_patterns_with_sort(self, pattern1: kore.Pattern,
                                              pattern2: kore.Pattern) -> Optional[UnificationResult]:
        pattern1_sorted, applied_eqs1 = self.sort_map_pattern(pattern1)
        pattern2_sorted, applied_eqs2 = self.sort_map_pattern(pattern2)

        unification = self.unify_concrete_map_pattern_children(pattern1_sorted, pattern2_sorted)
        if unification is None:
            return None

        reversed_eqs2 = [(eq.get_inverse(), path) for eq, path in applied_eqs2[::-1]]

        return unification.prepend_equations(applied_eqs1).append_equations(reversed_eqs2)

    def unify_concrete_map_patterns(self, pattern1: kore.Pattern,
                                    pattern2: kore.Pattern) -> Optional[UnificationResult]:
        """
        Unify two concrete map patterns.
        """

        # KoreUtils.pretty_print(pattern1)
        # KoreUtils.pretty_print(pattern2)

        if not KoreTemplates.is_map_pattern(pattern1) or \
           not KoreTemplates.is_map_pattern(pattern2):
            return None

        if KoreTemplates.is_map_unit_pattern(pattern1) and \
           KoreTemplates.is_map_unit_pattern(pattern2):
            return UnificationResult()

        if KoreTemplates.is_map_mapsto_pattern(pattern1) and \
           KoreTemplates.is_map_mapsto_pattern(pattern2):
            return self.unify_concrete_map_pattern_children(pattern1, pattern2)

        if not KoreTemplates.is_map_merge_pattern(pattern1) or \
           not KoreTemplates.is_map_merge_pattern(pattern2):
            # fall back to the dumb strategy
            # TODO: simplify this
            # print("fallback!")
            # KoreUtils.pretty_print(pattern1)
            # KoreUtils.pretty_print(pattern2)
            return self.unify_concrete_map_patterns_with_sort(pattern1, pattern2)

        if (KoreTemplates.get_path_to_nth_item_in_map(pattern1, 0) is None) != \
           (KoreTemplates.get_path_to_nth_item_in_map(pattern2, 0) is None):
            # one is empty and the other is not
            return None

        left1 = KoreTemplates.get_map_merge_left(pattern1)

        # if the left most item is not at the top level, we shuffle it up
        if not KoreTemplates.is_map_mapsto_pattern(left1):
            path = KoreTemplates.get_path_to_nth_item_in_map(pattern1, 0)
            assert path is not None
            pattern1, applied_eqs1 = self.bubble_item(pattern1, path)
            left1 = KoreTemplates.get_map_merge_left(pattern1)
        else:
            applied_eqs1 = []

        key, _ = KoreTemplates.destruct_mapsto(left1)

        # find an item with the same key in pattern2
        pattern2_items = KoreTemplates.destruct_map_pattern(pattern2)

        for i, (k, _) in enumerate(pattern2_items):
            if k == key:
                break
        else:
            return None

        path = KoreTemplates.get_path_to_nth_item_in_map(pattern2, i)
        assert path is not None
        pattern2, applied_eqs2 = self.bubble_item(pattern2, path)
        left2 = KoreTemplates.get_map_merge_left(pattern2)

        # KoreUtils.pretty_print(pattern1)
        # KoreUtils.pretty_print(pattern2)

        left_unification = self.unify_concrete_map_pattern_children(left1, left2)
        if left_unification is None:
            return None

        # then recursively unify the RHS of both maps
        right1 = KoreTemplates.get_map_merge_right(pattern1)
        right2 = KoreTemplates.get_map_merge_right(pattern2)

        right_unification = self.unify_concrete_map_patterns(right1, right2)
        if right_unification is None:
            return None

        unification = left_unification.prepend_path(0).merge(right_unification.prepend_path(1))
        if unification is None:
            return None

        # we want to first apply applied_eqs1 to make pattern1 into the form <left1> * <right1>
        # then apply the sub-unification results to transform left1 and right1
        # then we apply applied_eqs2 in reverse to make it the same form as pattern2
        reversed_eqs2 = [(eq.get_inverse(), path) for eq, path in applied_eqs2[::-1]]

        return unification.prepend_equations(applied_eqs1).append_equations(reversed_eqs2)


@dataclass
class ConstraintEquation(Equation):
    """
    This serves as an indicator to the caller
    of the unification generator where an
    additional equation (equations in the constraint)
    is applied during unification
    """
    def __init__(self, composer: KoreComposer, lhs: kore.Pattern, rhs: kore.Pattern):
        super().__init__(composer)
        self.lhs = lhs
        self.rhs = rhs

    def get_inverse(self) -> Equation:
        return ConstraintEquation(self.composer, self.rhs, self.lhs)


class UnificationProofGenerator(ProofGenerator, MapUnificationMixin):
    def __init__(
        self,
        composer: KoreComposer,
        allow_unevaluated_functions: bool = False,
        disable_substitution: bool = False,
    ):
        """
        additional_equations specifies a list of equations that
        we should consider equal. Used for constrained patterns
        """
        super().__init__(composer)
        self.allow_unevaluated_functions = allow_unevaluated_functions
        self.disable_substitution = disable_substitution

    """
    Unify two patterns modulo certain equations
    NOTE: this generator currently only supports
    unifying a pattern with a CONCRETE pattern
    """

    def unify_patterns(self, pattern1: kore.Pattern, pattern2: kore.Pattern) -> Optional[UnificationResult]:
        """
        Losely following https://github.com/kframework/kore/blob/master/docs/2018-11-12-Unification.md
        """

        algorithms = (
            self.unify_same_patterns,
            self.unify_unevaluated_functions,
            self.unify_vars,
            self.unify_applications,
            self.unify_ml_patterns,
            self.unify_string_literals,
            self.unify_left_duplicate_conjunction,
            self.unify_right_duplicate_conjunction,
            self.unify_distinct_inj,
            self.unify_concrete_map_patterns,
        )
        for algo in algorithms:
            result = algo(pattern1, pattern2)
            if result is not None:
                return result

        # print("pattern1")
        # KoreUtils.pretty_print(pattern1)
        # print("pattern2")
        # KoreUtils.pretty_print(pattern2)

        return None

    def unify_same_patterns(self, pattern1: kore.Pattern, pattern2: kore.Pattern) -> Optional[UnificationResult]:
        if pattern1 == pattern2:
            return UnificationResult()
        return None

    def unify_vars(self, pattern1: kore.Pattern, pattern2: kore.Pattern) -> Optional[UnificationResult]:
        """
        Check if any one of the patterns is a variable, if so try to unify
        otherwise return failure
        """

        if not isinstance(pattern1, kore.Variable) and not isinstance(pattern2, kore.Variable):
            return None

        if self.disable_substitution:
            return None

        if isinstance(pattern1, kore.Variable):
            if pattern1 in FreePatternVariableVisitor().visit(pattern2):
                return None

            return UnificationResult({pattern1: pattern2})
        else:
            assert isinstance(pattern2, kore.Variable)

            if pattern2 in FreePatternVariableVisitor().visit(pattern1):
                return None

            return UnificationResult({pattern2: pattern1})

    def unify_applications(self, pattern1: kore.Pattern, pattern2: kore.Pattern) -> Optional[UnificationResult]:
        """
        Try to unify two applications, expecting symbols and the number
        of arguments to be exactly the same
        """
        if not isinstance(pattern1, kore.Application) or not isinstance(pattern2, kore.Application):
            return None

        if pattern1.symbol != pattern2.symbol or len(pattern1.arguments) != len(pattern2.arguments):
            return None

        # unify subpatterns
        unification: UnificationResult = UnificationResult()

        for index, (subpattern1, subpattern2) in enumerate(zip(pattern1.arguments, pattern2.arguments)):
            subunification = self.unify_patterns(subpattern1, subpattern2)
            if subunification is None:
                return None

            merged = unification.merge(subunification.prepend_path(index))
            if merged is None:
                return None

            unification = merged

        return unification

    def unify_ml_patterns(self, pattern1: kore.Pattern, pattern2: kore.Pattern) -> Optional[UnificationResult]:
        """
        Try to unify two ML patterns. Currently
        we are conservatively assuming that the two patterns'
        top level constructs have to be exactly the same
        """
        if not isinstance(pattern1, kore.MLPattern) or not isinstance(pattern2, kore.MLPattern):
            return None

        if (pattern1.construct != pattern2.construct or pattern1.sorts != pattern2.sorts
                or len(pattern1.arguments) != len(pattern2.arguments)):
            return None

        # TODO: this is probably too conservative
        if (pattern1.construct == kore.MLPattern.FORALL or pattern1.construct == kore.MLPattern.EXISTS):
            if pattern1.get_binding_variable() != pattern1.get_binding_variable():
                return None

        # unify subpatterns
        unification = UnificationResult()

        for index, (subpattern1, subpattern2) in enumerate(zip(pattern1.arguments, pattern2.arguments)):
            subunification = self.unify_patterns(subpattern1, subpattern2)
            if subunification is None:
                return None

            merged = unification.merge(subunification.prepend_path(index))
            if merged is None:
                return None

            unification = merged

        return unification

    def unify_string_literals(self, pattern1: kore.Pattern, pattern2: kore.Pattern) -> Optional[UnificationResult]:
        if (isinstance(pattern1, kore.StringLiteral) and isinstance(pattern2, kore.StringLiteral)
                and pattern1 == pattern2):
            return UnificationResult()
        else:
            return None

    def unify_left_duplicate_conjunction(self, pattern1: kore.Pattern,
                                         pattern2: kore.Pattern) -> Optional[UnificationResult]:
        r"""
        Assuming pattern1 is of the form phi /\ var
        and if pattern2 is unifiable with phi, then we
        can apply DuplicateConjunction to reduce
        phi /\ phi to phi after substitution
        """
        if KoreUtils.is_and(pattern1):
            left, right = KoreUtils.destruct_and(pattern1)

            result1 = self.unify_patterns(left, pattern2)
            result2 = self.unify_patterns(right, pattern2)
            if result1 is not None and result2 is not None:
                unification = result1.prepend_path(0).merge(result2.prepend_path(1))
                if unification is None:
                    return None

                return unification.append_equation(DuplicateConjunction(self.composer), [])

        return None

    def unify_right_duplicate_conjunction(self, pattern1: kore.Pattern,
                                          pattern2: kore.Pattern) -> Optional[UnificationResult]:
        """
        Similar to unify_left_duplicate_conjunction
        but in the case where pattern2 is a conjunction
        """
        if KoreUtils.is_and(pattern2):
            left, right = KoreUtils.destruct_and(pattern2)

            result1 = self.unify_patterns(pattern1, left)
            result2 = self.unify_patterns(pattern1, right)

            if result1 is not None and result2 is not None:
                unification = result1.prepend_path(0).merge(result2.prepend_path(1))
                if unification is None:
                    return None

                # the equation is prepended: we need to split the term into a conjunction
                # first before applying rest of the equations
                return unification.prepend_equation(DuplicateConjunction(self.composer, inverse=True), [])

        return None

    def unify_distinct_inj(self, pattern1: kore.Pattern, pattern2: kore.Pattern) -> Optional[UnificationResult]:
        """
        If left pattern is inj{A, C}(X) and
        the right pattern is inj{B, C}(X)
        such that B < A or A < B, we can split the
        left/right pattern to inj{A, C}(inj{B, A}(X))
        and keep unifying
        """

        if (isinstance(pattern1, kore.Application) and isinstance(pattern2, kore.Application)
                and pattern1.symbol.definition == self.composer.sort_injection_symbol
                and pattern2.symbol.definition == self.composer.sort_injection_symbol):

            sort_a = pattern1.symbol.sort_arguments[0]
            sort_b = pattern2.symbol.sort_arguments[0]
            sort_c1 = pattern1.symbol.sort_arguments[1]
            sort_c2 = pattern2.symbol.sort_arguments[1]

            # if sort_c1 != sort_c2, the two patterns don't have the same output sort
            # if sort_a == sort_b, the case should already be resolved by an earlier
            # unification algorithm
            if sort_c1 != sort_c2 or \
               not isinstance(sort_a, kore.SortInstance) or \
               not isinstance(sort_b, kore.SortInstance) or \
               sort_a == sort_b:
                return None

            argument1 = pattern1.arguments[0]
            argument2 = pattern2.arguments[0]

            # pattern1: A -> C
            # pattern2: B -> C

            if self.composer.subsort_relation.get_subsort_chain(sort_b, sort_a) is not None:
                # B < A
                # split B -> C into B -> A -> C

                split_right_inj = kore.Application(
                    kore.SymbolInstance(
                        self.composer.sort_injection_symbol,
                        [sort_b, sort_a],
                    ),
                    [argument2],
                )
                split_right_inj.resolve(self.composer.module)

                result = self.unify_patterns(argument1, split_right_inj)
                if result is None:
                    return None

                return result.prepend_path(0).append_equation(InjectionCombine(self.composer), [])

            elif self.composer.subsort_relation.get_subsort_chain(sort_a, sort_b) is not None:
                # A < B
                # split A -> C to A -> B -> C

                split_left_inj = kore.Application(
                    kore.SymbolInstance(
                        self.composer.sort_injection_symbol,
                        [sort_a, sort_b],
                    ),
                    [argument1],
                )
                split_left_inj.resolve(self.composer.module)

                result = self.unify_patterns(split_left_inj, argument2)
                if result is None:
                    return None

                return result.append_equation(InjectionSplit(self.composer, sort_a, sort_b, sort_c1), [])

        return None

    def can_be_matched(self, pattern1: kore.Pattern, pattern2: kore.Pattern) -> bool:
        """
        This works on domain values but will probably fail on ADTs
        """
        return KoreTemplates.is_function_pattern(pattern1) and KoreTemplates.is_function_pattern(pattern2) or \
               KoreTemplates.is_function_pattern(pattern1) and KoreUtils.is_dv(pattern2) or \
               isinstance(pattern1, kore.Variable) and KoreTemplates.is_function_pattern(pattern2) or \
               isinstance(pattern1, kore.Variable) and KoreUtils.is_dv(pattern2) or \
               isinstance(pattern1, kore.Variable) and isinstance(pattern2, kore.Variable)

    def unify_unevaluated_functions(self, pattern1: kore.Pattern,
                                    pattern2: kore.Pattern) -> Optional[UnificationResult]:
        """
        If allow_unevaluated_functions is True,
        we will also add extra equations for unmatched
        subterms that have function head symbols
        """

        if self.allow_unevaluated_functions and \
           (self.can_be_matched(pattern1, pattern2) or self.can_be_matched(pattern2, pattern1)):
            return UnificationResult().append_equation(ConstraintEquation(self.composer, pattern1, pattern2), [])

        return None
