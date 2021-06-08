from typing import Optional, List, Tuple, Mapping, Dict

from ..ast import Metavariable, Term, Statement, Application, StructuredStatement, ProvableStatement
from ..composer import Composer, Theorem, MethodAutoProof, Proof

from .unification import Unification


class NotationProver:
    SYMBOL = "#Notation"
    SYM = "notation-symmetry"
    REFL = "notation-reflexivity"
    TRANS = "notation-transitivity"
    """
    Labels for the notation congruence axioms
    for metalevel relations, along with the indices
    pointing to subterms that need to be expanded
    """
    METALEVEL_CONGRUENCE_AXIOMS = {
        "|-": ("notation-proof", [1]),
        "#Fresh": ("notation-fresh", [2]),
        "#Positive": ("notation-positive", [2]),
        "#Negative": ("notation-negative", [2]),
        "#ApplicationContext": ("notation-application-context", [2]),
        "#Substitution": ("notation-substitution", [1, 2, 3]),
        "#Notation": ("notation-notation", [1, 2]),
    }

    @staticmethod
    @Composer.add_hook("index")
    def hook_index(composer: Composer, theorem: Theorem) -> None:
        """
        Called in composer every time when a new theorem is indexed
        """
        sugar_axiom_info = NotationProver.destruct_sugar_axiom(theorem)
        if sugar_axiom_info is not None:
            from_symbol, to_symbol = sugar_axiom_info

            assert from_symbol not in composer.notation_axiom_graph, \
                   f"symbol {from_symbol} can be rewritten to both " \
                   f"{to_symbol} (through {theorem.statement.label}) and {composer.notation_axiom_graph[from_symbol][1]}"

            composer.notation_axiom_graph[from_symbol] = theorem, to_symbol
            return

        congruence_lemma_info = NotationProver.destruct_congruence_lemma(theorem)
        if congruence_lemma_info is not None:
            symbol, order = congruence_lemma_info
            if symbol not in composer.notation_congruence:
                composer.notation_congruence[symbol] = theorem, order
            return  # otherwise we just ignore it

    @staticmethod
    @Composer.add_hook("remove")
    def hook_remove(composer: Composer, name: str) -> None:
        """
        Remove a theorem from the index
        """
        composer.notation_axiom_graph = {
            symbol1: (theorem, symbol2)
            for symbol1, (theorem, symbol2) in composer.notation_axiom_graph.items() if theorem.statement.label != name
        }

        composer.notation_congruence = {
            symbol: (theorem, order)
            for symbol, (theorem, order) in composer.notation_congruence.items() if theorem.statement.label != name
        }

    @staticmethod
    def get_path_to_root(composer: Composer, symbol: str) -> Tuple[Tuple[Theorem, str], ...]:
        path = []

        while symbol in composer.notation_axiom_graph:
            theroem, parent_symbol = composer.notation_axiom_graph[symbol]
            path.append((theroem, parent_symbol))
            symbol = parent_symbol

        return tuple(path)

    @staticmethod
    def get_path_to_lowest_common_ancestor(
        composer: Composer, symbol1: str, symbol2: str
    ) -> Optional[Tuple[Tuple[Tuple[Theorem, str], ...],  # tuple of (theorem name, symbol)
                        Tuple[Tuple[Theorem, str], ...], ]]:
        """
        Return a list of theorems to apply on each side
        """

        if symbol1 == symbol2:
            return (), ()

        path1 = NotationProver.get_path_to_root(composer, symbol1)
        path2 = NotationProver.get_path_to_root(composer, symbol2)

        for i, (_, symbol) in enumerate(path2):
            if symbol == symbol1:
                return (), path2[:i + 1]

        for i, (_, symbol) in enumerate(path1):
            if symbol == symbol2:
                return path1[:i + 1], ()

        if len(path1) == 0 or len(path2) == 0:
            return None

        if path1[-1] != path2[-1]:
            return None

        for i, ((_, subsymbol1), (_, subsymbol2)) in enumerate(zip(path1[::-1], path2[::-1])):
            if subsymbol1 != subsymbol2:
                i -= 1
                break

        return path1[:len(path1) - i], path2[:len(path2) - i]

    @staticmethod
    def destruct_sugar_axiom(theorem: Theorem) -> Optional[Tuple[str, str]]:
        """
        If the theorem is a "sugar axiom", return (symbol A, symbol B)
        such that the sugar axiom is defining A as B

        A sugar axiom of symbol S should be of the form
        $a #Notation ( S a b c ... ) phi $. for some phi, and metavariables a b c
        and it should not have any essential hypotheses (the ones with essentials
        are not supported right now)
        """
        if not len(theorem.statement.terms) == 3 or len(theorem.context.essentials) != 0:
            return None

        head, lhs, rhs = theorem.statement.terms

        if head != Application("#Notation"):
            return None

        if not isinstance(lhs, Application) or not isinstance(rhs, Application):
            return None

        for subterm in lhs.subterms:
            if not isinstance(subterm, Metavariable):
                return None

        # check that RHS doesn't have variables not appearing in the LHS
        left_metavars = lhs.get_metavariables()
        right_metavars = rhs.get_metavariables()
        if not right_metavars.issubset(left_metavars):
            return None

        return lhs.symbol, rhs.symbol

    @staticmethod
    def destruct_congruence_lemma(theorem: Theorem) -> Optional[Tuple[str, Tuple[int, ...]]]:
        """
        A congruence lemma for a symbol S is of the form
        ${
            $e #Notation a a' $.
            $e #Notation b b' $.
            $p #Notation ( S a b c ) ( S a' b' c' ) $.
        $}
        Note that the hypotheses may not contain all immediate child terms
        and the order may be different from the order in the application

        The returned list indicates the order of children
        appearing in the essential hypotheses
        """
        if len(theorem.statement.terms) != 3:
            return None

        head, lhs, rhs = theorem.statement.terms

        if head != Application("#Notation"):
            return None

        if not (isinstance(lhs, Application) and \
                isinstance(rhs, Application) and \
                lhs.symbol == rhs.symbol and \
                len(lhs.subterms) == len(rhs.subterms)):
            return None

        # (metavar pair) -> order in the application
        order_of_metavars = {}

        # check that all children of the applications are metavariables
        for i, (s1, s2) in enumerate(zip(lhs.subterms, rhs.subterms)):
            if not isinstance(s1, Metavariable) or not isinstance(s2, Metavariable):
                return None
            order_of_metavars[s1.name, s2.name] = i

        essentials_order = []

        # check that essentials only assumes things about metavariables
        for essential in theorem.context.essentials:
            if not (len(essential.terms) == 3 and essential.terms[0] == Application(NotationProver.SYMBOL)):
                return None

            _, lhs_var, rhs_var = essential.terms

            if not (isinstance(lhs_var, Metavariable) and isinstance(rhs_var, Metavariable)):
                return None

            pair = lhs_var.name, rhs_var.name
            if pair not in order_of_metavars:
                return None

            essentials_order.append(order_of_metavars[pair])

        return lhs.symbol, tuple(essentials_order)

    @staticmethod
    def format_target(left: Term, right: Term) -> StructuredStatement:
        return ProvableStatement(
            "",
            (
                Application(NotationProver.SYMBOL),
                left,
                right,
            ),
        )

    @staticmethod
    def apply_sugar_axiom(axiom: Theorem, term: Application) -> Application:
        """
        Rewrite a term using a sugar axiom, from left to right
        """

        assert len(axiom.statement.terms) == 3, \
               f"invalid sugar axiom {axiom.statement}"

        substitution = Unification.match_terms_as_instance(axiom.statement.terms[1], term)
        assert substitution is not None, \
               f"invalid sugar axiom {axiom.statement}"

        new_term = axiom.statement.terms[2].substitute(substitution)
        assert isinstance(new_term, Application)

        return new_term

    @staticmethod
    def apply_sugar_axioms(axioms: Tuple[Theorem, ...], term: Application) -> Application:
        for axiom in axioms:
            term = NotationProver.apply_sugar_axiom(axiom, term)
        return term

    @staticmethod
    def apply_sugar_axiom_with_proof(axiom: Theorem, term: Application) -> Tuple[Proof, Application]:
        result = NotationProver.apply_sugar_axiom(axiom, term)
        return axiom.match_and_apply(NotationProver.format_target(term, result)), result

    @staticmethod
    def apply_sugar_axioms_with_proof(composer: Composer, axioms: Tuple[Theorem, ...],
                                      term: Application) -> Tuple[Optional[Proof], Application]:
        current_proof: Optional[Proof] = None

        for axiom in axioms:
            step_proof, term = NotationProver.apply_sugar_axiom_with_proof(axiom, term)

            if current_proof is None:
                current_proof = step_proof
            else:
                current_proof = composer.get_theorem(NotationProver.TRANS).apply(
                    current_proof,
                    step_proof,
                )

        return current_proof, term

    @staticmethod
    def find_sugar_axiom(composer: Composer, symbol: str) -> Optional[Theorem]:
        if symbol in composer.notation_axiom_graph:
            return composer.notation_axiom_graph[symbol][0]
        return None

    @staticmethod
    def rewrite_to_same_head_symbol(
        composer: Composer,
        left: Application,
        right: Application,
        with_proof: bool = True,
    ) -> Optional[Tuple[Optional[Proof], Application, Optional[Proof], Application]]:
        """
        Return (left notation proof, new left, right notation proof, new right)
        """
        paths = NotationProver.get_path_to_lowest_common_ancestor(composer, left.symbol, right.symbol)
        if paths is None:
            return None

        left_path, right_path = paths

        left_proof: Optional[Proof] = None
        right_proof: Optional[Proof] = None

        if with_proof:
            left_proof, new_left = NotationProver.apply_sugar_axioms_with_proof(
                composer, tuple(theorem for theorem, _ in left_path), left
            )
            right_proof, new_right = NotationProver.apply_sugar_axioms_with_proof(
                composer, tuple(theorem for theorem, _ in right_path), right
            )
        else:
            new_left = NotationProver.apply_sugar_axioms(tuple(theorem for theorem, _ in left_path), left)
            new_right = NotationProver.apply_sugar_axioms(tuple(theorem for theorem, _ in right_path), right)

        assert isinstance(new_left, Application) and \
               isinstance(new_right, Application)

        return left_proof, new_left, right_proof, new_right

    @staticmethod
    def expand_top_level_once(composer: Composer, term: Application) -> Application:
        """
        Expand the top level construct once without proof
        """
        assert term.symbol in composer.notation_axiom_graph, \
               f"unable to expand the top level construct of {term} further"
        theorem, _ = composer.notation_axiom_graph[term.symbol]
        return NotationProver.apply_sugar_axiom(theorem, term)

    @staticmethod
    def apply_reflexivity(composer: Composer, term: Term) -> Proof:
        return composer.get_theorem(NotationProver.REFL).apply(ph0=term)

    @staticmethod
    def prove_notation(composer: Composer, left: Term, right: Term) -> Proof:
        """
        notation algorithm: given two terms phi and psi, there are (wlog) 3 cases
        1. phi and psi are both metavariables
        - if phi == psi, use notation-reflexivity
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
        1. sugar axioms (of the form #Notation ( a ... ) ( b ... )) are "directed" in the sense
        that it should intuitively mean ( a ... ) is defined as ( b ... ), not the other way around
        2. congruence lemmas and sugar axioms are unique for each definition (if they exist)
        3. no cycles of notation (except for common axioms like symmetry)
        """
        target = NotationProver.format_target(left, right)
        symmetric_target = NotationProver.format_target(right, left)

        if left == right:
            return NotationProver.apply_reflexivity(composer, left)

        # different metavariables
        if isinstance(left, Metavariable) and isinstance(right, Metavariable):
            # try to find an essential that says so
            for theorem in composer.get_all_essentials():
                if theorem.statement.terms == target.terms:
                    return theorem.apply()
                elif theorem.statement.terms == symmetric_target.terms:
                    return composer.get_theorem(NotationProver.SYM).apply(theorem.apply())
            assert False, f"unable to show {left} === {right}"

        # TODO: add this case
        if (isinstance(left, Metavariable) and not isinstance(right, Metavariable)
                or not isinstance(left, Metavariable) and isinstance(right, Metavariable)):
            assert False, f"proving {left} === {right} is not currently supported"

        assert isinstance(left, Application) and isinstance(right, Application)

        if left.symbol == right.symbol:
            if left.symbol in composer.notation_congruence:
                theorem, order = composer.notation_congruence[left.symbol]
                subproofs = []

                for n in order:
                    # show that the nth subterms are equal
                    assert n < len(left.subterms) and n < len(
                        right.subterms
                    ), f"ill-formed congruence axiom {theorem.statement.label}"

                    subproof = NotationProver.prove_notation(composer, left.subterms[n], right.subterms[n])
                    subproofs.append(subproof)

                proof = theorem.match_and_apply(target, *subproofs)
                assert proof.is_proof_of(target), f"congruence axiom gave unexpected result"

                return proof
            elif left.symbol in composer.notation_axiom_graph:
                # expand further to find congruence lemma
                theorem, _ = composer.notation_axiom_graph[left.symbol]

                step_proof1, left = NotationProver.apply_sugar_axiom_with_proof(theorem, left)
                step_proof2, right = NotationProver.apply_sugar_axiom_with_proof(theorem, right)
                proof = NotationProver.prove_notation(composer, left, right)

                return composer.get_theorem(NotationProver.TRANS).apply(
                    step_proof1,
                    composer.get_theorem(NotationProver.TRANS).apply(
                        proof,
                        composer.get_theorem(NotationProver.SYM).apply(step_proof2),
                    ),
                )

            assert False, f"failed to show {left} === {right}"

        # try to rewrite both terms to a common head symbol
        result = NotationProver.rewrite_to_same_head_symbol(composer, left, right)
        assert result is not None, \
               f"cannot rewrite {left} and {right} to have the same head symbol"
        left_proof, left, right_proof, right = result

        proof = NotationProver.prove_notation(composer, left, right)

        if left_proof is not None:
            proof = composer.get_theorem(NotationProver.TRANS).apply(
                left_proof,
                proof,
            )

        if right_proof is not None:
            proof = composer.get_theorem(NotationProver.TRANS
                                         ).apply(proof,
                                                 composer.get_theorem(NotationProver.SYM).apply(right_proof))

        return composer.cache_proof("notation-cache", proof)

    @staticmethod
    def expand_sugar(composer: Composer, term: Term, target_symbol: Optional[str] = None) -> Term:
        """
        Look for heads that have sugar axiom and
        expand all of them in the given term
        """
        expanded, _ = NotationProver.expand_sugar_with_proof(composer, term, target_symbol)
        return expanded

    @staticmethod
    def expand_sugar_with_proof(composer: Composer,
                                term: Term,
                                target_symbol: Optional[str] = None) -> Tuple[Term, Proof]:
        if isinstance(term, Metavariable):
            return term, composer.get_theorem(NotationProver.REFL).apply(ph0=term)

        assert isinstance(term, Application)

        proof = None

        # find a axiom to desugar the current head
        if target_symbol is None or term.symbol == target_symbol:
            if term.symbol in composer.notation_axiom_graph:
                sugar_axiom, _ = composer.notation_axiom_graph[term.symbol]

                substitution = Unification.match_terms_as_instance(sugar_axiom.statement.terms[1], term)
                assert (substitution is not None), f"ill-formed sugar axiom {sugar_axiom.statement}"

                reduction_proof = sugar_axiom.apply(**substitution)
                expanded = reduction_proof.conclusion[2]

                # switching the order here in the hope
                # that we don't produce a proof that's too long
                expanded, proof = NotationProver.expand_sugar_with_proof(
                    composer, expanded, target_symbol=target_symbol
                )
                proof = composer.get_theorem(NotationProver.TRANS).apply(reduction_proof, proof)
                return expanded, composer.cache_proof("notation-cache", proof)

        if len(term.subterms) == 0:
            return term, composer.get_theorem(NotationProver.REFL).apply(ph0=term)

        expanded_subterms = []
        subproofs = []

        # recurse to expand each subterm
        for subterm in term.subterms:
            expanded_subterm, subproof = NotationProver.expand_sugar_with_proof(
                composer, subterm, target_symbol=target_symbol
            )
            expanded_subterms.append(expanded_subterm)
            subproofs.append(subproof)

        final_term = Application(term.symbol, tuple(expanded_subterms))

        if term.symbol in composer.notation_congruence:
            # if we are lucky enough to find a congruence lemma for the current symbol
            # apply it to get the final result
            congruence_lemma, order = composer.notation_congruence[term.symbol]

            reordered_subproofs = []
            for n in order:
                assert n < len(subproofs), f"ill-formed congruence axiom {congruence_lemma.statement.label}"
                reordered_subproofs.append(subproofs[n])

            target = NotationProver.format_target(term, final_term)
            proof = congruence_lemma.match_and_apply(target, *reordered_subproofs)
            return final_term, composer.cache_proof("notation-cache", proof)
        else:
            # otherwise resort to the dumb way
            return final_term, NotationProver.prove_notation(composer, term, final_term)

    @staticmethod
    def prove_notation_statement(composer: Composer, target: StructuredStatement, source: Proof) -> Proof:
        """
        Given a statement <target> and a proof of another statement <source>
        attempt to show <target> by arguing that they are the same modulo notation
        """
        if source.is_proof_of(target):
            return source

        assert len(target.terms) == len(source.conclusion) != 0
        assert target.terms[0] == source.conclusion[0]
        assert isinstance(target.terms[0], Application)

        meta_relation = target.terms[0].symbol
        assert meta_relation in NotationProver.METALEVEL_CONGRUENCE_AXIOMS, \
               f"metalevel relation not supported: {target}"

        theorem_label, positions = NotationProver.METALEVEL_CONGRUENCE_AXIOMS[meta_relation]
        notation_proofs = []

        # prove notation at each subpattern
        for position in positions:
            assert position < len(target.terms), f"ill-formed goal: {target}"

            original_term = target.terms[position]
            expanded_term = source.conclusion[position]

            notation_proof = NotationProver.prove_notation(composer, original_term, expanded_term)
            notation_proofs.append(notation_proof)

        # apply suitable congruence axiom
        proof = composer.get_theorem(theorem_label).apply(
            source,
            *notation_proofs,
        )

        assert proof.is_proof_of(target), \
               f"unable to show {target} from {proof} using only notations"

        return proof

    """
    Usage: auto(<proof>) is an AutoProof that
    will attempt to resolve any proof obligation
    by applying notations on <proof>
    """
    auto = lambda proof: \
        MethodAutoProof(lambda composer, stmt: NotationProver.prove_notation_statement(composer, stmt, proof))
