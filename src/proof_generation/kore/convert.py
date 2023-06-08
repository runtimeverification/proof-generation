from __future__ import annotations

from typing import overload

import pyk.kore.syntax as pyk_kore
from pyk.kllvm import ast as kllvm_kore
from pyk.kllvm.convert import llvm_to_kore

import proof_generation.kore.ast as pg_kore


@overload
def from_pyk(p: pyk_kore.SortVar) -> pg_kore.SortVariable:
    ...


@overload
def from_pyk(p: pyk_kore.SortApp) -> pg_kore.SortInstance:
    ...


@overload
def from_pyk(p: pyk_kore.Sort) -> pg_kore.Sort:
    ...


@overload
def from_pyk(p: pyk_kore.Pattern) -> pg_kore.Pattern:
    ...


def from_pyk(p: pyk_kore.Pattern | pyk_kore.Sort) -> pg_kore.Pattern | pg_kore.Sort:
    if isinstance(p, pyk_kore.SortApp):
        sorts: list[pg_kore.Sort] = [from_pyk(sort) for sort in p.sorts]
        return pg_kore.SortInstance(p.name, sorts)
    if isinstance(p, pyk_kore.EVar):
        sort = from_pyk(p.sort)
        return pg_kore.Variable(p.name, sort)
    if isinstance(p, pyk_kore.DV):
        sorts = [from_pyk(p.sort)]
        args: list[pg_kore.Pattern] = [pg_kore.StringLiteral(p.value.value)]
        return pg_kore.MLPattern('\\dv', sorts, args)
    if isinstance(p, pyk_kore.SortVar):
        return pg_kore.SortVariable(p.name)
    if isinstance(p, pyk_kore.App):
        sorts = [from_pyk(sort) for sort in p.sorts]
        args = [from_pyk(arg) for arg in p.args]
        return pg_kore.Application(pg_kore.SymbolInstance(p.symbol, sorts), args)
    raise NotImplementedError(f'For type {type(p)}, kore = {p}')


def from_binkore(input: bytes) -> pg_kore.Pattern:
    llvm_pattern = kllvm_kore.Pattern.deserialize(input)
    assert llvm_pattern, ('Could not deserialize binary kore.', input)
    return from_pyk(llvm_to_kore(llvm_pattern))
