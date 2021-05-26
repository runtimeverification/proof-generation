from typing import Optional, List, Tuple, Mapping, Union

from traceback import print_exc

from ml.kore import ast as kore
from ml.kore.utils import KoreUtils, PatternPath
from ml.kore.ast import KoreVisitor

from ml.metamath import ast as mm
from ml.metamath.ast import Proof
from ml.metamath.composer import Theorem
from ml.metamath.auto.sorting import SortingProver

from .encoder import KorePatternEncoder

from .env import ProofEnvironment, ProofGenerator, ProvableClaim
from .equality import EqualityProofGenerator
from .quantifier import QuantifierProofGenerator, FunctionalProofGenerator
from .unification import UnificationProofGenerator, InjectionCombine
from .templates import KoreTemplates
from .disjointness import DisjointnessProofGenerator
from .tasks import RewritingStep, RewritingTask


class RewriteProofGenerator(ProofGenerator):
    """
    Generate proofs for rewriting related claims
    """

    def __init__(self, env: ProofEnvironment):
        super().__init__(env)
        self.owise_assumption_counter = 0
        self.rewrite_claim_counter = 0
        self.simplification_counter = 0
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
            "Lblkeys'LParUndsRParUnds'MAP'Unds'Set'Unds'Map": MapKeysEvaluator(env),
            "LblSet'Coln'in": SetInEvaluator(env),
        }
        self.disjoint_gen = DisjointnessProofGenerator(env)

    def decompose_rewrite_axiom(
        self, pattern: kore.Pattern
    ) -> Tuple[
        kore.Pattern, Optional[kore.Pattern], kore.Pattern, Optional[kore.Pattern]
    ]:
        """
        Returns (lhs, lhs requires, rhs, rhs ensures)
        """

        rewrite_pattern = KoreUtils.strip_forall(pattern)

        assert isinstance(rewrite_pattern, kore.MLPattern) and (
            rewrite_pattern.construct == kore.MLPattern.REWRITES
            or rewrite_pattern.construct == kore.MLPattern.REWRITES_STAR
        )

        lhs, rhs = rewrite_pattern.arguments

        lhs_requires: Optional[kore.Pattern] = None
        rhs_ensures: Optional[kore.Pattern] = None

        if isinstance(lhs, kore.MLPattern) and lhs.construct == kore.MLPattern.AND:
            lhs_requires, lhs_body = lhs.arguments
        else:
            lhs_body = lhs

        if isinstance(rhs, kore.MLPattern) and rhs.construct == kore.MLPattern.AND:
            rhs_ensures, rhs_body = rhs.arguments
        else:
            rhs_body = rhs

        return lhs_body, lhs_requires, rhs_body, rhs_ensures

    def decompose_concrete_rewrite_claim(
        self, provable: ProvableClaim
    ) -> Tuple[kore.Pattern, kore.Pattern]:
        """
        Given a provable claim of the form
        ph1 => ph2 or ph1 =>* ph2,
        return (ph1, ph2)
        """
        rewrite_pattern = provable.claim.pattern
        lhs, _, rhs, _ = self.decompose_rewrite_axiom(rewrite_pattern)
        return lhs, rhs

    def rewrite_from_pattern(
        self,
        pattern: kore.Pattern,
        rule_hint: Optional[str] = None,
        substitution_hints: Optional[Mapping[kore.Variable, kore.Pattern]] = None,
    ) -> ProvableClaim:
        """
        Find and instantiate a rewrite axiom for the given pattern,
        and then resolve all the functions in the RHS
        """
        unification_gen = UnificationProofGenerator(self.env)

        if rule_hint is not None:
            assert (
                rule_hint in self.env.rewrite_axioms
            ), f"unable to find axiom with id {rule_hint} in the hint"
            axioms = [self.env.rewrite_axioms[rule_hint]]
        else:
            axioms = list(self.env.rewrite_axioms.values())

        for rewrite_axiom in axioms:
            print(
                f"> trying axiom {KoreTemplates.get_axiom_unique_id(rewrite_axiom.claim)}"
            )
            lhs, _, _, _ = self.decompose_rewrite_axiom(rewrite_axiom.claim.pattern)

            # apply the substitution hint
            if substitution_hints is not None:
                lhs = KoreUtils.copy_and_substitute_pattern(lhs, substitution_hints)

            unification_result = unification_gen.unify_patterns(lhs, pattern)
            if unification_result is None:
                continue

            # eliminate all universal quantifiers
            substitution = unification_result.substitution

            if substitution_hints is not None:
                substitution = {**substitution, **substitution_hints}

            instantiated_axiom = QuantifierProofGenerator(self.env).prove_forall_elim(
                rewrite_axiom,
                substitution,
            )
            lhs, requires, rhs, ensures = self.decompose_rewrite_axiom(
                instantiated_axiom.claim.pattern
            )

            assert requires is not None

            # assert (
            #     isinstance(ensures, kore.MLPattern) and ensures.construct == kore.MLPattern.TOP
            # ), f"non-top ensures clause is not supported: {ensures}"
            if not (
                isinstance(ensures, kore.MLPattern)
                and ensures.construct == kore.MLPattern.TOP
            ):
                print(f"> warning: non-top ensures clause ignored: {ensures}")

            # trying to prove the requires clause
            # if failed, continue searching for an axiom
            requires_proof = self.prove_requires_clause(requires)
            if requires_proof is None:
                continue

            concrete_rewrite_proof = self.env.get_theorem(
                "kore-rewrites-conditional-concrete"
            ).apply(
                SortingProver.auto,
                SortingProver.auto,
                SortingProver.auto,
                instantiated_axiom.proof,
                requires_proof,
            )

            # reconstruct the rewrite pattern in kore
            assert isinstance(instantiated_axiom.claim.pattern, kore.MLPattern)
            concrete_rewrite = kore.Axiom(
                [],
                kore.MLPattern(
                    kore.MLPattern.REWRITES,
                    [instantiated_axiom.claim.pattern.sorts[0]],
                    [lhs, rhs],
                ),
                [],
            )
            concrete_rewrite.resolve(self.env.module)

            concrete_rewrite_claim = ProvableClaim(
                concrete_rewrite, concrete_rewrite_proof
            )

            # during unification, we applied some equations
            # here we resolve these equations so that we would
            # get a correct left hand side
            for equation, path in unification_result.applied_equations:
                print("> applying unification equation", equation)
                concrete_rewrite_claim = equation.replace_equal_subpattern(
                    concrete_rewrite_claim, [0, 0] + path
                )

            concrete_rewrite_claim = self.apply_rewrite_star_intro(
                concrete_rewrite_claim
            )

            # apply simplification to the rhs of the rewriting claim
            concrete_rewrite_claim = self.simplify_pattern(
                concrete_rewrite_claim, [0, 1]
            )

            return concrete_rewrite_claim

        assert False, "unable to find axiom to rewrite `{}`".format(pattern)

    def prove_rewriting_step(
        self,
        rewriting_step: RewritingStep,
    ) -> ProvableClaim:
        """
        Prove a single rewriting step
        """
        assert rewriting_step.initial is not None

        # TODO: this is a hack to load all domain values
        self.env.encode_pattern(rewriting_step.initial)

        return self.rewrite_from_pattern(
            rewriting_step.initial, rewriting_step.rule_id, rewriting_step.substitution
        )

    def check_equal_or_unify(
        self, given: kore.Pattern, expected: kore.Pattern
    ) -> Optional[ProvableClaim]:
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

        unification_result = UnificationProofGenerator(self.env).unify_patterns(
            expected, given
        )
        assert (
            unification_result is not None
        ), f"expecting the following patterns to be equal or unifiable: {given} and {expected}"

        assert len(unification_result.substitution) == 0, "patterns should be concrete"

        simplification_claim = self.apply_reflexivity(expected)

        for equation, path in unification_result.applied_equations:
            print("> applying unification equation", equation)
            simplification_claim = equation.replace_equal_subpattern(
                simplification_claim, [0, 0] + path
            )

        _, rhs = self.decompose_concrete_rewrite_claim(simplification_claim)
        assert rhs == expected, "unexpected unification"

        return simplification_claim

    def prove_rewriting_task(
        self,
        task: RewritingTask,
    ) -> ProvableClaim:
        """
        Prove a rewriting task which may contain multiple rewrite steps,
        from the given hints
        """
        current_pattern = task.initial

        # simplify before rewriting
        print("==================")
        print("simplifying initial pattern")
        simplification_claim = self.apply_reflexivity(current_pattern)
        simplification_claim = self.simplify_pattern(simplification_claim, [0, 1])
        _, current_pattern = self.decompose_concrete_rewrite_claim(simplification_claim)

        # if the RHS is already the same as to_pattern, no need to do more
        if current_pattern == task.final:
            return simplification_claim

        step_claims = [simplification_claim]

        for i, step in enumerate(task.steps):
            print("==================")
            print("proving rewriting step {}".format(i))

            # check that the current pattern
            # is the same as expected
            # otherwise try to unify
            assert step.initial is not None, "insufficient hints"

            unification_claim = self.check_equal_or_unify(current_pattern, step.initial)
            if unification_claim is not None:
                step_claims.append(unification_claim)
                _, current_pattern = self.decompose_concrete_rewrite_claim(
                    unification_claim
                )

            step_claim = self.prove_rewriting_step(step)
            lhs, rhs = self.decompose_concrete_rewrite_claim(step_claim)

            assert (
                step.initial == lhs
            ), f"unexpected rewriting claim, expected to rewrite from {step.initial}, but got {lhs}"

            self.env.load_comment(f"\nrewriting step:\n{lhs}\n=>\n{rhs}\n")
            step_claim = self.env.load_provable_claim_as_theorem(
                f"rewrite-step-{self.rewrite_claim_counter}", step_claim
            )
            self.rewrite_claim_counter += 1

            step_claims.append(step_claim)
            current_pattern = rhs

        # unify with the final expected pattern
        unification_claim = self.check_equal_or_unify(current_pattern, task.final)
        if unification_claim is not None:
            step_claims.append(unification_claim)

        final_claim = step_claims[0]

        for claim in step_claims[1:]:
            final_claim = self.apply_rewrite_star_transitivity(final_claim, claim)

        return final_claim

    def apply_rewrite_star_intro(self, step: ProvableClaim) -> ProvableClaim:
        """
        Transform a rewrite claim to a rewrite-star claim
        """
        lhs, rhs = self.decompose_concrete_rewrite_claim(step)
        pattern_sort = KoreUtils.infer_sort(lhs)

        new_claim = kore.Claim(
            [],
            kore.MLPattern(kore.MLPattern.REWRITES_STAR, [pattern_sort], [lhs, rhs]),
            [],
        )
        new_claim.resolve(self.env.module)

        return ProvableClaim(
            new_claim,
            self.env.get_theorem("kore-rewrites-star-intro").apply(
                SortingProver.auto,
                SortingProver.auto,
                step.proof,
            ),
        )

    def apply_rewrite_star_transitivity(
        self, step1: ProvableClaim, step2: ProvableClaim
    ) -> ProvableClaim:
        """
        Connect two rewrite-star claims
        """

        lhs1, rhs1 = self.decompose_concrete_rewrite_claim(step1)
        lhs2, rhs2 = self.decompose_concrete_rewrite_claim(step2)
        assert rhs1 == lhs2, "unable to apply transitivity"

        pattern_sort = KoreUtils.infer_sort(lhs1)

        new_claim = kore.Claim(
            [],
            kore.MLPattern(kore.MLPattern.REWRITES_STAR, [pattern_sort], [lhs1, rhs2]),
            [],
        )
        new_claim.resolve(self.env.module)

        return ProvableClaim(
            new_claim,
            self.env.get_theorem("kore-rewrites-star-transitivity").apply(
                SortingProver.auto,
                SortingProver.auto,
                SortingProver.auto,
                step1.proof,
                step2.proof,
            ),
        )

    def decompose_anywhere_axiom(
        self, pattern: kore.Pattern
    ) -> Tuple[kore.Pattern, kore.Pattern, kore.Pattern, kore.Pattern]:
        inner_pattern = KoreUtils.strip_forall(pattern)

        assert (
            isinstance(inner_pattern, kore.MLPattern)
            and inner_pattern.construct == kore.MLPattern.IMPLIES
        )

        requires, conjunction = inner_pattern.arguments

        assert (
            isinstance(conjunction, kore.MLPattern)
            and conjunction.construct == kore.MLPattern.AND
        )

        equation, ensures = conjunction.arguments

        assert (
            isinstance(equation, kore.MLPattern)
            and equation.construct == kore.MLPattern.EQUALS
        )

        lhs, rhs = equation.arguments

        return lhs, requires, rhs, ensures

    def prove_requires_clause(self, pattern: kore.Pattern) -> Optional[Proof]:
        r"""
        Prove a pattern of the form
        - top{S{}}(), or
        - \equals{...}(..., ...)

        For \equals, it can have either a concrete sort
        or a sort variable as the output sort
        """

        assert isinstance(pattern, kore.MLPattern)

        # if the pattern is top, then it's trivially true
        if pattern.construct == kore.MLPattern.TOP:
            sort = pattern.sorts[0]
            encoded_sort = self.env.encode_pattern(sort)
            if isinstance(sort, kore.SortInstance):
                return self.env.get_theorem("kore-top-valid").apply(ph0=encoded_sort)
            else:
                assert isinstance(sort, kore.SortVariable)
                return self.env.get_theorem("kore-top-valid-v1").apply(x=encoded_sort)

        # assert pattern.construct == kore.MLPattern.EQUALS, \
        #        f"unable to prove the requires clause {pattern}"
        if pattern.construct != kore.MLPattern.EQUALS:
            return None

        input_sort, output_sort = pattern.sorts
        encoded_input_sort = self.env.encode_pattern(input_sort)
        encoded_output_sort = self.env.encode_pattern(output_sort)

        lhs, rhs = pattern.arguments
        encoded_lhs = self.env.encode_pattern(lhs)

        # we only support two cases right now:
        # either the equals pattern depends on one
        # free sort variable, or none
        if isinstance(output_sort, kore.SortInstance):
            proof = self.env.get_theorem("kore-equals-reflexivity").apply(
                ph0=encoded_output_sort, ph1=encoded_input_sort, ph2=encoded_lhs
            )
            claim = kore.Claim(
                [],
                kore.MLPattern(
                    kore.MLPattern.EQUALS,
                    [
                        input_sort,
                        output_sort,
                    ],
                    [lhs, lhs],
                ),
                [],
            )
            claim.resolve(self.env.module)
            provable = ProvableClaim(claim, proof)
        else:
            assert isinstance(output_sort, kore.SortVariable)
            proof = self.env.get_theorem("kore-equals-reflexivity-v1").apply(
                x=encoded_output_sort, ph0=encoded_input_sort, ph1=encoded_lhs
            )
            claim = kore.Claim(
                [output_sort],
                kore.MLPattern(
                    kore.MLPattern.EQUALS,
                    [
                        input_sort,
                        output_sort,
                    ],
                    [lhs, lhs],
                ),
                [],
            )
            claim.resolve(self.env.module)
            provable = ProvableClaim(claim, proof)

        provable = self.simplify_pattern(provable, [0, 1])

        # failed to prove the condition
        assert isinstance(provable.claim.pattern, kore.MLPattern)
        if provable.claim.pattern.arguments[1] != rhs:
            return None

        return provable.proof

    def prove_owise_clause(self, condition: kore.Pattern) -> Optional[Proof]:
        assert (
            isinstance(condition, kore.MLPattern)
            and condition.construct == kore.MLPattern.AND
        )

        (output_sort,) = condition.sorts
        assert isinstance(output_sort, kore.SortVariable)

        # TODO: currently we don't have enough axioms in the kore definition
        # to show this condition, so we will just assume it being true

        claim = kore.Claim([output_sort], condition, [])
        claim.resolve(self.env.module)

        try:
            # trying to prove the simplest case with 1 other rule and 1 free variable
            # TODO: make this more general
            eq = KoreUtils.get_subpattern_by_path(condition, [0, 0, 0, 1, 1, 0, 0])
            assert isinstance(eq, kore.MLPattern)
            left, right = eq.arguments

            print("> proving disjointness claim")
            disjoint_proof = self.disjoint_gen.prove_disjointness(left, right)

            proof = self.env.get_theorem("owise-1-rule-1-var").match_and_apply(
                self.env.encode_metamath_statement(claim),
                disjoint_proof,
            )

            return proof
        except:
            print_exc()
            print("failed to prove owise condition, leavinig it as an assumption")
            theorem = self.env.load_axiom(
                claim,
                f"owise-assumption-{self.owise_assumption_counter}",
                provable=True,
            )
            self.owise_assumption_counter += 1
            return theorem.as_proof()

    def match_and_instantiate_anywhere_axiom(
        self, axiom: ProvableClaim, pattern: kore.Pattern, is_owise: bool = False
    ) -> Optional[ProvableClaim]:
        # unify the LHS
        lhs, _, _, _ = self.decompose_anywhere_axiom(axiom.claim.pattern)
        unification_result = UnificationProofGenerator(self.env).unify_patterns(
            lhs, pattern
        )
        if unification_result is None:
            return None

        # eliminate all universal quantifiers
        instantiated_axiom = QuantifierProofGenerator(self.env).prove_forall_elim(
            axiom, unification_result.substitution
        )

        lhs, requires, _, ensures = self.decompose_anywhere_axiom(
            instantiated_axiom.claim.pattern
        )

        # assert isinstance(ensures, kore.MLPattern) and \
        #        ensures.construct == kore.MLPattern.TOP, \
        #        f"unsupported ensures clause {ensures}"
        if not (
            isinstance(ensures, kore.MLPattern)
            and ensures.construct == kore.MLPattern.TOP
        ):
            return None

        # from \implies{R}(<requires>, \and{R}(<equation>, top))
        # if we can prove the requires clause
        # we can get \and{R}(<equation>, top)
        if not is_owise:
            requires_proof = self.prove_requires_clause(requires)
            if requires_proof is None:
                return None
        else:
            # if the current axiom is labelled [owise]
            # we have failed to match other non-owise axioms.
            # by the informal semantics of [owise] we should
            # use this rule if it matches.
            requires_proof = self.prove_owise_clause(requires)
            assert (
                requires_proof is not None
            ), f"unable to prove owise condition {requires}"

        removed_requires = self.env.get_theorem("kore-mp-v1").apply(
            requires_proof,
            instantiated_axiom.proof,
        )
        assert isinstance(instantiated_axiom.claim.pattern, kore.MLPattern)
        instantiated_axiom_claim = kore.Claim(
            instantiated_axiom.claim.sort_variables,
            instantiated_axiom.claim.pattern.arguments[1],
            [],
        )
        instantiated_axiom_claim.resolve(self.env.module)
        instantiated_axiom = ProvableClaim(instantiated_axiom_claim, removed_requires)

        # now we have a conjunction and{R}(<equation>, <ensures>)
        # since we assumed ensures is top, we can remove it as well
        # that is, from \and{R}(<equation>, top)
        # we can get <equation>
        and_eliminated = self.env.get_theorem("kore-and-equals-top-elim-v1").apply(
            instantiated_axiom.proof,
        )
        assert isinstance(instantiated_axiom.claim.pattern, kore.MLPattern)
        instantiated_axiom_claim = kore.Claim(
            instantiated_axiom.claim.sort_variables,
            instantiated_axiom.claim.pattern.arguments[0],
            [],
        )
        instantiated_axiom_claim.resolve(self.env.module)
        instantiated_axiom = ProvableClaim(instantiated_axiom_claim, and_eliminated)

        for equation, path in unification_result.applied_equations:
            instantiated_axiom = equation.replace_equal_subpattern(
                instantiated_axiom, [0, 0] + path
            )

        return instantiated_axiom

    def find_anywhere_axiom_for_pattern(self, pattern: kore.Pattern) -> ProvableClaim:
        """
        Find and instantiate a anywhere/function axiom for the given (function) pattern
        """

        assert isinstance(pattern, kore.Application), f"{pattern} is not an application"

        head_symbol = pattern.symbol
        assert (
            head_symbol in self.env.equational_axioms
        ), f"head symbol {head_symbol} does not have any equational axioms associated to it"

        non_owise_axioms = []
        owise_axiom = None

        for axiom in self.env.equational_axioms[head_symbol]:
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
            instantiated = self.match_and_instantiate_anywhere_axiom(
                owise_axiom, pattern, is_owise=True
            )
            if instantiated is not None:
                return instantiated

        raise Exception(
            f"unable to find anywhere/function rule to rewrite term {pattern}"
        )

    def is_simplifiable(self, pattern: kore.Pattern) -> bool:
        """
        Checks if the given pattern is "simplifiable", that is, if
        it contains duplicate injections and/or unevaluated functions
        """

        nested_inj_path = InnermostNestedInjectionPathVisitor(self.env).visit(pattern)
        if nested_inj_path is not None:
            return True

        function_path = InnermostFunctionPathVisitor().visit(pattern)
        if function_path is not None:
            return True

        return False

    def simplify_pattern(
        self, provable: ProvableClaim, path: PatternPath, bound: int = -1
    ) -> ProvableClaim:
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
            nested_inj_path = InnermostNestedInjectionPathVisitor(self.env).visit(
                subpattern
            )
            if nested_inj_path is not None:
                print(f"> simplifying nested inj")
                provable = InjectionCombine(self.env).replace_equal_subpattern(
                    provable, path + nested_inj_path
                )
                continue

            # resolve unresolved functions
            function_path = InnermostFunctionPathVisitor().visit(subpattern)
            if function_path is not None:
                function_subpattern = KoreUtils.get_subpattern_by_path(
                    subpattern, function_path
                )
                assert isinstance(function_subpattern, kore.Application)
                print(f"> rewriting anywhere/function {function_subpattern.symbol}")

                # if the symbol is bulitin, try the builtin evaluator
                symbol_string = function_subpattern.symbol.get_symbol_name()
                if symbol_string in self.hooked_symbol_evaluators:
                    axiom = self.hooked_symbol_evaluators[
                        symbol_string
                    ].prove_evaluation(function_subpattern)
                else:
                    axiom = self.find_anywhere_axiom_for_pattern(function_subpattern)

                # finish up the rewriting by substituting in the rhs
                provable = EqualityProofGenerator(
                    self.env
                ).replace_equal_subpattern_with_equation(
                    provable, path + function_path, axiom
                )
                continue

            break

        return provable

    def apply_reflexivity(self, pattern: kore.Pattern) -> ProvableClaim:
        pattern_sort = KoreUtils.infer_sort(pattern)

        refl_claim = kore.Claim(
            [],
            kore.MLPattern(
                kore.MLPattern.REWRITES_STAR, [pattern_sort], [pattern, pattern]
            ),
            [],
        )
        refl_claim.resolve(self.env.module)

        refl_proof = self.env.get_theorem("kore-rewrites-star-reflexivity").apply(
            SortingProver.auto,
            ph0=self.env.encode_pattern(pattern_sort),
            ph1=self.env.encode_pattern(pattern),
        )

        return ProvableClaim(refl_claim, refl_proof)


