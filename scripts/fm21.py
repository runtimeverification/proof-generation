import re
import os
import csv
import argparse

from ml.metamath.parser import load_database
from ml.metamath.composer import Composer, Theorem


def decode_index(index: str) -> int:
    last = index[-1]
    high = index[:-1]

    assert ord("A") <= ord(last) <= ord("T")

    num = ord(last) - ord("A") + 1
    mult = 0

    for digit in high:
        assert ord("U") <= ord(digit) <= ord("Y")
        mult = mult * 5 + (ord(digit) - ord("U") + 1)

    return num + mult * 20


def is_pattern_subtree(label: str) -> bool:
    return label.endswith("-is-pattern") or \
           label.endswith("-is-element-var") or \
           label.endswith("-is-var") or \
           label.endswith("-is-symbol")


def get_metamath_steps(theorem: Theorem, compressed_proof: str) -> int:
    match = re.match(r"\(\s+([\w\W]*?)\s+\)\s+(\S+)", compressed_proof)
    assert match is not None

    index_table = match.group(1).strip().split()
    index_table = list(theorem.context.get_all_mandatory_labels()) + index_table

    proof = match.group(2)

    script = []
    i = 0

    while i < len(proof):
        j = i
        while j < len(proof):
            char = ord(proof[j])
            if ord("A") <= char <= ord("T"):
                break
            j += 1
        else:
            assert False, f"unexpected ending {proof[i:]}"

        index = decode_index(proof[i:j + 1])
        assert index <= len(index_table), f"index {index} does not exists"
        script.append(index_table[index - 1])

        i = j + 1

    return len([label for label in script if not is_pattern_subtree(label)])


def collect_stats(writer: csv.DictWriter, path: str) -> int:
    database = load_database(path, include_proof=False)
    composer = Composer()
    composer.load(database)

    with open(path) as f:
        source = f.read()

    count = 0

    for match in re.finditer(r"(\S*)\s*\$p[\s\S]*?\$=([\s\S]*?)\$\.", source):
        label = match.group(1)
        proof = match.group(2).strip()
        split_match = re.match(r"\$\(([\w\W]+)\$\)\s+([\w\W]+)", proof)
        if split_match is not None:
            itp_script = split_match.group(1).strip().split("\n")
            mm_proof = split_match.group(2).strip()

            theorem = composer.find_theorem(label)
            if theorem is None:
                continue

            used_tautology = False

            for tactic in itp_script:
                if tactic.strip() == "tautology":
                    used_tautology = True
                    break

            mm_steps = get_metamath_steps(theorem, mm_proof)

            writer.writerow(
                {
                    "label": label,
                    "used_tautology": used_tautology,
                    "num_tactics": len(itp_script),
                    "num_mm_proof_steps": mm_steps,
                }
            )

            count += 1

    return count


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("theory", help="theory directory")
    parser.add_argument("output", help="output csv file")
    args = parser.parse_args()

    count = 0

    with open(args.output, "w") as output_file:
        writer = csv.DictWriter(output_file, ["label", "used_tautology", "num_tactics", "num_mm_proof_steps"])
        writer.writeheader()

        for name in os.listdir(args.theory):
            if name.endswith(".mm"):
                print(name)
                count += collect_stats(writer, os.path.join(args.theory, name))

        print(f"{count} theorems collected")


if __name__ == "__main__":
    main()
