from typing import Optional, List, Tuple, Mapping, Union

from .kore import ast as kore
from .kore.utils import KoreUtils, PatternPath
from .kore.visitors import KoreVisitor, PatternOnlyVisitorStructure

from .metamath import ast as mm
from .metamath.composer import Proof, Theorem

from .encoder import KorePatternEncoder

from .env import ProofEnvironment, ProofGenerator, ProvableClaim
from .substitution import SingleSubstitutionProofGenerator
from .equality import EqualityProofGenerator
from .quantifier import QuantifierProofGenerator, FunctionalProofGenerator
from .unification import UnificationProofGenerator, InjectionCombine


"""
Generate proofs for one or multiple rewrite steps
"""
class RewriteProofGenerator(ProofGenerator):
    def __init__(self, env: ProofEnvironment):
        super().__init__(env)
        self.owise_axiom_counter = 0
        self.hooked_symbol_evaluators = {
            "Lbl'UndsPlus'Int'Unds'": IntegerAdditionEvaluator(env),
            "Lbl'Unds'-Int'Unds'": IntegerSubtractionEvaluator(env),
            "Lbl'UndsStar'Int'Unds'": IntegerMultiplicationEvaluator(env),
            "Lbl'Unds-GT-Eqls'Int'Unds'": IntegerGreaterThanOrEqualToEvaluator(env),
            "Lbl'Unds'andBool'Unds'": BooleanAndEvaluator(env),
            "LblnotBool'Unds'": BooleanNotEvaluator(env),
        }

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

    """
    Find and instantiate a rewrite axiom for the given pattern,
    and then resolve all the functions in the RHS
    """
    def find_rewrite_axiom_for_pattern(self, pattern: kore.Pattern) -> ProvableClaim:
        unification_gen = UnificationProofGenerator(self.env)

        for _, rewrite_axiom in self.env.rewrite_axioms.items():
            print(f"> trying axiom {self.env.get_axiom_unique_id(rewrite_axiom.claim)}")

            lhs, _, _, _ = self.decompose_rewrite_axiom(rewrite_axiom.claim.pattern)
            unification_result = unification_gen.unify_patterns(lhs, pattern)
            if unification_result is None: continue

            substitution = unification_result.get_lhs_substitution_as_instance()
            if substitution is None: continue

            # eliminate all universal quantifiers
            instantiated_axiom = QuantifierProofGenerator(self.env).prove_forall_elim(rewrite_axiom, substitution)
            lhs, requires, rhs, ensures = self.decompose_rewrite_axiom(instantiated_axiom.claim.pattern)

            assert ensures.construct == kore.MLPattern.TOP, f"non-top ensures clause is not supported: {ensures}"

            # trying to prove the requires clause
            # if failed, continue searching for an axiom
            requires_proof = self.prove_requires_clause(requires)
            if requires_proof is None: continue

            top_valid_proof = self.env.get_theorem("kore-top-valid").apply(
                ph0=self.env.encode_pattern(instantiated_axiom.claim.pattern.sorts[0]),
            )
            
            concrete_rewrite_proof = self.env.get_theorem("kore-rewrites-conditional").apply(
                instantiated_axiom.proof,
                requires_proof,
                top_valid_proof,
            )

            # reconstruct the rewrite pattern in kore
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

            concrete_rewrite_claim = ProvableClaim(concrete_rewrite, concrete_rewrite_proof)

            # during unification, we applied some equations
            # here we resolve these equations so that we would
            # get a correct left hand side
            for equation, path in unification_result.applied_equations:
                print("> applying unification equation", equation)
                concrete_rewrite_claim = equation.prove_validity(concrete_rewrite_claim, [ 0, 0 ] + path)

            concrete_rewrite_claim = self.simplify_pattern(concrete_rewrite_claim, [ 0, 1 ])

            return concrete_rewrite_claim
        
        assert False, "unable to find axiom to rewrite `{}`".format(pattern)

    def prove_rewrite_step(
        self,
        from_pattern: kore.Pattern,
        to_pattern: kore.Pattern,
    ) -> Proof:
        # strip the outermost inj
        # TODO: re-add these in the end
        from_pattern = self.strip_inj(from_pattern)
        to_pattern = self.strip_inj(to_pattern)

        from_pattern_encoded = self.env.encode_pattern(from_pattern)
        to_pattern_encoded = self.env.encode_pattern(to_pattern)

        concrete_rewrite_claim = self.find_rewrite_axiom_for_pattern(from_pattern)

        # check that the proven statement is actually what we want
        # the result should be of the form |- ( \kore-valid <top level sort> ( \kore-rewrite LHS RHS ) )
        assert concrete_rewrite_claim.proof.statement.terms[1].symbol == KorePatternEncoder.VALID
        _, lhs_concrete, rhs_concrete = concrete_rewrite_claim.proof.statement.terms[1].subterms[1].subterms

        assert lhs_concrete == from_pattern_encoded, \
                "unexpected LHS: {} vs {}".format(lhs_concrete, from_pattern_encoded)
        assert rhs_concrete == to_pattern_encoded, \
                "unexpected RHS: {} vs {}".format(rhs_concrete, to_pattern_encoded)

        return concrete_rewrite_claim.proof

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

    r"""
    Prove a pattern of the form
    - top{S{}}(), or
    - \equals{...}(..., ...)

    For \equals, it can have either a concrete sort
    or a sort variable as the output sort
    """
    def prove_requires_clause(self, pattern: kore.Pattern) -> Optional[Proof]:
        assert isinstance(pattern, kore.MLPattern)

        # if the pattern is top, then it's trivially true
        if pattern.construct == kore.MLPattern.TOP:
            sort = pattern.sorts[0]
            encoded_sort = self.env.encode_pattern(sort)
            if isinstance(sort, kore.SortInstance):
                return self.env.get_theorem("kore-top-valid").apply(ph0=encoded_sort)
            else:
                assert isinstance(sort, kore.SortVariable)
                return self.env.get_theorem("kore-top-valid-v1").apply(x=encoded_sort)

        # assert pattern.construct == kore.MLPattern.EQUALS, \
        #        f"unable to prove the requires clause {pattern}"
        if pattern.construct != kore.MLPattern.EQUALS:
            return None

        input_sort, output_sort = pattern.sorts
        encoded_input_sort = self.env.encode_pattern(input_sort)
        encoded_output_sort = self.env.encode_pattern(output_sort)

        lhs, rhs = pattern.arguments
        encoded_lhs = self.env.encode_pattern(lhs)

        # we only support two cases right now:
        # either the equals pattern depends on one
        # free sort variable, or none
        if isinstance(output_sort, kore.SortInstance):
            proof = self.env.get_theorem("kore-equals-reflexivity").apply(ph0=encoded_output_sort, ph1=encoded_input_sort, ph2=encoded_lhs)
            claim = kore.Claim(
                [],
                kore.MLPattern(
                    kore.MLPattern.EQUALS,
                    [ input_sort, output_sort, ],
                    [ lhs, lhs ],
                ),
                [],
            )
            claim.resolve(self.env.module)
            provable = ProvableClaim(claim, proof)
        else:
            assert isinstance(output_sort, kore.SortVariable)
            proof = self.env.get_theorem("kore-equals-reflexivity-v1").apply(x=encoded_output_sort, ph0=encoded_input_sort, ph1=encoded_lhs)
            claim = kore.Claim(
                [ output_sort ],
                kore.MLPattern(
                    kore.MLPattern.EQUALS,
                    [ input_sort, output_sort, ],
                    [ lhs, lhs ],
                ),
                [],
            )
            claim.resolve(self.env.module)
            provable = ProvableClaim(claim, proof)

        provable = self.simplify_pattern(provable, [ 0, 1 ])

        # failed to prove the condition
        if provable.claim.pattern.arguments[1] != rhs:
            return None

        return provable.proof

    def prove_owise_clause(self, condition: kore.Pattern) -> Optional[Proof]:
        assert isinstance(condition, kore.MLPattern) and condition.construct == kore.MLPattern.AND

        output_sort, = condition.sorts

        # TODO: currently we don't have enough axioms in the kore definition
        # to show this condition, so we will just assume it being true

        claim = kore.Claim([ output_sort ], condition, [])
        claim.resolve(self.env.module)

        theorem = self.env.load_axiom(claim, f"owise-assumption-{self.owise_axiom_counter}", provable=True)
        self.owise_axiom_counter += 1

        return theorem.as_proof()

    def match_and_instantiate_anywhere_axiom(self, axiom: ProvableClaim, pattern: kore.Pattern, is_owise=False) -> Optional[ProvableClaim]:
        # unify the LHS
        lhs, _, _, _ = self.decompose_anywhere_axiom(axiom.claim.pattern)
        unification_result = UnificationProofGenerator(self.env).unify_patterns(lhs, pattern)

        if unification_result is None: return None

        # get substitution
        substitution = unification_result.get_lhs_substitution_as_instance()
        if substitution is None: return None

        # eliminate all universal quantifiers
        instantiated_axiom = QuantifierProofGenerator(self.env).prove_forall_elim(axiom, substitution)

        lhs, requires, _, ensures = self.decompose_anywhere_axiom(instantiated_axiom.claim.pattern)

        # assert isinstance(ensures, kore.MLPattern) and \
        #        ensures.construct == kore.MLPattern.TOP, \
        #        f"unsupported ensures clause {ensures}"
        if not (isinstance(ensures, kore.MLPattern) and
                ensures.construct == kore.MLPattern.TOP):
            return None

        # from \implies{R}(<requires>, \and{R}(<equation>, top))
        # if we can prove the requires clause
        # we can get \and{R}(<equation>, top)
        if not is_owise:
            requires_proof = self.prove_requires_clause(requires)
            if requires_proof is None: return None
        else:
            # if the current axiom is labelled [owise]
            # we have failed to match other non-owise axioms.
            # by the informal semantics of [owise] we should
            # use this rule if it matches.
            requires_proof = self.prove_owise_clause(requires)
            assert requires_proof is not None, f"unable to prove owise condition {requires}"

        removed_requires = self.env.get_theorem("kore-mp-v1").apply(
            requires_proof,
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

        for equation, path in unification_result.applied_equations:
            instantiated_axiom = equation.prove_validity(instantiated_axiom, [ 0, 0 ] + path)

        return instantiated_axiom

    """
    Find and instantiate a anywhere/function axiom for the given (function) pattern
    """
    def find_anywhere_axiom_for_pattern(self, pattern: kore.Pattern) -> ProvableClaim:
        assert isinstance(pattern, kore.Application), f"{pattern} is not an application"

        head_symbol = pattern.symbol
        assert head_symbol in self.env.equational_axioms, f"head symbol {head_symbol} does not have any equational axioms associated to it"

        non_owise_axioms = []
        owise_axiom = None

        for axiom in self.env.equational_axioms[head_symbol]:
            if axiom.claim.get_attribute_by_symbol("owise") is None:
                non_owise_axioms.append(axiom)
            else:
                assert owise_axiom is None, "multiple otherwise axioms"
                owise_axiom = axiom

        # find an anywhere/function rule to rewrite
        for axiom in non_owise_axioms:
            instantiated = self.match_and_instantiate_anywhere_axiom(axiom, pattern)
            if instantiated is not None: return instantiated

        # try owise if other ones failed to match
        if owise_axiom is not None:
            instantiated = self.match_and_instantiate_anywhere_axiom(owise_axiom, pattern, is_owise=True)
            if instantiated is not None: return instantiated
        
        raise Exception(f"unable to find anywhere/function rule to rewrite term {pattern}")

    """
    Simplify the subpattern indicated by the path by
      - resolving functions
      - simplify nested injections
    """
    def simplify_pattern(self, provable: ProvableClaim, path: PatternPath) -> ProvableClaim:
        while True:
            subpattern = KoreUtils.get_subpattern_by_path(provable.claim, path)

            # simplify nested inj
            nested_inj_path = InnermostNestedInjectionPathVisitor(self.env).visit(subpattern)
            if nested_inj_path is not None:
                print(f"> simplifying nested inj")
                provable = InjectionCombine(self.env).prove_validity(provable, path + nested_inj_path)
                continue

            # resolve unresolved functions
            function_path = InnermostFunctionPathVisitor().visit(subpattern)
            if function_path is not None:
                function_subpattern = KoreUtils.get_subpattern_by_path(subpattern, function_path)
                print(f"> rewriting anywhere/function {function_subpattern.symbol}")

                # if the symbol is bulitin, try the builtin evaluator
                symbol_string = function_subpattern.symbol.definition.symbol
                if symbol_string in self.hooked_symbol_evaluators:
                    axiom = self.hooked_symbol_evaluators[symbol_string].prove_evaluation(function_subpattern)
                else:
                    axiom = self.find_anywhere_axiom_for_pattern(function_subpattern)

                # finish up the rewriting by substituting in the rhs
                provable = EqualityProofGenerator(self.env).prove_validity_with_equation(provable, path + function_path, axiom)
                continue

            break

        return provable


class InnermostNestedInjectionPathVisitor(KoreVisitor):
    def __init__(self, env: ProofEnvironment):
        super().__init__()
        self.env = env

    def postvisit_variable(self, variable: kore.Variable) -> Optional[PatternPath]:
        return None

    def postvisit_string_literal(self, literal: kore.StringLiteral) -> Optional[PatternPath]:
        return None

    def postvisit_application(self, application: kore.Application) -> Optional[PatternPath]:
        for i, arg in enumerate(application.arguments):
            path = self.visit(arg)
            if path is not None:
                return [ i ] + path

        # if the current pattern is a nested injection
        if application.symbol.definition == self.env.sort_injection_symbol and \
           isinstance(application.arguments[0], kore.Application) and \
           application.arguments[0].symbol.definition == self.env.sort_injection_symbol:
            return []

        return None

    def postvisit_ml_pattern(self, ml_pattern: kore.MLPattern) -> Optional[PatternPath]:
        for i, arg in enumerate(ml_pattern.arguments):
            path = self.visit(arg)
            if path is not None:
                return [ i ] + path

        return None


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


"""
Common base class for evaluator of the builtin sort SortInt{}
"""
class BuiltinFunctionEvaluator(ProofGenerator):
    def __init__(self, env: ProofEnvironment):
        super().__init__(env)
        self.axiom_counter = 0

    def parse_int(self, value: kore.Pattern) -> int:
        assert isinstance(value, kore.MLPattern) and \
               value.construct == kore.MLPattern.DV
        assert value.sorts[0].definition.sort_id == "SortInt"
        assert isinstance(value.arguments[0], kore.StringLiteral)
        return int(value.arguments[0].content)

    def parse_bool(self, value: kore.Pattern) -> bool:
        assert isinstance(value, kore.MLPattern) and \
               value.construct == kore.MLPattern.DV
        assert value.sorts[0].definition.sort_id == "SortBool"
        assert isinstance(value.arguments[0], kore.StringLiteral)
        return { "true": True, "false": False }[value.arguments[0].content]

    """
    Build an axiom that says the given pattern
    is equal to the result, which is either an integer
    or a boolean

    Then we will potentially discharge a proof obligation to some domain value reasoning tool
    """
    def build_arithmetic_equation(self, application: kore.Application, result: Union[int, bool]) -> ProvableClaim:
        output_sort = application.symbol.definition.output_sort
        sort_var = kore.SortVariable("R")

        if type(result) is bool:
            result_literal = "true" if result else "false"
        else:
            result_literal = str(result)

        domain_value = kore.MLPattern(kore.MLPattern.DV, [ output_sort ], [ kore.StringLiteral(result_literal) ])

        claim = kore.Claim(
            [ sort_var ],
            kore.MLPattern(
                kore.MLPattern.EQUALS,
                [ output_sort, sort_var ],
                [ application, domain_value ],
            ),
            [],
        )

        claim.resolve(self.env.module)

        # TODO: we need to generate a proof obligation for
        # this arithmetic fact
        self.env.load_comment("NOTE: domain value reasoning checked by external tool")
        thm = self.env.load_axiom(claim, f"{self.env.sanitize_label_name(application.symbol.definition.symbol)}-domain-fact-{self.axiom_counter}", comment=False)

        print(f"> bulitin symbol proof obligation: {claim}")

        self.axiom_counter += 1

        return ProvableClaim(claim, thm.as_proof())


class IntegerAdditionEvaluator(BuiltinFunctionEvaluator):
    def prove_evaluation(self, application: kore.Application) -> ProvableClaim:
        a, b = application.arguments
        return self.build_arithmetic_equation(application, self.parse_int(a) + self.parse_int(b))


class IntegerSubtractionEvaluator(BuiltinFunctionEvaluator):
    def prove_evaluation(self, application: kore.Application) -> ProvableClaim:
        a, b = application.arguments
        return self.build_arithmetic_equation(application, self.parse_int(a) - self.parse_int(b))


class IntegerMultiplicationEvaluator(BuiltinFunctionEvaluator):
    def prove_evaluation(self, application: kore.Application) -> ProvableClaim:
        a, b = application.arguments
        return self.build_arithmetic_equation(application, self.parse_int(a) * self.parse_int(b))


class IntegerGreaterThanOrEqualToEvaluator(BuiltinFunctionEvaluator):
    def prove_evaluation(self, application: kore.Application) -> ProvableClaim:
        a, b = application.arguments
        return self.build_arithmetic_equation(application, self.parse_int(a) >= self.parse_int(b))


class BooleanAndEvaluator(BuiltinFunctionEvaluator):
    def prove_evaluation(self, application: kore.Application) -> ProvableClaim:
        a, b = application.arguments
        return self.build_arithmetic_equation(application, self.parse_bool(a) and self.parse_bool(b))


class BooleanNotEvaluator(BuiltinFunctionEvaluator):
    def prove_evaluation(self, application: kore.Application) -> ProvableClaim:
        a, = application.arguments
        return self.build_arithmetic_equation(application, not self.parse_bool(a))
