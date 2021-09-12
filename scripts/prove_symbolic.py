from typing import List, Optional, Mapping, Tuple, BinaryIO, Dict, Any

import os
import re
import sys
import shlex
import shutil
import argparse
import subprocess

import yaml

from tempfile import NamedTemporaryFile

import ml.kore.ast as kore
from ml.kore.ast import KoreVisitor
from ml.kore.parser import parse_definition, parse_pattern
from ml.kore.visitors import PatternOnlyVisitorStructure

from ml.utils.ansi import ANSI

from ml.rewrite.__main__ import run_on_arguments, set_additional_flags


def run_command(command: List[str], **kwargs: Any) -> subprocess.Popen:  # type: ignore
    command_str = " ".join([shlex.quote(frag) for frag in command])
    print(f"{ANSI.in_gray('+ ' + command_str)}", file=sys.stderr)
    return subprocess.Popen(command, **kwargs)


def get_mtime(path: str) -> float:
    if not os.path.exists(path):
        return -1
    return os.stat(path).st_mtime


def check_dependency_change(targets: List[str], dependencies: List[str]) -> bool:
    """
    Check if any of the dependencies is younger than
    any of the targets
    """
    min_target_mtime = min([get_mtime(path) for path in targets])
    max_dep_mtime = max([get_mtime(path) for path in dependencies])
    return max_dep_mtime > min_target_mtime


def gen_task_legacy(kompiled_dir: str, pgm: str) -> Dict[str, Any]:
    """
    Generate hints without modified backend
    This will not include substitutions or rule ids
    """

    # generate the initial configuration
    # TODO: technically initial configuration is also generated through equations
    # in the kore definition, but we are skipping that since we don't support map yet.
    proc = run_command(
        [
            "kast",
            "--directory",
            kompiled_dir,
            "--output",
            "kore",
            pgm,
        ],
        stdout=subprocess.PIPE,
    )
    assert proc.stdout is not None
    init_config = proc.stdout.read().decode()
    exit_code = proc.wait()
    assert exit_code == 0, f"kast failed with exit code {exit_code}"

    # generate snapshots from step 1 to the end
    # (the initial configuration has to be obtained differently)
    current_depth = 0

    last_config = None
    snapshots = []

    while True:
        proc = run_command(
            [
                "krun",
                "--directory",
                kompiled_dir,
                "--depth",
                str(current_depth),
                "--output",
                "kore",
                pgm,
            ],
            stdout=subprocess.PIPE,
        )
        assert proc.stdout is not None
        stdout = proc.stdout.read().decode()
        exit_code = proc.wait()
        assert exit_code == 0, f"krun failed with exit code {exit_code}"

        if last_config != stdout:
            snapshots.append(stdout)
            last_config = stdout
        else:
            break

        current_depth += 1

    steps = []
    for from_pattern, to_pattern in zip(snapshots[:-1], snapshots[1:]):
        steps.append({
            "initial": from_pattern,
            "applied-rules": [{
                "results": [to_pattern],
            }],
            "remainders": [],
        })

    return {
        "task": "rewriting",
        # call the initializer: LblinitGeneratedTopCell({ $PGM -> <init config> })
        "initial":
        f"""LblinitGeneratedTopCell{{}}(Lbl'UndsPipe'-'-GT-Unds'{{}}(inj{{SortKConfigVar{{}},SortKItem{{}}}}(\\dv{{SortKConfigVar{{}}}}("$PGM")),{init_config}))""",
        "finals": [snapshots[-1]],
        "steps": steps,
    }