class InnermostNestedInjectionPathVisitor(
    KoreVisitor[Union[kore.Pattern, kore.Axiom], Optional[PatternPath]]
):
    def __init__(self, env: ProofEnvironment):
        super().__init__()
        self.env = env

    def postvisit_variable(self, variable: kore.Variable) -> Optional[PatternPath]:
        return None

    def postvisit_string_literal(
        self, literal: kore.StringLiteral
    ) -> Optional[PatternPath]:
        return None

    def postvisit_application(
        self, application: kore.Application
    ) -> Optional[PatternPath]:
        for i, arg in enumerate(application.arguments):
            path = self.visit(arg)
            if path is not None:
                return [i] + path

        # if the current pattern is a nested injection
        if (
            application.symbol.definition == self.env.sort_injection_symbol
            and isinstance(application.arguments[0], kore.Application)
            and application.arguments[0].symbol.definition
            == self.env.sort_injection_symbol
        ):
            return []

        return None

    def postvisit_ml_pattern(self, ml_pattern: kore.MLPattern) -> Optional[PatternPath]:
        for i, arg in enumerate(ml_pattern.arguments):
            path = self.visit(arg)
            if path is not None:
                return [i] + path

        return None


class InnermostFunctionPathVisitor(
    KoreVisitor[Union[kore.Pattern, kore.Axiom], Optional[PatternPath]]
):
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
        "Lbl'Stop'Set",
        "LblSetItem",
        "Lbl'Unds'Set'Unds",
    }

    def postvisit_variable(self, variable: kore.Variable) -> Optional[PatternPath]:
        return None

    def postvisit_string_literal(
        self, literal: kore.StringLiteral
    ) -> Optional[PatternPath]:
        return None

    def postvisit_application(
        self, application: kore.Application
    ) -> Optional[PatternPath]:
        for i, arg in enumerate(application.arguments):
            path = self.visit(arg)
            if path is not None:
                return [i] + path

        # if the application itself is a function, return the empty path (pointing to itself)
        if (
            isinstance(application.symbol.definition, kore.SymbolDefinition)
            and application.symbol.definition.get_attribute_by_symbol("function")
            is not None
            and application.symbol.definition.symbol
            not in InnermostFunctionPathVisitor.EXCEPTIONS
        ):
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

    def __init__(self, env: ProofEnvironment):
        super().__init__(env)
        self.axiom_counter = 0

    def parse_int(self, value: kore.Pattern) -> int:
        assert (
            isinstance(value, kore.MLPattern) and value.construct == kore.MLPattern.DV
        )
        assert (
            isinstance(value.sorts[0], kore.SortInstance)
            and value.sorts[0].get_sort_id() == "SortInt"
        )

        assert isinstance(value.arguments[0], kore.StringLiteral)
        return int(value.arguments[0].content)

    def parse_bool(self, value: kore.Pattern) -> bool:
        assert (
            isinstance(value, kore.MLPattern) and value.construct == kore.MLPattern.DV
        )
        assert (
            isinstance(value.sorts[0], kore.SortInstance)
            and value.sorts[0].get_sort_id() == "SortBool"
        )
        assert isinstance(value.arguments[0], kore.StringLiteral)
        return {"true": True, "false": False}[value.arguments[0].content]

    def prove_evaluation(self, application: kore.Application) -> ProvableClaim:
        raise NotImplementedError()

    def build_equation(
        self, application: kore.Application, result: kore.Pattern
    ) -> ProvableClaim:
        sort_var = kore.SortVariable("R")
        output_sort = KoreUtils.infer_sort(application)

        assert output_sort == KoreUtils.infer_sort(
            result
        ), f"result {result} has a different sort than {application}"

        claim = kore.Claim(
            [sort_var],
            kore.MLPattern(
                kore.MLPattern.EQUALS,
                [output_sort, sort_var],
                [application, result],
            ),
            [],
        )

        claim.resolve(self.env.module)

        # TODO: we need to generate a proof obligation for
        # this arithmetic fact
        self.env.composer.start_segment("dv")
        self.env.load_comment("NOTE: domain value reasoning checked by external tool")
        thm = self.env.load_axiom(
            claim,
            f"{self.env.sanitize_label_name(application.symbol.get_symbol_name())}-domain-fact-{self.axiom_counter}",
            comment=False,
            provable=self.env.dv_as_provable,
        )
        self.env.composer.end_segment()

        print(f"> bulitin symbol proof obligation: {claim}")

        self.axiom_counter += 1

        return ProvableClaim(claim, thm.as_proof())

    def build_arithmetic_equation(
        self, application: kore.Application, result: Union[int, bool]
    ) -> ProvableClaim:
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

        domain_value = kore.MLPattern(
            kore.MLPattern.DV, [output_sort], [kore.StringLiteral(result_literal)]
        )
        domain_value.resolve(self.env.module)

        return self.build_equation(application, domain_value)


