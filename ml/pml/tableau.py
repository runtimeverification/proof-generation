from __future__ import annotations

from abc import abstractmethod
from dataclasses import dataclass
from itertools import chain, count, islice, product
from typing import Any, Dict, FrozenSet, Iterable, Iterator, List, Tuple, TypeVar
from subprocess import check_output
import re

from pml import *

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
            if isinstance(node.assertion.pattern, (Top, And, Forall, DApp, Mu, Nu, SVar, EVar)):
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
    assertion = node.assertion
    if isinstance(assertion, Matches):
        p = assertion.pattern
        if isinstance(p, (Bottom, Top)):
            edges[node] = frozenset([node])
        elif isinstance(p, DApp):
            if all(map(lambda arg: isinstance(arg, EVar), p.arguments)):
                if Matches(assertion.variable, p.negate()) not in node.closure:
                    next_node = PGNode(Matches(assertion.variable, Top()), node.closure)
                    edges[node] = frozenset([next_node])
                    build_parity_game(next_node, def_list, edges)
                else:
                    next_node = PGNode(Matches(assertion.variable, Bottom()), node.closure)
                    edges[node] = frozenset([next_node])
                    build_parity_game(next_node, def_list, edges)
            else:
                raise RuntimeError("XXXUnimplemented: " + str(node))
        elif isinstance(p, App):
            if all(map(lambda arg: isinstance(arg, EVar), p.arguments)):
                edges[node] = frozenset([node])
            else:
                for tuple in product(p.free_variables().union([assertion.variable]), repeat = len(p.arguments)):
                    raise RuntimeError("YYYUnimplemented: " + str(node))
        elif isinstance(p, And):
            left_node = PGNode(Matches(assertion.variable, p.left), node.closure)
            right_node = PGNode(Matches(assertion.variable, p.right), node.closure)
            edges[node] = frozenset([left_node, right_node])
            build_parity_game(left_node,  def_list, edges)
            build_parity_game(right_node, def_list, edges)

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

# fresh_evar = map(lambda i : EVar('$' + str(i)), count())
def build_closures(a: Matches, K: List[EVar], signature: Dict[Symbol, int]) -> List[Closure]:
    closures = add_to_closure(a, frozenset(), K)
    C = a.free_evars().union([a.variable])
    return complete_closure_for_signature(closures, C, K, signature)

def add_app_dapp_to_closure(pairs : List[Tuple[Matches, Matches]] , partialClosure: Closure, K: List[EVar]) -> List[Closure]:
    def is_atomic_application(app : App) -> bool:
        return all(map(lambda arg: isinstance(arg, EVar), app.arguments))

    curr_closures = [partialClosure]
    all_of : List[Assertion] = []
    for (app, dapp) in pairs:
        assert isinstance(app.pattern, App)
        assert isinstance(dapp.pattern, DApp)
        assert app.pattern.symbol == dapp.pattern.symbol

        if is_atomic_application(app.pattern):
            if Matches(app.variable, app.pattern.negate()) == dapp:
                return add_to_closure(Matches(app.variable, Bottom()), partialClosure, K)

            new_closures = []
            for curr_closure in curr_closures:
                any_of : List[Assertion] = []
                for ci, phii in zip(app.pattern.arguments, dapp.pattern.arguments):
                    assert isinstance(ci, EVar)
                    any_of += [Matches(ci, phii)]
                new_closures += add_to_closure(AllOf(frozenset(all_of)), curr_closure, K)
            curr_closures = new_closures
    return curr_closures

