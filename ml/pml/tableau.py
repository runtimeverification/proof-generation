from __future__ import annotations

from abc import abstractmethod
from dataclasses import dataclass
from functools import reduce
from itertools import chain, count, islice, product
from typing import Any, Callable, Container, Dict, FrozenSet, Iterable, Iterator, List, Tuple, Union, cast
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
    elif isinstance(p, Mu):
        if p not in def_list:
            def_list = def_list + [p]
            def_list = definition_list(p.subpattern.substitute(p.bound, SVar(def_list.index(p)).to_positive_normal_form()), def_list)
        return def_list
    elif isinstance(p, Nu):
        return definition_list(p.negate(), def_list)
    else:
        raise RuntimeError("Unsupported pattern: " + str(p))

def unfold(p: Union[Mu, Nu], def_list: DefList) -> Pattern:
    if isinstance(p, Mu):
        return p.subpattern.substitute(p.bound, SVar(def_list.index(p)))
    else:
        return p.subpattern.substitute(p.bound, Not(SVar(def_list.index(p.negate()))))

class Assertion:
    @abstractmethod
    def negate(self) -> 'Assertion':
        raise NotImplementedError

    @abstractmethod
    def free_evars(self) -> FrozenSet[EVar]:
        raise NotImplementedError

    @abstractmethod
    def substitute(self, x: Var, v: Pattern) -> Assertion:
        raise NotImplementedError

    def substitute_multi(self, xs: Iterable[EVar] , vs: Iterable[Pattern]) -> Assertion:
        # TODO: We do not do simultanious substitutions
        ret = self
        for (x, v) in zip(xs, vs):
            ret = ret.substitute(x, v)
        return ret

    @abstractmethod
    def to_latex(self) -> str:
        raise NotImplementedError

    @abstractmethod
    def to_utf(self) -> str:
        raise NotImplementedError

@dataclass(frozen=True)
class Matches(Assertion):
    variable: EVar
    pattern:  Pattern

    def negate(self) -> Matches:
        return Matches(self.variable, self.pattern.negate())

    def free_evars(self) -> FrozenSet[EVar]:
        return self.pattern.free_evars().union([self.variable])

    def substitute(self, x: Var, v: Pattern) -> Matches:
        assert isinstance(self.variable.substitute(x, v), EVar)
        return Matches(cast(EVar, self.variable.substitute(x, v)), self.pattern.substitute(x, v))

    def to_latex(self) -> str:
        return self.variable.to_latex() + ' \\vDash ' + self.pattern.to_latex()

    def to_utf(self) -> str:
        return self.variable.to_utf() + ' |= ' + self.pattern.to_utf()

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

    def substitute(self, x: Var, v: Pattern) -> AllOf:
        return AllOf(frozenset([a.substitute(x, v) for a in self.assertions]))

    def to_latex(self) -> str:
        return ' \\bigwedge '.join(map(lambda a: a.to_latex(), self.assertions))

    def to_utf(self) -> str:
        return ' and '.join(map(lambda a: a.to_utf(), self.assertions))

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

    def substitute(self, x: Var, v: Pattern) -> AnyOf:
        return AnyOf(frozenset([a.substitute(x, v) for a in self.assertions]))

    def to_latex(self) -> str:
        return ' \\bigvee '.join(map(lambda a: a.to_latex(), self.assertions))

    def to_utf(self) -> str:
        return ' or '.join(map(lambda a: a.to_utf(), self.assertions))

@dataclass(frozen=True)
class ExistsAssertion(Assertion):
    bound: frozenset[EVar]
    subassertion: Assertion

    def negate(self) -> 'ForallAssertion':
        return ForallAssertion(self.bound, self.subassertion.negate())

    def free_evars(self) -> FrozenSet[EVar]:
        return self.subassertion.free_evars() - self.bound

    def substitute(self, x: Var, v: Pattern) -> ExistsAssertion:
        if x in self.bound: return self
        else:               return ExistsAssertion(self.bound, self.subassertion.substitute(x, v))

    def to_latex(self) -> str:
        return '\\exists ' + ','.join(map(lambda p: p.to_latex(), self.bound)) + \
                    ' \\ldotp ' + self.subassertion.to_latex()

    def to_utf(self) -> str:
        return '∃ ' + ','.join(map(lambda p: p.to_utf(), self.bound)) + \
                    ' . (' + self.subassertion.to_utf() + ')'

