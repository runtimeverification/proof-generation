"""
Some automated tactics
"""

from typing import Optional, Tuple, List, Union, Dict

from ml.metamath.ast import Application, Term, Metavariable, StructuredStatement, Statement, ProvableStatement
from ml.metamath.composer import Theorem, Proof
from ml.metamath.utils import MetamathUtils

from ml.metamath.auto.unification import Unification
from ml.metamath.auto.notation import NotationProver
from ml.metamath.auto.substitution import SubstitutionProver
from ml.metamath.auto.sorting import SortingProver
from ml.metamath.auto.context import ApplicationContextProver
from ml.metamath.auto.fresh import FreshProver
from ml.metamath.auto.typecode import TypecodeProver
from ml.metamath.auto.positive import PositiveProver

from .state import ProofState, Goal, NoStateChangeException, Tactic
from .tactics import ApplyTactic
from .extension import SchematicVariable


@ProofState.register_tactic("search")
class SearchTactic(Tactic):
    """
    Search for claim most "similar" to the current goal,
    where the similarity is measured by the inverse of the sum of
    the sizes of terms in every non-trivial substitution pair.

    By non-trivial substitution pair I mean a pair
    x |-> t in the substitution where x is a schematic variable
    and t is NOT a schematic variable.

    And by size I mean the number of applications in the term
    """
    @staticmethod
    def get_size_of_term(term: Term) -> int:
        if isinstance(term, Metavariable):
            return 1
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

    @staticmethod
    def find_closest_matches_for_top_goal(state: ProofState) -> List[Tuple[int, Theorem]]:
        """
        Find the closest matches for the top goal
        """
        statement = state.get_top_goal().statement
        found = []

        theorems = list(state.composer.theorems.values()) + \
                   state.get_all_essentials_for_top_goal() + \
                   [ claim.theorem for claim in state.get_all_global_claims() ] + \
                   [ claim.theorem for claim in state.get_all_local_claims() ]

        for theorem in theorems:
            if theorem.statement.label is None:
                continue

            # skip the theorems that have conclusion of the form |- ph0
            # (ph0 being a metavariable)
            if MetamathUtils.is_provable(theorem.statement.terms):
                body = MetamathUtils.destruct_provable(theorem.statement.terms)
                if isinstance(body, Metavariable):
                    continue

            # TODO: this is a bit hacky
            old_schematic_vars = state.schematic_vars

            preprocessed = ApplyTactic.preprocess_theorem(state, theorem, {})
            result = Tactic.unify_statements(state, statement, preprocessed.conclusion)

            state.schematic_vars = old_schematic_vars

            if result is None:
                continue

            substitution, _ = result

            theorem_metavars = preprocessed.conclusion.get_metavariables()

            distance = 0
            for var, term in substitution.items():
                # only count the metavariables in the theorem statement
                if var not in theorem_metavars:
                    continue

                if isinstance(term, Metavariable):
                    # if the typecode are the same then distance is 0, otherwise 1
                    t1 = SearchTactic.get_typecode_of_metavariable(state, Metavariable(var))
                    t2 = SearchTactic.get_typecode_of_metavariable(state, term)
                    if t1 != t2:
                        distance += 1
                else:
                    distance += SearchTactic.get_size_of_term(term)

            found.append((distance, theorem))

        found.sort(key=lambda t: t[0])

        return found

    def apply(self, state: ProofState, *args: str, **_: str) -> None:
        if len(args) == 0:
            limit: Optional[int] = 7
        else:
            if args[0] == "all":
                limit = None
            else:
                limit = int(args[0])

        matches = SearchTactic.find_closest_matches_for_top_goal(state)

        print("theorem(s) found (from the least relevant to the most relevant):")
        for distance, theorem in matches[:limit][::-1]:
            print(f"{theorem.statement.label} ({distance}): {Goal.sanitize_goal_statement(theorem.statement)}")

        raise NoStateChangeException()

    def resolve(self, state: ProofState, subproofs: List[Proof]) -> Proof:
        pass


@ProofState.register_tactic("wf")
class WellFormednessTactic(Tactic):
    """
    Prove the well-formedness of a term
    """
    def apply(self, state: ProofState, *args: str, **kwargs: str) -> None:
        goal = state.resolve_top_goal(self)
        statement = goal.statement
        assert len(statement.terms) == 2 and \
               isinstance(statement.terms[0], Application) and \
               len(statement.terms[0].subterms) == 0, \
               f"goal {statement} is not an well-formedness claim"

        _, right = statement.terms
        assert state.is_concrete(right), f"RHS {right} is not concrete"

        proof = TypecodeProver.prove_typecode(state.composer, statement.terms[0].symbol, right)
        assert proof is not None, \
               f"unable to prove {statement} as a well-formedness claim"
        self.proof = proof

    def resolve(self, state: ProofState, subproofs: List[Proof]) -> Proof:
        return self.proof


@ProofState.register_tactic("notation")
class NotationTactic(Tactic):
    """
    Automatically prove notational equivalence of terms
    modulo the definition relation #Notation
    """
    def apply(self, state: ProofState, *args: str, **kwargs: str) -> None:
        goal = state.resolve_top_goal(self)
        statement = goal.statement
        assert len(statement.terms) == 3 and statement.terms[0] == Application(
            NotationProver.SYMBOL
        ), f"goal {statement} is not an notation claim"

        _, left, right = statement.terms

        assert state.is_concrete(left), f"LHS {left} is not concrete"
        assert state.is_concrete(right), f"RHS {right} is not concrete"

        self.proof = NotationProver.prove_notation(state.composer, left, right)

    def resolve(self, state: ProofState, subproofs: List[Proof]) -> Proof:
        return self.proof


