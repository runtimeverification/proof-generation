from typing import List, Optional, Mapping, Tuple, BinaryIO, Dict, Any

import os
import re
import sys
import shlex
import shutil
import argparse
import subprocess

import yaml

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


def parse_kore_log(log_src: str) -> List[Tuple[str, str]]:
    """
    Parse kore log and return a list of
    (<log name>, <message content>)

    assumed log format:
    kore-exec: [some number] <level> (<log name>):
    ...
    kore-exec: [some number] <level> (<log name>):
    ...
    """

    log_items: List[Tuple[str, str]] = []
    current_item: Optional[str] = None
    current_content: List[str] = []

    for line in log_src.split("\n"):
        match = re.match(r"kore-exec: \[\d+\] \w+ \((\w+)\):", line)
        if match is not None:
            if current_item is not None:
                content = "\n".join(current_content)
                log_items.append((current_item, content))

            current_item = match.group(1)
            current_content = []
        else:
            current_content.append(line)

    if current_item is not None:
        content = "\n".join(current_content)
        log_items.append((current_item, content))

    return log_items


class Initializer(KoreVisitor[kore.Pattern, kore.Pattern], PatternOnlyVisitorStructure[kore.Pattern, kore.Pattern]):
    def __init__(self, initializer_axioms: Mapping[str, kore.Pattern], pgm_pattern: kore.Pattern):
        super().__init__()
        self.initializer_axioms = initializer_axioms
        self.pgm_pattern = pgm_pattern

    def postvisit_application(self, application: kore.Application, arguments: List[kore.Pattern]) -> kore.Pattern:
        symbol_name = application.symbol.get_symbol_name()

        if symbol_name in self.initializer_axioms:
            return self.visit(self.initializer_axioms[symbol_name])

        if symbol_name.startswith("Lblproject'Coln'"):
            assert isinstance(self.pgm_pattern, kore.Application)
            return self.pgm_pattern

        application.arguments = arguments
        return application


def gen_init_config(kore_def_path: str, module: str, pgm_src: str) -> str:
    with open(kore_def_path) as f:
        definition = parse_definition(f.read())

    pgm_pattern = parse_pattern(pgm_src)
    main_module = definition.module_map[module]

    # find the initializer axioms, starting from LblinitGeneratedTopCell
    initializer_axioms = {}  # symbol -> term

    for axiom in main_module.axioms:
        if axiom.get_attribute_by_symbol("initializer") is not None:
            assert (
                isinstance(axiom.pattern, kore.MLPattern) and isinstance(axiom.pattern.arguments[1], kore.MLPattern)
                and isinstance(axiom.pattern.arguments[1].arguments[0], kore.MLPattern)
            )

            equation = axiom.pattern.arguments[1].arguments[0]
            lhs, rhs = equation.arguments
            assert isinstance(lhs, kore.Application)

            symbol_name = lhs.symbol.get_symbol_name()
            initializer_axioms[symbol_name] = rhs

    assert "LblinitGeneratedTopCell" in initializer_axioms
    init_config_pattern = Initializer(initializer_axioms,
                                      pgm_pattern).visit(initializer_axioms["LblinitGeneratedTopCell"])

    return f"inj{{SortGeneratedTopCell{{}}, SortKItem{{}}}}({init_config_pattern})"


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
    for from_pattern in snapshots[:-1]:
        steps.append({
            "type": "rewriting",
            "from": from_pattern,
        })

    return {
        "task": "rewriting",
        "initial": init_config,
        "final": snapshots[-1],
        "steps": steps,
    }


def gen_task(kompiled_dir: str, pgm: str) -> Dict[str, Any]:
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

    proc = run_command(
        [
            "krun",
            "--directory",
            kompiled_dir,
            "--haskell-backend-command",
            # to print logs about rewriting and substitutions
            "kore-exec --log-entries DebugRewriteSubstitution",
            "--output",
            "kore",
            pgm,
        ],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )
    assert proc.stdout is not None and proc.stderr is not None
    stderr = proc.stderr.read().decode()
    final_config = proc.stdout.read().decode()
    exit_code = proc.wait()
    assert exit_code == 0, f"krun failed with exit code {exit_code}"

    log_items = parse_kore_log(stderr)

    steps = []

    for name, content in log_items:
        if name == "DebugRewriteSubstitution":
            if content.strip() == "":
                continue

            obj = yaml.load(content, Loader=yaml.Loader)
            assert isinstance(obj, list), \
                   f"ill-formed rewrite log {content}"

            if len(obj) == 0:
                continue

            assert len(obj) == 1, "non-determinism not supported"
            step_obj = obj[0]

            assert "type" in step_obj and "from" in step_obj and \
                   "rule-id" in step_obj and "substitution" in step_obj, \
                   f"ill-formed rewrite log {step_obj}"

            steps.append(
                {
                    "type":
                    step_obj["type"].strip(),
                    "from":
                    step_obj["from"].strip(),
                    "rule-id":
                    step_obj["rule-id"].strip(),
                    "substitution": [
                        {
                            "key": item["key"].strip(),
                            "value": item["value"].strip(),
                        } for item in step_obj["substitution"]
                    ],
                }
            )

    return {
        "task": "rewriting",
        "initial": init_config,
        "final": final_config,
        "steps": steps,
    }


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
    assert kdef_basename.endswith(".k"), f"{kdef} should have .k suffix"
    kdef_name = kdef_basename[:-2]
    pgm_name, _ = os.path.splitext(os.path.basename(pgm))

    work_dir = os.path.dirname(kdef)

    # cache directory (storing kompiled data)
    cache_dir = os.path.join(work_dir, f".ml-proof-cache-{kdef_name}")
    if not os.path.isdir(cache_dir):
        os.mkdir(cache_dir)

    ### step 1. kompile the given k definition
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

    ### step 2. generate snapshots and rewriting information
    print(f"- generating snapshots")
    kore_definition = os.path.join(kompiled_dir, "definition.kore")
    task_path = os.path.join(cache_dir, f"rewriting-task-{pgm_name}.yml")

    if check_dependency_change([task_path], [kompile_timestamp, pgm]):
        if no_backend_hints:
            task_obj = gen_task_legacy(cache_dir, pgm)
        else:
            task_obj = gen_task(cache_dir, pgm)

        # TODO: for now since we don't support maps yet
        # we will manually initialize the configuration
        task_obj["initial"] = gen_init_config(kore_definition, module, task_obj["initial"])

        with open(task_path, "w") as f:
            yaml.dump(task_obj, f)

    ### step 4. generate proof object
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
    set_additional_flags(parser)
    args = parser.parse_args()
    gen_proof(args)


if __name__ == "__main__":
    main()
