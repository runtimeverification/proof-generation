from typing import Optional

from ..ast import Metavariable, Term, Statement, Application, StructuredStatement

from .unification import Unification


class TypecodeProver:
    """
    Try to prove a statement of the form
    <typecode> <term>
    by recursively unify the target with a theorem of this form
    """
    @staticmethod
    def prove_typecode(composer, typecode: str, term: Term):
        # try to find a matching floating statement first if the term is a metavariable
        if isinstance(term, Metavariable):
            for _, theorem in composer.theorems.items():
                if theorem.statement.statement_type == Statement.FLOATING:
                    other_typecode, metavar = theorem.statement.terms

                    if other_typecode.symbol == typecode and metavar.name == term.name:
                        # found a direct proof
                        return theorem.apply()
            # otherwise treat the metavariable as a term

        expected_statement = StructuredStatement(Statement.PROVABLE, [ Application(typecode), term ])

        # TODO: check if this may loop infinitely

        # try to find a non-floating statement without hypotheses and unify
        for _, theorem in composer.theorems.items():
            if len(theorem.essentials) == 0 and theorem.statement.statement_type != Statement.FLOATING:
                # check that expected_statement is an instance of theorem.statement
                solution = Unification.match_statements_as_instance(theorem.statement, expected_statement)

                if solution is None:
                    continue

                # print("try to apply", theorem.statement, "to", expected_statement)
                
                # try to recursively prove that each of the subterms in the solution
                # also have the suitable typecode
                meta_subst = {}
                failed = False

                for metavar, subterm in solution.items():
                    # find out the expected typecode for <metavar>
                    for expected_typecode, other_metavar in theorem.floatings:
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
                    return theorem.apply(**meta_subst)
        
        return None
