from typing import List, Tuple, Mapping

from .kore import ast as kore
from .kore.utils import KoreUtils
from .kore.visitors import PatternVariableVisitor

from .metamath import ast as mm
from .metamath.composer import Proof
from .metamath.auto.sorting import SortingProver

from .env import ProofGenerator, ProvableClaim
from .substitution import SingleSubstitutionProofGenerator
from .sort import SortProofGenerator
from .encoder import KorePatternEncoder
from .equality import EqualityProofGenerator


class QuantifierProofGenerator(ProofGenerator):
    """
    A wrapper to eliminate the top level forall
    """
    def prove_forall_elim_single(self, provable: ProvableClaim, pattern: kore.Pattern) -> ProvableClaim:
        assert isinstance(provable.claim.pattern, kore.MLPattern) and \
               provable.claim.pattern.construct == kore.MLPattern.FORALL
        return self.prove_forall_elim(provable, { provable.claim.pattern.get_binding_variable(): pattern })

    r"""
    Given a provable claim of the form
    claim{...} \forall x1. ... \forall xn. phi(x1, ..., xn)

    and a substitution on { x1, ..., xn }
    
    eliminate first n forall's by proving the functional property
    of the patterns in the substitution and using kore-forall-elim

    Currently we only support claims with 0 or 1 sort variables
    """
    def prove_forall_elim(self, provable: ProvableClaim, substitution: Mapping[kore.Variable, kore.Pattern]) -> ProvableClaim:
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

        while isinstance(provable.claim.pattern, kore.MLPattern) and \
              provable.claim.pattern.construct == kore.MLPattern.FORALL and \
              eliminated < len(substitution):

            var = provable.claim.pattern.get_binding_variable()
            body = provable.claim.pattern.arguments[1]

            assert var in substitution, f"variable {var} not found in substitution {substitution}"

            pattern = substitution[var]

            # prove that the term is interpreted to a singleton in some domain
            pattern_is_functional = FunctionalProofGenerator(self.env).visit(pattern)

            # prove the substitution
            subst_proof, subst_pattern = \
                SingleSubstitutionProofGenerator(self.env, var, pattern).visit_and_substitute(body)

            new_claim = kore.Claim(provable.claim.sort_variables, subst_pattern, [])
            new_claim.resolve(self.env.module)

            new_proof = self.env.get_theorem(thm).apply(
                provable.proof,
                pattern_is_functional.proof,
                subst_proof,
                SortingProver.auto,
                SortingProver.auto,
            )

            provable = ProvableClaim(new_claim, new_proof)
            eliminated += 1

        return provable


r"""
Given a pattern phi, generate a proof for the statement in the form

|- ( \kore-forall \sort R ( \kore-exists Sort1 x ( \kore-equals Sort1 R x phi ) ) )

that is, phi is a functional pattern that has a unique singleton interpretation in the domain of Sort1

Almost all patterns used in the execution should have such property

NOTE: only supports concrete patterns right now
"""
class FunctionalProofGenerator(ProofGenerator, kore.KoreVisitor):
    """
    Specical case: when A is not an immediate subsort of B,
    we don't have the functional axiom of inj{A, B},
    in which case we need to stitch the chain of subsorting
    A < A1 < ... < B together to get a functional pattern
    and then use the inj axiom to reduce that back to
    a single injection.
    """
    def prove_non_immediate_injection(self, application: kore.Application) -> ProvableClaim:
        assert application.symbol.definition == self.env.sort_injection_symbol

        sort1, sort2 = application.symbol.sort_arguments
        chain = self.env.subsort_relation.get_subsort_chain(sort1, sort2)
        assert chain is not None, f"{sort1} is not a subsort of {sort2}, unable to prove that it's functional"
        assert len(chain) > 2, f"{sort1} is an immediate subsort of {sort2}"

        argument = application.arguments[0]

        # suppose the chain is S1 < S2 < ... < Sn
        # first recursively prove the functionality of
        # inj{Sn-1, Sn}(inj{S1, Sn-1}(<argument>))
        reduced_injection = kore.Application(
            kore.SymbolInstance(self.env.sort_injection_symbol, [ sort1, chain[-2] ]),
            [ argument ],
        )
        reduced_injection = kore.Application(
            kore.SymbolInstance(self.env.sort_injection_symbol, [ chain[-2], chain[-1] ]),
            [ reduced_injection ],
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

        return EqualityProofGenerator(self.env).prove_validity(
            reduced_injection_is_functional,
            [ 0, 1, 1 ], # this is the path of the LHS of the equation in reduced_injection_axiom
            application,
            inj_axiom_instance.proof,
        )

    """
    Given a functional axiom sigma and an application phi,
    sigma should be in the form,
    ( forall Sort_1 V_1 ... ( forall Sort_n V_n ( exists Sort_0 W ( equals Sort_0 R W <RHS> ) ) ) )
    
    Return the substitution that should be applied to the equation
    """
    def get_substitution(self, axiom: kore.Axiom, application: kore.Application) -> Mapping[kore.Variable, kore.Pattern]:
        existential = KoreUtils.strip_forall(axiom.pattern)
        assert isinstance(existential, kore.MLPattern) and \
               existential.construct == kore.MLPattern.EXISTS

        equality = existential.arguments[1]
        assert isinstance(equality, kore.MLPattern) and \
               equality.construct == kore.MLPattern.EQUALS

        rhs = equality.arguments[1]
        assert isinstance(rhs, kore.Application)
        assert len(rhs.arguments) == len(application.arguments)

        for arg in rhs.arguments:
            assert isinstance(arg, kore.Variable)

        return dict(zip(rhs.arguments, application.arguments))

    def postvisit_application(self, application: kore.Application) -> ProvableClaim:
        if application.symbol not in self.env.functional_axioms:
            if application.symbol.definition == self.env.sort_injection_symbol:
                return self.prove_non_immediate_injection(application)
            else:
                assert False, "cannot find a functional axiom for symbol instance {}".format(application.symbol)
        
        functional_property = self.env.functional_axioms[application.symbol]
        substitution = self.get_substitution(functional_property.claim, application)

        return QuantifierProofGenerator(self.env).prove_forall_elim(functional_property, substitution)

    def postvisit_ml_pattern(self, ml_pattern: kore.MLPattern) -> ProvableClaim:
        assert ml_pattern.construct == kore.MLPattern.DV, \
               "unnable to prove functional property for {}".format(ml_pattern)

        sort, literal = ml_pattern.sorts[0], ml_pattern.arguments[0]

        assert (sort, literal) in self.env.domain_value_functional_axioms, \
               "cannot find functional axiom for domain value {}".format(ml_pattern)

        return self.env.domain_value_functional_axioms[sort, literal]
