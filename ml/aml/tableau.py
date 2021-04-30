from __future__ import annotations

from aml import *
from dataclasses import dataclass
from itertools import chain, combinations, count, product

from typing import Dict, FrozenSet, Iterable, Iterator, List, Optional, Tuple, TypeVar, Union

T = TypeVar('T')
def powerset(s: List[T]) -> Iterator[Iterable[T]]:
    return chain.from_iterable(combinations(s, r) for r in range(len(s)+1))

def definition_list(p: Pattern, existing_list: List[Pattern]) -> List[Pattern]:
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
    pattern: Pattern

    "A list of definition constant indices"
    regenerated: Tuple[int, ...] = ()
    trace_prefix: Tuple[int, ...] = ()

    def left(self) -> TracedPattern:
        assert(isinstance(self.pattern, (App, DApp, Or, And)))
        return TracedPattern(self.pattern.left, self.regenerated, self.trace_prefix + (0,))

    def right(self) -> TracedPattern:
        assert(isinstance(self.pattern, (App, DApp, Or, And)))
        return TracedPattern(self.pattern.right, self.regenerated, self.trace_prefix + (1,))

def is_inconsistant(gamma: FrozenSet[TracedPattern]) -> bool:
    atoms         : FrozenSet[Pattern] = frozenset([phi.pattern             for phi in gamma if isinstance(phi.pattern, (Symbol, EVar, SVar))])
    negated_atoms : FrozenSet[Pattern] = frozenset([phi.pattern.subpattern  for phi in gamma if isinstance(phi.pattern, Not)])
    return bool(negated_atoms.intersection(atoms))

def is_sat(p: Pattern) -> bool:
    return is_satisfiable(frozenset([TracedPattern(p)]), frozenset(), definition_list(p, []), {})

def is_prefix(prefix: Tuple[int, ...], t: Tuple[int, ...]) -> bool:
    return prefix == t[0:len(prefix)]

def all_traces_are_nu_traces( prevs: FrozenSet[TracedPattern]
                            , currs: FrozenSet[TracedPattern]
                            , definition_list: List[Pattern]
                            ) -> bool:
    for prev in prevs:
        for curr in currs:
            if not is_prefix(prev.trace_prefix, curr.trace_prefix): continue

            assert len(curr.regenerated)  >= len(prev.regenerated)
            regenerated = curr.regenerated[len(prev.regenerated):]
            if not regenerated: continue

            oldest_regenerated = min(regenerated)
            if isinstance(definition_list[oldest_regenerated], Mu): return False
    return True

def is_satisfiable( gamma: FrozenSet[TracedPattern]
                  , processed: FrozenSet[TracedPattern]
                  , definition_list: List[Pattern]
                  , path: Dict[FrozenSet[Pattern], FrozenSet[TracedPattern]]
                  ) -> bool:

    while gamma:
        # tp, *gamma = gamma, but for sets
        gamma_iter = iter(gamma)
        tp = next(gamma_iter)
        gamma = frozenset(gamma_iter)
        p = tp.pattern

        if   isinstance(p, (Symbol, App, DApp)):
            processed = processed.union(set([tp]))
        elif isinstance(p, Not) and isinstance(p.subpattern, (Symbol)):
            processed = processed.union(set([tp]))
        elif isinstance(p, And):
            gamma = gamma.union(set([tp.left(), tp.right()]))
        elif isinstance(p, SVar) and isinstance(p.name, int): # Definitional Constant
            return is_satisfiable(gamma.union(set([TracedPattern(definition_list[p.name], tp.regenerated)])), processed, definition_list, path)
        elif isinstance(p, Nu) or isinstance(p, Mu):
            # TODO: We should handle `Nu X . X`
            return is_satisfiable( gamma.union(set([TracedPattern( p.subpattern.substitute(p.bound, SVar(definition_list.index(p)))
                                                                 , tp.regenerated + (definition_list.index(p),) )
                                                   ]))
                                 , processed, definition_list, path)
        elif isinstance(p, Or):
            return is_satisfiable(gamma.union(set([tp.left()])),  processed, definition_list, path) \
                or is_satisfiable(gamma.union(set([tp.right()])), processed, definition_list, path)
        else:
            raise NotImplementedError(p)

    if is_inconsistant(processed): print(processed); return False

    processed_patterns = frozenset(tp.pattern for tp in processed)
    if processed_patterns in path:
        return all_traces_are_nu_traces(path[processed_patterns], processed, definition_list)
    path = { **path, processed_patterns : processed }

    # print(processed)
    apps  = [phi for phi in processed if isinstance(phi.pattern, App)]
    dapps = [phi for phi in processed if isinstance(phi.pattern, DApp)]
    partition_lefts = list(powerset(dapps))

    def partition_is_satisfiable(app: TracedPattern, partition_left: Iterable[TracedPattern]) -> bool:
        assert(isinstance(app.pattern, App))
        left_gamma  = frozenset([app.left()]).union(frozenset(map(lambda p: p.left(), partition_left)))
        right_gamma = frozenset([app.right()]).union(frozenset(map(lambda p: p.right(), set(dapps) - set(partition_left))))
        if not is_satisfiable(left_gamma, frozenset(), definition_list, path): return False
        if not is_satisfiable(right_gamma, frozenset(), definition_list, path): return False
        return True

    ret = all(any(partition_is_satisfiable(app, partition_left) for partition_left in partition_lefts) for app in apps)
    return ret
