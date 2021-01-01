from __future__ import annotations

from typing import List, Optional, Mapping, NewType, Set, Callable, Tuple

from proof.metamath.ast import StructuredStatement, Metavariable, Term, MetamathVisitor
from proof.metamath.composer import Composer, Proof, Theorem

from .extension import SchematicVariable, SubstitutionVisitor, CopyVisitor


"""
Tactic should raise this exception when there
is no change in the proof state
"""
class NoStateChangeException(Exception): pass


"""
A goal is a tuple (id, statement, [claim label])
All dependencies between goals
are recorded in ProofState so that
we can copy states more easily
"""
class Goal:
    def __init__(self, goal_id: int, statement: StructuredStatement, claim_label: Optional[str]=None):
        self.statement = Goal.sanitize_goal_statement(statement, claim_label)
        self.goal_id = goal_id
        self.claim_label = claim_label

    def copy(self) -> Goal:
        return Goal(self.goal_id, self.statement, self.claim_label)

    @staticmethod
    def sanitize_goal_statement(statement: StructuredStatement, claim_label: Optional[str]=None) -> StructuredStatement:
        copied = CopyVisitor().visit(statement)
        copied.statement_type = "?"
        copied.label = None if claim_label is None else f"[{claim_label}]"
        copied.proof = None
        return copied


