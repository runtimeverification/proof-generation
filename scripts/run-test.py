from typing import List, Optional, Mapping

import os
import re
import sys
import shlex
import shutil
import argparse
import subprocess

import ml.kore.ast as kore
from ml.kore.parser import parse_definition, parse_pattern
from ml.kore.visitors import KoreVisitor, PatternOnlyVisitorStructure

from ml.utils.ansi import ANSI


def run_command(command: List[str], **kwargs) -> subprocess.Popen:
    command_str = " ".join([ shlex.quote(frag) for frag in command ])
    print(f"{ANSI.COLOR_GREY}+ {command_str}{ANSI.RESET}", file=sys.stderr)
    return subprocess.Popen(command, **kwargs)


def get_mtime(path: str) -> int:
    if not os.path.exists(path): return -1
    return os.stat(path).st_mtime


"""
Check if any of the dependencies is younger than
any of the targets
"""
def check_dependency_change(targets: List[str], dependencies: List[str]) -> bool:
    min_target_mtime = min([ get_mtime(path) for path in targets ])
    max_dep_mtime = max([ get_mtime(path) for path in dependencies ])
    return max_dep_mtime > min_target_mtime


class Initializer(KoreVisitor, PatternOnlyVisitorStructure):
    def __init__(self, initializer_axioms: Mapping[str, kore.Pattern], pgm_pattern: kore.Pattern):
        super().__init__()
        self.initializer_axioms = initializer_axioms
        self.pgm_pattern = pgm_pattern

    def postvisit_application(self, application: kore.Application, arguments: List[kore.Pattern]) -> kore.Application:
        symbol_name = application.symbol.definition

        if symbol_name in self.initializer_axioms:
            return self.visit(self.initializer_axioms[symbol_name])

        if symbol_name.startswith("Lblproject'Coln'"):
            return self.pgm_pattern

        application.arguments = arguments
        return application


def gen_init_config(kore_def_path: str, module: str, pgm_src: str) -> str:
    with open(kore_def_path) as f:
        definition = parse_definition(f.read())

    pgm_pattern = parse_pattern(pgm_src)
    main_module = definition.module_map[module]

    # find the initializer axioms, starting from LblinitGeneratedTopCell
    initializer_axioms = {} # symbol -> term

    for axiom in main_module.axioms:
        if axiom.get_attribute_by_symbol("initializer") is not None:
            equation = axiom.pattern.arguments[1].arguments[0]
            lhs, rhs = equation.arguments
            assert isinstance(lhs, kore.Application)

            symbol_name = lhs.symbol.definition
            initializer_axioms[symbol_name] = rhs

    assert "LblinitGeneratedTopCell" in initializer_axioms
    init_config_pattern = Initializer(initializer_axioms, pgm_pattern).visit(initializer_axioms["LblinitGeneratedTopCell"])

    return f"inj{{SortGeneratedTopCell{{}}, SortKItem{{}}}}({init_config_pattern})"


def gen_proof(kdef: str, module: str, pgm: str, output: Optional[str]=None, benchmark: bool=False, cpython: bool=False):
    kdef = os.path.realpath(kdef)
    pgm = os.path.realpath(pgm)

    if output is not None:
        output = os.path.realpath(output)

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

    if check_dependency_change([ kompile_timestamp ], [ kdef ]):
        proc = run_command([
            "kompile",
            "--backend", "llvm",
            "--directory", cache_dir,
            "--main-module", module,
            "--debug",
            kdef,
        ])
        exit_code = proc.wait()
        assert exit_code == 0, f"kompiled failed with exit code {exit_code}"

    ### step 2. generate snapshots
    print(f"- generating snapshots")
    kore_definition = os.path.join(kompiled_dir, "definition.kore")

    snapshot_dir = os.path.join(cache_dir, f"snapshots-{pgm_name}")
    if not os.path.isdir(snapshot_dir):
        new_snapshots = True
        os.mkdir(snapshot_dir)
    else:
        new_snapshots = False

    snapshot_0 = os.path.join(snapshot_dir, f"snapshot-0.kore")

    if check_dependency_change([ snapshot_0 ], [ kompile_timestamp, pgm ]):
        if not new_snapshots:
            shutil.rmtree(snapshot_dir)
            os.mkdir(snapshot_dir)

        # generate the initial configuration
        # TODO: technically initial configuration is also generated through equations
        # in the kore definition, but we are skipping that since we don't support map yet.
        proc = run_command([
            "kast",
            "--directory", cache_dir,
            "--output", "kore",
            pgm,
        ], stdout=subprocess.PIPE)
        stdout = proc.stdout.read().decode()
        exit_code = proc.wait()
        assert exit_code == 0, f"kast failed with exit code {exit_code}"

        init_config = gen_init_config(kore_definition, module, stdout)
        with open(snapshot_0, "w") as f:
            f.write(init_config)

        # generate snapshots from step 1 to the end
        # (the initial configuration has to be obtained differently)
        current_depth = 1
        last_config = init_config

        while True:
            snapshot_path = os.path.join(snapshot_dir, f"snapshot-{current_depth}.kore")

            proc = run_command([
                "krun",
                "--directory", cache_dir,
                "--depth", str(current_depth),
                "--output", "kore",
                pgm,
            ], stdout=subprocess.PIPE)
            stdout = proc.stdout.read().decode()
            exit_code = proc.wait()
            assert exit_code == 0, f"krun failed with exit code {exit_code}"

            if last_config != stdout:
                with open(snapshot_path, "w") as f:
                    f.write(stdout)

                last_config = stdout
            else:
                break

            current_depth += 1

    ### step 4. generate proof object
    if output is not None:
        print(f"- generating proof")
        proc = run_command([
            "python3" if cpython else "pypy3",
            "-m", "ml.rewrite",
            kore_definition,
            module,
            "--prelude", "theory/prelude.mm",
            "--snapshots", snapshot_dir,
            "--output", output,
        ] + ([ "--benchmark" ] if benchmark else []))
        exit_code = proc.wait()
        assert exit_code == 0, f"ml.rewrite failed with exit code {exit_code}"


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("kdef", help="The main .k file")
    parser.add_argument("module", help="The main module")
    parser.add_argument("pgm", help="The program to run")
    parser.add_argument("-o", "--output", help="output directory for the proof object")
    parser.add_argument("--cpython", action="store_const", const=True, default=False, help="use CPython instead of PyPy")
    parser.add_argument("--benchmark", action="store_const", const=True, default=False, help="output the time spent for translating module and proving rewriting")
    args = parser.parse_args()

    gen_proof(args.kdef, args.module, args.pgm, output=args.output, benchmark=args.benchmark, cpython=args.cpython)


if __name__ == "__main__":
    main()
