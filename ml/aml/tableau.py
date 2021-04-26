from __future__ import annotations

from dataclasses import dataclass
from itertools import chain, combinations
from typing import Dict, FrozenSet, Iterable, Iterator, List, Tuple, TypeVar

from aml import *

T = TypeVar('T')
def powerset(s: List[T]) -> Iterator[Iterable[T]]:
    return chain.from_iterable(combinations(s, r) for r in range(len(s)+1))

def definition_list(p: Pattern, def_list: List[Pattern]) -> List[Pattern]:
    if isinstance(p, (SVar, EVar, Symbol)):
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
        raise NotImplementedError

@dataclass(frozen=True)
class TracedPattern:
    pattern: Pattern

    "A list of definition constant indices"
    regenerated: Tuple[int, ...] = ()
    trace_prefix: Tuple[int, ...] = ()

    def left(self) -> TracedPattern:
        assert isinstance(self.pattern, (App, DApp, Or, And))
        return TracedPattern(self.pattern.left, self.regenerated, self.trace_prefix + (0,))

    def right(self) -> TracedPattern:
        assert isinstance(self.pattern, (App, DApp, Or, And))
        return TracedPattern(self.pattern.right, self.regenerated, self.trace_prefix + (1,))

def is_inconsistant(gamma: FrozenSet[TracedPattern]) -> bool:
    atoms         = frozenset([p.pattern            for p in gamma if isinstance(p.pattern, (Symbol, EVar, SVar))])
    negated_atoms = frozenset([p.pattern.subpattern for p in gamma if isinstance(p.pattern, Not)])
    return bool(negated_atoms.intersection(atoms))

def is_sat(p: Pattern) -> bool:
    return is_satisfiable(frozenset([TracedPattern(p)]), frozenset(), definition_list(p, []), {})

def is_prefix(prefix: Tuple[int, ...], t: Tuple[int, ...]) -> bool:
    return prefix == t[0:len(prefix)]

def all_traces_are_nu_traces( prevs: FrozenSet[TracedPattern]
                            , currs: FrozenSet[TracedPattern]
                            , def_list: List[Pattern]
                            ) -> bool:
    for prev in prevs:
        for curr in currs:
            if not is_prefix(prev.trace_prefix, curr.trace_prefix): continue

            assert len(curr.regenerated)  >= len(prev.regenerated)
            regenerated = curr.regenerated[len(prev.regenerated):]
            if not regenerated: continue

            oldest_regenerated = min(regenerated)
            if isinstance(def_list[oldest_regenerated], Mu): return False
    return True

def is_satisfiable( gamma: FrozenSet[TracedPattern]
                  , processed: FrozenSet[TracedPattern]
                  , def_list: List[Pattern]
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
            gamma = gamma.union([tp.left(), tp.right()])
        elif isinstance(p, SVar) and isinstance(p.name, int): # Definitional Constant
            return is_satisfiable( gamma.union([TracedPattern(def_list[p.name], tp.regenerated)])
                                 , processed
                                 , def_list
                                 , path)
        elif isinstance(p, (Mu, Nu)):
            # TODO: We should handle `Nu X . X`
            fp_index = def_list.index(p)
            return is_satisfiable( gamma.union([TracedPattern( p.subpattern.substitute(p.bound, SVar(fp_index))
                                                             , tp.regenerated + (fp_index,) )
                                               ])
                                 , processed, def_list, path)
        elif isinstance(p, Or):
            return is_satisfiable(gamma.union([tp.left()]),  processed, def_list, path) \
                or is_satisfiable(gamma.union([tp.right()]), processed, def_list, path)
        else:
            raise NotImplementedError(p)

    if is_inconsistant(processed): print(processed); return False

    processed_patterns = frozenset(tp.pattern for tp in processed)
    if processed_patterns in path:
        return all_traces_are_nu_traces(path[processed_patterns], processed, def_list)
    path = { **path, processed_patterns : processed }

    # print(processed)
    apps  = [phi for phi in processed if isinstance(phi.pattern, App)]
    dapps = [phi for phi in processed if isinstance(phi.pattern, DApp)]
    partition_lefts = list(powerset(dapps))

    def partition_is_satisfiable(app: TracedPattern, partition_left: Iterable[TracedPattern]) -> bool:
        assert isinstance(app.pattern, App)
        left_gamma  = frozenset([app.left()]).union(map(lambda p: p.left(), partition_left))
        right_gamma = frozenset([app.right()]).union(map(lambda p: p.right(), set(dapps) - set(partition_left)))
        if not is_satisfiable(left_gamma, frozenset(), def_list, path): return False
        if not is_satisfiable(right_gamma, frozenset(), def_list, path): return False
        return True

    ret = all(any(partition_is_satisfiable(app, partition_left) for partition_left in partition_lefts) for app in apps)
    return ret
