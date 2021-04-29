#!/usr/bin/env python3

from typing import List
from ml.metamath.parser import load_database
from ml.metamath.composer import Composer

import os.path
import argparse
import re
import os


def number_to_letter(n: int) -> str:
    number = n - 1
    final_letter = chr(ord("A") + (number % 20))
    if number < 20:
        return final_letter

    number //= 20

    letters = []
    while True:
        number -= 1
        letters.append(chr(ord("U") + ((number % 5))))
        number //= 5
        if not number:
            break

    letters.reverse()
    letters.append(final_letter)
    return "".join(letters)


def compress(mandatory: List[str], proof: List[str]) -> str:
    label_to_num = {}
    unique_proof_labels = list(dict.fromkeys(proof))
    no_mand = [h for h in unique_proof_labels if h not in mandatory]
    for i, hyp in enumerate(mandatory + no_mand):
        label_to_num[hyp] = i + 1

    labels_str = " ( " + " ".join(no_mand) + " ) "
    letters = [number_to_letter(label_to_num[label]) for label in proof]
    letters_str = "".join(letters)
    return labels_str + letters_str


# assumse that each proof is on a single line
# Usage: takes in the files from the command line arguments
# and will output the compressed version to "filename"_compressed

parser = argparse.ArgumentParser(description="Compress Metamath proofs")
parser.add_argument("input", nargs="+", help="Input files")
parser.add_argument("--output", help="Output Folder")
args = parser.parse_args()
print(args)
for file_name in args.input:
    if file_name.endswith(".mm"):
        new_contents = None
        print("Rewriting " + file_name)
        with open(file_name, "r") as f:
            print("loading" + file_name)
            ast = load_database(file_name, include_proof=False)
            print("Finished loading ast for " + file_name)
            composer = Composer()
            composer.load(ast)

            contents = f.read()

            def transform(matchgroup: re.Match) -> str:
                label, statement, proof = matchgroup.groups()
                theorem = composer.get_theorem(label)
                mandatory = [x[2] for x in theorem.floatings] + [
                    x.label for x in theorem.essentials if x.label is not None
                ]
                new_proof = compress(mandatory, proof.split())
                return label + " $p " + statement + " $= " + new_proof + " $."

            new_contents = re.sub(r"(\S*)\s*\$p(.*)\$=(.*)\$\.", transform, contents)

        with open(os.path.join(args.output, os.path.split(file_name)[1]), "w") as f2:
            f2.writelines(new_contents)
