from typing import Mapping, Set, List, Tuple, Optional

from ml.kore import ast as kore
from ml.kore.utils import KoreUtils

from ml.metamath.composer import Theorem, Proof

from .env import ProofGenerator, ProvableClaim
from .encoder import KorePatternEncoder
from .substitution import SingleSubstitutionProofGenerator


class SortProofGenerator(ProofGenerator):
    """
    Return a provable claim of the form
    `forall x. inj{sort2, sort3}(inj{sort1, sort2}(x)) = inj{sort1, sort3}(x)`
    """
    def get_inj_instance(
        self,
        sort1: kore.Sort,
        sort2: kore.Sort,
        sort3: kore.Sort,
    ) -> ProvableClaim:
        # NOTE: this depends on the order in which the parametric sort variables
        # are generated

        assert isinstance(sort1, kore.SortInstance) and len(sort1.arguments) == 0 and \
               isinstance(sort2, kore.SortInstance) and len(sort2.arguments) == 0 and \
               isinstance(sort3, kore.SortInstance) and len(sort3.arguments) == 0, \
               "parametric sort not supported"

        sort_var1, sort_var2, sort_var3, _ = self.env.sort_injection_axiom.claim.sort_variables

        encoded_sort1 = KorePatternEncoder.encode_sort(sort1)
        encoded_sort2 = KorePatternEncoder.encode_sort(sort2)
        encoded_sort3 = KorePatternEncoder.encode_sort(sort3)

        sort1_is_sort = self.env.sort_axioms[encoded_sort1].as_proof()
        sort2_is_sort = self.env.sort_axioms[encoded_sort2].as_proof()
        sort3_is_sort = self.env.sort_axioms[encoded_sort3].as_proof()

        copied_injection_axiom = KoreUtils.copy_ast(self.env.module, self.env.sort_injection_axiom.claim)
        copied_injection_axiom.sort_variables = copied_injection_axiom.sort_variables[1:]
        subst_proof1, substituted1 = \
            SingleSubstitutionProofGenerator(self.env, sort_var1, sort1).visit_and_substitute(copied_injection_axiom)

        substituted1.sort_variables = substituted1.sort_variables[1:]
        subst_proof2, substituted2 = \
            SingleSubstitutionProofGenerator(self.env, sort_var2, sort2).visit_and_substitute(substituted1)

        substituted2.sort_variables = substituted2.sort_variables[1:]
        subst_proof3, substituted3 = \
            SingleSubstitutionProofGenerator(self.env, sort_var3, sort3).visit_and_substitute(substituted2)

        proof1 = self.env.get_theorem("kore-forall-sort-elim").apply(
            self.env.sort_injection_axiom.proof,
            sort1_is_sort,
            subst_proof1,
        )

        proof2 = self.env.get_theorem("kore-forall-sort-elim").apply(
            proof1,
            sort2_is_sort,
            subst_proof2,
        )

        proof3 = self.env.get_theorem("kore-forall-sort-elim").apply(
            proof2,
            sort3_is_sort,
            subst_proof3,
        )

        return ProvableClaim(substituted3, proof3)
