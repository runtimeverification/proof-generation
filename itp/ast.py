"""
Syntax trees of the proof script
"""

from typing import List

from .tactics import Tactic, ApplyTactic, SetSchematicVariableTactic, ShuffleTactic

from proof.metamath.parser import parse_term_with_metavariables


class BaseAST:
    def __repr__(self) -> str:
        return str(self)


class Options(BaseAST):
    def __init__(self, *args, **kwargs):
        self.args = args
        self.kwargs = kwargs

    def __str__(self) -> str:
        output = []

        if self.args:
            output += list(map(lambda s: s.replace("\"", "\\\""), self.args))

        if self.kwargs:
            output += list(map(lambda t: "{} = \"{}\"".format(t[0], t[1].replace("\"", "\\\"")), self.kwargs.items()))

        return ", ".join(output)

    def empty(self) -> bool:
        return not self.args and not self.kwargs


class Command(BaseAST):
    def get_tactic(self, state) -> Tactic:
        raise NotImplementedError()


class ApplyCommand(Command):
    def __init__(self, label: str, options: Options=Options()):
        self.label = label
        self.options = options

    def __str__(self) -> str:
        return f"apply {self.label}" + (f" with {self.options}" if not self.options.empty() else "")

    def get_tactic(self, state) -> Tactic:
        assert self.label in state.composer.theorems, f"cannot find theorem {self.label}"
        assert not self.options.args, "apply tactic is not expecting any positional arguments"

        substitution = {}

        for key, value in self.options.kwargs.items():
            assert type(value) is str
            substitution[key] = parse_term_with_metavariables(value, set(state.composer.get_all_metavariables()))

        return ApplyTactic(state.composer.theorems[self.label], substitution)


class LetCommand(Command):
    def __init__(self, options: Options=Options()):
        self.options = options

    def __str__(self) -> str:
        return f"let {self.options}"

    def get_tactic(self, state) -> Tactic:
        assert not self.options.args, "apply tactic is not expecting any positional arguments"

        substitution = {}

        # TODO: check for schematic variables here
        for key, value in self.options.kwargs.items():
            assert type(value) is str
            substitution[key] = parse_term_with_metavariables(value, set(state.composer.get_all_metavariables()))

        return SetSchematicVariableTactic(substitution)


class ShuffleCommand(Command):
    def __str__(self) -> str:
        return f"meh"

    def get_tactic(self, state) -> Tactic:
        return ShuffleTactic()


class Script(BaseAST):
    def __init__(self, commands: List[Command]):
        self.commands = commands

    def __str__(self) -> str:
        return "\n".join(map(str, self.commands))
