from typing import Any

from ml.kore.ast import BaseAST
from ml.kore.parser import parse_definition, parse_pattern
from ml.kore.utils import KoreUtils

import sys
import argparse


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("input", nargs="?", help="input kore source, if not set then defaults to stdin")
    parser.add_argument(
        "--definition", action="store_const", const=True, default=False, help="parse input as a definition"
    )
    args = parser.parse_args()

    if args.input is None:
        input_src = sys.stdin.read()
    else:
        with open(args.input) as f:
            input_src = f.read()

    if args.definition:
        ast: BaseAST[Any] = parse_definition(input_src)
    else:
        ast = parse_pattern(input_src)

    KoreUtils.pretty_print(ast)


if __name__ == "__main__":
    main()
