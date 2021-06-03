from typing import List, Union, Tuple, TypeVar, Any

from ml.kore import ast as kore
from ml.kore.utils import KoreUtils

from ml.metamath import ast as mm
from ml.metamath.composer import Theorem, Proof
from ml.metamath.auto.substitution import SubstitutionProver
from ml.metamath.utils import MetamathUtils

from .encoder import KoreEncoder

from .env import KoreComposer, ProofGenerator

PAS = TypeVar("PAS", kore.Pattern, kore.Axiom, kore.Sort)


class SingleSubstitutionProofGenerator(ProofGenerator):
    """
    Given a kore pattern phi, pattern psi, and variable x, generate a proof for

    #Substitution phi[psi/x] phi psi x

    where phi[psi/x] is the actual pattern with x substituted with phi,
    with the assumption that distinct meta #Variable varible are disjoint

    This also support substituting sort variables
    """
    def __init__(
        self,
        composer: KoreComposer,
        var: Union[kore.Variable, kore.SortVariable],
        substitute: Union[kore.Pattern, kore.Sort],
    ):
        super().__init__(composer)

        if isinstance(var, kore.Variable):
            assert isinstance(substitute, kore.Pattern)
        else:
            assert isinstance(substitute, kore.SortVariable) or isinstance(substitute, kore.SortInstance)

        self.var = var
        self.substitute = substitute

        self.var_encoded = self.composer.encode_pattern(var)
        self.substitute_encoded = self.composer.encode_pattern(substitute)

    def prove_substitution(self, original: PAS) -> Proof:
        return self.prove_substitution_with_result(original)[0]

    def prove_substitution_with_result(self, original: PAS) -> Tuple[Proof, PAS]:
        if isinstance(self.var, kore.Variable):
            assert isinstance(self.substitute, kore.Pattern)
            substituted = KoreUtils.copy_and_substitute_pattern(original, {self.var: self.substitute})
        else:
            assert isinstance(self.substitute, kore.SortVariable) or isinstance(self.substitute, kore.SortInstance)
            substituted = KoreUtils.copy_and_substitute_sort(original, {self.var: self.substitute})

        # we want to substitute the premise and claim separately
        # since once the free variable is substituted, the sorting
        # premises may decrease.
        # TODO: a bit hacky here. we may want to implement a metamath
        # level substitution

        if isinstance(original, kore.Axiom):
            encoded_original = self.composer.encode_pattern(original)
            encoded_substituted = self.composer.encode_pattern(substituted)

            original_premises, original_claim = MetamathUtils.destruct_imp(encoded_original)
            _, substituted_claim = MetamathUtils.destruct_imp(encoded_substituted)

            # manually substituting the metamath level premises
            assert isinstance(self.var_encoded, mm.Metavariable)
            substituted_premises = original_premises.substitute({self.var_encoded.name: self.substitute_encoded})

            # TODO: check that original_premises does not have any quantifier

            after_substitution = MetamathUtils.construct_imp(substituted_premises, substituted_claim)
            before_substitution = MetamathUtils.construct_imp(original_premises, original_claim)
        else:
            after_substitution = self.composer.encode_pattern(substituted)
            before_substitution = self.composer.encode_pattern(original)

        goal = mm.StructuredStatement(
            "",
            MetamathUtils.construct_substitution(
                after_substitution,
                before_substitution,
                self.substitute_encoded,
                self.var_encoded,
            )
        )

        proof = SubstitutionProver.prove_substitution_statement(self.composer, goal)
        proof = self.composer.cache_proof("substitution-cache", proof)

        return proof, substituted
