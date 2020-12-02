"""
Some auto tactics
"""

from typing import Optional, Tuple, List

from proof.metamath.ast import Application, Term, Metavariable, StructuredStatement, Statement
from proof.metamath.composer import Proof, Theorem

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
            equations = state.composer.unify_statements(goal, theorem.statement)
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
    SYMBOL = "#Equal"
    SYM = "equal-symmetry"
    REFL = "equal-reflexivity"
    TRANS = "equal-transitivity"

    @staticmethod
    def format_target(left: Term, right: Term) -> StructuredStatement:
        return StructuredStatement(Statement.PROVABLE, [
            Application(EqualityTactic.SYMBOL),
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
                        theorem.statement.terms[0] == Application(EqualityTactic.SYMBOL) and \
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
                            essential.terms[0] == Application(EqualityTactic.SYMBOL) and \
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
                        theorem.statement.terms[0] == Application(EqualityTactic.SYMBOL) and \
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
        target = EqualityTactic.format_target(left, right)
        symmetric_target = EqualityTactic.format_target(right, left)

        if left == right:
            return state.composer.theorems[EqualityTactic.REFL].unify_and_apply(target)

        # different metavariables
        if isinstance(left, Metavariable) and isinstance(right, Metavariable):
            # try to find an essential that says so
            for theorem in state.hypotheses.values():
                if theorem.statement.terms == target.terms:
                    return theorem.apply()
                elif theorem.statement.terms == symmetric_target.terms:
                    return state.composer.theorems[EqualityTactic.SYM].apply(theorem.apply())
            assert False, f"unable to show {left} === {right}"

        # TODO: add this case
        if isinstance(left, Metavariable) and not isinstance(right, Metavariable) or \
           not isinstance(left, Metavariable) and isinstance(right, Metavariable):
            assert False, f"proving {left} === {right} is not currently supported"

        assert isinstance(left, Application) and isinstance(right, Application)

        if left.symbol == right.symbol:
            found = EqualityTactic.find_congruence_lemma(state, left.symbol)
            if found is not None:
                congruence, order = found
                subproofs = []
            
                for n in order:
                    # show that the nth subterms are equal
                    assert n < len(left.subterms) and n < len(right.subterms), \
                           f"ill-formed congruence axiom {congruence.statement.label}"

                    subproof = EqualityTactic.prove_equality(state, left.subterms[n], right.subterms[n])
                    subproofs.append(subproof)

                proof = congruence.unify_and_apply(target, *subproofs)
                assert proof.statement.terms == target.terms, f"congruence axiom gave unexpected result"

                return proof
        
        # reduce one of the terms using sugar axiom
        sugar_axiom = EqualityTactic.find_sugar_axiom(state, left.symbol)
        if sugar_axiom:
            substitution = state.composer.unify_terms_as_instance(sugar_axiom.statement.terms[1], left)
            assert substitution is not None, f"ill-formed sugar axiom {sugar_axiom.statement}"

            reduction_proof = sugar_axiom.apply(**substitution)
            new_left = reduction_proof.statement.terms[2]

            # switching the order here in the hope
            # that we don't produce a proof that's too long
            proof = EqualityTactic.prove_equality(state, right, new_left)

            return state.composer.theorems[EqualityTactic.TRANS].apply(
                reduction_proof,
                state.composer.theorems[EqualityTactic.SYM].apply(proof),
            )

        sugar_axiom = EqualityTactic.find_sugar_axiom(state, right.symbol)
        if sugar_axiom:
            # TODO: just being lazy here
            return state.composer.theorems[EqualityTactic.SYM].apply(
                EqualityTactic.prove_equality(state, right, left),
            )

        assert False, f"ran out of tricks, cannot show {left} === {right}"

    def apply(self, state: ProofState):
        goal = state.goal_stack.pop()
        assert len(goal.terms) == 3 and goal.terms[0] == Application(EqualityTactic.SYMBOL), f"goal {goal} is not an equality claim"
        
        _, left, right = goal.terms

        assert state.is_concrete(left), f"LHS {left} is not concrete"
        assert state.is_concrete(right), f"RHS {right} is not concrete"

        self.proof = EqualityTactic.prove_equality(state, left, right)

    def resolve(self, state: ProofState):
        state.proof_stack.append(self.proof)


"""
Expand all syntax sugar defined using #Equal
in the current goal
"""
@ProofState.register_tactic("desugar")
@ProofState.register_tactic("desugar-all")
class DesugarTactic(Tactic):
    """
    Look for heads that have sugar axiom and
    expand all of them in the given term
    """
    @staticmethod
    def expand(state: ProofState, term: Term, *_, target_symbol: Optional[str]=None, desugar_all=False) -> Term:
        if isinstance(term, Metavariable):
            return term

        assert isinstance(term, Application)

        # expand all subterms
        expanded_subterm = [
            DesugarTactic.expand(state, subterm, target_symbol=target_symbol, desugar_all=desugar_all)
            for subterm in term.subterms
        ]
        new_term = Application(term.symbol, expanded_subterm)

        if target_symbol is not None and new_term.symbol != target_symbol:
            return new_term

        sugar_axiom = EqualityTactic.find_sugar_axiom(state, new_term.symbol)
        if sugar_axiom:
            _, left, right = sugar_axiom.statement.terms
            substitution = state.composer.unify_terms_as_instance(left, new_term)
            assert substitution is not None, f"ill-formed sugar axiom"
            new_term = SubstitutionVisitor(substitution).visit(right)
            
            if desugar_all:
                new_term = DesugarTactic.expand(
                    state, new_term,
                    target_symbol=target_symbol,
                    desugar_all=desugar_all,
                )

        return new_term

    def apply(self, state: ProofState, target_symbol: Optional[str]=None):
        goal = state.goal_stack.pop()
        assert len(goal.terms) >= 1, f"ill-formed goal {goal}"

        typecode = goal.terms[0]

        if typecode == Application("|-"):
            # definition preseves provability
            assert len(goal.terms) == 2, f"ill-formed provability claim {goal}"
            _, term = goal.terms

            expanded = DesugarTactic.expand(
                state, term, 
                target_symbol=target_symbol,
                desugar_all=self.tactic_name == "desugar-all",
            )
            self.equality_proofs = [ EqualityTactic.prove_equality(state, term, expanded) ]
            self.theorem = state.composer.theorems["equal-proof"]

            state.goal_stack.append(state.sanitize_goal_statement(StructuredStatement("p", [
                typecode, expanded,
            ])))
        elif typecode == Application("#Fresh"):
            # definition preserves freshness
            assert len(goal.terms) == 3, f"ill-formed #Fresh claim {goal}"
            _, var, term = goal.terms

            expanded = DesugarTactic.expand(
                state, term, 
                target_symbol=target_symbol,
                desugar_all=self.tactic_name == "desugar-all",
            )
            self.equality_proofs = [ EqualityTactic.prove_equality(state, term, expanded) ]
            self.theorem = self.theorem = state.composer.theorems["equal-fresh"]

            state.goal_stack.append(state.sanitize_goal_statement(StructuredStatement("p", [
                typecode, var, expanded,
            ])))
        elif typecode == Application("#Substitution"):
            assert len(goal.terms) == 5, f"ill-formed #Substitution claim {goal}"
            _, t1, t2, t3, var = goal.terms
            
            expanded_terms = [
                DesugarTactic.expand(
                    state, term, 
                    target_symbol=target_symbol,
                    desugar_all=self.tactic_name == "desugar-all",
                )
                for term in (t1, t2, t3)
            ]

            self.equality_proofs = [
                EqualityTactic.prove_equality(state, term, expanded)
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
