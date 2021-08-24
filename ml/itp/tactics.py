from typing import Mapping, Optional, List, Tuple, Dict, Any, Callable
from dataclasses import dataclass

from ml.metamath.ast import Term, StructuredStatement, Statement, Application, Metavariable, EssentialStatement, ProvableStatement
from ml.metamath.composer import Theorem, Context, Proof, TheoremContext
from ml.metamath.auto.notation import NotationProver
from ml.metamath.auto.typecode import TypecodeProver

from .state import ProofState, Goal, Tactic
from .extension import SchematicVariable


@dataclass
class PreprocessedTheorem:
    essentials: List[ProvableStatement]
    conclusion: StructuredStatement
    schematic_substitution: Dict[str, Term]


@ProofState.register_tactic("apply")
class ApplyTactic(Tactic):
    """
    Apply a theorem on the top of the goal stack
    """
    def __init__(self, *args: Any, **kwargs: Any):
        super().__init__(*args, **kwargs)
        self.use_claim = False
        self.applied_notation = False

    @staticmethod
    def preprocess_theorem(state: ProofState, theorem: Theorem, subst: Dict[str, Term]) -> PreprocessedTheorem:
        """
        Replace all metavariables in the given theorem by fresh
        schematic variables, and return the substituted statement,
        essentials, and the substitution (from original metavariables
        to schematic variables)

        metavar_subst fixes some metavariables beforehand (potentially given by the user)
        """

        # sort the metavariables to making things a bit more deterministic
        metavars = sorted(list(theorem.get_metavariables()))
        new_subst = dict(subst)

        for metavar in new_subst:
            assert metavar in metavars, \
                   f"metavariable {metavar} is not active in theorem {theorem.statement.label}"

        for metavar in metavars:
            if metavar not in new_subst:
                typecode = state.composer.find_metavariable(metavar)
                assert typecode is not None, f"metavariable {metavar} not found"
                new_subst[metavar] = state.get_next_schematic_variable(typecode)

        # substitute in schematic variables
        # and then sanitize format
        transformer: Callable[
            [StructuredStatement],
            ProvableStatement] = lambda stmt: Goal.sanitize_goal_statement(stmt.substitute(new_subst))

        conclusion = transformer(theorem.statement)
        essentials = [transformer(essential) for essential in theorem.context.essentials]

        return PreprocessedTheorem(essentials, conclusion, new_subst)

    def init_theorem(self, state: ProofState, top_goal: Goal, name: str) -> Theorem:
        """
        Find the theorem from three sources:
          - database
          - claim
          - essential
        """
        self.theorem = state.composer.find_theorem(name)
        if self.theorem is not None:
            return self.theorem

        # check if the name points to a claim
        claim = state.find_claim(name)
        if claim is not None:
            self.theorem = claim.theorem
            claim_goal = state.get_goal_by_id(claim.goal_id)
            state.add_goal_dependency(top_goal, claim_goal)
            self.use_claim = True
            return self.theorem

        # check if the name points to an essential
        self.theorem = state.find_essential_for_goal(name, top_goal)
        if self.theorem is not None:
            return self.theorem

        assert False, f"cannot find theorem {name}"

    def apply(self, state: ProofState, *args: str, **options: str) -> None:
        theorem_name, = args

        subst = self.parse_substitution(state, options)

        top_goal = state.get_top_goal()
        top_goal_statement = top_goal.statement

        theorem = self.init_theorem(state, top_goal, theorem_name)

        preprocessed = ApplyTactic.preprocess_theorem(state, theorem, subst)
        theorem_conclusion = preprocessed.conclusion
        essentials = preprocessed.essentials
        self.metavars_substitution = preprocessed.schematic_substitution

        # add all essentials to the goal stack
        state.resolve_top_goal(self)
        state.push_derived_goals(top_goal, essentials)

        # unify the conclusion of the statement with our top goal
        result = Tactic.unify_statements(state, top_goal_statement, theorem_conclusion)
        assert result is not None, f"unable to unify the goal {top_goal_statement} with {theorem_conclusion}"
        schematic_substitution, self.applied_notation = result

        # assign schematic variables
        state.assign_schematic_variables(schematic_substitution)

        # get the final top goal statement
        top_goal_statement = top_goal_statement.substitute(schematic_substitution)
        self.original_goal = top_goal_statement

        # check if any schematic variables are killed before being assigned
        live_svars = state.get_live_schematic_variables()
        killed_svars = top_goal_statement.get_metavariables().difference(live_svars)
        killed_svars = {var for var in killed_svars if state.get_schematic_variable_from_name(var) is not None}
        assert len(killed_svars) == 0, f"schematic variable(s) {killed_svars} killed before being assigned"

    def resolve(self, state: ProofState, subproofs: List[Proof]) -> Proof:
        """
        Construct a proof from given subproofs and the information inferred before
        """
        assert self.theorem is not None

        num_essentials = len(self.theorem.context.essentials)
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

        if self.use_claim:
            # get an inline proof if the reference theorem is an inline claim
            assert len(subproofs) != 0
            proof = self.theorem.inline_apply(
                subproofs[0],
                *subproofs[
                    1:
                ],  # subproofs would include the proof of the claim as the first one since we added the dependency
                **full_substitution,
            )
        else:
            proof = self.theorem.apply(
                *subproofs,
                **full_substitution,
            )

        if self.applied_notation:
            # if we applied any notation
            # make sure we generate a notation proof
            original_concrete_goal = state.resolve_schematic_variables_in_statement(self.original_goal)
            assert state.is_concrete(original_concrete_goal)
            proof = NotationProver.prove_notation_statement(state.composer, original_concrete_goal, proof)

        return proof


