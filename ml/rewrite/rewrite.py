from typing import Optional, List, Tuple, Mapping, Union, Set, Dict
from enum import Enum

from traceback import print_exc

from ml.kore import ast as kore
from ml.kore.utils import KoreUtils, PatternPath
from ml.kore.ast import KoreVisitor
from ml.kore.visitors import PatternVariableVisitor

from ml.metamath import ast as mm
from ml.metamath.composer import Theorem, Proof
from ml.metamath.auto.sorting import SortingProver
from ml.metamath.auto.predicate import PredicateProver

from .encoder import KoreEncoder

from .env import KoreComposer, ProofGenerator, ProvableClaim
from .fol import FOLProofGenerator
from .unification import UnificationProofGenerator, InjectionCombine, UnificationResult, ConstraintEquation
from .templates import KoreTemplates
from .disjointness import DisjointnessProofGenerator
from .propositional import PropositionalProofGenerator
from .substitution import SingleSubstitutionProofGenerator
from .smt import SMTProofGenerator, SMTOption
from .tasks import RewritingStep, RewritingTask, ReachabilityTask, ConstrainedPattern, Substitution, AppliedRule

ReachabilityType = str


class RewriteProofGenerator(ProofGenerator):
    """
    These functions can accept symbolic arguments
    """
    SYMBOLIC_FUNCTIONS = {
        "LblisKResult",

        # for top cell initialization
        "Lblproject'Coln'Pgm",
        "LblMap'Coln'lookup",
    }
    """
    Generate proofs for rewriting related claims
    """
    def __init__(self, composer: KoreComposer, smt_option: SMTOption = SMTOption()):
        super().__init__(composer)
        self.owise_assumption_counter = 0
        self.rewrite_claim_counter = 0
        self.simplification_counter = 0
        self.pattern_subsumption_counter = 0
        self.kore_is_predicate_counter = 0
        self.sorting_hypotheses_counter = 0
        self.hooked_symbol_evaluators = {
            "Lbl'UndsPlus'Int'Unds'":
            IntegerAdditionEvaluator(composer),
            "Lbl'Unds'-Int'Unds'":
            IntegerSubtractionEvaluator(composer),
            "Lbl'UndsStar'Int'Unds'":
            IntegerMultiplicationEvaluator(composer),
            "Lbl'UndsSlsh'Int'Unds'":
            IntegerDivisionEvaluator(composer),
            "Lbl'UndsPerc'Int'Unds'":
            IntegerModEvaluator(composer),
            "Lbl'Unds-GT-Eqls'Int'Unds'":
            IntegerGreaterThanOrEqualToEvaluator(composer),
            "Lbl'Unds-LT-Eqls'Int'Unds'":
            IntegerLessThanOrEqualToEvaluator(composer),
            "Lbl'Unds-GT-'Int'Unds'":
            IntegerGreaterThanEvaluator(composer),
            "Lbl'Unds-LT-'Int'Unds'":
            IntegerLessThanEvaluator(composer),
            "Lbl'UndsEqlsEqls'Int'Unds'":
            IntegerEqualityEvaluator(composer),
            "Lbl'Unds'andBool'Unds'":
            BooleanAndEvaluator(composer),
            "Lbl'Unds'orBool'Unds'":
            BooleanOrEvaluator(composer),
            "LblnotBool'Unds'":
            BooleanNotEvaluator(composer),
            "Lbl'UndsEqlsEqls'K'Unds'":
            KEqualityEvaluator(composer),
            "Lbl'UndsEqlsSlshEqls'K'Unds'":
            KNotEqualityEvaluator(composer),
            "LblMap'Coln'lookup":
            MapLookupEvaluator(composer),
            "LblMap'Coln'update":
            MapUpdateEvaluator(composer),
            "Lbl'Unds'in'Unds'keys'LParUndsRParUnds'MAP'Unds'Bool'Unds'KItem'Unds'Map":
            MapInKeysEvaluator(composer),
            "Lbl'Stop'Bytes'Unds'BYTES-HOOKED'Unds'Bytes":
            BytesUnitEvaluator(composer),
            "Lbl'Hash'if'UndsHash'then'UndsHash'else'UndsHash'fi'Unds'K-EQUAL-SYNTAX'Unds'Sort'Unds'Bool'Unds'Sort'Unds'Sort":
            IfEvaluator(composer),
        }
        self.disjoint_gen = DisjointnessProofGenerator(composer)
        self.smt_gen = SMTProofGenerator(composer, smt_option)
        self.prop_gen = PropositionalProofGenerator(composer)
        self.fol_gen = FOLProofGenerator(composer)

        self.proved_claims: Dict[str, ProvableClaim] = {}

    def prove_one_path_reachability_claims(
        self,
        tasks: Tuple[ReachabilityTask, ...],
    ) -> None:
        claim_to_task: Dict[str, ReachabilityTask] = {}
        claim_dependency: Dict[str, List[str]] = {}

        for task in tasks:
            claim_dependency[task.claim_id] = []
            claim_to_task[task.claim_id] = task

            for step in task.steps:
                for rule in step.applied_rules:
                    if rule.rule_id is not None and rule.rule_id.startswith("claim-"):
                        # ignore self-loops
                        if task.claim_id != rule.rule_id:
                            claim_dependency[task.claim_id].append(rule.rule_id)

        sorted_claims = self.sort_dependency_graph(claim_dependency)
        assert sorted_claims is not None, \
               f"cycle in the claim dependency graph"

        # self.proved_claims["claim-1"] = self.composer.load_fresh_claim_placeholder(
        #     "claim",
        #     KoreUtils.construct_one_path_reaches_plus(
        #         claim_to_task["claim-1"].lhs.as_pattern(),
        #         claim_to_task["claim-1"].rhs.as_pattern(),
        #     ),
        # )
        # self.prove_one_path_reachability_claim(claim_to_task["claim-0"])

        for claim_id in sorted_claims:
            print(f"### proving {claim_id}")
            proved_claim = self.prove_one_path_reachability_claim(claim_to_task[claim_id])
            self.proved_claims[claim_id] = proved_claim

    def sort_dependency_graph(self, dependency: Dict[str, List[str]]) -> Optional[List[str]]:
        """
        Do a topological sort

        a -> b in dep if a depends on b
        """
        sources = []
        sorted_list = []

        dependency = dependency.copy()
        inverse_dependency: Dict[str, List[str]] = {node: [] for node in dependency}

        for node, deps in dependency.items():
            for dep in deps:
                inverse_dependency[dep].append(node)

        for node, deps in dependency.items():
            if len(deps) == 0:
                sources.append(node)

        sources.sort()  # make this more deterministic

        while len(sources):
            node = sources.pop()
            sorted_list.append(node)

            deps = inverse_dependency[node]
            del inverse_dependency[node]

            for dep in deps:
                dependency[dep].remove(node)
                if dependency[dep] == []:
                    sources.append(dep)

        if len(inverse_dependency) != 0:
            return None

        else:
            return sorted_list

    def prove_one_path_reachability_claim(
        self,
        task: ReachabilityTask,
    ) -> ProvableClaim:
        """
        Prove a one-path reachability claim
        using the given cirularity claims
        and the hints
        """

        # TODO: when there are existential vars, K generates
        # claims of the form ph1 => exists ... ph2 /\ ph3
        # where ph1 and ph3 are both constraints
        # to make our life easier, we switch the order of ph3 and ph2
        # so that constraints are always on the left hand side
        if KoreUtils.is_exists(task.rhs.pattern):
            exists_vars = []
            rhs_body = task.rhs.pattern
            while KoreUtils.is_exists(rhs_body):
                var, rhs_body = KoreUtils.destruct_exists(rhs_body)
                exists_vars.append(var)

            rhs_left, rhs_right = KoreUtils.destruct_and(rhs_body)
            new_rhs = KoreUtils.construct_and(rhs_right, rhs_left)

            for var in exists_vars[::-1]:
                new_rhs = KoreUtils.construct_exists(var, new_rhs)

            task.rhs.pattern = new_rhs
            task.rhs.resolve(self.composer.module)

        claim = self.composer.construct_claim(
            KoreUtils.construct_one_path_reaches_plus(
                task.lhs.as_pattern(),
                task.rhs.as_pattern(),
            ),
        )

        assert len(task.steps) != 0, "trivial claim is not supported"

        self.preprocess_steps(task.steps)

        print(f"### step 0")
        symbolic_execution = self.prove_symbolic_step(kore.MLPattern.ONE_PATH_REACHES_PLUS, task.steps[0])

        for i, step in enumerate(task.steps[1:], 1):
            if len(step.applied_rules) == 1 and step.applied_rules[0].rule_id == task.claim_id:
                # claims will be resolved in the end
                print(f"### step {i} using circularity")
                step_claim = self.prove_reachability_axiom_step(kore.MLPattern.ONE_PATH_REACHES_STAR, claim, step)
            else:
                print(f"### step {i}")
                step_claim = self.prove_symbolic_step(kore.MLPattern.ONE_PATH_REACHES_STAR, step)

            symbolic_execution = self.connect_symbolic_steps(
                kore.MLPattern.ONE_PATH_REACHES_PLUS, symbolic_execution, step_claim
            )

        lhs, _, _, _ = self.destruct_rewrite_axiom(symbolic_execution, separate_lhs=False)

        # make the LHS of the symbolic execution same as the lhs of the claim
        symbolic_execution = self.apply_reachability_subsumption_left(
            self.prove_constrained_pattern_subsumption(
                task.lhs,
                ConstrainedPattern.from_pattern(lhs),
            ),
            symbolic_execution,
        )

        # we first construct a generalized version of the claim by
        # universally quantify all variables
        quantified_claim = self.quantify_all_free_variables(claim)

        # weakens the current claim by adding a circularity premise of quantified_claim
        if not KoreUtils.is_implies(symbolic_execution.claim.pattern):
            symbolic_execution = self.prop_gen.apply_weakening(
                symbolic_execution,
                KoreUtils.construct_circularity(quantified_claim.pattern),
            )

        # proves RHS of the current claim -> RHS of the goal claim, under the premise of quantified claim
        _, _, rhs, _ = self.destruct_rewrite_axiom(symbolic_execution, separate_lhs=False, separate_rhs=False)
        subsumption = self.prove_multiple_subsumptions(rhs, task.rhs.as_pattern())

        final_claim = self.apply_reachability_subsumption_right(symbolic_execution, subsumption)

        # apply circularity
        final_claim = self.prove_circularity(final_claim)
        final_claim = self.composer.load_provable_claim_as_theorem(f"goal-{task.claim_id}", final_claim)

        KoreUtils.pretty_print(final_claim.claim)

        return final_claim

    def prove_circularity(
        self,
        provable: ProvableClaim,
    ) -> ProvableClaim:
        """
        Given a proof of
        |- o [] forall x phi -> phi
        Eliminate the circularity assumption to get a proof of
        |- phi
        """
        left, right = KoreUtils.destruct_implies(provable.claim.pattern)
        circular_assumption, = KoreUtils.destruct_circularity(left)
        circular_assumption_stripped = KoreUtils.strip_forall(circular_assumption)

        assert circular_assumption_stripped == right, \
               f"not an application of circularity: the circular assumption " \
               f"{circular_assumption_stripped} is distinct from the conclusion {right}"

        free_vars = list(KoreUtils.get_free_variables(provable.claim))
        free_vars.sort(key=lambda v: v.name, reverse=True)
        # note that this order has to be the same as when we quantified the circularity
        # TODO: a bit hacky

        # quantify all free variables first
        for var in free_vars:
            # add a quantifer and then push it to the right of the implication
            provable = self.fol_gen.apply_forall_intro(provable, var)
            provable = self.fol_gen.apply_prenex_implies_right(provable)

        # get a proof of |- WF -> forall ... phi
        provable = self.composer.apply_kore_lemma(
            "kore-reachability-one-path-circularity-lemma",
            provable,
        )

        # show that the body WF -> phi
        # implies just phi (since it's a one-path reachability pattern)
        lhs, rhs = KoreUtils.destruct_implies(provable.claim.pattern)
        stripped_rhs = KoreUtils.strip_forall(rhs)

        # (WF -> (... =>+ ...)) -> (... =>+ ...)
        # here phi = (... =>+ ...)
        remove_wf = self.composer.apply_kore_lemma(
            "kore-reachability-permits-non-wf",
            goal=self.composer.construct_claim(
                KoreUtils.construct_implies(
                    KoreUtils.construct_implies(lhs, stripped_rhs),
                    stripped_rhs,
                ),
            ),
        )

        # add quantifies to both sides
        for var in free_vars:
            # (forall WF -> phi) -> forall phi
            remove_wf = self.fol_gen.apply_implies_compat_in_forall(remove_wf, var)

            lhs, rhs = KoreUtils.destruct_implies(remove_wf.claim.pattern)
            _, lhs = KoreUtils.destruct_forall(lhs)
            lhs_lhs, lhs_rhs = KoreUtils.destruct_implies(lhs)

            # (WF -> forall phi) -> (forall WF -> phi)
            prenex = self.fol_gen.get_prenex_implies_left(var, lhs_lhs, lhs_rhs)

            # (WF -> forall phi) -> forall phi
            remove_wf = self.prop_gen.apply_implies_transitivity(prenex, remove_wf)

        # finally removes the WF -> at the beginning of the claim
        provable = self.prop_gen.apply_mp(
            remove_wf,
            provable,
        )

        provable = self.fol_gen.eliminate_all_universal_quantifiers(provable)

        return provable

    def prenex_existential_configuration(
        self, pattern: kore.Pattern
    ) -> Optional[Tuple[ProvableClaim, List[kore.Variable], kore.Pattern]]:
        """
        Given a pattern of the form ph1 /\ exists x (ph2 /\ ph3)
        move the existential quantifier to the outermost level
        and return a proof of
        |- (ph1 /\ exists x (ph2 /\ ph3)) -> (exists x (ph1 /\ ph2) /\ ph3)
        and the (should be q-free) body (ph1 /\ ph3) /\ ph2

        If the pattern has no existential quantifiers, return None
        """

        if not KoreUtils.is_and(pattern):
            return None

        left, right = KoreUtils.destruct_and(pattern)

        if not KoreUtils.is_exists(right):
            return None

        exists_vars = []

        while KoreUtils.is_exists(right):
            var, right = KoreUtils.destruct_exists(right)
            exists_vars.append(var)

        if KoreUtils.is_and(right):
            right_left, right_right = KoreUtils.destruct_and(right)
            qf_pattern = KoreUtils.construct_and(KoreUtils.construct_and(left, right_left), right_right)
        else:
            qf_pattern = KoreUtils.construct_and(left, right)

        prenex_pattern = qf_pattern

        for var in exists_vars[::-1]:
            prenex_pattern = KoreUtils.construct_exists(var, prenex_pattern)

        # TODO: [exists] prove this
        return self.composer.load_fresh_claim_placeholder(
            "prenex-exists",
            KoreUtils.construct_implies(pattern, prenex_pattern),
        ), exists_vars[::-1], qf_pattern

    def prove_reachability_axiom_step(
        self,
        reachability: ReachabilityType,
        claim: kore.Claim,
        step: RewritingStep,
    ) -> ProvableClaim:
        """
        Apply the (Axiom) rule in the reachability proof system

        Given a claim (varphi => psi) and step hints (sigma),
        apply the claim itself and get a proof of
        |- always forall (varphi => psi) -> varphi[sigma] => psi[sigma]

        TODO: perhaps we should merge this to prove_symbolic_step
        """
        assert len(step.remainders) <= 1

        assert reachability == kore.MLPattern.ONE_PATH_REACHES_STAR

        assert len(step.applied_rules) == 1
        applied_rule = step.applied_rules[0]
        assert len(applied_rule.results) == 1

        initial = step.initial
        final = applied_rule.results[0]

        quantified_claim = self.quantify_all_free_variables(claim)

        substitution = step.applied_rules[0].get_substitution()
        axiom_instantiation = self.fol_gen.apply_functional_substitution_as_implication(
            quantified_claim.pattern, substitution
        )

        always_elim = self.composer.apply_kore_lemma(
            "kore-always-elim",
            goal=self.composer.construct_claim(
                KoreUtils.construct_implies(
                    KoreUtils.construct_always(quantified_claim.pattern),
                    quantified_claim.pattern,
                ),
            ),
        )

        axiom_instantiation = self.prop_gen.apply_implies_transitivity(
            always_elim,
            axiom_instantiation,
        )

        # simplify concrete function terms
        axiom_instantiation = self.simplify_pattern(axiom_instantiation, [0, 1, 1])  # rhs
        axiom_instantiation = self.simplify_pattern(axiom_instantiation, [0, 1, 0, 0])  # requires clause

        _, instantiated_reachability = KoreUtils.destruct_implies(axiom_instantiation.claim.pattern)
        _, instantiated_rhs = KoreUtils.destruct_one_path_reaches_plus(instantiated_reachability)

        # remove ensures clause
        axiom_instantiation = self.composer.apply_kore_lemma(
            "kore-one-path-reaches-plus-subsumption-rhs-alt",
            axiom_instantiation,
            self.prop_gen.apply_and_elim_right(instantiated_rhs),
        )

        axiom_instantiation = self.composer.apply_kore_lemma(
            "kore-one-path-reaches-plus-constraint-lemma-alt",
            axiom_instantiation,
        )

        # weaken to reaches-plus
        axiom_instantiation = self.composer.apply_kore_lemma(
            "kore-one-path-reaches-star-intro-alt3",
            axiom_instantiation,
        )

        appended_remainder = False

        # we need to combine the remainder term if it exists
        if len(step.remainders) != 0:
            remainder, = step.remainders

            if not self.check_smt_unsat(remainder.get_constraint()):
                appended_remainder = True
                # |- axiom -> (remainder_constraint \/ lhs_constraint) /\ lhs =>* remainder \/ rhs
                axiom_instantiation = self.composer.apply_kore_lemma(
                    "kore-one-path-reaches-star-union-alt2",
                    self.apply_reachability_reflexivity(kore.MLPattern.ONE_PATH_REACHES_STAR, remainder.as_pattern()),
                    axiom_instantiation,
                )

        # compute the LHS and RHS again
        _, instantiated_reachability = KoreUtils.destruct_implies(axiom_instantiation.claim.pattern)
        instantiated_lhs, _ = KoreUtils.destruct_one_path_reaches_star(instantiated_reachability)

        # arrange the LHS to be initial
        subsumption_lhs = self.prove_constrained_pattern_subsumption(
            initial,
            ConstrainedPattern.from_pattern(instantiated_lhs),
        )

        axiom_instantiation = self.composer.apply_kore_lemma(
            "kore-one-path-reaches-star-subsumption-lhs-alt",
            subsumption_lhs,
            axiom_instantiation,
        )

        # need to pass the LHS constraint to the RHS
        if not appended_remainder:
            axiom_instantiation = self.composer.apply_kore_lemma(
                "kore-one-path-reaches-star-constraint-lemma-alt",
                axiom_instantiation,
            )
        # TODO: is appended_remainder is true, we may still need to do this

        # recompute the RHS
        _, instantiated_reachability = KoreUtils.destruct_implies(axiom_instantiation.claim.pattern)
        _, instantiated_rhs = KoreUtils.destruct_one_path_reaches_star(instantiated_reachability)
        if appended_remainder:
            _, instantiated_rhs = KoreUtils.destruct_or(instantiated_rhs)

        # if the RHS has existential quantifiers, move them to the outermost level
        prenex_proof = self.prenex_existential_configuration(instantiated_rhs)
        if prenex_proof is not None:
            prenex = True
            prenex_claim, exists_vars, instantiated_rhs = prenex_proof
            axiom_instantiation = self.composer.apply_kore_lemma(
                "kore-one-path-reaches-star-subsumption-rhs-alt2"
                if appended_remainder else "kore-one-path-reaches-star-subsumption-rhs-alt",
                axiom_instantiation,
                prenex_claim,
            )
        else:
            prenex = False
            exists_vars = []

        # arrange the RHS to be goal
        subsumption_rhs = self.prove_constrained_pattern_subsumption(
            ConstrainedPattern.from_pattern(instantiated_rhs),
            final,
        )

        if prenex:
            # if there is existential quantifiers in the original RHS,
            # we have to existentially quantify both sides of subsumption
            subsumption_rhs_left, subsumption_rhs_right = KoreUtils.destruct_implies(subsumption_rhs.claim.pattern)
            for var in exists_vars:
                subsumption_rhs_left = KoreUtils.construct_exists(var, subsumption_rhs_left)
                subsumption_rhs_right = KoreUtils.construct_exists(var, subsumption_rhs_right)

            # TODO: [exists] prove this
            subsumption_rhs = self.composer.load_fresh_claim_placeholder(
                "implies-compat-exists",
                KoreUtils.construct_implies(
                    subsumption_rhs_left,
                    ConstrainedPattern.from_pattern(subsumption_rhs_right).as_pattern(),
                ),
            )

        # if we have appended the remainder, then the RHS will be a disjunction
        # so we have to apply subsumption differently
        axiom_instantiation = self.composer.apply_kore_lemma(
            "kore-one-path-reaches-star-subsumption-rhs-alt2"
            if appended_remainder else "kore-one-path-reaches-star-subsumption-rhs-alt",
            axiom_instantiation,
            subsumption_rhs,
        )

        return axiom_instantiation

    def prove_multiple_subsumptions(
        self,
        initial: kore.Pattern,
        goal: kore.Pattern,
    ) -> ProvableClaim:
        """
        Prove that a disjunction of patterns is subsumed by a single pattern
        
        Prove that (at Kore level)
        |- <disjunction> => <goal>
        """

        if KoreUtils.is_or(initial):
            left, right = KoreUtils.destruct_or(initial)
            return self.composer.apply_kore_lemma(
                "kore-or-elim-alt2",
                self.prove_multiple_subsumptions(left, goal),
                self.prove_multiple_subsumptions(right, goal),
            )

        constrained_pattern1 = ConstrainedPattern.from_pattern(initial)
        constrained_pattern2 = ConstrainedPattern.from_pattern(goal)

        # otherwise try to prove subsumption directly
        constraint_unsat = self.check_smt_unsat(constrained_pattern1.get_constraint())

        if constraint_unsat is not None:
            # if the constraint is unsatisfiable, the subsumption is trivial
            subsumption = self.composer.apply_kore_lemma(
                "kore-not-elim",
                constraint_unsat,
                ph2=constrained_pattern1.pattern,
                ph3=goal,
            )
        else:
            subsumption = self.prove_constrained_pattern_subsumption(
                constrained_pattern1,
                constrained_pattern2,
            )

        return subsumption

    def quantify_all_free_variables(self, claim: kore.Claim) -> kore.Claim:
        copied_claim = KoreUtils.copy_ast(self.composer.module, claim)
        KoreUtils.quantify_all_free_variables_in_axiom(copied_claim)
        return copied_claim

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

        if KoreUtils.is_implies(pattern):
            _, pattern = KoreUtils.destruct_implies(pattern)

        rewrite_pattern = KoreUtils.strip_forall(pattern)

        assert isinstance(rewrite_pattern, kore.MLPattern) and (
            rewrite_pattern.construct == kore.MLPattern.REWRITES or rewrite_pattern.construct
            == kore.MLPattern.REWRITES_STAR or rewrite_pattern.construct == kore.MLPattern.REWRITES_PLUS
            or rewrite_pattern.construct == kore.MLPattern.ONE_PATH_REACHES_PLUS
            or rewrite_pattern.construct == kore.MLPattern.ONE_PATH_REACHES_STAR
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

    def check_smt_unsat(
        self,
        pattern: kore.Pattern,
    ) -> Optional[ProvableClaim]:
        return self.smt_gen.check_validity(KoreUtils.construct_not(pattern))

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
                ph1=premise,
            )

        # TODO: call SMT solver and check
        # print("SMT proof obligation:")
        # KoreUtils.pretty_print(claim.pattern)

        provable = self.smt_gen.check_validity(claim)
        assert provable is not None, \
               f"predicate {KoreUtils.construct_implies(premise, conclusion)} is not valid"

        return provable

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

        claim = self.prop_gen.apply_implies_reflexivity(pattern1.as_pattern())

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

    # TODO: put this to FOLProofGenerator
    def apply_constraint_equation(
        self,
        pattern: kore.Pattern,
        position: PatternPath,
        equation: ConstraintEquation,
    ) -> ProvableClaim:
        r"""
        Given phi = phi1 /\ phi2
        Assume
        |- phi1 -> equation

        when prove that
        |- phi1 /\ phi2 -> phi1 /\ phi2[equation/path]
        """

        constraint, term = KoreUtils.destruct_and(pattern)

        equation_sort = KoreUtils.infer_sort(pattern)
        equation_pattern = KoreUtils.construct_equals(equation_sort, equation.lhs, equation.rhs)

        constraint_imp = self.check_smt_implication(constraint, equation_pattern)

        all_metavars = {KoreEncoder.encode_variable(var) for var in PatternVariableVisitor().visit(pattern)}
        fresh_var, = self.composer.gen_fresh_metavariables("#ElementVariable", 1, all_metavars)

        var = kore.Variable(fresh_var, equation_sort)
        var.resolve(self.composer.module)

        template_term = KoreUtils.copy_and_replace_path_by_pattern_in_pattern(term, position, var)
        new_term = KoreUtils.copy_and_replace_path_by_pattern_in_pattern(term, position, equation.rhs)

        goal = self.composer.construct_claim(
            KoreUtils.construct_implies(
                pattern,
                KoreUtils.construct_and(constraint, new_term),
            ),
        )

        return self.composer.apply_kore_lemma(
            "kore-equality-in-constraint",
            constraint_imp,
            x=var,
            ph4=template_term,
            goal=goal,
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

        # if pattern1 and pattern2 have the same existential quantifiers
        # we only need to unify their q-free body
        pattern1_body = pattern1.pattern
        pattern2_body = pattern2.pattern

        if KoreUtils.is_exists(pattern1_body) and KoreUtils.is_exists(pattern2_body):
            exists_vars = []

            while KoreUtils.is_exists(pattern1_body) and \
                KoreUtils.is_exists(pattern2_body):
                var1, pattern1_body = KoreUtils.destruct_exists(pattern1_body)
                var2, pattern2_body = KoreUtils.destruct_exists(pattern2_body)
                assert var1 == var2, f"reordering of existential variables not supported, got {var1}, {var2}"
                exists_vars.append(var1)

                if KoreUtils.is_and(pattern1_body):
                    new_constraint, pattern1_body = KoreUtils.destruct_and(pattern1_body)
                    pattern1_constraint = KoreUtils.construct_and(pattern1_constraint, new_constraint)

                if KoreUtils.is_and(pattern2_body):
                    new_constraint, pattern2_body = KoreUtils.destruct_and(pattern2_body)
                    pattern2_constraint = KoreUtils.construct_and(pattern2_constraint, new_constraint)

            new_pattern1 = ConstrainedPattern(pattern1_body, pattern1_constraint)
            new_pattern2 = ConstrainedPattern(pattern2_body, pattern2_constraint)

            inner_subsumption = self.prove_constrained_pattern_subsumption(new_pattern1, new_pattern2)

            # TODO: prove these FO rearrangements
            # lhs_rearrange = self.composer.load_fresh_claim_placeholder(
            #     "exists-rearrange",
            #     KoreUtils.construct_implies(pattern1.as_pattern(), new_pattern1.as_pattern()),
            # )
            # rhs_rearrange = self.composer.load_fresh_claim_placeholder(
            #     "exists-rearrange",
            #     KoreUtils.construct_implies(new_pattern2.as_pattern(), pattern2.as_pattern()),
            # )

            # finally concatenate both ends
            # return self.prop_gen.apply_implies_transitivity(
            #     self.prop_gen.apply_implies_transitivity(
            #         lhs_rearrange,
            #         inner_subsumption,
            #     ),
            #     rhs_rearrange,
            # )

            # TODO: [exists] implement this
            return self.composer.load_fresh_claim_placeholder(
                "subsumption",
                KoreUtils.construct_implies(pattern1.as_pattern(), pattern2.as_pattern()),
            )

        # if only RHS has existential quantifiers, then we need to do instantiation
        if KoreUtils.is_exists(pattern2_body):
            exists_vars = []

            while KoreUtils.is_exists(pattern2_body):
                var2, pattern2_body = KoreUtils.destruct_exists(pattern2_body)
                exists_vars.append(var2)

                if KoreUtils.is_and(pattern2_body):
                    new_constraint, pattern2_body = KoreUtils.destruct_and(pattern2_body)
                    pattern2_constraint = KoreUtils.construct_and(pattern2_constraint, new_constraint)

            # allow substitution (here pattern2 is more general since it has existential quantifiers)
            unification_result = \
                UnificationProofGenerator(self.composer) \
                    .unify_patterns(pattern2_body, pattern1_body)

            assert unification_result is not None, \
                   f"failed to unify {pattern1_body} and {pattern2_body}"

            # KoreUtils.pretty_print(pattern1_body)
            # KoreUtils.pretty_print(pattern2_body)
            # print(unification_result)

            # only check subsumption of pattern2 under the substitution
            pattern2_rearranged = ConstrainedPattern(pattern2_body, pattern2_constraint).as_pattern()
            pattern2_rearranged.resolve(self.composer.module)

            pattern2_instance = KoreUtils.copy_and_substitute_pattern(
                pattern2_rearranged,
                unification_result.substitution,
            )
            self.prove_constrained_pattern_subsumption(
                pattern1,
                ConstrainedPattern.from_pattern(pattern2_instance),
            )

            # TODO; [exists] actually prove this
            return self.composer.load_fresh_claim_placeholder(
                "subsumption",
                KoreUtils.construct_implies(pattern1.as_pattern(), pattern2.as_pattern()),
            )

        unification_result = \
            UnificationProofGenerator(self.composer, allow_unevaluated_functions=True, disable_substitution=True) \
                .unify_patterns(pattern1_body, pattern2_body)

        # we can not instantiate variables here so the substitution must be empty
        assert unification_result is not None and len(unification_result.substitution) == 0, \
               f"failed to unify {pattern1_body} and {pattern2_body}"

        claim = self.prop_gen.apply_implies_reflexivity(
            ConstrainedPattern(pattern1_body, pattern1_constraint).as_pattern()
        )

        for equation, path in unification_result.applied_equations:
            if isinstance(equation, ConstraintEquation):
                _, current_rhs = KoreUtils.destruct_implies(claim.claim.pattern)
                simplification = self.apply_constraint_equation(current_rhs, path, equation)
                claim = self.prop_gen.apply_implies_transitivity(claim, simplification)
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

    def prove_symbolic_branch(
        self,
        reachability: ReachabilityType,
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

        # applying either a claim or an axiom
        if applied_rule.rule_id in self.proved_claims:
            rewrite_axiom = self.proved_claims[applied_rule.rule_id]
        else:
            rewrite_axiom = self.composer.rewrite_axioms[applied_rule.rule_id]
        lhs, _, rhs, _ = self.destruct_rewrite_axiom(rewrite_axiom)

        axiom_free_vars = KoreUtils.get_free_variables(rewrite_axiom.claim.pattern)

        # TODO: the hint sometimes prefers rule variables as keys
        # we need to revert them
        oriented_substitution = applied_rule.substitution.orient(axiom_free_vars)
        rule_substitution, _ = oriented_substitution.split(axiom_free_vars)
        # print(applied_rule.rule_id)
        # print("oriented_substitution")
        # print("\n".join(list(map(lambda t: f"({t[0]}, {t[1]})", oriented_substitution.substitution))))
        # print("rule_substitution")
        # print("\n".join(list(map(lambda t: f"({t[0]}, {t[1]})", rule_substitution.substitution))))
        # print("axiom_free_vars")
        # print("\n".join(list(map(str, axiom_free_vars))))

        rule_substitution_dict = rule_substitution.as_dict()

        lhs = KoreUtils.copy_and_substitute_pattern(lhs, rule_substitution_dict)
        rhs = KoreUtils.copy_and_substitute_pattern(rhs, rule_substitution_dict)

        # we also consider a extra set of equalities in the constraint
        unification_gen = UnificationProofGenerator(self.composer, allow_unevaluated_functions=True)

        # unify the LHS with the initial pattern
        lhs_unification_result = unification_gen.unify_patterns(lhs, initial.pattern)
        assert lhs_unification_result is not None, \
               f"unable to unify the LHS of {applied_rule.rule_id} with the initial pattern {initial.pattern}"

        instantiated_axiom = self.fol_gen.apply_functional_substitution(
            rewrite_axiom,
            {
                **rule_substitution_dict,
                **lhs_unification_result.substitution
            },
        )
        instantiated_axiom = self.simplify_pattern(instantiated_axiom, [0, 1])  # rhs
        instantiated_axiom = self.simplify_pattern(instantiated_axiom, [0, 0, 0])  # requires clause

        lhs, requires, rhs, ensures = self.destruct_rewrite_axiom(instantiated_axiom)
        assert requires is not None and ensures is not None

        if not KoreUtils.is_top(ensures):
            print(f"removing non-empty ensures clause {ensures}")

        # remove ensures clause
        instantiated_axiom = self.apply_reachability_subsumption_right(
            instantiated_axiom,
            self.prop_gen.apply_and_elim_right(KoreUtils.construct_and(ensures, rhs)),
        )

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

        # TODO: support other reachability types as well

        # requires /\ lhs => rhs
        # ---------------------- (by simplification1)
        # final_constraint /\ initial_term => rhs
        claim = self.apply_reachability_subsumption_left(simplification1, instantiated_axiom)

        # final_constraint /\ initial_term => rhs
        # --------------------------------------- (add constraint to RHS)
        # final_constraint /\ initial_term => final_constraint /\ rhs
        claim = self.apply_reachability_constraint_lemma(claim)

        # final_constraint /\ initial_term => final_constraint /\ rhs
        # ----------------------------------------------------------- (by simplification2)
        # final_constraint /\ initial_term => final_constraint /\ final_term
        claim = self.apply_reachability_subsumption_right(claim, simplification2)

        return self.apply_reachability_intro(reachability, claim)

    def combine_branches(
        self,
        rewrite1: ProvableClaim,
        rewrite2: ProvableClaim,
    ) -> ProvableClaim:
        r"""
        Given two provable claims
          psi_1 /\ phi => phi'_1
          psi_2 /\ phi => phi'_2

        return a provable claim
          (psi_1 \/ psi_2) /\ phi => phi'_1 \/ phi'_2

        where => can be =>* or =>+
        """

        rewrite_type1 = self.get_reachability_type(rewrite1)
        rewrite_type2 = self.get_reachability_type(rewrite2)

        assert rewrite_type1 == rewrite_type2

        lhs1, left_constraints1, _, _ = self.destruct_rewrite_axiom(rewrite1, separate_rhs=False)
        lhs2, left_constraints2, _, _ = self.destruct_rewrite_axiom(rewrite2, separate_rhs=False)
        assert lhs1 == lhs2, f"{lhs1} != {lhs2}"
        assert left_constraints1 is not None and left_constraints2 is not None

        if rewrite_type1 == kore.MLPattern.REWRITES_STAR:
            return self.composer.apply_kore_lemma(
                "kore-rewrites-star-union",
                rewrite1,
                rewrite2,
            )
        elif rewrite_type1 == kore.MLPattern.REWRITES_STAR:
            return self.composer.apply_kore_lemma(
                "kore-rewrites-plus-union",
                rewrite1,
                rewrite2,
            )
        elif rewrite_type1 == kore.MLPattern.ONE_PATH_REACHES_STAR:
            return self.composer.apply_kore_lemma(
                "kore-one-path-reaches-star-union",
                rewrite1,
                rewrite2,
            )
        elif rewrite_type1 == kore.MLPattern.ONE_PATH_REACHES_PLUS:
            return self.composer.apply_kore_lemma(
                "kore-one-path-reaches-plus-union",
                rewrite1,
                rewrite2,
            )

        assert False, f"unsupported reachability type {rewrite_type1}"

    def prove_symbolic_step(
        self,
        reachability: ReachabilityType,
        step: RewritingStep,
    ) -> ProvableClaim:
        """
        Prove that the initial pattern in the step
        rewrites to the union of all final patterns
        """

        initial_pattern = step.get_initial_pattern()

        # TODO: maybe we need to change the free variable name to avoid conflict

        assert len(step.applied_rules) != 0
        branches = [
            self.prove_symbolic_branch(reachability, initial_pattern, applied_rule)
            for applied_rule in step.applied_rules
        ]

        # TODO: prune branches with unsatisfiable constraints

        # no changes to the remainder
        for remainder in step.remainders:
            if not self.check_smt_unsat(remainder.get_constraint()):
                # if unsat, then skip
                branches.append(self.apply_reachability_reflexivity(reachability, remainder.as_pattern()))

        # if len(step.remainders) == 0, we can use =>+ instead of =>*
        step_claim = branches[-1]
        for branch in branches[:-1][::-1]:
            step_claim = self.combine_branches(branch, step_claim)

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

        constraint_splitting = self.prop_gen.apply_implies_compatibility(
            kore.MLPattern.AND,
            constraint_splitting,
            self.prop_gen.apply_implies_reflexivity(lhs_term),
        )

        theorem_name = self.composer.get_fresh_label("symbolic-step")

        final_claim = self.apply_reachability_subsumption_left(constraint_splitting, step_claim)
        final_claim = self.composer.load_provable_claim_as_theorem(theorem_name, final_claim)

        return final_claim

    def prove_trivial_disjunction_implication(
        self, disjunction1: kore.Pattern, disjunction2: kore.Pattern
    ) -> ProvableClaim:
        """
        Prove |- phi_1 \/ ... \/ phi_n -> psi_1 \/ ... \/ psi_m
        where for all i, exists j such that phi_i = psi_j
        """

        if KoreUtils.is_or(disjunction1):
            left, right = KoreUtils.destruct_or(disjunction1)
            return self.composer.apply_kore_lemma(
                "kore-or-elim-alt2",
                self.prove_trivial_disjunction_implication(left, disjunction2),
                self.prove_trivial_disjunction_implication(right, disjunction2),
            )

        if disjunction1 == disjunction2:
            return self.prop_gen.apply_implies_reflexivity(disjunction1)

        if KoreUtils.is_or(disjunction2):
            left, right = KoreUtils.destruct_or(disjunction2)

            if disjunction1 in KoreUtils.destruct_nested_or(left):
                return self.prop_gen.apply_implies_transitivity(
                    self.prove_trivial_disjunction_implication(disjunction1, left),
                    self.composer.apply_kore_lemma(
                        "kore-or-intro-left-alt2",
                        goal=self.composer.construct_claim(KoreUtils.construct_implies(left, disjunction2), ),
                    ),
                )
            elif disjunction1 in KoreUtils.destruct_nested_or(right):
                return self.prop_gen.apply_implies_transitivity(
                    self.prove_trivial_disjunction_implication(disjunction1, right),
                    self.composer.apply_kore_lemma(
                        "kore-or-intro-right-alt2",
                        goal=self.composer.construct_claim(KoreUtils.construct_implies(right, disjunction2), ),
                    ),
                )

        assert False, f"failed to prove that {disjunction1} implies {disjunction2}"

        # disjuncts2 = KoreUtils.destruct_nested_or(disjunction2)
        # assert disjunction1 in disjuncts2
        # index = disjuncts2.index(disjunction1)

        # # shuffle the <index> pattern to the topmost position
        # shuffle = self.prop_gen.apply_iff_elim_right(
        #     self.prop_gen.shuffle_nested(kore.MLPattern.OR, disjunction2, index),
        # )

        # shuffled, _ = KoreUtils.destruct_implies(shuffle.claim.pattern)

        # return self.prop_gen.apply_implies_transitivity(
        #     self.composer.apply_kore_lemma(
        #         "kore-or-intro-left-alt2",
        #         goal=self.composer.construct_claim(
        #             KoreUtils.construct_implies(disjunction1, shuffled),
        #         ),
        #     ),
        #     shuffle,
        # )

    def simplify_branches(self, claim: ProvableClaim) -> ProvableClaim:
        """
        Remove duplicate branches on the RHS
        """
        _, _, rhs, _ = self.destruct_rewrite_axiom(claim, separate_rhs=False)
        branches = KoreUtils.destruct_nested_or(rhs)

        unique_branches = list(set(branches))

        if len(unique_branches) == len(branches):
            return claim

        new_rhs = unique_branches[0]
        for branch in unique_branches[1:]:
            new_rhs = KoreUtils.construct_or(branch, new_rhs)

        return self.apply_reachability_subsumption_right(
            claim,
            self.prove_trivial_disjunction_implication(rhs, new_rhs),
        )

    def connect_symbolic_steps(
        self, reachability: ReachabilityType, step1: ProvableClaim, step2: ProvableClaim
    ) -> ProvableClaim:
        r"""
        step1 = |- [COND ->] phi_0 => phi_1 \/ ... \/ phi_n
        step2 = |- [COND ->] phi_i => psi_1 \/ ... \/ psi_m, where i in { 1, ..., n }
        ------------------------------------------------------------------
        [COND ->] phi_0 => phi_1 \/ ... \/ (psi_1 \/ ... \/ psi_m) \/ ... phi_n
    
        ([COND ->] means that step1/step2 can have an optional premise)
        where => can be =>* or =>+

        (order of disjunctions may not be exactly like this)
        """

        _, _, rhs1, _ = self.destruct_rewrite_axiom(step1, separate_rhs=False)
        lhs2, _, _, _ = self.destruct_rewrite_axiom(step2, separate_lhs=False)

        lhs2_constraint, lhs2_term = KoreUtils.destruct_and(lhs2)

        branches1 = KoreUtils.destruct_nested_or(rhs1)

        # print(len(branches1), len(set(branches1)))

        # unify lhs2 with any of the branches
        unification_gen = UnificationProofGenerator(
            self.composer, allow_unevaluated_functions=True, disable_substitution=True
        )
        for i, branch in enumerate(branches1):
            branch_constraint, branch_term = KoreUtils.destruct_and(branch)
            unification_result = unification_gen.unify_patterns(branch_term, lhs2_term)

            if lhs2_constraint == branch_constraint and \
               unification_result is not None and \
               len(unification_result.substitution) == 0:

                lhs2_index = i

                # construct a simplification from branch to lhs2
                simplification = self.prop_gen.apply_implies_reflexivity(branch)

                for eqn, path in unification_result.applied_equations:
                    if isinstance(eqn, ConstraintEquation):
                        _, current_rhs = KoreUtils.destruct_implies(simplification.claim.pattern)
                        simplification = self.prop_gen.apply_implies_transitivity(
                            simplification,
                            self.apply_constraint_equation(current_rhs, path, eqn),
                        )
                    else:
                        # apply the equation to branch_term at position 0, 1, 1
                        simplification = eqn.replace_equal_subpattern(simplification, [0, 1, 1] + path)

                # connect the simplification to step2
                step2 = self.apply_reachability_subsumption_left(simplification, step2)
                break
        else:
            assert False, f"unable to unify {lhs2} with any of the branches in {rhs1}"

        step1_has_premise = KoreUtils.is_implies(step1.claim.pattern)
        step2_has_premise = KoreUtils.is_implies(step2.claim.pattern)

        if len(branches1) == 1:
            # TODO: support the case when we have premises
            # assert not step1_has_premise and not step2_has_premise, "not supported"
            return self.apply_reachability_transitivity(reachability, step1, step2)

        # now we assume there are at least 2 branches in step1

        rhs1_shuffle = self.prop_gen.apply_iff_elim_left(
            self.prop_gen.shuffle_nested(kore.MLPattern.OR, rhs1, lhs2_index)
        )
        step1 = self.apply_reachability_subsumption_right(step1, rhs1_shuffle)

        if not step1_has_premise and not step2_has_premise:
            if reachability == kore.MLPattern.REWRITES_STAR:
                return self.composer.apply_kore_lemma(
                    "kore-rewrites-star-branch",
                    self.apply_reachability_intro(kore.MLPattern.REWRITES_STAR, step1),
                    self.apply_reachability_intro(kore.MLPattern.REWRITES_STAR, step2),
                )
            elif reachability == kore.MLPattern.REWRITES_PLUS:
                return self.composer.apply_kore_lemma(
                    "kore-rewrites-plus-branch",
                    self.apply_reachability_intro(kore.MLPattern.REWRITES_PLUS, step1),
                    self.apply_reachability_intro(kore.MLPattern.REWRITES_STAR, step2),
                )
            elif reachability == kore.MLPattern.ONE_PATH_REACHES_STAR:
                return self.composer.apply_kore_lemma(
                    "kore-one-path-reaches-star-branch",
                    self.apply_reachability_intro(kore.MLPattern.ONE_PATH_REACHES_STAR, step1),
                    self.apply_reachability_intro(kore.MLPattern.ONE_PATH_REACHES_STAR, step2),
                )
            elif reachability == kore.MLPattern.ONE_PATH_REACHES_PLUS:
                return self.composer.apply_kore_lemma(
                    "kore-one-path-reaches-plus-branch",
                    self.apply_reachability_intro(kore.MLPattern.ONE_PATH_REACHES_PLUS, step1),
                    self.apply_reachability_intro(kore.MLPattern.ONE_PATH_REACHES_STAR, step2),
                )
        else:
            step1_reachability = self.get_reachability_type(step1)
            step2_reachability = self.get_reachability_type(step2)

            if step1_has_premise:
                premise, _ = KoreUtils.destruct_implies(step1.claim.pattern)
            else:
                premise, _ = KoreUtils.destruct_implies(step2.claim.pattern)

            # a special case when connecting (Axiom) step
            # TODO: hacky
            if reachability == step1_reachability == kore.MLPattern.ONE_PATH_REACHES_PLUS:
                assert KoreUtils.is_always(premise) or KoreUtils.is_circularity(premise), \
                       f"premise not supported: {premise}"

                if KoreUtils.is_always(premise):
                    inner_premise, = KoreUtils.destruct_always(premise)
                else:
                    inner_premise, = KoreUtils.destruct_circularity(premise)

                # make sure step1 and step2 have the same premise
                if not step1_has_premise:
                    step1 = self.prop_gen.apply_weakening(step1, KoreUtils.construct_circularity(inner_premise))

                if not step2_has_premise:
                    step2 = self.prop_gen.apply_weakening(step2, KoreUtils.construct_always(inner_premise))

                if step2_reachability == kore.MLPattern.ONE_PATH_REACHES_PLUS:
                    step2 = self.composer.apply_kore_lemma(
                        "kore-one-path-reaches-star-intro-alt3",
                        step2,
                    )

                return self.composer.apply_kore_lemma("kore-reachability-one-path-transitivity-alt", step1, step2)

        assert False, f"unsupported reachbility type {reachability}"

    def preprocess_steps(self, steps: Tuple[RewritingStep, ...]) -> None:
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

        for step in steps:
            for applied_rule in step.applied_rules:
                simplified_results = []
                for result in applied_rule.results:
                    simplified = self.simplify_without_proof(result.as_pattern())
                    simplified_results.append(ConstrainedPattern.from_pattern(simplified))
                applied_rule.results = tuple(simplified_results)

                if applied_rule.rule_id is not None and \
                   applied_rule.rule_id in self.composer.axiom_variable_renaming and \
                   applied_rule.substitution is not None:
                    renaming = self.composer.axiom_variable_renaming[applied_rule.rule_id]
                    applied_rule.substitution = applied_rule.substitution.rename_variables(renaming)
                    applied_rule.resolve(self.composer.module)

    def match_with_final_results(self, task: RewritingTask, claim: ProvableClaim, start_from: int = 0) -> ProvableClaim:
        _, rhs = KoreUtils.destruct_rewrites_star(claim.claim.pattern)
        branches = KoreUtils.destruct_nested_or(rhs)

        unification_gen = UnificationProofGenerator(self.composer)

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
                assert constraint_unsat is not None, \
                       f"{branch_constraint} is not unsat"

                rhs_shuffle = self.prop_gen.apply_iff_elim_left(self.prop_gen.shuffle_nested(kore.MLPattern.OR, rhs, i))

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
        self.preprocess_steps(task.steps)

        initial_pattern = task.get_initial_pattern().as_pattern()
        final_claim = self.apply_reachability_reflexivity(kore.MLPattern.REWRITES_STAR, initial_pattern)
        final_claim = self.simplify_pattern(final_claim, [0, 1])

        for i, step in enumerate(task.steps):
            print(f"######## symbolic step {i} ########")
            claim = self.prove_symbolic_step(kore.MLPattern.REWRITES_STAR, step)
            final_claim = self.connect_symbolic_steps(kore.MLPattern.REWRITES_STAR, final_claim, claim)
            final_claim = self.simplify_branches(final_claim)

            if i + 1 != len(task.steps):
                final_claim = self.composer.load_provable_claim_as_theorem(
                    self.composer.get_fresh_label("intermediate-state"),
                    final_claim,
                )

        # TODO: not using task.initial and task.final yet

        # # connect all steps together
        # # with self.composer.new_context():
        # initial_pattern = task.get_initial_pattern().as_pattern()

        # # assuming that the set of free variables will not increase
        # # self.add_free_variable_sorting_hypotheses(initial_pattern)

        # # simplify initial pattern
        # print("######## simplifying initial claim ########")
        # final_claim = self.apply_reachability_reflexivity(kore.MLPattern.REWRITES_STAR, initial_pattern)
        # final_claim = self.simplify_pattern(final_claim, [0, 1])

        # for i, claim in enumerate(step_claims):
        #     print(f"######## connecting symbolic step {i} ########")
        #     final_claim = self.connect_symbolic_steps(kore.MLPattern.REWRITES_STAR, final_claim, claim)

        final_claim = self.composer.load_provable_claim_as_theorem("goal", final_claim)

        print(f"######## pruning unsatisfiable branch(es) ########")
        final_claim = self.match_with_final_results(task, final_claim)

        print("final claim:")
        KoreUtils.pretty_print(final_claim.claim)

        return final_claim

    def get_reachability_type(self, claim: ProvableClaim) -> ReachabilityType:
        if KoreUtils.is_implies(claim.claim.pattern):
            _, pattern = KoreUtils.destruct_implies(claim.claim.pattern)
        else:
            pattern = claim.claim.pattern

        assert isinstance(pattern, kore.MLPattern)

        construct = pattern.construct
        assert construct in {
            kore.MLPattern.REWRITES,
            kore.MLPattern.REWRITES_STAR,
            kore.MLPattern.REWRITES_PLUS,
            kore.MLPattern.ONE_PATH_REACHES_STAR,
            kore.MLPattern.ONE_PATH_REACHES_PLUS,
        }, f"unexpected top-level construct {construct}"
        return construct

    """
    (src, dest): theorem name
    """
    REACHABILITY_INTRO_THEOREMS = {
        (kore.MLPattern.REWRITES, kore.MLPattern.REWRITES_STAR):
        "kore-rewrites-star-intro",
        (kore.MLPattern.REWRITES, kore.MLPattern.REWRITES_PLUS):
        "kore-rewrites-plus-intro",
        (kore.MLPattern.REWRITES_PLUS, kore.MLPattern.REWRITES_STAR):
        "kore-rewrites-star-intro-alt",
        (kore.MLPattern.REWRITES_STAR, kore.MLPattern.ONE_PATH_REACHES_STAR):
        "kore-one-path-reaches-star-intro",
        (kore.MLPattern.REWRITES_PLUS, kore.MLPattern.ONE_PATH_REACHES_PLUS):
        "kore-one-path-reaches-plus-intro",
        (kore.MLPattern.ONE_PATH_REACHES_PLUS, kore.MLPattern.ONE_PATH_REACHES_STAR):
        "kore-one-path-reaches-star-intro-alt",
    }
    """
    (resulting type, src1, src2)
    """
    REACHABILITY_TRANS_THEOREMS = {
        (kore.MLPattern.REWRITES_PLUS, kore.MLPattern.REWRITES_PLUS, kore.MLPattern.REWRITES_STAR):
        "kore-rewrites-plus-transitivity",
        (kore.MLPattern.REWRITES_STAR, kore.MLPattern.REWRITES_STAR, kore.MLPattern.REWRITES_STAR):
        "kore-rewrites-star-transitivity",
        (
            kore.MLPattern.ONE_PATH_REACHES_PLUS, kore.MLPattern.ONE_PATH_REACHES_PLUS, kore.MLPattern.ONE_PATH_REACHES_STAR
        ):
        "kore-one-path-reaches-plus-transitivity",
        (
            kore.MLPattern.ONE_PATH_REACHES_STAR, kore.MLPattern.ONE_PATH_REACHES_STAR, kore.MLPattern.ONE_PATH_REACHES_STAR
        ):
        "kore-one-path-reaches-star-transitivity",
    }
    """
    (resulting type, src1, src2)
    """
    REACHABILITY_WEAKENED_TRANS_THEOREMS = {
        # TODO: this is not general enough and only covers the always -> circularity premise
        (
            kore.MLPattern.ONE_PATH_REACHES_PLUS, kore.MLPattern.ONE_PATH_REACHES_PLUS, kore.MLPattern.ONE_PATH_REACHES_STAR
        ):
        "kore-reachability-one-path-transitivity-alt2",
    }

    REACHABILITY_REFLEXIVITY_THEOREMS = {
        kore.MLPattern.REWRITES_STAR: "kore-rewrites-star-reflexivity",
        kore.MLPattern.ONE_PATH_REACHES_STAR: "kore-one-path-reaches-star-reflexivity",
    }
    """
    type: (left subsumption, right subsumption)
    """
    REACHABILITY_SUBSUMPTION_THEOREMS = {
        kore.MLPattern.REWRITES: ("kore-rewrites-subsumption-lhs", "kore-rewrites-subsumption-rhs"),
        kore.MLPattern.REWRITES_STAR: ("kore-rewrites-star-subsumption-lhs", "kore-rewrites-star-subsumption-rhs"),
        kore.MLPattern.REWRITES_PLUS: ("kore-rewrites-plus-subsumption-lhs", "kore-rewrites-plus-subsumption-rhs"),
        kore.MLPattern.ONE_PATH_REACHES_STAR:
        ("kore-one-path-reaches-star-subsumption-lhs", "kore-one-path-reaches-star-subsumption-rhs"),
        kore.MLPattern.ONE_PATH_REACHES_PLUS:
        ("kore-one-path-reaches-plus-subsumption-lhs", "kore-one-path-reaches-plus-subsumption-rhs"),
    }
    REACHABILITY_WEAKENED_SUBSUMPTION_THEOREMS = {
        kore.MLPattern.ONE_PATH_REACHES_PLUS:
        ("kore-one-path-reaches-plus-subsumption-lhs-alt", "kore-one-path-reaches-plus-subsumption-rhs-alt"),
        kore.MLPattern.ONE_PATH_REACHES_STAR: ("kore-one-path-reaches-star-subsumption-lhs-alt", ""),
    }
    """
    Propagate the constraint LHS to RHS
    """
    REACHABILITY_CONSTRAINT_LEMMA = {
        kore.MLPattern.REWRITES: "kore-rewrites-constraint-lemma",
        kore.MLPattern.ONE_PATH_REACHES_PLUS: "kore-one-path-reaches-plus-constraint-lemma",
    }

    def construct_reachability_claim(
        self, target: ReachabilityType, left: kore.Pattern, right: kore.Pattern
    ) -> kore.Claim:
        return self.composer.construct_claim(KoreUtils.construct_binary_ml_pattern(target, left, right))

    def get_reachability_conversion_path(self, src: ReachabilityType,
                                         dest: ReachabilityType) -> Optional[Tuple[str, ...]]:
        """
        Check if a claim of reachability type <src> can be converted to <dest>

        If so, return a list of introduction rules to apply
        otherwise return None
        """
        if src == dest:
            return ()

        # directly convertible
        if (src, dest) in RewriteProofGenerator.REACHABILITY_INTRO_THEOREMS:
            return RewriteProofGenerator.REACHABILITY_INTRO_THEOREMS[src, dest],

        # find a path
        for (src2, dest2), theorem_name in RewriteProofGenerator.REACHABILITY_INTRO_THEOREMS.items():
            if src == src2:
                path = self.get_reachability_conversion_path(dest2, dest)
                if path is not None:
                    return (theorem_name, ) + path

        return None

    def apply_reachability_intro(self, target_type: ReachabilityType, claim: ProvableClaim) -> ProvableClaim:
        """
        Convert the given claim to the expected reachability type
        """
        given_type = self.get_reachability_type(claim)

        path = self.get_reachability_conversion_path(given_type, target_type)

        assert path is not None, \
               f"cannot convert {given_type} to {target_type}"

        for theorem_name in path:
            claim = self.composer.apply_kore_lemma(theorem_name, claim)

        assert self.get_reachability_type(claim) == target_type

        return claim

    def apply_reachability_transitivity(
        self, target_type: ReachabilityType, claim1: ProvableClaim, claim2: ProvableClaim
    ) -> ProvableClaim:
        """
        Apply transitivity on the given two claims
        Note that claim1 or claim2 may have additional premises
        """

        if KoreUtils.is_implies(claim1.claim.pattern) or KoreUtils.is_implies(claim2.claim.pattern):
            assert not KoreUtils.is_implies(claim1.claim.pattern), "unsupported"
            # TODO: right now we only support claim 2 to have premises
            table = RewriteProofGenerator.REACHABILITY_WEAKENED_TRANS_THEOREMS
        else:
            table = RewriteProofGenerator.REACHABILITY_TRANS_THEOREMS

        claim_type1 = self.get_reachability_type(claim1)
        claim_type2 = self.get_reachability_type(claim2)

        for (dest, src1, src2), theorem_name in table.items():
            if dest == target_type:
                path1 = self.get_reachability_conversion_path(claim_type1, src1)
                path2 = self.get_reachability_conversion_path(claim_type2, src2)
                if path1 is not None and path2 is not None:
                    return self.composer.apply_kore_lemma(
                        theorem_name,
                        self.apply_reachability_intro(src1, claim1),
                        self.apply_reachability_intro(src2, claim2),
                    )

        assert False, f"cannot apply transitivity on reachability types {claim_type1} and {claim_type2} to get {target_type}"

    def apply_reachability_reflexivity(self, target: ReachabilityType, pattern: kore.Pattern) -> ProvableClaim:
        assert target in RewriteProofGenerator.REACHABILITY_REFLEXIVITY_THEOREMS, \
               f"{target} does not have a reflexivity theorem recorded"

        theorem_name = RewriteProofGenerator.REACHABILITY_REFLEXIVITY_THEOREMS[target]

        return self.composer.apply_kore_lemma(
            theorem_name,
            goal=self.construct_reachability_claim(target, pattern, pattern),
        )

    def apply_reachability_subsumption_left(self, implication: ProvableClaim, claim: ProvableClaim) -> ProvableClaim:
        """
        Given proofs of
          |- phi -> psi
          |- [premise ->] psi => psi'
        return a proof of [premise ->] phi => psi'
        """

        if KoreUtils.is_implies(claim.claim.pattern):
            table = RewriteProofGenerator.REACHABILITY_WEAKENED_SUBSUMPTION_THEOREMS
        else:
            table = RewriteProofGenerator.REACHABILITY_SUBSUMPTION_THEOREMS

        given_type = self.get_reachability_type(claim)
        assert given_type in table, \
               f"{given_type} does not have any subsumption theorem associated to it"

        theorem_name, _ = table[given_type]
        assert theorem_name is not None, \
               f"{given_type} does not have a left subsumption theorem associated to it"

        return self.composer.apply_kore_lemma(
            theorem_name,
            implication,
            claim,
        )

    def apply_reachability_subsumption_right(self, claim: ProvableClaim, implication: ProvableClaim) -> ProvableClaim:
        """
        Given proofs of
          |- psi => psi'
          |- [premise ->] psi' -> phi
        return a proof of [premise ->] phi => phi
        """

        if KoreUtils.is_implies(claim.claim.pattern):
            table = RewriteProofGenerator.REACHABILITY_WEAKENED_SUBSUMPTION_THEOREMS
        else:
            table = RewriteProofGenerator.REACHABILITY_SUBSUMPTION_THEOREMS

        given_type = self.get_reachability_type(claim)
        assert given_type in table, \
               f"{given_type} does not have any subsumption theorem associated to it"

        _, theorem_name = table[given_type]
        assert theorem_name is not None, \
               f"{given_type} does not have a right subsumption theorem associated to it"

        return self.composer.apply_kore_lemma(
            theorem_name,
            claim,
            implication,
        )

    def apply_reachability_constraint_lemma(self, claim: ProvableClaim) -> ProvableClaim:
        r"""
        Given |- constraint /\ LHS => RHS
        return |- constraint /\ LHS => constraint /\ RHS
        """

        given_type = self.get_reachability_type(claim)
        assert given_type in RewriteProofGenerator.REACHABILITY_CONSTRAINT_LEMMA, \
               f"{given_type} does not have a constraint lemma associated to it"

        theorem_name = RewriteProofGenerator.REACHABILITY_CONSTRAINT_LEMMA[given_type]

        return self.composer.apply_kore_lemma(
            theorem_name,
            claim,
        )

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
        Try to prove |- ( \kore-not <pattern> )
        """

        if KoreUtils.is_bottom(pattern):
            return self.composer.apply_kore_lemma(
                "kore-not-bot",
                goal=self.composer.construct_claim(KoreUtils.construct_not(pattern)),
            )

        elif KoreUtils.is_top(pattern):
            return None

        elif KoreUtils.is_or(pattern):
            left, right = KoreUtils.destruct_or(pattern)
            left_proof = self.prove_negation_requires(left)
            if left_proof is None:
                return None

            right_proof = self.prove_negation_requires(right)
            if right_proof is None:
                return None

            return self.composer.apply_kore_lemma("kore-de-morgan-alt", left_proof, right_proof)

        elif KoreUtils.is_and(pattern):
            left, right = KoreUtils.destruct_and(pattern)

            left_proof = self.prove_negation_requires(left)
            if left_proof is not None:
                return self.composer.apply_kore_lemma(
                    "kore-or-intro-left-alt",
                    left_proof,
                    ph2=right,
                )

            right_proof = self.prove_negation_requires(right)
            if right_proof is not None:
                return self.composer.apply_kore_lemma(
                    "kore-or-intro-right-alt",
                    right_proof,
                    ph1=left,
                )

            return None

        elif KoreUtils.is_exists(pattern):
            quantified_variables = []
            stripped_pattern = pattern

            while KoreUtils.is_exists(stripped_pattern):
                var, stripped_pattern = KoreUtils.destruct_exists(stripped_pattern)
                quantified_variables.append(var)

            # prove the free-var version
            disjointness = self.prove_negation_requires(stripped_pattern)
            if disjointness is None:
                return None

            # quantify all variables and convert to exists
            for var in quantified_variables[::-1]:
                disjointness = self.fol_gen.apply_forall_intro(disjointness, var)
                disjointness = self.composer.apply_kore_lemma(
                    "kore-forall-not-to-exists",
                    disjointness,
                )

            return disjointness

        elif KoreUtils.is_in(pattern):
            left, right = KoreUtils.destruct_in(pattern)
            encoded_output_sort = self.composer.encode_pattern(KoreUtils.infer_sort(pattern))
            encoded_input_sort = self.composer.encode_pattern(KoreUtils.infer_sort(left))

            # |- ( \not ( \and ... ( \sorted-exists x ph0 ... ) ) )
            try:
                proof = self.disjoint_gen.prove_disjointness(left, right)
            except Exception as e:
                print(f"failed to prove the disjointness of {left} and {right}: {e}")
                return self.composer.load_fresh_claim_placeholder(
                    "disjointness",
                    KoreUtils.construct_not(pattern),
                )

            # |- ( \imp ( \in-sort x ph0 ) ( \not ( \and ... ... ) ) )
            proof = self.composer.get_theorem("disjointness-exists").apply(proof)

            # |- ( \imp ( \in-sort x ph0 ) ( \kore-valid R ( \kore-not R ( \kore-in ph0 R ... ... ) ) ) )
            proof = self.composer.get_theorem("disjointness-to-not-in").apply(
                PredicateProver.auto,
                # some technical requirements: the left pattern has to be non-empty
                SortingProver.auto_rearrange_premise(
                    self.composer.get_theorem("functional-imp-nonempty-alt"
                                              ).apply(self.fol_gen.prove_functional(left), ),
                ),
                SortingProver.auto,
                SortingProver.auto,
                proof,
                ph0=encoded_input_sort,
                ph3=encoded_output_sort
            )

            return self.composer.construct_provable_claim(
                claim=KoreUtils.construct_not(pattern),
                proof=proof,
            )

        return None

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
        instantiated_axiom = self.fol_gen \
            .apply_functional_substitution(axiom, unification_result.substitution)

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
            "kore-mp-alt",
            instantiated_axiom,
            requires_proof,
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

    def get_concrete_function_symbols(self) -> Set[str]:
        return set(self.hooked_symbol_evaluators.keys()).difference(RewriteProofGenerator.SYMBOLIC_FUNCTIONS)

    def is_simplifiable(self, pattern: kore.Pattern) -> bool:
        """
        Checks if the given pattern is "simplifiable", that is, if
        it contains duplicate injections and/or unevaluated functions
        """

        nested_inj_path = InnermostNestedInjectionPathVisitor(self.composer).visit(pattern)
        if nested_inj_path is not None:
            return True

        concrete_functions = self.get_concrete_function_symbols()
        function_path = InnermostFunctionPathVisitor(
            self.composer,
            concrete_functions,
            set(self.hooked_symbol_evaluators.keys()),
        ).visit(pattern)
        if function_path is not None:
            return True

        return False

    def simplify_without_proof(self, pattern: kore.Pattern) -> kore.Pattern:
        """
        Simplify a pattern without proof
        """
        # with self.composer.new_context():
        # self.add_free_variable_sorting_hypotheses(pattern)
        dummy_claim = self.prop_gen.apply_implies_reflexivity(pattern)
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
            concrete_functions = self.get_concrete_function_symbols()
            function_path = InnermostFunctionPathVisitor(
                self.composer,
                concrete_functions,
                set(self.hooked_symbol_evaluators.keys()),
            ).visit(subpattern)
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
                provable = self.fol_gen.replace_equal_subpattern(provable, path + function_path, axiom)
                continue

            break

        return provable


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
    def __init__(self, composer: KoreComposer, concrete_functions: Set[str], builtin_functions: Set[str]):
        super().__init__()
        self.composer = composer
        self.concrete_functions = concrete_functions
        self.builtin_functions = builtin_functions

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
        if KoreTemplates.is_function_pattern(application) and \
           isinstance(application.symbol.definition, kore.SymbolDefinition):
            symbol_name = application.symbol.get_symbol_name()

            # if a function does not have associated equations but have a SMT hook,
            # we ignore it and leave it to the SMT solver
            cannot_evaluate = application.symbol not in self.composer.equational_axioms and symbol_name not in self.builtin_functions
            has_smt_hook = isinstance(application.symbol.definition, kore.SymbolDefinition) and \
                           application.symbol.definition.has_attribute("smt-hook")
            if cannot_evaluate and has_smt_hook:
                return None

            # do not find symbolic instances of concrete functions
            # TODO: slightly hacky
            is_symbolic = len(KoreUtils.get_free_variables(application)) != 0
            if is_symbolic and symbol_name in self.concrete_functions:
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
    def __init__(self, composer: KoreComposer):
        super().__init__(composer)
        self.axiom_counter = 0

    def parse_int(self, value: kore.Pattern) -> int:
        assert (isinstance(value, kore.MLPattern) and value.construct == kore.MLPattern.DV)
        assert (isinstance(value.sorts[0], kore.SortInstance) and value.sorts[0].get_sort_id() == "SortInt")

        assert isinstance(value.arguments[0], kore.StringLiteral)
        return int(value.arguments[0].content)

    def parse_bool(self, value: kore.Pattern) -> bool:
        assert (isinstance(value, kore.MLPattern) and value.construct == kore.MLPattern.DV), \
               f"expecting a domain value, got {value}"
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
            provable_claim = self.composer.load_axiom(
                claim,
                f"{self.composer.sanitize_label_name(application.symbol.get_symbol_name())}-domain-fact-{self.axiom_counter}",
                comment=False,
                provable=self.composer.dv_as_provable,
            )

        print(f"> bulitin symbol proof obligation: {claim}")

        self.axiom_counter += 1

        return ProvableClaim(claim, provable_claim.proof)

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


class IntegerModEvaluator(BuiltinFunctionEvaluator):
    def prove_evaluation(self, application: kore.Application) -> ProvableClaim:
        a, b = application.arguments
        # TODO: check if this definition of % is the same as K
        return self.build_arithmetic_equation(application, self.parse_int(a) % self.parse_int(b))


class IntegerGreaterThanOrEqualToEvaluator(BuiltinFunctionEvaluator):
    def prove_evaluation(self, application: kore.Application) -> ProvableClaim:
        a, b = application.arguments
        return self.build_arithmetic_equation(application, self.parse_int(a) >= self.parse_int(b))


class IntegerLessThanOrEqualToEvaluator(BuiltinFunctionEvaluator):
    def prove_evaluation(self, application: kore.Application) -> ProvableClaim:
        a, b = application.arguments
        return self.build_arithmetic_equation(application, self.parse_int(a) <= self.parse_int(b))


class IntegerGreaterThanEvaluator(BuiltinFunctionEvaluator):
    def prove_evaluation(self, application: kore.Application) -> ProvableClaim:
        a, b = application.arguments
        return self.build_arithmetic_equation(application, self.parse_int(a) > self.parse_int(b))


class IntegerLessThanEvaluator(BuiltinFunctionEvaluator):
    def prove_evaluation(self, application: kore.Application) -> ProvableClaim:
        a, b = application.arguments
        return self.build_arithmetic_equation(application, self.parse_int(a) < self.parse_int(b))


class IntegerEqualityEvaluator(BuiltinFunctionEvaluator):
    def prove_evaluation(self, application: kore.Application) -> ProvableClaim:
        a, b = application.arguments
        return self.build_arithmetic_equation(application, self.parse_int(a) == self.parse_int(b))


class BooleanAndEvaluator(BuiltinFunctionEvaluator):
    def prove_evaluation(self, application: kore.Application) -> ProvableClaim:
        a, b = application.arguments
        return self.build_arithmetic_equation(application, self.parse_bool(a) and self.parse_bool(b))


class BooleanOrEvaluator(BuiltinFunctionEvaluator):
    def prove_evaluation(self, application: kore.Application) -> ProvableClaim:
        a, b = application.arguments
        return self.build_arithmetic_equation(application, self.parse_bool(a) or self.parse_bool(b))


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


class MapUpdateEvaluator(BuiltinFunctionEvaluator):
    """
    Implements the K builtin function MAP.update
    """
    def update_existing(self, map_pattern: kore.Application, key_pattern: kore.Pattern,
                        value_pattern: kore.Pattern) -> Tuple[kore.Pattern, bool]:
        if KoreTemplates.is_map_unit_pattern(map_pattern):
            return map_pattern, False
        elif KoreTemplates.is_map_merge_pattern(map_pattern):
            left = KoreTemplates.get_map_merge_left(map_pattern)
            right = KoreTemplates.get_map_merge_right(map_pattern)
            assert isinstance(left, kore.Application) and isinstance(right, kore.Application)

            left, left_updated = self.update_existing(left, key_pattern, value_pattern)
            right, right_updated = self.update_existing(right, key_pattern, value_pattern)

            return kore.Application(map_pattern.symbol, [left, right]), left_updated or right_updated
        else:
            assert KoreTemplates.is_map_mapsto_pattern(map_pattern)
            key, _ = map_pattern.arguments

            if key == key_pattern:
                return kore.Application(map_pattern.symbol, [key, value_pattern]), True

            return map_pattern, False

    def prove_evaluation(self, application: kore.Application) -> ProvableClaim:
        map_pattern, key_pattern, value_pattern = application.arguments
        assert isinstance(map_pattern, kore.Application)

        new_map, has_updated = self.update_existing(map_pattern, key_pattern, value_pattern)

        if not has_updated:
            # TODO: this doesn't work for custom map sorts
            mapsto_symbol = self.composer.module.get_symbol_by_name("Lbl'UndsPipe'-'-GT-Unds'")
            merge_symbol = self.composer.module.get_symbol_by_name("Lbl'Unds'Map'Unds'")
            assert mapsto_symbol is not None and merge_symbol is not None

            # append a new element
            new_map = kore.Application(
                kore.SymbolInstance(merge_symbol, []),
                [new_map,
                 kore.Application(
                     kore.SymbolInstance(mapsto_symbol, []),
                     [
                         key_pattern,
                         value_pattern,
                     ],
                 )]
            )

        return self.build_equation(application, new_map)


class MapInKeysEvaluator(BuiltinFunctionEvaluator):
    def find_key(self, map_pattern: kore.Application, key_pattern: kore.Application) -> bool:
        """
        Check if the given key is in the map pattern or not
        """
        if KoreTemplates.is_map_unit_pattern(map_pattern):
            return False
        elif KoreTemplates.is_map_merge_pattern(map_pattern):
            left = KoreTemplates.get_map_merge_left(map_pattern)
            right = KoreTemplates.get_map_merge_right(map_pattern)
            assert isinstance(left, kore.Application) and \
                   isinstance(right, kore.Application)
            return self.find_key(left, key_pattern) or self.find_key(right, key_pattern)
        else:
            assert KoreTemplates.is_map_mapsto_pattern(map_pattern)
            key, _ = map_pattern.arguments
            return key == key_pattern

    def prove_evaluation(self, application: kore.Application) -> ProvableClaim:
        key_pattern, map_pattern = application.arguments
        assert isinstance(key_pattern, kore.Application) and \
               isinstance(map_pattern, kore.Application)
        return self.build_arithmetic_equation(application, self.find_key(map_pattern, key_pattern))


class BytesUnitEvaluator(BuiltinFunctionEvaluator):
    def prove_evaluation(self, application: kore.Application) -> ProvableClaim:
        sort = KoreUtils.infer_sort(application)
        dv = kore.MLPattern(kore.MLPattern.DV, [sort], [kore.StringLiteral("")])
        return self.build_equation(application, dv)


class IfEvaluator(BuiltinFunctionEvaluator):
    def prove_evaluation(self, application: kore.Application) -> ProvableClaim:
        condition, true_branch, false_branch = application.arguments

        assert isinstance(condition, kore.MLPattern) and \
               condition.construct == kore.MLPattern.DV, \
               f"non-concrete condition {condition}"

        literal, = condition.arguments
        assert isinstance(literal, kore.StringLiteral)

        if literal.content == "true":
            return self.build_equation(application, true_branch)
        elif literal.content == "false":
            return self.build_equation(application, false_branch)
        else:
            assert False, f"unexpected condition {condition}"
