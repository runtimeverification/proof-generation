from typing import Optional

from ..ast import Metavariable, Term, Statement, Application, StructuredStatement
from ..visitors import SubstitutionVisitor

from .unification import Unification


class TypecodeProver:
    """
    Try to prove a statement of the form
    <typecode> <term>
    by recursively unify the target with a theorem of this form
    """
    @staticmethod
    def prove_typecode(composer, typecode: str, term: Term):
        # don't cache metavariable statements
        # otherwise it may be caught in infinite recursion in the proof cache
        if not isinstance(term, Metavariable):
            cached_proof = composer.lookup_proof_cache([ Application(typecode), term ])

            if cached_proof is not None:
                return cached_proof

        # try to find a matching floating statement first if the term is a metavariable
        if isinstance(term, Metavariable):
            for theorem in composer.get_theorems_of_typecode(typecode):
                if theorem.statement.statement_type == Statement.FLOATING:
                    _, metavar = theorem.statement.terms

                    if metavar.name == term.name:
                        # found a direct proof
                        proof = theorem.apply()
                        if not isinstance(term, Metavariable):
                            proof = composer.cache_proof("typecode-cache", proof)
                        return proof
            # otherwise treat the metavariable as a term

        expected_statement = StructuredStatement(Statement.PROVABLE, [ Application(typecode), term ])

        # TODO: check if this may loop infinitely

        # try to find a non-floating statement without hypotheses and unify
        for theorem in composer.get_theorems_of_typecode(typecode):
            if len(theorem.essentials) <= 1 and theorem.statement.statement_type != Statement.FLOATING:
                # check that expected_statement is an instance of theorem.statement
                solution = Unification.match_statements_as_instance(theorem.statement, expected_statement)

                if solution is None:
                    continue

                subproofs = []

                # try to find an exact essential that matches the hypotheses
                if len(theorem.essentials):
                    hypothesis = SubstitutionVisitor(solution).visit(theorem.essentials[0])
                    for essential in composer.get_all_essentials():
                        if hypothesis.terms == essential.statement.terms:
                            subproofs.append(essential.apply())
                            break
                    else:
                        continue

                # print("try to apply", theorem.statement, "to", expected_statement)
                
                # try to recursively prove that each of the subterms in the solution
                # also have the suitable typecode
                meta_subst = {}
                failed = False

                for metavar, subterm in solution.items():
                    # find out the expected typecode for <metavar>
                    for expected_typecode, other_metavar, _ in theorem.floatings:
                        if other_metavar == metavar:
                            break
                    else:
                        assert False, "unable to find metavarible {} in theorem {}".format(metavar, theorem)

                    subproof = TypecodeProver.prove_typecode(composer, expected_typecode, subterm)
                    if subproof is None:
                        # print("failed to prove", expected_typecode, subterm)
                        failed = True
                        break

                    meta_subst[metavar] = subproof

                # found a proof
                if not failed:
                    proof = theorem.apply(*subproofs, **meta_subst)
                    if not isinstance(term, Metavariable):
                        proof = composer.cache_proof("typecode-cache", proof)
                    return proof

        return None
