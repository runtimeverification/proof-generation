"""
Syntax trees of the proof script
"""

from typing import List

from .state import ProofState

from ml.metamath.parser import parse_term_with_metavariables


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
            output += list(
                map(lambda s: '"{}"'.format(s.replace('"', '\\"')), self.args)
            )

        if self.kwargs:
            output += list(
                map(
                    lambda t: '{} = "{}"'.format(t[0], t[1].replace('"', '\\"')),
                    self.kwargs.items(),
                )
            )

        return ", ".join(output)

    def empty(self) -> bool:
        return not self.args and not self.kwargs


class Command(BaseAST):
    def __init__(self, tactic: str, options: Options = Options()):
        self.tactic = tactic
        self.options = options

    def __str__(self) -> str:
        return f"{self.tactic}" + (
            f" {self.options}" if not self.options.empty() else ""
        )

    def apply_tactic(self, state: ProofState) -> ProofState:
        tactic_class = state.get_tactic(self.tactic)
        return state.apply_tactic(
            tactic_class(self.tactic), *self.options.args, **self.options.kwargs
        )


class Script(BaseAST):
    def __init__(self, commands: List[Command]):
        self.commands = commands

    def __str__(self) -> str:
        return "\n".join(map(str, self.commands))
