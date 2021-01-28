from typing import List

import os
import sys
import time
import shlex
import argparse
import subprocess

from ml.utils.ansi import ANSI


def run_command(command: List[str], **kwargs) -> subprocess.Popen:
    command_str = " ".join([ shlex.quote(frag) for frag in command ])
    print(f"{ANSI.COLOR_GREY}+ {command_str}{ANSI.RESET}", file=sys.stderr)
    return subprocess.Popen(command, **kwargs)


def verify_theorems(entry_database: str, label_patterns: List[str]) -> float:
    begin = time.time()

    proc = run_command([
            "metamath",
            f"read \"{entry_database}\"",
        ] +
        [ f"verify proof {pattern}" for pattern in label_patterns ] +
        [ "exit" ],
        stdout=subprocess.DEVNULL)
    exit_code = proc.wait()
    assert exit_code == 0, f"failed to verify database {entry_database}: exit code {exit_code}"

    return time.time() - begin


def measure(proof_object: str, prelude_theory: str):
    # measure base loading time
    base_po_time = verify_theorems(os.path.join(proof_object, "goal.mm"), [])
    base_prelude_time = verify_theorems(os.path.join(prelude_theory, "kore-lemmas.mm"), [])

    prelude_time = verify_theorems(os.path.join(prelude_theory, "kore-lemmas.mm"), [ "*" ]) - base_prelude_time
    task_time = verify_theorems(os.path.join(proof_object, "goal.mm"), [ "goal", "rewrite-*" ]) - base_po_time
    total_time = verify_theorems(os.path.join(proof_object, "goal.mm"), [ "*" ]) - base_po_time

    return {
        "prelude-ver-time": prelude_time,
        "task-ver-time": task_time,
        "module-ver-time": total_time - task_time - prelude_time,
        "total-ver-time": total_time,
    }


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("theory", help="path to the prelude theory directory")
    parser.add_argument("proof", help="path to the proof object directory")
    args = parser.parse_args()

    print(measure(args.proof, args.theory))


if __name__ == "__main__":
    main()
