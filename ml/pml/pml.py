from abc import abstractmethod
from dataclasses import dataclass
from itertools import accumulate, count, islice
from functools import reduce
from typing import Container, FrozenSet, Hashable, Iterable, List, Tuple, TypeVar, Union

Var = Union['SVar', 'EVar']

class Pattern:
    @abstractmethod
    def free_variables(self) -> FrozenSet[Var]:
        raise NotImplementedError

    def free_evars(self) -> FrozenSet['EVar']:
        return frozenset({ x for x in self.free_variables() if isinstance(x, EVar)})

    @abstractmethod
    def substitute(self, x: 'Var', v: 'Pattern') -> 'Pattern':
        raise NotImplementedError

    @abstractmethod
    def negate(self) -> 'Pattern':
        raise NotImplementedError

    @abstractmethod
    def to_positive_normal_form(self) -> 'Pattern':
        raise NotImplementedError

    @abstractmethod
    def to_latex(self) -> str:
        raise NotImplementedError

    @abstractmethod
    def to_utf(self) -> str:
        raise NotImplementedError

@dataclass(frozen=True)
class Top(Pattern):
    def free_variables(self) -> FrozenSet[Var]:
        return frozenset()

    def substitute(self, _x: Var, _v: Pattern) -> 'Top':
        return self

    def negate(self) -> 'Bottom':
        return Bottom()

    def to_positive_normal_form(self) -> Pattern:
        return self

    def to_latex(self) -> str:
        return '\\top{}'

    def to_utf(self) -> str:
        return '⊤'


@dataclass(frozen=True)
class Bottom(Pattern):
    def free_variables(self) -> FrozenSet[Var]:
        return frozenset()

    def substitute(self, _x: Var, _v: Pattern) -> 'Bottom':
        return self

    def negate(self) -> Top:
        return Top()

    def to_positive_normal_form(self) -> Pattern:
        return self

    def to_latex(self) -> str:
        return '\\bot{}'

    def to_utf(self) -> str:
        return '⊥'

@dataclass(frozen=True)
class EVar(Pattern):
    name: str

    def free_variables(self) -> FrozenSet[Var]:
        return frozenset([self])

    def substitute(self, x: Var, v: Pattern) -> Pattern:
        if x == self: return v
        else:         return self

    def negate(self) -> 'Not':
        return Not(self)

    def to_positive_normal_form(self) -> Pattern:
        return self

    def to_latex(self) -> str:
        return '\\$' + self.name

    def to_utf(self) -> str:
        return '$' + self.name

@dataclass(frozen=True)
class SVar(Pattern):
    name: Hashable

    def free_variables(self) -> FrozenSet[Var]:
        return frozenset([self])

    def substitute(self, x: Var, v: Pattern) -> Pattern:
        if x == self: return v
        else:         return self

    def negate(self) -> 'Not':
        return Not(self)

    def to_positive_normal_form(self) -> Pattern:
        return self

    def to_latex(self) -> str:
        return str(self.name)

    def to_utf(self) -> str:
        return str(self.name)

@dataclass(frozen=True)
class And(Pattern):
    left: Pattern
    right: Pattern

    def free_variables(self) -> FrozenSet[Var]:
        return self.left.free_variables().union(self.right.free_variables())

    def substitute(self, x: Var, v: Pattern) -> 'And':
        return And(self.left.substitute(x, v), self.right.substitute(x, v))

    def negate(self) -> 'Or':
        return Or(self.left.negate(), self.right.negate())

    def to_positive_normal_form(self) -> 'And':
        return And(self.left.to_positive_normal_form(), self.right.to_positive_normal_form())

    def to_latex(self) -> str:
        return self.left.to_latex() + '\\land' + self.right.to_latex()

    def to_utf(self) -> str:
        return self.left.to_utf() + ' ⋀ ' + self.right.to_utf()

@dataclass(frozen=True)
class Or(Pattern):
    left: Pattern
    right: Pattern

    def free_variables(self) -> FrozenSet[Var]:
        return self.left.free_variables().union(self.right.free_variables())

    def substitute(self, x: Var, v: Pattern) -> 'Or':
        return Or(self.left.substitute(x, v), self.right.substitute(x, v))

    def negate(self) -> And:
        return And(self.left.negate(), self.right.negate())

    def to_positive_normal_form(self) -> 'Or':
        return Or(self.left.to_positive_normal_form(), self.right.to_positive_normal_form())

    def to_latex(self) -> str:
        return self.left.to_latex() + '\\lor' + self.right.to_latex()

    def to_utf(self) -> str:
        return self.left.to_utf() + ' ⋁ ' + self.right.to_utf()

