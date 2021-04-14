import unittest

import os
import shutil
import tempfile

from ml.rewrite.__main__ import main as rewrite_main


class TestIntegrationBase(unittest.TestCase):
    def setUp(self):
        self.output_proof_dir = tempfile.mkdtemp()

    def tearDown(self):
        shutil.rmtree(self.output_proof_dir)

    def run_rewrite_proof_gen(self, pgm: str):
        """
        pgm should point to a directory under the `integration` directory
        the suffix of the name of pgm should be of the form ".<defn>"
        where defn should have a corresponding .kore file under the `definitions` directory
        
        e.g. integration/pgm-1.foo -> definitions/foo.kore

        The main module in any definition should be the capitalization of the name of the definition
        e.g. foo.kore should have FOO as its main module
        typed-lambda.kore should have TYPED_LAMBDA as its main module
        """

        assert os.path.isdir(self.output_proof_dir)

        definitions_path = os.path.join("tests", "definitions")
        integration_path = os.path.join("tests", "integration")
        prelude_path = os.path.join("theory", "prelude.mm")

        assert os.path.isdir(definitions_path) and \
               os.path.isdir(integration_path) and \
               os.path.isfile(prelude_path), \
               "not in the right directory"

        pgm_path = os.path.join(integration_path, pgm)
        assert os.path.isdir(pgm_path), \
               f"cannot find program path {pgm_path}"

        definition_name = pgm.split(".")[-1]
        definition_path = os.path.join(definitions_path, f"{definition_name}.kore")

        assert os.path.isfile(definition_path), \
               f"cannot find definition {definition_path} inferred from program name {pgm}"

        module_name = definition_name.upper().replace("-", "_")

        rewrite_main(
            [
                definition_path,
                module_name,
                "--prelude",
                prelude_path,
                "--snapshots",
                pgm_path,
                "--output",
                self.output_proof_dir,
            ]
        )


class TestRewriteProofGeneratorIntegeration(TestIntegrationBase):
    def test_rewrite_proof_gen(self):
        self.run_rewrite_proof_gen("pgm-1.foo")
        self.run_rewrite_proof_gen("pgm-1.lambda")
        self.run_rewrite_proof_gen("pgm-1.imp")

        # TODO: verify using metamath
