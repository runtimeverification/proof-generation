from typing import List, Tuple, Mapping, Dict

from ml.kore import ast as kore
from ml.kore.utils import KoreUtils

from ml.metamath import ast as mm
from ml.metamath.ast import Proof
from ml.metamath.auto.sorting import SortingProver

from .env import ProofGenerator, ProvableClaim
from .substitution import SingleSubstitutionProofGenerator
from .sort import SortProofGenerator
from .encoder import KorePatternEncoder
from .equality import EqualityProofGenerator


class QuantifierProofGenerator(ProofGenerator):
    def prove_forall_elim_single(self, provable: ProvableClaim, pattern: kore.Pattern) -> ProvableClaim:
        """
        A wrapper to eliminate the top level forall
        """
        assert (
            isinstance(provable.claim.pattern, kore.MLPattern)
            and provable.claim.pattern.construct == kore.MLPattern.FORALL
        )
        binding_var = provable.claim.pattern.get_binding_variable()
        assert binding_var is not None
        return self.prove_forall_elim(provable, {binding_var: pattern})

    def prove_forall_elim(
        self,
        provable: ProvableClaim,
        substitution: Mapping[kore.Variable, kore.Pattern],
    ) -> ProvableClaim:
        r"""
        Given a provable claim of the form
        claim{...} \forall x1. ... \forall xn. phi(x1, ..., xn)

        and a substitution on { x1, ..., xn }
        
        eliminate first n forall's by proving the functional property
        of the patterns in the substitution and using kore-forall-elim

        Currently we only support claims with 0 or 1 sort variables
        """
        thm_map = {
            0: "kore-forall-elim",
            1: "kore-forall-elim-v1",
        }

        num_sort_vars = len(provable.claim.sort_variables)

        if num_sort_vars in thm_map:
            thm = thm_map[num_sort_vars]
        else:
            raise Exception(f"forall elimination for axiom with {num_sort_vars} variable(s) is not supported")

        eliminated = 0

        # first compute intermediate sstatements after eliminating each quantifier
        # lits of (body after substitution, body before substitution, substitution pattern, substitution variable)
        # (all in kore ast)
        intermediate_instances = []

        claim_pattern = provable.claim.pattern

        while (isinstance(claim_pattern, kore.MLPattern) and claim_pattern.construct == kore.MLPattern.FORALL
               and eliminated < len(substitution)):
            var = claim_pattern.get_binding_variable()
            body = claim_pattern.arguments[1]

            assert var is not None
            assert (var in substitution), f"variable {var} not found in substitution {substitution}"

            pattern = substitution[var]
            substituted_body = KoreUtils.copy_and_substitute_pattern(body, {var: pattern})
            substituted_body.resolve(self.env.module)

            intermediate_instances.append((substituted_body, body, pattern, var))

            claim_pattern = substituted_body
            eliminated += 1

        final_claim = kore.Claim(provable.claim.sort_variables, claim_pattern)
        final_claim.resolve(self.env.module)

        # test if the final claim has already been proved
        final_mm_statement = self.env.encode_metamath_statement(final_claim)
        cached_proof = self.env.composer.lookup_proof_cache("quant-forall-elim-cache", final_mm_statement)
        if cached_proof is not None:
            return ProvableClaim(final_claim, cached_proof)

        current_proof = provable.proof

        # apply forall elimination repeatedly
        for substituted_body, body, pattern, var in intermediate_instances:
            # prove that the term is interpreted to a singleton in some domain
            pattern_is_functional = FunctionalProofGenerator(self.env).visit(pattern)

            # prove the substitution
            subst_proof = SingleSubstitutionProofGenerator(self.env, var, pattern).prove_substitution(body)

            current_proof = self.env.get_theorem(thm).apply(
                current_proof,
                pattern_is_functional.proof,
                subst_proof,
                SortingProver.auto,
                SortingProver.auto,
            )

            current_proof = self.env.cache_proof("quant-forall-elim-cache", current_proof)

        return ProvableClaim(final_claim, current_proof)


