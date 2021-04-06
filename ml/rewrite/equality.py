from typing import Tuple, Union

from ml.kore import ast as kore
from ml.kore.visitors import PatternVariableVisitor, SortVariableVisitor
from ml.kore.utils import KoreUtils, PatternPath

from ml.metamath import ast as mm
from ml.metamath.composer import Proof
from ml.metamath.visitors import SubstitutionVisitor
from ml.metamath.auto.sorting import SortingProver
from ml.metamath.auto.substitution import SubstitutionProver

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

    def replace_equal_subpattern(
        self,
        provable: ProvableClaim,
        path: PatternPath,
        replacement: kore.Pattern,
        equation_proof: Proof,
    ) -> ProvableClaim:
        final_claim = KoreUtils.copy_and_replace_path_by_pattern(
            provable.claim, path, replacement
        )

        # check for proof cache
        cached_proof = self.env.composer.lookup_proof_cache(
            "equality-cache", self.env.encode_axiom(mm.Statement.PROVABLE, final_claim)
        )
        if cached_proof is not None:
            return ProvableClaim(final_claim, cached_proof)

        original = KoreUtils.get_subpattern_by_path(provable.claim, path)

        # TODO: we are generating a mm fresh variable for a kore variable
        # this might cause some problems in the future
        all_metavars = {
            KorePatternEncoder.encode_variable(var)
            for var in PatternVariableVisitor().visit(provable.claim)
        }
        (fresh_var,) = self.env.gen_fresh_metavariables(
            "#ElementVariable", 1, all_metavars
        )

        sort = KoreUtils.infer_sort(original)
        assert sort == KoreUtils.infer_sort(replacement)

        # make a template/context for the replacement
        var = kore.Variable(fresh_var, sort)
        var.resolve(self.env.module)
        template_pattern = KoreUtils.copy_and_replace_path_by_pattern(
            provable.claim, path, var
        )

        subst_proof1 = SingleSubstitutionProofGenerator(
            self.env, var, original
        ).prove_substitution(template_pattern)
        subst_proof2 = SingleSubstitutionProofGenerator(
            self.env, var, replacement
        ).prove_substitution(template_pattern)

        # kore-equality requires that the sort variable in the equation
        # should be disjoint from the main statement being substituted
        # (due to meta-incompleteness and other issues)
        # so we need to do an alpha renaming on the sort variable
        all_sort_metavars = {
            KorePatternEncoder.encode_sort_variable(var)
            for var in SortVariableVisitor().visit(provable.claim)
        }
        # equation_proof is expected to be of the form
        # |- ( \kore-forall-sort z ... )
        current_sort_var = equation_proof.statement.terms[1].subterms[0].name

        if current_sort_var in all_sort_metavars:
            (fresh_sort_var,) = self.env.gen_fresh_metavariables(
                "#ElementVariable",
                1,
                all_sort_metavars.union(all_metavars).union({fresh_var}),
            )

            equation_body = equation_proof.statement.terms[1].subterms[1]
            equation_body_subst = SubstitutionVisitor(
                {current_sort_var: mm.Metavariable(fresh_sort_var)}
            ).visit(equation_body)

            # apply alpha renaming
            equation_proof = self.env.get_theorem("alpha-kore-forall-sort-alt").apply(
                SubstitutionProver.auto,
                equation_proof,
                y=mm.Metavariable(fresh_sort_var),
                ph1=equation_body_subst,
            )

        final_proof = self.env.get_theorem("kore-equality").apply(
            equation_proof,
            provable.proof,
            subst_proof1,
            subst_proof2,
            SortingProver.auto,
            SortingProver.auto,
            SortingProver.auto,
        )

        final_proof = self.env.cache_proof("equality-cache", final_proof)

        return ProvableClaim(final_claim, final_proof)

    """
    Same as above but using a provable claim,
    so that we can extract the replacement automatically
    """

    def replace_equal_subpattern_with_equation(
        self,
        provable: ProvableClaim,
        path: PatternPath,
        equation: ProvableClaim,
    ) -> ProvableClaim:
        assert (
            isinstance(equation.claim.pattern, kore.MLPattern)
            and equation.claim.pattern.construct == kore.MLPattern.EQUALS
        )
        rhs = equation.claim.pattern.arguments[1]
        return self.replace_equal_subpattern(provable, path, rhs, equation.proof)
