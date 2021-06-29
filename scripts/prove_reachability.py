from typing import List, Optional, Mapping, Tuple, BinaryIO, Dict, Any, TextIO

import os
import re
import sys
import shlex
import shutil
import argparse
import subprocess

import yaml

from tempfile import NamedTemporaryFile, TemporaryDirectory

import ml.kore.ast as kore
from ml.kore.ast import KoreVisitor
from ml.kore.parser import parse_definition, parse_pattern
from ml.kore.visitors import PatternSubstitutionVisitor
from ml.kore.utils import KoreUtils

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


def write_attributes(out: TextIO, attributes: Tuple[kore.Application, ...]) -> None:
    out.write("[")
    out.write(",".join(map(str, attributes)))
    out.write("]")


def write_sentence(out: TextIO, sentence: kore.Sentence) -> None:
    out.write("\n  ")
    out.write(str(sentence))
    out.write("\n    ")
    write_attributes(out, sentence.attributes)


def preprocess_spec_file(spec_module: str, file_path: str) -> None:
    with open(file_path) as spec_file:
        definition = parse_definition(spec_file.read())

    assert spec_module in definition.module_map, \
           f"cannot find spec module {spec_module}"

    with open(file_path, "w") as spec_file:
        write_attributes(spec_file, definition.attributes)
        spec_file.write("\n")

        for module in definition.module_map.values():
            spec_file.write(f"\nmodule {module.name}\n")

            if module.name == spec_module:
                claim_index = 0

                for sentence in module.all_sentences:
                    if isinstance(sentence, kore.Axiom):
                        assert sentence.is_claim, \
                            f"spec module contains a non-claim: {sentence}"

                        _, right = KoreUtils.destruct_implies(sentence.pattern)
                        assert isinstance(right, kore.Application) and \
                            right.symbol.get_symbol_name() == "weakAlwaysFinally", \
                            f"not a reachability claim: {sentence}"

                        # rename all free variables to avoid name clash
                        assert len(KoreUtils.get_free_sort_variables(sentence)) == 0, \
                            f"sort variable not supported: {sentence}"

                        free_vars = KoreUtils.get_free_variables(sentence)
                        substitution = {
                            free_var: kore.Variable(f"Claim{claim_index}Var{free_var.name}", free_var.sort)
                            for free_var in free_vars
                        }

                        PatternSubstitutionVisitor(substitution).visit(sentence)  # type: ignore

                        sentence.add_attribute(
                            kore.Application(
                                kore.SymbolInstance("UNIQUE'Unds'ID", []), [kore.StringLiteral(f"claim-{claim_index}")]
                            )
                        )
                        claim_index += 1

                        # TODO: probably need to do something with the generated counter cell

                    write_sentence(spec_file, sentence)
                    spec_file.write("\n")
            else:
                for sentence in definition.module_map[spec_module].all_sentences:
                    write_sentence(spec_file, sentence)
                    spec_file.write("\n")

            spec_file.write("\nendmodule ")
            write_attributes(spec_file, module.attributes)
            spec_file.write("\n")


def gen_proof(args: argparse.Namespace) -> None:
    kdef = os.path.realpath(args.kdef)
    spec_path = os.path.realpath(args.spec)
    module = args.module
    spec_module = args.spec_module

    del args.kdef
    del args.spec
    del args.module
    del args.spec_module

    if args.output is not None:
        args.output = os.path.realpath(args.output)

    # get kdef file name (without extension)
    kdef_basename = os.path.basename(kdef)
    assert kdef_basename.endswith(".k"), f"{kdef} should have .k suffix"
    kdef_name = kdef_basename[:-2]
    spec_name, _ = os.path.splitext(os.path.basename(spec_path))

    work_dir = os.path.dirname(kdef)

    # cache directory (storing kompiled data)
    cache_dir = os.path.join(work_dir, f".ml-proof-cache-{kdef_name}")
    if not os.path.isdir(cache_dir):
        os.mkdir(cache_dir)
    cache_dir = os.path.realpath(cache_dir)

    assert os.path.isfile(kdef), f"k definition {kdef} not found"

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

    ### Step 2. Do a dry run of kprove to generate the specs
    print(f"- generating hints for the spec")
    spec_kore_file = os.path.join(cache_dir, f"{spec_name}.kore")

    if check_dependency_change([spec_kore_file], [spec_path, kompile_timestamp]):
        with TemporaryDirectory() as tmp_dir:
            original_cwd = os.getcwd()
            os.chdir(tmp_dir)

            proc = run_command([
                "kprove",
                "--directory",
                cache_dir,
                "--def-module",
                module,
                "--dry-run",
                spec_path,
            ])
            exit_code = proc.wait()
            assert exit_code == 0, f"kprove failed with exit code {exit_code}"

            # go to a directory ".kprove-*" to find specs
            kprove_dirs = tuple(name for name in os.listdir() if name.startswith(".kprove-"))
            assert len(kprove_dirs) == 1, "cannot find a .kprove-* directory generated by kprove"
            kprove_dir, = kprove_dirs

            tmp_spec_kore_file = os.path.join(kprove_dir, "spec.kore")
            preprocess_spec_file(spec_module, tmp_spec_kore_file)
            shutil.move(tmp_spec_kore_file, spec_kore_file)

            os.chdir(original_cwd)

    ### Step 3. Run kore-exec --prove on the spec and produce hints
    kore_definition = os.path.join(kompiled_dir, "definition.kore")
    task_path = os.path.join(cache_dir, f"reachability-task-{spec_name}.yml")

    if check_dependency_change([task_path], [spec_kore_file, kompile_timestamp]):
        try:
            proc = run_command(
                [
                    "kore-exec",
                    kore_definition,
                    "--module",
                    module,
                    "--spec-module",
                    spec_module,
                    "--prove",
                    spec_kore_file,
                    "--trace-rewrites",
                    task_path,
                ] + (["--smt-prelude", args.smt_prelude] if args.smt_prelude is not None else []) +
                (["--z3-tactic", args.z3_tactic] if args.z3_tactic is not None else []) +
                (["--unknown-as-sat"] if args.unknown_as_sat else []),
                stdout=subprocess.DEVNULL,
            )
            exit_code = proc.wait()
            assert exit_code == 0, f"kore-exec --prove failed with exit code {exit_code}"
        except:
            os.remove(task_path)
            raise

    ### Step 4. Pass the hints and definition to ml.rewrite
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
    parser.add_argument("spec", help="Specification")
    parser.add_argument("spec_module", help="Spec module name")
    parser.add_argument(
        "--unknown-as-sat",
        action="store_const",
        const=True,
        default=False,
        help="Treat unknown results from SMT solver as satisfiable"
    )
    set_additional_flags(parser)
    args = parser.parse_args()
    gen_proof(args)


if __name__ == "__main__":
    main()