@dataclass(frozen=True)
class ForallAssertion(Assertion):
    bound: frozenset[EVar]
    subassertion: Assertion

    def negate(self) -> ExistsAssertion:
        return ExistsAssertion(self.bound, self.subassertion.negate())

    def free_evars(self) -> FrozenSet[EVar]:
        return self.subassertion.free_evars() - self.bound

    def substitute(self, x: Var, v: Pattern) -> ForallAssertion:
        if x in self.bound: return self
        else:               return ForallAssertion(self.bound, self.subassertion.substitute(x, v))

    def to_latex(self) -> str:
        return '\\forall ' + ','.join(map(lambda p: p.to_latex(), self.bound)) + \
                    ' \\ldotp ' + self.subassertion.to_latex()

    def to_utf(self) -> str:
        return '∀ ' + ','.join(map(lambda p: p.to_utf(), self.bound)) + \
                    ' . ' + self.subassertion.to_utf()

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
class Unsat():
    pass

def instantiations( length: int
                  , curr_assertion: FrozenSet[EVar]
                  ,  curr_closures: FrozenSet[EVar]
                  ,      available: List[EVar]
                  ) -> Iterable[Tuple[EVar,...]]:
    available = diff(available, curr_closures)
    curr      = sorted(list(curr_assertion))
    return list(instantiations_lists(length, curr, available))

def instantiations_lists(length: int, curr: List[EVar], avail: List[EVar]) -> Iterable[Tuple[EVar,...]]:
    if length == 0:
        yield ()
        return
    if length == 1:
        for item in curr:
            yield (item,)
        yield (avail[0],)
        return

    for curr_item in curr:
        for tuple in instantiations_lists(length - 1, curr, avail):
            yield (curr_item, *tuple)
    for tuple in instantiations_lists(length - 1, curr + [avail[0]], avail[1:]):
        yield (avail[0], *tuple)
    return



PGNodeGeneralized = Union[PGNode, Unsat]

ParityGame = Dict[PGNodeGeneralized, FrozenSet[PGNodeGeneralized]]
SerializedParityGameEntry = Tuple[int, int, int, List[int], str]
SerializedParityGame = List[SerializedParityGameEntry]

Tableau = Dict[Closure, FrozenSet[Closure]]

