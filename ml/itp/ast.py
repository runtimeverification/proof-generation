"""
Syntax trees of the proof script
"""

from typing import List

from .state import ProofState, NoStateChangeException

from ml.metamath.parser import parse_term_with_metavariables


class BaseAST:
    def __repr__(self) -> str:
        return str(self)


class Options(BaseAST):
    def __init__(self, *args: str, **kwargs: str):
        super().__init__()
        self.args = args
        self.kwargs = kwargs

    def __str__(self) -> str:
        output = []

        if self.args:
            output += list(map(lambda s: '"{}"'.format(s.replace('"', '\\"')), self.args))

        if self.kwargs:
            output += list(map(
                lambda t: '{} = "{}"'.format(t[0], t[1].replace('"', '\\"')),
                self.kwargs.items(),
            ))

        return ", ".join(output)

    def empty(self) -> bool:
        return not self.args and not self.kwargs


class Tactical(BaseAST):
    def apply(self, state: ProofState) -> ProofState:
        raise NotImplementedError()


class AtomicTactical(Tactical):
    """
    A single tactic with no combinators
    """
    def __init__(self, tactic: str, options: Options = Options()):
        super().__init__()
        self.tactic = tactic
        self.options = options

    def __str__(self) -> str:
        return f"{self.tactic}" + (f" {self.options}" if not self.options.empty() else "")

    def apply(self, state: ProofState) -> ProofState:
        tactic_class = state.get_tactic(self.tactic)
        return state.apply_tactic(tactic_class(self.tactic), *self.options.args, **self.options.kwargs)


class OrTactical(Tactical):
    """
    Apply the tacticals in sequence, until one of them succeeds
    """
    def __init__(self, *tacticals: Tactical):
        super().__init__()
        self.tacticals = tacticals

    def __str__(self) -> str:
        return " | ".join(map(str, self.tacticals))

    def apply(self, state: ProofState) -> ProofState:
        assert len(self.tacticals) != 0

        exceptions = []

        for tactical in self.tacticals:
            try:
                state = tactical.apply(state)
                return state

            except NoStateChangeException:
                raise NoStateChangeException()

            except Exception as exc:
                exceptions.append(exc)
                continue

        msg = []

        for tactical, exception in zip(self.tacticals, exceptions):
            msg.append(f"  {tactical}: {exception}")

        raise Exception("all tacticals failed:\n" + "\n".join(msg))


class AndTactical(Tactical):
    """
    Apply the tacticals in sequence, fail if any of them fail
    """
    def __init__(self, *tacticals: Tactical):
        super().__init__()
        self.tacticals = tacticals

    def __str__(self) -> str:
        return " & ".join(map(str, self.tacticals))

    def apply(self, state: ProofState) -> ProofState:
        assert len(self.tacticals) != 0

        no_state_change = True

        for tactical in self.tacticals:
            try:
                state = tactical.apply(state)
                no_state_change = False

            except NoStateChangeException:
                continue

        if no_state_change:
            raise NoStateChangeException()

        return state


class PlusTactical(Tactical):
    """
    Apply the tactical one or more times until it fails
    """
    def __init__(self, tactical: Tactical):
        super().__init__()
        self.tactical = tactical

    def __str__(self) -> str:
        return f"({self.tactical})+"

    def apply(self, state: ProofState) -> ProofState:
        count = 0
        no_state_change = True

        while True:
            try:
                count += 1
                state = self.tactical.apply(state)
                no_state_change = False
            except NoStateChangeException:
                continue
            except Exception:
                if count == 1:
                    raise
                break

        if no_state_change:
            raise NoStateChangeException()

        return state


class StarTactical(Tactical):
    """
    Apply the tactical zero or more times until it fails
    """
    def __init__(self, tactical: Tactical):
        super().__init__()
        self.tactical = tactical

    def __str__(self) -> str:
        return f"({self.tactical})*"

    def apply(self, state: ProofState) -> ProofState:
        no_state_change = True

        while True:
            try:
                state = self.tactical.apply(state)
                no_state_change = False
            except NoStateChangeException:
                continue
            except Exception:
                break

        if no_state_change:
            raise NoStateChangeException()

        return state
