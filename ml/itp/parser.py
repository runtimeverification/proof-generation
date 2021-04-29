from typing import Optional

from lark import Lark, Transformer

from .ast import *


class ASTTransformer(Transformer):
    def token(self, args):
        return args[0].value

    def string(self, args):
        literal = args[0].value
        assert literal.startswith('"') and literal.endswith('"')
        return literal[1:-1]

    def value(self, args):
        return args[0]

    def positional_option(self, args):
        return args[0]

    def keyword_option(self, args):
        key, value = args
        return key, value

    def options(self, args):
        positional_args = []
        keyword_args = {}

        for arg in args:
            if type(arg) is tuple:
                key, value = arg
                assert key not in keyword_args, f"duplicate keyword {key}"
                keyword_args[key] = value
            else:
                positional_args.append(arg)

        return Options(*positional_args, **keyword_args)

    def tactical_or_empty(self, args):
        if len(args):
            return args[0]
        return None

    def atomic_tactical(self, args):
        return AtomicTactical(*args)

    def tactical(self, args):
        return args[0]

    def paren_tactical(self, args):
        return args[0]

    def closure_tactical(self, args):
        return args[0]

    def plus_tactical(self, args):
        return PlusTactical(args[0])

    def star_tactical(self, args):
        return StarTactical(args[0])

    def and_tactical(self, args):
        if len(args) == 1: return args[0]
        return AndTactical(*args)

    def or_tactical(self, args):
        if len(args) == 1: return args[0]
        return OrTactical(*args)


syntax = r"""
%import common.ESCAPED_STRING -> STRING_LITERAL

BLOCK_COMMENT: /\$\(((.|\n)(?<!\$\)))*\$\)/
INLINE_COMMENT: /\#[^\n]*/

%ignore BLOCK_COMMENT
%ignore INLINE_COMMENT
%ignore /[ \n\t\f\r]+/
TOKEN: /[^ =,\#|+*&()]+/

token: TOKEN

atomic_tactical: token [options]
               | "(" tactical ")"      -> paren_tactical

closure_tactical: atomic_tactical
                | closure_tactical "+" -> plus_tactical
                | closure_tactical "*" -> star_tactical

and_tactical: closure_tactical ("&" closure_tactical)*
or_tactical: and_tactical ("|" and_tactical)*

tactical: or_tactical

tactical_or_empty: [tactical]

options: option ("," option)*
option: value           -> positional_option
      | value "=" value -> keyword_option

value: STRING_LITERAL -> string
     | token
"""

tactical_parser = Lark(
    syntax,
    start="tactical_or_empty",
    parser="lalr",
    lexer="standard",
    propagate_positions=True,
)


def parse_tactical(src: str) -> Optional[Tactical]:
    tree = tactical_parser.parse(src)
    return ASTTransformer().transform(tree)
