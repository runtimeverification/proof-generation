"""
Some auto tactics
"""

from typing import Optional, Tuple, List

from proof.metamath.ast import Application, Term, Metavariable, StructuredStatement, Statement
from proof.metamath.composer import Proof, Theorem

from proof.metamath.auto.unification import Unification
from proof.metamath.auto.equality import EqualityProver

from .state import ProofState
from .tactics import Tactic, ApplyTactic
from .extension import SubstitutionVisitor, SchematicVariable


"""
Search for claim most "similar" to the current goal,
where the similarity is measured by the inverse of the sum of
the sizes of terms in every non-trivial substitution pair.

By non-trivial substitution pair I mean a pair
x |-> t in the substitution where x is a schematic variable
and t is NOT a schematic variable.

And by size I mean the number of applications in the term
"""
@ProofState.register_tactic("search")
class SearchTactic(Tactic):
    @staticmethod
    def get_size_of_term(term: Term) -> int:
        if isinstance(term, Metavariable):
            return 0
        assert isinstance(term, Application)
        
        size = 1
        for subterm in term.subterms:
            size += SearchTactic.get_size_of_term(subterm)

        return size

    @staticmethod
    def get_typecode_of_metavariable(state: ProofState, var: Metavariable) -> Optional[str]:
        if isinstance(var, SchematicVariable):
            return var.typecode
        return state.composer.find_metavariable(var.name)

    def apply(self, state: ProofState):
        assert len(state.goal_stack), "no goals left"
        goal = state.goal_stack[-1]
        found = []

        for name, theorem in state.composer.theorems.items():
            equations = Unification.match_statements(goal, theorem.statement)
            if equations is None: continue

            failed = False
            for left, right in equations:
                # we don't allow substituting for a preexistent metavariable
                if isinstance(left, Metavariable) and \
                   not isinstance(left, SchematicVariable) and \
                   not isinstance(right, Metavariable):
                    failed = True
                    break
            if failed: continue

            distance = 0

            for left, right in equations:
                if isinstance(left, Metavariable) and isinstance(right, Metavariable):
                    # if the typecode are the same then distance is 0, otherwise 1
                    t1 = SearchTactic.get_typecode_of_metavariable(state, left)
                    t2 = SearchTactic.get_typecode_of_metavariable(state, right)
                    if t1 != t2: distance += 1
                else:
                    distance += SearchTactic.get_size_of_term(left) + SearchTactic.get_size_of_term(right)

            found.append((distance, name, theorem))

        found.sort(key=lambda t: t[0])

        print("theorem(s) found (from most relevant to least relevant):")
        for distance, name, theorem in found:
            print(f"{name} ({distance}): {state.sanitize_goal_statement(theorem.statement)}")

    def resolve(self, state: ProofState): pass


"""
Automatically prove equality of terms
modulo the definition relation #Equal
"""
@ProofState.register_tactic("equality")
class EqualityTactic(Tactic):
    def apply(self, state: ProofState):
        goal = state.goal_stack.pop()
        assert len(goal.terms) == 3 and goal.terms[0] == Application(EqualityProver.SYMBOL), f"goal {goal} is not an equality claim"
        
        _, left, right = goal.terms

        assert state.is_concrete(left), f"LHS {left} is not concrete"
        assert state.is_concrete(right), f"RHS {right} is not concrete"

        self.proof = EqualityProver.prove_equality(state.composer, left, right)

    def resolve(self, state: ProofState):
        state.proof_stack.append(self.proof)


"""
Expand all syntax sugar defined using #Equal
in the current goal
"""
@ProofState.register_tactic("desugar")
@ProofState.register_tactic("desugar-all")
class DesugarTactic(Tactic):
    def apply(self, state: ProofState, target_symbol: Optional[str]=None):
        goal = state.goal_stack.pop()
        assert len(goal.terms) >= 1, f"ill-formed goal {goal}"

        typecode = goal.terms[0]

        if typecode == Application("|-"):
            # definition preseves provability
            assert len(goal.terms) == 2, f"ill-formed provability claim {goal}"
            _, term = goal.terms

            assert state.is_concrete(term), f"term {term} is not concrete"

            expanded = EqualityProver.expand_sugar(
                state.composer, term, 
                target_symbol=target_symbol,
                desugar_all=self.tactic_name == "desugar-all",
            )
            self.equality_proofs = [ EqualityProver.prove_equality(state.composer, term, expanded) ]
            self.theorem = state.composer.theorems["equal-proof"]

            state.goal_stack.append(state.sanitize_goal_statement(StructuredStatement("p", [
                typecode, expanded,
            ])))
        elif typecode == Application("#Fresh"):
            # definition preserves freshness
            assert len(goal.terms) == 3, f"ill-formed #Fresh claim {goal}"
            _, var, term = goal.terms

            assert state.is_concrete(term), f"term {term} is not concrete"

            expanded = EqualityProver.expand_sugar(
                state.composer, term, 
                target_symbol=target_symbol,
                desugar_all=self.tactic_name == "desugar-all",
            )
            self.equality_proofs = [ EqualityProver.prove_equality(state.composer, term, expanded) ]
            self.theorem = self.theorem = state.composer.theorems["equal-fresh"]

            state.goal_stack.append(state.sanitize_goal_statement(StructuredStatement("p", [
                typecode, var, expanded,
            ])))
        elif typecode == Application("#Substitution"):
            assert len(goal.terms) == 5, f"ill-formed #Substitution claim {goal}"
            _, t1, t2, t3, var = goal.terms

            assert state.is_concrete(t1), f"term {t1} is not concrete"
            assert state.is_concrete(t2), f"term {t2} is not concrete"
            assert state.is_concrete(t3), f"term {t3} is not concrete"
            
            expanded_terms = [
                EqualityProver.expand_sugar(
                    state.composer, term, 
                    target_symbol=target_symbol,
                    desugar_all=self.tactic_name == "desugar-all",
                )
                for term in (t1, t2, t3)
            ]

            self.equality_proofs = [
                EqualityProver.prove_equality(state.composer, term, expanded)
                for term, expanded in zip((t1, t2, t3), expanded_terms)
            ]
            self.theorem = state.composer.theorems["equal-substitution"]

            state.goal_stack.append(state.sanitize_goal_statement(StructuredStatement("p", [
                typecode, *expanded_terms, var,
            ])))
        else:
            assert False, f"unsupported goal {goal} for desugaring"

    def resolve(self, state: ProofState):
        desugared_proof = state.proof_stack.pop()
        state.proof_stack.append(self.theorem.apply(
            desugared_proof,
            *self.equality_proofs,
        ))
