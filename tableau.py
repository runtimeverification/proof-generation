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
