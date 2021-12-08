from typing import Optional, Tuple, List, Union

import ml.kore.ast as kore
from ml.kore.utils import KoreUtils, PatternPath
from ml.kore.parser import parse_axiom, parse_pattern


class KoreTemplates:
    """
    A utility class used to extract and identify
    certain information in a kompile-generated kore module
    """
    @staticmethod
    def is_rewrite_axiom(axiom: kore.Axiom) -> bool:
        inner_pattern = KoreUtils.strip_forall(axiom.pattern)
        return (isinstance(inner_pattern, kore.MLPattern) and inner_pattern.construct == kore.MLPattern.REWRITES)

    @staticmethod
    def is_anywhere_rule_axiom(axiom: kore.Axiom) -> bool:
        inner_pattern = KoreUtils.strip_forall(axiom.pattern)
        return (
            isinstance(inner_pattern, kore.MLPattern) and inner_pattern.construct == kore.MLPattern.IMPLIES
            and isinstance(inner_pattern.arguments[1], kore.MLPattern)
            and inner_pattern.arguments[1].construct == kore.MLPattern.AND
            and isinstance(inner_pattern.arguments[1].arguments[0], kore.MLPattern)
            and inner_pattern.arguments[1].arguments[0].construct == kore.MLPattern.EQUALS
        )

    @staticmethod
    def is_functional_axiom(axiom: kore.Axiom) -> bool:
        return KoreTemplates.get_symbol_of_functional_axiom(axiom) is not None

    @staticmethod
    def is_map_commutativity_axiom(axiom: kore.Axiom) -> Optional[kore.SortInstance]:
        inner_pattern = KoreUtils.strip_forall(axiom.pattern)
        if (axiom.has_attribute("comm") and isinstance(inner_pattern, kore.MLPattern)
                and inner_pattern.construct == kore.MLPattern.EQUALS
                and str(inner_pattern.sorts[0]).endswith(r"Map{}")  # TODO: a bit hacky...
            ):
            assert isinstance(inner_pattern.sorts[0], kore.SortInstance)
            return inner_pattern.sorts[0]
        return None

    @staticmethod
    def is_map_associativity_axiom(axiom: kore.Axiom) -> Optional[kore.SortInstance]:
        inner_pattern = KoreUtils.strip_forall(axiom.pattern)
        if (axiom.has_attribute("assoc") and isinstance(inner_pattern, kore.MLPattern)
                and inner_pattern.construct == kore.MLPattern.EQUALS
                and str(inner_pattern.sorts[0]).endswith(r"Map{}")):
            assert isinstance(inner_pattern.sorts[0], kore.SortInstance)
            return inner_pattern.sorts[0]
        return None

    @staticmethod
    def is_map_right_unit_axiom(axiom: kore.Axiom) -> Optional[kore.SortInstance]:
        inner_pattern = KoreUtils.strip_forall(axiom.pattern)
        if (axiom.has_attribute("unit") and isinstance(inner_pattern, kore.MLPattern)
                and inner_pattern.construct == kore.MLPattern.EQUALS
                and str(inner_pattern.sorts[0]).endswith(r"Map{}")  # something like SortMap{}
                and isinstance(inner_pattern.arguments[0], kore.Application)
                and isinstance(inner_pattern.arguments[0].arguments[1], kore.Application)
                and inner_pattern.arguments[0].arguments[1].symbol.get_symbol_name().endswith(
                    "Map")  # something like Lbl'Stop'Map
            ):
            assert isinstance(inner_pattern.sorts[0], kore.SortInstance)
            return inner_pattern.sorts[0]
        return None

    @staticmethod
    def get_symbol_of_equational_axiom(axiom: kore.Axiom, ) -> Optional[kore.SymbolInstance]:
        inner_pattern = KoreUtils.strip_forall(axiom.pattern)
        if not (isinstance(inner_pattern, kore.MLPattern) and inner_pattern.construct == kore.MLPattern.IMPLIES):
            return None

        rhs = inner_pattern.arguments[1]
        if not (isinstance(rhs, kore.MLPattern) and rhs.construct == kore.MLPattern.AND):
            return None

        equation = rhs.arguments[0]
        if not (isinstance(equation, kore.MLPattern) and equation.construct == kore.MLPattern.EQUALS):
            return None

        eqn_lhs = equation.arguments[0]
        if not isinstance(eqn_lhs, kore.Application):
            return None

        return eqn_lhs.symbol

    @staticmethod
    def get_sorts_of_subsort_axiom(axiom: kore.Axiom) -> Optional[Tuple[kore.SortInstance, kore.SortInstance]]:
        attribute = axiom.get_attribute_by_symbol("subsort")
        if attribute is None:
            return None

        sort1, sort2 = attribute.symbol.sort_arguments
        sort1.resolve(axiom.get_parent())
        sort2.resolve(axiom.get_parent())

        if not (isinstance(sort1, kore.SortInstance) and isinstance(sort2, kore.SortInstance)):
            return None

        return sort1, sort2

    @staticmethod
    def get_axiom_unique_id(axiom: kore.Axiom) -> Optional[str]:
        """
        Get the content of the attribute UNIQUE'Unds'ID{}(...)
        """
        id_term = axiom.get_attribute_by_symbol("UNIQUE'Unds'ID")
        if id_term is None:
            return None
        assert len(id_term.arguments) == 1 and isinstance(id_term.arguments[0], kore.StringLiteral)
        return id_term.arguments[0].content

    @staticmethod
    def get_symbol_of_functional_axiom(axiom: kore.Axiom) -> Optional[kore.SymbolInstance]:
        """
        Get the corresponding symbol instance of the given functional axiom
        """
        if not isinstance(axiom.pattern, kore.MLPattern):
            return None

        inner_existential = axiom.pattern

        # get to the inner existential pattern
        while inner_existential.construct == kore.MLPattern.FORALL:
            body = inner_existential.arguments[1]
            if not isinstance(body, kore.MLPattern):
                return None
            inner_existential = body

        if inner_existential.construct != kore.MLPattern.EXISTS:
            return None

        equality = inner_existential.arguments[1]
        if (not isinstance(equality, kore.MLPattern) or equality.construct != kore.MLPattern.EQUALS):
            return None

        rhs = equality.arguments[1]
        if not isinstance(rhs, kore.Application):
            return None

        return rhs.symbol

    @staticmethod
    def get_sort_symbol_of_no_junk_axiom(axiom: kore.Axiom) -> Optional[kore.SortInstance]:
        """
        A no junk axiom should be a disjunction of existential patterns
        """
        axiom_body = KoreUtils.strip_forall(axiom.pattern)
        patterns = KoreUtils.decompose_disjunction(axiom_body)

        if len(patterns) <= 1:
            return None

        for pattern in patterns:
            if not KoreUtils.is_existential(pattern):
                return None

        sort = KoreUtils.infer_sort(axiom.pattern)

        if not isinstance(sort, kore.SortInstance):
            return None

        return sort

    @staticmethod
    def get_symbol_for_no_confusion_same_constructor_axiom(axiom: kore.Axiom) -> Optional[kore.SymbolInstance]:
        r"""
        Axiom of the form
        f(ph1, ..., phn) /\ f(ph1', ..., phn') => f(ph1 /\ ph1', ..., phn /\ phn')
        """
        axiom_body = KoreUtils.strip_forall(axiom.pattern)
        if not (isinstance(axiom_body, kore.MLPattern) and axiom_body.construct == kore.MLPattern.IMPLIES
                and isinstance(axiom_body.arguments[0], kore.MLPattern) and axiom_body.arguments[0].construct
                == kore.MLPattern.AND and isinstance(axiom_body.arguments[0].arguments[0], kore.Application)
                and isinstance(axiom_body.arguments[0].arguments[1], kore.Application) and isinstance(
                    axiom_body.arguments[1], kore.Application) and axiom_body.arguments[0].arguments[0].symbol ==
                axiom_body.arguments[0].arguments[1].symbol == axiom_body.arguments[1].symbol):
            return None

        return axiom_body.arguments[1].symbol

    @staticmethod
    def get_symbols_for_no_confusion_different_constructor_axiom(
        axiom: kore.Axiom,
    ) -> Optional[Tuple[kore.SymbolInstance, kore.SymbolInstance]]:
        axiom_body = KoreUtils.strip_forall(axiom.pattern)
        if not (isinstance(axiom_body, kore.MLPattern) and axiom_body.construct == kore.MLPattern.NOT and isinstance(
                axiom_body.arguments[0], kore.MLPattern) and axiom_body.arguments[0].construct == kore.MLPattern.AND):
            return None

        left, right = axiom_body.arguments[0].arguments
        left = KoreUtils.strip_exists(left)
        right = KoreUtils.strip_exists(right)

        if not isinstance(left, kore.Application) or not isinstance(right, kore.Application):
            return None

        return left.symbol, right.symbol

    ###################################
    # Utils methods for map patterns. #
    ###################################

    @staticmethod
    def is_map_merge_pattern(pattern: kore.Pattern) -> bool:
        return (
            isinstance(pattern, kore.Application) and KoreTemplates.get_hook_function(pattern.symbol) == "MAP.concat"
            # pattern.symbol.get_symbol_name() == "Lbl'Unds'Map'Unds'"
            and len(pattern.arguments) == 2
        )

    @staticmethod
    def is_map_mapsto_pattern(pattern: kore.Pattern) -> bool:
        return (
            isinstance(pattern, kore.Application) and KoreTemplates.get_hook_function(pattern.symbol) == "MAP.element"
            # pattern.symbol.get_symbol_name() == "Lbl'UndsPipe'-'-GT-Unds'"
            and len(pattern.arguments) == 2
        )

    @staticmethod
    def destruct_mapsto(pattern: kore.Pattern) -> Tuple[kore.Pattern, kore.Pattern]:
        assert isinstance(pattern, kore.Application) and \
               KoreTemplates.get_hook_function(pattern.symbol) == "MAP.element" and \
               len(pattern.arguments) == 2, \
               f"unexpected pattern {pattern}"
        # pattern.symbol.get_symbol_name() == "Lbl'UndsPipe'-'-GT-Unds'" and \
        return pattern.arguments[0], pattern.arguments[1]

    @staticmethod
    def is_map_unit_pattern(pattern: kore.Pattern) -> bool:
        return (
            isinstance(pattern, kore.Application) and KoreTemplates.get_hook_function(pattern.symbol) == "MAP.unit"
            # pattern.symbol.get_symbol_name() == "Lbl'Stop'Map"
            and len(pattern.arguments) == 0
        )

    @staticmethod
    def is_map_pattern(pattern: kore.Pattern) -> bool:
        """
        Recursively check that a pattern has the following form
        phi ::= merge(phi1, phi2) | phi1 |-> phi2 | .map
        """

        if KoreTemplates.is_map_unit_pattern(pattern) or \
           KoreTemplates.is_map_mapsto_pattern(pattern):
            return True

        if KoreTemplates.is_map_merge_pattern(pattern):
            return KoreTemplates.is_map_pattern(KoreTemplates.get_map_merge_left(pattern)) and \
                   KoreTemplates.is_map_pattern(KoreTemplates.get_map_merge_right(pattern))

        return False

    @staticmethod
    def destruct_map_pattern(pattern: kore.Pattern) -> Tuple[Tuple[kore.Pattern, kore.Pattern], ...]:
        """
        Destruct the map to a list of (k, v) pairs
        """

        if KoreTemplates.is_map_unit_pattern(pattern):
            return ()

        if KoreTemplates.is_map_mapsto_pattern(pattern):
            return KoreTemplates.destruct_mapsto(pattern),

        if KoreTemplates.is_map_merge_pattern(pattern):
            return KoreTemplates.destruct_map_pattern(KoreTemplates.get_map_merge_left(pattern)) + \
                   KoreTemplates.destruct_map_pattern(KoreTemplates.get_map_merge_right(pattern))

        assert False, f"not a map pattern {pattern}"

    @staticmethod
    def get_map_merge_left(pattern: kore.Pattern) -> kore.Pattern:
        assert KoreTemplates.is_map_merge_pattern(pattern)
        assert isinstance(pattern, kore.Application)
        return pattern.arguments[0]

    @staticmethod
    def get_map_merge_right(pattern: kore.Pattern) -> kore.Pattern:
        assert KoreTemplates.is_map_merge_pattern(pattern)
        assert isinstance(pattern, kore.Application)
        return pattern.arguments[1]

    @staticmethod
    def in_place_swap_map_merge_pattern(pattern: kore.Pattern) -> None:
        assert KoreTemplates.is_map_merge_pattern(pattern)
        assert isinstance(pattern, kore.Application)
        pattern.arguments[0], pattern.arguments[1] = \
            pattern.arguments[1], pattern.arguments[0]

    @staticmethod
    def in_place_rotate_right_map_merge_pattern(pattern: kore.Pattern) -> None:
        assert KoreTemplates.is_map_merge_pattern(pattern)
        assert isinstance(pattern, kore.Application)

        left = KoreTemplates.get_map_merge_left(pattern)

        assert KoreTemplates.is_map_merge_pattern(left)
        assert isinstance(left, kore.Application)

        left_left = KoreTemplates.get_map_merge_left(left)
        left_right = KoreTemplates.get_map_merge_right(left)
        right = KoreTemplates.get_map_merge_right(pattern)
        assert isinstance(right, kore.Application)

        pattern.arguments[0] = left_left
        pattern.arguments[1] = left
        left.arguments[0] = left_right
        left.arguments[1] = right

    @staticmethod
    def get_path_to_nth_item_in_map(pattern: kore.Pattern, n: int) -> Optional[PatternPath]:
        """
        Get the path to the ith item in a map pattern
        """

        assert not KoreTemplates.is_map_unit_pattern(pattern), "empty map"

        if KoreTemplates.is_map_mapsto_pattern(pattern):
            assert n == 0, f"map {pattern} index out of bound {n}"
            return []  # root

        if KoreTemplates.is_map_merge_pattern(pattern):
            left = KoreTemplates.get_map_merge_left(pattern)
            right = KoreTemplates.get_map_merge_right(pattern)

            left_items = KoreTemplates.destruct_map_pattern(left)
            right_items = KoreTemplates.destruct_map_pattern(right)

            if n < len(left_items):
                rest = KoreTemplates.get_path_to_nth_item_in_map(left, n)
                if rest is None: return None
                return [0] + rest

            if n - len(left_items) < len(right_items):
                rest = KoreTemplates.get_path_to_nth_item_in_map(right, n - len(left_items))
                if rest is None: return None
                return [1] + rest

            # assert False, f"map {pattern} index out of bound {n}"
            return None

        assert False, f"not a map {pattern}"

    @staticmethod
    def get_path_to_smallest_key_in_map_pattern(pattern: kore.Pattern) -> Tuple[kore.Pattern, PatternPath]:
        r"""
        Return the path to the pattern with the smallest key.
        0 means "left branch" and 1 means "right branch".
        """

        assert KoreTemplates.is_map_pattern(pattern)
        assert isinstance(pattern, kore.Application)

        if KoreTemplates.is_map_mapsto_pattern(pattern) or \
           KoreTemplates.is_map_unit_pattern(pattern):
            return pattern, []

        assert KoreTemplates.is_map_merge_pattern(pattern), \
               f"expecting a map merge, got {pattern}"

        lhs = KoreTemplates.get_map_merge_left(pattern)
        rhs = KoreTemplates.get_map_merge_right(pattern)

        p, lp = KoreTemplates.get_path_to_smallest_key_in_map_pattern(lhs)
        q, lq = KoreTemplates.get_path_to_smallest_key_in_map_pattern(rhs)

        # we order units to be greater than any item
        if KoreTemplates.is_map_unit_pattern(p):
            return q, [1] + lq
        elif KoreTemplates.is_map_unit_pattern(q):
            return p, [0] + lp

        # now expect p and q to be mapsto patterns
        assert isinstance(p, kore.Application)
        assert isinstance(q, kore.Application)

        if p.arguments[0] < q.arguments[0]:
            return p, [0] + lp  # left
        elif q.arguments[0] < p.arguments[0]:
            return q, [1] + lq  # right

        assert False, f"same key in map: {p.arguments[0]} and {q.arguments[0]}"

    @staticmethod
    def strip_inj(pattern: kore.Pattern) -> kore.Pattern:
        """
        Strip call outermost injection calls
        """
        while (isinstance(pattern, kore.Application) and pattern.symbol.get_symbol_name() == "inj"):
            assert len(pattern.arguments) == 1
            pattern = pattern.arguments[0]
        return pattern

    @staticmethod
    def is_function_pattern(pattern: kore.Pattern) -> bool:
        """
        Check if the head symbol is a K function
        """
        if not isinstance(pattern, kore.Application):
            return False

        if not isinstance(pattern.symbol.definition, kore.SymbolDefinition):
            return False

        return pattern.symbol.definition.get_attribute_by_symbol("function") is not None

    @staticmethod
    def get_hook_function(symbol: Union[kore.SymbolDefinition, kore.SymbolInstance]) -> Optional[str]:
        """
        Each hooked symbol has an attribute hook{}(<name>)
        This util function returns <name>
        """

        if isinstance(symbol, kore.SymbolInstance):
            assert isinstance(symbol.definition, kore.SymbolDefinition), \
                   f"unresolved symbol {symbol}"
            symbol = symbol.definition

        hook = symbol.get_attribute_by_symbol("hook")

        if hook is None:
            return None

        assert len(hook.arguments) == 1 and isinstance(hook.arguments[0], kore.StringLiteral), \
               f"invalid hook attribute {hook}"

        return hook.arguments[0].content
