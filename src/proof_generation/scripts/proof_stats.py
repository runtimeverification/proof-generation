from typing import List, BinaryIO, TextIO, Tuple, Any

import os
import sys
import time
import shlex
import argparse
import subprocess

from ml.utils.ansi import ANSI


def debug(msg: str) -> None:
    print(msg, file=sys.stderr)


def run_command(command: List[str], **kwargs: Any) -> subprocess.Popen:  # type: ignore
    command_str = " ".join([shlex.quote(frag) for frag in command])
    debug(f"{ANSI.in_gray('+ ' + command_str)}")
    return subprocess.Popen(command, **kwargs)


def read_until(stream: Any, keyword: bytes) -> bytes:
    buf = b""
    while True:
        buf += stream.read(1)
        # print(buf.decode())
        if buf.endswith(keyword):
            return buf


def verify_theorems(entry_database: str, label_patterns: List[str]) -> Tuple[float, List[float]]:
    proc = run_command(
        ["metamath", "set scroll continuous", f'read "{entry_database}"'],
        stdout=subprocess.PIPE,
        stdin=subprocess.PIPE,
    )
    assert proc.stdin is not None

    begin = time.time()
    read_until(proc.stdout, b"read into the source buffer.")
    read_until(proc.stdout, b"MM> ")
    loading_time = time.time() - begin

    verify_time = []

    for pattern in label_patterns:
        begin = time.time()
        proc.stdin.write(f"verify proof {pattern}\n".encode())
        proc.stdin.flush()
        debug(f"verifying {pattern}")
        read_until(proc.stdout, b"MM> ")
        verify_time.append(time.time() - begin)

    proc.stdin.write(b"exit\n")
    proc.stdin.close()

    exit_code = proc.wait()
    assert (exit_code == 0), f"failed to verify database {entry_database}: exit code {exit_code}"

    return loading_time, verify_time


def get_file_size(path: str, wrap: int) -> Tuple[int, int, int]:
    lines = 0
    wrapped_lines = 0
    size_in_bytes = 0

    with open(path) as f:
        while True:
            line = f.readline()
            if line == "":
                break

            size_in_bytes += len(line)

            if line.strip() != "":
                lines += 1
                wrapped_lines += max(1, len(line) // wrap)

    return lines, wrapped_lines, size_in_bytes


def measure(proof_object: str, prelude_theory: str, line_wrap: int = 80) -> None:
    # measure base loading time
    loading_time1, (goal_time, rewrite_time,
                    total_time) = verify_theorems(os.path.join(proof_object, "goal.mm"), ["goal", "rewrite-*", "*"])

    loading_time2, (prelude_time, ) = verify_theorems(os.path.join(prelude_theory, "kore-lemmas.mm"), ["*"])

    # count number of lines
    prelude_lines = 0
    module_lines = 0
    task_lines = 0

    prelude_lines_wrapped = 0
    module_lines_wrapped = 0
    task_lines_wrapped = 0

    prelude_size = 0
    module_size = 0
    task_size = 0

    for fname in os.listdir(proof_object):
        path = os.path.join(proof_object, fname)
        lines, wrapped_lines, size = get_file_size(path, line_wrap)

        # if fname == "dv.mm":
        #     dv_lines += lines
        # el
        if fname in {"dv.mm", "goal.mm", "variable.mm", "substitution.mm"}:
            task_lines += lines
            task_lines_wrapped += wrapped_lines
            task_size += size
        else:
            module_lines += lines
            module_lines_wrapped += wrapped_lines
            module_size += size

    for fname in os.listdir(prelude_theory):
        path = os.path.join(prelude_theory, fname)
        lines, wrapped_lines, size = get_file_size(path, line_wrap)
        prelude_lines += lines
        prelude_lines_wrapped += wrapped_lines
        prelude_size += size

    print(f"mm-loading {loading_time1}")
    print(f"mm-prelude {prelude_time}")
    print(f"mm-rewrite {goal_time + rewrite_time}")
    print(f"mm-total {prelude_time + goal_time + rewrite_time}")

    print(f"loc-prelude {prelude_lines}")
    print(f"loc-module {module_lines}")
    print(f"loc-rewrite {task_lines}")
    print(f"loc-total {prelude_lines + module_lines + task_lines}")

    print(f"loc-prelude-wrapped {prelude_lines_wrapped}")
    print(f"loc-module-wrapped {module_lines_wrapped}")
    print(f"loc-rewrite-wrapped {task_lines_wrapped}")
    print(f"loc-total-wrapped {prelude_lines_wrapped + module_lines_wrapped + task_lines_wrapped}")

    print(f"size-prelude {prelude_size}")
    print(f"size-module {module_size}")
    print(f"size-rewrite {task_size}")
    print(f"size-total {prelude_size + module_size + task_size}")

    # return {
    #     "mm-loading-time": loading_time1,
    #     "mm-prelude-time": prelude_time,
    #     "mm-task-time": goal_time + rewrite_time,
    #     "mm-total-time": total_time,

    #     # "prelude-ver-time": prelude_time,
    #     # "task-ver-time": task_time,
    #     # "module-ver-time": total_time - task_time - prelude_time,
    #     # "total-ver-time": total_time,

    #     "prelude-lines": prelude_lines,
    #     "module-lines": module_lines,
    #     "dv-lines": dv_lines,
    #     "task-lines": task_lines,
    # }


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("theory", help="path to the prelude theory directory")
    parser.add_argument("proof", help="path to the proof object directory")
    args = parser.parse_args()

    measure(args.proof, args.theory)


if __name__ == "__main__":
    main()
