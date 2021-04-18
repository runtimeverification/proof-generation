from __future__ import annotations

from aml import *
from dataclasses import dataclass
from itertools import chain, combinations, count, product

from typing import Iterable, Iterator, Optional, TypeVar, Union

T = TypeVar('T')
def powerset(s: list[T]) -> Iterator[Iterable[T]]:
    return chain.from_iterable(combinations(s, r) for r in range(len(s)+1))

def definition_list(p: Pattern, existing_list: list[Pattern]) -> list[Pattern]:
    if isinstance(p, SVar) or isinstance(p, EVar) or isinstance(p, Symbol):
        return existing_list
    elif isinstance(p, Not) and (isinstance(p.subpattern, (SVar, EVar, Symbol))):
        return existing_list
    elif isinstance(p, App) or isinstance(p, DApp) or isinstance(p, And) or isinstance(p, Or):
        existing_list = definition_list(p.left,  existing_list)
        existing_list = definition_list(p.right, existing_list)
        return existing_list
    elif isinstance(p, Mu) or isinstance(p, Nu):
        if p not in existing_list:
            existing_list = existing_list + [p]
            existing_list = definition_list(p.subpattern.substitute(p.bound, SVar(existing_list.index(p))), existing_list)
        return existing_list
    else:
        raise NotImplementedError

@dataclass(frozen=True)
class TracedPattern:
    """ Annotates patterns with a trace of regenerated definitional constants.  """ 
    trace_id: list[int]
    pattern: Pattern

    def left(self) -> TracedPattern:
        assert(isinstance(self.pattern, (App, DApp, And, Or)))
        return TracedPattern(self.trace_id + [0], self.pattern.left)
    def right(self) -> TracedPattern:
        assert(isinstance(self.pattern, (App, DApp, And, Or)))
        return TracedPattern(self.trace_id + [1], self.pattern.right)

    def closure(self) -> list[list[TracedPattern]]:
        """Calculate possible closures by applying all non-app tableau rules

           Since rules may have `Or`s multiple closures.
        """
        if   isinstance(self.pattern, (SVar, EVar, Symbol, App, DApp, Exists, Forall)):
            return [[self]]
        elif isinstance(self.pattern, Not) and isinstance(self.pattern.subpattern, (SVar, EVar, Symbol)):
            return [[self]]
        elif isinstance(self.pattern, And):
            return TracedPattern.closurePs([self.left(), self.right()])
        elif isinstance(self.pattern, Or):
            return self.left().closure() + self.right().closure()
        elif isinstance(self.pattern, Mu) or isinstance(self.pattern, Nu):
            return TracedPattern(self.trace_id, self.pattern.subpattern.substitute(self.pattern.bound, self.pattern)).closure()
        else:
            raise NotImplementedError

    @staticmethod
    def closurePs(patterns: list[TracedPattern]) -> list[list[TracedPattern]]:
        if patterns == []: return [[]]
        p, *ps = patterns
        ret : list[list[TracedPattern]] = []
        for l, r in product(p.closure(), TracedPattern.closurePs(ps)):
            ret += [l + r]
        return ret

class Node:
    @staticmethod
    def make_nodes(patterns: list[Pattern]) -> 'Node':
        return Node.from_closure([TracedPattern([i], p) for i, p in zip(count(start=0), patterns)])

    @staticmethod
    def from_closure(patterns: list[TracedPattern]) -> 'Node':
        closure = TracedPattern.closurePs(patterns)
        if len(closure) == 1: return Sequent(closure[0])
        return OrNode([Sequent(gamma) for gamma in closure])

@dataclass
class OrNode(Node):
    children: list[Node]

@dataclass
class AndNode(Node):
    children: list[Node]

@dataclass
class Sequent(Node):
    gamma: list[TracedPattern]

    def is_inconsistant(self) -> bool:
        gamma : list[Pattern] = [tp.pattern for tp in self.gamma]
        atoms : set[Pattern] = set([phi.negate() for phi in gamma if isinstance(phi, (Symbol, EVar, SVar))])
        return not bool(atoms.intersection(set(gamma)))

    def children(self) -> Node:
        if not self.is_inconsistant(): return OrNode([])
        apps  = [phi for phi in self.gamma if isinstance(phi.pattern, App)]
        dapps = [phi for phi in self.gamma if isinstance(phi.pattern, DApp)]
        left_partitions = powerset(dapps)
        return AndNode([ OrNode([ AndNode([ Node.from_closure([app.left()] + list(map(TracedPattern.left, left)))
                                          , Node.from_closure([app.right()] + list(map(TracedPattern.right, set(dapps) - set(left))))])
                                  for left in left_partitions
                                ])
                         for app in apps
                       ])

def build_quasimodel(node: Node, path_prefix: list[list[Pattern]]) -> Node:
    if isinstance(node, Sequent):
        gamma_p = [tp.pattern for tp in node.gamma]
        if gamma_p in path_prefix: return node
        else: path_prefix = path_prefix + [gamma_p]

        child = node.children()
        if child == AndNode([]): return node
        else: node = child

    if isinstance(node, AndNode):
        children = [build_quasimodel(child, path_prefix) for child in node.children]
        if any((child == OrNode([]) for child in children)): return OrNode([])
        return AndNode(children)
    elif isinstance(node, OrNode):
        for child in node.children:
            tab = build_quasimodel(child, path_prefix)
            if tab != OrNode([]): return tab
        return OrNode([])
    raise NotImplementedError

################################################################################

def is_inconsistant(gamma: list[Pattern]) -> bool:
    negated_atoms : set[Pattern] = set([phi.negate() for phi in gamma if isinstance(phi, (Symbol, EVar, SVar))])
    return bool(negated_atoms.intersection(set(gamma)))

def is_satisfiable(gamma: list[Pattern], processed: list[Pattern] = []) -> bool:
    while gamma:
        p, *gamma = gamma
        if   isinstance(p, (Symbol, App, DApp)):
            processed = processed + [p]
        elif isinstance(p, Not) and isinstance(p.subpattern, (Symbol)):
            processed = processed + [p]
        elif isinstance(p, And):
            processed = processed + [p.left, p.right]
#        elif isinstance(p, SVar) and isinstance(p.name, int): # Definitional Constant
#            return is_satisfiable(gamma, processed + [definition_list[p.name]], definition_list)
#        elif isinstance(p, Mu) or isinstance(p, Nu):
#            return is_satisfiable(gamma, processed + [p.subpattern.substitute(p.bound, SVar(definition_list.index(p)))], definition_list)
        elif isinstance(p, Or):
            return is_satisfiable(gamma + [p.left],  processed) \
                or is_satisfiable(gamma + [p.right], processed)
        else:
            raise NotImplementedError

    print(processed)
    print(is_inconsistant(processed))

    if is_inconsistant(processed): return False
    apps  = [phi for phi in processed if isinstance(phi, App)]
    dapps = [phi for phi in processed if isinstance(phi, DApp)]
    left_partitions = powerset(dapps)

    return all( any(     is_satisfiable([app.left]  + list(map(lambda p: p.left,  left)))
                     and is_satisfiable([app.right] + list(map(lambda p: p.right, set(dapps) - set(left))))
                    for left in left_partitions) for app in apps )
