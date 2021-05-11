from typing import List, IO, Tuple, Any, Union, Dict

import os
import re
import sys
import csv
import shlex
import argparse
import subprocess

from ml.utils.ansi import ANSI

STATS_LABELS = [
    "gen-module",
    "gen-rewrite",
    "gen-total",
    "mm-loading",
    "mm-prelude",
    "mm-rewrite",
    "mm-total",
    "loc-prelude",
    "loc-module",
    "loc-rewrite",
    "loc-total",
    "loc-prelude-wrapped",
    "loc-module-wrapped",
    "loc-rewrite-wrapped",
    "loc-total-wrapped",
    "size-prelude",
    "size-module",
    "size-rewrite",
    "size-total",
]

PRELUDE_THEORY = "theory"


def debug(msg: str) -> None:
    print(msg, file=sys.stderr)


def run_command(command: List[str], **kwargs: Any) -> subprocess.Popen:  # type: ignore
    command_str = " ".join([shlex.quote(frag) for frag in command])
    debug(f"{ANSI.in_gray('+ ' + command_str)}")
    return subprocess.Popen(command, **kwargs)


def read_stats(stream: IO[bytes], stats: Dict[str, Union[int, float]]) -> None:
    while True:
        line = stream.readline().decode()
        if line == "":
            break

        head, *rest = line.strip().split()
        if head in STATS_LABELS:
            assert len(rest)
            value = float(rest[0]) if "." in rest[0] else int(rest[0])
            stats[head] = value


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "test_dir", nargs="+", help="each test directory should contain exactly one *.k file and one input.* file"
    )
    parser.add_argument("output", help="output csv file")
    parser.add_argument(
        "--append",
        action="store_const",
        const=True,
        default=False,
        help="append to the output file instead of overwriting",
    )
    args = parser.parse_args()

    # [ (k defn, main module name, input program, output proof) ]
    tests: List[Tuple[str, str, str, str]] = []

    # find tests
    for test_path in args.test_dir:
        k_defn = None
        input_files = []

        # find the k definition
        for name in os.listdir(test_path):
            if name.endswith(".k"):
                assert k_defn is None, f"multiple k definitions found in {test_path}: {k_defn} and {name}"
                k_defn = name

        assert k_defn is not None, f"unable to find k definition in {test_path}"

        k_defn_suffix = k_defn.split(".")[0]
        k_defn = os.path.join(test_path, k_defn)

        # find all tests with suffix being .<k definition name>
        for name in os.listdir(test_path):
            if name.endswith(f".{k_defn_suffix}"):
                input_files.append(os.path.join(test_path, name))

        assert len(input_files) != 0, f"no input program found in {test_path}"

        # find the module name
        # we assume that it's the last module in the k definition
        main_module = None
        with open(k_defn) as f:
            for match in re.finditer(r"^\s*module\s+([^\s\n]+)$", f.read(), flags=re.MULTILINE):
                main_module = match.group(1)

        assert main_module is not None, f"unable to infer a main module name in {name}"

        for input_file in input_files:
            basename = os.path.basename(input_file)
            name = basename.split(".")[0]
            output = os.path.join(test_path, f"proof-{name}")

            tests.append((
                k_defn,
                main_module,
                input_file,
                output,
            ))

            print(f"found test {k_defn} {main_module} {input_file}, will output to {output}")

    with open(args.output, "a" if args.append else "w") as output_file:
        writer = csv.DictWriter(output_file, ["module-name", "pgm"] + STATS_LABELS)

        if not args.append:
            writer.writeheader()
            output_file.flush()

        for module_path, module_name, pgm_path, output_path in tests:
            debug(f"## collecting stats of {module_path} on program {pgm_path}")
            stats: Dict[str, Any] = {}

            proc = run_command(
                [
                    "python3",
                    "-m",
                    "scripts.run_test",
                    module_path,
                    module_name,
                    pgm_path,
                    "--output",
                    output_path,
                    "--benchmark",
                ],
                stdout=subprocess.PIPE,
                stderr=subprocess.DEVNULL,
            )

            assert proc.stdout is not None
            read_stats(proc.stdout, stats)

            exit_code = proc.wait()
            assert exit_code == 0, f"test failed with exit code {exit_code}"

            proc = run_command(
                [
                    "python3",
                    "-m",
                    "scripts.proof_stats",
                    PRELUDE_THEORY,
                    output_path,
                ],
                stdout=subprocess.PIPE,
                stderr=subprocess.DEVNULL,
            )

            assert proc.stdout is not None
            read_stats(proc.stdout, stats)

            exit_code = proc.wait()
            assert exit_code == 0, f"stats failed with exit code {exit_code}"

            stats["module-name"] = module_name
            stats["pgm"] = os.path.basename(pgm_path)
            print(stats)

            writer.writerow(stats)
            output_file.flush()


if __name__ == "__main__":
    main()
