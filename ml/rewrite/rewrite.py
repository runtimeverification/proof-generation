from typing import Optional, List, Tuple, Mapping, Union, Set

from traceback import print_exc

from ml.kore import ast as kore
from ml.kore.utils import KoreUtils, PatternPath
from ml.kore.ast import KoreVisitor
from ml.kore.visitors import PatternVariableVisitor

from ml.metamath import ast as mm
from ml.metamath.composer import Theorem, Proof
from ml.metamath.auto.sorting import SortingProver

from .encoder import KoreEncoder

from .env import KoreComposer, ProofGenerator, ProvableClaim
from .equality import EqualityProofGenerator
from .quantifier import QuantifierProofGenerator
from .unification import UnificationProofGenerator, InjectionCombine, UnificationResult, AdditionalEquation
from .templates import KoreTemplates
from .disjointness import DisjointnessProofGenerator
from .propositional import PropositionalProofGenerator
from .substitution import SingleSubstitutionProofGenerator
from .tasks import RewritingStep, RewritingTask, ConstrainedPattern, Substitution, AppliedRule


class RewriteProofGenerator(ProofGenerator):
    """
    Generate proofs for rewriting related claims
    """
    def __init__(self, env: KoreComposer):
        super().__init__(env)
        self.owise_assumption_counter = 0
        self.rewrite_claim_counter = 0
        self.simplification_counter = 0
        self.pattern_subsumption_counter = 0
        self.kore_is_predicate_counter = 0
        self.sorting_hypotheses_counter = 0
        self.hooked_symbol_evaluators = {
            "Lbl'UndsPlus'Int'Unds'": IntegerAdditionEvaluator(env),
            "Lbl'Unds'-Int'Unds'": IntegerSubtractionEvaluator(env),
            "Lbl'UndsStar'Int'Unds'": IntegerMultiplicationEvaluator(env),
            "Lbl'UndsSlsh'Int'Unds'": IntegerDivisionEvaluator(env),
            "Lbl'Unds-GT-Eqls'Int'Unds'": IntegerGreaterThanOrEqualToEvaluator(env),
            "Lbl'Unds-LT-Eqls'Int'Unds'": IntegerLessThanOrEqualToEvaluator(env),
            "Lbl'UndsEqlsEqls'Int'Unds'": IntegerEqualityEvaluator(env),
            "Lbl'Unds'andBool'Unds'": BooleanAndEvaluator(env),
            "LblnotBool'Unds'": BooleanNotEvaluator(env),
            "Lbl'UndsEqlsEqls'K'Unds'": KEqualityEvaluator(env),
            "Lbl'UndsEqlsSlshEqls'K'Unds'": KNotEqualityEvaluator(env),
            "LblMap'Coln'lookup": MapLookupEvaluator(env),
        }
        self.disjoint_gen = DisjointnessProofGenerator(env)

    def destruct_rewrite_axiom(
        self,
        pattern: Union[kore.Pattern, kore.Axiom, ProvableClaim],
        separate_lhs: bool = True,
        separate_rhs: bool = True,
    ) -> Tuple[kore.Pattern, Optional[kore.Pattern], kore.Pattern, Optional[kore.Pattern]]:
        """
        Returns (lhs, lhs requires, rhs, rhs ensures)
        """

        if isinstance(pattern, ProvableClaim):
            pattern = pattern.claim.pattern
        elif isinstance(pattern, kore.Axiom):
            pattern = pattern.pattern

        rewrite_pattern = KoreUtils.strip_forall(pattern)

        assert isinstance(rewrite_pattern, kore.MLPattern) and (
            rewrite_pattern.construct == kore.MLPattern.REWRITES
            or rewrite_pattern.construct == kore.MLPattern.REWRITES_STAR
        )

        lhs, rhs = rewrite_pattern.arguments

        lhs_requires: Optional[kore.Pattern] = None
        rhs_ensures: Optional[kore.Pattern] = None

        if separate_lhs and KoreUtils.is_and(lhs):
            lhs_requires, lhs_body = KoreUtils.destruct_and(lhs)
        else:
            lhs_body = lhs

        if separate_rhs and KoreUtils.is_and(rhs):
            rhs_ensures, rhs_body = KoreUtils.destruct_and(rhs)
        else:
            rhs_body = rhs

        return lhs_body, lhs_requires, rhs_body, rhs_ensures

    def check_equal_or_unify(self, given: kore.Pattern, expected: kore.Pattern) -> Optional[ProvableClaim]:
        """
        Check if <given> === <expected> syntactically
        if not try to unify and return a proof that
        given =>* expected
        if they don't unify, raise an exception

        NOTE: no rewriting is involved here, it's stated as a rewriting
        claim so that we can apply transitivity more easily
        """

        if given == expected:
            return None

        unification_result = UnificationProofGenerator(self.composer).unify_patterns(expected, given)
        assert unification_result is not None, \
               f"expecting the following patterns to be equal or unifiable: {given} and {expected}"

        assert len(unification_result.substitution) == 0, \
               "patterns should be concrete"

        simplification_claim = self.apply_rewrites_star_reflexivity(expected)

        for equation, path in unification_result.applied_equations:
            print("> applying unification equation", equation)
            simplification_claim = equation.replace_equal_subpattern(simplification_claim, [0, 0] + path)

        _, _, rhs, _ = self.destruct_rewrite_axiom(simplification_claim)
        assert rhs == expected, "unexpected unification"

        return simplification_claim

    def check_smt_unsat(
        self,
        pattern: kore.Pattern,
    ) -> ProvableClaim:
        claim = self.composer.construct_claim(KoreUtils.construct_not(pattern))

        print("SMT unsat obligation:")
        KoreUtils.pretty_print(claim)

        return self.composer.load_fresh_claim_placeholder("smt-obligation-counter", claim)

    def check_smt_implication(
        self,
        premise: kore.Pattern,
        conclusion: kore.Pattern,
    ) -> ProvableClaim:
        """
        Check an implication using an SMT solver
        but without producing an explicity proof in metamath
        """
        claim = self.composer.construct_claim(KoreUtils.construct_implies(premise, conclusion))

        if premise == conclusion:
            # trivial implication
            return self.composer.apply_kore_lemma("kore-implies-reflexivity", goal=claim)

        # TODO: should probably change the name prove_requires_clause
        # check if conclusion is trivial
        conclusion_validity = self.prove_requires_clause(conclusion)
        if conclusion_validity is not None:
            return self.composer.apply_kore_lemma(
                "kore-weakening",
                conclusion_validity,
                ph2=premise,
            )

        # TODO: call SMT solver and check
        print("SMT proof obligation:")
        KoreUtils.pretty_print(claim.pattern)

        return self.composer.load_fresh_claim_placeholder("smt-obligation-counter", claim)

    def prove_trivial_subsumption(
        self,
        pattern1: ConstrainedPattern,
        pattern2: ConstrainedPattern,
    ) -> Optional[ProvableClaim]:
        """
        Try to prove the subsumption if it's trivial
        (the terms are unifiable without using constraints)
        """

        unification_result = UnificationProofGenerator(self.composer).unify_patterns(pattern1.pattern, pattern2.pattern)
        # we can not instantiate variables here so the substitution must be empty
        if unification_result is None or len(unification_result.substitution) != 0:
            return None

        claim = PropositionalProofGenerator(self.composer).apply_implies_reflexivity(pattern1.as_pattern())

        pattern1_constraint = pattern1.get_constraint()
        pattern2_constraint = pattern2.get_constraint()

        if pattern1_constraint != pattern2_constraint:
            # check that the constraint of pattern1
            # implies the constraint the pattern2,
            # if they are not the same

            # TODO: should probably change the name prove_requires_clause
            constraint_imp = self.check_smt_implication(pattern1_constraint, pattern2_constraint)
            claim = self.composer.apply_kore_lemma("kore-imp-conj-simplify", constraint_imp, claim)

        for equation, path in unification_result.applied_equations:
            claim = equation.replace_equal_subpattern(claim, [0, 1, 1] + path)  # rhs

        return claim

    def apply_constraint_equation(
        self,
        claim: ProvableClaim,
        equation: Tuple[kore.Pattern, kore.Pattern],
        reverse: bool,
        position: PatternPath,
    ) -> ProvableClaim:
        r"""
        Assume the claim has the form
        lhs -> constraint /\ rhs
        And the equation E is present as a conjunct in constraint

        We apply E to rhs at <position> and return a proof of
        lhs -> constraint /\ rhs[E/position]
        """

        equation_sort = KoreUtils.infer_sort(equation[0])

        # locate the position of the equality in the conjunction
        _, rhs = KoreUtils.destruct_implies(claim.claim.pattern)
        constraint, rhs_term = KoreUtils.destruct_and(rhs)
        constraint_equalities = KoreUtils.destruct_nested_and(constraint)

        for i, equality in enumerate(constraint_equalities):
            if KoreUtils.is_equals(equality):
                eq_lhs, eq_rhs = KoreUtils.destruct_equals(equality)
                if eq_lhs == equation[0] and eq_rhs == equation[1]:
                    eq_position = i
                    break
        else:
            assert False, f"failed to find equation {equation[0]} = {equation[1]} in the constraint {constraint}"

        prop_gen = PropositionalProofGenerator(self.composer)

        # constraint <-> (rest /\ target_equation)
        constraint_shuffle = prop_gen.shuffle_nested(kore.MLPattern.AND, constraint, eq_position)
        constraint_shuffle = prop_gen.apply_iff_transitivity(
            constraint_shuffle,
            prop_gen.apply_commutativity(
                kore.MLPattern.AND,
                KoreUtils.destruct_iff(constraint_shuffle.claim.pattern)[1]
            ),
        )
        _, shuffled_constraint = KoreUtils.destruct_iff(constraint_shuffle.claim.pattern)

        # constraint /\ rhs_term <-> (rest /\ target_equation) /\ rhs_term
        shuffle = prop_gen.apply_iff_compatibility(
            kore.MLPattern.AND,
            constraint_shuffle,
            prop_gen.apply_iff_reflexivity(rhs_term),
        )

        all_metavars = {KoreEncoder.encode_variable(var) for var in PatternVariableVisitor().visit(rhs_term)}
        fresh_var, = self.composer.gen_fresh_metavariables("#ElementVariable", 1, all_metavars)

        var = kore.Variable(fresh_var, equation_sort)
        var.resolve(self.composer.module)
        template_rhs_term = KoreUtils.copy_and_replace_path_by_pattern_in_pattern(rhs_term, position, var)

        new_rhs_term1 = KoreUtils.copy_and_substitute_pattern(template_rhs_term, {var: equation[0]})
        new_rhs_term2 = KoreUtils.copy_and_substitute_pattern(template_rhs_term, {var: equation[1]})

        goal = self.composer.construct_claim(
            KoreUtils.construct_iff(
                KoreUtils.construct_and(shuffled_constraint, new_rhs_term1),
                KoreUtils.construct_and(shuffled_constraint, new_rhs_term2),
            ),
        )

        eq_claim = self.composer.apply_kore_lemma(
            "kore-equality-in-constraint",
            x=var,
            ph5=template_rhs_term,
            goal=goal,
        )

        if reverse:
            eq_claim = prop_gen.apply_iff_symmetry(eq_claim)
            final_rhs_term = new_rhs_term1
        else:
            final_rhs_term = new_rhs_term2

        # shuffle the constraint back to the original form
        # (rest /\ target_equation) /\ new_rhs_term <-> constraint /\ rhs_term
        unshuffle = prop_gen.apply_iff_compatibility(
            kore.MLPattern.AND,
            prop_gen.apply_iff_symmetry(constraint_shuffle),
            prop_gen.apply_iff_reflexivity(final_rhs_term),
        )

        final_claim = prop_gen.apply_iff_multiple_transitivity(
            shuffle,
            eq_claim,
            unshuffle,
        )

        # now connect with the original implication
        return prop_gen.apply_implies_transitivity(
            claim,
            prop_gen.apply_iff_elim_left(final_claim),
        )

    def prove_constrained_pattern_subsumption(
        self,
        pattern1: ConstrainedPattern,
        pattern2: ConstrainedPattern,
    ) -> ProvableClaim:
        r"""
        Show that a constrained pattern imply another
        """

        pattern1_constraint = pattern1.get_constraint()
        pattern2_constraint = pattern2.get_constraint()

        constraint_equalities = self.get_equalities_in_constraint(pattern1_constraint)

        unification_result = \
            UnificationProofGenerator(self.composer, constraint_equalities)\
                .unify_patterns(pattern1.pattern, pattern2.pattern)

        # we can not instantiate variables here so the substitution must be empty
        assert unification_result is not None and len(unification_result.substitution) == 0, \
               f"failed to prove {pattern1.as_pattern()} is subsumed by {pattern2.as_pattern()}"

        claim = PropositionalProofGenerator(self.composer).apply_implies_reflexivity(pattern1.as_pattern())

        for equation, path in unification_result.applied_equations:
            if isinstance(equation, AdditionalEquation):
                claim = self.apply_constraint_equation(
                    claim, constraint_equalities[equation.equation_index], equation.reverse, path
                )
            else:
                claim = equation.replace_equal_subpattern(claim, [0, 1, 1] + path)  # rhs

        if pattern1_constraint != pattern2_constraint:
            # check that the constraint of pattern1
            # implies the constraint the pattern2,
            # if they are not the same
            constraint_imp = self.check_smt_implication(pattern1_constraint, pattern2_constraint)
            claim = self.composer.apply_kore_lemma("kore-imp-conj-simplify", constraint_imp, claim)

        lhs, rhs = KoreUtils.destruct_implies(claim.claim.pattern)
        assert lhs == pattern1.as_pattern() and rhs == pattern2.as_pattern(), \
               f"unexpected result"

        counter = self.pattern_subsumption_counter
        self.pattern_subsumption_counter += 1

        return self.composer.load_provable_claim_as_theorem(f"pattern-subsumption-{counter}", claim)

    def remove_ensures(
        self,
        rewrite_claim: ProvableClaim,
    ) -> ProvableClaim:
        """
        Removes the ensure clause from a rewrite claim
        """
        _, _, _, ensures = self.destruct_rewrite_axiom(rewrite_claim, separate_lhs=False)
        assert ensures is not None

        if not KoreUtils.is_top(ensures):
            print(f"> warning: non-top ensures clause ignored: {ensures}")

        return self.composer.apply_kore_lemma("kore-rewrites-ignore-ensures", rewrite_claim)

    def prove_kore_is_predicate(
        self,
        constrained_pattern: ConstrainedPattern,
    ) -> Proof:
        r"""
        Prove that a constraint is a kore prediate (\kore-is-predicate)
        """

        constraint = constrained_pattern.get_constraint()
        sort = KoreUtils.infer_sort(constraint)

        encoded_constraint = self.composer.encode_pattern(constraint)
        encoded_sort = self.composer.encode_pattern(sort)

        counter = self.kore_is_predicate_counter
        self.kore_is_predicate_counter += 1

        # TODO: actually prove this
        theorem = self.composer.load_proof_as_statement(
            f"kore-is-predicate-lemma-{counter}",
            Proof.from_script(
                mm.StructuredStatement(
                    "", (
                        mm.Application("|-"),
                        mm.Application("\\kore-is-predicate", (encoded_sort, encoded_constraint)),
                    )
                ), "?"
            )
        )

        return theorem.as_proof()

    def get_equalities_in_constraint(self, constraint: kore.Pattern) -> Tuple[Tuple[kore.Pattern, kore.Pattern], ...]:
        if KoreUtils.is_and(constraint):
            left, right = KoreUtils.destruct_and(constraint)
            return self.get_equalities_in_constraint(left) + self.get_equalities_in_constraint(right)
        elif KoreUtils.is_equals(constraint):
            left, right = KoreUtils.destruct_equals(constraint)
            return (left, right),
        else:
            return ()

    def prove_symbolic_branch(
        self,
        initial: ConstrainedPattern,
        applied_rule: AppliedRule,
    ) -> ProvableClaim:
        r"""
        Prove a single branch in one step of symbolic execution

        Given a initial constrained term phi /\ psi /\ sigma
        where phi is the term, psi is the constraint, and sigma is the substitution
        
        and a final term phi' /\ psi' /\ sigma'
        
        Assuming psi' /\ sigma' -> psi /\ sigma

        We try to prove and return
        phi /\ psi' /\ sigma' => phi' /\ psi' /\ sigma'
        """
        assert applied_rule.substitution is not None and \
               applied_rule.rule_id is not None, \
               f"symbolic execution requires backend hints"

        assert len(applied_rule.results) == 1, \
               f"splitting in equations is currently not supported"

        final = applied_rule.results[0]

        config_free_vars = KoreUtils.get_free_variables(initial.pattern)

        # TODO: the hint sometimes prefers rule variables as keys
        # we need to revert them
        oriented_substitution = applied_rule.substitution.orient(config_free_vars)
        _, rule_substitution = oriented_substitution.split(config_free_vars)

        rewrite_axiom = self.composer.rewrite_axioms[applied_rule.rule_id]

        lhs, _, rhs, _ = self.destruct_rewrite_axiom(rewrite_axiom)
        lhs = KoreUtils.copy_and_substitute_pattern(lhs, rule_substitution.substitution)
        rhs = KoreUtils.copy_and_substitute_pattern(rhs, rule_substitution.substitution)

        # we also consider a extra set of equalities in the constraint
        unification_gen = UnificationProofGenerator(self.composer, self.get_equalities_in_constraint(final.constraint))

        # unify the LHS with the initial pattern
        lhs_unification_result = unification_gen.unify_patterns(lhs, initial.pattern)
        assert lhs_unification_result is not None, \
               f"unable to unify the LHS of {applied_rule.rule_id} with the initial pattern {initial.pattern}"

        instantiated_axiom = QuantifierProofGenerator(self.composer).prove_functional_pattern_substitution(
            rewrite_axiom,
            {
                **rule_substitution.substitution,
                **lhs_unification_result.substitution
            },
        )
        instantiated_axiom = self.remove_ensures(instantiated_axiom)
        instantiated_axiom = self.simplify_pattern(instantiated_axiom, [0, 1])  # rhs
        instantiated_axiom = self.simplify_pattern(instantiated_axiom, [0, 0, 0])  # requires clause

        lhs, requires, rhs, _ = self.destruct_rewrite_axiom(instantiated_axiom)
        assert requires is not None

        # TODO: simplify the requires clause here?

        # prove final_constraint /\ initial_term -> requires /\ lhs
        simplification1 = self.prove_constrained_pattern_subsumption(
            ConstrainedPattern(initial.pattern, final.constraint),
            ConstrainedPattern(lhs, requires),
        )

        # prove final_constraint /\ rhs -> final_constraint /\ final_term
        simplification2 = self.prove_constrained_pattern_subsumption(
            ConstrainedPattern(rhs, final.constraint),
            final,
        )

        # requires /\ lhs -> rhs
        # ---------------------- (by simplification1)
        # final_constraint /\ initial_term -> rhs
        claim = self.composer.apply_kore_lemma(
            "kore-rewrites-subsumption-lhs",
            simplification1,
            instantiated_axiom,
        )

        # final_constraint /\ initial_term -> rhs
        # --------------------------------------- (add constraint to RHS)
        # final_constraint /\ initial_term -> final_constraint /\ rhs
        claim = self.composer.apply_kore_lemma(
            "kore-rewrites-constraint-lemma",
            claim,
        )

        # final_constraint /\ initial_term -> final_constraint /\ rhs
        # ----------------------------------------------------------- (by simplification2)
        # final_constraint /\ initial_term -> final_constraint /\ final_term
        claim = self.composer.apply_kore_lemma(
            "kore-rewrites-subsumption-rhs",
            claim,
            simplification2,
        )

        return claim

    def combine_branches(
        self,
        rewrite1: ProvableClaim,
        rewrite2: ProvableClaim,
    ) -> ProvableClaim:
        r"""
        Given two provable claims
          psi_1 /\ phi =>* phi'_1
          psi_2 /\ phi =>* phi'_2

        return a provable claim
          (psi_1 \/ psi_2) /\ phi =>* phi'_1 \/ phi'_2
        """

        lhs1, left_constraints1, _, _ = self.destruct_rewrite_axiom(rewrite1, separate_rhs=False)
        lhs2, left_constraints2, _, _ = self.destruct_rewrite_axiom(rewrite2, separate_rhs=False)
        assert lhs1 == lhs2, f"{lhs1} != {lhs2}"
        assert left_constraints1 is not None and left_constraints2 is not None

        return self.composer.apply_kore_lemma(
            "kore-rewrites-star-union",
            rewrite1,
            rewrite2,
        )

    def prove_symbolic_step(
        self,
        step_index: int,
        step: RewritingStep,
    ) -> Tuple[ProvableClaim, Theorem]:
        """
        Prove that the initial pattern in the step
        rewrites to the union of all final patterns
        """

        initial_pattern = step.get_initial_pattern()

        # TODO: maybe we need to change the free variable name to avoid conflict

        assert len(step.applied_rules) != 0
        branches = [self.prove_symbolic_branch(initial_pattern, applied_rule) for applied_rule in step.applied_rules]

        # TODO: prune branches with unsatisfiable constraints

        # no changes to the remainder
        for remainder in step.remainders:
            branches.append(self.apply_rewrites_star_reflexivity(remainder.as_pattern()))

        # print(branches[-1].claim)
        step_claim = self.apply_rewrites_star_intro(branches[-1])
        for branch in branches[:-1][::-1]:
            # print(branch.claim)
            step_claim = self.combine_branches(self.apply_rewrites_star_intro(branch), step_claim)

        # prove that the initial constraint
        # implies the disjunction of all cases
        lhs, _, _, _ = self.destruct_rewrite_axiom(step_claim, separate_lhs=False)
        lhs_constraint, lhs_term = KoreUtils.destruct_and(lhs)

        assert lhs_term == initial_pattern.pattern

        # prove that the union of all branch conditions cover the initial constraint
        constraint_splitting = self.check_smt_implication(
            initial_pattern.get_constraint(),
            lhs_constraint,
        )

        simplification_claim = self.composer.apply_kore_lemma(
            "kore-rewrites-star-constraint-simplification",
            constraint_splitting,
            goal=self.composer.construct_claim(KoreUtils.construct_rewrites_star(initial_pattern.as_pattern(), lhs)),
            ph3=self.composer.encode_pattern(lhs_term),
        )

        theorem_name = f"symbolic-step-{step_index}"

        final_claim = self.apply_rewrites_star_transitivity(simplification_claim, step_claim)
        final_claim = self.composer.load_provable_claim_as_theorem(theorem_name, final_claim)

        return final_claim, self.composer.get_theorem(theorem_name)

    def connect_symbolic_steps(self, step1: ProvableClaim, step2: ProvableClaim) -> ProvableClaim:
        r"""
        step1 = |- phi_0 =>* phi_1 \/ ... \/ phi_n
        step2 = |- phi_i =>* psi_1 \/ ... \/ psi_m, where i in { 1, ..., n }
        ------------------------------------------------------------------
        phi_0 =>* phi_1 \/ ... \/ (psi_1 \/ ... \/ psi_m) \/ ... phi_n
    
        (order of disjunctions may not be exactly like this)
        """

        _, rhs1 = KoreUtils.destruct_rewrites_star(step1.claim.pattern)
        lhs2, _ = KoreUtils.destruct_rewrites_star(step2.claim.pattern)
        lhs2_constraint, lhs2_term = KoreUtils.destruct_and(lhs2)

        branches1 = KoreUtils.destruct_nested_or(rhs1)

        # unify lhs2 with any of the branches
        unification_gen = UnificationProofGenerator(self.composer)
        for i, branch in enumerate(branches1):
            branch_constraint, branch_term = KoreUtils.destruct_and(branch)
            unification_result = unification_gen.unify_patterns(lhs2_term, branch_term)

            if lhs2_constraint == branch_constraint and \
               unification_result is not None and \
               len(unification_result.substitution) == 0:

                lhs2_index = i

                for eqn, path in unification_result.applied_equations:
                    step2 = eqn.replace_equal_subpattern(step2, [0, 0, 1] + path)

                break
        else:
            assert False, f"unable to unify {lhs2} with any of the branches in {rhs1}"

        if len(branches1) == 1:
            return self.apply_rewrites_star_transitivity(step1, step2)

        # now we assume there are at least 2 branches in step1

        prop_gen = PropositionalProofGenerator(self.composer)

        rhs1_shuffle = prop_gen.apply_iff_elim_left(prop_gen.shuffle_nested(kore.MLPattern.OR, rhs1, lhs2_index))

        step1 = self.composer.apply_kore_lemma(
            "kore-rewrites-star-subsumption-rhs",
            step1,
            rhs1_shuffle,
        )

        # since we assumed we have at least 2 branches
        # _, other_branches = KoreUtils.destruct_or(shuffled_rhs1)

        return self.composer.apply_kore_lemma("kore-rewrites-star-branch", step1, step2)

    def preprocess_task(self, task: RewritingTask) -> None:
        """
        Does two things:
        - simplify the final results for each step
        - Replace all free variables with a constant. We would
          end up proving an equivalent thing but it's easier to
          do this way.
        """

        # free_variables = KoreUtils.get_free_variables(task.initial.as_pattern())
        # concretization_substitution = {}

        # for free_var in free_variables:
        #     concretization_substitution[free_var] = self.composer.add_concretized_variable(free_var)

        # task.concretize(concretization_substitution)

        for step in task.steps:
            for applied_rule in step.applied_rules:
                simplified_results = []
                for result in applied_rule.results:
                    simplified = self.simplify_without_proof(result.as_pattern())
                    simplified_results.append(ConstrainedPattern.from_pattern(simplified))
                applied_rule.results = tuple(simplified_results)

    def match_with_final_results(self, task: RewritingTask, claim: ProvableClaim, start_from: int = 0) -> ProvableClaim:
        _, rhs = KoreUtils.destruct_rewrites_star(claim.claim.pattern)
        branches = KoreUtils.destruct_nested_or(rhs)

        unification_gen = UnificationProofGenerator(self.composer)
        prop_gen = PropositionalProofGenerator(self.composer)

        for i, branch in enumerate(branches[start_from:], start_from):
            branch_constraint, branch_term = KoreUtils.destruct_and(branch)

            for final in task.finals:
                unification_result = unification_gen.unify_patterns(branch_term, final.pattern)

                if branch_constraint == final.get_constraint() and \
                   unification_result is not None and \
                   len(unification_result.substitution) == 0:
                    # TODO: apply the equations to rhs
                    break
            else:
                # cannot find a final pattern that matches the branch
                # then we will try to show that the constraint is
                # unsatifiable and prune this branch
                assert len(branches) > 1, "pruning the only branch"

                constraint_unsat = self.check_smt_unsat(branch_constraint)
                rhs_shuffle = prop_gen.apply_iff_elim_left(prop_gen.shuffle_nested(kore.MLPattern.OR, rhs, i))

                # connect with the existing claim
                claim = self.composer.apply_kore_lemma(
                    "kore-rewrites-star-subsumption-rhs",
                    claim,
                    rhs_shuffle,
                )

                # prune this branch
                claim = self.composer.apply_kore_lemma("kore-rewrites-star-prune", constraint_unsat, claim)

                # recurse to prune the rest
                return self.match_with_final_results(task, claim, start_from=i)

        return claim

    def prove_symbolic_rewriting_task(self, task: RewritingTask) -> ProvableClaim:
        """
        Prove a rewriting task which may contain multiple rewrite steps,
        from the given hints
        """

        print("preprocess rewriting task")
        self.preprocess_task(task)

        step_claims = []
        step_theorems = []

        for i, step in enumerate(task.steps):
            print(f"######## symbolic step {i} ########")
            claim, theorem = self.prove_symbolic_step(i, step)
            step_claims.append(claim)
            step_theorems.append(theorem)

        # TODO: not using task.initial and task.final yet

        # connect all steps together
        # with self.composer.new_context():
        initial_pattern = task.get_initial_pattern().as_pattern()

        # assuming that the set of free variables will not increase
        # self.add_free_variable_sorting_hypotheses(initial_pattern)

        # simplify initial pattern
        print("######## simplifying initial claim ########")
        final_claim = self.apply_rewrites_star_reflexivity(initial_pattern)
        final_claim = self.simplify_pattern(final_claim, [0, 1])

        # we need to replace the sorting essentials with the new ones present in the current context
        claims = [ProvableClaim(claim.claim, theorem.as_proof()) for claim, theorem in zip(step_claims, step_theorems)]

        for i, claim in enumerate(claims):
            print(f"######## connecting symbolic step {i} ########")
            final_claim = self.connect_symbolic_steps(final_claim, claim)

        final_claim = self.composer.load_provable_claim_as_theorem("goal", final_claim)

        print(f"######## pruning unsatisfiable branch(es) ########")
        final_claim = self.match_with_final_results(task, final_claim)

        print("final claim:")
        KoreUtils.pretty_print(final_claim.claim)

        return final_claim

    def apply_rewrites_star_intro(self, step: ProvableClaim) -> ProvableClaim:
        """
        Transform a rewrite claim to a rewrite-star claim
        """
        if KoreUtils.is_rewrites_star(step.claim.pattern):
            return step

        return self.composer.apply_kore_lemma("kore-rewrites-star-intro", step)

    def apply_rewrites_star_transitivity(self, step1: ProvableClaim, step2: ProvableClaim) -> ProvableClaim:
        """
        Connect two rewrite-star claims
        """
        return self.composer.apply_kore_lemma("kore-rewrites-star-transitivity", step1, step2)

    def destruct_anywhere_axiom(
        self,
        pattern: Union[kore.Pattern, kore.Axiom, ProvableClaim],
    ) -> Tuple[kore.Pattern, kore.Pattern, kore.Pattern, kore.Pattern]:
        if isinstance(pattern, ProvableClaim):
            pattern = pattern.claim.pattern
        elif isinstance(pattern, kore.Axiom):
            pattern = pattern.pattern

        inner_pattern = KoreUtils.strip_forall(pattern)
        requires, conjunction = KoreUtils.destruct_implies(inner_pattern)
        equation, ensures = KoreUtils.destruct_and(conjunction)
        lhs, rhs = KoreUtils.destruct_equals(equation)

        return lhs, requires, rhs, ensures

    def prove_negation_requires(self, pattern: kore.Pattern) -> Optional[ProvableClaim]:
        r"""
        Try to prove ( \kore-not <pattern> )
        """

        # TODO: prove this
        return self.composer.load_fresh_claim_placeholder(
            "disjointness",
            self.composer.construct_claim(KoreUtils.construct_not(pattern)),
        )

        # if isinstance(pattern, kore.MLPattern):
        #     if pattern.construct == kore.MLPattern.OR:
        #         # reduce to proving each disjunct is bottom
        #         left, right = pattern.arguments

        #         left_proof = self.prove_negation_requires(left)
        #         right_proof = self.prove_negation_requires(right)

        #         if left_proof is None or right_proof is None:
        #             return None

        #         return self.composer.get_theorem("kore-de-morgan-alt").apply(
        #             left_proof,
        #             right_proof,
        #         )

        #     elif pattern.construct == kore.MLPattern.BOTTOM:
        #         encoded_sort = self.composer.encode_pattern(pattern.sorts[0])
        #         return self.composer.get_theorem("kore-not-bot").apply(ph0=encoded_sort, )

        #     elif pattern.construct == kore.MLPattern.EXISTS:
        #         # disjointness condition
        #         # right now we only support one variable with no side condition

        #         _, body = pattern.arguments

        #         # the following chunk of nonsense basically
        #         # checks that body is of the form
        #         # top /\ (<inner condition> /\ top)
        #         try:
        #             top, right = KoreUtils.destruct_and(body)
        #             assert KoreUtils.is_top(top)
        #             condition, top = KoreUtils.destruct_and(right)
        #             assert KoreUtils.is_top(top)

        #             if KoreUtils.is_ceil(condition):
        #                 # ( \ceil ( \and <left> <right> ) )
        #                 lemma = "owise-var-1-cond-0"
        #                 condition, = KoreUtils.destruct_ceil(condition)
        #                 left, right = KoreUtils.destruct_and(condition)
        #             else:
        #                 # ( \in <left> <right> )
        #                 lemma = "owise-var-1-cond-0-alt"
        #                 left, right = KoreUtils.destruct_in(condition)

        #             claim = self.composer.construct_claim(KoreUtils.construct_not(pattern))

        #             print("> proving disjointness claim")
        #             disjoint_proof = self.disjoint_gen.prove_disjointness(left, right)

        #             return self.composer.get_theorem(lemma).match_and_apply(
        #                 self.composer.encode_metamath_statement(claim),
        #                 disjoint_proof,
        #             )
        #         except:
        #             pass

        #     print(f"!!! unable to prove the validity of the negation of {pattern}")

        # return None

    def prove_equality(self, pattern: kore.MLPattern) -> Optional[ProvableClaim]:
        """
        Prove a equality after simplfication
        """

        lhs, rhs = KoreUtils.destruct_equals(pattern)
        input_sort, output_sort = pattern.sorts

        provable = self.composer.apply_kore_lemma(
            "kore-equals-reflexivity",
            ph0=output_sort,
            ph1=input_sort,
            ph2=lhs,
        )

        provable = self.simplify_pattern(provable, [0, 1])

        # failed to prove the condition
        _, new_rhs = KoreUtils.destruct_equals(provable.claim.pattern)
        if new_rhs != rhs:
            return None

        return provable

    def prove_requires_clause(self, pattern: kore.Pattern) -> Optional[ProvableClaim]:
        r"""
        Prove a pattern phi of the form
        - top{S{}}(), or
        - \equals{...}(..., ...)
        - \in{...}(..., ...)
        - \and{...}(phi1, phi2)

        For \equals, it can have either a concrete sort
        or a sort variable as the output sort
        """

        assert isinstance(pattern, kore.MLPattern)

        if pattern.construct == kore.MLPattern.AND:
            left, right = pattern.arguments
            left_proof = self.prove_requires_clause(left)
            right_proof = self.prove_requires_clause(right)

            if left_proof is None or right_proof is None:
                return None

            return self.composer.apply_kore_lemma("kore-and-intro-alt", left_proof, right_proof)

        # if the pattern is top, then it's trivially true
        if pattern.construct == kore.MLPattern.TOP:
            sort = pattern.sorts[0]
            return self.composer.apply_kore_lemma("kore-top-valid", ph0=sort)

        if pattern.construct == kore.MLPattern.EQUALS:
            return self.prove_equality(pattern)

        if pattern.construct == kore.MLPattern.IN:
            # expecting left and right hand side already unified
            left, right = pattern.arguments
            input_sort, output_sort = pattern.sorts

            if left == right:
                return self.composer.apply_kore_lemma(
                    "kore-in-reflexivity",
                    ph0=input_sort,
                    ph1=output_sort,
                    ph2=left,
                )

        if pattern.construct == kore.MLPattern.NOT:
            return self.prove_negation_requires(pattern.arguments[0])

        return None

    def resolve_unification_obligations_in_requires_clause(self, requires: kore.Pattern) -> Optional[UnificationResult]:
        if isinstance(requires, kore.MLPattern):
            if requires.construct == kore.MLPattern.AND:
                # resolve each side separately and combine
                left, right = requires.arguments
                left_unification = self.resolve_unification_obligations_in_requires_clause(left)
                right_unification = self.resolve_unification_obligations_in_requires_clause(right)

                if left_unification is None or right_unification is None:
                    return None

                return left_unification.prepend_path(0).merge(right_unification.prepend_path(1))

            elif requires.construct == kore.MLPattern.IN:
                left, right = requires.arguments

                # putting <right> in the left since at this point <right> is usually smybolic
                result = UnificationProofGenerator(self.composer).unify_patterns(right, left)
                if result is None:
                    return None

                return result.prepend_path(1)

        return UnificationResult()

    def match_and_instantiate_anywhere_axiom(self, axiom: ProvableClaim,
                                             pattern: kore.Pattern) -> Optional[ProvableClaim]:
        # unify the LHS
        lhs, requires, _, _ = self.destruct_anywhere_axiom(axiom)
        unification_result = UnificationProofGenerator(self.composer).unify_patterns(lhs, pattern)
        if unification_result is None:
            return None

        # prepend the path to the lhs in the equation:
        #   <requires> => <lhs> = <rhs> /\ <ensures>
        # which has path [0, 1, 0, 0] from the root
        unification_result = unification_result.prepend_path([0, 1, 0, 0])

        # there could be more unification conditions in the require clause
        requires_substituted = KoreUtils.copy_and_substitute_pattern(requires, unification_result.substitution)
        side_unification_result = self.resolve_unification_obligations_in_requires_clause(requires_substituted)

        if side_unification_result is None:
            return None

        # prepend the path from root to the requires clause
        side_unification_result = side_unification_result.prepend_path([0, 0])

        # merge it with the main unification result
        unification_result = unification_result.merge(side_unification_result)

        if unification_result is None:
            # side condition unification is inconsistent
            return None

        # eliminate all universal quantifiers
        instantiated_axiom = QuantifierProofGenerator(self.composer) \
            .prove_functional_pattern_substitution(axiom, unification_result.substitution)

        # apply equations used in unification
        for equation, path in unification_result.applied_equations:
            instantiated_axiom = equation.replace_equal_subpattern(instantiated_axiom, path)

        lhs, requires, _, ensures = self.destruct_anywhere_axiom(instantiated_axiom)

        # right now we don't support other forms of ensures clause
        if not KoreUtils.is_top(ensures):
            return None

        # from \implies{R}(<requires>, \and{R}(<equation>, top))
        # if we can prove the requires clause
        # we can get \and{R}(<equation>, top)
        requires_proof = self.prove_requires_clause(requires)
        if requires_proof is None:
            return None

        instantiated_axiom = self.composer.apply_kore_lemma(
            "kore-mp",
            requires_proof,
            instantiated_axiom,
        )

        # now we have a conjunction and{R}(<equation>, <ensures>)
        # since we assumed ensures is top, we can remove it as well
        # that is, from \and{R}(<equation>, top)
        # we can get <equation>
        instantiated_axiom = self.composer.apply_kore_lemma("kore-anp-top", instantiated_axiom)

        return instantiated_axiom

    def find_anywhere_axiom_for_pattern(self, pattern: kore.Pattern) -> ProvableClaim:
        """
        Find and instantiate a anywhere/function axiom for the given (function) pattern
        """

        assert isinstance(pattern, kore.Application), f"{pattern} is not an application"

        head_symbol = pattern.symbol
        assert (
            head_symbol in self.composer.equational_axioms
        ), f"head symbol {head_symbol} does not have any equational axioms associated to it"

        non_owise_axioms = []
        owise_axiom = None

        for axiom in self.composer.equational_axioms[head_symbol]:
            if axiom.claim.get_attribute_by_symbol("owise") is None:
                non_owise_axioms.append(axiom)
            else:
                assert owise_axiom is None, "multiple otherwise axioms"
                owise_axiom = axiom

        # find an anywhere/function rule to rewrite
        for axiom in non_owise_axioms:
            instantiated = self.match_and_instantiate_anywhere_axiom(axiom, pattern)
            if instantiated is not None:
                return instantiated

        # try owise if other ones failed to match
        if owise_axiom is not None:
            instantiated = self.match_and_instantiate_anywhere_axiom(owise_axiom, pattern)
            if instantiated is not None:
                return instantiated

        raise Exception(f"unable to find anywhere/function rule to rewrite term {pattern}")

    def is_simplifiable(self, pattern: kore.Pattern) -> bool:
        """
        Checks if the given pattern is "simplifiable", that is, if
        it contains duplicate injections and/or unevaluated functions
        """

        nested_inj_path = InnermostNestedInjectionPathVisitor(self.composer).visit(pattern)
        if nested_inj_path is not None:
            return True

        function_path = InnermostFunctionPathVisitor(self.composer).visit(pattern)
        if function_path is not None:
            return True

        return False

    def simplify_without_proof(self, pattern: kore.Pattern) -> kore.Pattern:
        """
        Simplify a pattern without proof
        """
        # with self.composer.new_context():
        # self.add_free_variable_sorting_hypotheses(pattern)
        dummy_claim = PropositionalProofGenerator(self.composer).apply_implies_reflexivity(pattern)
        simplified_claim = self.simplify_pattern(dummy_claim, [0, 0])
        simplified_pattern, _ = KoreUtils.destruct_implies(simplified_claim.claim.pattern)
        return simplified_pattern

    def simplify_pattern(self, provable: ProvableClaim, path: PatternPath, bound: int = -1) -> ProvableClaim:
        """
        Simplify the subpattern indicated by the path by
        - resolving functions
        - simplify nested injections
        at most <bound> times
        """

        num_simplifications = 0

        while bound == -1 or num_simplifications < bound:
            num_simplifications += 1

            subpattern = KoreUtils.get_subpattern_by_path(provable.claim, path)

            # simplify nested inj
            nested_inj_path = InnermostNestedInjectionPathVisitor(self.composer).visit(subpattern)
            if nested_inj_path is not None:
                print(f"> simplifying nested inj")
                provable = InjectionCombine(self.composer).replace_equal_subpattern(provable, path + nested_inj_path)
                continue

            # resolve unresolved functions
            function_path = InnermostFunctionPathVisitor(self.composer).visit(subpattern)
            if function_path is not None:
                function_subpattern = KoreUtils.get_subpattern_by_path(subpattern, function_path)
                assert isinstance(function_subpattern, kore.Application)
                print(f"> rewriting anywhere/function {function_subpattern.symbol}")

                # if the symbol is bulitin, try the builtin evaluator
                symbol_string = function_subpattern.symbol.get_symbol_name()
                if symbol_string in self.hooked_symbol_evaluators:
                    axiom = self.hooked_symbol_evaluators[symbol_string].prove_evaluation(function_subpattern)
                else:
                    axiom = self.find_anywhere_axiom_for_pattern(function_subpattern)

                # finish up the rewriting by substituting in the rhs
                provable = EqualityProofGenerator(self.composer
                                                  ).replace_equal_subpattern(provable, path + function_path, axiom)
                continue

            break

        return provable

    def apply_rewrites_star_reflexivity(self, pattern: kore.Pattern) -> ProvableClaim:
        return self.composer.apply_kore_lemma(
            "kore-rewrites-star-reflexivity",
            ph0=KoreUtils.infer_sort(pattern),
            ph1=pattern,
        )


