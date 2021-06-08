from __future__ import annotations

from typing import (
    List,
    Optional,
    Mapping,
    NewType,
    Set,
    Callable,
    Tuple,
    Any,
    Dict,
    Union,
    NamedTuple,
    Type,
    TypeVar,
    Iterable,
)
from abc import abstractmethod

from ml.metamath.ast import StructuredStatement, Metavariable, Term, Terms, ProvableStatement, Application
from ml.metamath.composer import Composer, Theorem, Context, Proof, TheoremContext
from ml.metamath.parser import (
    parse_term_with_metavariables,
    parse_terms_with_metavariables,
)
from ml.metamath.auto.notation import NotationProver
from ml.metamath.auto.unification import Unification
from ml.metamath.auto.typecode import TypecodeProver

from .extension import SchematicVariable

StmtT = TypeVar("StmtT", bound=StructuredStatement)


class NoStateChangeException(Exception):
    """
    Tactic should raise this exception when there
    is no change in the proof state
    """
    pass


class Goal:
    """
    A goal is a tuple (id, statement, [claim label])
    All dependencies between goals
    are recorded in ProofState so that
    we can copy states more easily
    """
    def __init__(
        self,
        goal_id: int,
        statement: StructuredStatement,
        claim_label: Optional[str] = None,
    ):
        self.statement = Goal.sanitize_goal_statement(statement, claim_label)
        self.goal_id = goal_id
        self.claim_label = claim_label

    def copy(self) -> Goal:
        return Goal(self.goal_id, self.statement, self.claim_label)

    @staticmethod
    def sanitize_goal_statement(statement: StructuredStatement, claim_label: Optional[str] = None) -> ProvableStatement:
        label = "" if claim_label is None else f"[{claim_label}]"
        return ProvableStatement(label, statement.terms)


class Claim:
    """
    Claim is a theorem built during a proof
    It can be of two types:
     - a global claim acts like a new theorem that is put on the topmost level
       and does not share any metavariable with the current goal.

     - a local claim shares all mandatory hypotheses of the current goal
       and cannot have hypotheses itself.
    """
    def __init__(self, goal_id: int, theorem: Theorem, is_local: bool = False, scope: Optional[str] = None):
        self.goal_id = goal_id
        self.theorem = theorem
        self.is_local = is_local
        self.scope = scope

        if not self.is_local:
            assert scope is None

    def copy(self) -> Claim:
        return Claim(self.goal_id, self.theorem, self.is_local, self.scope)


class TacticRecord(NamedTuple):
    tactic_cls: Type[Tactic]
    help_message: Optional[str] = None


