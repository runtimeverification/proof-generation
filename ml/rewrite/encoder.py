from typing import TextIO, Optional, Set, Union, Dict, Tuple, Any

from urllib.parse import quote_plus, unquote_plus

from ml.kore import ast as kore
from ml.kore.ast import KoreVisitor
from ml.kore.utils import KoreUtils

from ml.metamath import ast as mm
from ml.metamath.ast import MetamathVisitor
from ml.metamath.utils import MetamathUtils


class KoreEncoder(KoreVisitor[kore.BaseAST[Any], mm.Term]):
    """
    Encode a kore pattern as a Term and collect all metavariables
    and constant symbols
    """

    KORE_SYMBOL_PREFIX = "\\kore-symbol-"
    KORE_SORT_PREFIX = "\\kore-sort-"
    KORE_ELEMENT_VAR_PREFIX = "kore-element-var-"
    KORE_SORT_VAR_PREFIX = "kore-sort-var-"

    TOP = "\\kore-top"
    BOTTOM = "\\kore-bottom"
    NOT = "\\kore-not"
    AND = "\\kore-and"
    OR = "\\kore-or"
    IMPLIES = "\\kore-implies"
    IFF = "\\kore-iff"
    CEIL = "\\kore-ceil"
    FLOOR = "\\kore-floor"
    EQUALS = "\\kore-equals"
    IN = "\\kore-in"
    ALWAYS = "\\kore-always"
    CIRCULARITY = "\\kore-circularity"
    WELL_FOUNDED = "\\kore-well-founded"
    REWRITES = "\\kore-rewrites"
    REWRITES_STAR = "\\kore-rewrites-star"
    REWRITES_PLUS = "\\kore-rewrites-plus"
    ONE_PATH_REACHES_STAR = "\\kore-one-path-reaches-star"
    ONE_PATH_REACHES_PLUS = "\\kore-one-path-reaches-plus"
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
        kore.MLPattern.IFF: IFF,
        kore.MLPattern.CEIL: CEIL,
        kore.MLPattern.FLOOR: FLOOR,
        kore.MLPattern.EQUALS: EQUALS,
        kore.MLPattern.IN: IN,
        kore.MLPattern.ALWAYS: ALWAYS,
        kore.MLPattern.CIRCULARITY: CIRCULARITY,
        kore.MLPattern.WELL_FOUNDED: WELL_FOUNDED,
        kore.MLPattern.REWRITES: REWRITES,
        kore.MLPattern.REWRITES_STAR: REWRITES_STAR,
        kore.MLPattern.REWRITES_PLUS: REWRITES_PLUS,
        kore.MLPattern.ONE_PATH_REACHES_STAR: ONE_PATH_REACHES_STAR,
        kore.MLPattern.ONE_PATH_REACHES_PLUS: ONE_PATH_REACHES_PLUS,
        kore.MLPattern.DV: DV,
        kore.MLPattern.FORALL: FORALL,
        kore.MLPattern.EXISTS: EXISTS,
    }

    INVERSE_LOGIC_CONSTRUCT_MAP = {v: k for k, v in LOGIC_CONSTRUCT_MAP.items()}

    @staticmethod
    def encode_symbol(symbol: Union[kore.SymbolInstance, str]) -> str:
        if isinstance(symbol, str):
            symbol_str = symbol
        else:
            symbol_str = symbol.get_symbol_name()

        if symbol_str == "inj":
            return "\\kore-inj"

        return KoreEncoder.KORE_SYMBOL_PREFIX + symbol_str

    @staticmethod
    def encode_sort(sort: Union[kore.SortInstance, str]) -> str:
        if isinstance(sort, str):
            sort_id = sort
        else:
            sort_id = sort.get_sort_id()

        if sort_id == "Unit":
            return "\\unit-sort"

        return KoreEncoder.KORE_SORT_PREFIX + sort_id

    @staticmethod
    def encode_string_literal(literal: kore.StringLiteral) -> str:
        return '"' + quote_plus(literal.content) + '"'

    @staticmethod
    def encode_logical_construct(construct: str) -> str:
        return KoreEncoder.LOGIC_CONSTRUCT_MAP[construct]

    @staticmethod
    def encode_variable(var: kore.Variable) -> str:
        return KoreEncoder.KORE_ELEMENT_VAR_PREFIX + var.name

    @staticmethod
    def encode_sort_variable(var: kore.SortVariable) -> str:
        return KoreEncoder.KORE_SORT_VAR_PREFIX + var.name

    def __init__(self) -> None:
        self.metavariables: Dict[str, str] = {}  # var -> typecode
        self.constant_symbols: Dict[str, int] = {}  # symbol -> arity
        self.domain_values: Set[Tuple[kore.SortInstance, kore.StringLiteral]] = set()  # set of (sort, string literal)

    def encode_free_variable_premise(self, ast: Union[kore.Axiom, kore.Pattern]) -> mm.Term:
        premise = MetamathUtils.construct_top()

        free_vars = list(KoreUtils.get_free_variables(ast))
        free_vars.sort(key=lambda var: var.name, reverse=True)

        free_sort_vars = list(KoreUtils.get_free_sort_variables(ast))
        free_sort_vars.sort(key=lambda var: var.name, reverse=True)

        # add sorting hypotheses for all free variables
        for var in free_vars:
            encoded_var = self.visit(var)
            encoded_sort = self.visit(var.sort)
            premise = MetamathUtils.construct_and(
                MetamathUtils.construct_in_sort(encoded_var, encoded_sort),
                premise,
            )

        # add sorting hypotheses for all sort variables
        for sort_var in free_sort_vars:
            encoded_sort_var = self.visit(sort_var)
            premise = MetamathUtils.construct_and(
                MetamathUtils.construct_kore_is_sort(encoded_sort_var),
                premise,
            )

        return premise

    def postvisit_axiom(self, axiom: kore.Axiom) -> mm.Term:
        body = self.visit(axiom.pattern)
        sort = KoreUtils.infer_sort(axiom.pattern)
        encoded_sort = self.visit(sort)

        body = mm.Application(KoreEncoder.VALID, (encoded_sort, body))
        premise = self.encode_free_variable_premise(axiom)

        return MetamathUtils.construct_imp(premise, body)

    def postvisit_sort_instance(self, sort_instance: kore.SortInstance) -> mm.Term:
        encoded = KoreEncoder.encode_sort(sort_instance)
        self.constant_symbols[encoded] = len(sort_instance.arguments)
        return mm.Application(encoded, tuple(self.visit(arg) for arg in sort_instance.arguments))

    def postvisit_sort_variable(self, sort_variable: kore.SortVariable) -> mm.Term:
        encoded_var = KoreEncoder.encode_sort_variable(sort_variable)
        self.metavariables[encoded_var] = "#ElementVariable"
        return mm.Metavariable(encoded_var)

    def postvisit_variable(self, var: kore.Variable) -> mm.Term:
        encoded_var = KoreEncoder.encode_variable(var)
        # assert not var.is_set_variable, f"set variables are not supported: {var}"
        self.metavariables[encoded_var] = "#ElementVariable" if not var.is_set_variable else "#SetVariable"
        return mm.Metavariable(encoded_var)

    def postvisit_string_literal(self, literal: kore.StringLiteral) -> mm.Term:
        encoded = KoreEncoder.encode_string_literal(literal)
        self.constant_symbols[encoded] = 0
        return mm.Application(encoded)

    def postvisit_application(self, application: kore.Application) -> mm.Term:
        constant_symbol = KoreEncoder.encode_symbol(application.symbol)
        self.constant_symbols[constant_symbol] = len(application.symbol.sort_arguments) + len(application.arguments)
        return mm.Application(
            constant_symbol,
            tuple(self.visit(sort_arg) for sort_arg in application.symbol.sort_arguments) +
            tuple(self.visit(arg) for arg in application.arguments),
        )

    def postvisit_ml_pattern(self, ml_pattern: kore.MLPattern) -> mm.Term:
        encoded_construct = KoreEncoder.encode_logical_construct(ml_pattern.construct)

        if (ml_pattern.construct == kore.MLPattern.FORALL or ml_pattern.construct == kore.MLPattern.EXISTS):
            var = ml_pattern.get_binding_variable()
            assert len(ml_pattern.arguments) == 2
            assert var is not None

            return mm.Application(
                encoded_construct,
                (
                    self.visit(var.sort),
                    self.visit(ml_pattern.sorts[0]),
                    self.visit(var),
                    self.visit(ml_pattern.arguments[1]),
                ),
            )

        else:
            if ml_pattern.construct == kore.MLPattern.DV:
                assert len(ml_pattern.sorts) == 1
                assert isinstance(ml_pattern.sorts[0], kore.SortInstance)
                assert isinstance(ml_pattern.arguments[0], kore.StringLiteral)
                self.domain_values.add((ml_pattern.sorts[0], ml_pattern.arguments[0]))

            return mm.Application(
                encoded_construct,
                tuple(self.visit(sort)
                      for sort in ml_pattern.sorts) + tuple(self.visit(arg) for arg in ml_pattern.arguments),
            )


