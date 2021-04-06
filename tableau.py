from aml import *
from itertools import product

def closure(p: Pattern) -> list[list[Pattern]]:
    if   isinstance(p, SVar) or isinstance(p, EVar) or isinstance(p, Symbol) \
      or isinstance(p, App) \
      or isinstance(p, Exists) or isinstance(p, Forall):
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