@dataclass(frozen=True)
class Not(Pattern):
    subpattern: Pattern

    def free_variables(self) -> FrozenSet[Var]:
        return self.subpattern.free_variables()

    def substitute(self, x: Var, v: Pattern) -> 'Not':
        return Not(self.subpattern.substitute(x, v))

    def negate(self) -> Pattern:
        return self.subpattern

    def to_positive_normal_form(self) -> Pattern:
        return self.subpattern.negate()

    def to_latex(self) -> str:
        return '\\lnot' + self.subpattern.to_latex()

    def to_utf(self) -> str:
        return '¬' + self.subpattern.to_utf()

Symbol = str

@dataclass(frozen=True)
class App(Pattern):
    symbol:    Symbol
    arguments: Tuple[Pattern, ...]

    def __init__(self, symbol: Symbol, *args: Pattern) -> None:
        object.__setattr__(self, 'symbol', symbol)
        object.__setattr__(self, 'arguments', args)

    def free_variables(self) -> FrozenSet[Var]:
        return reduce(frozenset.union, map(lambda p: p.free_variables(), self.arguments), frozenset())

    def substitute(self, x: Var, v: Pattern) -> 'App':
        return App(self.symbol, *map(lambda p: p.substitute(x, v), self.arguments))

    def negate(self) -> 'DApp':
        return DApp(self.symbol, *map(lambda p: p.negate(), self.arguments))

    def to_positive_normal_form(self) -> 'App':
        return App(self.symbol, *map(lambda p: p.to_positive_normal_form(), self.arguments))

    def to_latex(self) -> str:
        return self.symbol + '(' + ','.join(map(lambda p: p.to_latex(), self.arguments)) + ')'

    def to_utf(self) -> str:
        return self.symbol + '(' + ','.join(map(lambda p: p.to_utf(), self.arguments)) + ')'

@dataclass(frozen=True)
class DApp(Pattern):
    symbol:    Symbol
    arguments: Tuple[Pattern, ...]

    def __init__(self, symbol: Symbol, *args: Pattern) -> None:
        object.__setattr__(self, 'symbol', symbol)
        object.__setattr__(self, 'arguments', args)

    def free_variables(self) -> FrozenSet[Var]:
        return reduce(frozenset.union, map(lambda p: p.free_variables(), self.arguments), frozenset())

    def substitute(self, x: Var, v: Pattern) -> 'DApp':
        return DApp(self.symbol, *map(lambda p: p.substitute(x, v), self.arguments))

    def negate(self) -> App:
        return App(self.symbol, *map(lambda p: p.negate(), self.arguments))

    def to_positive_normal_form(self) -> 'DApp':
        return DApp(self.symbol, *map(lambda p: p.to_positive_normal_form(), self.arguments))

    def to_latex(self) -> str:
        return '\\bar{' + self.symbol + '}' + '(' + ','.join(map(lambda p: p.to_latex(), self.arguments)) + ')'

    def to_utf(self) -> str:
        return '[' + self.symbol + ']' + '(' + ','.join(map(lambda p: p.to_utf(), self.arguments)) + ')'

@dataclass(frozen=True)
class Exists(Pattern):
    bound: frozenset[EVar]
    subpattern: Pattern
    guard: Pattern

    def __init__( self
                , bound: Union[EVar, Iterable[EVar]]
                , subpattern: Pattern
                , guard: Pattern = Top()
                ):
        if   isinstance(bound, EVar): bound = frozenset([bound])
        else:                         bound = frozenset(bound)

        # workaround for frozen
        object.__setattr__(self, "bound", bound)
        object.__setattr__(self, "subpattern", subpattern)
        object.__setattr__(self, "guard", guard)

    def free_variables(self) -> FrozenSet[Var]:
        return self.subpattern.free_variables().union(self.guard.free_variables()) - self.bound

    def substitute(self, x: Var, v: Pattern) -> 'Exists':
        if x in self.bound: return self
        else:               return Exists(self.bound, self.subpattern.substitute(x, v), guard=self.guard.substitute(x, v))

    def negate(self) -> 'Forall':
        return Forall(self.bound, self.subpattern.negate(), guard=self.guard)

    def to_positive_normal_form(self) -> Pattern:
        return Exists(self.bound, self.subpattern.to_positive_normal_form(), guard=self.guard.to_positive_normal_form())

    def to_latex(self) -> str:
        return '\\exists ' + ','.join(map(lambda p: p.to_latex(), self.bound)) + \
                    ' \\ldotp ' + self.guard.to_latex() + ' \\limplies ' + self.subpattern.to_latex()

    def to_utf(self) -> str:
        return '∃ ' + ','.join(map(lambda p: p.to_utf(), self.bound)) + \
                    ' . ' + self.guard.to_latex() + ' -> ' + self.subpattern.to_utf()