def serialize_parity_game(root: PGNodeGeneralized, edges: ParityGame, def_list: DefList) -> SerializedParityGame:
    ret = []
    keys = dict(zip(edges.keys(), range(0, len(edges))))

    def ident(node: PGNodeGeneralized) -> int:
        if isinstance(node, Unsat):
            return 1
        if node in keys:
            return 2 + keys[node]
        print(hash(node), label(node))
        return hash(node)
        raise RuntimeError("Trace terminates at node: " + str(node))

    def priority(node: PGNodeGeneralized, def_list: DefList) -> int:
        # If the lowest priority infinitly recurring node has even priority, player 0  wins (pattern is sat).
        # Otherwise player 1 wins (pattern is unsat).

        if isinstance(node, Unsat):
            return 1
        if isinstance(node.assertion, Matches):
            p = node.assertion.pattern
            if isinstance(p, Top):
                return 0 # Tops only child is Top, so this can be any even value`
            if isinstance(p, (Bottom, EVar)) \
               or (isinstance(p, Not) and isinstance(p.subpattern, EVar)):
                return 0 # Cannot repeat infinitly on any trace, so value doesn't matter.
            if isinstance(p, (And, Or, SVar)) \
               or (isinstance(p, Not) and isinstance(p.subpattern, SVar)):
                return 2 * len(def_list) + 2 # Not relevant; some other node will have lower or equal priority
            if isinstance(p, Nu):
                return 2 * def_list.index(p.negate())
            if isinstance(p, Mu):
                return 2 * def_list.index(p) + 1
            if isinstance(p,  App) and is_atomic_application(p) or \
               isinstance(p, DApp) and is_atomic_application(p.negate()):
                # These are equivalent to Top()
                return 0
            if isinstance(p, (Exists, App)):
                return 2 * len(def_list) + 1
            if     isinstance(p, (Forall, DApp)):
                return 2 * len(def_list) + 2
            raise RuntimeError("Unimplemented: " + str(p))
        if isinstance(node.assertion, ExistsAssertion):
            return 2 * len(def_list) + 1
        if isinstance(node.assertion, ForallAssertion):
            return 2 * len(def_list) + 2
        if isinstance(node.assertion, (AllOf, AnyOf)):
            return 2 * len(def_list) + 2 # Not relevant; some other node will have lower or equal priority
        else:
            raise RuntimeError("Unimplemented: " + str(node.assertion))

    def pgsolver_priority(node: PGNodeGeneralized, def_list: DefList) -> int:
        # While in our paper, we define the lowest priority infinitly recurring node
        # to be the deciding priority, PGSolver considers the highest priority infinitly recurring node.

        # Must be greater than max possible priority and an even number.
        max_priority = 2 * len(def_list) + 2
        return max_priority - priority(node, def_list)

    def player(node: PGNodeGeneralized) -> int:
        # If a node has player N, then that player can make a move
        if isinstance(node, (Unsat)):
            # There is no choice to be made here, so it does not matter whose turn it is.
            return 0
        if isinstance(node.assertion, Matches):
            if isinstance(node.assertion.pattern, (Top, Bottom, Mu, Nu, SVar, EVar)) or \
               (isinstance(node.assertion.pattern, Not) and isinstance(node.assertion.pattern.subpattern, SVar)) or \
               (isinstance(node.assertion.pattern, Not) and isinstance(node.assertion.pattern.subpattern, EVar)):
                # There is no choice to be made here, so it does not matter whose turn it is.
                return 0
            if isinstance(node.assertion.pattern, (And, Forall, DApp)):
                return 1
            if isinstance(node.assertion.pattern, (Or,  Exists, App)):
                return 0
            raise RuntimeError("Unimplemented: " + str(node.assertion.pattern))
        if isinstance(node.assertion, (AllOf, ForallAssertion)):
            return 1
        if isinstance(node.assertion, (AnyOf, ExistsAssertion)):
            return 0
        raise RuntimeError("Unimplemented: " + str(node))

    def label(node: PGNodeGeneralized) -> str:
        if isinstance(node, Unsat):
            return "Unsat"
        else:
            free = [v.name for v in free_evars(node.closure)]
            apps  = [a.to_utf() for a in node.closure if isinstance(a, Matches) and isinstance(a.pattern, App) and is_atomic_application(a.pattern)]
            dapps = [a.to_utf() for a in node.closure if isinstance(a, Matches) and isinstance(a.pattern, DApp) and is_atomic_application(a.pattern.negate())]
            return node.assertion.to_utf() + '\\nfree: ' + ','.join(free) + ';\\nApps: ' +  ','.join(apps) + ';\\nDApps: ' +  ','.join(dapps)

    ret = [(0, 0, 0, [ident(root)], "root")] # Bug in PGSolver requires root == 0
    for source, destinations in edges.items():
        ret += [(ident(source),
                 pgsolver_priority(source, def_list),
                 player(source),
                 sorted(list(map(ident, destinations))),
                 label(source)
                )]
    return ret

def run_pgsolver(game: SerializedParityGame) -> bool:
    def entry_to_string(entry : SerializedParityGameEntry) -> str:
        source, priority, player, dests, label = entry
        assert len(dests) > 0
        return " ".join([str(source), str(priority), str(player), ",".join(map(str, dests)), '"' + label.replace('"', "'") + '"' ])
    input = "; \n".join(map(entry_to_string, game)) + ';'
    from subprocess import check_output, CalledProcessError, PIPE
    try:
        output = check_output(['pgsolver', '-local',  'stratimprloc2', '0'], input=input, text=True, stderr=PIPE)
    except CalledProcessError as e:
        print('PGSolver failed')
        print(input)
        print(e.stderr)
        raise

    match = re.search(r'Winner of initial node is player (\d)\n', output)
    if match is None:
        raise RuntimeError("PGGame not well formed?\n" + output)

    with open('/tmp/in.pg', 'w') as pg_file:
        pg_file.write(input)
    with open('/tmp/out.pg', 'w') as pg_file:
        pg_file.write(check_output(['pgsolver', '-global',  'recursive', '-pg'], input=input, text=True))

    return match.group(1) == '0'

PartialEdges = List[Tuple[Assertion, Assertion]]

