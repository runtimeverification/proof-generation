from __future__ import annotations

from typing import Optional, Callable

from ..ast import *
from ..composer import Composer, Proof
from ..utils import MetamathUtils

from .unification import Unification
from .positive import PositiveProver

import ml.metamath.auto as auto


class TypecodeProver:
    @staticmethod
    def check_typecode(
        composer: Composer,
        typecode: str,
        term: Term,
        # allow extra typecode check
        extension: Optional[Callable[[str, Term], bool]] = None,
    ) -> bool:
        """
        Check if the term can be proven to have the given typecode,
        without producing any proof
        """
        # try to find a matching floating statement first if the term is a metavariable
        if isinstance(term, Metavariable):
            for theorem in composer.get_theorems_of_typecode(typecode):
                if isinstance(theorem.statement, FloatingStatement):
                    _, metavar = theorem.statement.terms
                    assert isinstance(metavar, Metavariable)

                    if metavar.name == term.name:
                        return True
            # otherwise treat the metavariable as a term

        # try to find a non-floating statement without hypotheses and unify
        for theorem in composer.get_theorems_of_typecode(typecode):
            if (len(theorem.context.essentials) <= 1 and not isinstance(theorem.statement, FloatingStatement)
                    and len(theorem.statement.terms) == 2):
                # check that expected_statement is an instance of theorem.statement
                solution = Unification.match_terms_as_instance(theorem.statement.terms[1], term)
                if solution is None:
                    continue

                for floating in theorem.context.floatings:
                    if not TypecodeProver.check_typecode(composer, floating.typecode, solution[floating.metavariable],
                                                         extension=extension):
                        break
                else:
                    return True

        if extension is not None:
            return extension(typecode, term)

        return False

    @staticmethod
    def prove_typecode(composer: Composer, typecode: str, term: Term) -> Optional[Proof]:
        """
        Try to prove a statement of the form
        <typecode> <term>
        by recursively unify the target with a theorem of this form
        """

        # TODO: these checks are a bit too specialized
        if (typecode == "#Variable" or typecode == "#ElementVariable"
                or typecode == "#SetVariable") and not isinstance(term, Metavariable):
            return None

        if typecode == "#Symbol" and (not isinstance(term, Application) or len(term.subterms) != 0):
            return None

        expected_statement = ProvableStatement("", (Application(typecode), term))

        cached_proof = composer.lookup_proof_cache("typecode-cache-" + typecode, expected_statement.terms)
        if cached_proof is not None:
            return cached_proof

        # try to find a matching floating statement first if the term is a metavariable
        if isinstance(term, Metavariable):
            for theorem in composer.get_theorems_of_typecode(typecode):
                if isinstance(theorem.statement, FloatingStatement):
                    _, metavar = theorem.statement.terms
                    assert isinstance(metavar, Metavariable)

                    if metavar.name == term.name:
                        # found a direct proof
                        proof = Proof.from_script(expected_statement, theorem.statement.label)
                        return composer.cache_proof("typecode-cache-" + typecode, proof)
            # otherwise treat the metavariable as a term

        # TODO: check if this may loop infinitely

        # try to find a non-floating statement without hypotheses and unify
        for theorem in composer.get_theorems_of_typecode(typecode):
            if (len(theorem.context.essentials) <= 1 and not isinstance(theorem.statement, FloatingStatement)
                    and len(theorem.statement.terms) == 2):
                # check that expected_statement is an instance of theorem.statement
                solution = Unification.match_terms_as_instance(theorem.statement.terms[1], term)
                if solution is None:
                    continue

                essential_proof = None

                # try to find an exact essential that matches the hypotheses
                if len(theorem.context.essentials):
                    hypothesis = theorem.context.essentials[0].substitute(solution)
                    for essential in composer.get_all_essentials():
                        if hypothesis.terms == essential.statement.terms:
                            essential_proof = essential.apply()
                            break
                    else:
                        if len(hypothesis.terms) == 3 and \
                           (hypothesis.terms[0] == Application("#Positive") or
                            hypothesis.terms[0] == Application("#Negative")):
                            essential_proof = PositiveProver.prove_statement(composer, hypothesis)

                # try to recursively prove that each of the subterms in the solution
                # also have the suitable typecode
                subproofs = []
                failed = False

                for floating in theorem.context.floatings:
                    assert (
                        floating.metavariable in solution
                    ), f"unable to determine metavarible {floating.metavariable} in theorem {theorem.statement}"

                    metavar_proof = TypecodeProver.prove_typecode(
                        composer, floating.typecode, solution[floating.metavariable]
                    )
                    if metavar_proof is None:
                        failed = True
                        break

                    subproofs.append(metavar_proof)

                if essential_proof is not None:
                    subproofs.append(essential_proof)

                # found a proof
                if not failed:
                    # directly construct the proof here for performance
                    assert theorem.statement.label is not None
                    proof = Proof.from_application(expected_statement, theorem.statement.label, subproofs)
                    return composer.cache_proof("typecode-cache-" + typecode, proof)

        return None
