from typing import Tuple

from .ast import *


class MetamathUtils:
    @staticmethod
    def construct_top() -> Term:
        return Application("\\top")

    @staticmethod
    def construct_and(left: Term, right: Term) -> Term:
        return Application("\\and", (left, right))

    @staticmethod
    def construct_imp(left: Term, right: Term) -> Term:
        return Application("\\imp", (left, right))

    @staticmethod
    def construct_in_sort(term: Term, sort: Term) -> Term:
        return Application("\\in-sort", (term, sort))

    @staticmethod
    def construct_kore_is_sort(term: Term) -> Term:
        return Application("\\kore-is-sort", (term, ))

    @staticmethod
    def construct_forall_sort(var: Term, body: Term) -> Term:
        assert isinstance(var, Metavariable)
        return Application("\\forall-sort", (var, body))

    @staticmethod
    def construct_provable(term: Term) -> Terms:
        return (Application("|-"), term)

    @staticmethod
    def construct_substitution(after: Term, before: Term, substitute: Term, variable: Term) -> Terms:
        assert isinstance(variable, Metavariable)
        return (
            Application("#Substitution"),
            after,
            before,
            substitute,
            variable,
        )

    @staticmethod
    def destruct_metamath_application(symbol: str, num_args: int, term: Term) -> Terms:
        assert isinstance(term, Application) and \
               MetamathUtils.is_application_of_symbol(symbol, num_args, term), \
               f"expecting {symbol}, got {term}"
        return term.subterms

    @staticmethod
    def destruct_imp(term: Term) -> Terms:
        return MetamathUtils.destruct_metamath_application("\\imp", 2, term)

    @staticmethod
    def destruct_and(term: Term) -> Terms:
        return MetamathUtils.destruct_metamath_application("\\and", 2, term)

    @staticmethod
    def destruct_provable(terms: Terms) -> Term:
        assert len(terms) == 2 and \
               terms[0] == Application("|-"), \
               f"{terms} is not a provable claim"
        return terms[1]

    @staticmethod
    def is_provable(terms: Terms) -> bool:
        return len(terms) == 2 and terms[0] == Application("|-")

    @staticmethod
    def is_substitution(terms: Terms) -> bool:
        return len(terms) == 5 and terms[0] == Application("#Substitution")

    @staticmethod
    def is_application_of_symbol(symbol: str, num_args: int, term: Term) -> bool:
        return isinstance(term, Application) and \
               term.symbol == symbol and \
               len(term.subterms) == num_args

    @staticmethod
    def is_top(term: Term) -> bool:
        return MetamathUtils.is_application_of_symbol("\\top", 0, term)

    @staticmethod
    def is_imp(term: Term) -> bool:
        return MetamathUtils.is_application_of_symbol("\\imp", 2, term)

    @staticmethod
    def is_kore_valid(term: Term) -> bool:
        return MetamathUtils.is_application_of_symbol("\\kore-valid", 2, term)

    @staticmethod
    def is_in_sort(term: Term) -> bool:
        return MetamathUtils.is_application_of_symbol("\\kore-valid", 2, term)