@ProofState.register_tactic("desugar")
@ProofState.register_tactic("desugar-all")
@ProofState.register_tactic("desugar-kore")
class DesugarTactic(Tactic):
    """
    Expand all syntax sugar defined using #Notation
    in the current goal
    """
    def find_kore_symbol(self, state: ProofState, term: Term) -> Optional[str]:
        if isinstance(term, Application):
            if (term.symbol.startswith("\\kore-")
                    and NotationProver.find_sugar_axiom(state.composer, term.symbol) is not None):
                return term.symbol

            for subterm in term.subterms:
                found = self.find_kore_symbol(state, subterm)
                if found is not None:
                    return found

            return None
        else:
            return None

    def desugar_kore(self, state: ProofState, term: Term) -> Term:
        """
        Desugar all non constant symbols beginning with \\kore-
        """
        while True:
            symbol = self.find_kore_symbol(state, term)
            if symbol is None:
                return term
            term = NotationProver.expand_sugar(state.composer, term, target_symbol=symbol)

    def desugar(self, state: ProofState, term: Term, target_symbol: Optional[str] = None) -> Term:
        if self.tactic_name == "desugar-kore":
            return self.desugar_kore(state, term)
        else:
            if self.tactic_name == "desugar-all":
                assert target_symbol is None, "desugar-all takes no argument"

            return NotationProver.expand_sugar(
                state.composer,
                term,
                target_symbol=target_symbol,
            )

    def apply(self, state: ProofState, *args: str, **kwargs: str) -> None:
        if len(args) == 0:
            target_symbol: Optional[str] = None
        else:
            target_symbol = args[0]

        goal = state.resolve_top_goal(self)
        statement = goal.statement
        assert len(statement.terms) >= 1, f"ill-formed goal {statement}"

        typecode = statement.terms[0]

        assert isinstance(typecode, Application) and len(typecode.subterms) == 0, \
               f"missing typecode: {statement}"

        assert typecode.symbol in NotationProver.METALEVEL_CONGRUENCE_AXIOMS, \
               f"unsupported metalevel relation: {statement}"

        theorem_label, positions = NotationProver.METALEVEL_CONGRUENCE_AXIOMS[typecode.symbol]

        self.theorem = state.composer.get_theorem(theorem_label)
        self.notation_proofs = []

        # desugar subterms that are expected to hold patterns
        desugared_terms = list(statement.terms)
        for position in positions:
            assert position < len(statement.terms), f"ill-formed goal: {statement}"
            term = statement.terms[position]

            expanded_term = self.desugar(state, term, target_symbol)
            notation_proof = NotationProver.prove_notation(state.composer, term, expanded_term)

            self.notation_proofs.append(notation_proof)

            desugared_terms[position] = expanded_term

        state.push_derived_goal(goal, ProvableStatement(statement.label, tuple(desugared_terms)))

    def resolve(self, state: ProofState, subproofs: List[Proof]) -> Proof:
        assert len(subproofs) == 1
        return self.theorem.apply(
            subproofs[0],
            *self.notation_proofs,
        )


@ProofState.register_tactic("substitution")
class SubstitutionTactic(Tactic):
    """
    Prove a statement about substitution
    """
    def apply(self, state: ProofState, *args: str, **kwargs: str) -> None:
        goal = state.resolve_top_goal(self)
        self.proof = SubstitutionProver.prove_substitution_statement(
            state.composer,
            goal.statement,
            hypotheses=state.composer.get_all_essentials(),
        )

    def resolve(self, state: ProofState, subproofs: List[Proof]) -> Proof:
        return self.proof


@ProofState.register_tactic("sorting")
class SortingTactic(Tactic):
    def apply(self, state: ProofState, *args: str, **kwargs: str) -> None:
        goal = state.resolve_top_goal(self)
        statement = goal.statement
        assert len(statement.terms
                   ) == 2 and statement.terms[0] == Application("|-"), f"not a provability goal {statement}"
        self.proof = SortingProver.prove_sorting_statement(state.composer, statement)

    def resolve(self, state: ProofState, subproofs: List[Proof]) -> Proof:
        return self.proof


@ProofState.register_tactic("context")
class ApplicationContextTactic(Tactic):
    def apply(self, state: ProofState, *args: str, **kwargs: str) -> None:
        goal = state.resolve_top_goal(self)
        statement = goal.statement
        self.proof = ApplicationContextProver.prove_application_context_statement(state.composer, statement)

    def resolve(self, state: ProofState, subproofs: List[Proof]) -> Proof:
        return self.proof


@ProofState.register_tactic("fresh")
class FreshTactic(Tactic):
    def apply(self, state: ProofState, *args: str, **kwargs: str) -> None:
        goal = state.resolve_top_goal(self)
        statement = goal.statement
        assert len(statement.terms
                   ) == 3 and statement.terms[0] == Application("#Fresh"), f"not a #Fresh goal {statement}"
        self.proof = FreshProver.prove_fresh_statement(state.composer, statement)

    def resolve(self, state: ProofState, subproofs: List[Proof]) -> Proof:
        return self.proof


@ProofState.register_tactic("positive")
@ProofState.register_tactic("negative")
class PositiveTactic(Tactic):
    def apply(self, state: ProofState, *args: str, **kwargs: str) -> None:
        goal = state.resolve_top_goal(self)
        statement = goal.statement
        assert len(statement.terms) == 3 and \
               (statement.terms[0] == Application("#Positive") or
                statement.terms[0] == Application("#Negative")), \
               f"not a #Positive or #Negative goal {statement}"
        self.proof = PositiveProver.prove_statement(state.composer, statement)

    def resolve(self, state: ProofState, subproofs: List[Proof]) -> Proof:
        return self.proof