def gen_task(kompiled_dir: str, output_task_path: str, pgm: str, kore_definition: str, module_name: str) -> None:
    if pgm.endswith(".kore"):
        cmd = [
            "kore-exec",
            kore_definition,
            "--module",
            module_name,
            # to print logs about rewriting and substitutions
            "--trace-rewrites",
            output_task_path,
            "--pattern",
            pgm,
        ]
    else:
        cmd = [
            "krun",
            "--directory",
            kompiled_dir,
            "--haskell-backend-command",
            # to print logs about rewriting and substitutions
            f"kore-exec --trace-rewrites {output_task_path}",
            "--output",
            "none",
            pgm,
        ]

    proc = run_command(cmd, stdout=subprocess.DEVNULL)
    exit_code = proc.wait()
    assert exit_code == 0, f"krun/kore-exec failed with exit code {exit_code}"


def gen_proof(args: argparse.Namespace) -> None:
    kdef = os.path.realpath(args.kdef)
    pgm = os.path.realpath(args.pgm)
    module = args.module
    no_backend_hints = args.no_backend_hints

    del args.kdef
    del args.pgm
    del args.module
    del args.no_backend_hints

    if args.output is not None:
        args.output = os.path.realpath(args.output)

    # get kdef file name (without extension)
    kdef_basename = os.path.basename(kdef)
    # assert kdef_basename.endswith(".k"), f"{kdef} should have .k suffix"
    kdef_name = kdef_basename[:-2]
    pgm_name, _ = os.path.splitext(os.path.basename(pgm))

    work_dir = os.path.dirname(kdef)

    # cache directory (storing kompiled data)
    cache_dir = os.path.join(work_dir, f".ml-proof-cache-{kdef_name}")
    if not os.path.isdir(cache_dir):
        os.mkdir(cache_dir)

    ### step 1. kompile the given k definition
    if args.kompiled_dir is None:
        print(f"- kompiling {kdef}")

        kompiled_dir = os.path.join(cache_dir, f"{kdef_name}-kompiled")
        kompile_timestamp = os.path.join(kompiled_dir, "timestamp")

        if check_dependency_change([kompile_timestamp], [kdef]):
            proc = run_command(
                [
                    "kompile",
                    "--backend",
                    "haskell",
                    "--directory",
                    cache_dir,
                    "--main-module",
                    module,
                    "--debug",
                    kdef,
                ]
            )
            exit_code = proc.wait()
            assert exit_code == 0, f"kompiled failed with exit code {exit_code}"
    else:
        print(f"- using an existing kompiled dir {args.kompiled_dir}")
        kompiled_dir = args.kompiled_dir
        if kompiled_dir.endswith("/"):
            kompiled_dir = kompiled_dir[:-1]
        kompile_timestamp = os.path.join(kompiled_dir, "timestamp")

    ### step 2. generate snapshots and rewriting information
    print(f"- generating snapshots")
    kore_definition = os.path.join(kompiled_dir, "definition.kore")
    task_path = os.path.join(cache_dir, f"rewriting-task-{pgm_name}.yml")

    if check_dependency_change([task_path], [kompile_timestamp, pgm]):
        if no_backend_hints:
            task_obj = gen_task_legacy(os.path.dirname(kompiled_dir), pgm)
            with open(task_path, "w") as f:
                yaml.dump(task_obj, f)
        else:
            gen_task(os.path.dirname(kompiled_dir), task_path, pgm, kore_definition, module)

    ### step 3. generate proof object
    print(f"- generating proof")

    args.definition = kore_definition
    args.module = module
    if args.prelude is None:
        args.prelude = "theory/prelude.mm"
    args.task = task_path

    run_on_arguments(args)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("kdef", help="Input K definition")
    parser.add_argument("module", help="Input main module name")
    parser.add_argument("pgm", help="Program to run")
    parser.add_argument(
        "--no-backend-hints",
        action="store_const",
        const=True,
        default=False,
        help="Do not use/expect hints from the backend but generate snapshots using well-defined interface",
    )
    parser.add_argument(
        "--kompiled-dir",
        help="Use an existing compiled directory instead of rekompiling",
    )
    set_additional_flags(parser)
    args = parser.parse_args()
    gen_proof(args)


if __name__ == "__main__":
    main()
