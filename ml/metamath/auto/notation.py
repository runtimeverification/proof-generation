from typing import Optional, List, Tuple, Mapping

from ..ast import Metavariable, Term, Statement, Application, StructuredStatement
from ..composer import Composer, Theorem, Proof, MethodAutoProof
from ..visitors import SubstitutionVisitor

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
        "#ApplicationContext": ("notation-application-context", [2]),
        "#Substitution": ("notation-substitution", [1, 2, 3]),
    }

    @staticmethod
    def format_target(left: Term, right: Term) -> StructuredStatement:
        return StructuredStatement(
            Statement.PROVABLE,
            [
                Application(NotationProver.SYMBOL),
                left,
                right,
            ],
        )

    @staticmethod
    def apply_sugar_axiom(axiom: Theorem, term: Term) -> Term:
        """
        Rewrite a term using a sugar axiom, from left to right
        """

        assert len(axiom.statement.terms) == 3, \
               f"invalid sugar axiom {axiom}"

        substitution = Unification.match_terms_as_instance(axiom.statement.terms[1], term)
        assert substitution is not None, \
               f"invalid sugar axiom {axiom}"

        return SubstitutionVisitor(substitution).visit(axiom.statement.terms[2])

    @staticmethod
    def find_sugar_axiom(composer: Composer, symbol: str) -> Optional[Theorem]:
        """
        A sugar axiom of symbol S should be of the form
        $a #Notation ( S a b c ... ) phi $. for some phi, and metavariables a b c
        and it should not have any essential hypotheses (the ones with essentials
        are not supported right now)
        """
        for theorem in composer.get_theorems_of_typecode(NotationProver.SYMBOL):
            if not (len(theorem.statement.terms) == 3 and len(theorem.essentials) == 0):
                continue

            lhs = theorem.statement.terms[1]

            if not (isinstance(lhs, Application) and lhs.symbol == symbol):
                continue

            failed = False

            for subterm in lhs.subterms:
                if not isinstance(subterm, Metavariable):
                    failed = True
                    break
            if failed:
                continue

            # check that RHS doesn't have variables not appearing in the LHS
            left_metavars = lhs.get_metavariables()
            right_metavars = theorem.statement.terms[2].get_metavariables()
            if not right_metavars.issubset(left_metavars):
                continue

            return theorem

        return None

    @staticmethod
    def find_congruence_lemma(composer: Composer, symbol: str) -> Optional[Tuple[Theorem, List[int]]]:
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
        for theorem in composer.get_theorems_of_typecode(NotationProver.SYMBOL):
            if len(theorem.statement.terms) != 3:
                continue

            _, lhs, rhs = theorem.statement.terms

            if not (isinstance(lhs, Application) and isinstance(rhs, Application) and lhs.symbol == symbol
                    and rhs.symbol == symbol and len(lhs.subterms) == len(rhs.subterms)):
                continue

            failed = False
            # (metavar pair) -> order in the application
            order_of_metavars = {}

            # check that all children of the applications are metavariables
            for i, (s1, s2) in enumerate(zip(
                    lhs.subterms,
                    rhs.subterms,
            )):
                if not isinstance(s1, Metavariable) or not isinstance(s2, Metavariable):
                    failed = True
                    break
                order_of_metavars[s1.name, s2.name] = i
            if failed:
                continue

            essentials_order = []

            # check that essentials only assumes things about metavariables
            for essential in theorem.essentials:
                if not (len(essential.terms) == 3 and essential.terms[0] == Application(NotationProver.SYMBOL)):
                    continue

                lhs_var = essential.terms[1]
                rhs_var = essential.terms[2]

                if not (isinstance(lhs_var, Metavariable) and isinstance(rhs_var, Metavariable)):
                    continue

                pair = lhs_var.name, rhs_var.name
                if pair not in order_of_metavars:
                    failed = True
                    break

                essentials_order.append(order_of_metavars[pair])
            if failed:
                continue

            return theorem, essentials_order

        return None

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
            return composer.get_theorem(NotationProver.REFL).match_and_apply(target)

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
            found = NotationProver.find_congruence_lemma(composer, left.symbol)
            if found is not None:
                congruence, order = found
                subproofs = []

                for n in order:
                    # show that the nth subterms are equal
                    assert n < len(left.subterms) and n < len(
                        right.subterms
                    ), f"ill-formed congruence axiom {congruence.statement.label}"

                    subproof = NotationProver.prove_notation(composer, left.subterms[n], right.subterms[n])
                    subproofs.append(subproof)

                proof = congruence.match_and_apply(target, *subproofs)
                assert (proof.statement.terms == target.terms), f"congruence axiom gave unexpected result"

                return proof

        # reduce one of the terms using sugar axiom
        sugar_axiom = NotationProver.find_sugar_axiom(composer, left.symbol)
        if sugar_axiom:
            substitution = Unification.match_terms_as_instance(sugar_axiom.statement.terms[1], left)
            assert (substitution is not None), f"ill-formed sugar axiom {sugar_axiom.statement}"

            reduction_proof = sugar_axiom.apply(**substitution)
            new_left = reduction_proof.statement.terms[2]

            # switching the order here in the hope
            # that we don't produce a proof that's too long
            proof = NotationProver.prove_notation(composer, right, new_left)

            return composer.cache_proof(
                "notation-cache",
                composer.get_theorem(NotationProver.TRANS).apply(
                    reduction_proof,
                    composer.get_theorem(NotationProver.SYM).apply(proof),
                ),
            )

        sugar_axiom = NotationProver.find_sugar_axiom(composer, right.symbol)
        if sugar_axiom:
            # TODO: just being lazy here
            return composer.cache_proof(
                "notation-cache",
                composer.get_theorem(NotationProver.SYM).apply(NotationProver.prove_notation(composer, right, left), ),
            )

        assert False, f"ran out of tricks, cannot show {left} === {right}"

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
            sugar_axiom = NotationProver.find_sugar_axiom(composer, term.symbol)

            if sugar_axiom is not None:
                substitution = Unification.match_terms_as_instance(sugar_axiom.statement.terms[1], term)
                assert (substitution is not None), f"ill-formed sugar axiom {sugar_axiom.statement}"

                reduction_proof = sugar_axiom.apply(**substitution)
                expanded = reduction_proof.statement.terms[2]

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

        final_term = Application(term.symbol, expanded_subterms)

        congruence_lemma_pair = NotationProver.find_congruence_lemma(composer, term.symbol)
        if congruence_lemma_pair is not None:
            # if we are lucky enough to find a congruence lemma for the current symbol
            # apply it to get the final result
            congruence_lemma, order = congruence_lemma_pair
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
        if target.terms == source.statement.terms:
            return source

        assert len(target.terms) == len(source.statement.terms) != 0
        assert target.terms[0] == source.statement.terms[0]
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
            expanded_term = source.statement.terms[position]

            notation_proof = NotationProver.prove_notation(composer, original_term, expanded_term)
            notation_proofs.append(notation_proof)

        # apply suitable congruence axiom
        proof = composer.get_theorem(theorem_label).apply(
            source,
            *notation_proofs,
        )

        assert proof.statement.terms == target.terms, \
               f"unable to show {target} from {proof.statement.terms} using only notations"

        return proof

    """
    Usage: auto(<proof>) is an AutoProof that
    will attempt to resolve any proof obligation
    by applying notations on <proof>
    """
    auto = lambda proof: \
        MethodAutoProof(lambda composer, stmt: NotationProver.prove_notation_statement(composer, stmt, proof))