class InnermostNestedInjectionPathVisitor(KoreVisitor[Union[kore.Pattern, kore.Axiom], Optional[PatternPath]]):
    def __init__(self, env: KoreComposer):
        super().__init__()
        self.composer = env

    def postvisit_variable(self, variable: kore.Variable) -> Optional[PatternPath]:
        return None

    def postvisit_string_literal(self, literal: kore.StringLiteral) -> Optional[PatternPath]:
        return None

    def postvisit_application(self, application: kore.Application) -> Optional[PatternPath]:
        for i, arg in enumerate(application.arguments):
            path = self.visit(arg)
            if path is not None:
                return [i] + path

        # if the current pattern is a nested injection
        if (application.symbol.definition == self.composer.sort_injection_symbol
                and isinstance(application.arguments[0], kore.Application)
                and application.arguments[0].symbol.definition == self.composer.sort_injection_symbol):
            return []

        return None

    def postvisit_ml_pattern(self, ml_pattern: kore.MLPattern) -> Optional[PatternPath]:
        for i, arg in enumerate(ml_pattern.arguments):
            path = self.visit(arg)
            if path is not None:
                return [i] + path

        return None


class InnermostFunctionPathVisitor(KoreVisitor[Union[kore.Pattern, kore.Axiom], Optional[PatternPath]]):
    """
    Return a path of an application subpattern with a function-like head such that
    it doesn't have any (sub-)subpattern with a function-like head
    """
    """
    These symbols are marked as hooked function symbols
    but for the purpose of proof generation they should
    be constructors
    """
    EXCEPTIONS = {
        "Lbl'UndsPipe'-'-GT-Unds'",
        "Lbl'Unds'Map'Unds'",
        "Lbl'Stop'Map",
    }
    """
    These functions can accept symbolic arguments
    """
    SYMBOLIC_FUNCTIONS = {
        "LblisKResult",

        # for top cell initialization
        "Lblproject'Coln'Pgm",
        "LblMap'Coln'lookup",
    }

    def __init__(self, composer: KoreComposer):
        super().__init__()
        self.composer = composer

    def postvisit_variable(self, variable: kore.Variable) -> Optional[PatternPath]:
        return None

    def postvisit_string_literal(self, literal: kore.StringLiteral) -> Optional[PatternPath]:
        return None

    def postvisit_application(self, application: kore.Application) -> Optional[PatternPath]:
        for i, arg in enumerate(application.arguments):
            path = self.visit(arg)
            if path is not None:
                return [i] + path

        # if the application itself is a function, return the empty path (pointing to itself)
        if (isinstance(application.symbol.definition, kore.SymbolDefinition)
                and application.symbol.definition.get_attribute_by_symbol("function") is not None):

            symbol_name = application.symbol.get_symbol_name()

            if symbol_name in InnermostFunctionPathVisitor.EXCEPTIONS:
                return None

            # do not find symbolic instances of concrete functions
            # (unless it's an initializer)
            # TODO: slightly hacky

            is_symbolic = len(KoreUtils.get_free_variables(application)) != 0 or \
                          self.composer.has_concretized_variable(application)

            if symbol_name not in InnermostFunctionPathVisitor.SYMBOLIC_FUNCTIONS and \
               is_symbolic and \
               application.symbol.definition.get_attribute_by_symbol("initializer") is None:
                return None

            return []

        return None

    def postvisit_ml_pattern(self, ml_pattern: kore.MLPattern) -> Optional[PatternPath]:
        for i, arg in enumerate(ml_pattern.arguments):
            path = self.visit(arg)
            if path is not None:
                return [i] + path

        return None