class IntegerAdditionEvaluator(BuiltinFunctionEvaluator):
    def prove_evaluation(self, application: kore.Application) -> ProvableClaim:
        a, b = application.arguments
        return self.build_arithmetic_equation(
            application, self.parse_int(a) + self.parse_int(b)
        )


class IntegerSubtractionEvaluator(BuiltinFunctionEvaluator):
    def prove_evaluation(self, application: kore.Application) -> ProvableClaim:
        a, b = application.arguments
        return self.build_arithmetic_equation(
            application, self.parse_int(a) - self.parse_int(b)
        )


class IntegerMultiplicationEvaluator(BuiltinFunctionEvaluator):
    def prove_evaluation(self, application: kore.Application) -> ProvableClaim:
        a, b = application.arguments
        return self.build_arithmetic_equation(
            application, self.parse_int(a) * self.parse_int(b)
        )


class IntegerDivisionEvaluator(BuiltinFunctionEvaluator):
    def prove_evaluation(self, application: kore.Application) -> ProvableClaim:
        a, b = application.arguments
        return self.build_arithmetic_equation(
            application, self.parse_int(a) // self.parse_int(b)
        )


class IntegerGreaterThanOrEqualToEvaluator(BuiltinFunctionEvaluator):
    def prove_evaluation(self, application: kore.Application) -> ProvableClaim:
        a, b = application.arguments
        return self.build_arithmetic_equation(
            application, self.parse_int(a) >= self.parse_int(b)
        )


