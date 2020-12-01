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

    def command(self, args):
        return Command(*args)

    def script(self, args):
        return Script(args)


syntax = r"""
%import common.ESCAPED_STRING -> STRING_LITERAL

COMMENT: /\$\(((.|\n)(?<!\$\)))*\$\)/

%ignore COMMENT
%ignore /[ \n\t\f\r]+/
TOKEN: /[^ \n\t\f\r=,]+/

token: TOKEN

script: command*

command: token [options]

options: option ("," option)*
option: value           -> positional_option
      | value "=" value -> keyword_option

value: STRING_LITERAL -> string
     | token
"""


script_parser = Lark(
    syntax,
    start="script",
    parser="lalr",
    lexer="standard",
    propagate_positions=True,
)


command_parser = Lark(
    syntax,
    start="command",
    parser="lalr",
    lexer="standard",
    propagate_positions=True,
)


def parse_script(src: str) -> Script:
    tree = script_parser.parse(src)
    return ASTTransformer().transform(tree)


def parse_command(src: str) -> Command:
    tree = command_parser.parse(src)
    return ASTTransformer().transform(tree)
