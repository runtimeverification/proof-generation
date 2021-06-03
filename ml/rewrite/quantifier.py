from typing import List, Tuple, Mapping, Dict

from ml.kore import ast as kore
from ml.kore.utils import KoreUtils

from ml.metamath import ast as mm
from ml.metamath.composer import Proof
from ml.metamath.auto.sorting import SortingProver
from ml.metamath.auto.hypothesis import HypothesisProver

from .env import ProofGenerator, ProvableClaim
from .substitution import SingleSubstitutionProofGenerator
from .encoder import KoreEncoder
from .equality import EqualityProofGenerator


class QuantifierProofGenerator(ProofGenerator):
    def prove_functional_pattern_substitution(
        self, provable: ProvableClaim, substitution: Dict[kore.Variable, kore.Pattern]
    ) -> ProvableClaim:
        """
        Substitute a free pattern variable in the given claim with
        a functional pattern and return a new provable claim
        """
        # TODO: prove this
        substituted_claim = KoreUtils.copy_and_substitute_pattern(provable.claim, substitution, self.composer.module)
        return self.composer.load_claim_without_proof(
            self.composer.get_fresh_label("functional-substitution"), substituted_claim
        )

    def prove_sort_substitution(
        self, provable: ProvableClaim, substitution: Dict[kore.SortVariable, kore.Sort]
    ) -> ProvableClaim:
        """
        Substitute a free sort variable in the given claim with
        a sort and return a new provable claim
        """
        # TODO: prove this
        substituted_claim = KoreUtils.copy_and_substitute_sort(provable.claim, substitution, self.composer.module)
        return self.composer.load_claim_without_proof(
            self.composer.get_fresh_label("functional-substitution"), substituted_claim
        )

    # def prove_functional(self, pattern: kore.Pattern) -> ProvableClaim:
    #     ...

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
            self.composer.sort_injection_axiom, {
                sort_var1: sort1,
                sort_var2: sort2,
                sort_var3: sort3,
            }
        )
