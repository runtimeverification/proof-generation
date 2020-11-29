from typing import Mapping

from proof.metamath.ast import Term
from proof.metamath.composer import Theorem
from proof.metamath.visitors import CopyVisitor

from .env import Environment, GoalStack, ProofStack
from .extension import SchematicVariable, SubstitutionVisitor


class Tactic:
    def apply(self, env: Environment, goal_stack: GoalStack) -> GoalStack:
        raise NotImplementedError()

    def resolve(self, env: Environment, proof_stack: ProofStack) -> ProofStack:
        raise NotImplementedError()


"""
Apply a theorem on the top of the goal stack
"""
class ApplyTactic(Tactic):
    def __init__(self, theorem: Theorem, initial_substitution: Mapping[str, Term]={}):
        self.theorem = theorem
        self.metavars_substitution = initial_substitution

    def apply(self, env: Environment, goal_stack: GoalStack) -> GoalStack:
        goal_stack = goal_stack.copy()

        top_goal = goal_stack.pop()
        copied_statement = CopyVisitor().visit(self.theorem.statement)
        copied_statement.label = None
        copied_statement.proof = None

        metavars = copied_statement.get_metavariables()
        for essential in self.theorem.essentials:
            metavars.update(essential.get_metavariables())

        for metavar in metavars:
            if metavar not in self.metavars_substitution:
                typecode = env.composer.find_metavariable(metavar)
                self.metavars_substitution[metavar] = env.get_next_schematic_variable(typecode)

        # replace all metavariables in the applied theorem
        # with distinct schematic variables
        metavars_subst_visitor = SubstitutionVisitor(self.metavars_substitution)
        copied_statement = metavars_subst_visitor.visit(copied_statement)
        essentials = [ metavars_subst_visitor.visit(essential) for essential in self.theorem.essentials ]

        # check that they indeed have disjoint metavariables
        # assert len(top_goal.get_metavariables().intersection(copied_statement.get_metavariables())) == 0

        unification = env.composer.unify_statements(top_goal, copied_statement)
        assert unification is not None, f"unable to unify the goal {top_goal} with {copied_statement}"

        # only consider the substitution of schematic variables
        schematic_substitution = {}

        for left, right in unification:
            if isinstance(right, SchematicVariable):
                left, right = right, left

            if isinstance(left, SchematicVariable):
                assert left.name not in schematic_substitution or \
                       schematic_substitution[left.name] == right, f"unable to unify the goal {top_goal} with {copied_statement}"
                schematic_substitution[left.name] = right

                # hook each schematic variable to its actual substitute
                # so that we can expand them later
                left.assigned = right
            else:
                # we should not replace a metavariable in the goal with a schematic variable
                assert left == right, f"unable to unify the goal {top_goal} with {copied_statement}"

        print("applying", self.theorem.statement.label, copied_statement)

        schematic_subst_visitor = SubstitutionVisitor(schematic_substitution)

        # add all essentials to the goal stack
        essentials = [ schematic_subst_visitor.visit(essential) for essential in essentials ]
        goal_stack += essentials[::-1]

        changed = True

        # apply the substitution until no change is possible
        while changed:
            old_stack = goal_stack.copy()
            goal_stack = [ schematic_subst_visitor.visit(stmt) for stmt in goal_stack ]
            changed = old_stack != goal_stack

        return goal_stack

    """
    Construct a proof from the proof stack and the information inferred before
    """
    def resolve(self, env: Environment, proof_stack: ProofStack) -> ProofStack:
        proof_stack = proof_stack.copy()

        num_essentials = len(self.theorem.essentials)

        assert len(proof_stack) >= num_essentials, \
               f"theorem {self.theorem.statement.label} requires {num_essentials}, but only {len(proof_stack)} are on the proof stack"

        subproofs = []
        for _ in range(len(self.theorem.essentials)):
            subproofs.append(proof_stack.pop())

        # during apply(), we made a substitution from metavariables to schematic variables
        # now we attempt to resolve all the schematic variables to concrete terms (terms
        # without schematic variables)
        full_substitution = {
            var: env.resolve_schematic_variables(term)
            for var, term in self.metavars_substitution.items()
        }

        proof_stack.append(self.theorem.apply(
            *subproofs,
            **full_substitution,
        ))

        return proof_stack
