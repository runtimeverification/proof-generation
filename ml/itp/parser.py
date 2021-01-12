from typing import Optional

from lark import Lark, Transformer

from .ast import *


class ASTTransformer(Transformer):
    def token(self, args):
        return args[0].value

    def string(self, args):
        literal = args[0].value
        assert literal.startswith("\"") and literal.endswith("\"")
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

    def command_or_empty(self, args):
        if len(args):
            return args[0]
        return None

    def command(self, args):
        return Command(*args)

    def script(self, args):
        return Script(args)


syntax = r"""
%import common.ESCAPED_STRING -> STRING_LITERAL

BLOCK_COMMENT: /\$\(((.|\n)(?<!\$\)))*\$\)/
INLINE_COMMENT: /\#[^\n]*/

%ignore BLOCK_COMMENT
%ignore INLINE_COMMENT
%ignore /[ \n\t\f\r]+/
TOKEN: /[^ \n\t\f\r=,\#]+/

token: TOKEN

command: token [options]
command_or_empty: [command]

options: option ("," option)*
option: value           -> positional_option
      | value "=" value -> keyword_option

value: STRING_LITERAL -> string
     | token
"""


command_parser = Lark(
    syntax,
    start="command_or_empty",
    parser="lalr",
    lexer="standard",
    propagate_positions=True,
)


def parse_command(src: str) -> Optional[Command]:
    tree = command_parser.parse(src)
    return ASTTransformer().transform(tree)
