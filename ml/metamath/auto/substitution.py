from typing import List, Optional, Tuple

from ..ast import Metavariable, Term, Application, StructuredStatement, ProvableStatement
from ..composer import Composer, Theorem, MethodAutoProof, TypecodeProver, Proof
from ..utils import MetamathUtils

from .notation import NotationProver
from .unification import Unification


class SubstitutionProver:
    # @staticmethod
    # def substitute_expanded(
    #     composer: Composer,
    #     before_pattern: Term,
    #     subst_pattern: Term,
    #     subst_var: Metavariable,
    # ) -> Term:
    #     if isinstance(before_pattern, Metavariable):
    #         if subst_var == before_pattern:
    #             return subst_pattern
    #         else:
    #             return before_pattern

    #     assert isinstance(before_pattern, Application)

    #     if MetamathUtils.is_exists(before_pattern):
    #         var, body = MetamathUtils.destruct_exists(before_pattern)
    #         if var == subst_var:
    #             return before_pattern
    #         else:
    #             substituted_body = SubstitutionProver.substitute_expanded(composer, body, subst_pattern, subst_var)
    #             return MetamathUtils.construct_exists(var, substituted_body)

    #     elif MetamathUtils.is_mu(before_pattern):
    #         var, body = MetamathUtils.destruct_mu(before_pattern)
    #         if var == subst_var:
    #             return before_pattern
    #         else:
    #             substituted_body = SubstitutionProver.substitute_expanded(composer, body, subst_pattern, subst_var)
    #             return MetamathUtils.construct_mu(var, substituted_body)

    #     else:
    #         substituted_subterms = []
    #         for subterm in before_pattern.subterms:
    #             substituted_subterms.append(SubstitutionProver.substitute_expanded(composer, subterm, subst_pattern, subst_var))

    #         return Application(before_pattern.symbol, tuple(substituted_subterms))

    # @staticmethod
    # def substitute(
    #     composer: Composer,
    #     before_pattern: Term,
    #     subst_pattern: Term,
    #     subst_var: Metavariable,
    # ) -> Term:
    #     """
    #     Compute the result of substitution
    #     """
    #     expanded_before_pattern = NotationProver.expand_sugar(composer, before_pattern)
    #     return SubstitutionProver.substitute_expanded(composer, expanded_before_pattern, subst_pattern, subst_var)

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
    def prove_desugared_substitution(
        composer: Composer,
        after_pattern: Term,
        before_pattern: Term,
        subst_pattern: Term,
        subst_var: Metavariable,
        hypotheses: List[Theorem] = [],
    ) -> Proof:
        """
        This method only deals with patterns consisting of
        the most basic constructs (\\bot, \\imp, \\app, \\exists, \\mu)
        and metavariables
        """
        target = SubstitutionProver.get_target(after_pattern, before_pattern, subst_pattern, subst_var)

        is_variable_metavar = (TypecodeProver.prove_typecode(composer, "#Variable", before_pattern) is not None)
        is_pattern_metavar = (TypecodeProver.prove_typecode(composer, "#Pattern", before_pattern) is not None)
        is_symbol_metavar = (TypecodeProver.prove_typecode(composer, "#Symbol", before_pattern) is not None)

        if before_pattern == subst_var and after_pattern == subst_pattern:
            return composer.get_theorem("substitution-var-same").match_and_apply(target)

        if after_pattern == before_pattern:
            if is_variable_metavar and before_pattern != subst_var:
                return composer.get_theorem("substitution-var-diff").match_and_apply(target)

            if subst_pattern == subst_var:
                return composer.get_theorem("substitution-identity").match_and_apply(target)

            if is_symbol_metavar:
                return composer.get_theorem("substitution-symbol").match_and_apply(target)

        if is_pattern_metavar:
            # try to find a hypothesis that says so
            for hypothesis in hypotheses:
                if hypothesis.statement.terms == target.terms:
                    return hypothesis.apply()

        if isinstance(before_pattern, Application):
            assert isinstance(after_pattern, Application)

            arity_map = {
                "\\bot": (0, "substitution-bot"),
                "\\imp": (2, "substitution-imp"),
                "\\app": (2, "substitution-app"),
            }

            binder_map = {
                "\\exists": ("substitution-exists-shadowed", "substitution-exists"),
                "\\mu": ("substitution-mu-shadowed", "substitution-mu"),
            }

            if before_pattern.symbol in arity_map:
                arity, theorem_label = arity_map[before_pattern.symbol]

                assert (len(after_pattern.subterms) == len(before_pattern.subterms) == arity)

                subproofs = [
                    SubstitutionProver.prove_desugared_substitution(
                        composer,
                        after_subpattern,
                        before_subpattern,
                        subst_pattern,
                        subst_var,
                        hypotheses,
                    ) for after_subpattern, before_subpattern in zip(after_pattern.subterms, before_pattern.subterms)
                ]

                return composer.get_theorem(theorem_label).match_and_apply(target, *subproofs)

            elif before_pattern.symbol == after_pattern.symbol and before_pattern.symbol in binder_map:
                assert len(before_pattern.subterms) == 2 and \
                       len(after_pattern.subterms) == 2, \
                       f"ill-formed \\exists or \\mu pattern: {before_pattern}"

                shadowed_axiom, body_subst_axiom = binder_map[before_pattern.symbol]

                binding_var = before_pattern.subterms[0]

                if binding_var == subst_var and after_pattern == before_pattern:
                    return composer.get_theorem(shadowed_axiom).match_and_apply(target)

                elif binding_var != subst_var:  # and composer.are_terms_disjoint(binding_var, subst_var):
                    body_subst = SubstitutionProver.prove_desugared_substitution(
                        composer,
                        after_pattern.subterms[1],
                        before_pattern.subterms[1],
                        subst_pattern,
                        subst_var,
                        hypotheses,
                    )

                    return composer.get_theorem(body_subst_axiom).match_and_apply(
                        target,
                        composer.get_theorem("substitution-identity"
                                             ).apply(ph0=before_pattern.subterms[1], xX=binding_var),
                        body_subst,
                    )

        if composer.are_terms_disjoint(before_pattern, subst_var) and before_pattern == after_pattern:
            return composer.get_theorem("substitution-disjoint").match_and_apply(target)

        assert (False), f"unable to prove #Substitution {after_pattern} {before_pattern} {subst_pattern} {subst_var}"

    @staticmethod
    def prove_substitution_using_lemmas(
        composer: Composer,
        after_pattern: Term,
        before_pattern: Term,
        subst_pattern: Term,
        subst_var: Metavariable,
        hypotheses: List[Theorem] = [],
    ) -> Optional[Proof]:
        """
        Try to prove the substitution using an existing lemma
        """

        # if the heads are the same and there exists a substitution for the head symbol
        if (isinstance(after_pattern, Application) and isinstance(before_pattern, Application)
                and after_pattern.symbol == before_pattern.symbol
                and len(after_pattern.subterms) == len(before_pattern.subterms)):
            target = SubstitutionProver.get_target(after_pattern, before_pattern, subst_pattern, subst_var)

            for theorem in composer.get_theorems_of_typecode("#Substitution"):
                if not (len(theorem.statement.terms) > 1 and isinstance(theorem.statement.terms[1], Application)
                        and theorem.statement.terms[1].symbol == after_pattern.symbol):
                    continue

                instantiation = Unification.match_statements_as_instance(theorem.statement, target)
                if instantiation is None:
                    continue

                failed = False
                subgoals: List[Tuple[Term, Term, Term, Metavariable]
                               ] = ([])  # list of tuples (after_pattern, before_pattern, subst_pattern, subst_var)

                # determine the subgoals
                for essential in theorem.context.essentials:
                    if len(essential.terms) == 5 and essential.terms[0] == Application("#Substitution"):
                        (
                            _,
                            after_subpattern,
                            before_subpattern,
                            subst_subpattern,
                            sub_subst_var,
                        ) = essential.terms

                        if (isinstance(after_subpattern, Metavariable) and isinstance(before_subpattern, Metavariable)
                                and isinstance(subst_subpattern, Metavariable)
                                and isinstance(sub_subst_var, Metavariable) and after_subpattern.name in instantiation
                                and before_subpattern.name in instantiation and subst_subpattern.name in instantiation
                                and sub_subst_var.name in instantiation):
                            var = instantiation[sub_subst_var.name]
                            assert isinstance(var, Metavariable)
                            subgoals.append(
                                (
                                    instantiation[after_subpattern.name],
                                    instantiation[before_subpattern.name],
                                    instantiation[subst_subpattern.name],
                                    var,
                                )
                            )
                            continue

                    failed = True
                    break

                if failed:
                    continue

                subproofs = []
                for subgoal in subgoals:
                    try:
                        subproof = SubstitutionProver.prove_substitution(composer, *subgoal, hypotheses)
                    except:
                        failed = True
                        break

                    subproofs.append(subproof)

                if failed:
                    continue

                return theorem.match_and_apply(target, *subproofs)

        return None

    @staticmethod
    def prove_substitution(
        composer: Composer,
        after_pattern: Term,
        before_pattern: Term,
        subst_pattern: Term,
        subst_var: Metavariable,
        hypotheses: List[Theorem] = [],
    ) -> Proof:
        """
        Prove statement of the form
        #Substitution ph0 ph1 ph2 xX
        where ph0 is the result of substituting ph2 for xX in ph1

        Notations are also considered
        """

        proof = SubstitutionProver.prove_substitution_using_lemmas(
            composer,
            after_pattern,
            before_pattern,
            subst_pattern,
            subst_var,
            hypotheses,
        )
        if proof is not None:
            return proof

        # otherwise fall back to the default prover

        # desugar everything first
        # TODO: there might be a more efficient way

        (
            expanded_after_pattern,
            expansion_subproof1,
        ) = NotationProver.expand_sugar_with_proof(composer, after_pattern)
        (
            expanded_before_pattern,
            expansion_subproof2,
        ) = NotationProver.expand_sugar_with_proof(composer, before_pattern)
        (
            expanded_subst_pattern,
            expansion_subproof3,
        ) = NotationProver.expand_sugar_with_proof(composer, subst_pattern)

        subst_proof = SubstitutionProver.prove_desugared_substitution(
            composer,
            expanded_after_pattern,
            expanded_before_pattern,
            expanded_subst_pattern,
            subst_var,
            hypotheses=hypotheses,
        )

        target = SubstitutionProver.get_target(
            expanded_after_pattern,
            expanded_before_pattern,
            expanded_subst_pattern,
            subst_var,
        )

        assert subst_proof.is_proof_of(target)

        return composer.get_theorem("notation-substitution").apply(
            subst_proof,
            expansion_subproof1,
            expansion_subproof2,
            expansion_subproof3,
        )

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
