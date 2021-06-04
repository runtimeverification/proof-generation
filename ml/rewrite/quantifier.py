from typing import List, Tuple, Mapping, Dict, Optional, Union

from ml.kore import ast as kore
from ml.kore.utils import KoreUtils

from ml.metamath import ast as mm
from ml.metamath.composer import Proof
from ml.metamath.utils import MetamathUtils
from ml.metamath.auto.sorting import SortingProver
from ml.metamath.auto.hypothesis import HypothesisProver
from ml.metamath.auto.substitution import SubstitutionProver

from .env import ProofGenerator, ProvableClaim
from .substitution import SingleSubstitutionProofGenerator
from .encoder import KoreEncoder, KoreDecoder
from .equality import EqualityProofGenerator


class QuantifierProofGenerator(ProofGenerator):
    def prove_functional_pattern_substitution(
        self, provable: ProvableClaim, substitution: Dict[kore.Variable, kore.Pattern]
    ) -> ProvableClaim:
        """
        Substitute a free pattern variable in the given claim with
        a functional pattern and return a new provable claim
        """

        for k, v in sorted(substitution.items(), key=lambda t: t[0].name):
            functional_claim = self.prove_functional(v)
            provable = self.apply_functional_substitution(
                provable,
                k,
                v,
                self.composer.get_theorem("kore-functional").apply(
                    SortingProver.auto,
                    self.instantiate_claim_with_unit_sort(functional_claim).proof,
                ),
            )

        return provable

    def prove_sort_substitution(
        self, provable: ProvableClaim, substitution: Dict[kore.SortVariable, kore.Sort]
    ) -> ProvableClaim:
        """
        Substitute a free sort variable in the given claim with
        a sort and return a new provable claim
        """
        # TODO: prove this
        substituted_claim = KoreUtils.copy_and_substitute_sort(provable.claim, substitution, self.composer.module)
        return self.composer.load_fresh_claim_placeholder("functional-substitution", substituted_claim)

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
        reduced_injection_is_functional = self.prove_functional(reduced_injection)

        # get an instance of the injection axiom
        # with sort variables replaced by S1, Sn-1, and Sn
        inj_axiom_instance = self.get_inj_instance(sort1, chain[-2], chain[-1])

        # inj_axiom_instance is of the form
        # \forall{...}(X:<sort1>, ... = ...)
        # we need to substitute current_argument for X in the equation
        free_var, = KoreUtils.get_free_variables(inj_axiom_instance.claim)
        inj_axiom_instance = self.prove_functional_pattern_substitution(inj_axiom_instance, {free_var: argument})

        return EqualityProofGenerator(self.composer).replace_equal_subpattern(
            reduced_injection_is_functional,
            [
                0,
                1,
                1,
            ],  # this is the path of the LHS of the equation in reduced_injection_axiom
            inj_axiom_instance,
        )

    def prove_functional(self, pattern: kore.Pattern) -> ProvableClaim:
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
                argument_is_functional = self.prove_functional(argument)
                functional_axiom = self.apply_functional_substitution(
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
                    s0=self.composer.encode_pattern(sort_var),
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

        return self.prove_sort_substitution(
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

        return self.apply_functional_substitution(claim, sort_var, self.composer.unit_sort, unit_sort_functional)

    def apply_functional_substitution(
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
            "quant-functional-substitution",
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
        rearranged_functional_proof = self.composer.rearrange_sorting_premise(common_premise, functional_proof)

        # functional-substitution-alt.1
        rearranged_original_proof = self.composer.rearrange_sorting_premise(
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

        return self.composer.construct_provable_claim(
            substituted_claim, proof, cache_key="quant-functional-substitution"
        )
