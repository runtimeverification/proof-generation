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

def is_inconsistant(gamma: list[Pattern]) -> bool:
    negated_atoms : set[Pattern] = set([phi.negate() for phi in gamma if isinstance(phi, (Symbol, EVar, SVar))])
    return bool(negated_atoms.intersection(set(gamma)))

def is_sat(p: Pattern) -> bool:
    return is_satisfiable(frozenset([p]), frozenset(), definition_list(p, []), frozenset())

def is_satisfiable(gamma: frozenset[Pattern], processed: frozenset[Pattern], definition_list: list[Pattern], path: frozenset[frozenset[Pattern]]) -> bool:
    while gamma:
        # p, *gamma = gamma, but for sets
        gamma_iter = iter(gamma)
        p = next(gamma_iter)
        gamma = frozenset(gamma_iter)

        if   isinstance(p, (Symbol, App, DApp)):
            processed = processed.union(set([p]))
        elif isinstance(p, Not) and isinstance(p.subpattern, (Symbol)):
            processed = processed.union(set([p]))
        elif isinstance(p, And):
            gamma = gamma.union(set([p.left, p.right]))
        elif isinstance(p, SVar) and isinstance(p.name, int): # Definitional Constant
            return is_satisfiable(gamma.union(set([definition_list[p.name]])), processed, definition_list, path)
        elif isinstance(p, Nu):
            # TODO: We should handle `Nu X . X`
            return is_satisfiable(gamma.union(set([p.subpattern.substitute(p.bound, SVar(definition_list.index(p)))])), processed, definition_list, path)
        elif isinstance(p, Or):
            return is_satisfiable(gamma.union(set([p.left])),  processed, definition_list, path) \
                or is_satisfiable(gamma.union(set([p.right])), processed, definition_list, path)
        else:
            raise NotImplementedError(p)

    print(processed)

    if is_inconsistant(list(processed)): return False
    if processed in path: return True
    path = path.union([processed])

    apps  = [phi for phi in processed if isinstance(phi, App)]
    dapps = [phi for phi in processed if isinstance(phi, DApp)]
    print('apps', apps)
    left_partitions = powerset(dapps)

    return all( any(     is_satisfiable(frozenset([app.left]).union( frozenset(map(lambda p: p.left,  left))),                   frozenset(), definition_list, path)
                     and is_satisfiable(frozenset([app.right]).union(frozenset(map(lambda p: p.right, set(dapps) - set(left)))), frozenset(), definition_list, path)
                    for left in left_partitions) for app in apps )
