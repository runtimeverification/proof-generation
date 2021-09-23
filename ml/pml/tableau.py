from __future__ import annotations

from abc import abstractmethod
from dataclasses import dataclass
from itertools import chain, count, islice, product
from typing import Any, Dict, FrozenSet, Iterable, Iterator, List, Tuple, TypeVar, Union, cast
from subprocess import check_output
import re

from pml import *

Signature = Dict[Symbol, int]

DefList = List[Pattern]
def definition_list(p: Pattern, def_list: DefList) -> DefList:
    if def_list is None: def_list = []

    if isinstance(p, (SVar, EVar, Symbol, Bottom, Top)):
        return def_list
    elif isinstance(p, Not) and (isinstance(p.subpattern, (SVar, EVar, Symbol))):
        return def_list
    elif isinstance(p, (And, Or)):
        def_list = definition_list(p.left,  def_list)
        def_list = definition_list(p.right, def_list)
        return def_list
    elif isinstance(p, (App, DApp)):
        for arg in p.arguments:
            def_list = definition_list(arg,  def_list)
        return def_list
    elif isinstance(p, (Mu, Nu)):
        if p not in def_list:
            def_list = def_list + [p]
            def_list = definition_list(p.subpattern.substitute(p.bound, SVar(def_list.index(p))), def_list)
        return def_list
    else:
        raise RuntimeError("Unsupported pattern: " + str(p))

class Assertion:
    @abstractmethod
    def negate(self) -> 'Assertion':
        raise NotImplementedError

    @abstractmethod
    def free_evars(self) -> FrozenSet[EVar]:
        raise NotImplementedError

@dataclass(frozen=True)
class Matches(Assertion):
    variable: EVar
    pattern:  Pattern

    def negate(self) -> Matches:
        return Matches(self.variable, self.pattern.negate())

    def free_evars(self) -> FrozenSet[EVar]:
        return self.pattern.free_evars().union([self.variable])

@dataclass(frozen=True)
class AllOf(Assertion):
    assertions: FrozenSet[Assertion]

    def negate(self) -> AnyOf:
        return AnyOf(frozenset([a.negate() for a in self.assertions]))

    def free_evars(self) -> FrozenSet[EVar]:
        ret : FrozenSet[EVar] = frozenset()
        for assertion in self.assertions:
            ret = ret.union(assertion.free_evars())
        return ret

@dataclass(frozen=True)
class AnyOf(Assertion):
    assertions: FrozenSet[Assertion]

    def negate(self) -> AllOf:
        return AllOf(frozenset([a.negate() for a in self.assertions]))

    def free_evars(self) -> FrozenSet[EVar]:
        ret : FrozenSet[EVar] = frozenset()
        for assertion in self.assertions:
            ret = ret.union(assertion.free_evars())
        return ret

Closure = FrozenSet[Assertion]
def free_evars(cl: Closure) -> FrozenSet[EVar]:
    ret : FrozenSet[EVar] = frozenset()
    for assertion in cl:
        ret = ret.union(assertion.free_evars())
    return ret

@dataclass(frozen=True)
class PGNode():
    assertion: Assertion
    closure: Closure

@dataclass(frozen=True)
class Root():
    assertion: Assertion

@dataclass(frozen=True)
class Unsat():
    pass

PGNodeGeneralized = Union[PGNode, Root, Unsat]

ParityGame = Dict[PGNodeGeneralized, FrozenSet[PGNodeGeneralized]]
SerializedParityGameEntry = Tuple[int, int, int, List[int]]
SerializedParityGame = List[SerializedParityGameEntry]

Tableau = Dict[Closure, FrozenSet[Closure]]

def print_parity_game(root: PGNodeGeneralized, edges: ParityGame, def_list: DefList) -> SerializedParityGame:
    ret = []
    keys = list(edges.keys())

    def ident(node: PGNodeGeneralized) -> int:
        if isinstance(node, Root):
            return 0
        if isinstance(node, Unsat):
            return 2
        return 3 + keys.index(node)

    def priority(node: PGNodeGeneralized, def_list: DefList) -> int:
        if isinstance(node, Root):
            return 0 # Cannot repeat on any trace, so value doesn't matter.
        if isinstance(node, Unsat):
            return 1
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

    def player(node: PGNodeGeneralized) -> int:
        if isinstance(node, (Root, Unsat, Top, Bottom, Mu, Nu, SVar, EVar)):
            # There is no choice to be made here, so it does not matter whose turn it is.
            return 0 
        if isinstance(node.assertion, Matches):
            if isinstance(node.assertion.pattern, (And, Forall, DApp)):
                return 1
            if isinstance(node.assertion.pattern, (Or,  Exists, App)):
                return 0
        if isinstance(node.assertion, AllOf):
            return 1
        if isinstance(node.assertion, AnyOf):
            return 0
        raise RuntimeError("Unimplemented: " + str(node))

    for source, destinations in edges.items():
        ret += [(ident(source), priority(source, def_list), player(source), sorted(list(map(ident, destinations))))]
    return ret

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

