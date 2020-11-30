"""
Some auto tactics
"""

from typing import Optional, Tuple, List

from proof.metamath.ast import Application, Term, Metavariable, StructuredStatement, Statement
from proof.metamath.composer import Proof, Theorem

from .state import ProofState
from .tactics import Tactic
from .extension import SubstitutionVisitor


"""
Automatically prove equality of terms
modulo the definition relation #Equal
"""
@ProofState.auto("equality")
class EqualityAutoTactic(Tactic):
    SYMBOL = "#Equal"
    SYM = "equal-symmetry"
    REFL = "equal-reflexivity"
    TRANS = "equal-transitivity"

    def __init__(self):
        self.proof = None

    @staticmethod
    def format_target(left: Term, right: Term) -> StructuredStatement:
        return StructuredStatement(Statement.PROVABLE, [
            Application(EqualityAutoTactic.SYMBOL),
            left, right,
        ])

    """
    A congruence lemma for a symbol S is of the form
    ${
        $e #Equal a a' $.
        $e #Equal b b' $.
        $p #Equal ( S a b c ) ( S a' b' c' ) $.
    $}
    Note that the hypotheses may not contain all immediate child terms
    and the order may be different from the order in the application

    The returned list indicates the order of children
    appearing in the essential hypotheses
    """
    @staticmethod
    def find_congruence_lemma(state: ProofState, symbol: str) -> Optional[Tuple[Theorem, List[int]]]:
        for theorem in state.composer.theorems.values():
            condition = len(theorem.statement.terms) == 3 and \
                        theorem.statement.terms[0] == Application(EqualityAutoTactic.SYMBOL) and \
                        isinstance(theorem.statement.terms[1], Application) and \
                        isinstance(theorem.statement.terms[2], Application) and \
                        theorem.statement.terms[1].symbol == symbol and \
                        theorem.statement.terms[2].symbol == symbol and \
                        len(theorem.statement.terms[1].subterms) == len(theorem.statement.terms[2].subterms)
            if not condition: continue

            failed = False
            order_of_metavars = {} # (metavar pair) -> order in the application

            # check that all children of the applications are metavariables
            for i, (s1, s2) in enumerate(zip(theorem.statement.terms[1].subterms, theorem.statement.terms[2].subterms)):
                if not isinstance(s1, Metavariable) or \
                    not isinstance(s2, Metavariable):
                    failed = True
                    break
                order_of_metavars[s1.name, s2.name] = i
            if failed: continue

            essentials_order = []

            # check that essentials only assumes things about metavariables
            for essential in theorem.essentials:
                condition = len(essential.terms) == 3 and \
                            essential.terms[0] == Application(EqualityAutoTactic.SYMBOL) and \
                            isinstance(essential.terms[1], Metavariable) and \
                            isinstance(essential.terms[2], Metavariable)

                pair = essential.terms[1].name, essential.terms[2].name
                if pair not in order_of_metavars:
                    failed = True
                    break

                essentials_order.append(order_of_metavars[pair])
            if failed: continue

            return theorem, essentials_order

        return None

    """
    A sugar axiom of symbol S should be of the form
    $a #Equal ( S a b c ... ) phi $. for some phi, and metavariables a b c
    and it should not have any essential hypotheses (the ones with essentials
    are not supported right now)
    """
    @staticmethod
    def find_sugar_axiom(state: ProofState, symbol: str) -> Optional[Theorem]:
        for theorem in state.composer.theorems.values():
            condition = len(theorem.statement.terms) == 3 and \
                        len(theorem.essentials) == 0 and \
                        theorem.statement.terms[0] == Application(EqualityAutoTactic.SYMBOL) and \
                        isinstance(theorem.statement.terms[1], Application) and \
                        theorem.statement.terms[1].symbol == symbol
            if not condition: continue

            failed = False

            for subterm in theorem.statement.terms[1].subterms:
                if not isinstance(subterm, Metavariable):
                    failed = True
                    break
            if failed: continue

            # check that RHS doesn't have variables not appearing in the LHS
            left_metavars = theorem.statement.terms[1].get_metavariables()
            right_metavars = theorem.statement.terms[2].get_metavariables()
            if not right_metavars.issubset(left_metavars): continue

            return theorem

    """
    equality algorithm: given two terms phi and psi, there are (wlog) 3 cases
    1. phi and psi are both metavariables
       - if phi == psi, use equal-reflexivity
       - if phi != psi, try to find a essential hypothesis that asserts this fact
       - otherwise fail
    2. phi is a metavariable but psi is not
       - try to find a hypothesis that asserts this
       - otherwise fail
    3. phi and psi are both applications
       - if they have the same head, try to find a congruence lemma for the head
         * if found, recursively show they have equal children
         * if not found, try to reduce BOTH phi and psi using a sugar axiom
         * if no sugar axiom is found, fail
       - if they have different head, try to reduce one of them using a sugar axiom,
         then try again.

    some assumptions:
    1. sugar axioms (of the form #Equal ( a ... ) ( b ... )) are "directed" in the sense
       that it should intuitively mean ( a ... ) is defined as ( b ... ), not the other way around
    2. congruence lemmas and sugar axioms are unique for each definition (if they exist)
    3. no cycles of equality (except for common axioms like symmetry)
    """
    @staticmethod
    def prove_equality(state: ProofState, left: Term, right: Term) -> Proof:
        target = EqualityAutoTactic.format_target(left, right)
        symmetric_target = EqualityAutoTactic.format_target(right, left)

        if left == right:
            return state.composer.theorems[EqualityAutoTactic.REFL].unify_and_apply(target)

        # different metavariables
        if isinstance(left, Metavariable) and isinstance(right, Metavariable):
            # try to find an essential that says so
            for theorem in state.hypotheses:
                if theorem.statement.terms == target.terms:
                    return theorem.apply()
                elif theorem.statement.terms == symmetric_target.terms:
                    return state.composer.theorems[EqualityAutoTactic.SYM].apply(theorem.apply())
            assert False, f"unable to show {left} === {right}"

        # TODO: add this case
        if isinstance(left, Metavariable) and not isinstance(right, Metavariable) or \
           not isinstance(left, Metavariable) and isinstance(right, Metavariable):
            assert False, f"proving {left} === {right} is not currently supported"

        assert isinstance(left, Application) and isinstance(right, Application)

        if left.symbol == right.symbol:
            found = EqualityAutoTactic.find_congruence_lemma(state, left.symbol)
            if found is not None:
                congruence, order = found
                subproofs = []
            
                for n in order:
                    # show that the nth subterms are equal
                    assert n < len(left.subterms) and n < len(right.subterms), \
                           f"ill-formed congruence axiom {congruence.statement.label}"

                    subproof = EqualityAutoTactic.prove_equality(state, left.subterms[n], right.subterms[n])
                    subproofs.append(subproof)

                proof = congruence.unify_and_apply(target, *subproofs)
                assert proof.statement.terms == target.terms, f"congruence axiom gave unexpected result"

                return proof
        
        # reduce one of the terms using sugar axiom
        sugar_axiom = EqualityAutoTactic.find_sugar_axiom(state, left.symbol)
        if sugar_axiom:
            substitution = state.composer.unify_terms_as_instance(sugar_axiom.statement.terms[1], left)
            assert substitution is not None, f"ill-formed sugar axiom {sugar_axiom.statement}"

            reduction_proof = sugar_axiom.apply(**substitution)
            new_left = reduction_proof.statement.terms[2]

            # switching the order here in the hope
            # that we don't produce a proof that's too long
            proof = EqualityAutoTactic.prove_equality(state, right, new_left)

            return state.composer.theorems[EqualityAutoTactic.TRANS].apply(
                reduction_proof,
                state.composer.theorems[EqualityAutoTactic.SYM].apply(proof),
            )

        sugar_axiom = EqualityAutoTactic.find_sugar_axiom(state, right.symbol)
        if sugar_axiom:
            # TODO: just being lazy here
            return state.composer.theorems[EqualityAutoTactic.SYM].apply(
                EqualityAutoTactic.prove_equality(state, right, left),
            )

        assert False, f"ran out of tricks, cannot show {left} === {right}"

    def apply(self, state: ProofState):
        goal = state.goal_stack.pop()
        assert len(goal.terms) == 3 and goal.terms[0] == Application(EqualityAutoTactic.SYMBOL), f"goal {goal} is not an equality claim"
        
        _, left, right = goal.terms

        assert state.is_concrete(left), f"LHS {left} is not concrete"
        assert state.is_concrete(right), f"RHS {right} is not concrete"

        self.proof = EqualityAutoTactic.prove_equality(state, left, right)

    def resolve(self, state: ProofState):
        state.proof_stack.append(self.proof)


