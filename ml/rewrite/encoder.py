from typing import TextIO, Optional, Set, Union

from urllib.parse import quote_plus

from ml.kore import ast as kore
from ml.kore.ast import KoreVisitor
from ml.kore.utils import KoreUtils

from ml.metamath import ast as mm

"""
Encode a kore pattern as a Term and collect all metavariables
and constant symbols
"""


class KorePatternEncoder(KoreVisitor):
    TOP = "\\kore-top"
    BOTTOM = "\\kore-bottom"
    NOT = "\\kore-not"
    AND = "\\kore-and"
    OR = "\\kore-or"
    IMPLIES = "\\kore-implies"
    CEIL = "\\kore-ceil"
    FLOOR = "\\kore-floor"
    EQUALS = "\\kore-equals"
    IN = "\\kore-in"
    REWRITES = "\\kore-rewrites"
    REWRITES_STAR = "\\kore-rewrites-star"
    DV = "\\kore-dv"
    IS_SORT = "\\kore-is-sort"
    STRING = "\\kore-string"

    FORALL = "\\kore-forall"
    EXISTS = "\\kore-exists"
    FORALL_SORT = "\\kore-forall-sort"
    VALID = "\\kore-valid"

    LOGIC_CONSTRUCT_MAP = {
        kore.MLPattern.TOP: TOP,
        kore.MLPattern.BOTTOM: BOTTOM,
        kore.MLPattern.NOT: NOT,
        kore.MLPattern.AND: AND,
        kore.MLPattern.OR: OR,
        kore.MLPattern.IMPLIES: IMPLIES,
        kore.MLPattern.CEIL: CEIL,
        kore.MLPattern.FLOOR: FLOOR,
        kore.MLPattern.EQUALS: EQUALS,
        kore.MLPattern.IN: IN,
        kore.MLPattern.REWRITES: REWRITES,
        kore.MLPattern.REWRITES_STAR: REWRITES_STAR,
        kore.MLPattern.DV: DV,
        kore.MLPattern.FORALL: FORALL,
        kore.MLPattern.EXISTS: EXISTS,
    }

    @staticmethod
    def encode_symbol(symbol: Union[kore.SymbolInstance, str]) -> str:
        if isinstance(symbol, str):
            symbol_str = symbol
        elif isinstance(symbol.definition, str):
            symbol_str = symbol.definition
        else:
            symbol_str = symbol.definition.symbol

        if symbol_str == "inj":
            return "\\kore-inj"

        return "\\kore-symbol-" + symbol_str

    @staticmethod
    def encode_sort(sort: Union[kore.SortInstance, str]) -> str:
        if isinstance(sort, str):
            return "\\kore-sort-" + sort
        elif isinstance(sort.definition, str):
            return "\\kore-sort-" + sort.definition
        else:
            return "\\kore-sort-" + sort.definition.sort_id

    @staticmethod
    def encode_string_literal(literal: kore.StringLiteral) -> str:
        return '"' + quote_plus(literal.content) + '"'

    @staticmethod
    def encode_logical_construct(construct: str) -> str:
        return KorePatternEncoder.LOGIC_CONSTRUCT_MAP[construct]

    @staticmethod
    def encode_variable(var: kore.Variable) -> str:
        return "kore-element-var-" + var.name

    @staticmethod
    def encode_sort_variable(var: kore.SortVariable) -> str:
        return "kore-sort-var-" + var.name

    def __init__(self):
        self.metavariables = {}  # var -> typecode
        self.constant_symbols = {}  # symbol -> arity
        self.domain_values = set()  # set of (sort, string literal)

    def postvisit_axiom(self, axiom: kore.Axiom) -> mm.Term:
        term = self.visit(axiom.pattern)
        sort = KoreUtils.infer_sort(axiom.pattern)

        term = mm.Application(KorePatternEncoder.VALID, [self.visit(sort), term])

        for var in axiom.sort_variables[::-1]:
            var_term = self.visit(var)
            term = mm.Application(KorePatternEncoder.FORALL_SORT, [var_term, term])

        return term

    def postvisit_sort_instance(self, sort_instance: kore.SortInstance) -> mm.Term:
        encoded = KorePatternEncoder.encode_sort(sort_instance)
        self.constant_symbols[encoded] = len(sort_instance.arguments)
        return mm.Application(
            encoded, [self.visit(arg) for arg in sort_instance.arguments]
        )

    def postvisit_sort_variable(self, sort_variable: kore.SortVariable) -> mm.Term:
        encoded_var = KorePatternEncoder.encode_sort_variable(sort_variable)
        self.metavariables[encoded_var] = "#ElementVariable"
        return mm.Metavariable(encoded_var)

    def postvisit_variable(self, var: kore.Variable) -> mm.Term:
        encoded_var = KorePatternEncoder.encode_variable(var)
        assert not var.is_set_variable, "set variables are not supported"
        self.metavariables[encoded_var] = "#ElementVariable"
        return mm.Metavariable(encoded_var)

    def postvisit_string_literal(self, literal: kore.StringLiteral) -> mm.Term:
        encoded = KorePatternEncoder.encode_string_literal(literal)
        self.constant_symbols[encoded] = 0
        return mm.Application(encoded)

    def postvisit_application(self, application: kore.Application) -> mm.Term:
        constant_symbol = KorePatternEncoder.encode_symbol(application.symbol)
        self.constant_symbols[constant_symbol] = len(
            application.symbol.sort_arguments
        ) + len(application.arguments)
        return mm.Application(
            constant_symbol,
            [self.visit(sort_arg) for sort_arg in application.symbol.sort_arguments]
            + [self.visit(arg) for arg in application.arguments],
        )

    def postvisit_ml_pattern(self, ml_pattern: kore.MLPattern) -> mm.Term:
        encoded_construct = KorePatternEncoder.encode_logical_construct(
            ml_pattern.construct
        )

        if (
            ml_pattern.construct == kore.MLPattern.FORALL
            or ml_pattern.construct == kore.MLPattern.EXISTS
        ):
            var = ml_pattern.get_binding_variable()
            assert len(ml_pattern.arguments) == 2
            assert var is not None

            return mm.Application(
                encoded_construct,
                [
                    self.visit(var.sort),
                    self.visit(ml_pattern.sorts[0]),
                    self.visit(var),
                    self.visit(ml_pattern.arguments[1]),
                ],
            )

        else:
            if ml_pattern.construct == kore.MLPattern.DV:
                assert len(ml_pattern.sorts) == 1
                assert isinstance(ml_pattern.arguments[0], kore.StringLiteral)
                self.domain_values.add((ml_pattern.sorts[0], ml_pattern.arguments[0]))

            return mm.Application(
                encoded_construct,
                [self.visit(sort) for sort in ml_pattern.sorts]
                + [self.visit(arg) for arg in ml_pattern.arguments],
            )
