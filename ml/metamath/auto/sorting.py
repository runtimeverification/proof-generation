from typing import Mapping, Optional, Tuple, List, Dict, Callable

from ..ast import Metavariable, Term, Application, Statement, StructuredStatement, ProvableStatement
from ..composer import Composer, Theorem, MethodAutoProof, ProofCache, Proof
from ..utils import MetamathUtils

from .unification import Unification


class SortingProver:
    r"""
    The goal of this prover is to prove
    statements of the form

    |- ( \imp ( ... ) ( \in-sort ph1 ph0 ) )

    given only ph1

    Suppose ph1 is a term with metavariables v1, ..., vn
    Each vi can be:
    - a pattern variable
    - an element variable
    - a set variable

    Suppose we separate them so that
    - psi1, ..., psik are the pattern variables appearing in ph1
    - xX1, ..., xXl are the element/set variables appearing in ph1

    In the case when l = 0, we will try to prove the statement
        |- ( \in-sort ph1 ph0 )

    Otherwise, we will try to prove
        |- ( \imp ( ( \in-sort xX1 ) /\ ... /\ ( \in-sort xXl ) ) ( \in-sort ph1 ph0 ) )

    Whenever it comes to the point that we need to show ( \in-sort psij ph0 ), for some 1 <= j <= k
    we will scan the essentials to show that
    """
    @staticmethod
    def in_sort(term: Term, sort: Term) -> Application:
        return Application("\\in-sort", (term, sort))

    @staticmethod
    def construct_imp_goal(lhs: Term, rhs: Term) -> StructuredStatement:
        return ProvableStatement(
            "",
            (
                Application("|-"),
                Application("\\imp", (lhs, rhs)),
            ),
        )

    @staticmethod
    def get_conjuncts(term: Term) -> List[Term]:
        if (isinstance(term, Application) and term.symbol == "\\and" and len(term.subterms) == 2):
            return SortingProver.get_conjuncts(term.subterms[0]) + SortingProver.get_conjuncts(term.subterms[1])
        else:
            return [term]

    @staticmethod
    def get_provability_body(statement: StructuredStatement) -> Optional[Term]:
        if len(statement.terms) == 2 and statement.terms[0] == Application("|-"):
            return statement.terms[1]
        else:
            return None

    @staticmethod
    def get_provability_body_force(statement: StructuredStatement) -> Term:
        body = SortingProver.get_provability_body(statement)
        assert body is not None, f"not a provability statement {statement}"
        return body

    @staticmethod
    def is_imp_conjunctions(term: Term) -> Optional[Tuple[List[Term], List[Term]]]:
        """
        Check if the given term is an implication of conjunctions
        and return the tuple of conjuncts
        """
        if (not isinstance(term, Application) or term.symbol != "\\imp" or len(term.subterms) != 2):
            return None

        return (
            SortingProver.get_conjuncts(term.subterms[0]),
            SortingProver.get_conjuncts(term.subterms[1]),
        )

    @staticmethod
    def get_in_sort_pair(term: Term) -> Optional[Tuple[Term, Term]]:
        if (isinstance(term, Application) and term.symbol == "\\in-sort" and len(term.subterms) == 2):
            return term.subterms[0], term.subterms[1]
        else:
            return None

    @staticmethod
    def get_in_sort_pair_force(term: Term) -> Tuple[Term, Term]:
        pair = SortingProver.get_in_sort_pair(term)
        assert pair is not None, f"not an in-sort pattern {term}"
        return pair

    @staticmethod
    def is_kore_is_sort(term: Term) -> bool:
        return (isinstance(term, Application) and term.symbol == "\\kore-is-sort" and len(term.subterms) == 1)

    @staticmethod
    def find_sorting_lemma_for_symbol(composer: Composer, symbol: str) -> Optional[Theorem]:
        for theorem in composer.get_theorems_of_typecode("|-"):
            if len(theorem.context.essentials) != 0:
                continue

            term = SortingProver.get_provability_body(theorem.statement)
            if term is None:
                continue

            conjuncts = SortingProver.is_imp_conjunctions(term)
            if conjuncts is None:
                if SortingProver.get_in_sort_pair(term):
                    left_conjuncts: List[Term] = []
                    right_conjuncts = [term]
                else:
                    continue
            else:
                left_conjuncts, right_conjuncts = conjuncts

            # all conjuncts have to be \in-sort patterns
            failed = False
            for conjunct in left_conjuncts + right_conjuncts:
                if SortingProver.get_in_sort_pair(conjunct) is None and not SortingProver.is_kore_is_sort(conjunct):
                    failed = True
                    break
            if failed:
                continue

            if len(right_conjuncts) != 1:
                continue

            conclusion_term, _ = SortingProver.get_in_sort_pair_force(right_conjuncts[0])

            if (not isinstance(conclusion_term, Application) or conclusion_term.symbol != symbol):
                continue

            for subterm in conclusion_term.subterms:
                if not isinstance(subterm, Metavariable):
                    failed = True
            if failed:
                continue

            return theorem

        return None

    @staticmethod
    def prove_kore_is_sort(composer: Composer, statement: StructuredStatement) -> Proof:
        r"""
        Prove a statement of the form:
        |- ( \kore-is-sort ph0 )

        TODO: add support for sort-parametric sorts
        """

        term = SortingProver.get_provability_body(statement)
        assert term is not None, f"statement {statement} is not a provability claim"

        assert (
            isinstance(term, Application) and term.symbol == "\\kore-is-sort" and len(term.subterms) == 1
        ), f"unexpected kore-is-sort claim {statement}"

        for theorem in composer.get_theorems_of_typecode("|-"):
            if len(theorem.context.essentials) != 0:
                continue

            theorem_term = SortingProver.get_provability_body(theorem.statement)
            if theorem_term is None:
                continue

            if (not isinstance(theorem_term, Application) or theorem_term.symbol != "\\kore-is-sort"
                    or len(theorem_term.subterms) != 1):
                continue

            substitution = Unification.match_statements_as_instance(theorem.statement, statement)
            if substitution is None:
                continue

            proof = theorem.match_and_apply(statement)

            if proof.is_proof_of(statement):
                break
        else:
            assert False, f"unable to prove {statement}"

        return proof

    @staticmethod
    def prove_single_sorting_judgement(composer: Composer, hypothesis: Application, conclusion: Application) -> Proof:
        """
        Conclusion should be a single sorting claim
        """
        left_conjuncts = SortingProver.get_conjuncts(hypothesis)

        if MetamathUtils.is_top(conclusion):
            return composer.get_theorem("rule-weakening").apply(
                composer.get_theorem("top-intro").apply(),
                ph0=hypothesis,
            )

        # if the conclusion in one of the essentials
        for essential in composer.get_all_essentials():
            if essential.statement.terms == (Application("|-"), conclusion):
                return composer.get_theorem("proof-rule-mp").apply(
                    composer.get_theorem("proof-rule-prop-1").apply(ph0=conclusion, ph1=hypothesis),
                    essential.apply(),
                )

        # if the conclusion is exactly the (only) left conjunct
        if hypothesis == conclusion:
            return composer.get_theorem("imp-reflexivity").apply(ph0=conclusion)

        # if the conclusion is one of the left conjuncts
        if conclusion in left_conjuncts and len(left_conjuncts) > 1:
            left_left_conjuncts = SortingProver.get_conjuncts(hypothesis.subterms[0])

            if conclusion in left_left_conjuncts:
                return composer.get_theorem("rule-imp-transitivity").apply(
                    composer.get_theorem("and-elim-left-sugar"
                                         ).apply(ph0=hypothesis.subterms[0], ph1=hypothesis.subterms[1]),
                    SortingProver.prove_multiple_sorting_judgements(
                        composer,
                        hypothesis.subterms[0],
                        conclusion,
                    ),
                )
            else:
                return composer.get_theorem("rule-imp-transitivity").apply(
                    composer.get_theorem("and-elim-right-sugar"
                                         ).apply(ph0=hypothesis.subterms[0], ph1=hypothesis.subterms[1]),
                    SortingProver.prove_multiple_sorting_judgements(
                        composer,
                        hypothesis.subterms[1],
                        conclusion,
                    ),
                )

        # if the conclusion is a \kore-is-sort claims
        # currently we are assuming that it's directly provable
        # without any hypothesis
        if (isinstance(conclusion, Application) and conclusion.symbol == "\\kore-is-sort"):
            return composer.get_theorem("proof-rule-mp").apply(
                composer.get_theorem("proof-rule-prop-1").apply(ph0=conclusion, ph1=hypothesis),
                SortingProver.prove_kore_is_sort(
                    composer,
                    ProvableStatement(
                        "",
                        (
                            Application("|-"),
                            conclusion,
                        ),
                    ),
                ),
            )

        conclusion_term, _ = SortingProver.get_in_sort_pair_force(conclusion)

        assert isinstance(
            conclusion_term, Application
        ), f"unable to prove sorting judgement ( \\imp {hypothesis} {conclusion} )"

        sorting_lemma = SortingProver.find_sorting_lemma_for_symbol(composer, conclusion_term.symbol)
        assert (sorting_lemma is not None), f"unable to find sorting lemma for symbol {conclusion_term.symbol}"

        sorting_lemma_term = SortingProver.get_provability_body_force(sorting_lemma.statement)

        if SortingProver.get_in_sort_pair(sorting_lemma_term) is not None:
            sorting_lemma_rhs = sorting_lemma_term
        else:
            assert isinstance(sorting_lemma_term, Application)
            sorting_lemma_rhs = sorting_lemma_term.subterms[1]

        assert isinstance(sorting_lemma_rhs, Application)
        substitution = Unification.match_terms_as_instance(sorting_lemma_rhs, conclusion)

        assert (
            substitution is not None
        ), f"unable to unify the conclusion {conclusion} with the sorting lemma |- {sorting_lemma_term}"
        assert set(substitution.keys()).issubset(
            sorting_lemma.statement.get_metavariables()
        ), f"free metavariables left unused in the sorting lemma |- {sorting_lemma_term}"

        subproof = sorting_lemma.apply(**substitution)

        # we can prove the conclusion directly without using hypotheses
        if SortingProver.get_in_sort_pair(sorting_lemma_term) is not None:
            assert (
                subproof.conclusion[1] == conclusion
            ), f"unable to prove sorting judgement ( \\imp {hypothesis} {conclusion} )"

            return composer.get_theorem("proof-rule-mp").apply(
                composer.get_theorem("proof-rule-prop-1").apply(ph0=conclusion, ph1=hypothesis),
                subproof,
            )

        # this statement should also be a implication
        # we prove the left hand side of our target
        # implies the left hand side of this statement
        assert isinstance(subproof.conclusion[1], Application)
        subgoal = subproof.conclusion[1].subterms[0]

        return composer.get_theorem("rule-imp-transitivity").apply(
            SortingProver.prove_multiple_sorting_judgements(composer, hypothesis, subgoal),
            subproof,
        )

    @staticmethod
    def prove_multiple_sorting_judgements(composer: Composer, hypothesis: Term, conclusion: Term) -> Proof:
        assert isinstance(hypothesis, Application) and isinstance(conclusion, Application)

        # see if we have already cached the result
        cached_proof = composer.lookup_proof_cache(
            "sorting-cache", SortingProver.construct_imp_goal(hypothesis, conclusion)
        )
        if cached_proof is not None:
            return cached_proof

        if conclusion.symbol == "\\and":
            # top level must be an \and, so we break it into two goals
            proof = composer.get_theorem("rule-and-intro-alt2-sugar").apply(
                SortingProver.prove_multiple_sorting_judgements(composer, hypothesis, conclusion.subterms[0]),
                SortingProver.prove_multiple_sorting_judgements(composer, hypothesis, conclusion.subterms[1]),
            )
            proof = composer.cache_proof("sorting-cache", proof)
            return proof

        proof = SortingProver.prove_single_sorting_judgement(composer, hypothesis, conclusion)
        proof = composer.cache_proof("sorting-cache", proof)
        return proof

    @staticmethod
    def prove_sorting_statement(composer: Composer, statement: StructuredStatement) -> Proof:
        r"""
        Prove a statement of the form:
        |- ( \imp <hypotheses> ( conjunction of the form of either ( \in-sort ph0 ph1 ) or ( \kore-is-sort ph0 ) ) )
        """

        term = SortingProver.get_provability_body(statement)
        assert term is not None, f"statement {statement} is not a provability claim"
        assert isinstance(term, Application)

        # if the top level is not \imp (i.e. if there is no hypotheses/sorting environment)
        if term.symbol != "\\imp":
            return composer.get_theorem("proof-rule-mp").apply(
                SortingProver.prove_multiple_sorting_judgements(composer, Application("\\top"), term),
                composer.get_theorem("top-intro").apply(),
            )

        hypothesis, conclusion = term.subterms

        if isinstance(hypothesis, Metavariable):
            # if the hypotheses is a metavariable
            # try to find sorting essentials that have the same hypotheses

            actual_hypothesis = MetamathUtils.construct_top()
            hyp_proof = composer.get_theorem("rule-weakening").apply(
                composer.get_theorem("top-intro").apply(),
                ph0=hypothesis,
            )

            for essential in composer.get_all_essentials():
                if MetamathUtils.is_provable(essential.statement.terms):
                    body = MetamathUtils.destruct_provable(essential.statement.terms)
                    if MetamathUtils.is_imp(body):
                        left, right = MetamathUtils.destruct_imp(body)
                        if left == hypothesis and MetamathUtils.is_in_sort(right):
                            actual_hypothesis = MetamathUtils.construct_and(
                                right,
                                actual_hypothesis,
                            )

                            # |- hypothesis -> actual hypothesis
                            hyp_proof = composer.get_theorem("rule-and-intro-alt2-sugar").apply(
                                essential.apply(),
                                hyp_proof,
                            )

            proof = SortingProver.prove_multiple_sorting_judgements(composer, actual_hypothesis, conclusion)
            proof = composer.get_theorem("proof-rule-mp").apply(
                composer.get_theorem("rule-weakening-imp2").apply(
                    proof,
                    ph2=hypothesis,
                ),
                hyp_proof,
            )
            assert proof.conclusion == statement.terms, \
                   f"unexpected proof {proof} for {statement}"

            return proof

        return SortingProver.prove_multiple_sorting_judgements(composer, hypothesis, conclusion)

    @staticmethod
    def lookup_rearrange_cache(composer: Composer, target_premise: Optional[Term], proof: Proof) -> Optional[Proof]:
        conclusion = MetamathUtils.destruct_provable(proof.conclusion)

        if target_premise is None:
            if MetamathUtils.is_imp(conclusion):
                goal = MetamathUtils.construct_provable(conclusion)
            else:
                return None
        else:
            if MetamathUtils.is_imp(conclusion):
                _, conclusion_body = MetamathUtils.destruct_imp(conclusion)
                goal = MetamathUtils.construct_provable(MetamathUtils.construct_imp(target_premise, conclusion_body))
            else:
                goal = MetamathUtils.construct_provable(MetamathUtils.construct_imp(target_premise, conclusion))

        return composer.lookup_proof_cache("sorting-rearrange", goal)

    @staticmethod
    def rearrange_premise(composer: Composer, target_premise: Optional[Term], proof: Proof) -> Proof:
        r"""
        Rearrange the premise of the conclusion of the proof

        If target_premise is not None,
        - if proof is of the form |- ( \imp <old premise> ... ),
          we return a new proof of the form |- ( \imp <target_premise> ... )
        - if the proof is not an implication, we weakens it by adding the target premise

        If target_premise is None,
        - if the proof is of the form |- ( \imp <old premise> ... ),
          we try to prove <old premise> directly and removes it
        - otherwise we are done
        """
        conclusion = MetamathUtils.destruct_provable(proof.conclusion)

        cached_proof = SortingProver.lookup_rearrange_cache(composer, target_premise, proof)
        if cached_proof is not None:
            return cached_proof

        if target_premise is None:
            if MetamathUtils.is_imp(conclusion):
                conclusion_premise, _ = MetamathUtils.destruct_imp(conclusion)
                premise_proof = SortingProver.prove_sorting_statement(
                    composer,
                    StructuredStatement(
                        "",
                        MetamathUtils.construct_provable(conclusion_premise),
                    ),
                )
                return composer.cache_proof(
                    "sorting-rearrange",
                    composer.get_theorem("proof-rule-mp").apply(proof, premise_proof),
                )
            else:
                return proof
        else:
            if MetamathUtils.is_imp(conclusion):
                conclusion_premise, conclusion_body = MetamathUtils.destruct_imp(conclusion)

                if conclusion_premise == target_premise:
                    return proof

                premise_imp = SortingProver.prove_sorting_statement(
                    composer,
                    StructuredStatement(
                        "",
                        MetamathUtils.construct_provable(
                            MetamathUtils.construct_imp(target_premise, conclusion_premise),
                        ),
                    ),
                )

                return composer.cache_proof(
                    "sorting-rearrange",
                    composer.get_theorem("rule-imp-transitivity").apply(premise_imp, proof),
                )
            else:
                return composer.cache_proof(
                    "sorting-rearrange",
                    composer.get_theorem("rule-weakening").apply(
                        proof,
                        ph0=target_premise,
                    ),
                )

    # given a proof, automatically rearrange the premise to fit the form required
    auto_rearrange_premise: Callable[[Proof], MethodAutoProof] = \
        lambda proof: MethodAutoProof(
            lambda composer, statement:
                SortingProver.rearrange_premise(composer, MetamathUtils.destruct_premise(statement)[0], proof))

    auto = MethodAutoProof(prove_sorting_statement.__func__)  # type: ignore
