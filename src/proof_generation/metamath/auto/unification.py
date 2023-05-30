from __future__ import annotations

from typing import TYPE_CHECKING

from ..ast import Application, Metavariable

if TYPE_CHECKING:
    from collections.abc import Callable, Collection, Mapping
    from typing import Any

    from ..ast import StructuredStatement, Term


class Unification:
    @staticmethod
    def unify(
        equations: list[tuple[Term, Term]],
        variable_class: type[Metavariable] = Metavariable,
        variable_order: Callable[
            [Metavariable, Metavariable], bool
        ] = lambda v1, v2: True,  # returns True iff v1 <= v2, False otherwise
        # allow user to supply extra unifiction rules
        additional_unifier: Callable[[Term, Term], list[tuple[Term, Term]] | None] | None = None,
    ) -> Mapping[str, Term] | None:
        """
        Try to solve the given unification problem,
        treating only <variable> as variables (this is primarily for the purpose of extending the AST)
        """
        substitution = {}

        while len(equations):
            left, right = equations.pop()
            if left == right:
                continue

            # unifying applications
            if not isinstance(left, variable_class) and not isinstance(right, variable_class):
                if not isinstance(left, Application) or not isinstance(right, Application):
                    # we are not supposed to substitute any non-schematic metavariables
                    return None

                if left.symbol != right.symbol:
                    # unable to unify the head,
                    # try additional unification algorithm
                    # if available

                    if additional_unifier is None:
                        return None

                    subequations = additional_unifier(left, right)
                    if subequations is None:
                        return None

                    equations.extend(subequations)
                else:
                    if len(left.subterms) != len(right.subterms):
                        return None

                    equations.extend(zip(left.subterms, right.subterms, strict=True))

            elif isinstance(left, variable_class):
                # check for recursive equations
                if left.name in right.get_metavariables():
                    return None

                # if both are variables, potentially switch them to
                # make sure left <= right in some given ordering
                if isinstance(right, variable_class) and not variable_order(left, right):
                    left, right = right, left

                substitution[left.name] = right

                replace = {left.name: right}

                for i, (left, right) in enumerate(equations):
                    equations[i] = left.substitute(replace), right.substitute(replace)

                substitution = {var: term.substitute(replace) for var, term in substitution.items()}

            else:
                assert isinstance(right, variable_class)
                equations.append((right, left))

        return substitution

    @staticmethod
    def unify_terms(term1: Term, term2: Term, **kwargs: Any) -> Mapping[str, Term] | None:
        return Unification.unify([(term1, term2)], **kwargs)

    @staticmethod
    def unify_statements(
        stmt1: StructuredStatement, stmt2: StructuredStatement, **kwargs: Any
    ) -> Mapping[str, Term] | None:
        if len(stmt1.terms) != len(stmt2.terms):
            return None
        return Unification.unify(list(zip(stmt1.terms, stmt2.terms, strict=True)), **kwargs)

    @staticmethod
    def match_terms(term1: Term, term2: Term) -> list[tuple[Term, Term]] | None:
        """
        Attempts to match the terms by paring up subterms in the same position
        NOTE: this does not check the consistency of the resulting substitution
        """
        if isinstance(term1, Application) and isinstance(term2, Application):
            if term1.symbol == term2.symbol and len(term1.subterms) == len(term2.subterms):
                matching = []
                for subterm1, subterm2 in zip(term1.subterms, term2.subterms, strict=True):
                    submatching = Unification.match_terms(subterm1, subterm2)
                    if submatching is None:
                        return None

                    matching.extend(submatching)
                return matching
            else:
                return None
        elif isinstance(term1, Metavariable) or isinstance(term2, Metavariable):
            return [(term1, term2)]
        else:
            return None

    @staticmethod
    def match_lists_of_terms(terms1: Collection[Term], terms2: Collection[Term]) -> list[tuple[Term, Term]] | None:
        matching = []

        if len(terms1) != len(terms2):
            return None

        for term1, term2 in zip(terms1, terms2, strict=True):
            submatching = Unification.match_terms(term1, term2)
            if submatching is None:
                return None

            matching.extend(submatching)

        return matching

    @staticmethod
    def match_statements(stmt1: StructuredStatement, stmt2: StructuredStatement) -> list[tuple[Term, Term]] | None:
        """
        Attempt to match two statements
        NOTE: this does not check the consistency of the resulting substitution
        but only returns a list of equations that should hold if the two statements
        are unifiable
        """
        return Unification.match_lists_of_terms(stmt1.terms, stmt2.terms)

    @staticmethod
    def match_terms_as_instance(term1: Term, term2: Term) -> Mapping[str, Term] | None:
        """
        Check if term2 is an instance of term1, that is, if
        there is a substitution sigma such that term1[sigma] = term2
        NOTE: note that term1 and term2 may not be unifiable
        but term2 could still be an instance of term1
        """
        solution = Unification.match_terms(term1, term2)
        if solution is None:
            return None
        return Unification.get_instance_substitution(solution)

    @staticmethod
    def match_lists_of_terms_as_instance(
        terms1: Collection[Term], terms2: Collection[Term]
    ) -> Mapping[str, Term] | None:
        solution = Unification.match_lists_of_terms(terms1, terms2)
        if solution is None:
            return None
        return Unification.get_instance_substitution(solution)

    @staticmethod
    def match_statements_as_instance(
        stmt1: StructuredStatement, stmt2: StructuredStatement
    ) -> Mapping[str, Term] | None:
        """
        Same as above but for statements
        """
        solution = Unification.match_statements(stmt1, stmt2)
        if solution is None:
            return None
        return Unification.get_instance_substitution(solution)

    @staticmethod
    def get_instance_substitution(matching: list[tuple[Term, Term]]) -> Mapping[str, Term] | None:
        substitution: dict[str, Term] = {}

        for lhs, rhs in matching:
            if not isinstance(lhs, Metavariable):
                return None

            if lhs.name in substitution:
                if substitution[lhs.name] == rhs:
                    continue
                else:
                    return None

            substitution[lhs.name] = rhs

        return substitution
