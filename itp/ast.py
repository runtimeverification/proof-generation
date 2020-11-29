"""
Syntax trees of the proof script
"""

from typing import List

from .tactics import Tactic, ApplyTactic, ShuffleTactic

from proof.metamath.parser import parse_term_with_metavariables


class BaseAST:
    def __repr__(self) -> str:
        return str(self)


class Options(BaseAST):
    def __init__(self, *args, **kwargs):
        self.args = args
        self.kwargs = kwargs

    def __str__(self) -> str:
        return f"<option {self.args}, {self.kwargs}>"


class Command(BaseAST):
    def get_tactic(self, env) -> Tactic:
        raise NotImplementedError()


class ApplyCommand(Command):
    def __init__(self, label: str, options: Options=Options()):
        self.label = label
        self.options = options

    def __str__(self) -> str:
        return f"<apply {self.label} {self.options}>"

    def get_tactic(self, env) -> Tactic:
        assert self.label in env.composer.theorems
        assert not self.options.args, "apply tactic is not expecting any positional arguments"

        substitution = {}

        for key, value in self.options.kwargs.items():
            assert type(value) is str
            substitution[key] = parse_term_with_metavariables(value, set(env.composer.get_all_metavariables()))

        return ApplyTactic(env.composer.theorems[self.label], substitution)


class ShuffleCommand(Command):
    def __str__(self) -> str:
        return f"<sorry>"

    def get_tactic(self, env) -> Tactic:
        return ShuffleTactic()


class SectionCommand(Command):
    def __init__(self, mark: str):
        self.mark = mark

    def __str__(self) -> str:
        return f"<section {self.mark}>"


class Script(BaseAST):
    def __init__(self, commands: List[Command]):
        self.commands = commands

    def __str__(self) -> str:
        return "\n".join(map(str, self.commands))