"""
Expand all syntax sugar defined using #Equal
in the current goal
"""
@ProofState.auto("desugar")
class DesugarAutoTactic(Tactic):
    def __init__(self, symbol: Optional[str]=None):
        self.target_symbol = symbol
        self.equality_proof = None

    """
    Look for heads that have sugar axiom and
    expand all of them in the given term
    """
    @staticmethod
    def expand_all_sugar(state: ProofState, term: Term, target_symbol: Optional[str]=None) -> Term:
        if isinstance(term, Metavariable):
            return term

        assert isinstance(term, Application)

        # expand all subterms
        expanded_subterm = [ DesugarAutoTactic.expand_all_sugar(state, subterm, target_symbol) for subterm in term.subterms ]
        new_term = Application(term.symbol, expanded_subterm)

        if target_symbol is not None and new_term.symbol != target_symbol:
            return new_term

        sugar_axiom = EqualityAutoTactic.find_sugar_axiom(state, new_term.symbol)
        if sugar_axiom:
            _, left, right = sugar_axiom.statement.terms
            substitution = state.composer.unify_terms_as_instance(left, new_term)
            assert substitution is not None, f"ill-formed sugar axiom"
            new_term = SubstitutionVisitor(substitution).visit(right)
            # new_term = DesugarAutoTactic.expand_all_sugar(state, new_term)

        return new_term

    def apply(self, state: ProofState):
        goal = state.goal_stack.pop()
        assert len(goal.terms) == 2 and goal.terms[0] == Application("|-"), f"goal {goal} is not a provability claim"

        _, term = goal.terms

        expanded = DesugarAutoTactic.expand_all_sugar(state, term, self.target_symbol)
        self.equality_proof = EqualityAutoTactic.prove_equality(state, term, expanded)

        state.goal_stack.append(state.sanitize_goal_statement(StructuredStatement("p", [
            Application("|-"),
            expanded,
        ])))

    def resolve(self, state: ProofState):
        desugared_proof = state.proof_stack.pop()
        state.proof_stack.append(state.composer.theorems["equal-proof"].apply(
            desugared_proof,
            self.equality_proof,
        ))
