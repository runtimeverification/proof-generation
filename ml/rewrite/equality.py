from typing import Tuple, Union

from ml.kore import ast as kore
from ml.kore.visitors import PatternVariableVisitor, SortVariableVisitor
from ml.kore.utils import KoreUtils, PatternPath

from ml.metamath import ast as mm
from ml.metamath.composer import Proof
from ml.metamath.auto.sorting import SortingProver
from ml.metamath.auto.substitution import SubstitutionProver

from .encoder import KoreEncoder

from .env import ProofGenerator, ProvableClaim
from .substitution import SingleSubstitutionProofGenerator


class EqualityProofGenerator(ProofGenerator):
    def apply_symmetry(self, equation: ProvableClaim) -> ProvableClaim:
        lhs, rhs = KoreUtils.destruct_equals(equation.claim.pattern)
        output_sort = KoreUtils.infer_sort(equation.claim.pattern)

        new_claim = self.composer.construct_claim(
            KoreUtils.construct_equals(output_sort, rhs, lhs),
            sort_variables=list(equation.claim.sort_variables),
        )

        return self.composer.load_claim_without_proof(self.composer.get_fresh_label("symmetry"), new_claim)

    def replace_equal_subpattern(
        self,
        provable: ProvableClaim,
        path: PatternPath,
        equation: ProvableClaim,
    ) -> ProvableClaim:
        """
        Apply an equation at the given path from lhs to rhs
        """

        # TODO: prove this

        subpattern = KoreUtils.get_subpattern_by_path(provable.claim, path)
        lhs, rhs = KoreUtils.destruct_equals(equation.claim.pattern)

        assert lhs == subpattern, \
               f"cannot apply equation {equation.claim} on {subpattern}"

        new_claim = KoreUtils.copy_and_replace_path_by_pattern_in_axiom(provable.claim, path, rhs)

        return self.composer.load_claim_without_proof(self.composer.get_fresh_label("equality"), new_claim)
