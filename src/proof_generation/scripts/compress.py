from typing import List, Optional, Tuple

from ml.metamath.parser import load_database
from ml.metamath.composer import Composer, Proof

import os
import re
import argparse


def locate_comment_segment(comment_segments: List[Tuple[int, int]], pos: int) -> Optional[Tuple[int, int]]:
    """
    Try to find the comment segment the given position is in
    """
    for begin, end in comment_segments:
        if pos >= begin and pos < end:
            return begin, end
    return None


def transform_provable_statement(
    composer: Composer, comment_segments: List[Tuple[int, int]], label: str, stmt_src: str, abs_pos: int
) -> str:
    proof_start_pos = stmt_src.index("$=") + 2

    print(f"  compressing theorem {label}")

    # find the start of the proof, excluding comments
    while True:
        # find the next non-space character
        suffix = stmt_src[proof_start_pos:]
        suffix_strip = suffix.lstrip()
        next_nonspace = proof_start_pos + len(suffix) - len(suffix_strip)

        assert next_nonspace < len(stmt_src), "failed to find a proof"

        segment = locate_comment_segment(comment_segments, abs_pos + next_nonspace)
        if segment is None:
            # found the first non-space, non-comment char
            proof_start_pos = next_nonspace
            break
        else:
            # jump to the end of the comment
            _, end = segment
            proof_start_pos = end - abs_pos

    if stmt_src[proof_start_pos] == "(":
        # already in compressed format
        return stmt_src

    # find the end of the proof
    end_match = re.search(r"\s*\$\.$", stmt_src[proof_start_pos:])
    assert end_match is not None, f"non-terminated provable statement"
    proof_end_pos = proof_start_pos + end_match.start()

    # print(proof_start_pos, proof_end_pos, stmt_src[proof_start_pos:proof_end_pos])

    theorem = composer.get_theorem(label)
    mandatory = theorem.context.get_all_mandatory_labels()
    new_proof = Proof.compress_script(mandatory, stmt_src[proof_start_pos:proof_end_pos].split())

    return stmt_src[:proof_start_pos] + new_proof + stmt_src[proof_end_pos:]


def find_all_comment_segments(src: str) -> List[Tuple[int, int]]:
    """
    Find all comment segments in a database starting from a position
    return a list of pairs [ (comment start pos, comment end pos) ]
    where start pos is inclusive and end pos is exclusive
    """

    comment_segments = []

    pos = 0
    comment_level = 0
    current_start = None

    while pos < len(src):
        next_comment_open = src.find("$(", pos)
        next_comment_close = src.find("$)", pos)

        if next_comment_open != -1:
            if next_comment_open < next_comment_close or next_comment_close == -1:
                pos = next_comment_open + 2
                comment_level += 1
                if comment_level == 1:
                    current_start = next_comment_open
                continue

        if next_comment_close != -1:
            if next_comment_close < next_comment_open or next_comment_open == -1:
                pos = next_comment_close + 2
                assert comment_level != 0, f"incorrectly nested comment at next_comment_close"
                comment_level -= 1
                if comment_level == 0:
                    assert current_start is not None
                    comment_segments.append((current_start, pos))
                    current_start = None
                continue
        break

    assert comment_level == 0, f"unclosed comment at EOF"

    return comment_segments


def update_comment_segments(comment_segments: List[Tuple[int, int]], pos: int, offset: int) -> List[Tuple[int, int]]:
    """
    Update comment segments with an offset
    """
    new_comment_segments = []

    for begin, end in comment_segments:
        if end >= pos:
            new_comment_segments.append((begin + offset, end + offset))

    return new_comment_segments


def main() -> None:
    parser = argparse.ArgumentParser(description="Compress Metamath proofs")
    parser.add_argument("input", nargs="+", help="Input files or directories")
    parser.add_argument("output", help="Output directory")
    args = parser.parse_args()

    all_inputs = []

    # collect all *.mm input files
    for input_path in args.input:
        if os.path.isdir(input_path):
            for f in os.scandir(input_path):
                if f.is_file() and f.name.endswith(".mm"):
                    all_inputs.append(f.path)
        else:
            assert os.path.isfile(input_path), f"Input not found {input_path}"
            all_inputs.append(input_path)

    assert not os.path.exists(args.output), \
           f"Output directory {args.output} already exists"

    os.mkdir(args.output)

    for input_path in all_inputs:
        print(f"loading database {input_path}")

        with open(input_path) as input_file:
            ast = load_database(input_path, include_proof=False)
            composer: Composer = Composer()
            composer.load(ast)

            print(f"loaded database {input_path}")

            contents = input_file.read()

            # not doing re.sub since we need to skip matching all
            # positions starting within a comment
            comment_segments = find_all_comment_segments(contents)

            pos = 0

            while True:
                match = re.search(r"(\S*)\s*\$p[\s\S]*?\$=[\s\S]*?\$\.", contents[pos:])
                if match is None:
                    break

                match_start = pos + match.start()
                match_end = pos + match.end()

                segment = locate_comment_segment(comment_segments, match_start)

                # if found within a comment, start again at the end
                # of the current comment
                if segment is not None:
                    _, pos = segment
                    continue

                stmt_src = match.group(0)
                label = match.group(1)
                new_stmt_src = transform_provable_statement(composer, comment_segments, label, stmt_src, match_start)

                contents = contents[:match_start] + new_stmt_src + contents[match_end:]
                pos = match_start + len(new_stmt_src)

                # update comment positions
                # TODO: bad performance
                comment_segments = update_comment_segments(
                    comment_segments, match_end,
                    len(new_stmt_src) - len(stmt_src)
                )

        output_path = os.path.join(args.output, os.path.basename(input_path))

        print(f"outputting to {output_path}")
        with open(output_path, "w") as output_file:
            output_file.write(contents)


if __name__ == "__main__":
    main()
