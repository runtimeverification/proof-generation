import re
import os
import sys
import time
import argparse

from typing import List, Tuple, Optional, Sequence
from io import StringIO

import yaml

from ml.kore.parser import parse_definition, parse_pattern
from ml.kore.visitors import FreePatternVariableVisitor, PatternSubstitutionVisitor
from ml.kore.ast import StringLiteral, MLPattern, Module, Pattern
from ml.kore.utils import KoreUtils

from ml.metamath.parser import load_database
from ml.metamath.ast import Statement, StructuredStatement, IncludeStatement, Comment
from ml.metamath.composer import Composer, ProofCache

from .env import ProofEnvironment
from .rewrite import RewriteProofGenerator
from .preprocessor import KorePreprocessor
from .disjointness import DisjointnessProofGenerator
from .tasks import RewritingTask


def load_prelude(composer: Composer, args):
    # if we are not outputing a standalone proof object
    # there is no need to load proofs (which are huge)
    prelude = load_database(args.prelude, include_proof=args.standalone)
    composer.load(prelude)


def load_rewriting_task(module: Module, task_path: str) -> RewritingTask:
    """
    Load all rewriting information in a directory
    as substitutions (lists of tuples of patterns) in the given module
    """
    with open(task_path) as task_file:
        loaded_obj = yaml.load(task_file, Loader=yaml.Loader)
        return RewritingTask.load_from_object(module, loaded_obj)


def prove_rewriting(
    env: ProofEnvironment,
    task: RewritingTask,
):
    gen = RewriteProofGenerator(env)
    final_claim = gen.prove_rewriting_task(task)
    env.load_comment(f"\nfinal goal:\n{task.initial}\n=>\n{task.final}\n")
    env.load_provable_claim_as_theorem("goal", final_claim)


def output_theory(
    composer: Composer,
    prelude: Optional[str],
    output: str,
    standalone=False,
    include_rewrite_proof=False,
):
    """
    Output to a standalone .mm file or a directory containing
    multiple interdepdent theories
    """
    if standalone:
        assert not os.path.isdir(output), f"path {output} exists and is a directory"
        print(f"dumping standalone metamath theory to {output}")
        with open(output, "w") as out:
            composer.encode(out)
    else:
        assert not os.path.isfile(output), f"path {output} exists and is a file"
        print(f"dumping multiple metamath theories to {output}")

        if not os.path.isdir(output):
            os.mkdir(output)

        assert prelude is not None

        abs_output_path = os.path.realpath(output)
        abs_prelude_path = os.path.realpath(prelude)
        assert abs_output_path is not None and abs_prelude_path is not None

        output_list = [
            ("variable", "variable.mm"),
            ("sort", "module-sort.mm"),
            ("symbol", "module-symbol.mm"),
            ("dv", "dv.mm"),
            ("module", "module-axiom.mm"),
        ]

        if include_rewrite_proof:
            output_list += [
                ("substitution", "substitution.mm"),
                ("rewrite", "goal.mm"),
            ]

        for i, (segment, output_path) in enumerate(output_list):
            full_path = os.path.join(abs_output_path, output_path)
            with open(full_path, "w") as f:
                # include the last file
                if i == 0:
                    previous_path = abs_prelude_path
                else:
                    previous_path = os.path.join(abs_output_path, output_list[i - 1][1])

                IncludeStatement(previous_path).encode(f)
                f.write("\n")
                composer.encode(f, segment)


def main(argv: Optional[Sequence[str]] = None):
    parser = argparse.ArgumentParser()
    parser.add_argument("definition", help="a kore file")
    parser.add_argument("module", help="the entry module name")
    parser.add_argument(
        "-sa",
        "--standalone",
        action="store_const",
        const=True,
        default=False,
        help="output a standalone .mm file",
    )
    parser.add_argument(
        "-o",
        "--output",
        help="directory to store the translated module and proof object",
    )
    parser.add_argument("--prelude", help="prelude mm file")
    parser.add_argument(
        "--task",
        help="a task description file in YAML. we currently only support rewriting tasks",
    )
    parser.add_argument(
        "--benchmark",
        action="store_const",
        const=True,
        default=False,
        help="output the time spent for translating module and proving rewriting",
    )
    parser.add_argument(
        "--dv-as-provable",
        action="store_const",
        const=True,
        default=False,
        help="generate domain facts as provable instead of axiom",
    )
    parser.add_argument(
        "--proof-cache-threshold",
        type=int,
        default=ProofCache.THEOREM_CACHE_THRESHOLD,
        help="maximum uncached proof size",
    )
    args = parser.parse_args(argv)

    # TODO: this is a bit hacky
    ProofCache.THEOREM_CACHE_THRESHOLD = args.proof_cache_threshold

    composer = Composer()

    with open(args.definition) as f:
        definition = parse_definition(f.read())
        definition.resolve()

    if args.prelude is not None:
        load_prelude(composer, args)

    # do some preliminary transformations
    # and add missing axioms
    KorePreprocessor().preprocess(definition)

    module = definition.module_map[args.module]

    module_begin = time.time()

    composer.start_segment("module")
    env = ProofEnvironment(module, composer, dv_as_provable=args.dv_as_provable)
    composer.end_segment()

    module_elapsed = time.time() - module_begin

    # TODO: currently only supports rewriting hints
    rewriting_task: Optional[RewritingTask] = None

    if args.task is not None:
        rewriting_task = load_rewriting_task(module, args.task)

        rewrite_begin = time.time()
        composer.start_segment("rewrite")
        prove_rewriting(env, rewriting_task)
        composer.end_segment()
        rewrite_elapsed = time.time() - rewrite_begin

    if args.output is not None:
        output_theory(
            composer,
            args.prelude,
            args.output,
            standalone=args.standalone,
            include_rewrite_proof=args.task is not None,
        )

    if args.benchmark:
        print("==================")
        print(f"gen-module {module_elapsed}")
        print(f"gen-rewrite {rewrite_elapsed}")
        print(f"gen-total {module_elapsed + rewrite_elapsed}")


if __name__ == "__main__":
    sys.setrecursionlimit(4096)
    main()