class ProofState:
    all_tactics: Dict[str, TacticRecord] = {}  # name -> ( tactic class name, [help message] )

    @staticmethod
    def register_tactic(name: str, help_msg: Optional[str] = None) -> Callable[[Type[Tactic]], Type[Tactic]]:
        def decorator(class_object: Type[Tactic]) -> Type[Tactic]:
            ProofState.all_tactics[name] = TacticRecord(class_object, help_msg)
            return class_object

        return decorator

    def get_tactic(self, name: str) -> Type[Tactic]:
        assert name in ProofState.all_tactics, f"tactic {name} not found"
        return ProofState.all_tactics[name].tactic_cls

    def __init__(self, composer: Composer, init_goal: StructuredStatement):
        self.composer = composer

        # set of schematic variables
        self.schematic_vars: List[SchematicVariable] = []
        self.schematic_var_assignment: Dict[int, Term] = {}  # num -> term

        # scope restricts what hypotheses to show
        self.claims: Dict[str, Claim] = {}  # claim label -> claim object

        # the graph of dependencies of goals
        # it should ideally be a DAG
        # (not necessarily a tree since we may
        # have claims being used by multiple goals)
        self.all_goals = [Goal(0, init_goal)]
        self.current_goals = [0]
        # goal id -> List[goal id]
        self.goal_dependencies: Dict[int, List[int]] = {}
        self.goal_resolver: Dict[int, Tactic] = {}  # goal id -> Tactic that resolved the goal

    def copy(self) -> ProofState:
        copied_state = ProofState(self.composer, self.get_goal_by_id(0).statement)
        copied_state.schematic_vars = self.schematic_vars.copy()
        copied_state.schematic_var_assignment = self.schematic_var_assignment.copy()

        copied_state.claims = self.claims.copy()

        copied_state.all_goals = self.all_goals.copy()
        copied_state.current_goals = self.current_goals.copy()
        copied_state.goal_dependencies = {goal_id: deps.copy() for goal_id, deps in self.goal_dependencies.items()}
        copied_state.goal_resolver = self.goal_resolver.copy()

        return copied_state

    def find_essential_for_goal(self, name: str, goal: Goal) -> Optional[Theorem]:
        """
        Find an essential usable by the current goal
        NOTE: a goal is needed because inline claims may
        have different essentials than the main goal
        """

        if goal.claim_label is not None:
            claim = self.claims[goal.claim_label]
            for essential in claim.theorem.context.essentials:
                if essential.label == name:
                    return Theorem(self.composer, essential)
            return None
        else:
            return self.composer.find_essential(name)

    def get_all_essentials_for_top_goal(self) -> List[Theorem]:
        top_goal = self.get_top_goal()
        if top_goal.claim_label is not None:
            claim = self.claims[top_goal.claim_label]
            return [Theorem(self.composer, essential) for essential in claim.theorem.context.essentials]
        else:
            return self.composer.get_all_essentials()

    def add_goal_dependency(self, parent: Goal, child: Goal) -> None:
        if parent.goal_id not in self.goal_dependencies:
            self.goal_dependencies[parent.goal_id] = []

        self.goal_dependencies[parent.goal_id].append(child.goal_id)
        assert not self.has_dependency_cycle_from(parent), f"depdendency cycle detected from goal {parent.statement}"

    def get_goal_dependencies(self, goal: Goal) -> List[Goal]:
        if goal.goal_id not in self.goal_dependencies:
            return []
        return [self.get_goal_by_id(dep) for dep in self.goal_dependencies[goal.goal_id]]

    def has_dependency_cycle_from(self, root: Goal) -> bool:
        """
        Check if there is a dependency cycle from the given goal
        """

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

    def get_top_goal(self) -> Goal:
        assert len(self.current_goals), "no goals left"
        return self.get_goal_by_id(self.current_goals[-1])

    def get_current_goal_statements(self) -> List[ProvableStatement]:
        """
        Get the current list of goals from top to bottom
        """
        return [self.get_goal_by_id(goal_id).statement for goal_id in self.current_goals][::-1]

    def get_current_scope(self) -> Optional[str]:
        """
        If the top goal is a claim, return its label
        otherwise return None
        """
        if len(self.current_goals) == 0: return None
        return self.get_top_goal().claim_label

    def resolve_top_goal(self, tactic: Tactic) -> Goal:
        assert len(self.current_goals), "no goals left"
        resolved_goal_id = self.current_goals.pop()
        self.goal_resolver[resolved_goal_id] = tactic
        return self.get_goal_by_id(resolved_goal_id)

    def add_claim(self, theorem: Theorem, is_local: bool = False) -> Goal:
        assert theorem.statement.label is not None
        top_claim_label = self.get_current_scope()
        goal = self.push_isolated_goal(theorem.statement, theorem.statement.label)
        self.claims[theorem.statement.label
                    ] = Claim(goal.goal_id, theorem, is_local, top_claim_label if is_local else None)
        return goal

    def find_claim(self, name: str) -> Optional[Claim]:
        """
        Find a claim with the given name in the current scope
        """

        claim = self.claims.get(name)

        # if the claim is local, filter it out if we
        # are not in the correct claim environment
        if claim is not None and claim.is_local and claim.scope != self.get_current_scope():
            return None

        return claim

    def get_all_global_claims(self) -> List[Claim]:
        return [claim for claim in self.claims.values() if not claim.is_local]

    def get_all_local_claims(self) -> List[Claim]:
        return [claim for claim in self.claims.values() if claim.is_local and claim.scope == self.get_current_scope()]

    def push_isolated_goals(self,
                            statements: Iterable[StructuredStatement],
                            claim_label: Optional[str] = None) -> List[Goal]:
        """
        Push a goal with no initial dependency (similar to the initial goal)
        and optionally associate it with a claim label
        """
        new_goals = [Goal(len(self.all_goals) + i, statement, claim_label) for i, statement in enumerate(statements)]
        self.all_goals += new_goals

        # current goals are reversed because the first one should be resolved the first
        self.current_goals += [goal.goal_id for goal in new_goals[::-1]]

        return new_goals

    def push_isolated_goal(self, statement: StructuredStatement, claim_label: Optional[str] = None) -> Goal:
        return self.push_isolated_goals([statement], claim_label)[0]

    def push_derived_goals(self, parent: Goal, statements: Iterable[StructuredStatement]) -> None:
        new_goals = self.push_isolated_goals(statements, parent.claim_label)
        for goal in new_goals:
            self.add_goal_dependency(parent, goal)

    def push_derived_goal(self, parent: Goal, statement: StructuredStatement) -> None:
        self.push_derived_goals(parent, [statement])

    def get_next_schematic_variable(self, typecode: str) -> SchematicVariable:
        num = len(self.schematic_vars)
        var = SchematicVariable(f"${num}", typecode, num)
        self.schematic_vars.append(var)
        return var

    def get_nth_schematic_variable(self, num: int) -> SchematicVariable:
        return self.schematic_vars[num]

    def get_schematic_variable_from_name(self, name: str) -> Optional[SchematicVariable]:
        if name.startswith("$"):
            return self.get_nth_schematic_variable(int(name[1:]))
        else:
            return None

    def assign_schematic_variables(self, subst: Mapping[str, Term]) -> None:
        # check validity of the substitution
        for var, term in subst.items():
            svar = self.get_schematic_variable_from_name(var)
            assert svar is not None, f"{var} is not a schematic variable"
            assert svar.num < len(self.schematic_vars)

            if svar.num in self.schematic_var_assignment:
                assert (
                    self.schematic_var_assignment[svar.num] == term
                ), f"both {self.schematic_var_assignment[svar.num]} and {term} are assigned to the schematic variable {svar}"
            else:
                self.schematic_var_assignment[svar.num] = term

        # substitute the variables in all goals
        for goal_id in self.current_goals:
            goal = self.all_goals[goal_id] = self.all_goals[goal_id].copy()
            goal.statement = goal.statement.substitute(subst)

        # substitute the variables in all claims
        for name in self.claims:
            claim = self.claims[name] = self.claims[name].copy()
            claim.theorem.statement = claim.theorem.statement.substitute(subst)

    def get_live_schematic_variables(self) -> Set[str]:
        """
        A schematic variable is live if it appears in one of the goals
        """
        live_vars = set()
        for goal_id in self.current_goals:
            live_vars.update(self.get_goal_by_id(goal_id).statement.get_metavariables())
        return live_vars

    def resolve_schematic_variables(self, term: Term) -> Term:
        """
        (Recursively) resolve to the actual concrete term assigned to it
        NOTE: by concrete I mean a term without schematic variables
        """

        if isinstance(term, SchematicVariable):
            assert (term.num in self.schematic_var_assignment), f"schematic variable {term.name} has not been assigned"
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

        return term.substitute(schematic_substitution)

    def resolve_schematic_variables_in_statement(self, stmt: StmtT) -> StmtT:
        return type(stmt)(stmt.label, tuple(self.resolve_schematic_variables(term) for term in stmt.terms))

    def is_concrete(self, term: Union[Term, StructuredStatement]) -> bool:
        """
        Check if the given term has any schematic variables
        """
        metavars = term.get_metavariables()
        for metavar in metavars:
            if self.get_schematic_variable_from_name(metavar) is not None:
                return False
        return True

    def apply_tactic(self, tactic: Tactic, *args: Any, **kwargs: Any) -> ProofState:
        """
        Apply the given tactic on a copied state
        """
        copied = self.copy()
        tactic.apply(copied, *args, **kwargs)
        return copied

    def gen_proof_for_goal(self, goal: Goal, trace: List[int] = []) -> Proof:
        """
        Generate a proof for the given goal by tracing
        through the DAG and obtaining subproofs
        """
        assert (goal.goal_id not in trace), f"proof of goal {goal.statement} depends on itself"

        subproofs = [self.gen_proof_for_goal(dep, trace + [goal.goal_id]) for dep in self.get_goal_dependencies(goal)]
        assert goal.goal_id in self.goal_resolver, "goal not resolved yet"
        tactic = self.goal_resolver[goal.goal_id]

        return tactic.resolve(self, subproofs)

    def gen_proof(self) -> Proof:
        """
        Generate the proof for the initial goal
        """
        assert not self.current_goals, "non empty goal stack"
        init_goal = self.get_goal_by_id(0)
        return self.gen_proof_for_goal(init_goal)


