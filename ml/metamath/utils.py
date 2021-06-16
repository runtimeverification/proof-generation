from typing import Tuple, Sequence, Union, Optional

from .ast import *


class MetamathUtils:
    @staticmethod
    def construct_top() -> Term:
        return Application("\\top")

    @staticmethod
    def construct_bot() -> Term:
        return Application("\\bot")

    @staticmethod
    def construct_and(left: Term, right: Term) -> Term:
        return Application("\\and", (left, right))

    @staticmethod
    def construct_or(left: Term, right: Term) -> Term:
        return Application("\\or", (left, right))

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
    def construct_exists(var: Metavariable, term: Term) -> Term:
        return Application("\\exists", (var, term))

    @staticmethod
    def construct_mu(var: Metavariable, term: Term) -> Term:
        return Application("\\mu", (var, term))

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
    def construct_multi_and(terms: Sequence[Term]) -> Term:
        if len(terms) == 0:
            return MetamathUtils.construct_top()
        else:
            return MetamathUtils.construct_and(terms[0], MetamathUtils.construct_multi_and(terms[1:]))

    @staticmethod
    def construct_multi_or(terms: Sequence[Term]) -> Term:
        if len(terms) == 0:
            return MetamathUtils.construct_bot()
        else:
            return MetamathUtils.construct_or(terms[0], MetamathUtils.construct_multi_or(terms[1:]))

    @staticmethod
    def destruct_metamath_application(symbol: str, num_args: int, term: Term) -> Terms:
        assert isinstance(term, Application) and \
               MetamathUtils.is_application_of_symbol(symbol, num_args, term), \
               f"expecting {symbol}, got {term}"
        return term.subterms

    @staticmethod
    def destruct_is_predicate(term: Term) -> Terms:
        return MetamathUtils.destruct_metamath_application("\\is-predicate", 1, term)

    @staticmethod
    def destruct_kore_is_predicate(term: Term) -> Terms:
        return MetamathUtils.destruct_metamath_application("\\kore-is-predicate", 2, term)

    @staticmethod
    def destruct_kore_and(term: Term) -> Terms:
        return MetamathUtils.destruct_metamath_application("\\kore-and", 3, term)

    @staticmethod
    def destruct_kore_not(term: Term) -> Terms:
        return MetamathUtils.destruct_metamath_application("\\kore-not", 2, term)

    @staticmethod
    def destruct_kore_top(term: Term) -> Terms:
        return MetamathUtils.destruct_metamath_application("\\kore-top", 1, term)

    @staticmethod
    def destruct_kore_floor(term: Term) -> Terms:
        return MetamathUtils.destruct_metamath_application("\\kore-floor", 3, term)

    @staticmethod
    def destruct_floor(term: Term) -> Terms:
        return MetamathUtils.destruct_metamath_application("\\floor", 1, term)

    @staticmethod
    def destruct_imp(term: Term) -> Terms:
        return MetamathUtils.destruct_metamath_application("\\imp", 2, term)

    @staticmethod
    def destruct_app(term: Term) -> Terms:
        return MetamathUtils.destruct_metamath_application("\\app", 2, term)

    @staticmethod
    def destruct_and(term: Term) -> Terms:
        return MetamathUtils.destruct_metamath_application("\\and", 2, term)

    @staticmethod
    def destruct_eq(term: Term) -> Terms:
        return MetamathUtils.destruct_metamath_application("\\eq", 2, term)

    @staticmethod
    def destruct_exists(term: Term) -> Tuple[Metavariable, Term]:
        var, body = MetamathUtils.destruct_metamath_application("\\exists", 2, term)
        assert isinstance(var, Metavariable), \
               f"expecting {var} to be a metavariable"
        return var, body

    @staticmethod
    def destruct_mu(term: Term) -> Tuple[Metavariable, Term]:
        var, body = MetamathUtils.destruct_metamath_application("\\mu", 2, term)
        assert isinstance(var, Metavariable), \
               f"expecting {var} to be a metavariable"
        return var, body

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
    def is_fresh(terms: Terms) -> bool:
        return len(terms) == 3 and terms[0] == Application("#Fresh")

    @staticmethod
    def is_application_of_symbol(symbol: str, num_args: int, term: Term) -> bool:
        return isinstance(term, Application) and \
               term.symbol == symbol and \
               len(term.subterms) == num_args

    @staticmethod
    def is_top(term: Term) -> bool:
        return MetamathUtils.is_application_of_symbol("\\top", 0, term)

    @staticmethod
    def is_floor(term: Term) -> bool:
        return MetamathUtils.is_application_of_symbol("\\floor", 1, term)

    @staticmethod
    def is_is_predicate(term: Term) -> bool:
        return MetamathUtils.is_application_of_symbol("\\is-predicate", 1, term)

    @staticmethod
    def is_imp(term: Term) -> bool:
        return MetamathUtils.is_application_of_symbol("\\imp", 2, term)

    @staticmethod
    def is_kore_valid(term: Term) -> bool:
        return MetamathUtils.is_application_of_symbol("\\kore-valid", 2, term)

    @staticmethod
    def is_kore_and(term: Term) -> bool:
        return MetamathUtils.is_application_of_symbol("\\kore-and", 3, term)

    @staticmethod
    def is_kore_not(term: Term) -> bool:
        return MetamathUtils.is_application_of_symbol("\\kore-not", 2, term)

    @staticmethod
    def is_kore_top(term: Term) -> bool:
        return MetamathUtils.is_application_of_symbol("\\kore-top", 1, term)

    @staticmethod
    def is_kore_floor(term: Term) -> bool:
        return MetamathUtils.is_application_of_symbol("\\kore-floor", 3, term)

    @staticmethod
    def is_kore_is_sort(term: Term) -> bool:
        return MetamathUtils.is_application_of_symbol("\\kore-is-sort", 1, term)

    @staticmethod
    def is_kore_is_predicate(term: Term) -> bool:
        return MetamathUtils.is_application_of_symbol("\\kore-is-predicate", 2, term)

    @staticmethod
    def is_in_sort(term: Term) -> bool:
        return MetamathUtils.is_application_of_symbol("\\in-sort", 2, term)

    @staticmethod
    def is_exists(term: Term) -> bool:
        return MetamathUtils.is_application_of_symbol("\\exists", 2, term)

    @staticmethod
    def is_and(term: Term) -> bool:
        return MetamathUtils.is_application_of_symbol("\\and", 2, term)

    @staticmethod
    def is_mu(term: Term) -> bool:
        return MetamathUtils.is_application_of_symbol("\\mu", 2, term)

    @staticmethod
    def destruct_nested(symbol: str, term: Term) -> Tuple[Term, ...]:
        if isinstance(term, Application) and term.symbol == symbol:
            left, right = term.subterms
            return MetamathUtils.destruct_nested(symbol, left) + MetamathUtils.destruct_nested(symbol, right)
        else:
            return term,

    @staticmethod
    def destruct_nested_and(term: Term) -> Tuple[Term, ...]:
        return MetamathUtils.destruct_nested("\\and", term)

    @staticmethod
    def destruct_nested_or(term: Term) -> Tuple[Term, ...]:
        return MetamathUtils.destruct_nested("\\or", term)

    @staticmethod
    def destruct_premise(statement: Union[StructuredStatement, Terms], ) -> Tuple[Optional[Term], Term]:
        if isinstance(statement, StructuredStatement):
            statement = statement.terms

        body = MetamathUtils.destruct_provable(statement)

        if MetamathUtils.is_imp(body):
            premise, conclusion = MetamathUtils.destruct_imp(body)
            return premise, conclusion
        else:
            return None, body
