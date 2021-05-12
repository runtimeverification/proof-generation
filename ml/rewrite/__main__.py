import re
import os
import sys
import time
import code
import argparse

from typing import List, Tuple, Optional, Sequence
from io import StringIO

import yaml

from ml.utils.profiler import MemoryProfiler

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


def load_prelude(composer: Composer, args: argparse.Namespace) -> None:
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
) -> None:
    gen = RewriteProofGenerator(env)
    final_claim = gen.prove_rewriting_task(task)
    env.load_comment(f"\nfinal goal:\n{task.initial}\n=>\n{task.final}\n")
    env.load_provable_claim_as_theorem("goal", final_claim)


def output_theory(
    composer: Composer,
    prelude: Optional[str],
    output: str,
    standalone: bool = False,
    include_rewrite_proof: bool = False,
) -> None:
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

                f.write(f"{IncludeStatement(previous_path)}\n")
                composer.encode(f, segment)


def set_additional_flags(parser: argparse.ArgumentParser) -> None:
    parser.add_argument(
        "-sa",
        "--standalone",
        action="store_const",
        const=True,
        default=False,
        help="Output a standalone .mm file",
    )
    parser.add_argument(
        "-o",
        "--output",
        help="Directory to store the translated module and proof object",
    )
    parser.add_argument("--prelude", help="prelude mm file")
    parser.add_argument(
        "--task",
        help="Task description file in YAML. we currently only support rewriting tasks",
    )
    parser.add_argument(
        "--benchmark",
        action="store_const",
        const=True,
        default=False,
        help="Output the time spent for translating module and proving rewriting",
    )
    parser.add_argument(
        "--dv-as-provable",
        action="store_const",
        const=True,
        default=False,
        help="Generate domain facts as provable instead of axiom",
    )
    parser.add_argument(
        "--proof-cache-threshold",
        type=int,
        default=ProofCache.THEOREM_CACHE_THRESHOLD,
        help="Maximum uncached proof size",
    )
    parser.add_argument(
        "--profile-mem",
        action="store_const",
        const=True,
        default=False,
        help="Enable profiler for memory usage",
    )
    parser.add_argument(
        "--profile-mem-n-top",
        type=int,
        default=10,
        help="Number of top memory-consuming items to show when the memory profiler is enable",
    )
    parser.add_argument(
        "--profile-mem-trace-limit",
        type=int,
        default=1,
        help="Trace limit of memory profiler, used only if the memory profiler is enabled",
    )


def get_arguments(argv: Optional[Sequence[str]]) -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("definition", help="Input Kore definition")
    parser.add_argument("module", help="Entry module name")
    set_additional_flags(parser)
    return parser.parse_args(argv)


def run_on_arguments(args: argparse.Namespace) -> None:
    ProofCache.THEOREM_CACHE_THRESHOLD = args.proof_cache_threshold

    if args.profile_mem:
        MemoryProfiler.start(args.profile_mem_trace_limit)

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

    with composer.in_segment("module"):
        env = ProofEnvironment(module, composer, dv_as_provable=args.dv_as_provable)

    module_elapsed = time.time() - module_begin

    # TODO: currently only supports rewriting hints
    rewriting_task: Optional[RewritingTask] = None

    if args.task is not None:
        rewriting_task = load_rewriting_task(module, args.task)

        rewrite_begin = time.time()
        with composer.in_segment("rewrite"):
            prove_rewriting(env, rewriting_task)

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

    if args.profile_mem:
        MemoryProfiler.print_current_snapshot(num_top_stats=args.profile_mem_n_top)
        code.interact(local={**globals(), **vars()})


def main(argv: Optional[Sequence[str]] = None) -> None:
    run_on_arguments(get_arguments(argv))


if __name__ == "__main__":
    sys.setrecursionlimit(4096)
    main()