PartialEdges = List[Tuple[Assertion, Assertion]]

def is_atomic_application(app : App) -> bool:
    return all(map(lambda arg: isinstance(arg, EVar), app.arguments))

def add_app_dapp_to_closure(pairs : List[Tuple[Matches, Matches]] , partial_closure: Closure, partial_edges: PartialEdges, K: List[EVar]) -> List[Tuple[Closure, PartialEdges]]:
    curr_closures = [(partial_closure, partial_edges)]
    all_of : List[Assertion] = []
    for (app, dapp) in pairs:
        assert isinstance(app.pattern, App)
        assert isinstance(dapp.pattern, DApp)
        assert app.pattern.symbol == dapp.pattern.symbol

        if is_atomic_application(app.pattern):
            new_closures = []
            for (curr_closure, curr_edges) in curr_closures:
                if Matches(app.variable, app.pattern.negate()) == dapp:
                    return add_to_closure( Matches(app.variable, Bottom())
                                         , curr_closure
                                         , curr_edges +
                                           [(dapp, Matches(app.variable, Bottom()))
                                           ,( app, Matches(app.variable, Bottom())) 
                                           ]
                                         , K
                                         )

                any_of : List[Assertion] = []
                for ci, phii in zip(app.pattern.arguments, dapp.pattern.arguments):
                    assert isinstance(ci, EVar)
                    any_of += [Matches(ci, phii)]
                new_closures += add_to_closure(AllOf(frozenset(all_of)), curr_closure, curr_edges, K)
            curr_closures = new_closures
    return curr_closures

def add_to_closure(assertion: Assertion, partial_closure: Closure, partial_edges: PartialEdges, K: List[EVar]) -> List[Tuple[Closure, PartialEdges]]:
    if isinstance(assertion, Matches):
        p = assertion.pattern
        if   isinstance(p, (Bottom)):
            return []
        elif isinstance(p, (Top)):
            return [( partial_closure.union([assertion])
                    , partial_edges + [(assertion, assertion)]
                    )]
        elif isinstance(p, EVar):
            if assertion.variable != p:
                return add_to_closure( Matches(assertion.variable, Bottom())
                                     , partial_closure.union([assertion])
                                     , partial_edges + [(assertion, Matches(assertion.variable, Bottom()))]
                                     , K)
            return [(partial_closure, partial_edges)]
        elif isinstance(p, Not):
            assert isinstance(p.subpattern, EVar)
            if Matches(assertion.variable, p.negate()) in partial_closure:
                return add_to_closure( Matches(assertion.variable, Bottom())
                                     , partial_closure.union([assertion])
                                     , partial_edges + [(assertion, Matches(assertion.variable, Bottom()))]
                                     , K)
            return [(partial_closure, partial_edges)]
        elif isinstance(p, DApp):
            if (is_atomic_application(p.negate())):
                partial_edges = partial_edges + [(assertion, assertion)]
            apps = [a for a in partial_closure if    isinstance(a, Matches)
                                                and isinstance(a.pattern, App)
                                                and a.pattern.symbol == p.symbol]
            return add_app_dapp_to_closure( list(product(apps, [assertion]))
                                          , partial_closure.union(frozenset([assertion]))
                                          , partial_edges
                                          , K
                                          )
        elif isinstance(p, App):
            if (is_atomic_application(p)):
                partial_edges = partial_edges + [(assertion, assertion)]
            dapps = [a for a in partial_closure if   isinstance(a, Matches)
                                                and isinstance(a.pattern, DApp)
                                                and a.pattern.symbol == p.symbol]
            return add_app_dapp_to_closure( list(product([assertion], dapps))
                                          , partial_closure.union(frozenset([assertion]))
                                          , partial_edges
                                          , K
                                          )
        elif isinstance(p, And):
            ret = []
            partial_closure = partial_closure.union([assertion])
            for (closure, edges) in add_to_closure( Matches(assertion.variable, p.left)
                                         , partial_closure
                                         , partial_edges + [(assertion, Matches(assertion.variable, p.left))]
                                         , K
                                         ):
                ret += add_to_closure( Matches(assertion.variable, p.right)
                                     , closure
                                     , edges + [(assertion, Matches(assertion.variable, p.right))]
                                     , K)
            return ret
        else:
            raise RuntimeError("Unimplemented: ")
    elif isinstance(assertion, AllOf):
        curr_closures = [(partial_closure, partial_edges)]
        for a in assertion.assertions:
            new_closures = []
            for (closure, edges) in curr_closures:
                new_closures += add_to_closure( a
                                              , closure
                                              , edges + [(assertion, a)]
                                              , K)
            curr_closures = new_closures
        return curr_closures
    elif isinstance(assertion, AnyOf):
        if len(assertion.assertions) == 0:
            return []
        ret = []
        for a in assertion.assertions:
            ret += add_to_closure(a, partial_closure, partial_edges + [(assertion, a)], K)
        return ret
    else:
        raise RuntimeError("Unimplemented: ")