class BuiltinFunctionEvaluator(ProofGenerator):
    """
    Common base class for evaluator of the builtin sort SortInt{}
    """
    def __init__(self, env: KoreComposer):
        super().__init__(env)
        self.axiom_counter = 0

    def parse_int(self, value: kore.Pattern) -> int:
        assert (isinstance(value, kore.MLPattern) and value.construct == kore.MLPattern.DV)
        assert (isinstance(value.sorts[0], kore.SortInstance) and value.sorts[0].get_sort_id() == "SortInt")

        assert isinstance(value.arguments[0], kore.StringLiteral)
        return int(value.arguments[0].content)

    def parse_bool(self, value: kore.Pattern) -> bool:
        assert (isinstance(value, kore.MLPattern) and value.construct == kore.MLPattern.DV)
        assert (isinstance(value.sorts[0], kore.SortInstance) and value.sorts[0].get_sort_id() == "SortBool")
        assert isinstance(value.arguments[0], kore.StringLiteral)
        return {"true": True, "false": False}[value.arguments[0].content]

    def prove_evaluation(self, application: kore.Application) -> ProvableClaim:
        raise NotImplementedError()

    def build_equation(self, application: kore.Application, result: kore.Pattern) -> ProvableClaim:
        sort_var = kore.SortVariable("R")
        claim = self.composer.construct_claim(
            KoreUtils.construct_equals(sort_var, application, result),
            sort_variables=[sort_var],
        )

        # TODO: we need to generate a proof obligation for
        # this arithmetic fact
        with self.composer.in_segment("dv"):
            self.composer.load_comment("NOTE: domain value reasoning checked by external tool")
            thm = self.composer.load_axiom(
                claim,
                f"{self.composer.sanitize_label_name(application.symbol.get_symbol_name())}-domain-fact-{self.axiom_counter}",
                comment=False,
                provable=self.composer.dv_as_provable,
            )

        print(f"> bulitin symbol proof obligation: {claim}")

        self.axiom_counter += 1

        return ProvableClaim(claim, thm.as_proof())

    def build_arithmetic_equation(self, application: kore.Application, result: Union[int, bool]) -> ProvableClaim:
        """
        Build an axiom that says the given pattern
        is equal to the result, which is either an integer
        or a boolean

        Then we will potentially discharge a proof obligation to some domain value reasoning tool
        """
        output_sort = KoreUtils.infer_sort(application)

        if type(result) is bool:
            result_literal = "true" if result else "false"
        else:
            result_literal = str(result)

        return self.build_equation(application, KoreUtils.construct_dv(output_sort, result_literal))


