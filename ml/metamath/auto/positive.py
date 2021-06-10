from typing import Tuple, Optional

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
    @Composer.add_hook("index")
    def hook_index(composer: Composer, theorem: Theorem) -> None:
        positive_lemma_info = PositiveProver.destruct_lemma(theorem)
        if positive_lemma_info is not None:
            sign, symbol, order = positive_lemma_info
            if (sign, symbol) not in composer.positive_lemmas:
                composer.positive_lemmas[sign, symbol] = theorem, order

    @staticmethod
    @Composer.add_hook("remove")
    def hook_remove(composer: Composer, name: str) -> None:
        composer.positive_lemmas = {
            (sign, symbol): (theorem, order)
            for (sign, symbol), (theorem, order) in composer.positive_lemmas.items() if theorem.statement.label != name
        }

    @staticmethod
    def destruct_lemma(theorem: Theorem) -> Optional[Tuple[bool, str, Tuple[int, ...]]]:
        if len(theorem.statement.terms) != 3:
            return None

        head, var, term = theorem.statement.terms

        if head != Application("#Positive") and \
           head != Application("#Negative"):
            return None

        sign = head == Application("#Positive")

        if not isinstance(var, Metavariable) or \
           not isinstance(term, Application):
            return None

        indices = []

        for essential in theorem.context.essentials:
            if len(essential.terms) != 3:
                return None

            head, var2, term2 = essential.terms
            if head != Application("#Positive") and \
               head != Application("#Negative"):
                return None

            if not isinstance(var2, Metavariable) or \
               not isinstance(term2, Metavariable):
                return None

            if term2 not in term.subterms or var != var2:
                return None

            indices.append(term.subterms.index(term2))

        return sign, term.symbol, tuple(indices)

    @staticmethod
    def apply_lemma(
        composer: Composer,
        var: Metavariable,
        term: Application,
        target: StructuredStatement,
        lemma: Theorem,
        order: Tuple[int, ...],
    ) -> Proof:
        subproofs = []

        for i, index in enumerate(order):
            assert index < len(term.subterms) and \
                    i < len(lemma.context.essentials)

            essential = lemma.context.essentials[i]
            assert len(essential.terms) == 3

            if essential.terms[0] == Application("#Positive"):
                subproofs.append(PositiveProver.prove_positive(composer, var, term.subterms[index]))
            elif essential.terms[0] == Application("#Negative"):
                subproofs.append(PositiveProver.prove_negative(composer, var, term.subterms[index]))
            else:
                assert False, f"ill-formed positive/negative lemma {lemma.statement}"

        return lemma.match_and_apply(target, *subproofs)

    @staticmethod
    def prove_positive(composer: Composer, var: Metavariable, term: Term) -> Proof:
        target = PositiveProver.construct_positive_target(var, term)

        if composer.are_terms_disjoint(var, term):
            return composer.get_theorem("positive-disjoint").match_and_apply(target)

        if auto.typecode.TypecodeProver.prove_typecode(composer, "#Variable", term) is not None:
            return composer.get_theorem("positive-in-var").match_and_apply(target)

        if auto.typecode.TypecodeProver.prove_typecode(composer, "#Symbol", term) is not None:
            return composer.get_theorem("positive-in-symbol").match_and_apply(target)

        for essential in composer.get_all_essentials():
            if essential.statement.terms == target.terms:
                return essential.apply()

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

        if (True, term.symbol) in composer.positive_lemmas:
            theorem, order = composer.positive_lemmas[True, term.symbol]
            return PositiveProver.apply_lemma(composer, var, term, target, theorem, order)

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

        for essential in composer.get_all_essentials():
            if essential.statement.terms == target.terms:
                return essential.apply()

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

        if (False, term.symbol) in composer.positive_lemmas:
            theorem, order = composer.positive_lemmas[False, term.symbol]
            return PositiveProver.apply_lemma(composer, var, term, target, theorem, order)

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