def is_atomic_application(app : App) -> bool:
    return all(map(lambda arg: isinstance(arg, EVar), app.arguments))

def add_to_closures( assertion: Assertion
                   , closures: List[Tuple[Closure, PartialEdges]]
                   , C: FrozenSet[EVar]
                   , K: List[EVar]
                   , def_list: DefList
                   ) -> List[Tuple[Closure, PartialEdges]]:
    return  list(flat_map( lambda cl_pe: add_to_closure(assertion, *cl_pe, C, K, def_list)
                         , closures
                )        )

def add_to_closure( assertion: Assertion
                  , partial_closure: Closure
                  , partial_edges: PartialEdges
                  , C: FrozenSet[EVar]
                  , K: List[EVar]
                  , def_list: DefList
                  ) -> List[Tuple[Closure, PartialEdges]]:
    next : Assertion

    if assertion in partial_closure:
        return [(partial_closure, partial_edges)]

    if isinstance(assertion, Matches):
        p = assertion.pattern
        if   isinstance(p, (Bottom)):
            return []
        elif isinstance(p, (Top)):
            return [( partial_closure
                    , partial_edges + [(assertion, assertion)]
                    )]
        elif isinstance(p, EVar):
            if assertion.variable != p:
                return add_to_closure( Matches(assertion.variable, Bottom())
                                     , partial_closure
                                     , partial_edges + [(assertion, Matches(assertion.variable, Bottom()))]
                                     , C, K
                                     , def_list)
            return [( partial_closure.union([assertion])
                    , partial_edges + [(assertion, assertion)]
                    )]
        elif isinstance(p, Not) and isinstance(p.subpattern, EVar):
            if Matches(assertion.variable, p.negate()) in partial_closure:
                return add_to_closure( Matches(assertion.variable, Bottom())
                                     , partial_closure
                                     , partial_edges + [(assertion, Matches(assertion.variable, Bottom()))]
                                     , C, K
                                     , def_list)
            return [(partial_closure, partial_edges)]
        elif isinstance(p, App):
            if (is_atomic_application(p)):
                partial_closure = partial_closure.union([assertion])
                if assertion.negate() in partial_closure:
                    next = Matches(assertion.variable, Bottom())
                    return add_to_closure( next
                                         , partial_closure, partial_edges + [(assertion,next), (assertion.negate(), next)]
                                         , C, K , def_list)
                partial_edges = partial_edges + [(assertion, assertion)]
                return [(partial_closure, partial_edges)]

            bound_vars = list(take(len(p.arguments), diff(K, C)))
            next = ExistsAssertion(frozenset(bound_vars)
                                  , AllOf(frozenset( [ Matches( assertion.variable, App(p.symbol, *bound_vars)) ]
                                                   + [ Matches(bound, arg) for (bound, arg) in zip(bound_vars, p.arguments) ]
                                  )      )         )
            return add_to_closure( next
                                 , partial_closure
                                 , partial_edges + [(assertion, next)]
                                 , C, K
                                 , def_list
                                 )
        elif isinstance(p, DApp):
            if (is_atomic_application(p.negate())):
                partial_closure = partial_closure.union([assertion])
                if assertion.negate() in partial_closure:
                    next = Matches(assertion.variable, Bottom())
                    return add_to_closure( next
                                         , partial_closure, partial_edges + [(assertion,next), (assertion.negate(), next)]
                                         , C, K , def_list)
                partial_edges = partial_edges + [(assertion, assertion)]
                return [(partial_closure, partial_edges)]

            bound_vars = list(take(len(p.arguments), diff(K, C)))
            next  = ForallAssertion( frozenset(bound_vars)
                                   , AnyOf(frozenset( [ Matches( assertion.variable, App(p.symbol, *bound_vars).negate()) ]
                                                    + [ Matches(bound, arg) for (bound, arg) in zip(bound_vars, p.arguments) ]
                                   )      )         )
            return add_to_closure( next
                                 , partial_closure.union([assertion])
                                 , partial_edges + [(assertion, next)]
                                 , C, K
                                 , def_list
                                 )
        elif isinstance(p, And):
            next = AllOf(frozenset([ Matches(assertion.variable, p.left), Matches(assertion.variable, p.right) ]))
            return add_to_closure( next
                                 , partial_closure
                                 , partial_edges + [(assertion, next)]
                                 , C, K
                                 , def_list
                                 )
        elif isinstance(p, Or):
            next = AnyOf(frozenset([ Matches(assertion.variable, p.left), Matches(assertion.variable, p.right)]))
            return add_to_closure( next
                                 , partial_closure
                                 , partial_edges + [(assertion, next)]
                                 , C, K
                                 , def_list
                                 )
        elif isinstance(p, (Nu, Mu)):
            next = Matches(assertion.variable, unfold(p, def_list))
            if (assertion, next) in partial_edges:
                return [(partial_closure, partial_edges)]
            return add_to_closure( next
                                 , partial_closure
                                 , partial_edges + [(assertion, next)]
                                 , C, K
                                 , def_list
                                 )
        elif isinstance(p, SVar) and isinstance(p.name, int): # Only consider bound `SVar`s.
            next = Matches(assertion.variable, def_list[p.name])
            return add_to_closure( next
                                 , partial_closure
                                 , partial_edges + [(assertion, next)]
                                 , C, K
                                 , def_list
                                 )
        elif isinstance(p, Not) and isinstance(p.subpattern, SVar) and isinstance(p.subpattern.name, int): # Only consider bound `SVar`s.
            next = Matches(assertion.variable, def_list[p.subpattern.name].negate())
            return add_to_closure( next
                                 , partial_closure
                                 , partial_edges + [(assertion, next)]
                                 , C, K
                                 , def_list
                                 )
        else:
            raise RuntimeError("Unimplemented: " + str(assertion))
    elif isinstance(assertion, AllOf):
        curr_closures = [(partial_closure, partial_edges)]
        for a in assertion.assertions:
            new_closures = []
            for (closure, edges) in curr_closures:
                new_closures += add_to_closure( a
                                              , closure
                                              , edges + [(assertion, a)]
                                              , C, K
                                              , def_list
                                              )
            curr_closures = new_closures
        return curr_closures
    elif isinstance(assertion, AnyOf):
        ret = []
        for a in assertion.assertions:
            ret += add_to_closure(a, partial_closure, partial_edges + [(assertion, a)], C, K, def_list)
        return ret
    elif isinstance(assertion, ExistsAssertion):
        return [( partial_closure.union([assertion])
                , partial_edges + [(assertion, assertion)]
                )]
    elif isinstance(assertion, ForallAssertion):
        curr_closures = [(partial_closure.union([assertion]), partial_edges)]
        bound = list(assertion.bound)
        for instantiation in product(C, repeat = len(assertion.bound)):
            new_closures = []
            for (closure, edges) in curr_closures:
                next = assertion.subassertion.substitute_multi(bound, instantiation)
                new_closures += add_to_closure( next
                                              , closure
                                              , edges + [(assertion, next)]
                                              , C, K, def_list)
            curr_closures = new_closures
        return curr_closures
    else:
        raise RuntimeError("Unimplemented: " + str(assertion))

