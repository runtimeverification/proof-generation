from typing import Optional

from ..ast import Metavariable, Term, Statement, Application, StructuredStatement
from ..visitors import SubstitutionVisitor

from .unification import Unification


class TypecodeProver:
    # TODO: this is a bit too casual
    cache = {} # (typecode, Term) -> proof

    """
    Try to prove a statement of the form
    <typecode> <term>
    by recursively unify the target with a theorem of this form
    """
    @staticmethod
    def prove_typecode(composer, typecode: str, term: Term):
        if (typecode, term) in TypecodeProver.cache:
            return TypecodeProver.cache[typecode, term]

        # try to find a matching floating statement first if the term is a metavariable
        if isinstance(term, Metavariable):
            for _, theorem in composer.theorems.items():
                if theorem.statement.statement_type == Statement.FLOATING:
                    other_typecode, metavar = theorem.statement.terms

                    if other_typecode.symbol == typecode and metavar.name == term.name:
                        # found a direct proof
                        proof = theorem.apply()
                        TypecodeProver.cache[typecode, term] = proof
                        return proof
            # otherwise treat the metavariable as a term

        expected_statement = StructuredStatement(Statement.PROVABLE, [ Application(typecode), term ])

        # TODO: check if this may loop infinitely

        # try to find a non-floating statement without hypotheses and unify
        for _, theorem in composer.theorems.items():
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
                    TypecodeProver.cache[typecode, term] = proof
                    return proof

        return None