@ProofState.register_tactic("tautology")
class TautologyTactic(Tactic):
    """
    Try to resolve the current goal if it's
    a propositional claim, i.e., a propositional pattern
    with pattern metavariables as atomic propositions
    """

    # connective -> arity
    PROPOSITION_CONNECTIVES = {
        "\\imp": 2,
        "\\bot": 0,
        "\\and": 2,
        "\\or": 2,
        "\\not": 1,
        "\\top": 0,
        "\\iff": 2,
    }

    def is_propositional(self, state: ProofState, term: Term) -> bool:
        r"""
        A propositional formula/pattern is defined as a pattern built
        from the following constructs:
        - atomic propositions: pattern metavariables
        - \imp
        - \bot
        - \and
        - \or
        - \not
        - \top
        - \iff

        In the comments below,
        the fragment with only \imp and \bot will be called implicative
        the fragment with only \and, \or, and \not will be called conjunctive
        """
        if isinstance(term, Application):
            if term.symbol not in TautologyTactic.PROPOSITION_CONNECTIVES:
                return False

            arity = TautologyTactic.PROPOSITION_CONNECTIVES[term.symbol]

            if len(term.subterms) != arity:
                return False

            for subterm in term.subterms:
                if not self.is_propositional(state, subterm):
                    return False

            return True

        if isinstance(term, Metavariable):
            typecode = state.composer.find_metavariable(term.name)
            return typecode == "#Pattern"

        return False

    def decompose_iff(self, proof: Proof) -> Tuple[Term, Term]:
        assert (
            len(proof.conclusion) == 2 and isinstance(proof.conclusion[1], Application)
            and proof.conclusion[1].symbol == "\\iff" and len(proof.conclusion[1].subterms) == 2
        )
        lhs, rhs = proof.conclusion[1].subterms
        return lhs, rhs

    def decompose_imp(self, proof: Proof) -> Tuple[Term, Term]:
        assert (
            len(proof.conclusion) == 2 and isinstance(proof.conclusion[1], Application)
            and proof.conclusion[1].symbol == "\\imp" and len(proof.conclusion[1].subterms) == 2
        )
        lhs, rhs = proof.conclusion[1].subterms
        return lhs, rhs

    def junction_to_list(self, term: Term, connective: str = "and") -> List[Term]:
        if isinstance(term, Application) and term.symbol == f"\\{connective}":
            return [term.subterms[0]] + self.junction_to_list(term.subterms[1], connective)
        else:
            return [term]

    def list_to_junction(self, terms: List[Term], connective: str = "and", reverse: bool = False) -> Term:
        assert len(terms)

        if len(terms) > 1:
            subterms = [
                terms[0],
                self.list_to_junction(terms[1:], connective, reverse=reverse),
            ]
            if reverse:
                subterms.reverse()
            return Application(f"\\{connective}", tuple(subterms))
        else:
            return terms[0]

    def apply_iff_transitivity(self, state: ProofState, *proofs: Proof) -> Proof:
        assert len(proofs)
        proof = proofs[0]
        for step in proofs[1:]:
            proof = state.composer.get_theorem("rule-iff-transitivity").apply(proof, step)
        return proof

    def apply_iff_reflexivity(self, state: ProofState, term: Term) -> Proof:
        return state.composer.get_theorem("iff-reflexivity").apply(ph0=term)

    def apply_iff_congruence(
        self, state: ProofState, *terms_or_proofs: Union[Proof, Term], connective: str = "and"
    ) -> Proof:
        theorem = state.composer.get_theorem(f"rule-iff-compat-in-{connective}")
        proofs = [
            self.apply_iff_reflexivity(state, term_or_proof) if isinstance(term_or_proof, Term) else term_or_proof
            for term_or_proof in terms_or_proofs
        ]
        return theorem.apply(*proofs)

    def reverse_junction(self, state: ProofState, term: Term, connective: str = "and") -> Proof:
        r"""
        Assuming term is of the form
        ( ph0 /\ ( ph1 /\ ... ( phn-1 /\ phn ) ) )
        return a proof of
        ( ( ph0 /\ ( ph1 /\ ... ( phn-1 /\ phn ) ) ) <-> ( ( ( ph0 /\ ph1 ) ... ) /\ phn ) )
        """
        if isinstance(term, Application) and term.symbol == f"\\{connective}":
            first = term.subterms[0]
            rest = term.subterms[1]
            subproof = self.reverse_junction(state, rest, connective)

            _, rhs = self.decompose_iff(subproof)

            return self.apply_iff_transitivity(
                state,
                self.apply_iff_congruence(state, first, subproof, connective=connective),
                state.composer.get_theorem(f"{connective}-commutativity").apply(ph0=first, ph1=rhs),
            )
        else:
            return self.apply_iff_reflexivity(state, term)

    def merge_junctions(self, state: ProofState, left: Term, right: Term, connective: str = "and") -> Proof:
        r"""
        Merge con/dis-junctions. Suppose left and right are of the form
        ( ph0 /\ ( ph1 /\ ... ) ) and ( ph0' /\ ( ph1' /\ ... ) )

        Return a proof of
        ( \iff ( ph0 /\ ( ph1 /\ ... ) ) /\ ( ph0' /\ ( ph1' /\ ... ) )
            ( phn /\ ( ... ( ph1 ( ph0 /\ ( ph0' /\ ( ph1' /\ ... ) ) ) ... )
        """
        left_conjuncts = self.junction_to_list(left, connective)
        right_conjuncts = self.junction_to_list(right, connective)

        if len(left_conjuncts) > 1:
            reversed_left_proof = self.reverse_junction(state, left, connective)
            proof = self.apply_iff_congruence(
                state,
                reversed_left_proof,
                self.apply_iff_reflexivity(state, right),
                connective=connective,
            )

            # apply associativity repeatedly to merge two "cons" lists
            for i in range(len(left_conjuncts) - 1):
                ph0 = self.list_to_junction(left_conjuncts[i + 1:], connective, reverse=True)
                ph1 = left_conjuncts[i]
                ph2 = self.list_to_junction(left_conjuncts[:i][::-1] + right_conjuncts, connective)
                step = state.composer.get_theorem(f"{connective}-associativity").apply(ph0=ph0, ph1=ph1, ph2=ph2)
                proof = self.apply_iff_transitivity(state, proof, step)

            return proof
        else:
            return self.apply_iff_reflexivity(state, Application(f"\\{connective}", (left, right)))

    def reduce_to_cnf(self, state: ProofState, term: Term) -> Proof:
        r"""
        Let CNF(ph) be one CNF formula of ph
        This function returns a proof of |- ( \imp ph CNF(ph) )
        NOTE: ph is assumed to have only conjunctions, disjunctions, negations, and atoms
        """
        if isinstance(term, Metavariable):
            return self.apply_iff_reflexivity(state, term)

        assert isinstance(term, Application)

        if term.symbol == "\\and":
            left, right = term.subterms
            left_cnf_proof = self.reduce_to_cnf(state, left)
            right_cnf_proof = self.reduce_to_cnf(state, right)

            _, left_cnf = self.decompose_iff(left_cnf_proof)
            _, right_cnf = self.decompose_iff(right_cnf_proof)

            return self.apply_iff_transitivity(
                state,
                self.apply_iff_congruence(state, left_cnf_proof, right_cnf_proof, connective="and"),
                self.merge_junctions(state, left_cnf, right_cnf, "and"),
            )
        elif term.symbol == "\\or":
            left, right = term.subterms
            left_cnf_proof = self.reduce_to_cnf(state, left)
            right_cnf_proof = self.reduce_to_cnf(state, right)

            _, left_cnf = self.decompose_iff(left_cnf_proof)
            _, right_cnf = self.decompose_iff(right_cnf_proof)

            premerge_proof = self.apply_iff_congruence(
                state,
                left_cnf_proof,
                right_cnf_proof,
                connective="or",
            )

            left_conjuncts = self.junction_to_list(left_cnf)
            right_conjuncts = self.junction_to_list(right_cnf)

            if len(left_conjuncts) > 1:
                distribute_or = self.apply_iff_transitivity(
                    state,
                    premerge_proof,
                    state.composer.get_theorem("or-left-distributivity").apply(
                        ph0=left_conjuncts[0],
                        ph1=self.list_to_junction(left_conjuncts[1:]),
                        ph2=self.list_to_junction(right_conjuncts),
                    ),
                )

                _, distributed = self.decompose_iff(distribute_or)

                return self.apply_iff_transitivity(
                    state,
                    distribute_or,
                    self.reduce_to_cnf(state, distributed),
                )
            elif len(right_conjuncts) > 1:
                distribute_or = self.apply_iff_transitivity(
                    state,
                    premerge_proof,
                    state.composer.get_theorem("or-right-distributivity").apply(
                        ph0=left_conjuncts[0],
                        ph1=right_conjuncts[0],
                        ph2=self.list_to_junction(right_conjuncts[1:]),
                    ),
                )

                _, distributed = self.decompose_iff(distribute_or)

                return self.apply_iff_transitivity(
                    state,
                    distribute_or,
                    self.reduce_to_cnf(state, distributed),
                )
            else:
                return self.apply_iff_transitivity(
                    state,
                    premerge_proof,
                    self.merge_junctions(state, left_cnf, right_cnf, "or"),
                )

        elif term.symbol == "\\not":
            (subterm, ) = term.subterms

            if isinstance(subterm, Metavariable):
                return self.apply_iff_reflexivity(state, term)

            assert isinstance(subterm, Application)

            if subterm.symbol == "\\and" or subterm.symbol == "\\or":
                left, right = subterm.subterms
                de_morgan_proof = state.composer.get_theorem(f"de-morgan-{subterm.symbol[1:]}").apply(
                    ph0=left,
                    ph1=right,
                )

                _, reduced = self.decompose_iff(de_morgan_proof)

                return self.apply_iff_transitivity(
                    state,
                    de_morgan_proof,
                    self.reduce_to_cnf(state, reduced),
                )

            if subterm.symbol == "\\not":
                (subsubterm, ) = subterm.subterms
                dn_elim_proof = state.composer.get_theorem("double-negation").apply(ph0=subsubterm, )

                _, reduced = self.decompose_iff(dn_elim_proof)

                return self.apply_iff_transitivity(
                    state,
                    dn_elim_proof,
                    self.reduce_to_cnf(state, reduced),
                )

        assert False, f"unable to reduce {term} to cnf"

    def reduce_to_conjunctive(self, state: ProofState, term: Term) -> Proof:
        r"""
        Reduce a propositional term to the conjunctive fragment (i.e.
        reduce to only using \and, \or, and \not)
        """

        if isinstance(term, Metavariable):
            return self.apply_iff_reflexivity(state, term)

        assert isinstance(term, Application)

        if term.symbol in {"\\and", "\\or", "\\not"}:
            return self.apply_iff_congruence(
                state,
                *[self.reduce_to_conjunctive(state, subterm) for subterm in term.subterms],
                connective=term.symbol[1:],
            )

        if term.symbol == "\\imp":
            left, right = term.subterms

            left_reduced = self.reduce_to_conjunctive(state, left)
            right_reduced = self.reduce_to_conjunctive(state, right)

            return self.apply_iff_transitivity(
                state,
                state.composer.get_theorem("imp-to-or").apply(ph0=left, ph1=right),
                self.apply_iff_congruence(
                    state,
                    self.apply_iff_congruence(state, left_reduced, connective="not"),
                    right_reduced,
                    connective="or",
                ),
            )

        # iff to and of two implications
        if term.symbol == "\\iff":
            left, right = term.subterms

            left_reduced = self.reduce_to_conjunctive(state, left)
            right_reduced = self.reduce_to_conjunctive(state, right)

            return self.apply_iff_transitivity(
                state,
                state.composer.get_theorem("iff-to-and").apply(ph0=left, ph1=right),
                self.apply_iff_congruence(
                    state,
                    self.apply_iff_congruence(
                        state,
                        self.apply_iff_congruence(state, left_reduced, connective="not"),
                        right_reduced,
                        connective="or",
                    ),
                    self.apply_iff_congruence(
                        state,
                        self.apply_iff_congruence(state, right_reduced, connective="not"),
                        left_reduced,
                        connective="or",
                    ),
                    connective="and",
                ),
            )

        if term.symbol == "\\bot":
            return state.composer.get_theorem("bot-to-and").as_proof()

        if term.symbol == "\\top":
            return state.composer.get_theorem("top-to-or").as_proof()

        assert False, f"unable to reduce pattern {term}"

    def permute_junction(self, state: ProofState, cnf: Term, position: int, connective: str = "and") -> Proof:
        """
        Move the nth clause/literal to the first, and return a proof of equivalence
        """
        if position == 0:
            return self.apply_iff_reflexivity(state, cnf)

        conjuncts = self.junction_to_list(cnf, connective)
        assert position < len(conjuncts)

        assert isinstance(cnf, Application)
        left, right = cnf.subterms

        right_conjuncts = self.junction_to_list(right, connective)
        if len(right_conjuncts) == 1:
            return state.composer.get_theorem(f"{connective}-commutativity").apply(
                ph0=left,
                ph1=right,
            )

        right_permutation_proof = self.permute_junction(state, right, position - 1, connective)
        _, permuted_right = self.decompose_iff(right_permutation_proof)

        permuted_right_conjuncts = self.junction_to_list(permuted_right, connective)
        target = permuted_right_conjuncts[0]

        # step 1
        proof = self.apply_iff_congruence(
            state,
            self.apply_iff_reflexivity(state, left),
            right_permutation_proof,
            connective=connective,
        )

        # step 2
        rest_conjuncts = self.list_to_junction(permuted_right_conjuncts[1:], connective)
        proof = self.apply_iff_transitivity(
            state,
            proof,
            state.composer.get_theorem("rule-iff-symmetry").apply(
                state.composer.get_theorem(f"{connective}-associativity").apply(
                    ph0=left,
                    ph1=target,
                    ph2=rest_conjuncts,
                ),
            ),
        )

        # step 3
        proof = self.apply_iff_transitivity(
            state,
            proof,
            self.apply_iff_congruence(
                state,
                state.composer.get_theorem(f"{connective}-commutativity").apply(
                    ph0=left,
                    ph1=target,
                ),
                self.apply_iff_reflexivity(state, rest_conjuncts),
                connective=connective,
            ),
        )

        # step 4
        proof = self.apply_iff_transitivity(
            state,
            proof,
            state.composer.get_theorem(f"{connective}-associativity").apply(
                ph0=target,
                ph1=left,
                ph2=rest_conjuncts,
            ),
        )

        return proof

    def simplify_clause(self, state: ProofState, clause: Term) -> Proof:
        r"""
        Simplify a clause to either a smaller clause or \top
        """
        literals = self.junction_to_list(clause, "or")
        positive_vars = {}  # var name -> position
        negative_vars = {}

        duplicate_pair = None  # we only need one pair

        for i, literal in enumerate(literals):
            if isinstance(literal, Metavariable):
                if literal.name not in positive_vars:
                    positive_vars[literal.name] = i
                elif duplicate_pair is None:
                    duplicate_pair = positive_vars[literal.name], i
            else:
                assert (
                    isinstance(literal, Application) and literal.symbol == "\\not" and len(literal.subterms) == 1
                    and isinstance(literal.subterms[0], Metavariable)
                )
                if literal.subterms[0].name not in negative_vars:
                    negative_vars[literal.subterms[0].name] = i
                elif duplicate_pair is None:
                    duplicate_pair = negative_vars[literal.subterms[0].name], i

        for var in positive_vars:
            if var in negative_vars:
                positive_var = literals[positive_vars[var]]
                negative_var = literals[negative_vars[var]]

                # combine var and not var to get top
                permutation_pos_proof = self.permute_junction(state, clause, positive_vars[var], "or")
                _, permuted_clause = self.decompose_iff(permutation_pos_proof)

                if positive_vars[var] > negative_vars[var]:
                    negative_vars[var] += 1
                permutation_neg_proof = self.permute_junction(state, permuted_clause, negative_vars[var], "or")
                _, permuted_clause = self.decompose_iff(permutation_neg_proof)

                permuted_literals = self.junction_to_list(permuted_clause, "or")

                top_proof = state.composer.get_theorem("or-complement").apply(ph0=positive_var)

                if len(permuted_literals) > 2:
                    rest = self.list_to_junction(permuted_literals[2:], "or")

                    top_proof = self.apply_iff_transitivity(
                        state,
                        state.composer.get_theorem("rule-iff-symmetry").apply(
                            state.composer.get_theorem("or-associativity").apply(
                                ph0=negative_var,
                                ph1=positive_var,
                                ph2=rest,
                            ),
                        ),
                        self.apply_iff_congruence(
                            state,
                            top_proof,
                            self.apply_iff_reflexivity(state, rest),
                            connective="or",
                        ),
                    )

                    top_proof = self.apply_iff_transitivity(
                        state,
                        top_proof,
                        state.composer.get_theorem("or-top").apply(ph0=rest),
                    )

                return self.apply_iff_transitivity(
                    state,
                    permutation_pos_proof,
                    permutation_neg_proof,
                    top_proof,
                )

        # if no complementing literals found, try to reduce duplicated literals
        if duplicate_pair is not None:
            i, j = duplicate_pair
            assert i < j
            permutation_proof_1 = self.permute_junction(state, clause, i, "or")
            _, permuted_clause = self.decompose_iff(permutation_proof_1)

            permutation_proof_2 = self.permute_junction(state, permuted_clause, j, "or")
            _, permuted_clause = self.decompose_iff(permutation_proof_2)

            permuted_literals = self.junction_to_list(permuted_clause, "or")

            idempotency_proof = state.composer.get_theorem("or-idempotency").apply(ph0=literals[i])

            if len(permuted_literals) > 2:
                rest = self.list_to_junction(permuted_literals[2:], "or")

                idempotency_proof = self.apply_iff_transitivity(
                    state,
                    state.composer.get_theorem("rule-iff-symmetry").apply(
                        state.composer.get_theorem("or-associativity").apply(
                            ph0=literals[i],
                            ph1=literals[i],
                            ph2=rest,
                        ),
                    ),
                    self.apply_iff_congruence(
                        state,
                        idempotency_proof,
                        self.apply_iff_reflexivity(state, rest),
                        connective="or",
                    ),
                )

            simplification_proof = self.apply_iff_transitivity(
                state,
                permutation_proof_1,
                permutation_proof_2,
                idempotency_proof,
            )
            _, simplified_clause = self.decompose_iff(simplification_proof)

            return self.apply_iff_transitivity(
                state,
                simplification_proof,
                self.simplify_clause(state, simplified_clause),
            )

        return self.apply_iff_reflexivity(state, clause)

    def simplify_cnf(self, state: ProofState, cnf: Term, i: int = 0) -> Proof:
        """
        Given a CNF formula:
        1. remove all duplicated literals
        2. remove all clauses with complementing literals,
        """
        conjuncts = self.junction_to_list(cnf)
        # clauses = [ self.junction_to_list(conjunct, "or") for conjunct in conjuncts ]

        if i >= len(conjuncts):
            return self.apply_iff_reflexivity(state, cnf)
        conjunct = conjuncts[i]

        subproof = self.simplify_clause(state, conjunct)
        _, simplified_clause = self.decompose_iff(subproof)

        permutation_proof = self.permute_junction(state, cnf, i)
        _, cnf = self.decompose_iff(permutation_proof)

        permuted_conjuncts = self.junction_to_list(cnf)

        if len(permuted_conjuncts) > 1:
            rest = self.list_to_junction(permuted_conjuncts[1:])
            simplification_proof = self.apply_iff_congruence(
                state,
                subproof,
                self.apply_iff_reflexivity(state, rest),
                connective="and",
            )
        else:
            simplification_proof = subproof

        simplification_proof = self.apply_iff_transitivity(
            state,
            permutation_proof,
            simplification_proof,
        )

        if simplified_clause == Application("\\top"):
            if len(permuted_conjuncts) > 1:
                simplification_proof = self.apply_iff_transitivity(
                    state,
                    simplification_proof,
                    state.composer.get_theorem("and-top").apply(ph0=rest),
                )

                # the current clause is eliminated, so we don't
                # need to increase i
                return self.apply_iff_transitivity(
                    state,
                    simplification_proof,
                    self.simplify_cnf(state, rest, i),
                )

        _, simplified_cnf = self.decompose_iff(simplification_proof)

        return self.apply_iff_transitivity(
            state,
            simplification_proof,
            self.simplify_cnf(state, simplified_cnf, i + 1),
        )

    def is_clause_tautology(self, clause: List[Term]) -> bool:
        """
        A clause is a tautology iff it contains a pair of complementing literals
        """
        literal_map: Dict[Metavariable, bool] = {}

        for literal in clause:
            if isinstance(literal, Metavariable):
                var = literal
                value = True
            else:
                assert isinstance(literal, Application)
                assert len(literal.subterms) == 1
                term = literal.subterms[0]
                assert isinstance(term, Metavariable)
                var = term
                value = False

            if var in literal_map and literal_map[var] != value:
                return True
            else:
                literal_map[var] = value

        return False

    def is_clause_new(self, clauses: List[List[Term]], clause: List[Term]) -> bool:
        """
        Test if any of the existing clauses is equivalent to the given clause
        or if the current clause is a tautology
        """
        if self.is_clause_tautology(clause):
            return False

        for old_clause in clauses:
            if set(clause) == set(old_clause):
                return False

        return True

    def find_path_to_falsum(self, clauses: List[List[Term]]) -> Optional[List[Tuple[int, int, Metavariable]]]:
        """
        Given a list of clauses, find a path of resolutions that
        will lead to falsum (using a naive BFS algorithm)

        A path is a list of triples (c1, c2, var), c1 != c2
        where var occurs in c1 and (not var) occurs in c2
        """
        # [ ( clauses (conjunction of disjunctions of literals), path (negative var position, positive var position, variable) ) ]
        queue_type = List[Tuple[List[List[Term]], List[Tuple[int, int, Metavariable]]]]
        queue: queue_type = [(clauses, [])]
        initial_length = len(clauses)
        current_depth = 0

        while queue:
            clauses, path = queue.pop(0)

            if len(clauses) > initial_length + current_depth:
                current_depth = len(clauses) - initial_length
                print(f"search depth: {current_depth}, size of queue: {len(queue)}")

            # find all possible pairs to apply resolution
            # such that we would result in a new and non-tautology
            # clause

            # record all positive and negative occurrences of variables
            positive_occurences: Dict[Metavariable, List[Tuple[int, int]]] = {
            }  # metavar -> [ ( position of the clause, position of the literal ) ]
            negative_occurences: Dict[Metavariable, List[Tuple[int, int]]] = {}  # ^ same

            for i, clause in enumerate(clauses):
                for j, literal in enumerate(clause):
                    if isinstance(literal, Metavariable):
                        if literal not in positive_occurences:
                            positive_occurences[literal] = []

                        positive_occurences[literal].append((i, j))
                    elif isinstance(literal, Application) and literal.symbol == "\\not":
                        var = literal.subterms[0]
                        assert isinstance(var, Metavariable)
                        if var not in negative_occurences:
                            negative_occurences[var] = []

                        negative_occurences[var].append((i, j))

            # test each candidate pair
            next_steps: queue_type = []

            for var in set(positive_occurences).intersection(set(negative_occurences)):
                candidates = [
                    (pos_clause, pos_literal, neg_clause, neg_literal)
                    for pos_clause, pos_literal in positive_occurences[var]
                    for neg_clause, neg_literal in negative_occurences[var] if pos_clause != neg_clause
                ]

                for pos_clause, pos_literal, neg_clause, neg_literal in candidates:
                    clause1 = clauses[pos_clause].copy()
                    clause2 = clauses[neg_clause].copy()

                    var = clause1[pos_literal]
                    assert isinstance(var, Metavariable)

                    del clause1[pos_literal]
                    del clause2[neg_literal]

                    # this order should be the same as the order in resolution-* lemmas
                    new_clause = clause2 + clause1
                    new_path = path + [(pos_clause, neg_clause, var)]

                    # find falsum
                    if len(new_clause) == 0:
                        return new_path

                    if self.is_clause_new(clauses, new_clause):
                        # make sure we don't make duplicate clauses
                        for next_clauses, _ in next_steps:
                            if set(next_clauses[0]) == set(new_clause):
                                break
                        else:
                            # print([ new_clause ] + clauses)
                            next_steps.append(([list(set(new_clause))] + clauses, new_path))

            # print(len(clauses), len(queue), len(next_steps))

            queue += next_steps

        return None

    def apply_resolution(
        self,
        state: ProofState,
        cnf: Term,
        pos_clause: int,
        neg_clause: int,
        var: Metavariable,
    ) -> Proof:
        """
        Given a CNF term ph, try to apply the resolution rule
        and return a proof of ph -> ph' where ph' is the result
        of applying resolution on the literals indicated by
        the quadruplet (pos_clause, pos_literal, neg_clause, neg_literal)
        """
        # result = self.find_next_pair_to_resolve(state, cnf)
        # if result is None: return None
        # pos_clause, pos_literal, neg_clause, neg_literal = result

        clauses = [self.junction_to_list(conjunct, "or") for conjunct in self.junction_to_list(cnf)]
        pos_literal = clauses[pos_clause].index(var)
        neg_literal = clauses[neg_clause].index(Application("\\not", (var, )))

        # print(var, pos_clause, neg_clause)

        # first, move up the clause with positive occurence
        permutation_pos_proof = self.permute_junction(state, cnf, pos_clause)
        _, permuted_cnf = self.decompose_iff(permutation_pos_proof)
        permuted_conjuncts = self.junction_to_list(permuted_cnf)

        # then move up the literal in the first clause
        permutation_pos_literal_proof = self.permute_junction(state, permuted_conjuncts[0], pos_literal, "or")
        _, permuted_pos_clause = self.decompose_iff(permutation_pos_literal_proof)
        proof = self.apply_iff_transitivity(
            state,
            permutation_pos_proof,
            self.apply_iff_congruence(
                state,
                permutation_pos_literal_proof,
                self.apply_iff_reflexivity(state, self.list_to_junction(permuted_conjuncts[1:])),
                connective="and",
            ),
        )
        _, permuted_cnf = self.decompose_iff(proof)

        if neg_clause < pos_clause:
            # add one here because we have moved one clause to the front
            neg_clause += 1

        # now move up the clause with the negative occurence
        permutation_neg_proof = self.permute_junction(state, permuted_cnf, neg_clause)
        _, permuted_cnf = self.decompose_iff(permutation_neg_proof)
        permuted_conjuncts = self.junction_to_list(permuted_cnf)

        # and similarly, move up the literal in the first clause with the negative occurence
        permutation_neg_literal_proof = self.permute_junction(state, permuted_conjuncts[0], neg_literal, "or")
        _, permuted_neg_clause = self.decompose_iff(permutation_neg_literal_proof)
        proof = self.apply_iff_transitivity(
            state,
            proof,
            permutation_neg_proof,
            self.apply_iff_congruence(
                state,
                permutation_neg_literal_proof,
                self.apply_iff_reflexivity(state, self.list_to_junction(permuted_conjuncts[1:])),
                connective="and",
            ),
        )
        _, permuted_cnf = self.decompose_iff(proof)
        permuted_conjuncts = self.junction_to_list(permuted_cnf)
        permuted_clauses = [self.junction_to_list(conjunct, "or") for conjunct in permuted_conjuncts]

        # one last step to transform the statement to
        # ( merge1 /\ merge2 ) /\ rest
        if len(permuted_conjuncts) > 2:
            proof = self.apply_iff_transitivity(
                state,
                proof,
                state.composer.get_theorem("rule-iff-symmetry").apply(
                    state.composer.get_theorem("and-associativity").apply(
                        ph0=permuted_neg_clause,
                        ph1=permuted_pos_clause,
                        ph2=self.list_to_junction(permuted_conjuncts[2:]),
                    ),
                ),
            )

        # reduce iff to imp
        simplification_proof = state.composer.get_theorem("rule-iff-elim-left").apply(proof)

        # three possible versions of resolution may apply

        first_conjunct = permuted_conjuncts[0]
        second_conjunct = permuted_conjuncts[1]
        first_clause = permuted_clauses[0]
        second_clause = permuted_clauses[1]

        first_and_second_clause = Application("\\and", (first_conjunct, second_conjunct))

        falsum_found = False

        if len(first_clause) > 1 and len(second_clause) > 1:
            resolvent_left = self.list_to_junction(first_clause[1:], "or")
            resolvent_right = self.list_to_junction(second_clause[1:], "or")

            target_statement = ProvableStatement(
                "",
                (
                    Application("|-"),
                    Application(
                        "\\imp",
                        (
                            first_and_second_clause,
                            Application("\\or", (resolvent_left, resolvent_right)),
                        ),
                    ),
                ),
            )

            resolution_proof = state.composer.get_theorem("resolution-4").match_and_apply(target_statement)

            # now we need to merge the resolvent to the correct format
            merge_proof = self.merge_junctions(state, resolvent_left, resolvent_right, "or")
            merge_proof_imp = state.composer.get_theorem("rule-iff-elim-left").apply(merge_proof)

            resolution_proof = state.composer.get_theorem("rule-imp-transitivity").apply(
                resolution_proof,
                merge_proof_imp,
            )
        elif len(first_clause) > 1:
            resolvent_left = self.list_to_junction(first_clause[1:], "or")

            target_statement = ProvableStatement(
                "",
                (
                    Application("|-"),
                    Application(
                        "\\imp",
                        (
                            first_and_second_clause,
                            resolvent_left,
                        ),
                    ),
                ),
            )

            resolution_proof = state.composer.get_theorem("resolution-2").match_and_apply(target_statement)

        elif len(second_clause) > 1:
            resolvent_right = self.list_to_junction(second_clause[1:], "or")

            target_statement = ProvableStatement(
                "",
                (
                    Application("|-"),
                    Application(
                        "\\imp",
                        (
                            first_and_second_clause,
                            resolvent_right,
                        ),
                    ),
                ),
            )

            resolution_proof = state.composer.get_theorem("resolution-3").match_and_apply(target_statement)

        else:
            # otherwise it reduces to falsum!
            resolution_proof = state.composer.get_theorem("resolution-1").apply(ph0=second_clause[0])
            falsum_found = True

        # simplify the resolvent
        if not falsum_found:
            _, resolvent = self.decompose_imp(resolution_proof)
            # assuming here the resolvent is not top (which should be filtered out by the initial search)

            resolution_proof = state.composer.get_theorem("rule-imp-transitivity").apply(
                resolution_proof,
                state.composer.get_theorem("rule-iff-elim-left").apply(self.simplify_clause(state, resolvent)),
            )

        # 1. cnf -> cnf /\ cnf
        # 2. cnf -> first_two_clauses -> resolvent
        # 3. cnf -> cnf
        # 4. cnf -> resolvent /\ cnf
        if len(permuted_conjuncts) > 2:
            rest = self.list_to_junction(permuted_conjuncts[2:])
            resolution_proof = state.composer.get_theorem("rule-imp-compat-in-and").apply(
                state.composer.get_theorem("rule-imp-transitivity").apply(
                    simplification_proof,
                    state.composer.get_theorem("rule-imp-transitivity").apply(
                        state.composer.get_theorem("and-elim-left-sugar").apply(ph0=first_and_second_clause, ph1=rest),
                        resolution_proof,
                    ),
                ),
                state.composer.get_theorem("rule-iff-elim-left").apply(self.apply_iff_reflexivity(state, cnf)),
            )
        else:
            resolution_proof = state.composer.get_theorem("rule-imp-compat-in-and").apply(
                state.composer.get_theorem("rule-imp-transitivity").apply(
                    simplification_proof,
                    resolution_proof,
                ),
                state.composer.get_theorem("rule-iff-elim-left").apply(self.apply_iff_reflexivity(state, cnf)),
            )

        resolution_proof = state.composer.get_theorem("rule-imp-transitivity").apply(
            state.composer.get_theorem("rule-iff-elim-left").apply(
                state.composer.get_theorem("rule-iff-symmetry"
                                           ).apply(state.composer.get_theorem("and-idempotency").apply(ph0=cnf), ),
            ),
            resolution_proof,
        )

        # if the resolvent is falsum
        # we can just reduce the entire cnf to falsum
        if falsum_found:
            _, cnf_with_resolvent = self.decompose_imp(resolution_proof)
            assert isinstance(cnf_with_resolvent, Application)

            resolution_proof = state.composer.get_theorem("rule-imp-transitivity").apply(
                resolution_proof,
                state.composer.get_theorem("and-bot").apply(ph0=cnf_with_resolvent.subterms[1]),
            )

        return resolution_proof

    def apply(self, state: ProofState, *args: str, **kwargs: str) -> None:
        goal = state.resolve_top_goal(self)
        statement = goal.statement
        assert len(statement.terms
                   ) == 2 and statement.terms[0] == Application("|-"), f"{statement} is not a provability claim"
        assert state.is_concrete(statement), f"{statement} still have schematic variables"

        _, goal_term = statement.terms

        print("expanding the goal")
        assert self.is_propositional(state, goal_term), f"goal {statement} is not propositional"

        negated_goal_term = Application("\\not", (goal_term, ))

        print("reducing the negation of the goal to CNF")

        reduction_proof = self.reduce_to_conjunctive(state, negated_goal_term)
        _, reduced_term = self.decompose_iff(reduction_proof)

        cnf_proof = self.reduce_to_cnf(state, reduced_term)
        _, cnf_term = self.decompose_iff(cnf_proof)

        print("simplifying CNF")

        simpl_proof = self.simplify_cnf(state, cnf_term)
        _, cnf_term = self.decompose_iff(simpl_proof)

        # separated clauses
        clauses = [self.junction_to_list(conjunct, "or") for conjunct in self.junction_to_list(cnf_term)]

        # find a path to falsum
        print(f"searching a path to falsum")
        path = self.find_path_to_falsum(clauses)
        assert path is not None, f"the equivalent cnf {clauses} does not imply falsum"

        # proof that the cnf implies falsum
        falsum_proof = None

        print(f"applying {len(path)} step(s) of resolution")

        for c1, c2, var in path:
            step = self.apply_resolution(state, cnf_term, c1, c2, var)
            _, cnf_term = self.decompose_imp(step)

            if falsum_proof is None:
                falsum_proof = step
            else:
                falsum_proof = state.composer.get_theorem("rule-imp-transitivity").apply(falsum_proof, step)

        assert cnf_term == Application("\\bot")

        print("resolved to falsum, constructing final proof")

        # the negation of the goal implies falsum
        assert falsum_proof is not None
        falsum_proof = state.composer.get_theorem("rule-imp-transitivity").apply(
            state.composer.get_theorem("rule-iff-elim-left").apply(
                self.apply_iff_transitivity(state, reduction_proof, cnf_proof, simpl_proof)
            ),
            falsum_proof,
        )

        goal_proof = state.composer.get_theorem("proof-rule-mp").apply(
            state.composer.get_theorem("contradiction").apply(ph0=goal_term),
            falsum_proof,
        )

        self.goal_proof = goal_proof

    def resolve(self, state: ProofState, subproofs: List[Proof]) -> Proof:
        return self.goal_proof
