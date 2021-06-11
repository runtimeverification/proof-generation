from typing import Tuple

from ml.kore import ast as kore
from ml.kore.utils import KoreUtils

from ml.metamath.auto.sorting import SortingProver

from .env import ProofGenerator, ProvableClaim


class PropositionalProofGenerator(ProofGenerator):
    """
    Propositional manipulation
    """

    COMMUTATIVITY = {
        kore.MLPattern.AND: "kore-and-commutativity",
        kore.MLPattern.OR: "kore-or-commutativity",
    }

    ASSOCIATIVITY = {
        kore.MLPattern.AND: "kore-and-associativity",
        kore.MLPattern.OR: "kore-or-associativity",
    }

    IMPLIES_COMPAT = {
        kore.MLPattern.AND: "kore-implies-compat-in-kore-and",
        kore.MLPattern.OR: "kore-implies-compat-in-kore-or",
    }

    IFF_COMPAT = {
        kore.MLPattern.AND: "kore-iff-compat-in-kore-and",
        kore.MLPattern.OR: "kore-iff-compat-in-kore-or",
    }

    def apply_implies_reflexivity(self, pattern: kore.Pattern) -> ProvableClaim:
        claim = self.composer.construct_claim(KoreUtils.construct_implies(pattern, pattern))
        return self.composer.apply_kore_lemma("kore-implies-reflexivity-alt", goal=claim)

    def apply_iff_reflexivity(self, pattern: kore.Pattern) -> ProvableClaim:
        claim = self.composer.construct_claim(KoreUtils.construct_iff(pattern, pattern))
        return self.composer.apply_kore_lemma("kore-iff-reflexivity", goal=claim)

    @staticmethod
    def destruct_implies_claim(claim: ProvableClaim) -> Tuple[kore.Pattern, kore.Pattern]:
        left, right = KoreUtils.destruct_implies(claim.claim.pattern)
        return left, right

    @staticmethod
    def destruct_iff_claim(claim: ProvableClaim) -> Tuple[kore.Pattern, kore.Pattern]:
        left, right = KoreUtils.destruct_iff(claim.claim.pattern)
        return left, right

    def apply_implies_transitivity(self, claim1: ProvableClaim, claim2: ProvableClaim) -> ProvableClaim:
        _, right1 = PropositionalProofGenerator.destruct_implies_claim(claim1)
        left2, _ = PropositionalProofGenerator.destruct_implies_claim(claim2)
        assert right1 == left2, f"cannot connect {claim1.claim} and {claim2.claim}"

        return self.composer.apply_kore_lemma("kore-implies-transitivity-alt", claim1, claim2)

    def apply_iff_transitivity(self, claim1: ProvableClaim, claim2: ProvableClaim) -> ProvableClaim:
        _, right1 = PropositionalProofGenerator.destruct_iff_claim(claim1)
        left2, _ = PropositionalProofGenerator.destruct_iff_claim(claim2)
        assert right1 == left2, f"cannot connect {claim1.claim} and {claim2.claim}"

        return self.composer.apply_kore_lemma("kore-iff-transitivity", claim1, claim2)

    def apply_implies_multiple_transitivity(self, *claims: ProvableClaim) -> ProvableClaim:
        assert len(claims) > 0

        if len(claims) == 1:
            return claims[0]
        else:
            return self.apply_implies_transitivity(
                claims[0],
                self.apply_implies_multiple_transitivity(*claims[1:]),
            )

    def apply_iff_multiple_transitivity(self, *claims: ProvableClaim) -> ProvableClaim:
        assert len(claims) > 0

        if len(claims) == 1:
            return claims[0]
        else:
            return self.apply_iff_transitivity(
                claims[0],
                self.apply_iff_multiple_transitivity(*claims[1:]),
            )

    def apply_iff_symmetry(self, claim: ProvableClaim) -> ProvableClaim:
        """
        phi1 <-> phi2
        -------------
        phi2 <-> phi1
        """
        return self.composer.apply_kore_lemma("kore-iff-symmetry", claim)

    def apply_iff_elim_left(self, claim: ProvableClaim) -> ProvableClaim:
        """
        phi1 <-> phi2
        -------------
        phi1 -> phi2
        """
        return self.composer.apply_kore_lemma("kore-iff-elim-left", claim)

    def apply_iff_elim_right(self, claim: ProvableClaim) -> ProvableClaim:
        """
        phi1 <-> phi2
        -------------
        phi2 -> phi1
        """
        return self.composer.apply_kore_lemma("kore-iff-elim-right", claim)

    def apply_commutativity(self, construct: str, pattern: kore.Pattern) -> ProvableClaim:
        """
        phi1 [] phi2 <-> phi2 [] phi1
        """
        assert construct in PropositionalProofGenerator.COMMUTATIVITY

        left, right = KoreUtils.destruct_ml_pattern(construct, pattern)

        goal = self.composer.construct_claim(
            KoreUtils.construct_iff(
                pattern,
                KoreUtils.construct_binary_ml_pattern(construct, right, left),
            ),
        )

        theorem_name = PropositionalProofGenerator.COMMUTATIVITY[construct]
        return self.composer.apply_kore_lemma(theorem_name, goal=goal)

    def apply_left_associativity(self, construct: str, pattern: kore.Pattern) -> ProvableClaim:
        """
        phi1 [] ( phi2 [] phi3 ) <-> ( phi1 [] phi2 ) [] phi3
        """
        assert construct in PropositionalProofGenerator.ASSOCIATIVITY

        left, right = KoreUtils.destruct_ml_pattern(construct, pattern)
        right_left, right_right = KoreUtils.destruct_ml_pattern(construct, right)

        goal = self.composer.construct_claim(
            KoreUtils.construct_iff(
                pattern,
                KoreUtils.construct_binary_ml_pattern(
                    construct,
                    KoreUtils.construct_binary_ml_pattern(construct, left, right_left),
                    right_right,
                ),
            ),
        )

        theorem_name = PropositionalProofGenerator.ASSOCIATIVITY[construct]
        return self.composer.apply_kore_lemma(theorem_name, goal=goal)

    def apply_right_associativity(self, construct: str, pattern: kore.Pattern) -> ProvableClaim:
        """
        ( phi1 [] phi2 ) [] phi3 <-> phi1 [] ( phi2 [] phi3 )
        """
        left, right = KoreUtils.destruct_ml_pattern(construct, pattern)
        left_left, left_right = KoreUtils.destruct_ml_pattern(construct, left)

        return self.apply_iff_symmetry(
            self.apply_left_associativity(
                construct,
                KoreUtils.construct_binary_ml_pattern(
                    construct,
                    left_left,
                    KoreUtils.construct_binary_ml_pattern(construct, left_right, right),
                ),
            ),
        )

    def apply_implies_compatibility(
        self, construct: str, claim1: ProvableClaim, claim2: ProvableClaim
    ) -> ProvableClaim:
        """
        Apply a theorem that implies is compatible with respect to the construct

        phi1 -> phi2
        phi3 -> phi4
        ------------
        phi1 [] phi3 -> phi2 [] phi4
        """

        assert construct in PropositionalProofGenerator.IMPLIES_COMPAT

        left1, right1 = PropositionalProofGenerator.destruct_implies_claim(claim1)
        left2, right2 = PropositionalProofGenerator.destruct_implies_claim(claim2)

        goal = self.composer.construct_claim(
            KoreUtils.construct_implies(
                KoreUtils.construct_binary_ml_pattern(construct, left1, left2),
                KoreUtils.construct_binary_ml_pattern(construct, right1, right2),
            ),
        )

        theorem_name = PropositionalProofGenerator.IMPLIES_COMPAT[construct]
        return self.composer.apply_kore_lemma(theorem_name, claim1, claim2, goal=goal)

    def apply_iff_compatibility(self, construct: str, claim1: ProvableClaim, claim2: ProvableClaim) -> ProvableClaim:
        """
        Apply a theorem that iff is compatible with respect to the construct

        phi1 <-> phi2
        phi3 <-> phi4
        ------------
        phi1 [] phi3 <-> phi2 [] phi4
        """

        assert construct in PropositionalProofGenerator.IMPLIES_COMPAT

        left1, right1 = PropositionalProofGenerator.destruct_iff_claim(claim1)
        left2, right2 = PropositionalProofGenerator.destruct_iff_claim(claim2)

        goal = self.composer.construct_claim(
            KoreUtils.construct_iff(
                KoreUtils.construct_binary_ml_pattern(construct, left1, left2),
                KoreUtils.construct_binary_ml_pattern(construct, right1, right2),
            ),
        )

        theorem_name = PropositionalProofGenerator.IFF_COMPAT[construct]
        return self.composer.apply_kore_lemma(theorem_name, claim1, claim2, goal=goal)

    def shuffle_nested(self, construct: str, pattern: kore.Pattern, n: int) -> ProvableClaim:
        """
        Shuffle the n^th subpattern in KoreUtils.destruct_nested_ml_pattern(construct, pattern)
        to the leftmost while maintaining the order of other subpatterns

        construct in { AND, OR }
        
        Return a proof of pattern <-> shuffled pattern
        """

        if not (isinstance(pattern, kore.MLPattern) and pattern.construct == construct):
            assert n == 0, f"{n}^th conjunct does not exist in {pattern}"
            return self.apply_iff_reflexivity(pattern)

        left, right = KoreUtils.destruct_ml_pattern(construct, pattern)
        # len(left), len(right) >= 1

        left_conjuncts = KoreUtils.destruct_nested_ml_pattern(construct, left)
        if n < len(left_conjuncts):
            left_shuffle = self.shuffle_nested(construct, left, n)

            shuffle = self.apply_iff_compatibility(
                construct,
                left_shuffle,
                self.apply_iff_reflexivity(right),  # RHS stays the same
            )

            if len(left_conjuncts) > 1:
                # shuffle the target to the top level
                _, rhs = PropositionalProofGenerator.destruct_iff_claim(shuffle)
                shuffle = self.apply_iff_transitivity(
                    shuffle,
                    self.apply_right_associativity(construct, rhs),
                )

            return shuffle

        right_conjuncts = KoreUtils.destruct_nested_ml_pattern(construct, right)
        if n - len(left_conjuncts) < len(right_conjuncts):
            right_shuffle = self.shuffle_nested(construct, right, n - len(left_conjuncts))
            _, right_rhs = PropositionalProofGenerator.destruct_iff_claim(right_shuffle)

            shuffle = self.apply_iff_compatibility(
                construct,
                self.apply_iff_reflexivity(left),  # LHS stays the same
                right_shuffle,
            )

            _, rhs = PropositionalProofGenerator.destruct_iff_claim(shuffle)

            if len(right_conjuncts) == 1:
                shuffle = self.apply_iff_transitivity(
                    shuffle,
                    self.apply_commutativity(construct, rhs),
                )
            else:
                assert len(right_conjuncts) > 1
                target, rest = KoreUtils.destruct_ml_pattern(construct, right_rhs)

                # left /\ (target /\ rest)
                # <-> (step1)
                # (left /\ target) /\ rest
                # <-> (step2)
                # (target /\ left) /\ rest
                # <-> (step3)
                # target /\ (left /\ rest)

                step1 = self.apply_left_associativity(construct, rhs)
                step2 = self.apply_iff_compatibility(
                    construct,
                    self.apply_commutativity(construct, KoreUtils.construct_binary_ml_pattern(construct, left, target)),
                    self.apply_iff_reflexivity(rest),
                )
                step3 = self.apply_right_associativity(
                    construct,
                    PropositionalProofGenerator.destruct_iff_claim(step2)[1],
                )

                shuffle = self.apply_iff_multiple_transitivity(shuffle, step1, step2, step3)

            return shuffle

        assert False, f"{n}^th conjunct does not exist in {pattern}"

    def apply_weakening(self, claim: ProvableClaim, additional_premise: kore.Pattern) -> ProvableClaim:
        """
        Given a proof of |- phi and a pattern psi
        return a proof of |- psi -> phi
        """
        return self.composer.apply_kore_lemma(
            "kore-weakening",
            claim,
            ph1=additional_premise,
        )

    def apply_mp(self, implication: ProvableClaim, premise: ProvableClaim) -> ProvableClaim:
        return self.composer.apply_kore_lemma(
            "kore-mp-alt",
            implication,
            premise,
        )

    def apply_and_elim_left(self, pattern: kore.Pattern) -> ProvableClaim:
        left, _ = KoreUtils.destruct_and(pattern)
        return self.composer.apply_kore_lemma(
            "kore-and-elim-left-alt3",
            goal=self.composer.construct_claim(KoreUtils.construct_implies(pattern, left)),
        )

    def apply_and_elim_right(self, pattern: kore.Pattern) -> ProvableClaim:
        _, right = KoreUtils.destruct_and(pattern)
        return self.composer.apply_kore_lemma(
            "kore-and-elim-right-alt3",
            goal=self.composer.construct_claim(KoreUtils.construct_implies(pattern, right)),
        )
