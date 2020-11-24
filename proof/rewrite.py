from typing import Optional, List, Tuple, Mapping

from .kore import ast as kore
from .kore.utils import KoreUtils, PatternPath
from .kore.visitors import KoreVisitor, PatternOnlyVisitorStructure

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
    def decompose_rewrite_axiom(self, pattern: kore.Pattern) -> Tuple[kore.Pattern, kore.Pattern, kore.Pattern, kore.Pattern]:
        rewrite_pattern = KoreUtils.strip_forall(pattern)

        assert isinstance(rewrite_pattern, kore.MLPattern) and \
               rewrite_pattern.construct == kore.MLPattern.REWRITES

        lhs, rhs = rewrite_pattern.arguments

        if isinstance(lhs, kore.MLPattern) and lhs.construct == kore.MLPattern.AND:
            lhs_requires, lhs_body = lhs.arguments
        else:
            lhs_requires, lhs_body = None, lhs

        if isinstance(rhs, kore.MLPattern) and rhs.construct == kore.MLPattern.AND:
            rhs_ensures, rhs_body = rhs.arguments
        else:
            rhs_ensures, rhs_body = None, rhs

        return lhs_body, lhs_requires, rhs_body, rhs_ensures

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
                provable = equation.prove_validity(provable, [ 0, 0 ] + path)

            provable = self.resolve_functions(provable, [ 0, 1 ])

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

    def decompose_anywhere_axiom(self, pattern: kore.Pattern) -> Tuple[kore.Pattern, kore.Pattern, kore.Pattern, kore.Pattern]:
        inner_pattern = KoreUtils.strip_forall(pattern)

        assert isinstance(inner_pattern, kore.MLPattern) and \
               inner_pattern.construct == kore.MLPattern.IMPLIES

        requires, conjunction = inner_pattern.arguments

        assert isinstance(conjunction, kore.MLPattern) and \
               conjunction.construct == kore.MLPattern.AND

        equation, ensures = conjunction.arguments

        assert isinstance(equation, kore.MLPattern) and \
               equation.construct == kore.MLPattern.EQUALS

        lhs, rhs = equation.arguments

        return lhs, requires, rhs, ensures

    """
    Attempt to resolve all function patterns
    in the subpattern indicated by the path
    """
    def resolve_functions(self, provable: ProvableClaim, path: PatternPath) -> ProvableClaim:
        while True:
            subpattern = KoreUtils.get_subpattern_by_path(provable.claim, path)
            function_path = InnermostFunctionPathVisitor().visit(subpattern)
            if function_path is None:
                break

            function_subpattern = KoreUtils.get_subpattern_by_path(subpattern, function_path)

            # find an anywhere/function rule to rewrite
            for anywhere_axiom in self.env.anywhere_axioms.values():
                lhs, _, _, _ = self.decompose_anywhere_axiom(anywhere_axiom.claim.pattern)
                unification_result = UnificationProofGenerator(self.env).unify_patterns(lhs, function_subpattern)

                if unification_result is not None:
                    break
            else:
                raise Exception(f"unable to find anywhere/function rule to rewrite term {function_subpattern}")

            substitution = unification_result.get_lhs_substitution_as_instance()
            assert substitution is not None, "`{}` is not an instance of `{}`".format(function_subpattern, lhs)

            print(f"> rewriting anywhere/function {function_subpattern.symbol}")

            # eliminate all universal quantifiers
            instantiated_axiom = QuantifierProofGenerator(self.env).prove_forall_elim(anywhere_axiom, substitution)

            lhs, requires, rhs, ensures = self.decompose_anywhere_axiom(instantiated_axiom.claim.pattern)

            assert isinstance(requires, kore.MLPattern) and \
                   requires.construct == kore.MLPattern.TOP and \
                   isinstance(ensures, kore.MLPattern) and \
                   ensures.construct == kore.MLPattern.TOP, \
                   f"unsupported requires/ensures clause: {requires}, {ensures}"

            # from \implies{R}(top, \and{R}(<equation>, top))
            # we can get \and{R}(<equation>, top)
            free_sort_var = instantiated_axiom.claim.sort_variables[0]
            encoded_free_sort_var = self.env.encode_pattern(free_sort_var)

            top_proof = self.env.get_theorem("kore-top-valid-v1").apply(x=encoded_free_sort_var)
            removed_requires = self.env.get_theorem("kore-mp-v1").apply(
                top_proof,
                instantiated_axiom.proof,
            )
            instantiated_axiom_claim = kore.Claim(
                instantiated_axiom.claim.sort_variables,
                instantiated_axiom.claim.pattern.arguments[1],
                [],
            )
            instantiated_axiom_claim.resolve(self.env.module)
            instantiated_axiom = ProvableClaim(instantiated_axiom_claim, removed_requires)

            # now we have a conjunction and{R}(<equation>, <ensures>)
            # since we assumed ensures is top, we can remove it as well
            # that is, from \and{R}(<equation>, top)
            # we can get <equation>
            and_eliminated = self.env.get_theorem("kore-and-elim-left-v1").apply(
                instantiated_axiom.proof,
            )
            instantiated_axiom_claim = kore.Claim(
                instantiated_axiom.claim.sort_variables,
                instantiated_axiom.claim.pattern.arguments[0],
                [],
            )
            instantiated_axiom_claim.resolve(self.env.module)
            instantiated_axiom = ProvableClaim(instantiated_axiom_claim, and_eliminated)

            # finish up the rewriting by substituting in the rhs
            provable = EqualityProofGenerator(self.env).prove_validity(provable, path + function_path, rhs, instantiated_axiom.proof)

        return provable


"""
Return a path of an application subpattern with a function-like head such that
it doesn't have any (sub-)subpattern with a function-like head
"""
class InnermostFunctionPathVisitor(KoreVisitor):
    def postvisit_variable(self, variable: kore.Variable) -> Optional[PatternPath]:
        return None

    def postvisit_string_literal(self, literal: kore.StringLiteral) -> Optional[PatternPath]:
        return None

    def postvisit_application(self, application: kore.Application) -> Optional[PatternPath]:
        for i, arg in enumerate(application.arguments):
            path = self.visit(arg)
            if path is not None:
                return [ i ] + path

        # if the application itself is a function, return the empty path (pointing to itself)
        if application.symbol.definition.get_attribute_by_symbol("function") is not None:
            return []

        return None

    def postvisit_ml_pattern(self, ml_pattern: kore.MLPattern) -> Optional[PatternPath]:
        for i, arg in enumerate(ml_pattern.arguments):
            path = self.visit(arg)
            if path is not None:
                return [ i ] + path

        return None
