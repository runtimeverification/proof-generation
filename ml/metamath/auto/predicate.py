from typing import Optional, Tuple

from ..ast import StructuredStatement, Term, Metavariable, Application
from ..composer import Composer, Theorem, MethodAutoProof, Proof
from ..utils import MetamathUtils

from .notation import NotationProver
from .typecode import TypecodeProver


class PredicateProver:
    @staticmethod
    def construct_target(term: Term) -> StructuredStatement:
        return StructuredStatement("", MetamathUtils.construct_provable(Application("\\is-predicate", (term, ))))

    @staticmethod
    def prove_predicate(composer: Composer, term: Term) -> Proof:
        if MetamathUtils.is_and(term):
            left, right = MetamathUtils.destruct_and(term)
            return composer.get_theorem("rule-predicate-intro-and").apply(
                PredicateProver.prove_predicate(composer, left),
                PredicateProver.prove_predicate(composer, right),
            )

        if MetamathUtils.is_top(term):
            return composer.get_theorem("predicate-intro-top").apply()

        if MetamathUtils.is_floor(term):
            subterm, = MetamathUtils.destruct_floor(term)
            return composer.get_theorem("lemma-floor-is-predicate").apply(ph0=subterm)

        # TODO: this is pretty incomplete

        assert isinstance(term, Application)

        # try to reduce to floor
        expanded_term = NotationProver.expand_top_level_once(composer, term)
        proof = PredicateProver.prove_predicate(composer, expanded_term)
        return NotationProver.prove_notation_statement(composer, PredicateProver.construct_target(term), proof)

    @staticmethod
    def prove_statement(composer: Composer, statement: StructuredStatement) -> Proof:
        body = MetamathUtils.destruct_provable(statement.terms)
        term, = MetamathUtils.destruct_is_predicate(body)
        return PredicateProver.prove_predicate(composer, term)

    auto = MethodAutoProof(prove_statement.__func__)  # type: ignore
