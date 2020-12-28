from typing import Mapping, Optional

from proof.metamath.parser import parse_term_with_metavariables
from proof.metamath.ast import Term, StructuredStatement, Application
from proof.metamath.composer import Theorem, Proof
from proof.metamath.visitors import CopyVisitor

from proof.metamath.auto.unification import Unification

from .state import ProofState
from .extension import SchematicVariable, SubstitutionVisitor


class Tactic:
    def __init__(self, tactic_name: str):
        self.tactic_name = tactic_name

    """
    Transforms the proof state
    """
    def apply(self):
        raise NotImplementedError()

    """
    Transforms the proof stack
    """
    def resolve(self):
        raise NotImplementedError()

    def parse_substitution(self, state: ProofState, options: Mapping[str, str]) -> Mapping[str, Term]:
        substitution = {}

        for key, value in options.items():
            assert type(value) is str
            substitution[key] = parse_term_with_metavariables(value, set(state.composer.get_all_metavariables()))

        return substitution


"""
Apply a theorem on the top of the goal stack
"""
@ProofState.register_tactic("apply")
class ApplyTactic(Tactic):
    def apply(self, state: ProofState, theorem_name: str, **options):
        substitution = self.parse_substitution(state, options)
        self.metavars_substitution = substitution

        top_goal = state.goal_stack.pop()

        self.theorem = state.composer.find_theorem(theorem_name)
        if self.theorem is not None:
            copied_statement = state.sanitize_goal_statement(self.theorem.statement)

            metavars = copied_statement.get_metavariables()
            for essential in self.theorem.essentials:
                metavars.update(essential.get_metavariables())
            metavars = list(metavars)
            metavars.sort() # making things a bit more deterministic

            for metavar in metavars:
                if metavar not in self.metavars_substitution:
                    typecode = state.composer.find_metavariable(metavar)
                    self.metavars_substitution[metavar] = state.get_next_schematic_variable(typecode)

            # replace all metavariables in the applied theorem
            # with distinct schematic variables
            metavars_subst_visitor = SubstitutionVisitor(self.metavars_substitution)
            copied_statement = metavars_subst_visitor.visit(copied_statement)

            essentials = [ state.sanitize_goal_statement(essential) for essential in self.theorem.essentials ]
            essentials = [ metavars_subst_visitor.visit(essential) for essential in essentials ]

        else:
            self.theorem = state.composer.find_essential(theorem_name)
            assert self.theorem is not None, f"cannot find theorem {theorem_name}"
            copied_statement = self.theorem.statement
            essentials = []

        schematic_substitution = Unification.unify_statements(
            top_goal, copied_statement,
            variable_class=SchematicVariable,
            substitution_visitor_class=SubstitutionVisitor,
            # newer schematic variable are used as substitution variables
            # with higher priority than older schematic variables
            variable_order=lambda v1, v2: v1.num > v2.num,
        )
        assert schematic_substitution is not None, f"unable to unify the goal {top_goal} with {copied_statement}"

        for var, term in schematic_substitution.items():
            svar = state.get_schematic_variable_from_name(var)
            assert svar is not None, f"missing schematic variable {svar}"
            state.assign_schematic_variable(svar, term)

        schematic_subst_visitor = SubstitutionVisitor(schematic_substitution)

        # add all essentials to the goal stack
        state.goal_stack += essentials[::-1]
        state.goal_stack = [ schematic_subst_visitor.visit(stmt) for stmt in state.goal_stack ]

        # check if any schematic variables are killed before being assigned
        top_goal = schematic_subst_visitor.visit(top_goal)
        live_svars = state.get_live_schematic_variables()
        killed_svars = top_goal.get_metavariables().difference(live_svars)
        killed_svars = { var for var in killed_svars if state.get_schematic_variable_from_name(var) is not None }
        assert not killed_svars, f"schematic variable(s) {killed_svars} killed before being assigned"

    """
    Construct a proof from the proof stack and the information inferred before
    """
    def resolve(self, state: ProofState):
        num_essentials = len(self.theorem.essentials)

        assert len(state.proof_stack) >= num_essentials, \
               f"theorem {self.theorem.statement.label} requires {num_essentials}, but only {len(state.proof_stack)} are on the proof stack"

        subproofs = []
        for _ in range(len(self.theorem.essentials)):
            subproofs.append(state.proof_stack.pop())

        # during apply(), we made a substitution from metavariables to schematic variables
        # now we attempt to resolve all the schematic variables to concrete terms (terms
        # without schematic variables)
        full_substitution = {
            var: state.resolve_schematic_variables(term)
            for var, term in self.metavars_substitution.items()
        }

        state.proof_stack.append(self.theorem.apply(
            *subproofs,
            **full_substitution,
        ))


"""
Set some schematic variables to concrete terms (without schematic variables)
"""
@ProofState.register_tactic("let")
class SetSchematicVariableTactic(Tactic):
    def apply(self, state: ProofState, **options):
        substitution = self.parse_substitution(state, options)

        live_svars = state.get_live_schematic_variables()
        substituting_svars = set(substitution.keys())
        assert substituting_svars.issubset(live_svars), \
               f"assigning dead/nonexistent schematic variable(s) {substituting_svars.difference(live_svars)}"

        for var, term in substitution.items():
            assert state.is_concrete(term), f"non-concrete term {term} substituted for schematic variable {var}"

            svar = state.get_schematic_variable_from_name(var)            
            assert svar is not None, f"cannot substitute non-schematic variable {var}"

            state.assign_schematic_variable(svar, term)

        subst_visitor = SubstitutionVisitor(substitution)
        state.goal_stack = [ subst_visitor.visit(stmt) for stmt in state.goal_stack ]

    def resolve(self, state: ProofState): pass


"""
Move the current goal to the last
"""
@ProofState.register_tactic("meh")
class ShuffleTactic(Tactic):
    def apply(self, state: ProofState):
        state.goal_stack = [ state.goal_stack[-1] ] + state.goal_stack[:-1]

    def resolve(self, state: ProofState):
        state.proof_stack = state.proof_stack[1:] + [ state.proof_stack[0] ]
