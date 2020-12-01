from __future__ import annotations

from typing import List, Optional, Mapping, NewType, Set

from proof.metamath.ast import StructuredStatement, Metavariable, Term, MetamathVisitor
from proof.metamath.composer import Composer, Proof, Theorem

from .ast import *
from .extension import SchematicVariable, SubstitutionVisitor, CopyVisitor


class ProofState:
    auto_tactics = {}

    @staticmethod
    def auto(name: str):
        def decorator(class_object):
            ProofState.auto_tactics[name] = class_object
            return class_object
        return decorator

    def get_auto_tactic(self, name: str):
        assert name in ProofState.auto_tactics, f"auto tactic {name} not found"
        return ProofState.auto_tactics[name]

    def __init__(self, composer: Composer, init_goal_stack: List[StructuredStatement], hypotheses: List[Theorem]):
        self.composer = composer
        self.schematic_vars = []
        self.schematic_var_assignment = {} # num -> term
        self.goal_stack = [ self.sanitize_goal_statement(goal) for goal in init_goal_stack ]
        self.hypotheses = hypotheses
        self.proof_stack: List[Proof] = []
        self.applied_tactics = []

    def copy(self) -> ProofState:
        copied_state = ProofState(self.composer, self.goal_stack, self.hypotheses)
        copied_state.schematic_vars = self.schematic_vars.copy()
        copied_state.schematic_var_assignment = self.schematic_var_assignment.copy()
        copied_state.proof_stack = self.proof_stack.copy()
        copied_state.applied_tactics = self.applied_tactics.copy()
        return copied_state

    def sanitize_goal_statement(self, goal: StructuredStatement) -> StructuredStatement:
        copied = CopyVisitor().visit(goal)
        copied.statement_type = "?"
        copied.label = None
        copied.proof = None
        return copied

    def get_next_schematic_variable(self, typecode: str) -> SchematicVariable:
        var = SchematicVariable(typecode, len(self.schematic_vars))
        self.schematic_vars.append(var)
        return var

    def get_nth_schematic_variable(self, num: int) -> SchematicVariable:
        return self.schematic_vars[num]

    def get_schematic_variable_from_name(self, name: str) -> Optional[SchematicVariable]:
        if name.startswith("$"):
            return self.get_nth_schematic_variable(int(name[1:]))
        else:
            return None

    def assign_schematic_variable(self, svar: SchematicVariable, term: Term):
        assert svar.num < len(self.schematic_vars)
        if svar.num in self.schematic_var_assignment:
            assert self.schematic_var_assignment[svar.num] == term, \
                   f"both {self.schematic_var_assignment[svar.num]} and {term} are assigned to the schematic variable {svar}"
        else:
            self.schematic_var_assignment[svar.num] = term

    """
    A schematic variable is live if it appears in one of the goals
    """
    def get_live_schematic_variables(self) -> Set[str]:
        live_vars = set()
        for goal in self.goal_stack:
            live_vars.update(goal.get_metavariables())
        return live_vars

    """
    (Recursively) resolve to the actual concrete term assigned to it
    NOTE: by concrete I mean a term without schematic variables
    """
    def resolve_schematic_variables(self, term: Term) -> Term:
        if isinstance(term, SchematicVariable):
            assert term.num in self.schematic_var_assignment, f"schematic variable {term.name} has not been assigned"
            return self.resolve_schematic_variables(self.schematic_var_assignment[term.num])

        metavars = term.get_metavariables()
        schematic_substitution = {}

        for metavar in metavars:
            svar = self.get_schematic_variable_from_name(metavar)
            
            if svar is not None:
                # recursively resolve this
                # TODO: check if this is possible to recursively depend on itself
                subterm = self.resolve_schematic_variables(svar)
                schematic_substitution[svar.name] = subterm

        return SubstitutionVisitor(schematic_substitution).visit(term)

    """
    Check if the given term has any schematic variables
    """
    def is_concrete(self, term: Term) -> bool:
        metavars = term.get_metavariables()
        for metavar in metavars:
            if self.get_schematic_variable_from_name(metavar) is not None:
                return False
        return True

    """
    Apply the given tactic on a copied state and return
    """
    def apply_tactic(self, tactic: Tactic) -> ProofState:
        copied = self.copy()
        tactic.apply(copied)
        copied.applied_tactics.append(tactic)
        return copied

    def gen_proof(self) -> Proof:
        assert not self.goal_stack, "non empty goal stack"

        self.proof_stack = []

        for tactic in self.applied_tactics[::-1]:
            tactic.resolve(self)

        assert len(self.proof_stack) == 1, "proof stack should contain exactly one proof"

        return self.proof_stack[0]
