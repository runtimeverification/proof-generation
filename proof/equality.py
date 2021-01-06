from typing import Tuple, Union

from .kore import ast as kore
from .kore.visitors import PatternVariableVisitor
from .kore.utils import KoreUtils, PatternPath

from .metamath import ast as mm
from .metamath.composer import Proof
from .metamath.auto.sorting import SortingProver

from .encoder import KorePatternEncoder

from .env import ProofGenerator, ProvableClaim
from .substitution import SingleSubstitutionProofGenerator


"""
Generate proofs for equality related statements
"""
class EqualityProofGenerator(ProofGenerator):
    """
    Prove that validity of a pattern of axiom is preserved
    after substituting a subpattern using equality

    Given the following data:
    - a provable claim (a kore claim and a proof of its encoding)
    - a path pointing to a subpattern psi of phi
    - an unconditional equation in the form
        forall sort R. equals { S, R } ( psi, psi' )

    Returns phi with psi replaced by psi',
    and a proof for it using (primarily) `kore-equality`
    """
    def prove_validity(
        self,
        provable: ProvableClaim,
        path: PatternPath,
        replacement: kore.Pattern,
        equation_proof: Proof,
    ) -> ProvableClaim:
        original = KoreUtils.get_subpattern_by_path(provable.claim, path)

        # TODO: we are generating a mm fresh variable for a kore variable
        # this might cause some problems in the future
        all_metavars = { KorePatternEncoder.encode_variable(var) for var in PatternVariableVisitor().visit(provable.claim) }
        fresh_var, = self.env.gen_fresh_metavariables("#ElementVariable", 1, all_metavars)

        sort = KoreUtils.infer_sort(original)
        assert sort == KoreUtils.infer_sort(replacement)

        var = kore.Variable(fresh_var, sort)
        template_pattern = KoreUtils.copy_and_replace_path_by_pattern(provable.claim, path, var)
        final_axiom = KoreUtils.copy_and_replace_path_by_pattern(provable.claim, path, replacement)

        subst_proof1 = SingleSubstitutionProofGenerator(self.env, var, original).visit(template_pattern)
        subst_proof2 = SingleSubstitutionProofGenerator(self.env, var, replacement).visit(template_pattern)

        final_proof = self.env.get_theorem("kore-equality").apply(
            equation_proof,
            provable.proof,
            subst_proof1,
            subst_proof2,
            SortingProver.auto,
            SortingProver.auto,
            SortingProver.auto,
        )

        return ProvableClaim(final_axiom, final_proof)

    """
    Same as above but using a provable claim,
    so that we can extract the replacement automatically
    """
    def prove_validity_with_equation(
        self,
        provable: ProvableClaim,
        path: PatternPath,
        equation: ProvableClaim,
    ) -> ProvableClaim:
        assert isinstance(equation.claim.pattern, kore.MLPattern) and \
               equation.claim.pattern.construct == kore.MLPattern.EQUALS
        rhs = equation.claim.pattern.arguments[1]
        return self.prove_validity(provable, path, rhs, equation.proof)
