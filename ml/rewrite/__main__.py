import re
import os
import sys
import time
import argparse

from typing import List, Optional
from io import StringIO

from ml.kore.parser import parse_definition, parse_pattern
from ml.kore.visitors import FreePatternVariableVisitor, PatternSubstitutionVisitor
from ml.kore.ast import StringLiteral, MLPattern, Module, Pattern
from ml.kore.utils import KoreUtils

from ml.metamath.parser import load_database
from ml.metamath.ast import Statement, StructuredStatement, IncludeStatement, Comment
from ml.metamath.composer import Composer

from .env import ProofEnvironment
from .rewrite import RewriteProofGenerator


def load_prelude(composer: Composer, args):
    # if we are not outputing a standalone proof object
    # there is no need to load proofs (which are huge)
    prelude = load_database(args.prelude, include_proof=args.standalone)
    composer.load(prelude)


"""
Load all snapshots in a directory
as patterns in the given module
"""
def load_snapshots(module: Module, snapshot_dir: str) -> List[Pattern]:
    snapshots = {}
    max_step = 0

    for file_name in os.listdir(snapshot_dir):
        match = re.match(r"[^\d]*(\d+)\.kore", file_name)
        if match is not None:
            step = int(match.group(1))
            assert step not in snapshots, "duplicated snapshot for step {}".format(step)

            max_step = max(max_step, step)

            full_path = os.path.join(snapshot_dir, file_name)
            with open(full_path) as snapshot:
                # parse each snapshot
                snapshot_pattern = parse_pattern(snapshot.read())

                # resolve all references in the specified module
                snapshot_pattern.resolve(module)
                snapshots[step] = snapshot_pattern

    snapshots = [ snapshots[i] for i in range(max_step + 1) ]

    return snapshots


"""
Given a list of snapshots, prove that the first snapshot
rewrites to the second snapshot, and load all proofs into
the environment
"""
def prove_rewriting(env: ProofEnvironment, snapshots: List[Pattern]):
    gen = RewriteProofGenerator(env)

    final_claim = gen.prove_multiple_rewrite_steps(snapshots)
    env.load_comment(f"\nfinal goal:\n{snapshots[0]}\n=>\n{snapshots[-1]}\n")
    env.load_provable_claim_as_theorem("goal", final_claim)


"""
Output to a standalone .mm file or a directory containing
multiple interdepdent theories
"""
def output_theory(composer: Composer, prelude: Optional[str], output: str, standalone=False, include_rewrite_proof=False):
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


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("definition", help="a kore file")
    parser.add_argument("module", help="the entry module name")
    parser.add_argument("-sa", "--standalone", action="store_const", const=True, default=False, help="output a standalone .mm file")
    parser.add_argument("-o", "--output", help="directory to store the translated module and proof object")
    parser.add_argument("--prelude", help="prelude mm file")
    parser.add_argument("--snapshots", help="directory containing all snapshots in the format *-<step number>.kore")
    parser.add_argument("--benchmark", action="store_const", const=True, default=False, help="output the time spent for translating module and proving rewriting")
    args = parser.parse_args()

    composer = Composer()

    with open(args.definition) as f:
        print("parsing kore definition")
        definition = parse_definition(f.read())
        definition.resolve()

    if args.prelude is not None:
        load_prelude(composer, args)

    module = definition.module_map[args.module]
    env = ProofEnvironment(composer)

    module_begin = time.time()

    composer.start_segment("module")
    env.load_module(module)
    composer.end_segment()

    module_elapsed = time.time() - module_begin

    print("loading snapshots")

    # emit claims about each rewriting step if shapshots are given
    if args.snapshots is not None:
        snapshots = load_snapshots(module, args.snapshots)

        if len(snapshots) >= 2:
            rewrite_begin = time.time()
            composer.start_segment("rewrite")
            prove_rewriting(env, snapshots)
            composer.end_segment()
            rewrite_elapsed = time.time() - rewrite_begin
        else:
            rewrite_elapsed = 0
            print("only one snapshot, nothing to prove")

    if args.output is not None:
        output_theory(composer, args.prelude, args.output, standalone=args.standalone, include_rewrite_proof=args.snapshots is not None)

    if args.benchmark:
        print("==================")
        print(f"gen-module {module_elapsed}")
        print(f"gen-rewrite {rewrite_elapsed}")
        print(f"gen-total {module_elapsed + rewrite_elapsed}")


if __name__ == "__main__":
    sys.setrecursionlimit(4096)
    main()