@ProofState.register_tactic("let")
class SetSchematicVariableTactic(Tactic):
    """
    Set some schematic variables to concrete terms (without schematic variables)
    """
    def apply(self, state: ProofState, *_: str, **options: str) -> None:
        substitution = self.parse_substitution(state, options)

        # check that we are not substituting dead schematic variables
        live_svars = state.get_live_schematic_variables()
        substituting_svars = set(substitution.keys())
        assert substituting_svars.issubset(
            live_svars
        ), f"assigning dead/nonexistent schematic variable(s) {substituting_svars.difference(live_svars)}"

        state.assign_schematic_variables(substitution)

    def resolve(self, state: ProofState, subproofs: List[Proof]) -> Proof:
        pass


@ProofState.register_tactic("shuffle")
@ProofState.register_tactic("meh")
class ShuffleTactic(Tactic):
    """
    Move the current goal to the last
    """
    def apply(self, state: ProofState, *args: str, **kwargs: str) -> None:
        state.current_goals = [state.current_goals[-1]] + state.current_goals[:-1]

    def resolve(self, state: ProofState, subproofs: List[Proof]) -> Proof:
        pass


@ProofState.register_tactic("claim")
class ClaimTactic(Tactic):
    """
    Make a temporary claim and use it in other parts of the proof
    """
    @staticmethod
    def find_free_theorem_name(state: ProofState, prefix: str) -> str:
        i = 0
        # TODO: well...
        while True:
            name = prefix + str(i)
            if (state.composer.find_theorem(name) is None and state.find_claim(name) is None):
                return name
            i += 1

    def apply(self, state: ProofState, *args: str, **kwargs: str) -> None:
        # the last argument or the single kwarg is the conclusion
        # other positional arguments are hypotheses
        assert len(kwargs) <= 1, "wrong claim format"
        if len(kwargs) == 1:
            label, conclusion_str = list(kwargs.items())[0]
            hypotheses_str = args
        else:
            assert len(args) >= 1, "wrong claim format"
            label = ClaimTactic.find_free_theorem_name(state, "claim-")
            conclusion_str = args[-1]
            hypotheses_str = args[:-1]

        # parse hyotheses and conclusion
        essentials = []
        for i, hypothesis in enumerate(hypotheses_str):
            terms = self.parse_terms(state, hypothesis)
            essential_label = f"{label}.{i}"
            essential = EssentialStatement(essential_label, terms)
            essentials.append(essential)

        terms = self.parse_terms(state, conclusion_str)
        conclusion = ProvableStatement(label, terms)

        # TODO: this should probably stay in metamath.composer?
        # find all related floating statements
        metavariables = conclusion.get_metavariables()
        for essential in essentials:
            metavariables.update(essential.get_metavariables())

        floatings = state.composer.context.find_floatings(metavariables)

        self.claim_theorm = Theorem(state.composer, conclusion, TheoremContext(tuple(floatings), tuple(essentials)))
        self.claim_goal = state.add_claim(self.claim_theorm)

    def resolve(self, state: ProofState, subproofs: List[Proof]) -> Proof:
        # return the proof of the theorem
        return state.gen_proof_for_goal(self.claim_goal)


