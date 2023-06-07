from __future__ import annotations

from dataclasses import dataclass
from typing import overload

import pyk.kore.syntax as pyk_kore
from pyk.kllvm import load

load  # Only needed to quench the autoformatter.


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
    return from_pyk(llvm_to_kore(llvm_pattern))


@dataclass
class LLVMRewriteStep:
    post_config: pyk_kore.Pattern
    rule_ordinal: int
    substitution: dict[pyk_kore.EVar, pyk_kore.Pattern]


@dataclass
class LLVMRewriteTrace:
    initial_config: pyk_kore.Pattern
    trace: tuple[LLVMRewriteStep, ...]


def parse_proof_hint(input: bytes) -> LLVMRewriteTrace:
    """
    binary_kore_term := 0xffffffffffffffff serialized_term 0xcccccccccccccccc
    variable := null_terminated_name serialized_term 0xcccccccccccccccc
    rewrite_trace := variable* binary_kore_term
    initial_config := binary_kore_term
    proof_trace := initial_config rewrite_trace*
    """
    raise NotImplementedError()
