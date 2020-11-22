from typing import Tuple, Union

from .kore import ast as kore
from .kore.visitors import PatternVariableVisitor
from .kore.utils import KoreUtils, PatternPath

from .metamath import ast as mm
from .metamath.composer import Proof

from .encoder import KorePatternEncoder

from .env import ProofGenerator
from .substitution import SingleSubstitutionProofGenerator


"""
Generate proofs for equality related statements
"""
class EqualityProofGenerator(ProofGenerator):
    """
    Prove that validity of a pattern of axiom is preserved
    after substituting a subpattern using equality

    Given the following data:
    - a pattern phi (and a proof for it)
    - a path pointing to a subpattern psi of phi
    - an unconditional equation in the form
        forall sort R. equals { S, R } ( psi, psi' )

    Returns phi with psi replaced by psi',
    and a proof for it using (primarily) `kore-equality`
    """
    def prove_validity(
        self,
        pattern_or_axiom: Union[kore.Pattern, kore.Axiom],
        pattern_or_axiom_proof: Proof,
        path: PatternPath, 
        replacement: kore.Pattern,
        equation_proof: Proof,
    ) -> Tuple[Union[kore.Pattern, kore.Axiom], Proof]:
        assert len(path)
        original = KoreUtils.get_subpattern_by_path(pattern_or_axiom, path)

        # TODO: we are generating a mm fresh variable for a kore variable
        # this might cause some problems in the future
        all_metavars = { KorePatternEncoder.encode_variable(var) for var in PatternVariableVisitor().visit(pattern_or_axiom) }
        fresh_var, = self.env.gen_fresh_metavariables("#ElementVariable", 1, all_metavars)

        sort = KoreUtils.get_sort(self.env.module, original)
        assert sort == KoreUtils.get_sort(self.env.module, replacement)

        var = kore.Variable(fresh_var, sort)
        template_pattern = KoreUtils.copy_and_replace_path_by_pattern(self.env.module, pattern_or_axiom, path, var)
        final_pattern_or_axiom = KoreUtils.copy_and_replace_path_by_pattern(self.env.module, pattern_or_axiom, path, replacement)

        subst_proof1 = SingleSubstitutionProofGenerator(self.env, var, original).visit(template_pattern)
        subst_proof2 = SingleSubstitutionProofGenerator(self.env, var, replacement).visit(template_pattern)

        final_proof = self.env.get_theorem("kore-equality").apply(
            equation_proof,
            pattern_or_axiom_proof,
            subst_proof1,
            subst_proof2,
        )

        return final_pattern_or_axiom, final_proof