class IntegerLessThanOrEqualToEvaluator(BuiltinFunctionEvaluator):
    def prove_evaluation(self, application: kore.Application) -> ProvableClaim:
        a, b = application.arguments
        return self.build_arithmetic_equation(
            application, self.parse_int(a) <= self.parse_int(b)
        )


class IntegerEqualityEvaluator(BuiltinFunctionEvaluator):
    def prove_evaluation(self, application: kore.Application) -> ProvableClaim:
        a, b = application.arguments
        return self.build_arithmetic_equation(
            application, self.parse_int(a) == self.parse_int(b)
        )


class BooleanAndEvaluator(BuiltinFunctionEvaluator):
    def prove_evaluation(self, application: kore.Application) -> ProvableClaim:
        a, b = application.arguments
        return self.build_arithmetic_equation(
            application, self.parse_bool(a) and self.parse_bool(b)
        )


class BooleanNotEvaluator(BuiltinFunctionEvaluator):
    def prove_evaluation(self, application: kore.Application) -> ProvableClaim:
        (a,) = application.arguments
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


class SetInEvaluator(BuiltinFunctionEvaluator):
    def is_element(self, app: kore.Application, element: kore.Pattern) -> bool:

        if KoreTemplates.is_set_unit_pattern(app):
            return False
        elif KoreTemplates.is_set_merge_pattern(app):

            left, right = app.arguments
            assert isinstance(left, kore.Application)
            assert isinstance(right, kore.Application)

            element_in_left = self.is_element(left, element)
            element_in_right = self.is_element(right, element)

            return element_in_left or element_in_right
        elif KoreTemplates.is_set_singleton_pattern(app):
            found_element = app.arguments

            return element == found_element

        return False

    def prove_evaluation(self, application: kore.Application) -> ProvableClaim:
        key, set_pattern = application.arguments

        assert isinstance(set_pattern, kore.Application)
        return self.build_arithmetic_equation(
            application, self.is_element(set_pattern, key)
        )