@dataclass(frozen=True)
class Forall(Pattern):
    bound: frozenset[EVar]
    subpattern: Pattern
    guard: Pattern = Top()

    def __init__( self
                , bound: Union[EVar, Iterable[EVar]]
                , subpattern: Pattern
                , guard: Pattern = Top()
                ):
        if   isinstance(bound, EVar): bound = frozenset([bound])
        else:                         bound = frozenset(bound)

        # workaround for frozen
        object.__setattr__(self, "bound", bound)
        object.__setattr__(self, "subpattern", subpattern)
        object.__setattr__(self, "guard", guard)

    def free_variables(self) -> FrozenSet[Var]:
        return self.subpattern.free_variables().union(self.guard.free_variables()) - self.bound

    def substitute(self, x: Var, v: Pattern) -> 'Forall':
        if x in self.bound: return self
        else:               return Forall(self.bound, self.subpattern.substitute(x, v), guard=self.guard.substitute(x, v))

    def negate(self) -> Exists:
        return Exists(self.bound, self.subpattern.negate(), guard=self.guard)

    def to_positive_normal_form(self) -> Pattern:
        return Forall(self.bound, self.subpattern.to_positive_normal_form(), guard=self.guard.to_positive_normal_form())

    def to_latex(self) -> str:
        return '\\forall ' + ','.join(map(lambda p: p.to_latex(), self.bound)) + \
                    ' \\ldotp ' + self.guard.to_latex() + ' \\land ' + self.subpattern.to_latex()

    def to_utf(self) -> str:
        return '∀ ' + ','.join(map(lambda p: p.to_utf(), self.bound)) + \
                        ' . ' + self.guard.to_latex() + ' ⋀ ' + self.subpattern.to_utf()

@dataclass(frozen=True)
class Mu(Pattern):
    bound: SVar
    subpattern: Pattern

    def free_variables(self) -> FrozenSet[Var]:
        return self.subpattern.free_variables() - frozenset([self.bound])

    def substitute(self, x: Var, v: Pattern) -> 'Mu':
        if x == self.bound: return self
        else:               return Mu(self.bound, self.subpattern.substitute(x, v))

    def negate(self) -> 'Nu':
        return Nu(self.bound, self.subpattern.substitute(self.bound, Not(self.bound)).negate())

    def to_positive_normal_form(self) -> 'Mu':
        return Mu(self.bound, self.subpattern.to_positive_normal_form())

    def alpha_rename(self, v: SVar) -> 'Mu':
        return Mu(v, self.subpattern.substitute(self.bound, v))

    def to_latex(self) -> str:
        return '\\mu ' + self.bound.to_latex() + ' \\ldotp ' + self.subpattern.to_latex()

    def to_utf(self) -> str:
        return 'μ ' + self.bound.to_utf() + ' . ' + self.subpattern.to_utf()

@dataclass(frozen=True)
class Nu(Pattern):
    bound: SVar
    subpattern: Pattern

    def free_variables(self) -> FrozenSet[Var]:
        return self.subpattern.free_variables() - frozenset([self.bound])

    def substitute(self, x: Var, v: Pattern) -> 'Nu':
        if x == self.bound: return self
        else:               return Nu(self.bound, self.subpattern.substitute(x, v))

    def negate(self) -> Mu:
        return Mu(self.bound, self.subpattern.substitute(self.bound, Not(self.bound)).negate())

    def to_positive_normal_form(self) -> 'Nu':
        return Nu(self.bound, self.subpattern.to_positive_normal_form())

    def alpha_rename(self, v: SVar) -> 'Nu':
        return Nu(v, self.subpattern.substitute(self.bound, v))

    def to_latex(self) -> str:
        return '\\nu ' + self.bound.to_latex() + ' \\ldotp ' + self.subpattern.to_latex()

    def to_utf(self) -> str:
        return 'ν ' + self.bound.to_utf() + ' . ' + self.subpattern.to_utf()

def implies(phi: Pattern, psi: Pattern) -> Pattern:
    return Or(Not(phi), psi)

# Helper Utilities
# ----------------

T = TypeVar('T')
def diff(l1: List[T] , l2_set: Container[T]) -> List[T]:
    # Preserves order
    return [item for item in l1 if item not in l2_set]

def take(n: int, l: Iterable[T]) -> Tuple[T, ...]:
  return tuple(islice(l, n))

