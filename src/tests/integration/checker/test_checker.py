from __future__ import annotations

from typing import TYPE_CHECKING

import pytest

from proof_generation.checker.checker import Implication, MetaVar, Proved, verify
from proof_generation.checker.instruction import Instruction

if TYPE_CHECKING:
    from proof_generation.checker.checker import Journal, Stack


phi0 = MetaVar(0, (), (), (), ())
phi0_implies_phi0 = Implication(phi0, phi0)

# fmt: off
# 
construct_phi_implies_phi: list[int] = [
    int(Instruction.List), 0, # Fresh
    int(Instruction.List), 0, # Positive
    int(Instruction.List), 0, # Negative
    int(Instruction.List), 0, # Context
    int(Instruction.MetaVar), 0, # Stack: Phi
    int(Instruction.Save),    # @ 0
    int(Instruction.Load), 0, # Phi ; Phi
    int(Instruction.Implication), # Phi -> Phi
]

prove_phi_implies_psi : list[int] = [
          int(Instruction.Prop1),               # (p1: phi0 -> (phi1 -> phi0))

          int(Instruction.List), 0,
          int(Instruction.List), 0,
          int(Instruction.List), 0,
          int(Instruction.List), 0,
          int(Instruction.MetaVar), 1,          # Stack: p1 ; phi1
          int(Instruction.Save),

          int(Instruction.List), 0,
          int(Instruction.List), 0,
          int(Instruction.List), 0,
          int(Instruction.List), 0,
          int(Instruction.MetaVar), 0,          # Stack: p1 ; phi1 ; phi0
          int(Instruction.Save),

          int(Instruction.InstantiateSchema),   # Stack: (p2: phi0 -> (phi0 -> phi0))

          int(Instruction.Prop1),               # Stack: p2 ; p1
          int(Instruction.Load), 0,
          int(Instruction.Load), 1,
          int(Instruction.Load), 1,
          int(Instruction.Implication),         # Stack: p2 ; p1 ; phi1; phi0 -> phi0
          int(Instruction.Save),

          int(Instruction.InstantiateSchema),   # Stack: p2 ; (p3: phi0 -> (phi0 -> phi0) -> phi0)

          int(Instruction.Prop2),
          int(Instruction.Load), 0,
          int(Instruction.Load), 2,
          int(Instruction.InstantiateSchema),
          int(Instruction.List), 0,
          int(Instruction.List), 0,
          int(Instruction.List), 0,
          int(Instruction.List), 0,
          int(Instruction.MetaVar), 2,
          int(Instruction.Load), 1,
          int(Instruction.InstantiateSchema),

          int(Instruction.ModusPonens),
          int(Instruction.ModusPonens),         # Stack: phi0 -> phi0

          int(Instruction.Publish),
        ]

TEST_DATA = [
    ('construct-phi',             construct_phi_implies_phi[0:10],  [phi0],                         []),
    ('construct-phi-implies-psi', construct_phi_implies_phi,        [phi0_implies_phi0],            []),
    ('prove-phi-implies-psi',     prove_phi_implies_psi,            [Proved(phi0_implies_phi0)],    [Proved(phi0_implies_phi0)]),
]
# fmt: on


@pytest.mark.parametrize('id,proof,expected_stack,expected_journal', TEST_DATA, ids=[id for id, _, _, _ in TEST_DATA])
def test_python_checker(
    id: str,
    proof: list[int],
    expected_stack: Stack,
    expected_journal: Journal,
) -> None:
    stack, memory, journal = verify(iter([]), iter(proof))
    assert stack == expected_stack
    assert journal == expected_journal