class Tactic:
    def __init__(self, tactic_name: str):
        self.tactic_name = tactic_name

    @abstractmethod
    def apply(self, state: ProofState, *args: str, **kwargs: str) -> None:
        """
        Transforms the proof state
        """
        raise NotImplementedError()

    def resolve(self, state: ProofState, subproofs: List[Proof]) -> Proof:
        """
        Transforms the proof stack
        """
        raise NotImplementedError()

    def parse_terms(self, state: ProofState, src: str) -> Terms:
        return parse_terms_with_metavariables(src, set(state.composer.get_all_metavariables()))

    def parse_substitution(self, state: ProofState, options: Mapping[str, str]) -> Dict[str, Term]:
        substitution = {}
        all_metavars = set(state.composer.get_all_metavariables())

        for key, value in options.items():
            assert type(value) is str
            substitution[key] = parse_term_with_metavariables(value, all_metavars)

        return substitution

    @staticmethod
    def typcode_extension(state: ProofState, typecode: str, term: Term) -> bool:
        if isinstance(term, SchematicVariable):
            var, *_ = state.composer.find_metavariables_of_typecode(term.typecode)
            return TypecodeProver.check_typecode(state.composer, typecode, Metavariable(var))
        return False

    @staticmethod
    def check_schematic_substitution(state: ProofState, substitution: Mapping[str, Term]) -> bool:
        for var, term in substitution.items():
            svar = state.get_schematic_variable_from_name(var)
            assert svar is not None, f"missing schematic variable {svar}"
            if not TypecodeProver.check_typecode(
                    state.composer,
                    svar.typecode,
                    term,
                    extension=lambda typecode, term: Tactic.typcode_extension(state, typecode, term),
            ):
                if svar.typecode == "#Pattern" and isinstance(term, Application):
                    continue
                return False
        return True

    @staticmethod
    def unify(state: ProofState,
              equations: List[Tuple[Term, Term]],
              only_schematic_vars: bool = True) -> Optional[Tuple[Mapping[str, Term], bool]]:
        """
        Unify two statements modulo notations
        return Optional[( substitution, if notation is applied )]

        only_schematic_vars = True means that we only consider
        schematic variables as variables

        otherwise the unification will use all metavariables (including schematic variables)
        """

        applied_notation = False

        def unify_modulo_notation(state: ProofState, left: Term, right: Term) -> Optional[List[Tuple[Term, Term]]]:
            """
            Additional unification rules
            if the heads of left and right are different,
            try to apply notation axiom to one of them
            """

            nonlocal applied_notation

            if not isinstance(left, Application) or \
               not isinstance(right, Application):
                return None

            result = NotationProver.rewrite_to_same_head_symbol(state.composer, left, right, with_proof=False)
            if result is None:
                return None
            _, left, _, right = result

            assert left.symbol == right.symbol, f"{left} != {right}"
            applied_notation = True

            return [(left, right)]

        subst = Unification.unify(
            equations,
            variable_class=SchematicVariable if only_schematic_vars else Metavariable,
            # newer schematic variable are used as substitution variables
            # with higher priority than older schematic variables
            variable_order=(lambda v1, v2: v1 > v2) if only_schematic_vars else (lambda v1, v2: True),
            # add extra unification algorithm for notations
            additional_unifier=lambda t1, t2: unify_modulo_notation(state, t1, t2),
        )

        if subst is not None:
            if not Tactic.check_schematic_substitution(state, subst):
                return None
            return subst, applied_notation

        return None

    @staticmethod
    def unify_statements(
        state: ProofState, left: StructuredStatement, right: StructuredStatement, *args: Any, **kwargs: Any
    ) -> Optional[Tuple[Mapping[str, Term], bool]]:
        if len(left.terms) != len(right.terms):
            return None
        return Tactic.unify(state, list(zip(left.terms, right.terms)), *args, **kwargs)