def complete_closures_for_signature( closures: List[Tuple[Closure, PartialEdges]]
                                   , C: FrozenSet[EVar]
                                   , K: List[EVar]
                                   , signature: Signature
                                   , parity_game : ParityGame) -> List[Closure]:
    # TODO: This should be replaced by some form of resulution
    for (symbol, arity) in signature.items():
        for tuple in product(C, repeat = arity + 1):
            new_closures = []
            for (partial_closure, partial_edges) in closures:
                first, *rest = tuple
                new_edges : PartialEdges = []
                x = add_to_closure(Matches(first, App(symbol, *rest)),          partial_closure, partial_edges, K)
                y = add_to_closure(Matches(first, App(symbol, *rest).negate()), partial_closure, partial_edges, K)
                new_closures += x
                new_closures += y
            closures = new_closures

    ret : List[Closure] = []
    for (closure, partial_edges) in closures:
        for (source, dest) in partial_edges:
            source_node = PGNode(source, closure)
            parity_game[source_node] = parity_game.get(source_node, frozenset()).union([PGNode(dest, closure)])
        ret += [closure]
    return ret

def diff(l1: List[EVar] , l2_set: FrozenSet[EVar]) -> List[EVar]:
    # Preserves order
    return [item for item in l1 if item not in l2_set]

def take(n: int, l: List[EVar]) -> List[EVar]:
  return list(islice(l, n))

def build_tableau( currentNode: Closure
                 , partial_tableau: Tableau
                 , partial_game : ParityGame
                 , K: List[EVar]
                 , signature: Signature) -> None:
    if currentNode in partial_tableau.keys(): return
    next_nodes : List[Closure] = []
    for assertion in currentNode:
        if not isinstance(assertion, Matches):
            continue
        p = assertion.pattern
        if not isinstance(p, App):
            continue
        if all(map(lambda arg: isinstance(arg, EVar), p.arguments)):
            continue

        # TODO: Fixme: We need new_clousre == currentNode if instantiation does not bring in new variables.
        new_closure = frozenset({ a for a in currentNode if p.free_evars() <= p.free_evars().union({assertion.variable}) })

        failed_instantiations : List[Assertion] = []
        potential_variables = list(assertion.free_evars()) + take(len(p.arguments), diff(K, free_evars(currentNode)))

        for instantiation in product(potential_variables, repeat = len(p.arguments)):
            new_assertion = AllOf(frozenset( failed_instantiations
                                           + [ Matches(assertion.variable,  App(p.symbol, *instantiation)) ]
                                           + [ Matches(inst, arg) for (inst, arg) in zip(instantiation, p.arguments) ]
                                           ))
            new_closures = complete_closures_for_signature( add_to_closure(new_assertion, new_closure, [], K)
                                                          , free_evars(new_closure).union(frozenset(instantiation))
                                                          , K
                                                          , signature
                                                          , partial_game
                                                          )
            for new_closure in new_closures:
                source_node = PGNode(assertion, currentNode)
                dest_node = PGNode(new_assertion, new_closure)
                partial_game[source_node] = partial_game.get(source_node, frozenset()).union([dest_node])
            next_nodes += new_closures
            # TODO: add game edges
            failed_instantiations += [new_assertion.negate()]

    partial_tableau[currentNode] = frozenset(next_nodes)

    for node in next_nodes:
        build_tableau(node, partial_tableau, partial_game, K, signature)

def build_closures(a: Matches, K: List[EVar], signature: Signature, partial_game: ParityGame) -> List[Closure]:
    closures = add_to_closure(a, frozenset(), [], K)
    C = a.free_evars().union([a.variable])
    return complete_closures_for_signature(closures, C, K, signature, partial_game)

def build_tableaux(assertion : Matches, K: List[EVar], signature: Signature) -> ParityGame:
    def_list : DefList = definition_list(assertion.pattern, def_list = [])
    game : ParityGame = {}
    tableau : Tableau = {}
    closures = build_closures(assertion, K, signature, game)
    if closures:
        game[Root(assertion)] = frozenset([PGNode(assertion, closure) for closure in closures])
    else:
        game[Root(assertion)] = frozenset([Unsat()])
    for closure in closures:
        build_tableau(closure, tableau, game, K, signature)
    return game

def tableau_to_parity_game(tableau: Tableau) -> ParityGame:
    pass

def is_sat(p: Pattern, K: List[EVar], signature: Signature) -> bool:
    tableaux = build_tableaux(Matches(K[0], p), K, signature)
    for tableau in tableaux:
        print(tableau)
        return True
    return False
#def is_sat(p: Pattern) -> bool:
#    assertion = Matches(fresh_evar.__next__(), p)
#    for tableau in build_tableaux(assertion):
#        pg = tableau_to_parity_game(tableau)
#        if run_pgsolver(pg):
#            return True
#    return False
#