def complete_closures_for_signature( closures: List[Tuple[Closure, PartialEdges]]
                                   , C: FrozenSet[EVar]
                                   , K: List[EVar]
                                   , signature: Signature
                                   , def_list : DefList
                                   ) -> List[Tuple[Closure, PartialEdges]]:
    # TODO: This should be replaced by some form of resulution
    for (symbol, arity) in signature.items():
        for tuple in product(C, repeat = arity + 1):
            new_closures = []
            for (partial_closure, partial_edges) in closures:
                first, *rest = tuple
                new_edges : PartialEdges = []
                x = add_to_closure(Matches(first, App(symbol, *rest)),          partial_closure, partial_edges, C, K, def_list)
                y = add_to_closure(Matches(first, App(symbol, *rest).negate()), partial_closure, partial_edges, C, K, def_list)
                new_closures += x
                new_closures += y
            closures = new_closures
    return closures

def instantiate_universals( closures: List[Tuple[Closure, PartialEdges]]
                          , C: FrozenSet[EVar]
                          , K: List[EVar]
                          , def_list: DefList
                          ) -> List[Tuple[Closure, PartialEdges]]:
    ret = []
    for (closure, partial_edges) in closures:
        curr_closures = [(closure, partial_edges)]
        for universal in closure:
            if not isinstance(universal, ForallAssertion):
                continue
            curr_closures = add_to_closures(universal, curr_closures, C, K, def_list)
        ret += curr_closures
    return ret