class ProofState:
    all_tactics = {}

    @staticmethod
    def register_tactic(name: str):
        def decorator(class_object):
            ProofState.all_tactics[name] = class_object
            return class_object
        return decorator

    def get_tactic(self, name: str):
        assert name in ProofState.all_tactics, f"tactic {name} not found"
        return ProofState.all_tactics[name]

    def __init__(self, composer: Composer, init_goal: StructuredStatement):
        self.composer = composer

        # set of schematic variables
        self.schematic_vars = []
        self.schematic_var_assignment = {} # num -> term

        self.claims = {} # claim label -> (theorem, associated goal id)

        # the graph of dependencies of goals
        # it should ideally be a DAG
        # (not necessarily a tree since we may
        # have claims being used by multiple goals)
        self.all_goals = [ Goal(0, init_goal) ]
        self.current_goals = [ 0 ]
        self.goal_dependencies = {} # goal id -> List[goal id]
        self.goal_resolver = {} # goal id -> Tactic that resolved the goal

    def copy(self) -> ProofState:
        copied_state = ProofState(self.composer, self.get_goal_by_id(0).statement)
        copied_state.schematic_vars = self.schematic_vars.copy()
        copied_state.schematic_var_assignment = self.schematic_var_assignment.copy()
        
        copied_state.claims = self.claims.copy()

        copied_state.all_goals = self.all_goals.copy()
        copied_state.current_goals = self.current_goals.copy()
        copied_state.goal_dependencies = { goal_id: deps.copy() for goal_id, deps in self.goal_dependencies.items() }
        copied_state.goal_resolver = self.goal_resolver.copy()
        
        return copied_state

    """
    Find an essential usable by the current goal
    NOTE: a goal is needed because inline claims may
    have different essentials than the main goal
    """
    def find_essential_for_goal(self, name: str, goal: Goal) -> Optional[Theorem]:
        if goal.claim_label is not None:
            theorem, _ = self.find_claim(goal.claim_label)
            for essential in theorem.essentials:
                if essential.label == name:
                    return Theorem(self.composer, essential, [], [])
        else:
            return self.composer.find_essential(name)

    def get_all_essentials_for_current_top_goal(self) -> List[Theorem]:
        top_goal = self.get_current_top_goal()
        if top_goal.claim_label is not None:
            theorem, _ = self.find_claim(top_goal.claim_label)
            return [ Theorem(self.composer, essential, [], []) for essential in theorem.essentials ]
        else:
            return self.composer.get_all_essentials()

    def add_goal_dependency(self, parent: Goal, child: Goal):
        if parent.goal_id not in self.goal_dependencies:
            self.goal_dependencies[parent.goal_id] = []
        self.goal_dependencies[parent.goal_id].append(child.goal_id)
        assert not self.has_dependency_cycle_from(parent), f"depdendency cycle detected from goal {parent.statement}"

    def get_goal_dependencies(self, goal: Goal) -> List[Goal]:
        if goal.goal_id not in self.goal_dependencies:
            return []
        return [ self.get_goal_by_id(dep) for dep in self.goal_dependencies[goal.goal_id] ]

    """
    Check if there is a dependency cycle from the given goal
    """
    def has_dependency_cycle_from(self, root: Goal) -> bool:
        reachable_goals = set()

        stack = self.get_goal_dependencies(root)
        while stack:
            goal = stack.pop()

            if goal.goal_id == root.goal_id:
                # found a non-empty path from root to root
                return True

            if goal.goal_id not in reachable_goals:
                reachable_goals.add(goal.goal_id)
                stack += self.get_goal_dependencies(goal)

        return False

    def get_goal_by_id(self, goal_id: int) -> Goal:
        return self.all_goals[goal_id]

    def get_current_top_goal(self) -> Goal:
        assert len(self.current_goals), "no goals left"
        return self.get_goal_by_id(self.current_goals[-1])

    """
    Get the current list of goals from top to bottom
    """
    def get_current_goal_statements(self) -> List[StructuredStatement]:
        return [ self.get_goal_by_id(goal_id).statement for goal_id in self.current_goals ][::-1]

    def resolve_current_goal(self, tactic) -> Goal:
        assert len(self.current_goals), "no goals left"
        resolved_goal_id = self.current_goals.pop()
        self.goal_resolver[resolved_goal_id] = tactic
        return self.get_goal_by_id(resolved_goal_id)

    def add_claim(self, theorem: Theorem) -> Goal:
        goal = self.push_isolated_goal(theorem.statement, theorem.statement.label)
        self.claims[theorem.statement.label] = theorem, goal.goal_id
        return goal

    def find_claim(self, name: str) -> Optional[Tuple[Theorem, Goal]]:
        if name not in self.claims:
            return None
        theorem, goal_id = self.claims[name]
        return theorem, self.get_goal_by_id(goal_id)

    def get_all_claims(self) -> List[Theorem]:
        return [ theorem for theorem, _ in self.claims.values() ]

    """
    Push a goal with no initial dependency (similar to the initial goal)
    and optionally associate it with a claim label
    """
    def push_isolated_goals(self, statements: List[StructuredStatement], claim_label: Optional[str]=None) -> List[Goal]:
        new_goals = [ Goal(len(self.all_goals) + i, statement, claim_label) for i, statement in enumerate(statements) ]
        self.all_goals += new_goals

        # current goals are reversed because the first one should be resolved the first
        self.current_goals += [ goal.goal_id for goal in new_goals[::-1] ]
        
        return new_goals

    def push_isolated_goal(self, statement: StructuredStatement, claim_label: Optional[str]=None) -> Goal:
        return self.push_isolated_goals([ statement ], claim_label)[0]

    def push_derived_goals(self, parent: Goal, statements: List[StructuredStatement]):
        new_goals = self.push_isolated_goals(statements, parent.claim_label)
        for goal in new_goals:
            self.add_goal_dependency(parent, goal)

    def push_derived_goal(self, parent: Goal, statement: StructuredStatement):
        self.push_derived_goals(parent, [ statement ])

    """
    Apply some transformation on all current goals
    """
    def transform_all_current_goals(self, transformation: Callable[StructuredStatement, StructuredStatement]):
        for goal_id in self.current_goals:
            goal = self.all_goals[goal_id] = self.all_goals[goal_id].copy()
            goal.statement = transformation(goal.statement)

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
        for goal_id in self.current_goals:
            live_vars.update(self.get_goal_by_id(goal_id).statement.get_metavariables())
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
    Apply the given tactic on a copied state
    """
    def apply_tactic(self, tactic, *args, **kwargs) -> ProofState:
        copied = self.copy()
        tactic.apply(copied, *args, **kwargs)
        return copied

    """
    Generate a proof for the given goal by tracing
    through the DAG and obtaining subproofs
    """
    def gen_proof_for_goal(self, goal: Goal, trace: List[int]=[]) -> Proof:
        assert goal.goal_id not in trace, f"proof of goal {goal.statement} depends on itself"

        subproofs = [ self.gen_proof_for_goal(dep, trace + [ goal.goal_id ]) for dep in self.get_goal_dependencies(goal) ]
        assert goal.goal_id in self.goal_resolver, "goal not resolved yet"
        tactic = self.goal_resolver[goal.goal_id]

        return tactic.resolve(self, subproofs)

    """
    Generate the proof for the initial goal
    """
    def gen_proof(self) -> Proof:
        assert not self.current_goals, "non empty goal stack"
        init_goal = self.get_goal_by_id(0)
        return self.gen_proof_for_goal(init_goal)
