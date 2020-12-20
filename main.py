import re
import os
import sys
import argparse

from typing import List, Optional
from io import StringIO

from proof.kore.parser import parse_definition, parse_pattern
from proof.kore.visitors import FreePatternVariableVisitor, PatternSubstitutionVisitor
from proof.kore.ast import StringLiteral, MLPattern, Module, Pattern
from proof.kore.utils import KoreUtils

from proof.metamath.parser import load_database
from proof.metamath.ast import Statement, StructuredStatement, IncludeStatement, Comment
from proof.metamath.composer import Composer

from proof.env import ProofEnvironment
from proof.rewrite import RewriteProofGenerator


def load_prelude(composer: Composer, path: str):
    prelude = load_database(path)
    composer.load(prelude)


"""
Load all snapshots in a directory
as patterns in the given module
"""
def load_snapshots(module: Module, snapshot_dir: str) -> List[Pattern]:
    snapshots = {}
    max_step = 0

    for file_name in os.listdir(snapshot_dir):
        match = re.match(r".*_(\d+)\.kore", file_name)
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

    step_theorems = []

    for step, (from_pattern, to_pattern) in enumerate(zip(snapshots[:-1], snapshots[1:])):
        print("==================")
        print("proving rewriting step {}".format(step))
        # search for the axiom to use and try to get a proof
        proof = gen.prove_rewrite_step(from_pattern, to_pattern)
        proof.statement.label = f"step-{step}"

        env.load_comment(f"\nrewriting step {step}:\n{from_pattern}\n=>\n{to_pattern}\n")
        step_theorems.append(env.load_metamath_statement(proof.statement))

    print("==================")
    print("chaining steps to prove the final goal")
    multiple_steps_proof = gen.chain_rewrite_steps(step_theorems)
    multiple_steps_proof.statement.label = "goal"

    env.load_comment(f"\nfinal goal:\n{snapshots[0]}\n=>\n{snapshots[-1]}\n")
    env.load_metamath_statement(multiple_steps_proof.statement)


"""
Output to a standalone .mm file or a directory containing
multiple interdepdent theories
"""
def output_theory(composer: Composer, prelude: Optional[str], output: str, standalone=False, include_rewrite_proof=False):
    if standalone:
        assert not os.path.isdir(output), f"path {output} exists and is a directory"
        print(f"dumping to standalone metamath theory {output}")
        with open(output, "w") as out:
            composer.encode(out)
    else:
        assert not os.path.isfile(output), f"path {output} exists and is a file"
        print(f"dumping to multiple metamath theories in {output}")

        if not os.path.isdir(output):
            os.mkdir(output)

        abs_output_path = os.path.realpath(output)
        abs_prelude_path = os.path.realpath(prelude)
        assert abs_output_path is not None and abs_prelude_path is not None

        module_path = os.path.join(abs_output_path, "module.mm")
        dv_path = os.path.join(abs_output_path, "dv.mm")
        proof_path = os.path.join(abs_output_path, "proof.mm")

        # dump the translated module
        with open(module_path, "w") as module_file:
            IncludeStatement(abs_prelude_path).encode(module_file)
            module_file.write("\n")
            composer.encode(module_file, "module")

        if include_rewrite_proof:
            rewrite_segment = composer.get_segment("rewrite")

            dv_segment = []
            proof_segment = []

            # TODO: this is a bit of a hack
            for i, stmt in enumerate(rewrite_segment):
                if isinstance(stmt, StructuredStatement):
                    if stmt.label is not None and (stmt.label.startswith("step-") or stmt.label == "goal"):
                        proof_segment.append(stmt)
                    else:
                        dv_segment.append(stmt)
                    continue
                elif isinstance(stmt, Comment):
                    if i + 1 < len(rewrite_segment):
                        next_stmt = rewrite_segment[i + 1]
                        if next_stmt.label is not None and (next_stmt.label.startswith("step-") or next_stmt.label == "goal"):
                            proof_segment.append(stmt)
                            continue

                dv_segment.append(stmt)

            with open(dv_path, "w") as dv_file:
                IncludeStatement(module_path).encode(dv_file)
                dv_file.write("\n")
                for stmt in dv_segment:
                    stmt.encode(dv_file)
                    dv_file.write("\n")

            with open(proof_path, "w") as proof_file:
                IncludeStatement(dv_path).encode(proof_file)
                proof_file.write("\n")
                for stmt in proof_segment:
                    stmt.encode(proof_file)
                    proof_file.write("\n")


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("definition", help="a kore file")
    parser.add_argument("module", help="the entry module name")
    parser.add_argument("-sa", "--standalone", action="store_const", const=True, default=False, help="output a standalone .mm file")
    parser.add_argument("-o", "--output", help="directory to store the translated module and proof object")
    parser.add_argument("--prelude", help="prelude mm file")
    parser.add_argument("--snapshots", help="directory containing all snapshots in the format *-<step number>.kore")
    args = parser.parse_args()

    composer = Composer()

    with open(args.definition) as f:
        print("parsing kore definition")
        definition = parse_definition(f.read())
        definition.resolve()

    if args.prelude is not None:
        load_prelude(composer, args.prelude)

    composer.start_segment("module")

    module = definition.module_map[args.module]
    env = ProofEnvironment(module, composer)

    composer.end_segment("module")

    print("loading snapshots")

    # emit claims about each rewriting step if shapshots are given
    if args.snapshots is not None:
        snapshots = load_snapshots(module, args.snapshots)

        if len(snapshots) >= 2:
            composer.start_segment("rewrite")
            prove_rewriting(env, snapshots)
            composer.end_segment("rewrite")
        else:
            print("only one snapshot, nothing to prove")

    if args.output is not None:
        output_theory(composer, args.prelude, args.output, standalone=args.standalone, include_rewrite_proof=args.snapshots is not None)


if __name__ == "__main__":
    sys.setrecursionlimit(4096)
    main()
