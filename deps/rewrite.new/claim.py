from __future__ import annotations

from typing import Tuple, TypeVar, Generic
from dataclasses import dataclass
from abc import ABC, abstractmethod

from ml.kore import ast as kore

from ml.metamath import ast as mm
from ml.metamath.composer import Proof
from ml.metamath.utils import MetamathUtils


class Claim(ABC):
    r"""
    A metamath pattern that satisfies \is-predicate
    """

    @abstractmethod
    def encode(self) -> mm.Term:
        """
        Encode self as a metamath term
        """


class TrueClaim(Claim):
    ...


class FalseClaim(Claim):
    ...


@dataclass
class KoreValidClaim(Claim):
    r"""
    A pattern of the form ( \kore-valid ... ... )
    """
    claim: kore.Claim


@dataclass
class SortingClaim(Claim):
    r"""
    ( \in-sort variable sort )
    """
    variable: mm.Metavariable
    sort: mm.Term


@dataclass
class ConjuctionClaim(Claim):
    r"""
    ( \and left right )
    """
    left: Claim
    right: Claim


@dataclass
class ImplicationClaim(Claim):
    r"""
    ( \imp hypothesis conclusion )
    """
    hypothesis: Claim
    conclusion: Claim


C = TypeVar("C", bound=Claim)


@dataclass
class Provable(Generic[C]):
    predicate: C
    proof: Proof

    def __post_init__(self):
        body = MetamathUtils.destruct_provable(self.proof.conclusion)
        assert self.predicate.encode() == body, \
               f"{self.proof} is not a proof of {self.predicate}"
