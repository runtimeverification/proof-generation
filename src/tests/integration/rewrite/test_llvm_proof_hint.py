from pathlib import Path

from pyk.testing import KompiledTest

from proof_generation.metamath.parser import load_database
from proof_generation.kore.parser import parse_definition
from proof_generation.metamath.backend import StandaloneFileBackend
from proof_generation.metamath.utils import MetamathUtils
from proof_generation.rewrite.env import KoreComposer
from proof_generation.rewrite.llvm_proof_hint import LLVMRewriteTrace, make_ordinal_list
from proof_generation.rewrite.preprocessor import KorePreprocessor
from proof_generation.rewrite.rewrite import RewriteProofGenerator


class TestLLVMProofHint(KompiledTest):
    KOMPILE_MAIN_FILE = 'examples/imp/imp.k'
    KOMPILE_BACKEND = 'llvm'

    def test_parse_proof_hint(self, definition_dir: Path, tmp_path: Path) -> None:
        bin_hint = Path('examples/imp/sum.imp.proof-hint').read_bytes()
        hint = LLVMRewriteTrace.parse(bin_hint)

        kore_file = definition_dir / 'definition.kore'
        definition = parse_definition(kore_file.read_text())
        ordinal_list = make_ordinal_list(definition)
        definition.resolve()
        KorePreprocessor().preprocess(definition)

        task = hint.to_task(ordinal_list)
        main_module = definition.module_map['IMP']
        task.resolve(main_module)

        metamath_proof = tmp_path / 'sum.mm'
        with StandaloneFileBackend(str(metamath_proof)) as backend:
            composer = KoreComposer(backend=backend, dv_as_provable=False)
            composer.load(load_database('theory/prelude.mm'))

            print('proof-file', metamath_proof)
            composer.load_module(main_module)
            gen = RewriteProofGenerator(composer)
            gen.prove_symbolic_rewriting_task(task)
            print(tmp_path)

        MetamathUtils.verify(metamath_proof)