class MapKeysEvaluator(BuiltinFunctionEvaluator):
    def get_keys(self, app: kore.Application) -> kore.Pattern:
        if KoreTemplates.is_map_unit_pattern(app):
            unit_symbol = self.env.module.get_symbol_by_name("Lbl'Stop'Set")
            assert unit_symbol is not None
            unit_symbol_instance = kore.SymbolInstance(unit_symbol, [])
            return kore.Application(unit_symbol_instance, [])
        elif KoreTemplates.is_map_merge_pattern(app):

            left, right = app.arguments
            merge_symbol = self.env.module.get_symbol_by_name("Lbl'Unds'Set'Unds")
            assert isinstance(left, kore.Application)
            assert isinstance(right, kore.Application)
            assert merge_symbol is not None

            left_keys = self.get_keys(left)
            right_keys = self.get_keys(right)

            merge_symbol_instance = kore.SymbolInstance(merge_symbol, [])
            return kore.Application(merge_symbol_instance, [left_keys, right_keys])
        else:
            assert KoreTemplates.is_map_mapsto_pattern(app)
            key, value = app.arguments

            singleton_symbol = self.env.module.get_symbol_by_name("LblSetItem")
            assert singleton_symbol is not None
            singleton_symbol_instance = kore.SymbolInstance(singleton_symbol, [])
            return kore.Application(singleton_symbol_instance, [key])

    def prove_evaluation(self, application: kore.Application) -> ProvableClaim:
        map_pattern = application.arguments[0]

        assert isinstance(map_pattern, kore.Application)
        return self.build_equation(application, self.get_keys(map_pattern))