def build_games( closures: List[Tuple[Closure, PartialEdges]]
               , parity_game: ParityGame
               ) -> List[Tuple[Closure, ParityGame]]:
    ret : List[Tuple[Closure, ParityGame]] = []
    for (closure, partial_edges) in closures:
        game = parity_game.copy()
        for (source, dest) in partial_edges:
            source_node = PGNode(source, closure)
            game[source_node] = game.get(source_node, frozenset()).union([PGNode(dest, closure)])
        ret += [(closure, game)]
    return ret

def build_tableaux( curr_closure: Closure
                  , partial_tableau: Tableau
                  , partial_game : ParityGame
                  , K: List[EVar]
                  , signature: Signature
                  , def_list : DefList
                  ) -> Iterator[ParityGame]:
    if curr_closure in partial_tableau.keys():
        yield partial_game
        return

    # We pick an existential assertion in the closure,
    # and expand the closure to allow instantiating it.
    existential = next((a for a in curr_closure if isinstance(a, ExistsAssertion)), None)
    if not existential:
        yield partial_game
        return

    bound = list(existential.bound)

    prev_instantiations_negated : FrozenSet[Assertion] = frozenset()
    for instantiation in instantiations(len(bound), existential.free_evars(), free_evars(curr_closure), K):
        new_assertion = existential.subassertion.substitute_multi(list(bound), instantiation)
        build_new_node = not new_assertion.free_evars() <= free_evars(curr_closure) # Partial order, not equivalent to >
        new_closure: Closure
        if build_new_node:
            C = new_assertion.free_evars()
            new_closure = frozenset([assertion for assertion in curr_closure
                                               if     assertion.free_evars() <= C
                                                  and (    isinstance(assertion, ForallAssertion)
                                                        or ( isinstance(assertion, ExistsAssertion) and not assertion == existential)
                                                        or (     isinstance(assertion, Matches)
                                                             and ( (isinstance(assertion.pattern, App)  and is_atomic_application(assertion.pattern))
                                                               or (isinstance(assertion.pattern, DApp) and is_atomic_application(assertion.pattern.negate()))
                                                                )
                                                           )
                                                      )
                                    ])
        else:
            C = free_evars(curr_closure)
            new_closure = curr_closure

        new_closures = add_to_closure(new_assertion, new_closure, [], C, K, def_list)
        new_closures = add_to_closures(AllOf(prev_instantiations_negated), new_closures, C, K, def_list)
        prev_instantiations_negated = prev_instantiations_negated.union([new_assertion.negate()])
        new_closures = instantiate_universals(new_closures, C, K, def_list)
        new_closures = complete_closures_for_signature( new_closures
                                                      , C
                                                      , K
                                                      , signature
                                                      , def_list
                                                      )

        for (new_closure, new_game) in build_games(new_closures, partial_game):
            if build_new_node:
                for common in curr_closure.intersection(new_closure):
                    if isinstance(common, ExistsAssertion):
                        continue
                    new_game[PGNode(common, curr_closure)] = new_game.get(PGNode(common, curr_closure), frozenset()).union([PGNode(common, new_closure)])

            dest_node = PGNode(new_assertion, new_closure)
            source_node = PGNode(existential, curr_closure)
            new_game[source_node] = new_game.get(source_node, frozenset()).union([dest_node])

            new_tableau = partial_tableau.copy()
            new_tableau[curr_closure] = frozenset([new_closure])
            yield from build_tableaux(new_closure, new_tableau, new_game, K, signature, def_list)
    return

def is_sat(pattern: Pattern, K: List[EVar], signature: Signature) -> bool:
    print('---- is_sat')
    pattern = pattern.to_positive_normal_form()
    def_list : DefList = definition_list(pattern, def_list = [])
    assertion = ExistsAssertion(frozenset({K[0]}), Matches(K[0], pattern))
    root = frozenset({assertion})
    root_pgnode = PGNode(assertion, root)
    games = build_tableaux(root, {}, {}, K, signature, def_list)
    for game in games:
        game[Unsat()] = frozenset({Unsat()})
        serialized = serialize_parity_game(root_pgnode, game, def_list)
        if run_pgsolver(serialized):
            return True
    return False

