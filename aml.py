from dataclasses import dataclass
from typing import Union
from abc import abstractmethod

Var = Union['SVar', 'EVar']

class Pattern:
    @abstractmethod
    def free_variables(self) -> set[Var]:
       raise NotImplementedError
    @abstractmethod
    def substitute(self, p: 'Var', v: 'Pattern') -> 'Pattern':
       raise NotImplementedError

@dataclass(frozen=True)
class Symbol(Pattern):
    name: str
    def free_variables(self) -> set[Var]:
        return set()

    def substitute(self, x: Var, v: Pattern) -> 'Symbol':
        return self

@dataclass(frozen=True)
class EVar(Pattern):
    name: str

    def free_variables(self) -> set[Var]:
        return set([self])

    def substitute(self, x: Var, v: Pattern) -> Pattern:
        if x == self: return v
        else:         return self

@dataclass(frozen=True)
class SVar(Pattern):
    name: str

    def free_variables(self) -> set[Var]:
        return set([self])

    def substitute(self, x: Var, v: Pattern) -> Pattern:
        if x == self: return v
        else:         return self

@dataclass(frozen=True)
class And(Pattern):
    left: Pattern
    right: Pattern

    def free_variables(self) -> set[Var]:
        return self.left.free_variables().union(self.right.free_variables())

    def substitute(self, x: Var, v: Pattern) -> 'And':
        return And(self.left.substitute(x, v), self.right.substitute(x, v))

@dataclass(frozen=True)
class Or(Pattern):
    left: Pattern
    right: Pattern

    def free_variables(self) -> set[Var]:
        return self.left.free_variables().union(self.right.free_variables())

    def substitute(self, x: Var, v: Pattern) -> 'Or':
        return Or(self.left.substitute(x, v), self.right.substitute(x, v))

@dataclass(frozen=True)
class Not(Pattern):
    subpattern: Pattern

    def free_variables(self) -> set[Var]:
        return self.subpattern.free_variables()

    def substitute(self, x: Var, v: Pattern) -> 'Not':
        return Not(self.subpattern.substitute(x, v))

@dataclass(frozen=True)
class App(Pattern):
    left: Pattern
    right: Pattern

    def free_variables(self) -> set[Var]:
        return self.left.free_variables().union(self.right.free_variables())

    def substitute(self, x: Var, v: Pattern) -> 'App':
        return App(self.left.substitute(x, v), self.right.substitute(x, v))

@dataclass(frozen=True)
class Exists(Pattern):
    bound: EVar
    subpattern: Pattern

    def free_variables(self) -> set[Var]:
        return self.subpattern.free_variables() - set([self.bound])

    def substitute(self, x: Var, v: Pattern) -> 'Exists':
        if x == self.bound: return self
        else:               return Exists(self.bound, self.subpattern.substitute(x, v))

@dataclass(frozen=True)
class Forall(Pattern):
    bound: EVar
    subpattern: Pattern

    def free_variables(self) -> set[Var]:
        return self.subpattern.free_variables() - set([self.bound])

    def substitute(self, x: Var, v: Pattern) -> 'Forall':
        if x == self.bound: return self
        else:               return Forall(self.bound, self.subpattern.substitute(x, v))

@dataclass(frozen=True)
class Mu(Pattern):
    bound: SVar
    subpattern: Pattern

    def free_variables(self) -> set[Var]:
        return self.subpattern.free_variables() - set([self.bound])

    def substitute(self, x: Var, v: Pattern) -> 'Mu':
        if x == self.bound: return self
        else:               return Mu(self.bound, self.subpattern.substitute(x, v))

@dataclass(frozen=True)
class Nu(Pattern):
    bound: SVar
    subpattern: Pattern

    def free_variables(self) -> set[Var]:
        return self.subpattern.free_variables() - set([self.bound])

    def substitute(self, x: Var, v: Pattern) -> 'Nu':
        if x == self.bound: return self
        else:               return Nu(self.bound, self.subpattern.substitute(x, v))
