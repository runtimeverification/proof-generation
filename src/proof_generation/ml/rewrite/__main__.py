import re
import os
import sys
import time
import code
import argparse

from typing import List, Tuple, Optional, Sequence, ContextManager, Union, Dict
from io import StringIO
from contextlib import nullcontext

import yaml
import schema  # type: ignore

from ml.utils.profiler import MemoryProfiler
from ml.utils.stopwatch import Stopwatch

from ml.kore.parser import parse_definition, parse_pattern, parse_axiom
from ml.kore.visitors import FreePatternVariableVisitor, PatternSubstitutionVisitor
from ml.kore.ast import StringLiteral, MLPattern, Module, Pattern, Claim
from ml.kore.utils import KoreUtils

from ml.metamath.parser import load_database
from ml.metamath.ast import Statement, StructuredStatement, IncludeStatement, Comment
from ml.metamath.composer import Composer, ProofCache
from ml.metamath.backend import Backend, StandaloneFileBackend, MultipleFileBackend, NullBackend, SegmentLabel

from .env import KoreComposer
from .rewrite import RewriteProofGenerator
from .preprocessor import KorePreprocessor
from .disjointness import DisjointnessProofGenerator
from .tasks import RewritingTask, ReachabilityTask
from .smt import SMTOption


def load_tasks(module: Module, task_path: str) -> Tuple[Tuple[RewritingTask, ...], Tuple[ReachabilityTask, ...]]:
    """
    Load all tasks in the document.
    We are expecting either a single rewriting task
    or a list of reachability tasks
    """
    with open(task_path) as task_file:
        rewriting_tasks = []
        reachability_tasks = []

        for doc in yaml.load_all(task_file, Loader=yaml.Loader):
            task: Union[RewritingTask, ReachabilityTask] = schema.Schema(
                schema.Or(
                    ReachabilityTask.get_schema(),
                    RewritingTask.get_schema(),
                )
            ).validate(doc)

            task.resolve(module)

            if isinstance(task, RewritingTask):
                rewriting_tasks.append(task)
            else:
                reachability_tasks.append(task)

        return tuple(rewriting_tasks), tuple(reachability_tasks)


def parse_smt_option(args: argparse.Namespace) -> SMTOption:
    return SMTOption(args.smt_prelude, args.z3_tactic or "default", args.z3_timeout)


def prove_rewriting(
    composer: KoreComposer,
    task: RewritingTask,
    smt_option: SMTOption,
) -> None:
    print("proving symbolic execution")
    gen = RewriteProofGenerator(composer, smt_option)
    gen.prove_symbolic_rewriting_task(task)


def prove_reachability(
    composer: KoreComposer,
    tasks: Tuple[ReachabilityTask, ...],
    smt_option: SMTOption,
) -> None:
    print("proving one-path reachability")
    gen = RewriteProofGenerator(composer, smt_option)
    gen.prove_one_path_reachability_claims(tasks)


def set_additional_flags(parser: argparse.ArgumentParser) -> None:
    parser.add_argument(
        "--standalone",
        action="store_const",
        const=True,
        default=False,
        help="Output a standalone proof object containing all proofs and prelude",
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
    parser.add_argument(
        "-c",
        "--compress",
        action="store_const",
        const=True,
        default=False,
        help=
        "Compress the output proof object using the LZMA algorithm, currently only applicable in the standalone mode",
    )
    parser.add_argument(
        "--smt-prelude",
        help="SMT prelude file",
    )
    parser.add_argument(
        "--z3-tactic",
        help="Tactic to use for z3",
    )
    parser.add_argument(
        "--z3-timeout",
        type=int,
        help="z3 timeout (in ms)",
    )


def get_arguments(argv: Optional[Sequence[str]]) -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("definition", help="Input Kore definition")
    parser.add_argument("module", help="Entry module name")
    set_additional_flags(parser)
    return parser.parse_args(argv)


def get_backend(args: argparse.Namespace) -> ContextManager[Backend]:
    """
    Create a backend according to the given arguments
    """

    if args.standalone:
        assert args.output is not None, "--standalone given without specifying the output file"

        if args.compress:
            output_path = args.output + ".xz"
            print(f"storing standalone and compressed proof object at {output_path}")
        else:
            output_path = args.output
            print(f"storing standalone proof object at {output_path}")

        return StandaloneFileBackend(output_path, compression=args.compress)

    elif args.output is not None:
        if args.prelude is not None:
            prelude_deps: Tuple[str, ...] = (os.path.realpath(args.prelude), )
        else:
            prelude_deps = ()

        # layout of the output proof object
        layout = (
            (None, None, ()),  # ignore all statements without assigned segment (e.g. prelude)
            ("variable", "variable.mm", prelude_deps),
            ("sort", "module-sort.mm", ("variable", )),
            ("symbol", "module-symbol.mm", ("sort", )),
            ("dv", "dv.mm", ("symbol", )),
            ("module", "module-axiom.mm", ("dv", )),
            ("substitution", "substitution.mm", ("module", )),
            ("rewrite", "goal.mm", ("substitution", )),
        )

        print(f"storing separated proof objects in {args.output}")

        return MultipleFileBackend(args.output, layout)
    else:
        return nullcontext(NullBackend())


def run_on_arguments(args: argparse.Namespace) -> None:
    stopwatch = Stopwatch()

    ProofCache.THEOREM_CACHE_THRESHOLD = args.proof_cache_threshold

    if args.profile_mem:
        MemoryProfiler.start(args.profile_mem_trace_limit)

    with get_backend(args) as backend:
        # initialize proof environment
        env = KoreComposer(backend=backend, dv_as_provable=args.dv_as_provable)

        # load prelude into the proof environment
        # if we are outputting standalone proof object, then include the proof
        if args.prelude is not None:
            env.load(load_database(args.prelude, include_proof=args.standalone))

        # parse the input kore definition
        with open(args.definition) as f:
            definition = parse_definition(f.read())
            definition.resolve()

        # do some preliminary transformations and add missing axioms
        KorePreprocessor().preprocess(definition)
        module = definition.module_map[args.module]

        with stopwatch.start("module"), env.in_segment("module"):
            env.load_module(module)

        if args.task is not None:
            rewriting_tasks, reachability_tasks = load_tasks(module, args.task)

            smt_option = parse_smt_option(args)

            if len(rewriting_tasks) != 0:
                assert len(reachability_tasks) == 0 and len(rewriting_tasks) == 1
                with stopwatch.start("rewrite"), env.in_segment("rewrite"):
                    prove_rewriting(env, rewriting_tasks[0], smt_option)

            else:
                assert len(reachability_tasks) != 0
                with stopwatch.start("rewrite"), env.in_segment("rewrite"):
                    prove_reachability(env, reachability_tasks, smt_option)

    if args.benchmark:
        module_elapsed = stopwatch.get_elapsed("module")
        rewrite_elapsed = stopwatch.get_elapsed("rewrite")

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
