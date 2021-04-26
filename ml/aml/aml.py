from dataclasses import dataclass
from typing import FrozenSet, Hashable, Union
from abc import abstractmethod

Var = Union['SVar', 'EVar']

class Pattern:
    @abstractmethod
    def free_variables(self) -> FrozenSet[Var]:
        raise NotImplementedError

    @abstractmethod
    def substitute(self, x: 'Var', v: 'Pattern') -> 'Pattern':
        raise NotImplementedError

    @abstractmethod
    def subpatterns(self) -> FrozenSet['Pattern']:
        raise NotImplementedError

    @abstractmethod
    def negate(self) -> 'Pattern':
        raise NotImplementedError

@dataclass(frozen=True)
class Symbol(Pattern):
    name: str
    def free_variables(self) -> FrozenSet[Var]:
        return frozenset()

    def substitute(self, _x: Var, _v: Pattern) -> 'Symbol':
        return self

    def subpatterns(self) -> FrozenSet[Pattern]:
        return frozenset([self])

    def negate(self) -> 'Not':
        return Not(self)

@dataclass(frozen=True)
class EVar(Pattern):
    name: str

    def free_variables(self) -> FrozenSet[Var]:
        return frozenset([self])

    def substitute(self, x: Var, v: Pattern) -> Pattern:
        if x == self: return v
        else:         return self

    def subpatterns(self) -> FrozenSet[Pattern]:
        return frozenset([self])

    def negate(self) -> 'Not':
        return Not(self)

@dataclass(frozen=True)
class SVar(Pattern):
    name: Hashable

    def free_variables(self) -> FrozenSet[Var]:
        return frozenset([self])

    def substitute(self, x: Var, v: Pattern) -> Pattern:
        if x == self: return v
        else:         return self

    def subpatterns(self) -> FrozenSet[Pattern]:
        return frozenset([self])

    def negate(self) -> 'Not':
        return Not(self)

@dataclass(frozen=True)
class And(Pattern):
    left: Pattern
    right: Pattern

    def free_variables(self) -> FrozenSet[Var]:
        return self.left.free_variables().union(self.right.free_variables())

    def substitute(self, x: Var, v: Pattern) -> 'And':
        return And(self.left.substitute(x, v), self.right.substitute(x, v))

    def subpatterns(self) -> FrozenSet[Pattern]:
        return self.left.subpatterns().union(frozenset([self])).union(self.right.subpatterns())

    def negate(self) -> 'Or':
        return Or(self.left.negate(), self.right.negate())

@dataclass(frozen=True)
class Or(Pattern):
    left: Pattern
    right: Pattern

    def free_variables(self) -> FrozenSet[Var]:
        return self.left.free_variables().union(self.right.free_variables())

    def substitute(self, x: Var, v: Pattern) -> 'Or':
        return Or(self.left.substitute(x, v), self.right.substitute(x, v))

    def subpatterns(self) -> FrozenSet[Pattern]:
        return self.left.subpatterns().union(frozenset([self])).union(self.right.subpatterns())

    def negate(self) -> And:
        return And(self.left.negate(), self.right.negate())

@dataclass(frozen=True)
class Not(Pattern):
    subpattern: Pattern

    def free_variables(self) -> FrozenSet[Var]:
        return self.subpattern.free_variables()

    def substitute(self, x: Var, v: Pattern) -> 'Not':
        return Not(self.subpattern.substitute(x, v))

    def subpatterns(self) -> FrozenSet[Pattern]:
        return self.subpattern.subpatterns().union(frozenset([self]))

    def negate(self) -> Pattern:
        return self.subpattern

@dataclass(frozen=True)
class App(Pattern):
    left: Pattern
    right: Pattern

    def free_variables(self) -> FrozenSet[Var]:
        return self.left.free_variables().union(self.right.free_variables())

    def substitute(self, x: Var, v: Pattern) -> 'App':
        return App(self.left.substitute(x, v), self.right.substitute(x, v))

    def subpatterns(self) -> FrozenSet[Pattern]:
        return self.left.subpatterns().union(frozenset([self])).union(self.right.subpatterns())

    def negate(self) -> 'DApp':
        return DApp(self.left.negate(), self.right.negate())

@dataclass(frozen=True)
class DApp(Pattern):
    left: Pattern
    right: Pattern

    def free_variables(self) -> FrozenSet[Var]:
        return self.left.free_variables().union(self.right.free_variables())

    def substitute(self, x: Var, v: Pattern) -> 'DApp':
        return DApp(self.left.substitute(x, v), self.right.substitute(x, v))

    def subpatterns(self) -> FrozenSet[Pattern]:
        return self.left.subpatterns().union(frozenset([self])).union(self.right.subpatterns())

    def negate(self) -> App:
        return App(self.left.negate(), self.right.negate())

@dataclass(frozen=True)
class Exists(Pattern):
    bound: EVar
    subpattern: Pattern

    def free_variables(self) -> FrozenSet[Var]:
        return self.subpattern.free_variables() - frozenset([self.bound])

    def substitute(self, x: Var, v: Pattern) -> 'Exists':
        if x == self.bound: return self
        else:               return Exists(self.bound, self.subpattern.substitute(x, v))

    def subpatterns(self) -> FrozenSet[Pattern]:
        return self.subpattern.subpatterns().union(frozenset([self]))

    def negate(self) -> 'Forall':
        return Forall(self.bound, self.subpattern.negate())

@dataclass(frozen=True)
class Forall(Pattern):
    bound: EVar
    subpattern: Pattern

    def free_variables(self) -> FrozenSet[Var]:
        return self.subpattern.free_variables() - frozenset([self.bound])

    def substitute(self, x: Var, v: Pattern) -> 'Forall':
        if x == self.bound: return self
        else:               return Forall(self.bound, self.subpattern.substitute(x, v))

    def subpatterns(self) -> FrozenSet[Pattern]:
        return self.subpattern.subpatterns().union(frozenset([self]))

    def negate(self) -> Exists:
        return Exists(self.bound, self.subpattern.negate())

@dataclass(frozen=True)
class Mu(Pattern):
    bound: SVar
    subpattern: Pattern

    def free_variables(self) -> FrozenSet[Var]:
        return self.subpattern.free_variables() - frozenset([self.bound])

    def substitute(self, x: Var, v: Pattern) -> 'Mu':
        if x == self.bound: return self
        else:               return Mu(self.bound, self.subpattern.substitute(x, v))

    def subpatterns(self) -> FrozenSet[Pattern]:
        return self.subpattern.subpatterns().union(frozenset([self]))

    def negate(self) -> 'Nu':
        return Nu(self.bound, self.subpattern.substitute(self.bound, Not(self.bound)).negate())

    def alpha_rename(self, v: SVar) -> 'Mu':
        return Mu(v, self.subpattern.substitute(self.bound, v))

@dataclass(frozen=True)
class Nu(Pattern):
    bound: SVar
    subpattern: Pattern

    def free_variables(self) -> FrozenSet[Var]:
        return self.subpattern.free_variables() - frozenset([self.bound])

    def substitute(self, x: Var, v: Pattern) -> 'Nu':
        if x == self.bound: return self
        else:               return Nu(self.bound, self.subpattern.substitute(x, v))

    def subpatterns(self) -> FrozenSet[Pattern]:
        return self.subpattern.subpatterns().union(frozenset([self]))

    def negate(self) -> Mu:
        return Mu(self.bound, self.subpattern.substitute(self.bound, Not(self.bound)).negate())

    def alpha_rename(self, v: SVar) -> 'Nu':
        return Nu(v, self.subpattern.substitute(self.bound, v))
