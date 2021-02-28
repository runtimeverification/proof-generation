from typing import Optional, Tuple, List

import ml.kore.ast as kore
from ml.kore.utils import KoreUtils


"""
A utility class used to extract and identify
certain information in a kompile-generated kore module
"""
class KoreTemplates:
    @staticmethod
    def is_rewrite_axiom(axiom: kore.Axiom) -> bool:
        inner_pattern = KoreUtils.strip_forall(axiom.pattern)
        return isinstance(inner_pattern, kore.MLPattern) and inner_pattern.construct == kore.MLPattern.REWRITES

    @staticmethod
    def is_anywhere_rule_axiom(axiom: kore.Axiom) -> bool:
        inner_pattern = KoreUtils.strip_forall(axiom.pattern)
        return isinstance(inner_pattern, kore.MLPattern) and \
               inner_pattern.construct == kore.MLPattern.IMPLIES and \
               isinstance(inner_pattern.arguments[1], kore.MLPattern) and \
               inner_pattern.arguments[1].construct == kore.MLPattern.AND and \
               isinstance(inner_pattern.arguments[1].arguments[0], kore.Pattern) and \
               inner_pattern.arguments[1].arguments[0].construct == kore.MLPattern.EQUALS

    @staticmethod
    def is_functional_axiom(axiom: kore.Axiom) -> bool:
        return KoreTemplates.get_symbol_of_functional_axiom(axiom) is not None

    @staticmethod
    def get_symbol_of_equational_axiom(axiom: kore.Axiom) -> Optional[kore.SymbolInstance]:
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
        if attribute is None: return None

        sort1, sort2 = attribute.symbol.sort_arguments
        sort1.resolve(axiom.get_parent())
        sort2.resolve(axiom.get_parent())

        return sort1, sort2

    """
    Get the content of the attribute UNIQUE'Unds'ID{}(...)
    """
    @staticmethod
    def get_axiom_unique_id(axiom: kore.Axiom) -> Optional[str]:
        id_term = axiom.get_attribute_by_symbol("UNIQUE'Unds'ID")
        if id_term is None: return None
        assert len(id_term.arguments) == 1 and isinstance(id_term.arguments[0], kore.StringLiteral)
        return id_term.arguments[0].content

    """
    Get the corresponding symbol instance of the given functional axiom
    """
    @staticmethod
    def get_symbol_of_functional_axiom(axiom: kore.Axiom) -> Optional[kore.SymbolInstance]:
        if not isinstance(axiom.pattern, kore.MLPattern):
            return None

        inner_existential = axiom.pattern

        # get to the inner existential pattern
        while inner_existential.construct == kore.MLPattern.FORALL:
            inner_existential = inner_existential.arguments[1]
            if not isinstance(inner_existential, kore.MLPattern):
                return None

        if inner_existential.construct != kore.MLPattern.EXISTS:
            return None

        equality = inner_existential.arguments[1]
        if not isinstance(equality, kore.MLPattern) or equality.construct != kore.MLPattern.EQUALS:
            return None

        rhs = equality.arguments[1]
        if not isinstance(rhs, kore.Application):
            return None

        return rhs.symbol

    """
    A no junk axiom should be a disjunction of existential patterns
    """
    @staticmethod
    def get_sort_symbol_of_no_junk_axiom(axiom: kore.Axiom) -> Optional[kore.SortInstance]:
        axiom_body = KoreUtils.strip_forall(axiom.pattern)
        patterns = KoreUtils.decompose_disjunction(axiom_body)

        if len(patterns) <= 1:
            return None

        for pattern in patterns:
            if not KoreUtils.is_existential(pattern):
                return None

        return KoreUtils.infer_sort(axiom.pattern)

    r"""
    Axiom of the form
    f(ph1, ..., phn) /\ f(ph1', ..., phn') => f(ph1 /\ ph1', ..., phn /\ phn')
    """
    @staticmethod
    def get_symbol_for_no_confusion_same_constructor_axiom(axiom: kore.Axiom) -> Optional[kore.SymbolInstance]:
        axiom_body  = KoreUtils.strip_forall(axiom.pattern)
        if not (isinstance(axiom_body, kore.MLPattern) and \
                axiom_body.construct == kore.MLPattern.IMPLIES and \
                isinstance(axiom_body.arguments[0], kore.MLPattern) and \
                axiom_body.arguments[0].construct == kore.MLPattern.AND and \
                isinstance(axiom_body.arguments[0].arguments[0], kore.Application) and \
                isinstance(axiom_body.arguments[0].arguments[1], kore.Application) and \
                isinstance(axiom_body.arguments[1], kore.Application) and \
                axiom_body.arguments[0].arguments[0].symbol == \
                axiom_body.arguments[0].arguments[1].symbol == \
                axiom_body.arguments[1].symbol):
            return None

        return axiom_body.arguments[1].symbol

    @staticmethod
    def get_symbols_for_no_confusion_different_constructor_axiom(axiom: kore.Axiom) -> Optional[Tuple[kore.SymbolInstance, kore.SymbolInstance]]:
        axiom_body  = KoreUtils.strip_forall(axiom.pattern)
        if not (isinstance(axiom_body, kore.MLPattern) and \
                axiom_body.construct == kore.MLPattern.NOT and \
                isinstance(axiom_body.arguments[0], kore.MLPattern) and \
                axiom_body.arguments[0].construct == kore.MLPattern.AND):
            return None

        left, right = axiom_body.arguments[0].arguments
        left = KoreUtils.strip_exists(left)
        right = KoreUtils.strip_exists(right)

        if not isinstance(left, kore.Application) or \
           not isinstance(right, kore.Application):
            return None

        return left.symbol, right.symbol