class KoreDecoder:
    """
    Decode the result of KoreEncoder
    Works only on applications and structured statements
    """
    def __init__(self, module: kore.Module):
        self.module = module

    def decode_claim(self, term_or_statement: Union[mm.Term, mm.StructuredStatement]) -> kore.Claim:
        if isinstance(term_or_statement, mm.StructuredStatement):
            term = MetamathUtils.destruct_provable(term_or_statement.terms)
        else:
            term = term_or_statement

        if MetamathUtils.is_imp(term):
            _, term = MetamathUtils.destruct_imp(term)

        assert isinstance(term, mm.Application) and \
               MetamathUtils.is_kore_valid(term), \
               f"unable to decode {term} as a claim"

        sort = self.decode_sort(term.subterms[0])
        body = self.decode_pattern(term.subterms[1], sort)

        # find all free sort variables
        sort_vars = KoreUtils.get_free_sort_variables(body)

        claim = kore.Claim(list(sort_vars), body)
        claim.resolve(self.module)

        return claim

    def decode_pattern(self, term: mm.Term, sort: Optional[kore.Sort] = None) -> kore.Pattern:
        if isinstance(term, mm.Metavariable):
            assert sort is not None, \
                   f"unable to decode {term} as a pattern variable without sorting information"
            assert term.name.startswith(KoreEncoder.KORE_ELEMENT_VAR_PREFIX), \
                   f"unable to decode {term} as a pattern variable"
            return kore.Variable(term.name[len(KoreEncoder.KORE_ELEMENT_VAR_PREFIX):], sort)

        assert isinstance(term, mm.Application)

        if term.symbol.startswith(KoreEncoder.KORE_SYMBOL_PREFIX):
            symbol_name = term.symbol[len(KoreEncoder.KORE_SYMBOL_PREFIX):]
            symbol_definition = self.module.get_symbol_by_name(symbol_name)

            assert symbol_definition is not None, \
                   f"unable to decode {term} as a pattern: symbol {symbol_name} not found in module {self.module.name}"

            arity = len(symbol_definition.sort_variables) + len(symbol_definition.input_sorts)
            assert len(term.subterms) == arity, \
                   f"unable to decode {term} as a pattern: unmatched arity"

            sort_subterms = term.subterms[:len(symbol_definition.sort_variables)]
            pattern_subterms = term.subterms[len(symbol_definition.sort_variables):]

            sort_arguments = [self.decode_sort(subterm) for subterm in sort_subterms]
            pattern_arguments = [
                self.decode_pattern(subterm, sort)
                for subterm, sort in zip(pattern_subterms, symbol_definition.input_sorts)
            ]

            return kore.Application(
                kore.SymbolInstance(symbol_definition, sort_arguments),
                pattern_arguments,
            )

        elif term.symbol in KoreEncoder.INVERSE_LOGIC_CONSTRUCT_MAP:
            kore_construct = KoreEncoder.INVERSE_LOGIC_CONSTRUCT_MAP[term.symbol]

            num_sort_arguments = kore.MLPattern.get_number_of_sort_arguments_for_construct(kore_construct)
            num_arguments = kore.MLPattern.get_number_of_arguments_for_construct(kore_construct)

            if kore.MLPattern.is_binder_construct(kore_construct):
                # <variable sort> <body sort> <variable> <body>
                assert len(term.subterms) == 4, \
                       f"unable to decode {term} as pattern: unexpected number of arguments"

                binder_var_sort = self.decode_sort(term.subterms[0])
                body_sort = self.decode_sort(term.subterms[1])
                variable = self.decode_pattern(term.subterms[2], binder_var_sort)
                body = self.decode_pattern(term.subterms[3], body_sort)

                return kore.MLPattern(kore_construct, [body_sort], [variable, body])
            else:
                assert len(term.subterms) == num_sort_arguments + num_arguments, \
                       f"unable to decode {term} as pattern: unexpected number of arguments"

                sort_arguments = [self.decode_sort(subterm) for subterm in term.subterms[:num_sort_arguments]]
                assert len(sort_arguments) != 0

                argument_sort = sort_arguments[0]
                pattern_arguments = [
                    self.decode_pattern(subterm, argument_sort) for subterm in term.subterms[num_sort_arguments:]
                ]

                return kore.MLPattern(kore_construct, sort_arguments, pattern_arguments)

        elif term.symbol == "\\kore-inj":
            inj_definition = self.module.get_symbol_by_name("inj")
            assert inj_definition is not None, \
                   f"module {self.module.name} have not defined an injection symbol"

            assert len(term.subterms) == 3, \
                   f"unable to decode {term} as pattern: unexpected number of arguments"

            sort1, sort2 = self.decode_sort(term.subterms[0]), self.decode_sort(term.subterms[1])
            argument = self.decode_pattern(term.subterms[2], sort1)

            return kore.Application(
                kore.SymbolInstance(inj_definition, [sort1, sort2]),
                [argument],
            )

        elif term.symbol.startswith('"') and term.symbol.endswith('"'):
            value = unquote_plus(term.symbol[1:-1])
            return kore.StringLiteral(value)

        else:
            assert False, f"unable to decode {term} as pattern"

    def decode_sort(self, term: mm.Term) -> kore.Sort:
        if isinstance(term, mm.Metavariable):
            assert term.name.startswith(KoreEncoder.KORE_SORT_VAR_PREFIX), \
                   f"unable to decode {term} as a sort"
            return kore.SortVariable(term.name[len(KoreEncoder.KORE_SORT_VAR_PREFIX):])

        assert isinstance(term, mm.Application)

        if term.symbol == "\\unit-sort":
            sort_id = "Unit"
        else:
            assert term.symbol.startswith(KoreEncoder.KORE_SORT_PREFIX), \
                    f"unable to decode {term} as a sort"
            sort_id = term.symbol[len(KoreEncoder.KORE_SORT_PREFIX):]

        sort_definition = self.module.get_sort_by_id(sort_id)
        assert sort_definition is not None, \
               f"unable to decode {term} as a sort: sort {sort_id} does not exist in module {self.module.name}"

        assert len(term.subterms) == len(sort_definition.sort_variables), \
               f"unable to decode {term} as a sort: unmatched number of arguments"

        sort_arguments = [self.decode_sort(subterm) for subterm in term.subterms]

        return kore.SortInstance(sort_definition, sort_arguments)
