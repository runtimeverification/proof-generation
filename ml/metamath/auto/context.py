from typing import List, Optional

from ..ast import Metavariable, Term, Application, ProvableStatement, StructuredStatement
from ..composer import Composer, Theorem, MethodAutoProof, Proof

from .notation import NotationProver


class ApplicationContextProver:
    """
    An automated prover for statements of the form
    #ApplicationContext x ph0
    """
    @staticmethod
    def get_target(var: Metavariable, pattern: Term) -> StructuredStatement:
        return ProvableStatement("", (Application("#ApplicationContext"), var, pattern))

    @staticmethod
    def flatten_application(pattern: Term) -> List[Term]:
        if not isinstance(pattern, Application) or pattern.symbol != "\\app":
            return [pattern]

        assert len(pattern.subterms) == 2
        return ApplicationContextProver.flatten_application(
            pattern.subterms[0]
        ) + ApplicationContextProver.flatten_application(pattern.subterms[1])

    @staticmethod
    def prove_application_context_desugared(
        composer: Composer,
        var: Metavariable,
        pattern: Term,
        hypotheses: List[Theorem] = [],
    ) -> Proof:
        target = ApplicationContextProver.get_target(var, pattern)

        if isinstance(pattern, Metavariable):
            if var == pattern:
                return composer.get_theorem("application-context-var").match_and_apply(target)

            for hypothesis in hypotheses:
                if target.terms == hypothesis.statement.terms:
                    return hypothesis.apply()

        elif isinstance(pattern, Application) and pattern.symbol == "\\app":
            assert len(pattern.subterms) == 2

            left_arguments = ApplicationContextProver.flatten_application(pattern.subterms[0])
            right_arguments = ApplicationContextProver.flatten_application(pattern.subterms[1])

            known_context: List[Term] = [var]
            for hypothesis in hypotheses:
                if (len(hypothesis.statement.terms) == 3
                        and hypothesis.statement.terms[0] == Application("#ApplicationContext")
                        and hypothesis.statement.terms[1] == var):
                    known_context.append(hypothesis.statement.terms[2])

            # try left side
            for arg in left_arguments:
                if arg in known_context:
                    return composer.get_theorem("application-context-app-left").match_and_apply(
                        target,
                        ApplicationContextProver.prove_application_context_desugared(
                            composer, var, pattern.subterms[0], hypotheses
                        ),
                    )

            # try right side
            for arg in right_arguments:
                if arg in known_context:
                    return composer.get_theorem("application-context-app-right").match_and_apply(
                        target,
                        ApplicationContextProver.prove_application_context_desugared(
                            composer, var, pattern.subterms[1], hypotheses
                        ),
                    )

        assert False, (
            f"failed to prove {pattern} is a context over variable " +
            f"{var} under assumptions {', '.join(map(lambda t: str(t.statement), hypotheses))}"
        )

    @staticmethod
    def prove_application_context(
        composer: Composer,
        var: Metavariable,
        pattern: Term,
        hypotheses: List[Theorem] = [],
    ) -> Proof:
        expanded_pattern, notation_proof = NotationProver.expand_sugar_with_proof(composer, pattern)
        subproof = ApplicationContextProver.prove_application_context_desugared(
            composer, var, expanded_pattern, hypotheses
        )
        return composer.get_theorem("notation-application-context").apply(
            subproof,
            notation_proof,
        )

    @staticmethod
    def prove_application_context_statement(
        composer: Composer,
        statement: StructuredStatement,
        hypotheses: List[Theorem] = [],
    ) -> Proof:
        assert (
            len(statement.terms) == 3 and statement.terms[0] == Application("#ApplicationContext")
            and isinstance(statement.terms[1], Metavariable)
        ), f"{statement} is not a #ApplicationContext claim"

        return ApplicationContextProver.prove_application_context(
            composer, statement.terms[1], statement.terms[2], hypotheses
        )

    auto = MethodAutoProof(prove_application_context_statement.__func__)  # type: ignore
