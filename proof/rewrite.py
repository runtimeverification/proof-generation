from typing import Optional, List, Tuple, Mapping

from .kore import ast as kore
from .kore.utils import KoreUtils, PatternPath

from .metamath import ast as mm
from .metamath.composer import Proof, Theorem

from .encoder import KorePatternEncoder

from .env import ProofGenerator, ProvableClaim
from .substitution import SingleSubstitutionProofGenerator
from .equality import EqualityProofGenerator
from .quantifier import QuantifierProofGenerator, FunctionalProofGenerator
from .unification import UnificationProofGenerator


"""
Generate proofs for one or multiple rewrite steps
"""
class RewriteProofGenerator(ProofGenerator):
    """
    Strip call outermost injection calls
    """
    def strip_inj(self, pattern: kore.Pattern) -> kore.Pattern:
        while isinstance(pattern, kore.Application) and pattern.symbol.definition.symbol == "inj":
            assert len(pattern.arguments) == 1
            pattern = pattern.arguments[0]
        return pattern

    """
    Returns (lhs, lhs requires, rhs, rhs ensures)
    """
    def decompose_rewrite_axiom(self, pattern: kore.Pattern) -> (kore.Pattern, kore.Pattern, kore.Pattern, kore.Pattern):
        rewrite_pattern = KoreUtils.strip_forall(pattern)

        assert isinstance(rewrite_pattern, kore.MLPattern) and \
               rewrite_pattern.construct == kore.MLPattern.REWRITES

        lhs, rhs = rewrite_pattern.arguments
        lhs_requires, lhs_body = lhs.arguments
        rhs_ensures, rhs_body = rhs.arguments
        return (lhs_body, lhs_requires, rhs_body, rhs_ensures)

    def prove_rewrite_step(
        self,
        from_pattern: kore.Pattern,
        to_pattern: kore.Pattern,
        axiom_id: Optional[str]=None,
    ) -> Proof:
        # strip the outermost inj
        # TODO: re-add these in the end
        from_pattern = self.strip_inj(from_pattern)
        to_pattern = self.strip_inj(to_pattern)

        from_pattern_encoded = self.env.encode_pattern(from_pattern)
        to_pattern_encoded = self.env.encode_pattern(to_pattern)

        unification_gen = UnificationProofGenerator(self.env)

        if axiom_id is not None:
            # lookup the selected axiom if given
            assert axiom_id in self.env.rewrite_axioms, \
                "unable to find rewrite axiom {}".format(axiom_id)

            rewrite_axiom = self.env.rewrite_axioms[axiom_id]

            # unify `from_pattern` with the lhs of the selected axiom
            lhs, _, _, _ = self.decompose_rewrite_axiom(rewrite_axiom.claim.pattern)
            unification_result = unification_gen.unify_patterns(lhs, from_pattern)
            assert unification_result is not None, "unable to unify `{}` and `{}`".format(from_pattern, lhs)
        else:
            # if no axiom given, try to find one by brute force
            for _, rewrite_axiom in self.env.rewrite_axioms.items():
                lhs, _, _, _ = self.decompose_rewrite_axiom(rewrite_axiom.claim.pattern)
                unification_result = unification_gen.unify_patterns(lhs, from_pattern)
                if unification_result is not None:
                    break
            else:
                assert False, "unable to find axiom to rewrite `{}`".format(from_pattern)

        substitution = unification_result.get_lhs_substitution_as_instance()
        assert substitution is not None, "`{}` is not an instance of `{}`".format(from_pattern, lhs)

        # eliminate all universal quantifiers
        instantiated_axiom = QuantifierProofGenerator(self.env).prove_forall_elim(rewrite_axiom, substitution)

        # get rid of valid conditionals
        lhs, requires, rhs, ensures = self.decompose_rewrite_axiom(instantiated_axiom.claim.pattern)

        if requires.construct == kore.MLPattern.TOP and \
           ensures.construct == kore.MLPattern.TOP:
            top_valid_proof = self.env.get_theorem("kore-top-valid").apply(
                ph0=self.env.encode_pattern(instantiated_axiom.claim.pattern.sorts[0]),
            )
            
            step_proof = self.env.get_theorem("kore-rewrites-conditional").apply(
                instantiated_axiom.proof,
                top_valid_proof,
                top_valid_proof,
            )

            # during unification, there may be some equations applied to the pattern
            # we need to re-apply those equations so that the snapshot
            # and the lhs of the rewrite rule would be syntactically the same

            # reconstruct the rewrite pattern in kore
            # NOTE: this should be the "same" as step_proof.statement
            concrete_rewrite = kore.Axiom(
                [],
                kore.MLPattern(
                    kore.MLPattern.REWRITES,
                    [ instantiated_axiom.claim.pattern.sorts[0] ],
                    [ lhs, rhs ],
                ),
                [],
            )
            concrete_rewrite.resolve(self.env.module)

            provable = ProvableClaim(concrete_rewrite, step_proof)

            for equation, path in unification_result.applied_equations:
                print("> applying equation", equation)
                provable = equation.prove_validity(provable, [0, 0] + path)

            # check that the proven statement is actually what we want
            # the result should be of the form |- ( \kore-valid <top level sort> ( \kore-rewrite LHS RHS ) )
            assert provable.proof.statement.terms[1].symbol == KorePatternEncoder.VALID
            _, lhs_concrete, rhs_concrete = provable.proof.statement.terms[1].subterms[1].subterms

            assert lhs_concrete == from_pattern_encoded, \
                   "LHS is not what we expected: {} vs {}".format(lhs_concrete, from_pattern_encoded)
            assert rhs_concrete == to_pattern_encoded, \
                   "RHS is not what we expected: {} vs {}".format(rhs_concrete, to_pattern_encoded)

            return provable.proof
        else:
            raise Exception("unable to prove requires {} and/or ensures {}".format(requires, ensures))

    """
    Use transitivity of rewrite
    to chain a list of rewrite steps
    """
    def chain_rewrite_steps(self, step_theorems: List[Theorem]) -> Proof:
        assert len(step_theorems)

        current_proof = step_theorems[0].as_proof()
        for next_step in step_theorems[1:]:
            current_proof = self.env.get_theorem("kore-rewrites-trans").apply(current_proof, next_step.as_proof())
        
        return current_proof