@ProofState.register_tactic("from")
class FromTactic(Tactic):
    """
    Apply theorem to hypotheses
    """
    def __init__(self, *args: Any, **kwargs: Any):
        super().__init__(*args, **kwargs)
        self.claim_goal: Optional[Goal] = None
        self.applied_notation = False
        self.applied_theorems: List[Optional[Theorem]
                                    ] = []  # None if the hypotheses uses another claim, which will be resolved later

    def init_hypotheses(self, state: ProofState, goal: Goal, names: List[str]) -> List[Theorem]:
        hypotheses = []

        for name in names:
            # try essential first
            top_goal = state.get_top_goal()
            theorem = state.find_essential_for_goal(name, top_goal)
            if theorem is not None:
                self.applied_theorems.append(theorem)
                hypotheses.append(theorem)
                continue

            claim = state.find_claim(name)
            if claim is not None and claim.is_local:
                self.applied_theorems.append(None)
                hypotheses.append(claim.theorem)
                state.add_goal_dependency(goal, state.get_goal_by_id(claim.goal_id))
                continue

            assert False, f"unable to find hypothesis {name}"

        return hypotheses

    def init_theorem(self, state: ProofState, name: str) -> Theorem:
        self.theorem = state.composer.find_theorem(name)
        if self.theorem is not None:
            return self.theorem

        # try to find an inline claim
        if self.theorem is None:
            claim = state.find_claim(name)
            if claim is not None and not claim.is_local:
                self.theorem = claim.theorem
                self.claim_goal = state.get_goal_by_id(claim.goal_id)
                return self.theorem

        assert False, f"unable to find theorem {name}"

    def apply(self, state: ProofState, *args: str, **kwargs: str) -> None:
        assert len(args) >= 1, f"expecting at least one argument"

        hypothesis_names = list(args[:-1])
        theorem_name = args[-1]
        self.metavars_substitution = self.parse_substitution(state, kwargs)

        # find the specified theorem
        theorem = self.init_theorem(state, theorem_name)

        preprocessed = ApplyTactic.preprocess_theorem(state, theorem, self.metavars_substitution)
        theorem_conclusion = self.conclusion = preprocessed.conclusion
        theorem_essentials = preprocessed.essentials
        self.metavars_substitution = preprocessed.schematic_substitution

        # add a local claim
        theorem_conclusion_as_essential = \
            EssentialStatement(ClaimTactic.find_free_theorem_name(state, "hyp-"), theorem_conclusion.terms)
        local_theorem = Theorem(state.composer, theorem_conclusion_as_essential)
        phantom_goal = state.add_claim(local_theorem, is_local=True)
        state.resolve_top_goal(self)  # directly resolve it

        # initialize all hypotheses
        hypotheses = self.init_hypotheses(state, phantom_goal, hypothesis_names)
        assert len(theorem.context.essentials) == len(hypotheses), \
               f"not enough hypotheses is given for theorem {theorem_name}, expecting {len(theorem.context.essentials)}, given {len(hypotheses)}"

        # unify the essentials
        equations = []
        for theorem_essential, hypothesis in zip(theorem_essentials, hypotheses):
            assert len(theorem_essential.terms) == len(hypothesis.statement.terms), \
                   f"unable to unify hypotheses {theorem_essential} and {hypothesis.statement}"
            equations.extend(list(zip(theorem_essential.terms, hypothesis.statement.terms)))

        result = Tactic.unify(state, equations)
        assert result is not None, \
               f"unable to unify the hypotheses {', '.join(hypothesis_names)} with essentials of theorem {theorem_name}"
        schematic_substitution, self.applied_notation = result

        # assign schematic variables
        state.assign_schematic_variables(schematic_substitution)

    def resolve(self, state: ProofState, claim_subproofs: List[Proof]) -> Proof:
        assert self.theorem is not None

        # collect proofs of all hypotheses
        subproofs = []

        for hypothesis in self.applied_theorems:
            if hypothesis is not None:
                subproofs.append(hypothesis.apply())
            else:
                assert len(claim_subproofs) != 0
                subproofs.append(claim_subproofs.pop(0))

        full_substitution = {
            var: state.resolve_schematic_variables(term)
            for var, term in self.metavars_substitution.items()
        }

        return self.theorem.apply(*map(NotationProver.auto, subproofs), **full_substitution)
