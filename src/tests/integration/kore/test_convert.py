from pyk.kllvm import load

load  # Only needed to quench the autoformatter.

from pathlib import Path

import pyk.kore.syntax as pyk_kore

import proof_generation.kore.ast as pg_kore
from proof_generation.kore.convert import from_binkore

PykSortVar = pyk_kore.SortVar
PykSortApp = pyk_kore.SortApp
PykPattern = pyk_kore.Pattern
PGSortVariable = pg_kore.SortVariable
PGSortInstance = pg_kore.SortInstance


def test_from_binkore() -> None:
    binkore = Path('./deps/k/llvm-backend/src/main/native/llvm-backend/test/input/test_61.in').read_bytes()
    kore = from_binkore(binkore)
    assert str(kore).startswith(
        "inj{SortTUBunch{}, SortKItem{}}(Lbltubunch{}(kseq{}(inj{SortGeneratedTopCell{}, SortKItem{}}(Lbl'-LT-'generatedTop'-GT-'{}(Lbl'-LT-'phase'-GT-'{}(Lbltranslate'Unds'C-PHASE'Unds'Phase{}()), Lbl'Stop'StateCell{}()"
    )
