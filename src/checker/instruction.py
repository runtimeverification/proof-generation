from __future__ import annotations

from enum import IntEnum
from typing import TYPE_CHECKING

if TYPE_CHECKING:
    from collections.abc import Iterator


class Instruction(IntEnum):
    List = 1

    # Patterns
    EVar = 2
    SVar = 3
    Symbol = 4
    Implication = 5
    Application = 6
    Mu = 7
    Exists = 8

    # Meta Patterns
    MetaVar = 9
    ESubst = 10
    SSubst = 11

    # Axiom Schemas
    Prop1 = 12
    Prop2 = 13  # TODO: Fix numbering
    Prop3 = 14  # TODO: Fix numbering

    Quantifier = 15
    PropagationOr = 16
    PropagationExists = 17
    PreFixpoint = 18
    Existance = 19
    Singleton = 20

    # Inference rules
    ModusPonens = 21
    Generalization = 22
    Frame = 23
    Substitution = 24
    KnasterTarski = 25

    # Meta Incference rules
    InstantiateNotation = 26
    InstantiateSchema = 27

    # Stack Manipulation
    Pop = 28

    # Memory Manipulation
    Save = 29
    Load = 30

    # Journal Manipulation
    Publish = 31


def pack(input: Iterator[int]) -> bytes:
    """Render into a binary representation.
    For now, we restrict ourselves to 256 distinct symbols, element
    variables, set variables, and metavariables, considered separately,
    and 256 memory locations.
    """

    return bytes(input)
