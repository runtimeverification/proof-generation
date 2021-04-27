#!/usr/bin/env python3
#
import sys
import os
import re


def number_to_letter(n):
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


def compress(mandatory, proof):
    label_to_num = {}
    unique_proof_labels = list(dict.fromkeys(proof))
    no_mand = [h for h in unique_proof_labels if h not in mandatory]
    for i, hyp in enumerate(mandatory + no_mand):
        label_to_num[hyp] = i + 1

    labels_str = " ( " + " ".join(no_mand) + " ) "
    letters = [number_to_letter(label_to_num[label]) for label in proof]
    letters_str = "".join(letters)
    return labels_str + letters_str


files = sys.argv

for file_name in sys.argv[1:]:

    with open(file_name, "r+") as f:
        print("Rewriting " + file_name)
        new_contents = []
        contents = f.read()

        for line in contents.splitlines():
            if line.find("$p") >= 0:
                left = line.find("$=")
                right = line.find("$.")

                proof_labels = line[left + 2 : right].split(" ")
                if line[0] != "(":
                    new_line = line[:left] + "$=" + compress([], proof_labels) + "$."

                    new_contents.append(new_line)

        f.writelines(new_contents)
