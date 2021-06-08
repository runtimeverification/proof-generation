from typing import List

from ..ast import StructuredStatement
from ..composer import Composer, Theorem, MethodAutoProof, Proof


class FreshProver:
    """
    Prove claims of the form
    #Fresh x ph0
    """
    @staticmethod
    def prove_fresh_statement(
        composer: Composer, statement: StructuredStatement, hypotheses: List[Theorem] = []
    ) -> Proof:
        # TODO prove this
        return Proof.from_script(statement, "?")

    auto = MethodAutoProof(prove_fresh_statement.__func__)  # type: ignore
