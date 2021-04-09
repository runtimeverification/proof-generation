from aml import *
from dataclasses import dataclass
from itertools import chain, combinations, product

from typing import Iterable, Iterator, Union

# TODO: Make typing more generic.
def powerset(s: list[DApp]) -> Iterator[Iterable[DApp]]:
    return chain.from_iterable(combinations(s, r) for r in range(len(s)+1))

def closure(p: Pattern) -> list[list[Pattern]]:
    """Calculate possible closures by applying all non-app tableau rules

       Since rules may have `Or`s multiple closures.
    """
    if   isinstance(p, SVar) or isinstance(p, EVar) or isinstance(p, Symbol) \
      or isinstance(p, App) \
      or isinstance(p, Exists) or isinstance(p, Forall):
        return [[p]]
    elif isinstance(p, Not) and \
       ( isinstance(p.subpattern, SVar) or isinstance(p.subpattern, EVar) or isinstance(p.subpattern, Symbol)
      or isinstance(p.subpattern, App)
      or isinstance(p.subpattern, Exists) or isinstance(p.subpattern, Forall)):
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
    if patterns == []: return [[]]
    p, *ps = patterns
    ret : list[list[Pattern]] = []
    for l, r in product(closure(p), closurePs(ps)):
        ret += [l + r]
    return ret

class Node:
    @staticmethod
    def make_nodes(patterns: list[Pattern]) -> 'Node':
        closure = closurePs(patterns)
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
    gamma: list[Pattern]

    def is_consitant(self) -> bool:
        atoms = set([phi.negate() for phi in self.gamma if isinstance(phi, Symbol) or isinstance(phi, SVar) or isinstance(phi, EVar)])
        return not bool(atoms.intersection(set(self.gamma)))

    def children(self) -> Node:
        def project_left(p: DApp)  -> Pattern: return p.left
        def project_right(p: DApp) -> Pattern: return p.right

        if not self.is_consitant(): return OrNode([])
        apps  = [phi for phi in self.gamma if isinstance(phi, App)]
        dapps = [phi for phi in self.gamma if isinstance(phi, DApp)]
        left_partitions = powerset(dapps)
        return AndNode([ OrNode([ AndNode([ Node.make_nodes([app.left] + list(map(project_left, left)))
                                          , Node.make_nodes([app.right] + list(map(project_right, set(dapps) - set(left))))])
                                  for left in left_partitions
                                ])
                         for app in apps
                       ])

def build_quasimodel(node: Node, path_prefix: list[Node]) -> Node:
    if isinstance(node, Sequent):
        if node in path_prefix: return node
        else: path_prefix = path_prefix + [node]
        child = node.children()
        if child == AndNode([]): return node
        else: node = child

    if   isinstance(node, AndNode):
        children = [build_quasimodel(child, path_prefix) for child in node.children]
        if any((child == OrNode([]) for child in children)): return OrNode([])
        return AndNode(children)
    elif isinstance(node, OrNode):
        for child in node.children:
            tab = build_quasimodel(child, path_prefix)
            if tab != OrNode([]): return tab
        return OrNode([])
    raise NotImplementedError
