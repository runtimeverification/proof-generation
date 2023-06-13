from pathlib import Path

import pytest

from proof_generation.metamath.utils import MetamathUtils
from proof_generation.rewrite.__main__ import main as rewrite_main

REPO_ROOT = (Path(__file__).parents[4]).resolve(strict=True)
TEST_DATA_DIR = (Path(__file__).parents[1] / 'test-data').resolve(strict=True)

PRELUDE_FILE = (REPO_ROOT / 'theory' / 'prelude.mm').resolve(strict=True)
DEFINITIONS_DIR = (TEST_DATA_DIR / 'definitions').resolve(strict=True)
INTEGRATION_DIR = (TEST_DATA_DIR / 'integration').resolve(strict=True)


"""
Each pgm for testing should be place in the `integration` directory
the suffix of the name of pgm should be of the form ".<defn>"
where defn should have a corresponding .kore file under the `definitions` directory

e.g. integration/pgm-1.foo -> definitions/foo.kore

The main module in any definition should be the capitalization of the name of the definition
e.g. foo.kore should have FOO as its main module
typed-lambda.kore should have TYPED_LAMBDA as its main module
"""
TEST_FILES = tuple(INTEGRATION_DIR.glob('*.yml'))


def defn_for(proof_hint: Path) -> Path:
    test_name = proof_hint.name
    pgm_name, defn_name, yml = test_name.split('.')
    assert yml == 'yml'
    defn_file = (DEFINITIONS_DIR / f'{defn_name}.kore').resolve(strict=True)
    return defn_file


TEST_DATA = tuple((proof_hint, defn_for(proof_hint)) for proof_hint in TEST_FILES)


@pytest.mark.parametrize('proof_hint,defn_file', TEST_DATA, ids=[proof_hint.name for proof_hint, _ in TEST_DATA])
def test_rewrite_proof_generator(proof_hint: Path, defn_file: Path, tmp_path: Path) -> None:
    # Given
    module_name = defn_file.stem.upper()

    # When
    rewrite_main(
        [
            str(defn_file),
            module_name,
            '--prelude',
            str(PRELUDE_FILE),
            '--task',
            str(proof_hint),
            '--output',
            str(tmp_path),
        ]
    )

    # Then
    MetamathUtils.verify(tmp_path / 'goal.mm')
