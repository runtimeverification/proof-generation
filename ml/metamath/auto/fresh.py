from typing import Optional, Tuple

from ..ast import StructuredStatement, Term, Metavariable, Application
from ..composer import Composer, Theorem, MethodAutoProof, Proof
from ..utils import MetamathUtils

from .notation import NotationProver
from .typecode import TypecodeProver


class FreshProver:
    """
    Prove claims of the form
    #Fresh x ph0
    """
    @staticmethod
    def construct_target(var: Metavariable, term: Term) -> StructuredStatement:
        return StructuredStatement("", (Application("#Fresh"), var, term))

    @staticmethod
    @Composer.add_hook("index")
    def hook_index(composer: Composer, theorem: Theorem) -> None:
        fresh_lemma_info = FreshProver.destruct_fresh_lemma(theorem)
        if fresh_lemma_info is not None:
            symbol, order = fresh_lemma_info
            if symbol not in composer.fresh_lemmas:
                composer.fresh_lemmas[symbol] = theorem, order

    @staticmethod
    @Composer.add_hook("remove")
    def hook_remove(composer: Composer, name: str) -> None:
        composer.fresh_lemmas = {
            symbol: (theorem, order)
            for symbol, (theorem, order) in composer.fresh_lemmas.items() if theorem.statement.label != name
        }

    @staticmethod
    def destruct_fresh_lemma(theorem: Theorem) -> Optional[Tuple[str, Tuple[int, ...]]]:
        if len(theorem.statement.terms) != 3:
            return None

        head, var, term = theorem.statement.terms

        if head != Application("#Fresh"):
            return None

        if not isinstance(var, Metavariable) or \
           not isinstance(term, Application):
            return None

        indices = []

        for essential in theorem.context.essentials:
            if len(essential.terms) != 3:
                return None

            head, var2, term2 = essential.terms
            if head != Application("#Fresh"):
                return None

            if not isinstance(var2, Metavariable) or \
               not isinstance(term2, Metavariable):
                return None

            if term2 not in term.subterms or var != var2:
                return None

            indices.append(term.subterms.index(term2))

        return term.symbol, tuple(indices)

    @staticmethod
    def prove_fresh(composer: Composer, var: Metavariable, term: Term) -> Proof:
        target = FreshProver.construct_target(var, term)

        if composer.are_terms_disjoint(var, term):
            return composer.get_theorem("fresh-disjoint").match_and_apply(target)

        if TypecodeProver.prove_typecode(composer, "#Symbol", term) is not None:
            return composer.get_theorem("fresh-in-symbol").match_and_apply(target)

        if isinstance(term, Metavariable):
            # try to find a statement in the hypotheses
            for essential in composer.get_all_essentials():
                if essential.statement.terms == target.terms:
                    return essential.apply()

        assert isinstance(term, Application), \
               f"unable to prove #Fresh {var} {term}"

        if term.symbol == "\\bot":
            return composer.get_theorem("fresh-in-bot").match_and_apply(target)
        elif term.symbol == "\\imp":
            left, right = MetamathUtils.destruct_imp(term)
            return composer.get_theorem("fresh-in-imp").apply(
                FreshProver.prove_fresh(composer, var, left),
                FreshProver.prove_fresh(composer, var, right),
            )
        elif term.symbol == "\\app":
            left, right = MetamathUtils.destruct_app(term)
            return composer.get_theorem("fresh-in-app").apply(
                FreshProver.prove_fresh(composer, var, left),
                FreshProver.prove_fresh(composer, var, right),
            )
        elif term.symbol == "\\exists":
            quant_var, body = MetamathUtils.destruct_exists(term)

            if var == quant_var:
                return composer.get_theorem("fresh-in-exists-shadowed").match_and_apply(target)
            elif composer.are_terms_disjoint(var, quant_var):
                return composer.get_theorem("fresh-in-exists").match_and_apply(
                    target,
                    FreshProver.prove_fresh(composer, var, body),
                )

            assert False, f"unable to prove #Fresh in {term}: variables {var} and {quant_var} are neither the same or disjoint"
        elif term.symbol == "\\mu":
            quant_var, body = MetamathUtils.destruct_mu(term)

            if var == quant_var:
                return composer.get_theorem("fresh-in-mu-shadowed").match_and_apply(target)
            elif composer.are_terms_disjoint(var, quant_var):
                return composer.get_theorem("fresh-in-mu").match_and_apply(
                    target,
                    FreshProver.prove_fresh(composer, var, body),
                )

            assert False, f"unable to prove #Fresh in {term}: variables {var} and {quant_var} are neither the same or disjoint"

        # try to find a lemma
        if term.symbol in composer.fresh_lemmas:
            theorem, order = composer.fresh_lemmas[term.symbol]

            subproofs = []

            for index in order:
                assert index < len(term.subterms)
                subproofs.append(FreshProver.prove_fresh(composer, var, term.subterms[index]))

            return theorem.match_and_apply(
                target,
                *subproofs,
            )

        # expand the top level symbol and recurse
        expanded_term = NotationProver.expand_top_level_once(composer, term)
        expanded_proof = FreshProver.prove_fresh(composer, var, expanded_term)
        return NotationProver.prove_notation_statement(composer, target, expanded_proof)

    @staticmethod
    def prove_fresh_statement(composer: Composer, statement: StructuredStatement) -> Proof:
        assert MetamathUtils.is_fresh(statement.terms)

        _, var, term = statement.terms
        assert isinstance(var, Metavariable), \
               f"ill-formed #Fresh statement {statement}"

        return FreshProver.prove_fresh(composer, var, term)

    auto = MethodAutoProof(prove_fresh_statement.__func__)  # type: ignore
