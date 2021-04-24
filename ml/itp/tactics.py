from typing import Mapping, Optional, List

from ml.metamath.parser import (
    parse_term_with_metavariables,
    parse_terms_with_metavariables,
)
from ml.metamath.ast import Term, StructuredStatement, Statement, Application
from ml.metamath.composer import Theorem, Proof
from ml.metamath.visitors import CopyVisitor

from ml.metamath.auto.unification import Unification

from .state import ProofState, Goal
from .extension import SchematicVariable, SubstitutionVisitor


class Tactic:
    def __init__(self, tactic_name: str):
        self.tactic_name = tactic_name

    # def apply(self, state: ProofState, *args, **kwargs):
    #     """
    #     Transforms the proof state
    #     """
    #     raise NotImplementedError()

    def resolve(self, state: ProofState, subproofs: List[Proof]) -> Proof:
        """
        Transforms the proof stack
        """
        raise NotImplementedError()

    def parse_terms(self, state: ProofState, src: str) -> List[Term]:
        return parse_terms_with_metavariables(src, set(state.composer.get_all_metavariables()))

    def parse_substitution(self, state: ProofState, options: Mapping[str, str]) -> Mapping[str, Term]:
        substitution = {}
        all_metavars = set(state.composer.get_all_metavariables())

        for key, value in options.items():
            assert type(value) is str
            substitution[key] = parse_term_with_metavariables(value, all_metavars)

        return substitution


@ProofState.register_tactic("apply")
class ApplyTactic(Tactic):
    """
    Apply a theorem on the top of the goal stack
    """

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.use_claim = False

    def apply(self, state: ProofState, theorem_name: str, **options):
        substitution = self.parse_substitution(state, options)
        self.metavars_substitution = dict(substitution)

        top_goal = state.resolve_current_goal(self)
        top_goal_statement = top_goal.statement

        self.theorem = state.composer.find_theorem(theorem_name)

        # try to find an inline claim
        if self.theorem is None:
            found = state.find_claim(theorem_name)
            if found is not None:
                self.theorem, claim_goal = found
                self.use_claim = True
                state.add_goal_dependency(top_goal, claim_goal)

        if self.theorem is not None:
            copied_statement = Goal.sanitize_goal_statement(self.theorem.statement)

            metavars = copied_statement.get_metavariables()
            for essential in self.theorem.essentials:
                metavars.update(essential.get_metavariables())

            metavars_sorted = list(metavars)
            metavars_sorted.sort()  # making things a bit more deterministic

            for metavar in metavars_sorted:
                if metavar not in self.metavars_substitution:
                    typecode = state.composer.find_metavariable(metavar)
                    assert typecode is not None, f"metavariable {metavar} not found"
                    self.metavars_substitution[metavar] = state.get_next_schematic_variable(typecode)

            # replace all metavariables in the applied theorem
            # with distinct schematic variables
            metavars_subst_visitor = SubstitutionVisitor(self.metavars_substitution)
            copied_statement = metavars_subst_visitor.visit(copied_statement)

            essentials = [Goal.sanitize_goal_statement(essential) for essential in self.theorem.essentials]
            essentials = [metavars_subst_visitor.visit(essential) for essential in essentials]

        else:
            # try to find a hypotheses
            self.theorem = state.find_essential_for_goal(theorem_name, top_goal)
            assert self.theorem is not None, f"cannot find theorem {theorem_name}"
            copied_statement = self.theorem.statement
            essentials = []

        schematic_substitution = Unification.unify_statements(
            top_goal_statement,
            copied_statement,
            variable_class=SchematicVariable,
            substitution_visitor_class=SubstitutionVisitor,
            # newer schematic variable are used as substitution variables
            # with higher priority than older schematic variables
            variable_order=lambda v1, v2: v1.num > v2.num,
        )
        assert (
            schematic_substitution is not None
        ), f"unable to unify the goal {top_goal_statement} with {copied_statement}"

        for var, term in schematic_substitution.items():
            svar = state.get_schematic_variable_from_name(var)
            assert svar is not None, f"missing schematic variable {svar}"
            state.assign_schematic_variable(svar, term)

        schematic_subst_visitor = SubstitutionVisitor(schematic_substitution)

        # add all essentials to the goal stack
        state.push_derived_goals(top_goal, essentials)

        state.transform_all_current_goals(lambda stmt: schematic_subst_visitor.visit(stmt))

        # check if any schematic variables are killed before being assigned
        top_goal_statement = schematic_subst_visitor.visit(top_goal_statement)
        live_svars = state.get_live_schematic_variables()
        killed_svars = top_goal_statement.get_metavariables().difference(live_svars)
        killed_svars = {var for var in killed_svars if state.get_schematic_variable_from_name(var) is not None}
        assert (not killed_svars), f"schematic variable(s) {killed_svars} killed before being assigned"

    def resolve(self, state: ProofState, subproofs: List[Proof]) -> Proof:
        """
        Construct a proof from given subproofs and the information inferred before
        """

        assert self.theorem is not None

        num_essentials = len(self.theorem.essentials)

        assert (
            len(subproofs) >= num_essentials
        ), f"theorem {self.theorem.statement.label} requires {num_essentials}, but only {len(subproofs)} are provided"

        # during apply(), we made a substitution from metavariables to schematic variables
        # now we attempt to resolve all the schematic variables to concrete terms (terms
        # without schematic variables)
        full_substitution = {
            var: state.resolve_schematic_variables(term)
            for var, term in self.metavars_substitution.items()
        }

        # print(self.theorem.statement.label)

        if self.use_claim:
            # get an inline proof if the reference theorem is an inline claim
            return self.theorem.inline_apply(
                subproofs[0],
                *subproofs[
                    1:
                ],  # subproofs would include the proof of the claim as the first one since we added the dependency
                **full_substitution,
            )
        else:
            return self.theorem.apply(
                subproofs[0],
                *subproofs[1:],
                **full_substitution,
            )