class FunctionalProofGenerator(ProofGenerator, kore.KoreVisitor[kore.Pattern, ProvableClaim]):
    r"""
    Given a pattern phi, generate a proof for the statement in the form

    |- ( \kore-forall \sort R ( \kore-exists Sort1 x ( \kore-equals Sort1 R x phi ) ) )

    that is, phi is a functional pattern that has a unique singleton interpretation in the domain of Sort1

    Almost all patterns used in the execution should have such property

    NOTE: only supports concrete patterns right now
    """
    def prove_non_immediate_injection(self, application: kore.Application) -> ProvableClaim:
        """
        Specical case: when A is not an immediate subsort of B,
        we don't have the functional axiom of inj{A, B},
        in which case we need to stitch the chain of subsorting
        A < A1 < ... < B together to get a functional pattern
        and then use the inj axiom to reduce that back to
        a single injection.
        """
        assert application.symbol.definition == self.env.sort_injection_symbol

        sort1, sort2 = application.symbol.sort_arguments
        assert isinstance(sort1, kore.SortInstance) and isinstance(sort2, kore.SortInstance)

        chain = self.env.subsort_relation.get_subsort_chain(sort1, sort2)
        assert (chain is not None), f"{sort1} is not a subsort of {sort2}, unable to prove that it's functional"
        assert len(chain) > 2, f"{sort1} is an immediate subsort of {sort2}"

        argument = application.arguments[0]

        # suppose the chain is S1 < S2 < ... < Sn
        # first recursively prove the functionality of
        # inj{Sn-1, Sn}(inj{S1, Sn-1}(<argument>))
        reduced_injection = kore.Application(
            kore.SymbolInstance(self.env.sort_injection_symbol, [sort1, chain[-2]]),
            [argument],
        )
        reduced_injection = kore.Application(
            kore.SymbolInstance(self.env.sort_injection_symbol, [chain[-2], chain[-1]]),
            [reduced_injection],
        )
        reduced_injection.resolve(self.env.module)
        reduced_injection_is_functional = self.visit(reduced_injection)

        # get an instance of the injection axiom
        # with sort variables replaced by S1, Sn-1, and Sn
        inj_axiom_instance = SortProofGenerator(self.env).get_inj_instance(sort1, chain[-2], chain[-1])

        # inj_axiom_instance is of the form
        # \forall{...}(X:<sort1>, ... = ...)
        # we need to substitute current_argument for X in the equation
        inj_axiom_instance = QuantifierProofGenerator(self.env).prove_forall_elim_single(inj_axiom_instance, argument)

        return EqualityProofGenerator(self.env).replace_equal_subpattern(
            reduced_injection_is_functional,
            [
                0,
                1,
                1,
            ],  # this is the path of the LHS of the equation in reduced_injection_axiom
            application,
            inj_axiom_instance.proof,
        )

    def get_substitution(self, axiom: kore.Axiom,
                         application: kore.Application) -> Mapping[kore.Variable, kore.Pattern]:
        """
        Given a functional axiom sigma and an application phi,
        sigma should be in the form,
        ( forall Sort_1 V_1 ... ( forall Sort_n V_n ( exists Sort_0 W ( equals Sort_0 R W <RHS> ) ) ) )
        
        Return the substitution that should be applied to the equation
        """

        existential = KoreUtils.strip_forall(axiom.pattern)
        assert (isinstance(existential, kore.MLPattern) and existential.construct == kore.MLPattern.EXISTS)

        equality = existential.arguments[1]
        assert (isinstance(equality, kore.MLPattern) and equality.construct == kore.MLPattern.EQUALS)

        rhs = equality.arguments[1]
        assert isinstance(rhs, kore.Application)
        assert len(rhs.arguments) == len(application.arguments)

        subst: Dict[kore.Variable, kore.Pattern] = {}

        for arg, app_arg in zip(rhs.arguments, application.arguments):
            assert isinstance(arg, kore.Variable)
            subst[arg] = app_arg

        return subst

    def postvisit_application(self, application: kore.Application) -> ProvableClaim:
        if application.symbol not in self.env.functional_axioms:
            if application.symbol.definition == self.env.sort_injection_symbol:
                return self.prove_non_immediate_injection(application)
            else:
                assert (False), "cannot find a functional axiom for symbol instance {}".format(application.symbol)

        functional_property = self.env.functional_axioms[application.symbol]
        substitution = self.get_substitution(functional_property.claim, application)

        return QuantifierProofGenerator(self.env).prove_forall_elim(functional_property, substitution)

    def postvisit_ml_pattern(self, ml_pattern: kore.MLPattern) -> ProvableClaim:
        assert (ml_pattern.construct == kore.MLPattern.DV
                ), "unnable to prove functional property for {}".format(ml_pattern)

        sort, literal = ml_pattern.sorts[0], ml_pattern.arguments[0]

        assert isinstance(sort, kore.SortInstance) and isinstance(literal, kore.StringLiteral)
        assert (
            sort,
            literal,
        ) in self.env.domain_value_functional_axioms, (
            "cannot find functional axiom for domain value {}".format(ml_pattern)
        )

        return self.env.domain_value_functional_axioms[sort, literal]
