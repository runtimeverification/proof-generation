from typing import Optional, List, Tuple, Mapping

from .kore import ast as kore
from .kore.utils import KoreUtils, PatternPath

from .metamath import ast as mm
from .metamath.composer import Proof

from .encoder import KorePatternEncoder

from .env import ProofGenerator
from .substitution import SingleSubstitutionProofGenerator
from .equality import EqualityProofGenerator
from .functional import FunctionalProofGenerator
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

    """
    Repeatedly apply kore-forall-elim to instantiate an axiom with function-like patterns.
    Return the substituted pattern (in kore) and the proof for that pattern
    """
    def apply_forall_elim(
        self,
        axiom: kore.Axiom,
        proof: Proof, # proof in mm for the axiom above
        substitution: Mapping[kore.Variable, kore.Pattern],
        elim_axiom="kore-forall-elim", # or kore-forall-elim-variant
    ) -> Tuple[kore.Pattern, Proof]:
        current_proof = proof
        current_axiom_pattern = axiom.pattern

        while isinstance(current_axiom_pattern, kore.MLPattern) and \
              current_axiom_pattern.construct == kore.MLPattern.FORALL:
            var = current_axiom_pattern.get_binding_variable()

            assert var in substitution, "variable {} not instantiated".format(var)
            
            term = substitution[var]

            # prove that the term is interpreted to a singleton in some domain
            functional_term_subproof = FunctionalProofGenerator(self.env).visit(term)

            # remove one layer of quantification
            current_axiom_pattern = current_axiom_pattern.arguments[1]

            # prove the substitution
            subst_subproof, current_axiom_pattern = \
                SingleSubstitutionProofGenerator(self.env, var, term).visit_and_substitute(current_axiom_pattern)

            current_proof = self.env.get_theorem(elim_axiom).apply(
                current_proof,
                functional_term_subproof,
                subst_subproof
            )

        return current_axiom_pattern, current_proof

    def prove_rewrite_step(
        self,
        from_pattern: kore.Pattern,
        to_pattern: kore.Pattern,
        axiom_id: Optional[str]=None,
    ):
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

            rewrite_axiom, rewrite_axiom_in_mm = self.env.rewrite_axioms[axiom_id]

            # unify `from_pattern` with the lhs of the selected axiom
            lhs, _, _, _ = self.decompose_rewrite_axiom(rewrite_axiom.pattern)
            unification_result = unification_gen.unify_patterns(lhs, from_pattern)
            assert unification_result is not None, "unable to unify `{}` and `{}`".format(from_pattern, lhs)
        else:
            # if no axiom given, try to find one by brute force
            for _, (rewrite_axiom, rewrite_axiom_in_mm) in self.env.rewrite_axioms.items():
                lhs, _, _, _ = self.decompose_rewrite_axiom(rewrite_axiom.pattern)
                unification_result = unification_gen.unify_patterns(lhs, from_pattern)
                if unification_result is not None:
                    break
            else:
                assert False, "unable to find axiom to rewrite `{}`".format(from_pattern)

        # iteratively apply each item in the substitution
        # NOTE: here we are assuming the terms in the substitution
        # are all concrete so that iterative substitution is equivalent
        # to a one-time simultaneous substitution

        substitution = unification_result.get_lhs_substitution_as_instance()

        assert substitution is not None, "`{}` is not an instance of `{}`".format(from_pattern, lhs)

        instantiated_axiom_pattern, instantiated_proof = \
            self.apply_forall_elim(rewrite_axiom, rewrite_axiom_in_mm.as_proof(), substitution)

        # get rid of valid conditionals
        lhs, requires, rhs, ensures = self.decompose_rewrite_axiom(instantiated_axiom_pattern)

        if requires.construct == kore.MLPattern.TOP and \
           ensures.construct == kore.MLPattern.TOP:
            top_valid_proof = self.env.get_theorem("kore-top-valid").apply(
                ph0=self.env.encode_pattern(instantiated_axiom_pattern.sorts[0]),
            )
            
            step_proof = self.env.get_theorem("kore-rewrites-conditional").apply(
                instantiated_proof,
                top_valid_proof,
                top_valid_proof,
            )

            # during unification, there may be some equations applied to the pattern
            # we need to re-apply those equations so that the snapshot
            # and the lhs of the rewrite rule would be syntactically the same

            # reconstruct the rewrite pattern in kore
            # NOTE: this should be the "same" as step_proof.statement
            concrete_rewrite_axiom = kore.Axiom(
                [],
                kore.MLPattern(
                    kore.MLPattern.REWRITES,
                    [ instantiated_axiom_pattern.sorts[0] ],
                    [ lhs, rhs ],
                ),
                [],
            )

            for equation, path in unification_result.applied_equations:
                concrete_rewrite_axiom, step_proof = equation.prove_validity(concrete_rewrite_axiom, step_proof, [0, 0] + path)

            # check that the proven statement is actually what we want
            # the result should be of the form |- ( \kore-valid <top level sort> ( \kore-rewrite LHS RHS ) )
            assert step_proof.statement.terms[1].symbol == KorePatternEncoder.VALID
            _, lhs_concrete, rhs_concrete = step_proof.statement.terms[1].subterms[1].subterms

            assert lhs_concrete == from_pattern_encoded, \
                   "LHS is not we expected: {} vs {}".format(lhs_concrete, from_pattern_encoded)
            assert rhs_concrete == to_pattern_encoded, \
                   "RHS is not we expected: {} vs {}".format(rhs_concrete, to_pattern_encoded)

            return step_proof
        else:
            raise Exception("unable to prove requires {} and/or ensures {}".format(requires, ensures))

    """
    Use transitivity of rewrite
    to chain a list of rewrite steps
    """
    def chain_rewrite_steps(self, step_proofs: List[Proof]) -> Proof:
        assert len(step_proofs)

        current_proof = step_proofs[0]
        for next_step in step_proofs[1:]:
            current_proof = self.env.get_theorem("kore-rewrites-trans").apply(current_proof, next_step)
        
        return current_proof
