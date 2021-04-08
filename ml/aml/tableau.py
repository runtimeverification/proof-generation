from aml import *
from dataclasses import dataclass
from itertools import chain, combinations, product

from typing import Iterable, Iterator, Union


def closure(p: Pattern) -> list[list[Pattern]]:
    if (
        isinstance(p, SVar)
        or isinstance(p, EVar)
        or isinstance(p, Symbol)
        or isinstance(p, App)
        or isinstance(p, Exists)
        or isinstance(p, Forall)
    ):
        return [[p]]
    elif isinstance(p, And):
        return closurePs([p.left, p.right])
    elif isinstance(p, Or):
        return closure(p.left) + closure(p.right)
    elif isinstance(p, Mu) or isinstance(p, Nu):
        return closure(p.subpattern.substitute(p.bound, p))
    else:
        raise NotImplementedError


def closurePs(patterns: list[Pattern]) -> list[list[Pattern]]:
    if patterns == []:
        return [[]]
    p, *ps = patterns
    ret: list[list[Pattern]] = []
    for l, r in product(closure(p), closurePs(ps)):
        ret += [l + r]
    return ret


Node = Union["OrNode", "AndNode", "SimpleNode"]

# TODO: Make typing more generic.
def powerset(s: list[DApp]) -> Iterator[Iterable[DApp]]:
    return chain.from_iterable(combinations(s, r) for r in range(len(s) + 1))


@dataclass
class OrNode:
    children: list[Node]


@dataclass
class AndNode:
    children: list[Node]


@dataclass
class SimpleNode:
    gamma: list[Pattern]

    def is_consitant(self) -> bool:
        atoms = set(
            [
                phi.negate()
                for phi in self.gamma
                if isinstance(phi, Symbol)
                or isinstance(phi, SVar)
                or isinstance(phi, EVar)
            ]
        )
        return not bool(atoms.intersection(set(self.gamma)))

    def children(self) -> Node:
        def project_left(p: DApp) -> Pattern:
            return p.left

        def project_right(p: DApp) -> Pattern:
            return p.right

        if not self.is_consitant():
            return OrNode([])
        apps = [phi for phi in self.gamma if isinstance(phi, App)]
        dapps = [phi for phi in self.gamma if isinstance(phi, DApp)]
        left_partitions = powerset(dapps)
        return AndNode(
            [
                OrNode(
                    [
                        AndNode(
                            [
                                SimpleNode([app.left] + list(map(project_left, left))),
                                SimpleNode(
                                    [app.right]
                                    + list(map(project_right, set(dapps) - set(left)))
                                ),
                            ]
                        )
                        for left in left_partitions
                    ]
                )
                for app in apps
            ]
        )
