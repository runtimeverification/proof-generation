from typing import List, Tuple

from .kore import ast as kore
from .kore.visitors import PatternVariableVisitor

from .metamath import ast as mm
from .metamath.composer import Proof

from .env import ProofGenerator
from .substitution import SingleSubstitutionProofGenerator
from .sort import SortProofGenerator
from .encoder import KorePatternEncoder
from .equality import EqualityProofGenerator


r"""
Given a pattern phi, generate a proof for the statement in the form

|- ( \kore-forall \sort R ( \kore-exists Sort1 x ( \kore-equals Sort1 R x phi ) ) )

that is, phi is a functional pattern that has a unique singleton interpretation in the domain of Sort1

Almost all patterns used in the execution should have such property

NOTE: only supports concrete patterns right now
"""
class FunctionalProofGenerator(ProofGenerator, kore.KoreVisitor):
    """
    Given a functional axiom sigma and an application phi,
    sigma should be in the form,
    ( forall Sort_1 V_1 ... ( forall Sort_n V_n ( exists Sort_0 W ( equals Sort_0 R W <RHS> ) ) ) )
    where <RHS> will be of the form ( symbol <term_1> ... <term_n> )
    and <term_i> will be a variable, but the order is uncertain

    This function will figure out the order of variables in the term <RHS>
    """
    def get_order_of_substitution(self, axiom: kore.Axiom, application: kore.Application) -> List[Tuple[kore.Variable, kore.Pattern]]:
        variables = []
        equality = axiom.pattern
        while isinstance(equality, kore.MLPattern) and \
              equality.construct == kore.MLPattern.FORALL:
            variables.append(equality.get_binding_variable())
            equality = equality.arguments[1]

        assert isinstance(equality, kore.MLPattern) and \
               equality.construct == kore.MLPattern.EXISTS
        equality = equality.arguments[1]
        rhs = equality.arguments[1]

        assert rhs.symbol == application.symbol
        assert len(rhs.arguments) == len(application.arguments)

        ordered_variable_to_term = []

        for var, term in zip(rhs.arguments, application.arguments):
            assert isinstance(var, kore.Variable)
            ordered_variable_to_term.append((variables.index(var), var, term))

        ordered_variable_to_term.sort(key=lambda t: t[0])

        return [ (var, term) for _, var, term in ordered_variable_to_term ]

    """
    Specical case: when A is not an immediate subsort of B,
    we don't have the functional axiom of inj{A, B},
    in which case we need to stitch the chain of subsorting
    A < A1 < ... < B together to get a functional pattern
    and then use the inj axiom to reduce that back to
    a single injection.
    """
    def prove_non_immediate_injection(self, application: kore.Application) -> Proof:
        assert application.symbol.definition == self.env.sort_injection_symbol

        sort1, sort2 = application.symbol.sort_arguments
        chain = self.env.subsort_relation.get_subsort_chain(sort1, sort2)
        assert chain is not None, f"{sort1} is not a subsort of {sort2}, unable to prove that it's functional"
        assert len(chain) > 2, f"{sort1} is an immediate subsort of {sort2}"

        argument, = application.arguments

        # suppose the chain is S1 < S2 < ... < Sn
        # first recursively prove the functionality of
        # inj{Sn-1, Sn}(inj{S1, Sn-1}(<argument>))
        reduced_injection = kore.Application(
            kore.SymbolInstance(self.env.sort_injection_symbol, [ sort1, chain[-2] ]),
            [ argument ],
        )

        reduced_injection = kore.Application(
            kore.SymbolInstance(self.env.sort_injection_symbol, [ chain[-2], chain[-1] ]),
            [ reduced_injection ],
        )

        reduced_injection_is_functional = self.visit(reduced_injection)

        # TODO: hack
        sort_var = kore.SortVariable("R")
        elem_var = kore.Variable("Val", sort2)

        # kore pattern format of the statement above
        # so that we can do substitution:
        # axiom{R} \exists{R}(X:<sort2>, \equals{<sort2>, R}(<reduce form>, X:<sort2>))
        reduced_injection_axiom = kore.Axiom(
            [ sort_var ],
            kore.MLPattern(
                kore.MLPattern.EXISTS,
                [ sort_var ],
                [
                    elem_var,
                    kore.MLPattern(
                        kore.MLPattern.EQUALS,
                        [ sort2, sort_var ],
                        [ elem_var, reduced_injection ],
                    ),
                ],
            ),
            [],
        )

        inj_theorem_instance, inj_axiom_instance = SortProofGenerator(self.env).get_inj_instance(sort1, chain[-2], chain[-1])

        current_argument = reduced_injection.arguments[0].arguments[0]
        current_argument_is_functional = self.visit(current_argument)

        # inj_axiom_instance is of the form
        # \forall{...}(X:<sort1>, ... = ...)
        # we need to substitute current_argument for X in the equation
        subst_proof, _ = \
            SingleSubstitutionProofGenerator(self.env, self.env.sort_injection_axiom_element_var, current_argument) \
            .visit_and_substitute(inj_axiom_instance.pattern.arguments[1])

        # get the concrete form of the inj axiom (substitute the actual subpattern for X)
        concrete_inj_theorem_instance = self.env.get_theorem("kore-forall-elim-variant").apply(
            inj_theorem_instance,
            current_argument_is_functional,
            subst_proof,
        )

        _, proof = EqualityProofGenerator(self.env).prove_validity(
            reduced_injection_axiom,
            reduced_injection_is_functional,
            [ 0, 1, 1 ], # this is the path of the LHS of the equation in reduced_injection_axiom

            # the final injection pattern: inj{S1, S2}(<argument>)
            kore.Application(
                kore.SymbolInstance(self.env.sort_injection_symbol, [ sort1, sort2 ]),
                [ argument ],
            ),
            concrete_inj_theorem_instance,
        )

        return proof

        # zip_interval = lambda lst: zip(lst[:-1], lst[1:])

        # # suppose the chain is S1 < ... < Sn
        # # first prove the functionality of the expanded form
        # # inj{Sn-1, Sn}( ... inj{S1, S2}(<argument>) ... )
        # expanded_form = argument

        # for s1, s2 in zip_interval(chain):
        #     expanded_form = kore.Application(
        #         kore.SymbolInstance(self.env.sort_injection_symbol, [ s1, s2 ]),
        #         [ expanded_form ],
        #     )
        #     expanded_form.resolve(self.env.module)

        # # this should be of the form
        # # |- ( \forall-sort R ( \kore-valid R ( \exists Sn R X ( \equals Sn R inj{Sn-1, Sn}(...) = X ) ) ) )
        # expanded_form_is_functional = self.visit(expanded_form)

        

        # then use the injection axiom (equality)
        # to reduce it back to the original form

        # sort_gen = SortProofGenerator(self.env)

        # # since A is NOT an immediate subsort of B
        # # the expanded form has to have at least two
        # # layers of injections
        # current_argument = expanded_form.arguments[0].arguments[0]

        # for (s1, s2), (_, s3) in enumerate(zip_interval(zip_interval(chain))):
        #     # reduce inj{s2, s3}(inj{s1, s2}(X)) to inj{s1, s3}(X)
        #     inj_axiom_instance = sort_gen.get_inj_axiom_instance(s1, s2, s3)

        #     current_argument_is_functional = self.visit(current_argument)

        #     subst_proof, _ = \
        #         SingleSubstitutionProofGenerator(self.env, self.env.sort_injection_axiom_element_var, current_argument) \
        #         .visit_and_substitute(inj_axiom_instance)

        #     # get the concrete form of the inj axiom (substitute the actual subpattern for X)
        #     concrete_inj_axiom_instance = self.env.get_theorem("kore-forall-elim-variant").apply(
        #         inj_axiom_instance,
        #         current_argument_is_functional,
        #         subst_proof,
        #     )

        #     EqualityProofGenerator(self.env).prove_validity(
        #         expanded_form_axiom,
        #         expanded_form_is_functional,
        #         [ 0, 1, 0 ], # this is the path of the LHS of the equation in expanded_form_axiom
                
        #     )

    def postvisit_application(self, application: kore.Application) -> Tuple[Proof, kore.Axiom]:
        if application.symbol not in self.env.functional_axioms:
            if application.symbol.definition == self.env.sort_injection_symbol:
                return self.prove_non_immediate_injection(application)
            else:
                assert False, "cannot find a functional axiom for symbol instance {}".format(application.symbol)
        
        axiom, theorem = self.env.functional_axioms[application.symbol]
        ordered_substitution = self.get_order_of_substitution(axiom, application)

        # take the statement itself as a proof
        proof = theorem.as_proof()
        current_pattern = axiom.pattern

        for var, term in ordered_substitution:
            arg_subproof = self.visit(term)

            assert current_pattern.get_binding_variable() == var
            current_pattern = current_pattern.arguments[1]
            
            subst_subproof, current_pattern = \
                SingleSubstitutionProofGenerator(self.env, var, term).visit_and_substitute(current_pattern)

            # these info should be enough for the composer to infer all variables
            proof = self.env.get_theorem("kore-forall-elim-variant").apply(
                proof,
                arg_subproof,
                subst_subproof,
            )
        
        return proof

    def postvisit_ml_pattern(self, ml_pattern: kore.MLPattern) -> Proof:
        assert ml_pattern.construct == kore.MLPattern.DV, \
               "unnable to prove functional property for {}".format(ml_pattern)

        sort, literal = ml_pattern.sorts[0], ml_pattern.arguments[0]

        assert (sort, literal) in self.env.domain_value_functional_axioms, \
               "cannot find functional axiom for domain value {}".format(ml_pattern)

        return self.env.domain_value_functional_axioms[sort, literal].as_proof()
