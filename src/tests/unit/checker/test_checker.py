from proof_generation.checker.checker import Implication, MetaVar, Proved, verify
from proof_generation.checker.instruction import Instruction


def test_construct_phi_implies_phi() -> None:
    # fmt: off
    proof : list[int] = [
              int(Instruction.List), 0, # Fresh
              int(Instruction.List), 0, # Positive
              int(Instruction.List), 0, # Negative
              int(Instruction.List), 0, # Context
              int(Instruction.MetaVar), 0, # Stack: Phi
              int(Instruction.Save),    # @ 0
              int(Instruction.Load), 0, # Phi ; Phi
              int(Instruction.Implication), # Phi -> Phi
            ]
    # fmt: on
    phi = MetaVar(0, (), (), (), ())
    stack, memory, journal = verify(iter([]), iter(proof[0:10]))
    assert stack == [phi], stack
    stack, memory, journal = verify(iter([]), iter(proof))
    assert stack == [Implication(phi, phi)], stack


def test_prove_phi_implies_phi() -> None:
    # fmt: off
    proof : list[int] = [
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
    # fmt: on
    phi0 = MetaVar(0, (), (), (), ())
    stack, memory, journal = verify(iter([]), iter(proof[0:55]))
    assert stack == [Proved(Implication(phi0, phi0))], stack
