from __future__ import annotations

from dataclasses import dataclass
from itertools import chain, combinations
from typing import Any, Dict, FrozenSet, Iterable, Iterator, List, Tuple, TypeVar
from subprocess import check_output
import re

from aml import *

T = TypeVar('T')
def powerset(s: List[T]) -> Iterator[Iterable[T]]:
    return chain.from_iterable(combinations(s, r) for r in range(len(s)+1))

DefList = List[Pattern]
def definition_list(p: Pattern, def_list: DefList) -> DefList:
    if def_list is None: def_list = []

    if isinstance(p, (SVar, EVar, Symbol, Bottom, Top)):
        return def_list
    elif isinstance(p, Not) and (isinstance(p.subpattern, (SVar, EVar, Symbol))):
        return def_list
    elif isinstance(p, (App, DApp, And, Or)):
        def_list = definition_list(p.left,  def_list)
        def_list = definition_list(p.right, def_list)
        return def_list
    elif isinstance(p, (Mu, Nu)):
        if p not in def_list:
            def_list = def_list + [p]
            def_list = definition_list(p.subpattern.substitute(p.bound, SVar(def_list.index(p))), def_list)
        return def_list
    else:
        raise RuntimeError("Unsupported pattern: " + str(p))

class Assertion:
    pass

@dataclass(frozen=True)
class Matches(Assertion):
    variable: EVar
    pattern:  Pattern

@dataclass(frozen=True)
class AllOf(Assertion):
    assertions: FrozenSet[Assertion]

@dataclass(frozen=True)
class AnyOf(Assertion):
    assertions: FrozenSet[Assertion]

@dataclass(frozen=True)
class PGNode():
    assertion: Assertion
    closure: FrozenSet[Assertion]

ParityGame = Dict[PGNode, FrozenSet[PGNode]]
SerializedParityGameEntry = Tuple[int, int, int, List[int]]
SerializedParityGame = List[SerializedParityGameEntry]
def print_parity_game(root: PGNode, edges: ParityGame, def_list: DefList) -> SerializedParityGame:
    ret = []
    keys = list(edges.keys())

    def ident(node: PGNode) -> int:
        return keys.index(node)

    def priority(node: PGNode, def_list: DefList) -> int:
        if isinstance(node.assertion, Matches):
            if isinstance(node.assertion.pattern, Nu):
                return 2 * def_list.index(node.assertion.pattern)
            if isinstance(node.assertion.pattern, Mu):
                return 2 * def_list.index(node.assertion.pattern) + 1
            if isinstance(node.assertion.pattern, Bottom):
                return 2 * len(def_list) + 1
            else:
                return 2 * len(def_list)
        else:
            return 2 * len(def_list)

    def player(node: PGNode) -> int:
        if isinstance(node.assertion, Matches):
            if isinstance(node.assertion.pattern, (Top, And, Forall, DApp, Mu, Nu, SVar, EVar, Symbol)):
                return 1
            if isinstance(node.assertion.pattern, (Bottom, Or, Exists, App)):
                return 0
        if isinstance(node.assertion, AllOf):
            return 1
        if isinstance(node.assertion, AnyOf):
            return 0
        raise RuntimeError("Unimplemented: " + str(node))

    for source, destinations in edges.items():
        ret += [(ident(source), priority(source, def_list), player(source), sorted(list(map(ident, destinations))))]
    return ret

def build_parity_game( node         : PGNode
                     , def_list     : DefList
                     , edges        : ParityGame
                     ) -> ParityGame:
    if isinstance(node.assertion, Matches):
        if isinstance(node.assertion.pattern, (Bottom, Top)):
            edges[node] = frozenset([node])
        else:
            raise RuntimeError("Unimplemented: " + str(node))
    else:
        raise RuntimeError("Unimplemented: " + str(node))
    return edges

def run_pgsolver(game: SerializedParityGame) -> bool:
    def entry_to_string(entry : SerializedParityGameEntry) -> str:
        source, priority, player, dests = entry
        return " ".join([str(source), str(priority), str(player), ",".join(map(str, dests))])
    input = "; \n".join(map(entry_to_string, game)) + ';'
    output = check_output(['pgsolver', '-local',  'stratimprloc2', '0'], input=input, text=True)
    match = re.search(r'Winner of initial node is player (\d)\n', output)
    if match is None:
        raise RuntimeError("PGGame not well formed?\n" + output)

    return match.group(1) == '0'

def build_closure(a: Assertion) -> FrozenSet[Assertion]:
    return frozenset([a])

def is_sat(p: Pattern) -> bool:
    def_list : DefList = definition_list(p, def_list = [])
    root = PGNode(Matches(EVar('$w'), p), build_closure(Matches(EVar('$w'), p)))
    pg = build_parity_game(root, def_list, edges = {})
    serialized = print_parity_game(root, pg, def_list)
    return run_pgsolver(serialized)
