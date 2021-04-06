from typing import List, BinaryIO

import os
import sys
import csv
import shlex
import argparse
import subprocess

from ml.utils.ansi import ANSI


TESTS = [
    # ("examples/cav/two-counters.k", "TWO-COUNTERS", "examples/cav/pgm-10.two-counters", "examples/cav/two-counters-pgm-10"),
    # ("examples/cav/two-counters.k", "TWO-COUNTERS", "examples/cav/pgm-20.two-counters", "examples/cav/two-counters-pgm-20"),
    # ("examples/cav/two-counters.k", "TWO-COUNTERS", "examples/cav/pgm-50.two-counters", "examples/cav/two-counters-pgm-50"),
    # ("examples/cav/two-counters.k", "TWO-COUNTERS", "examples/cav/pgm-100.two-counters", "examples/cav/two-counters-pgm-100"),
] + [
    (
        f"examples/cav/rec-k-unconditional/{rec_module}.k",
        rec_module.upper(),
        f"examples/cav/rec-k-unconditional/pgm.{rec_module}",
        f"examples/cav/rec-k-unconditional/{rec_module}-pgm",
    )
    for rec_module in [
        # "add8",
        # "factorial5",
        "fibonacci05",
        "benchexpr10",
        "benchsym10",
        "benchtree10",
        "langton6",
        "mul8",
        "revelt",
        "revnat100",
        "tautologyhard",
    ]
]

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


def debug(msg: str):
    print(msg, file=sys.stderr)


def run_command(command: List[str], **kwargs) -> subprocess.Popen:
    command_str = " ".join([shlex.quote(frag) for frag in command])
    debug(f"{ANSI.COLOR_GREY}+ {command_str}{ANSI.RESET}")
    return subprocess.Popen(command, **kwargs)


def read_stats(stream: BinaryIO, stats):
    while True:
        line = stream.readline().decode()
        if line == "":
            break

        head, *rest = line.strip().split()
        if head in STATS_LABELS:
            assert len(rest)
            value = float(rest[0]) if "." in rest[0] else int(rest[0])
            stats[head] = value


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("output", help="output csv file")
    parser.add_argument(
        "--append",
        action="store_const",
        const=True,
        default=False,
        help="append to the output file instead of overwriting",
    )
    args = parser.parse_args()

    with open(args.output, "a" if args.append else "w") as output:
        writer = csv.DictWriter(output, ["module-name", "pgm"] + STATS_LABELS)

        if not args.append:
            writer.writeheader()
            output.flush()

        for module_path, module_name, pgm_path, output_path in TESTS:
            debug(f"## collecting stats on {module_path} on program {pgm_path}")
            stats = {}

            proc = run_command(
                [
                    "python3",
                    "-m",
                    "scripts.run-test",
                    module_path,
                    module_name,
                    pgm_path,
                    "--output",
                    output_path,
                    "--benchmark",
                    "--cpython",
                ],
                stdout=subprocess.PIPE,
                stderr=subprocess.DEVNULL,
            )

            read_stats(proc.stdout, stats)

            exit_code = proc.wait()
            assert exit_code == 0, f"test failed with exit code {exit_code}"

            proc = run_command(
                [
                    "python3",
                    "-m",
                    "scripts.proof-stats",
                    PRELUDE_THEORY,
                    output_path,
                ],
                stdout=subprocess.PIPE,
                stderr=subprocess.DEVNULL,
            )

            read_stats(proc.stdout, stats)

            exit_code = proc.wait()
            assert exit_code == 0, f"stats failed with exit code {exit_code}"

            stats["module-name"] = module_name
            stats["pgm"] = os.path.basename(pgm_path)
            print(stats)

            writer.writerow(stats)
            output.flush()


if __name__ == "__main__":
    main()
