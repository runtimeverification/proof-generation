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
    def construct_kore_target(sort: Term, term: Term) -> StructuredStatement:
        return StructuredStatement(
            "", MetamathUtils.construct_provable(Application("\\kore-is-predicate", (sort, term)))
        )

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

        if MetamathUtils.is_kore_is_sort(term):
            assert isinstance(term, Application)
            return composer.get_theorem("kore-is-sort-is-predicate").apply(ph0=term.subterms[0])

        # TODO: this is pretty incomplete

        assert isinstance(term, Application)

        # try to reduce to floor
        expanded_term = NotationProver.expand_top_level_once(composer, term)
        proof = PredicateProver.prove_predicate(composer, expanded_term)
        return NotationProver.prove_notation_statement(composer, PredicateProver.construct_target(term), proof)

    @staticmethod
    def prove_kore_predicate(composer: Composer, sort: Term, term: Term) -> Proof:
        if MetamathUtils.is_kore_and(term):
            _, left, right = MetamathUtils.destruct_kore_and(term)
            return composer.get_theorem("kore-is-predicate-and-alt").apply(
                PredicateProver.prove_kore_predicate(composer, sort, left),
                PredicateProver.prove_kore_predicate(composer, sort, right),
            )

        if MetamathUtils.is_kore_top(term):
            return composer.get_theorem("kore-is-predicate-top").apply(ph0=sort)

        if MetamathUtils.is_kore_not(term):
            _, subterm = MetamathUtils.destruct_kore_not(term)
            return composer.get_theorem("kore-is-predicate-not-alt"
                                        ).apply(PredicateProver.prove_kore_predicate(composer, sort, subterm), )

        if MetamathUtils.is_kore_floor(term):
            return composer.get_theorem("kore-floor-is-predicate").match_and_apply(
                PredicateProver.construct_kore_target(sort, term)
            )

        assert isinstance(term, Application)

        # try to reduce to kore-floor
        expanded_term = NotationProver.expand_top_level_once(composer, term)
        proof = PredicateProver.prove_kore_predicate(composer, sort, expanded_term)
        return NotationProver.prove_notation_statement(
            composer, PredicateProver.construct_kore_target(sort, term), proof
        )

    @staticmethod
    def prove_statement(composer: Composer, statement: StructuredStatement) -> Proof:
        body = MetamathUtils.destruct_provable(statement.terms)

        if MetamathUtils.is_is_predicate(body):
            term, = MetamathUtils.destruct_is_predicate(body)
            return PredicateProver.prove_predicate(composer, term)

        elif MetamathUtils.is_kore_is_predicate(body):
            sort, term = MetamathUtils.destruct_kore_is_predicate(body)
            return PredicateProver.prove_kore_predicate(composer, sort, term)

        assert False, f"cannot prove {statement} using the predicate prover"

    auto = MethodAutoProof(prove_statement.__func__)  # type: ignore