def add_to_closure(assertion: Assertion, partialClosure: Closure, K: List[EVar]) -> List[Closure]:
    if isinstance(assertion, Matches):
        p = assertion.pattern
        if   isinstance(p, (Bottom)):
            return []
        elif isinstance(p, (Top)):
            return [partialClosure.union([assertion])]
        elif isinstance(p, EVar):
            if assertion.variable != p:
                return add_to_closure(Matches(assertion.variable, Bottom()), partialClosure.union([assertion]), K)
            return [partialClosure]
        elif isinstance(p, Not):
            assert isinstance(p.subpattern, EVar)
            if Matches(assertion.variable, p.negate()) in partialClosure:
                return add_to_closure(Matches(assertion.variable, Bottom()), partialClosure.union([assertion]), K)
            return [partialClosure]
        elif isinstance(p, DApp):
            apps = [a for a in partialClosure if    isinstance(a, Matches)
                                                and isinstance(a.pattern, App)
                                                and a.pattern.symbol == p.symbol]
            return add_app_dapp_to_closure(list(product(apps, [assertion])), partialClosure.union(frozenset([assertion])), K)
        elif isinstance(p, App):
            dapps = [a for a in partialClosure if   isinstance(a, Matches)
                                                and isinstance(a.pattern, DApp)
                                                and a.pattern.symbol == p.symbol]
            return add_app_dapp_to_closure(list(product([assertion], dapps)), partialClosure.union(frozenset([assertion])), K)
        elif isinstance(p, And):
            ret = []
            partialClosure = partialClosure.union([assertion])
            for closure in add_to_closure(Matches(assertion.variable, p.left),  partialClosure, K):
                ret += add_to_closure(Matches(assertion.variable, p.right), closure, K)
            return ret
        else:
            raise RuntimeError("Unimplemented: ")
    elif isinstance(assertion, AllOf):
        if len(assertion.assertions) == 0:
            return [partialClosure]
        first, *rest = assertion.assertions
        new_closures = add_to_closure(first, partialClosure, K)
        ret = []
        for new_closure in new_closures:
            ret += add_to_closure(AllOf(frozenset(rest)), new_closure, K)
        return ret
    elif isinstance(assertion, AnyOf):
        if len(assertion.assertions) == 0:
            return []
        ret = []
        for a in assertion.assertions:
            ret += add_to_closure(a, partialClosure, K)
        return ret
    else:
        raise RuntimeError("Unimplemented: ")

def complete_closure_for_signature(closures: List[Closure], C: FrozenSet[EVar], K: List[EVar], signature: Dict[Symbol, int]) -> List[Closure]:
    # TODO: This should be replaced by some form of resulution
    for (symbol, arity) in signature.items():
        for tuple in product(C, repeat = arity + 1):
            new_closures = []
            for closure in closures:
                first, *rest = tuple
                x = add_to_closure(Matches(first, App(symbol, *rest)),          closure, K)
                y = add_to_closure(Matches(first, App(symbol, *rest).negate()), closure, K)
                new_closures += x
                new_closures += y
            closures = new_closures
    return closures

Tableau = Dict[Closure, FrozenSet[Closure]]

def diff(l1: List[EVar] , l2_set: FrozenSet[EVar]) -> List[EVar]:
    # Preserves order
    return [item for item in l1 if item not in l2_set]

def take(n: int, l: List[EVar]) -> List[EVar]:
  return list(islice(l, n))

def build_tableau(currentNode: Closure, partialTableau: Tableau, K: List[EVar], signature: Dict[Symbol, int]) -> Tableau:
    if currentNode in partialTableau.keys(): return partialTableau
    next_nodes : List[Closure] = []
    for assertion in currentNode:
        if not isinstance(assertion, Matches):
            continue
        p = assertion.pattern
        if not isinstance(p, App):
            continue
        if all(map(lambda arg: isinstance(arg, EVar), p.arguments)):
            continue

        new_closure = frozenset({ a for a in currentNode if p.free_evars() <= p.free_evars().union({assertion.variable}) })

        failed_instantiations : List[Assertion] = []
        potential_variables = list(assertion.free_evars()) + take(len(p.arguments), diff(K, free_evars(currentNode)))

        for instantiation in product(potential_variables, repeat = len(p.arguments)):
            new_assertion = AllOf(frozenset( failed_instantiations
                                           + [ Matches(assertion.variable,  App(p.symbol, *instantiation)) ]
                                           + [ Matches(inst, arg) for (inst, arg) in zip(instantiation, p.arguments) ]
                                           ))
            new_closures = add_to_closure(new_assertion, new_closure, K)
            new_closures = complete_closure_for_signature(new_closures, free_evars(new_closure).union(frozenset(instantiation)), K, signature)
            next_nodes += new_closures
            failed_instantiations += [new_assertion.negate()]

    partialTableau[currentNode] = frozenset(next_nodes)

    for node in next_nodes:
        build_tableau(node, partialTableau, K, signature)
    return partialTableau

def build_tableaux(assertion : Matches, K: List[EVar], signature: Dict[Symbol, int]) -> List[Tableau]:
    def_list : DefList = definition_list(assertion.pattern, def_list = [])
    ret : List[Tableau] = []
    for closure in build_closures(assertion, K, signature):
        root = closure
        ret += [build_tableau(root, {}, K, signature)]
    return ret

def tableau_to_parity_game(tableau: Tableau) -> ParityGame:
    pass

def is_sat(p: Pattern) -> bool:
    return False
#def is_sat(p: Pattern) -> bool:
#    assertion = Matches(fresh_evar.__next__(), p)
#    for tableau in build_tableaux(assertion):
#        pg = tableau_to_parity_game(tableau)
#        if run_pgsolver(pg):
#            return True
#    return False
#
