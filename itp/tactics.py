from typing import Mapping, Optional

from proof.metamath.ast import Term, StructuredStatement, Application
from proof.metamath.composer import Theorem, Proof
from proof.metamath.visitors import CopyVisitor

from .state import ProofState
from .extension import SchematicVariable, SubstitutionVisitor


class Tactic:
    """
    Transforms the proof state
    """
    def apply(self, state: ProofState):
        raise NotImplementedError()

    """
    Transforms the proof stack
    """
    def resolve(self, state: ProofState):
        raise NotImplementedError()


"""
Apply a theorem on the top of the goal stack
"""
class ApplyTactic(Tactic):
    def __init__(self, theorem: Theorem, initial_substitution: Mapping[str, Term]={}):
        self.theorem = theorem
        self.metavars_substitution = initial_substitution

    """
    Unify two statements, treating only schematic variables as variables
    """
    def unify_schematic_variables(self, state: ProofState, stmt1: StructuredStatement, stmt2: StructuredStatement) -> Optional[Mapping[str, Term]]:
        if len(stmt1.terms) != len(stmt2.terms): return None

        unification = list(zip(stmt1.terms, stmt2.terms))
        substitution = {}

        while len(unification):
            left, right = unification.pop()
            if left == right: continue

            # unifying applications
            if not isinstance(left, SchematicVariable) and \
               not isinstance(right, SchematicVariable):
                if not isinstance(left, Application) or not isinstance(right, Application):
                    # we are not supposed to substitute any non-schematic metavariables
                    return None

                if left.symbol != right.symbol: return None
                if len(left.subterms) != len(right.subterms): return None
                unification += list(zip(left.subterms, right.subterms))
                continue

            if isinstance(left, SchematicVariable):
                # check for recursive equations
                if left.name in right.get_metavariables():
                    return None

                substitution[left.name] = right

                subst_visitor = SubstitutionVisitor({ left.name: right })

                for i, (left, right) in enumerate(unification):
                    unification[i] = subst_visitor.visit(left), subst_visitor.visit(right)

                substitution = { var: subst_visitor.visit(term) for var, term in substitution.items() }

            else:
                assert isinstance(right, SchematicVariable)
                unification.append((right, left))

        return substitution

    def apply(self, state: ProofState):
        top_goal = state.goal_stack.pop()
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

        schematic_substitution = self.unify_schematic_variables(state, top_goal, copied_statement)
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
class SetSchematicVariableTactic(Tactic):
    def __init__(self, substitution: Mapping[str, Term]={}):
        self.substitution = substitution

    def apply(self, state: ProofState):
        live_svars = state.get_live_schematic_variables()
        substituting_svars = set(self.substitution.keys())
        assert substituting_svars.issubset(live_svars), \
               f"assigning dead/nonexistent schematic variable(s) {substituting_svars.difference(live_svars)}"

        for var, term in self.substitution.items():
            assert state.is_concrete(term), f"non-concrete term {term} substituted for schematic variable {var}"

            svar = state.get_schematic_variable_from_name(var)            
            assert svar is not None, f"cannot substitute non-schematic variable {var}"

            state.assign_schematic_variable(svar, term)

        subst_visitor = SubstitutionVisitor(self.substitution)
        state.goal_stack = [ subst_visitor.visit(stmt) for stmt in state.goal_stack ]

    def resolve(self, state: ProofState): pass


"""
Move the current goal to the last
"""
class ShuffleTactic(Tactic):
    def __init__(self):
        self.statement = None

    def apply(self, state: ProofState):
        state.goal_stack = [ state.goal_stack[-1] ] + state.goal_stack[:-1]

    def resolve(self, state: ProofState):
        state.proof_stack = state.proof_stack[1:] + [ state.proof_stack[0] ]
