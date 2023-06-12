from pathlib import Path

from proof_generation.rewrite.llvm_proof_hint import LLVMRewriteTrace


def test_parse_proof_hint() -> None:
    bin_hint = Path('examples/proof-hints.bin').read_bytes()
    hint = LLVMRewriteTrace.parse(bin_hint)
    assert len(hint.trace) == 64
    # TODO: Strenghten these assertions.
