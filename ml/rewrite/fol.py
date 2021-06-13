from typing import List, Tuple, Mapping, Dict, Optional, Union

from ml.kore import ast as kore
from ml.kore.visitors import PatternVariableVisitor, SortVariableVisitor
from ml.kore.utils import KoreUtils, PatternPath

from ml.metamath import ast as mm
from ml.metamath.composer import Proof
from ml.metamath.utils import MetamathUtils
from ml.metamath.auto.sorting import SortingProver
from ml.metamath.auto.hypothesis import HypothesisProver
from ml.metamath.auto.substitution import SubstitutionProver
from ml.metamath.auto.fresh import FreshProver
from ml.metamath.auto.predicate import PredicateProver

from .env import ProofGenerator, ProvableClaim
from .substitution import SingleSubstitutionProofGenerator
from .encoder import KoreEncoder, KoreDecoder
from .propositional import PropositionalProofGenerator


class FOLProofGenerator(ProofGenerator):
    """
    Generating proofs related to FOL and equality reasoning
    """
    def apply_symmetry(self, equation: ProvableClaim) -> ProvableClaim:
        return self.composer.apply_kore_lemma("kore-equals-symmetry", equation)

    def apply_forall_intro(self, provable: ProvableClaim, variable: kore.Variable) -> ProvableClaim:
        """
        Universally quantify an indicated free variable
        """

        # assert variable in KoreUtils.get_free_variables(provable.claim), \
        #        f"{variable} is not a free variable in {provable.claim}"

        goal = KoreUtils.construct_forall(variable, provable.claim.pattern)

        encoded_variable = self.composer.encode_pattern(variable)
        encoded_sort = self.composer.encode_pattern(variable.sort)

        other_premises = KoreEncoder().encode_free_variable_premise(goal)
        variable_sorting = MetamathUtils.construct_in_sort(encoded_variable, encoded_sort)

        premises_rearranged = SortingProver.rearrange_premise(
            self.composer,
            MetamathUtils.construct_and(variable_sorting, other_premises),
            provable.proof,
        )

        return self.composer.construct_provable_claim(
            claim=goal,
            proof=self.composer.get_theorem("kore-forall-intro-alt").apply(premises_rearranged, ),
        )

    def apply_forall_elim(self, provable: ProvableClaim) -> ProvableClaim:
        """
        Remove the top level universal quantifier and let the variable appear free
        """
        var, _ = KoreUtils.destruct_forall(provable.claim.pattern)
        imp = self.apply_functional_substitution_as_implication(provable.claim.pattern, {var: var})
        return PropositionalProofGenerator(self.composer).apply_mp(imp, provable)

    def eliminate_all_universal_quantifiers(self, provable: ProvableClaim) -> ProvableClaim:
        while KoreUtils.is_forall(provable.claim.pattern):
            provable = self.apply_forall_elim(provable)
        return provable

    def apply_implies_compat_in_forall(self, provable: ProvableClaim, variable: kore.Variable) -> ProvableClaim:
        """
        From
        |- phi -> psi
        get
        |- (forall x phi) -> (forall x psi)
        """

        lhs, _ = KoreUtils.destruct_implies(provable.claim.pattern)

        # |- ( \forall x phi ) -> phi
        quantified_lhs = KoreUtils.construct_forall(variable, lhs)
        forall_elim = self.apply_functional_substitution_as_implication(quantified_lhs, {variable: variable})

        prop_gen = PropositionalProofGenerator(self.composer)

        # |- ( \forall x phi ) -> psi
        provable = prop_gen.apply_implies_transitivity(
            forall_elim,
            provable,
        )

        # |- ( \forall x ( \forall x phi ) -> psi )
        provable = self.apply_forall_intro(provable, variable)

        # |- ( \forall x phi ) -> ( \forall x psi )
        provable = self.apply_prenex_implies_right(provable)

        return provable

    def apply_prenex_implies_left(self, provable: ProvableClaim) -> ProvableClaim:
        """
        Given a proof of |- phi -> forall x psi
        return a proof of |- forall x (phi -> psi)
        given that x is free in phi
        """
        left, right = KoreUtils.destruct_implies(provable.claim.pattern)
        var, right_body = KoreUtils.destruct_forall(right)

        return PropositionalProofGenerator(self.composer).apply_mp(
            self.get_prenex_implies_left(
                var,
                left,
                right_body,
            ),
            provable,
        )

    def apply_prenex_implies_right(self, provable: ProvableClaim) -> ProvableClaim:
        """
        Given a proof of |- forall x (phi -> psi)
        return a proof of |- phi -> forall x psi
        given that x is free in phi
        """
        var, body = KoreUtils.destruct_forall(provable.claim.pattern)
        left, right = KoreUtils.destruct_implies(body)

        return PropositionalProofGenerator(self.composer).apply_mp(
            self.get_prenex_implies_right(
                var,
                left,
                right,
            ),
            provable,
        )

    def get_prenex_implies_left(
        self, variable: kore.Variable, left: kore.Pattern, right: kore.Pattern
    ) -> ProvableClaim:
        r"""
        Given patterns left, right and a variable x
        Return a proof of
        |- (left -> forall x right) -> forall x (left -> right)
        given that x is free in left
        """

        goal = KoreUtils.construct_implies(
            KoreUtils.construct_implies(left, KoreUtils.construct_forall(variable, right)),
            KoreUtils.construct_forall(variable, KoreUtils.construct_implies(left, right))
        )

        return self.composer.apply_kore_lemma(
            "kore-forall-prenex-implies-left",
            goal=self.composer.construct_claim(goal),
        )

    def get_prenex_implies_right(
        self, variable: kore.Variable, left: kore.Pattern, right: kore.Pattern
    ) -> ProvableClaim:
        r"""
        Given patterns left, right and a variable x
        Return a proof of
        |- (forall x (left -> right)) -> (left -> forall x right)
        given that x is free in left
        """

        goal = KoreUtils.construct_implies(
            KoreUtils.construct_forall(variable, KoreUtils.construct_implies(left, right)),
            KoreUtils.construct_implies(left, KoreUtils.construct_forall(variable, right)),
        )

        return self.composer.apply_kore_lemma(
            "kore-forall-prenex-implies-right",
            goal=self.composer.construct_claim(goal),
        )

    def replace_equal_subpattern(
        self,
        provable: ProvableClaim,
        path: PatternPath,
        equation: ProvableClaim,
    ) -> ProvableClaim:
        """
        Apply an equation at the given path from lhs to rhs
        """

        equation_sort = KoreUtils.infer_sort(equation.claim.pattern)
        assert isinstance(equation_sort, kore.SortVariable), \
               f"expecting a more general form with a free sort variable"

        lhs, rhs = KoreUtils.destruct_equals(equation.claim.pattern)
        subpattern = KoreUtils.get_subpattern_by_path(provable.claim, path)
        assert lhs == subpattern, \
               f"cannot apply equation {equation} on a {subpattern}"

        goal = KoreUtils.copy_and_replace_path_by_pattern_in_axiom(provable.claim, path, rhs)

        encoded_goal = self.composer.encode_metamath_statement(goal)
        cached_proof = self.composer.lookup_proof_cache("equality-elim", encoded_goal)
        if cached_proof is not None:
            return ProvableClaim(goal, cached_proof)

        # collect all free (sort and pattern) variables
        free_vars = {var.name for var in PatternVariableVisitor().visit(provable.claim)}
        free_vars = free_vars.union({var.name for var in KoreUtils.get_free_sort_variables(provable.claim)})

        fresh_var_name, = self.composer.gen_fresh_metavariables("#ElementVariable", 1, free_vars)
        fresh_var = kore.Variable(fresh_var_name, KoreUtils.infer_sort(lhs))

        template = KoreUtils.copy_and_replace_path_by_pattern_in_axiom(provable.claim, path, fresh_var)

        encoded_template = self.composer.encode_pattern(template)
        _, encoded_template_body = MetamathUtils.destruct_imp(encoded_template)

        return self.composer.apply_kore_lemma(
            "kore-equals-elim-alt",
            # instantiate the equation with unit-sort for convenience
            self.instantiate_claim_with_unit_sort(equation),
            provable,
            goal=goal,
            cache_key="equality-elim",
            ph4=encoded_template_body,
            x=self.composer.encode_pattern(fresh_var),
        )

    def apply_functional_substitution_as_implication(
        self, pattern: kore.Pattern, substitution: Mapping[kore.Variable, kore.Pattern]
    ) -> ProvableClaim:
        """
        Given a universally quantified pattern forall x. phi (at the kore level)
        return a proof of
        |- (forall x. phi) -> phi[psi/x]
        """

        free_vars = set()
        for _, v in substitution.items():
            free_vars.update(KoreUtils.get_free_variables(v))

        fresh_var_substitution = {
            free_var: kore.Variable(f"Fresh{free_var.name}", free_var.sort)
            for free_var in free_vars
        }

        # replace all free variables in the substitutes by fresh variables
        substitution = {
            k: KoreUtils.copy_and_substitute_pattern(v, fresh_var_substitution)
            for k, v in substitution.items()
        }

        claims = []

        while len(substitution):
            var, body = KoreUtils.destruct_forall(pattern)
            assert var in substitution, \
                   f"variable {var} not found in the substitution"

            original_substitute = substitute = substitution[var]
            del substitution[var]

            functional_proof = self.composer.get_theorem("kore-functional").apply(
                SortingProver.auto,
                self.instantiate_claim_with_unit_sort(self.prove_kore_functional(substitute)).proof,
            )

            claim = self.apply_functional_substitution_as_implication_raw(pattern, substitute, functional_proof)
            claims.append(claim)

            pattern = KoreUtils.copy_and_substitute_pattern(body, {var: original_substitute})

        final_claim = PropositionalProofGenerator(self.composer).apply_implies_multiple_transitivity(*claims)

        # restore the free variables
        for k, v in fresh_var_substitution.items():
            final_claim = self.rename_free_variable(final_claim, v, k.name)

        return final_claim

    def apply_functional_substitution(
        self, provable: ProvableClaim, substitution: Dict[kore.Variable, kore.Pattern]
    ) -> ProvableClaim:
        """
        Substitute a free pattern variable in the given claim with
        a functional pattern and return a new provable claim
        """

        for k, v in sorted(substitution.items(), key=lambda t: t[0].name):
            functional_claim = self.prove_kore_functional(v)
            provable = self.apply_functional_substitution_raw(
                provable,
                k,
                v,
                self.composer.get_theorem("kore-functional").apply(
                    SortingProver.auto,
                    self.instantiate_claim_with_unit_sort(functional_claim).proof,
                ),
            )

        return provable

    def apply_sort_substitution(
        self, provable: ProvableClaim, substitution: Dict[kore.SortVariable, kore.Sort]
    ) -> ProvableClaim:
        """
        Substitute a free sort variable in the given claim with
        a sort and return a new provable claim
        """

        for sort_var, sort in sorted(substitution.items(), key=lambda t: t[0].name):
            assert len(KoreUtils.get_free_sort_variables(sort)) == 0, \
                   f"substituting sorts with free sort variables is not supported"

            sort_is_functional = self.composer.get_theorem("kore-sort-functional").apply(
                SortingProver.auto,
                th0=MetamathUtils.construct_top(),
                ph0=self.composer.encode_pattern(sort),
                x=mm.Metavariable("x"),
            )

            provable = self.apply_functional_substitution_raw(
                provable,
                sort_var,
                sort,
                sort_is_functional,
            )

        return provable

    def prove_inj_functional(self, application: kore.Application) -> ProvableClaim:
        """
        Specical case: when A is not an immediate subsort of B,
        we don't have the functional axiom of inj{A, B},
        in which case we need to stitch the chain of subsorting
        A < A1 < ... < B together to get a functional pattern
        and then use the inj axiom to reduce that back to
        a single injection.
        """
        assert application.symbol.definition == self.composer.sort_injection_symbol

        sort1, sort2 = application.symbol.sort_arguments
        assert isinstance(sort1, kore.SortInstance) and isinstance(sort2, kore.SortInstance)

        chain = self.composer.subsort_relation.get_subsort_chain(sort1, sort2)
        assert (chain is not None), f"{sort1} is not a subsort of {sort2}, unable to prove that it's functional"
        assert len(chain) > 2, f"{sort1} is an immediate subsort of {sort2}"

        argument = application.arguments[0]

        # suppose the chain is S1 < S2 < ... < Sn
        # first recursively prove the functionality of
        # inj{Sn-1, Sn}(inj{S1, Sn-1}(<argument>))
        reduced_injection = kore.Application(
            kore.SymbolInstance(self.composer.sort_injection_symbol, [sort1, chain[-2]]),
            [argument],
        )
        reduced_injection = kore.Application(
            kore.SymbolInstance(self.composer.sort_injection_symbol, [chain[-2], chain[-1]]),
            [reduced_injection],
        )
        reduced_injection.resolve(self.composer.module)
        reduced_injection_is_functional = self.prove_kore_functional(reduced_injection)

        # get an instance of the injection axiom
        # with sort variables replaced by S1, Sn-1, and Sn
        inj_axiom_instance = self.get_inj_instance(sort1, chain[-2], chain[-1])

        # inj_axiom_instance is of the form
        # \forall{...}(X:<sort1>, ... = ...)
        # we need to substitute current_argument for X in the equation
        free_var, = KoreUtils.get_free_variables(inj_axiom_instance.claim)
        inj_axiom_instance = self.apply_functional_substitution(inj_axiom_instance, {free_var: argument})

        return self.replace_equal_subpattern(
            reduced_injection_is_functional,
            [
                0,
                1,
                1,
            ],  # this is the path of the LHS of the equation in reduced_injection_axiom
            inj_axiom_instance,
        )

    def prove_functional(self, pattern: kore.Pattern) -> Proof:
        r"""
        Prove a ML level functional claim: |- ( \imp ... ( \exists x ( \eq x <pattern> ) ) )
        """
        return self.composer.get_theorem("kore-functional").apply(
            SortingProver.auto,
            self.instantiate_claim_with_unit_sort(self.prove_kore_functional(pattern)).proof,
        )

    def prove_kore_functional(self, pattern: kore.Pattern) -> ProvableClaim:
        r"""
        Return a proof of
        |- ( \imp <premise> ( \kore-valid R ( \kore-exists ph0 R x ( \kore-equals ph0 R x <pattern> ) ) )
        where x is some variable free in pattern
              <premise> contains sorting hypotheses for free variables
        """

        if isinstance(pattern, kore.Application):
            if pattern.symbol not in self.composer.functional_axioms:
                # injection is handled as a special case
                if pattern.symbol.definition == self.composer.sort_injection_symbol:
                    return self.prove_inj_functional(pattern)

                assert False, f"cannot find functional axiom for symbol instance {pattern.symbol}"

            functional_axiom = self.composer.functional_axioms[pattern.symbol]

            var, body = KoreUtils.destruct_exists(functional_axiom.claim.pattern)
            lhs, rhs = KoreUtils.destruct_equals(body)
            assert var == lhs, \
                   f"ill-formed functional axiom {functional_axiom.claim}"

            assert isinstance(rhs, kore.Application) and \
                   rhs.symbol == pattern.symbol and \
                   len(rhs.arguments) == len(pattern.arguments), \
                   f"ill-formed functional axiom {functional_axiom.claim}"

            # instantiate the axiom with arguments
            for axiom_var, argument in zip(rhs.arguments, pattern.arguments):
                assert isinstance(axiom_var, kore.Variable)
                argument_is_functional = self.prove_kore_functional(argument)
                functional_axiom = self.apply_functional_substitution_raw(
                    functional_axiom,
                    axiom_var,
                    argument,
                    # turn the Kore-level claim to a ML-level functional statement
                    self.composer.get_theorem("kore-functional").apply(
                        SortingProver.auto,
                        self.instantiate_claim_with_unit_sort(argument_is_functional).proof,
                    ),
                )

            return functional_axiom

        elif isinstance(pattern, kore.Variable):
            fresh_var_name, sort_var_name = self.composer.gen_fresh_metavariables("#ElementVariable", 2, {pattern.name})
            fresh_var = kore.Variable(fresh_var_name, pattern.sort)
            sort_var = kore.SortVariable(sort_var_name)

            return self.composer.construct_provable_claim(
                claim=KoreUtils.construct_exists(fresh_var, KoreUtils.construct_equals(sort_var, fresh_var, pattern)),
                proof=self.composer.get_theorem("kore-variable-functional").apply(
                    x=self.composer.encode_pattern(pattern),
                    y=self.composer.encode_pattern(fresh_var),
                    ph1=self.composer.encode_pattern(sort_var),
                    ph0=self.composer.encode_pattern(pattern.sort),
                ),
            )

        elif KoreUtils.is_dv(pattern):
            # add domain value axioms if we don't have them
            self.composer.encode_pattern(pattern)

            sort, literal = KoreUtils.destruct_dv(pattern)
            assert isinstance(sort, kore.SortInstance)

            assert (sort, literal) in self.composer.domain_value_functional_axioms, \
                   f"cannot find functional axiom for domain value pattern {pattern}"

            return self.composer.domain_value_functional_axioms[sort, literal]

        assert False, f"unable to prove {pattern} is funtional"

    def get_inj_instance(self, sort1: kore.Sort, sort2: kore.Sort, sort3: kore.Sort) -> ProvableClaim:
        """
        Return a provable claim of the form
        inj{sort2, sort3}(inj{sort1, sort2}(x)) = inj{sort1, sort3}(x)
        """
        # NOTE: this depends on the order in which the parametric sort variables
        # are generated

        assert (
            isinstance(sort1, kore.SortInstance) and len(sort1.arguments) == 0 and isinstance(sort2, kore.SortInstance)
            and len(sort2.arguments) == 0 and isinstance(sort3, kore.SortInstance) and len(sort3.arguments) == 0
        ), "parametric sort not supported"

        assert self.composer.sort_injection_axiom is not None

        (
            sort_var1,
            sort_var2,
            sort_var3,
            _,
        ) = self.composer.sort_injection_axiom.claim.sort_variables

        return self.apply_sort_substitution(
            self.composer.sort_injection_axiom,
            {
                sort_var1: sort1,
                sort_var2: sort2,
                sort_var3: sort3,
            },
        )

    def instantiate_claim_with_unit_sort(self, claim: ProvableClaim) -> ProvableClaim:
        r"""
        Instantiate a free sort variable in the claim with \unit-sort
        """
        sort_var = KoreUtils.infer_sort(claim.claim.pattern)
        assert isinstance(sort_var, kore.SortVariable), \
               f"expecting a free sort variable in {claim.claim}"

        encoded_sort_var = self.composer.encode_pattern(sort_var)
        assert isinstance(encoded_sort_var, mm.Metavariable)

        unit_sort_functional = self.composer.get_theorem("unit-sort-is-functional").apply(x=mm.Metavariable("x"))

        return self.apply_functional_substitution_raw(claim, sort_var, self.composer.unit_sort, unit_sort_functional)

    def rename_free_variable(self, claim: ProvableClaim, var: kore.Variable, new_name: str) -> ProvableClaim:
        new_var = kore.Variable(new_name, var.sort)
        new_claim = KoreUtils.copy_and_substitute_pattern(claim.claim, {var: new_var})

        encoded_var = self.composer.encode_pattern(var)
        encoded_new_var = self.composer.encode_pattern(new_var)
        assert isinstance(encoded_var, mm.Metavariable) and \
               isinstance(encoded_new_var, mm.Metavariable)

        premise, _ = MetamathUtils.destruct_imp(self.composer.encode_pattern(claim.claim))
        premise = premise.substitute({encoded_var.name: encoded_new_var})

        _, encoded_new_claim_body = MetamathUtils.destruct_imp(self.composer.encode_pattern(new_claim))
        encoded_new_claim = MetamathUtils.construct_imp(premise, encoded_new_claim_body)

        proof = self.composer.get_theorem("fv-subst-left").apply(
            claim.proof,
            SubstitutionProver.auto,
            FreshProver.auto,
            x=encoded_var,
            y=encoded_new_var,
            ph1=encoded_new_claim,
        )

        return self.composer.construct_provable_claim(
            new_claim,
            proof,
            sort_variables=list(KoreUtils.get_free_sort_variables(claim.claim)),
        )

    def apply_functional_substitution_as_implication_raw(
        self,
        pattern: kore.Pattern,
        substitute: kore.Pattern,
        functional_proof: Proof,
    ) -> ProvableClaim:
        """
        Similar to apply_functional_substitution_raw but uses
        a different implication form and only works for patterns
        """

        var, body = KoreUtils.destruct_forall(pattern)

        assert var not in KoreUtils.get_free_variables(substitute), \
               f"variable {var} is free in substitute {substitute}"

        substituted_body = KoreUtils.copy_and_substitute_pattern(body, {var: substitute})

        goal = self.composer.construct_claim(
            KoreUtils.construct_implies(pattern, substituted_body),
            sort_variables=list(KoreUtils.get_free_sort_variables(pattern)),
        )

        # th0
        common_premise = MetamathUtils.construct_and(
            KoreEncoder().encode_free_variable_premise(substitute),
            KoreEncoder().encode_free_variable_premise(substituted_body),
        )

        # get the encoded goal WITHOUT the sorting premises
        _, encoded_goal_body = MetamathUtils.destruct_imp(self.composer.encode_pattern(goal))

        encoded_goal = MetamathUtils.construct_provable(
            MetamathUtils.construct_imp(common_premise, encoded_goal_body),
        )

        functional_proof = SortingProver.rearrange_premise(self.composer, common_premise, functional_proof)

        functional_proof_body = MetamathUtils.destruct_provable(functional_proof.conclusion)
        if MetamathUtils.is_imp(functional_proof_body):
            _, functional_proof_body = MetamathUtils.destruct_imp(functional_proof_body)

        # get the kore level variable name to avoid conflict
        functional_quant_var, _ = MetamathUtils.destruct_exists(functional_proof_body)
        decoded_var = KoreDecoder(self.composer.module).decode_pattern(functional_quant_var, sort=var.sort)
        assert isinstance(decoded_var, kore.Variable)
        functional_var_name = decoded_var.name

        free_vars = {var.name for var in PatternVariableVisitor().visit(goal)}
        free_vars = free_vars.union({var.name for var in SortVariableVisitor().visit(goal)})
        free_vars.add(functional_var_name)
        fresh_var_name, = self.composer.gen_fresh_metavariables("#ElementVariable", 1, free_vars)

        # z in the theorem
        fresh_pattern_var = kore.Variable(fresh_var_name, var.sort)
        dummy_claim = KoreUtils.copy_and_substitute_pattern(body, {var: fresh_pattern_var}, self.composer.module)
        encoded_fresh_var = self.composer.encode_pattern(fresh_pattern_var)

        proof = self.composer.get_theorem("functional-substitution-alt4").match_and_apply(
            mm.StructuredStatement("", encoded_goal),
            PredicateProver.auto,
            functional_proof,
            SortingProver.auto,
            SortingProver.auto,
            SubstitutionProver.auto,
            SubstitutionProver.auto,
            z=encoded_fresh_var,
            ph3=self.composer.encode_pattern(dummy_claim),
        )

        return self.composer.construct_provable_claim(goal, proof)

    def apply_functional_substitution_raw(
        self,
        original_claim: ProvableClaim,
        var: Union[kore.Variable, kore.SortVariable],
        substitute: Union[kore.Pattern, kore.Sort],
        functional_proof: Proof,
    ) -> ProvableClaim:
        r"""
        Apply functional substitution (functional-substitution-alt)
        original_proof and functional_proof are automatically arranged
        to have the expected premise
        """

        if isinstance(var, kore.Variable):
            assert isinstance(substitute, kore.Pattern)
            substituted_claim = KoreUtils.copy_and_substitute_pattern(
                original_claim.claim, {var: substitute}, self.composer.module
            )
        else:
            assert isinstance(substitute, kore.SortVariable) or isinstance(substitute, kore.SortInstance)
            substituted_claim = KoreUtils.copy_and_substitute_sort(
                original_claim.claim, {var: substitute}, self.composer.module
            )

        # look up proof cache
        cached_proof = self.composer.lookup_proof_cache(
            "functional-substitution",
            self.composer.encode_metamath_statement(substituted_claim),
        )
        if cached_proof is not None:
            return ProvableClaim(substituted_claim, cached_proof)

        encoded_var = self.composer.encode_pattern(var)
        encoded_substitute = self.composer.encode_pattern(substitute)
        assert isinstance(encoded_var, mm.Metavariable)

        # destruct conclusions to get information
        original_body = MetamathUtils.destruct_provable(original_claim.proof.conclusion)
        original_premise: Optional[mm.Term] = None

        if MetamathUtils.is_imp(original_body):
            original_premise, original_body = MetamathUtils.destruct_imp(original_body)

        functional_proof_body = MetamathUtils.destruct_provable(functional_proof.conclusion)

        if MetamathUtils.is_imp(functional_proof_body):
            functional_proof_premise, functional_proof_body = MetamathUtils.destruct_imp(functional_proof_body)
        else:
            functional_proof_premise = MetamathUtils.construct_top()

        # get the kore level variable name to avoid conflict
        functional_quant_var, _ = MetamathUtils.destruct_exists(functional_proof_body)
        if isinstance(var, kore.Variable):
            decoded_var = KoreDecoder(self.composer.module).decode_pattern(functional_quant_var, sort=var.sort)
            assert isinstance(decoded_var, kore.Variable)
            functional_var_name = decoded_var.name
        else:
            functional_var_name = functional_quant_var.name

        # one set of premises are to be substituted
        # and the other is untouched
        affected_premises = []
        other_premises = []

        if original_premise is not None:
            for premise in MetamathUtils.destruct_nested_and(original_premise):
                if MetamathUtils.is_top(premise) or premise in affected_premises or premise in other_premises:
                    continue

                # TODO: this is assuming no quantifiers in the premise
                if encoded_var.name in premise.get_metavariables():
                    affected_premises.append(premise)
                else:
                    other_premises.append(premise)

        # th0 in the theorem
        common_premise = MetamathUtils.construct_multi_and(other_premises)
        if not MetamathUtils.is_top(functional_proof_premise):
            common_premise = MetamathUtils.construct_and(
                functional_proof_premise,
                common_premise,
            )

        # th1 in the theorem
        affected_premise = MetamathUtils.construct_multi_and(affected_premises)

        fresh_var_name, = self.composer.gen_fresh_metavariables("#ElementVariable", 1, {var.name, functional_var_name})

        # z in the theorem
        if isinstance(var, kore.Variable):
            fresh_pattern_var = kore.Variable(fresh_var_name, var.sort)
            dummy_claim = KoreUtils.copy_and_substitute_pattern(
                original_claim.claim, {var: fresh_pattern_var}, self.composer.module
            )
            encoded_fresh_var = self.composer.encode_pattern(fresh_pattern_var)
        else:
            fresh_sort_var = kore.SortVariable(fresh_var_name)
            dummy_claim = KoreUtils.copy_and_substitute_sort(
                original_claim.claim, {var: fresh_sort_var}, self.composer.module
            )
            encoded_fresh_var = self.composer.encode_pattern(fresh_sort_var)

        # ph2 in the theorem
        _, substituted_body = MetamathUtils.destruct_imp(self.composer.encode_pattern(substituted_claim))

        # th2 in the theorem
        substituted_premise = affected_premise.substitute({encoded_var.name: encoded_substitute})

        # ph3
        _, dummy_claim_body = MetamathUtils.destruct_imp(self.composer.encode_pattern(dummy_claim))

        # th3
        dummy_premise = affected_premise.substitute({encoded_var.name: encoded_fresh_var})

        # functional-substitution-alt.0
        rearranged_functional_proof = SortingProver.rearrange_premise(self.composer, common_premise, functional_proof)

        # functional-substitution-alt.1
        rearranged_original_proof = SortingProver.rearrange_premise(
            self.composer,
            MetamathUtils.construct_and(common_premise, affected_premise),
            original_claim.proof,
        )

        proof = self.composer.get_theorem("functional-substitution-alt").apply(
            rearranged_functional_proof,
            rearranged_original_proof,
            SubstitutionProver.auto,
            SubstitutionProver.auto,
            y=encoded_var,
            z=encoded_fresh_var,
            ph2=substituted_body,
            th2=substituted_premise,
            ph3=dummy_claim_body,
            th3=dummy_premise,
        )

        return self.composer.construct_provable_claim(substituted_claim, proof, cache_key="functional-substitution")
