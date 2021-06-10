from typing import List, Optional, Tuple

from ..ast import Metavariable, Term, Application, StructuredStatement, ProvableStatement
from ..composer import Composer, Theorem, MethodAutoProof, Proof
from ..utils import MetamathUtils

from .notation import NotationProver
from .unification import Unification
from .typecode import TypecodeProver


class SubstitutionProver:
    @staticmethod
    def get_target(
        after_pattern: Term,
        before_pattern: Term,
        subst_pattern: Term,
        subst_var: Metavariable,
    ) -> StructuredStatement:
        return ProvableStatement(
            "",
            (
                Application("#Substitution"),
                after_pattern,
                before_pattern,
                subst_pattern,
                subst_var,
            ),
        )

    @staticmethod
    @Composer.add_hook("index")
    def hook_index(composer: Composer, theorem: Theorem) -> None:
        substitution_lemma_info = SubstitutionProver.destruct_substitution_lemma(theorem)
        if substitution_lemma_info is not None:
            symbol, order = substitution_lemma_info
            if symbol not in composer.substitution_lemmas:
                composer.substitution_lemmas[symbol] = theorem, order
            else:
                old_lemma, _ = composer.substitution_lemmas[symbol]
                if len(old_lemma.context.essentials) < len(theorem.context.essentials):
                    # try to find a more general one
                    composer.substitution_lemmas[symbol] = theorem, order

    @staticmethod
    @Composer.add_hook("remove")
    def hook_remove(composer: Composer, name: str) -> None:
        composer.substitution_lemmas = {
            symbol: (theorem, order)
            for symbol, (theorem, order) in composer.substitution_lemmas.items() if theorem.statement.label != name
        }

    @staticmethod
    def destruct_substitution_lemma(theorem: Theorem) -> Optional[Tuple[str, Tuple[int, ...]]]:
        """
        A theorem is a substitution lemma if it's of the form
        ${
            $e #Substitution a a' d xX $.
            $e #Substitution b b' d xX $.
            $p #Substitution ( S a b c ) ( S a' b' c' ) d xX $.
        $}
        """
        if len(theorem.statement.terms) != 5:
            return None

        head, after_pattern, before_pattern, subst_pattern, subst_var = theorem.statement.terms

        if head != Application("#Substitution"):
            return None

        if not isinstance(after_pattern, Application) or \
           not isinstance(before_pattern, Application) or \
           not isinstance(subst_pattern, Metavariable) or \
           not isinstance(subst_var, Metavariable):
            return None

        if after_pattern.symbol != before_pattern.symbol:
            return None

        indices = []

        for essential in theorem.context.essentials:
            if len(essential.terms) != 5:
                return None

            head, after_pattern2, before_pattern2, subst_pattern2, subst_var2 = essential.terms
            if head != Application("#Substitution"):
                return None

            if not isinstance(after_pattern2, Metavariable) or \
               not isinstance(before_pattern2, Metavariable):
                return None

            if after_pattern2 not in after_pattern.subterms or \
               before_pattern2 not in before_pattern.subterms or \
               subst_pattern2 != subst_pattern or \
               subst_var2 != subst_var:
                return None

            index = after_pattern.subterms.index(after_pattern2)
            if before_pattern.subterms.index(before_pattern2) != index:
                return None
            indices.append(index)

        return after_pattern.symbol, tuple(indices)

    @staticmethod
    def prove_application_substitution(
        composer: Composer,
        after_pattern: Application,
        before_pattern: Application,
        subst_pattern: Term,
        subst_var: Metavariable,
        hypotheses: List[Theorem] = [],
    ) -> Optional[Proof]:
        if after_pattern.symbol != before_pattern.symbol:
            result = NotationProver.rewrite_to_same_head_symbol(
                composer, after_pattern, before_pattern, with_proof=False
            )
            if result is None: return None
            _, new_after_pattern, _, new_before_pattern = result

            proof = SubstitutionProver.prove_substitution(
                composer,
                new_after_pattern,
                new_before_pattern,
                subst_pattern,
                subst_var,
                hypotheses,
            )

            if proof is None:
                return None

            return SubstitutionProver.modulo_notation(
                composer,
                after_pattern,
                before_pattern,
                subst_pattern,
                subst_var,
                proof=proof,
            )

        # TODO: quantifiers

        if after_pattern.symbol in composer.substitution_lemmas:
            theorem, indices = composer.substitution_lemmas[after_pattern.symbol]

            subproofs = []

            for index in indices:
                assert index < len(after_pattern.subterms) and \
                       index < len(before_pattern.subterms), \
                       f"ill-formed substitution lemma {theorem.statement}"

                sub_after_pattern = after_pattern.subterms[index]
                sub_before_pattern = before_pattern.subterms[index]

                subproof = SubstitutionProver.prove_substitution(
                    composer,
                    sub_after_pattern,
                    sub_before_pattern,
                    subst_pattern,
                    subst_var,
                    hypotheses,
                )
                subproofs.append(subproof)

            target = SubstitutionProver.get_target(after_pattern, before_pattern, subst_pattern, subst_var)
            return theorem.match_and_apply(target, *subproofs)

        # try to expand the notation a bit further
        sugar_axiom = NotationProver.find_sugar_axiom(composer, after_pattern.symbol)
        if sugar_axiom is not None:
            new_after_pattern = NotationProver.apply_sugar_axiom(sugar_axiom, after_pattern)
            new_before_pattern = NotationProver.apply_sugar_axiom(sugar_axiom, before_pattern)

            proof = SubstitutionProver.prove_substitution(
                composer,
                new_after_pattern,
                new_before_pattern,
                subst_pattern,
                subst_var,
                hypotheses,
            )

            if proof is None:
                return None

            return SubstitutionProver.modulo_notation(
                composer,
                after_pattern,
                before_pattern,
                subst_pattern,
                subst_var,
                proof=proof,
            )

        return None

    @staticmethod
    def modulo_notation(
        composer: Composer,
        after_pattern1: Term,
        before_pattern1: Term,
        subst_pattern1: Term,
        subst_var1: Metavariable,
        proof: Proof,
    ) -> Proof:
        """
        Turn the given proof to the expected form by applying notations
        """
        if proof.conclusion[1:] == (after_pattern1, before_pattern1, subst_pattern1, subst_var1):
            return proof

        _, after_pattern2, before_pattern2, subst_pattern2, subst_var2 = proof.conclusion

        assert subst_var2 == subst_var1

        return composer.get_theorem("notation-substitution").apply(
            proof,
            NotationProver.prove_notation(composer, after_pattern1, after_pattern2),
            NotationProver.prove_notation(composer, before_pattern1, before_pattern2),
            NotationProver.prove_notation(composer, subst_pattern1, subst_pattern2),
        )

    @staticmethod
    def check_and_cache(composer: Composer, proof: Proof) -> Proof:
        if len(composer.get_all_essentials()) != 0:
            return proof
        return composer.cache_proof("substitution", proof)

    @staticmethod
    def prove_substitution(
        composer: Composer,
        after_pattern: Term,
        before_pattern: Term,
        subst_pattern: Term,
        subst_var: Metavariable,
        hypotheses: List[Theorem] = [],
    ) -> Proof:
        target = SubstitutionProver.get_target(after_pattern, before_pattern, subst_pattern, subst_var)
        cached_proof = composer.lookup_proof_cache("substitution", target)
        if cached_proof is not None:
            return cached_proof

        if before_pattern == subst_var:
            # the entire pattern should be replaced by subst_pattern
            return SubstitutionProver.check_and_cache(
                composer,
                SubstitutionProver.modulo_notation(
                    composer,
                    after_pattern,
                    before_pattern,
                    subst_pattern,
                    subst_var,
                    proof=composer.get_theorem("substitution-var-same").apply(
                        xX=subst_var,
                        ph0=subst_pattern,
                    ),
                ),
            )

        if subst_pattern == subst_var:
            # substitution should do nothing to the before_pattern
            return SubstitutionProver.check_and_cache(
                composer,
                SubstitutionProver.modulo_notation(
                    composer,
                    after_pattern,
                    before_pattern,
                    subst_pattern,
                    subst_var,
                    proof=composer.get_theorem("substitution-identity").apply(
                        xX=subst_var,
                        ph0=before_pattern,
                    ),
                ),
            )

        if composer.are_terms_disjoint(before_pattern, subst_var):
            # before_pattern is disjoint from subst_var
            # this includes the case when before_pattern is a variable
            # and is disjoint from subst_var
            return SubstitutionProver.check_and_cache(
                composer,
                SubstitutionProver.modulo_notation(
                    composer,
                    after_pattern,
                    before_pattern,
                    subst_pattern,
                    subst_var,
                    proof=composer.get_theorem("substitution-disjoint").apply(
                        xX=subst_var,
                        ph0=before_pattern,
                        ph1=subst_pattern,
                    ),
                ),
            )

        if isinstance(before_pattern, Application) and \
           isinstance(after_pattern, Application):
            proof = SubstitutionProver.prove_application_substitution(
                composer,
                after_pattern,
                before_pattern,
                subst_pattern,
                subst_var,
                hypotheses,
            )
            if proof is not None:
                return SubstitutionProver.check_and_cache(composer, proof)

        if TypecodeProver.prove_typecode(composer, "#Symbol", before_pattern) is not None:
            return SubstitutionProver.check_and_cache(
                composer,
                SubstitutionProver.modulo_notation(
                    composer,
                    after_pattern,
                    before_pattern,
                    subst_pattern,
                    subst_var,
                    proof=composer.get_theorem("substitution-symbol").apply(
                        xX=subst_var,
                        ph0=subst_pattern,
                        sg0=before_pattern,
                    ),
                ),
            )

        if isinstance(before_pattern, Metavariable):
            # TypecodeProver.prove_typecode(composer, "#Pattern", before_pattern) is not None:
            # try to find a hypothesis that says so
            for hypothesis in hypotheses:
                if hypothesis.statement.terms == target.terms:
                    return hypothesis.apply()

        assert False, f"unable to prove #Substitution {after_pattern} {before_pattern} {subst_pattern} {subst_var}"

    @staticmethod
    def prove_substitution_statement(
        composer: Composer, statement: StructuredStatement, hypotheses: List[Theorem] = []
    ) -> Proof:
        """
        A wrapper for an auto proof method
        """

        assert len(
            statement.terms
        ) == 5 and statement.terms[0] == Application("#Substitution"), f"not a substitution goal {statement}"
        _, after, before, pattern, var = statement.terms
        assert isinstance(var, Metavariable)
        return SubstitutionProver.prove_substitution(
            composer,
            after,
            before,
            pattern,
            var,
            hypotheses=hypotheses,
        )

    auto = MethodAutoProof(prove_substitution_statement.__func__)  # type: ignore