@ProofState.register_tactic("let")
class SetSchematicVariableTactic(Tactic):
    """
    Set some schematic variables to concrete terms (without schematic variables)
    """

    def apply(self, state: ProofState, **options):
        substitution = self.parse_substitution(state, options)

        live_svars = state.get_live_schematic_variables()
        substituting_svars = set(substitution.keys())
        assert substituting_svars.issubset(
            live_svars
        ), f"assigning dead/nonexistent schematic variable(s) {substituting_svars.difference(live_svars)}"

        for var, term in substitution.items():
            assert state.is_concrete(term), f"non-concrete term {term} substituted for schematic variable {var}"

            svar = state.get_schematic_variable_from_name(var)
            assert svar is not None, f"cannot substitute non-schematic variable {var}"

            state.assign_schematic_variable(svar, term)

        subst_visitor = SubstitutionVisitor(substitution)
        state.transform_all_current_goals(lambda stmt: subst_visitor.visit(stmt))

    def resolve(self, state: ProofState, subproofs: List[Proof]) -> Proof:
        pass


@ProofState.register_tactic("meh")
class ShuffleTactic(Tactic):
    """
    Move the current goal to the last
    """

    def apply(self, state: ProofState):
        state.current_goals = [state.current_goals[-1]] + state.current_goals[:-1]

    def resolve(self, state: ProofState, subproofs: List[Proof]) -> Proof:
        pass


@ProofState.register_tactic("claim")
class ClaimTactic(Tactic):
    """
    Make a temporary claim and use it in other parts of the proof
    """
    
    def find_free_theorem_name(self, state: ProofState, prefix: str) -> str:
        i = 0
        # TODO: well...
        while True:
            name = prefix + str(i)
            if (state.composer.find_theorem(name) is None and state.find_claim(name) is None):
                return name
            i += 1

    def apply(self, state: ProofState, *args, **kwargs):
        # the last argument or the single kwarg is the conclusion
        # other positional arguments are hypotheses
        assert len(kwargs) <= 1, "wrong claim format"
        if len(kwargs) == 1:
            label, conclusion = list(kwargs.items())[0]
            hypotheses = args
        else:
            assert len(args) >= 1, "wrong claim format"
            label = self.find_free_theorem_name(state, "claim-")
            conclusion = args[-1]
            hypotheses = args[:-1]

        # parse hyotheses and conclusion
        essentials = []
        for i, hypothesis in enumerate(hypotheses):
            terms = self.parse_terms(state, hypothesis)
            essential_label = f"{label}.{i}"
            essential = StructuredStatement(Statement.ESSENTITAL, terms, label=essential_label)
            essentials.append(essential)

        terms = self.parse_terms(state, conclusion)
        conclusion = StructuredStatement(Statement.PROVABLE, terms, label=label)

        # TODO: this should probably stay in metamath.composer?
        # find all related floating statements
        metavariables = conclusion.get_metavariables()
        for essential in essentials:
            metavariables.update(essential.get_metavariables())

        floatings = state.composer.context.find_floatings(metavariables)

        self.claim_theorm = Theorem(state.composer, conclusion, floatings, essentials)
        self.claim_goal = state.add_claim(self.claim_theorm)

    def resolve(self, state: ProofState, subproofs: List[Proof]) -> Proof:
        # return the proof of the theorem
        return state.gen_proof_for_goal(self.claim_goal)
