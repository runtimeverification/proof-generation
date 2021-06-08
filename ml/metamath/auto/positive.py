from ..ast import StructuredStatement, Term, Metavariable, Application
from ..composer import Composer, Theorem, MethodAutoProof, Proof
from ..utils import MetamathUtils

from .notation import NotationProver

import ml.metamath.auto as auto


class PositiveProver:
    """
    Prove statements of the form
    #Positive xX ph0
    or
    #Negative xX ph0
    """
    @staticmethod
    def construct_positive_target(var: Metavariable, term: Term) -> StructuredStatement:
        return StructuredStatement(
            "",
            (Application("#Positive"), var, term),
        )

    @staticmethod
    def construct_negative_target(var: Metavariable, term: Term) -> StructuredStatement:
        return StructuredStatement(
            "",
            (Application("#Negative"), var, term),
        )

    @staticmethod
    def prove_positive(composer: Composer, var: Metavariable, term: Term) -> Proof:
        target = PositiveProver.construct_positive_target(var, term)

        if composer.are_terms_disjoint(var, term):
            return composer.get_theorem("positive-disjoint").match_and_apply(target)

        if auto.typecode.TypecodeProver.prove_typecode(composer, "#Variable", term) is not None:
            return composer.get_theorem("positive-in-var").match_and_apply(target)

        if auto.typecode.TypecodeProver.prove_typecode(composer, "#Symbol", term) is not None:
            return composer.get_theorem("positive-in-symbol").match_and_apply(target)

        assert isinstance(term, Application), \
               f"unable to prove #Positive {var} {term}"

        if term.symbol == "\\bot":
            return composer.get_theorem("positive-in-bot").match_and_apply(target)
        elif term.symbol == "\\imp":
            left, right = MetamathUtils.destruct_imp(term)
            return composer.get_theorem("positive-in-imp").apply(
                PositiveProver.prove_negative(composer, var, left),
                PositiveProver.prove_positive(composer, var, right),
            )
        elif term.symbol == "\\app":
            left, right = MetamathUtils.destruct_app(term)
            return composer.get_theorem("positive-in-app").apply(
                PositiveProver.prove_positive(composer, var, left),
                PositiveProver.prove_positive(composer, var, right),
            )
        elif term.symbol == "\\exists":
            _, body = MetamathUtils.destruct_exists(term)
            return composer.get_theorem("positive-in-exists").match_and_apply(
                target,
                PositiveProver.prove_positive(composer, var, body),
            )
        elif term.symbol == "\\mu":
            _, body = MetamathUtils.destruct_mu(term)
            return composer.get_theorem("positive-in-mu").match_and_apply(
                target,
                PositiveProver.prove_positive(composer, var, body),
            )

        for essential in composer.get_all_essentials():
            if essential.statement.terms == target.terms:
                return essential.apply()

        # expand the top level symbol and recurse
        expanded_term = NotationProver.expand_top_level_once(composer, term)
        expanded_proof = PositiveProver.prove_positive(composer, var, expanded_term)
        return NotationProver.prove_notation_statement(composer, target, expanded_proof)

    @staticmethod
    def prove_negative(composer: Composer, var: Metavariable, term: Term) -> Proof:
        target = PositiveProver.construct_negative_target(var, term)

        if composer.are_terms_disjoint(var, term):
            return composer.get_theorem("negative-disjoint").match_and_apply(target)

        if auto.typecode.TypecodeProver.prove_typecode(composer, "#Symbol", term) is not None:
            return composer.get_theorem("negative-in-symbol").match_and_apply(target)

        assert isinstance(term, Application), \
               f"unable to prove #Negative {var} {term}"

        if term.symbol == "\\bot":
            return composer.get_theorem("negative-in-bot").match_and_apply(target)
        elif term.symbol == "\\imp":
            left, right = MetamathUtils.destruct_imp(term)
            return composer.get_theorem("negative-in-imp").apply(
                PositiveProver.prove_positive(composer, var, left),
                PositiveProver.prove_negative(composer, var, right),
            )
        elif term.symbol == "\\app":
            left, right = MetamathUtils.destruct_app(term)
            return composer.get_theorem("negative-in-app").apply(
                PositiveProver.prove_negative(composer, var, left),
                PositiveProver.prove_negative(composer, var, right),
            )
        elif term.symbol == "\\exists":
            _, body = MetamathUtils.destruct_exists(term)
            return composer.get_theorem("negative-in-exists").match_and_apply(
                target,
                PositiveProver.prove_negative(composer, var, body),
            )
        elif term.symbol == "\\mu":
            _, body = MetamathUtils.destruct_mu(term)
            return composer.get_theorem("negative-in-mu").match_and_apply(
                target,
                PositiveProver.prove_negative(composer, var, body),
            )
        elif term.symbol == "\\nu":
            _, body = MetamathUtils.destruct_mu(term)
            return composer.get_theorem("negative-in-nu").match_and_apply(
                target,
                PositiveProver.prove_negative(composer, var, body),
            )

        for essential in composer.get_all_essentials():
            if essential.statement.terms == target.terms:
                return essential.apply()

        # expand the top level symbol and recurse
        expanded_term = NotationProver.expand_top_level_once(composer, term)
        expanded_proof = PositiveProver.prove_negative(composer, var, expanded_term)
        return NotationProver.prove_notation_statement(composer, target, expanded_proof)

    @staticmethod
    def prove_statement(composer: Composer, statement: StructuredStatement) -> Proof:
        assert len(statement.terms) == 3
        head, var, term = statement.terms

        assert isinstance(var, Metavariable), \
               f"ill-formed statement {statement}"

        if head == Application("#Positive"):
            return PositiveProver.prove_positive(composer, var, term)
        elif head == Application("#Negative"):
            return PositiveProver.prove_negative(composer, var, term)
        else:
            assert False, f"not a #Positive or #Negative statement {statement}"

    auto = MethodAutoProof(prove_statement.__func__)  # type: ignore
