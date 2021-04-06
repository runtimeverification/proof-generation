from typing import Mapping, Optional, Tuple, List

from ..ast import Metavariable, Term, Application, Statement, StructuredStatement
from ..composer import Composer, Theorem, Proof, MethodAutoProof, ProofCache

from .unification import Unification


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


class SortingProver:
    @staticmethod
    def in_sort(term: Term, sort: Term) -> Term:
        return Application("\\in-sort", [term, sort])

    @staticmethod
    def construct_imp_goal(lhs: Term, rhs: Term) -> StructuredStatement:
        return StructuredStatement(
            Statement.PROVABLE,
            [
                Application("|-"),
                Application("\\imp", [lhs, rhs]),
            ],
        )

    @staticmethod
    def get_conjuncts(term: Term) -> List[Term]:
        if (
            isinstance(term, Application)
            and term.symbol == "\\and"
            and len(term.subterms) == 2
        ):
            return SortingProver.get_conjuncts(
                term.subterms[0]
            ) + SortingProver.get_conjuncts(term.subterms[1])
        else:
            return [term]

    @staticmethod
    def is_provability_statement(statement: StructuredStatement) -> Optional[Term]:
        if len(statement.terms) == 2 and statement.terms[0] == Application("|-"):
            return statement.terms[1]
        else:
            return None

    """
    Check if the given term is an implication of conjunctions
    and return the tuple of conjuncts
    """

    @staticmethod
    def is_imp_conjunctions(term: Term) -> Optional[Tuple[List[Term], List[Term]]]:
        if (
            not isinstance(term, Application)
            or term.symbol != "\\imp"
            or len(term.subterms) != 2
        ):
            return None

        return (
            SortingProver.get_conjuncts(term.subterms[0]),
            SortingProver.get_conjuncts(term.subterms[1]),
        )

    @staticmethod
    def is_in_sort(term: Term) -> Optional[Tuple[Term, Term]]:
        if (
            isinstance(term, Application)
            and term.symbol == "\\in-sort"
            and len(term.subterms) == 2
        ):
            return tuple(term.subterms)
        else:
            return None

    @staticmethod
    def is_kore_is_sort(term: Term) -> bool:
        return (
            isinstance(term, Application)
            and term.symbol == "\\kore-is-sort"
            and len(term.subterms) == 1
        )

    # TODO: this cache is quite unsafe
    sorting_lemma_cache = {}

    @staticmethod
    def find_sorting_lemma_for_symbol(
        composer: Composer, symbol: str
    ) -> Optional[Theorem]:
        if not ProofCache.DISABLED and symbol in SortingProver.sorting_lemma_cache:
            return SortingProver.sorting_lemma_cache[symbol]

        for theorem in composer.get_theorems_of_typecode("|-"):
            if len(theorem.essentials) != 0:
                continue

            term = SortingProver.is_provability_statement(theorem.statement)
            if term is None:
                continue

            conjuncts = SortingProver.is_imp_conjunctions(term)
            if conjuncts is None:
                if SortingProver.is_in_sort(term):
                    left_conjuncts = []
                    right_conjuncts = [term]
                else:
                    continue
            else:
                left_conjuncts, right_conjuncts = conjuncts

            # all conjuncts have to be \in-sort patterns
            failed = False
            for conjunct in left_conjuncts + right_conjuncts:
                if SortingProver.is_in_sort(
                    conjunct
                ) is None and not SortingProver.is_kore_is_sort(conjunct):
                    failed = True
                    break
            if failed:
                continue

            if len(right_conjuncts) != 1:
                continue

            conclusion_term, _ = SortingProver.is_in_sort(right_conjuncts[0])

            if (
                not isinstance(conclusion_term, Application)
                or conclusion_term.symbol != symbol
            ):
                continue

            for subterm in conclusion_term.subterms:
                if not isinstance(subterm, Metavariable):
                    failed = True
            if failed:
                continue

            SortingProver.sorting_lemma_cache[symbol] = theorem
            return theorem

    r"""
    Prove a statement of the form:
    |- ( \kore-is-sort ph0 )

    TODO: add support for sort-parametric sorts
    """

    @staticmethod
    def prove_kore_is_sort(composer: Composer, statement: StructuredStatement) -> Proof:
        term = SortingProver.is_provability_statement(statement)
        assert term is not None, f"statement {statement} is not a provability claim"

        assert (
            isinstance(term, Application)
            and term.symbol == "\\kore-is-sort"
            and len(term.subterms) == 1
        ), f"unexpected kore-is-sort claim {statement}"

        for theorem in composer.get_theorems_of_typecode("|-"):
            if len(theorem.essentials) != 0:
                continue

            theorem_term = SortingProver.is_provability_statement(theorem.statement)
            if theorem_term is None:
                continue

            if (
                not isinstance(theorem_term, Application)
                or theorem_term.symbol != "\\kore-is-sort"
                or len(theorem_term.subterms) != 1
            ):
                continue

            substitution = Unification.match_statements_as_instance(
                theorem.statement, statement
            )
            if substitution is None:
                continue

            proof = theorem.match_and_apply(statement)

            if proof.statement.terms == statement.terms:
                break
        else:
            assert (
                proof.statement.terms == statement.terms
            ), f"unable to prove {statement}"

        return proof

    """
    Conclusion should be a single sorting claim
    """

    @staticmethod
    def prove_single_sorting_judgement(
        composer: Composer, hypothesis: Term, conclusion: Term
    ) -> Proof:
        left_conjuncts = SortingProver.get_conjuncts(hypothesis)

        # if the conclusion is a \kore-is-sort claims
        # currently we are assuming that it's directly provable
        # without any hypothesis
        if (
            isinstance(conclusion, Application)
            and conclusion.symbol == "\\kore-is-sort"
        ):
            return composer.find_theorem("proof-rule-mp").apply(
                composer.find_theorem("proof-rule-prop-1").apply(
                    ph0=conclusion, ph1=hypothesis
                ),
                SortingProver.prove_kore_is_sort(
                    composer,
                    StructuredStatement(
                        Statement.PROVABLE,
                        [
                            Application("|-"),
                            conclusion,
                        ],
                    ),
                ),
            )

        conclusion_term, _ = SortingProver.is_in_sort(conclusion)

        # if the conclusion in one of the essentials
        for essential in composer.get_all_essentials():
            if essential.statement.terms == [Application("|-"), conclusion]:
                return composer.find_theorem("proof-rule-mp").apply(
                    composer.find_theorem("proof-rule-prop-1").apply(
                        ph0=conclusion, ph1=hypothesis
                    ),
                    essential.apply(),
                )

        # if the conclusion is exactly the (only) left conjunct
        if hypothesis == conclusion:
            return composer.find_theorem("imp-reflexivity").apply(ph0=conclusion)

        # if the conclusion is one of the left conjuncts
        if conclusion in left_conjuncts and len(left_conjuncts) > 1:
            left_left_conjuncts = SortingProver.get_conjuncts(hypothesis.subterms[0])

            if conclusion in left_left_conjuncts:
                return composer.find_theorem("rule-imp-transitivity").apply(
                    composer.find_theorem("and-elim-left-sugar").apply(
                        ph0=hypothesis.subterms[0], ph1=hypothesis.subterms[1]
                    ),
                    SortingProver.prove_multiple_sorting_judgements(
                        composer,
                        hypothesis.subterms[0],
                        conclusion,
                    ),
                )
            else:
                return composer.find_theorem("rule-imp-transitivity").apply(
                    composer.find_theorem("and-elim-right-sugar").apply(
                        ph0=hypothesis.subterms[0], ph1=hypothesis.subterms[1]
                    ),
                    SortingProver.prove_multiple_sorting_judgements(
                        composer,
                        hypothesis.subterms[1],
                        conclusion,
                    ),
                )

        assert isinstance(
            conclusion_term, Application
        ), f"unable to prove sorting judgement ( \\imp {hypothesis} {conclusion} )"

        sorting_lemma = SortingProver.find_sorting_lemma_for_symbol(
            composer, conclusion_term.symbol
        )
        assert (
            sorting_lemma is not None
        ), f"unable to find sorting lemma for symbol {conclusion_term.symbol}"

        sorting_lemma_term = SortingProver.is_provability_statement(
            sorting_lemma.statement
        )

        if SortingProver.is_in_sort(sorting_lemma_term) is not None:
            sorting_lemma_rhs = sorting_lemma_term
        else:
            sorting_lemma_rhs = sorting_lemma_term.subterms[1]

        substitution = Unification.match_terms_as_instance(
            sorting_lemma_rhs, conclusion
        )

        assert (
            substitution is not None
        ), f"unable to unify the conclusion {conclusion} with the sorting lemma |- {sorting_lemma_term}"
        assert set(substitution.keys()).issubset(
            sorting_lemma.statement.get_metavariables()
        ), f"free metavariables left unused in the sorting lemma |- {sorting_lemma_term}"

        subproof = sorting_lemma.apply(**substitution)

        # we can prove the conclusion directly without using hypotheses
        if SortingProver.is_in_sort(sorting_lemma_term) is not None:
            assert (
                subproof.statement.terms[1] == conclusion
            ), f"unable to prove sorting judgement ( \\imp {hypothesis} {conclusion} )"

            return composer.find_theorem("proof-rule-mp").apply(
                composer.find_theorem("proof-rule-prop-1").apply(
                    ph0=conclusion, ph1=hypothesis
                ),
                subproof,
            )

        # this statement should also be a implication
        # we prove the left hand side of our target
        # implies the left hand side of this statement
        subgoal = subproof.statement.terms[1].subterms[0]

        return composer.find_theorem("rule-imp-transitivity").apply(
            SortingProver.prove_multiple_sorting_judgements(
                composer, hypothesis, subgoal
            ),
            subproof,
        )

    @staticmethod
    def prove_multiple_sorting_judgements(
        composer: Composer, hypothesis: Term, conclusion: Term
    ) -> Proof:
        # see if we have already cached the result
        cached_proof = composer.lookup_proof_cache(
            "sorting-cache", SortingProver.construct_imp_goal(hypothesis, conclusion)
        )
        if cached_proof is not None:
            return cached_proof

        if isinstance(conclusion, Application) and conclusion.symbol == "\\and":
            # top level must be an \and, so we break it into two goals
            return composer.cache_proof(
                "sorting-cache",
                composer.find_theorem("rule-and-intro-alt2-sugar").apply(
                    SortingProver.prove_multiple_sorting_judgements(
                        composer, hypothesis, conclusion.subterms[0]
                    ),
                    SortingProver.prove_multiple_sorting_judgements(
                        composer, hypothesis, conclusion.subterms[1]
                    ),
                ),
            )

        return composer.cache_proof(
            "sorting-cache",
            SortingProver.prove_single_sorting_judgement(
                composer, hypothesis, conclusion
            ),
        )

    r"""
    Prove a statement of the form:
    |- ( \imp <hypotheses> ( conjunction of the form of either ( \in-sort ph0 ph1 ) or ( \kore-is-sort ph0 ) ) )
    """

    @staticmethod
    def prove_sorting_statement(
        composer: Composer, statement: StructuredStatement
    ) -> Proof:
        term = SortingProver.is_provability_statement(statement)
        assert term is not None, f"statement {statement} is not a provability claim"

        # if the top level is not \imp (i.e. if there is no hypotheses/sorting environment)
        if isinstance(term, Application) and term.symbol != "\\imp":
            return composer.find_theorem("proof-rule-mp").apply(
                SortingProver.prove_multiple_sorting_judgements(
                    composer, Application("\\top"), term
                ),
                composer.find_theorem("top-intro").apply(),
            )

        hypothesis, conclusion = term.subterms
        return SortingProver.prove_multiple_sorting_judgements(
            composer, hypothesis, conclusion
        )

    @staticmethod
    def prove_sorting(
        composer: Composer, term: Term, sort: Term, free_var_sorts: Mapping[str, Term]
    ) -> Proof:
        # construct the hypotheses
        hypotheses = [
            SortingProver.in_sort(var, sort) for var, sort in free_var_sorts.items()
        ]

        if len(hypotheses) == 0:
            hypothesis = Application("\\top")
        else:
            hypothesis = hypotheses[-1]
            for hyp in hypotheses[:-1][::-1]:
                hypothesis = Application("\\and", [hyp, hypothesis])

        return SortingProver.prove_sorting_statement(
            composer,
            SortingProver.construct_imp_goal(
                hypothesis, SortingProver.in_sort(term, sort)
            ),
        )

    auto = MethodAutoProof(prove_sorting_statement.__func__)