class IntegerAdditionEvaluator(BuiltinFunctionEvaluator):
    def prove_evaluation(self, application: kore.Application) -> ProvableClaim:
        a, b = application.arguments
        return self.build_arithmetic_equation(application, self.parse_int(a) + self.parse_int(b))


class IntegerSubtractionEvaluator(BuiltinFunctionEvaluator):
    def prove_evaluation(self, application: kore.Application) -> ProvableClaim:
        a, b = application.arguments
        return self.build_arithmetic_equation(application, self.parse_int(a) - self.parse_int(b))


class IntegerMultiplicationEvaluator(BuiltinFunctionEvaluator):
    def prove_evaluation(self, application: kore.Application) -> ProvableClaim:
        a, b = application.arguments
        return self.build_arithmetic_equation(application, self.parse_int(a) * self.parse_int(b))


class IntegerDivisionEvaluator(BuiltinFunctionEvaluator):
    def prove_evaluation(self, application: kore.Application) -> ProvableClaim:
        a, b = application.arguments
        return self.build_arithmetic_equation(application, self.parse_int(a) // self.parse_int(b))


class IntegerGreaterThanOrEqualToEvaluator(BuiltinFunctionEvaluator):
    def prove_evaluation(self, application: kore.Application) -> ProvableClaim:
        a, b = application.arguments
        return self.build_arithmetic_equation(application, self.parse_int(a) >= self.parse_int(b))


class IntegerLessThanOrEqualToEvaluator(BuiltinFunctionEvaluator):
    def prove_evaluation(self, application: kore.Application) -> ProvableClaim:
        a, b = application.arguments
        return self.build_arithmetic_equation(application, self.parse_int(a) <= self.parse_int(b))


class IntegerEqualityEvaluator(BuiltinFunctionEvaluator):
    def prove_evaluation(self, application: kore.Application) -> ProvableClaim:
        a, b = application.arguments
        return self.build_arithmetic_equation(application, self.parse_int(a) == self.parse_int(b))


class BooleanAndEvaluator(BuiltinFunctionEvaluator):
    def prove_evaluation(self, application: kore.Application) -> ProvableClaim:
        a, b = application.arguments
        return self.build_arithmetic_equation(application, self.parse_bool(a) and self.parse_bool(b))


class BooleanNotEvaluator(BuiltinFunctionEvaluator):
    def prove_evaluation(self, application: kore.Application) -> ProvableClaim:
        (a, ) = application.arguments
        return self.build_arithmetic_equation(application, not self.parse_bool(a))


# TODO: we may need to define this in the prelude
class KEqualityEvaluator(BuiltinFunctionEvaluator):
    def prove_evaluation(self, application: kore.Application) -> ProvableClaim:
        a, b = application.arguments
        return self.build_arithmetic_equation(application, a == b)


class KNotEqualityEvaluator(BuiltinFunctionEvaluator):
    def prove_evaluation(self, application: kore.Application) -> ProvableClaim:
        a, b = application.arguments
        return self.build_arithmetic_equation(application, a != b)


class MapLookupEvaluator(BuiltinFunctionEvaluator):
    """
    Implements the K builtin function MAP.lookup
    """
    def lookup(self, map_pattern: kore.Application, key_pattern: kore.Pattern) -> Optional[kore.Pattern]:
        if KoreTemplates.is_map_unit_pattern(map_pattern):
            return None
        elif KoreTemplates.is_map_merge_pattern(map_pattern):
            left = KoreTemplates.get_map_merge_left(map_pattern)
            right = KoreTemplates.get_map_merge_right(map_pattern)
            assert isinstance(left, kore.Application) and isinstance(right, kore.Application)

            return self.lookup(left, key_pattern) or self.lookup(right, key_pattern)
        else:
            assert KoreTemplates.is_map_mapsto_pattern(map_pattern)
            key, value = map_pattern.arguments

            if key == key_pattern:
                return value

            return None

    def prove_evaluation(self, application: kore.Application) -> ProvableClaim:
        map_pattern, key_pattern = application.arguments
        assert isinstance(map_pattern, kore.Application)

        found = self.lookup(map_pattern, key_pattern)
        assert found is not None, f"key {key_pattern} does not exist in map pattern {map_pattern}"

        return self.build_equation(application, found)
