from pathlib import Path

from pyk.testing import KompiledTest

from proof_generation.kore.parser import parse_definition
from proof_generation.rewrite.llvm_proof_hint import LLVMRewriteTrace


class TestLLVMProofHint(KompiledTest):
    KOMPILE_MAIN_FILE = 'examples/imp/imp.k'
    KOMPILE_BACKEND = 'llvm'

    def test_parse_proof_hint(self, definition_dir: Path) -> None:
        bin_hint = Path('examples/imp/sum.imp.proof-hint').read_bytes()
        hint = LLVMRewriteTrace.parse(bin_hint)
        assert len(hint.trace) == 15

        kore_file = definition_dir / 'definition.kore'
        definition = parse_definition(kore_file.read_text())

        task = hint.to_task(definition)
        assert len(task.steps) == 15
