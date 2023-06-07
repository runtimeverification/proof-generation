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
    assert llvm_pattern, ('Could not deserialize binary kore.', input)
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

    @staticmethod
    def parse(input: bytes) -> LLVMRewriteTrace:
        parser = LLVMRewriteTraceParser(input)
        ret = parser.read_rewrite_trace()
        # assert parser.eof()
        return ret

class LLVMRewriteTraceParser:
    """
    binary_kore_term := 0xffffffffffffffff serialized_term 0xcccccccccccccccc
    variable := null_terminated_name serialized_term 0xcccccccccccccccc
    ordinal := uint64
    arity := uint64
    rewrite_trace := ordinal arity variable* binary_kore_term
    initial_config := binary_kore_term
    proof_trace := initial_config rewrite_trace*
    """


    def __init__(self, input: bytes):
        self.input = input

    def read_rewrite_trace(self) -> LLVMRewriteTrace:
        init_config = self.read_binary_kore_term()
        # while input:
        #     traces += self.read_rewrite_step()
        return LLVMRewriteTrace(init_config, ())

    def read_binary_kore_term(self) -> pg_kore.Pattern:
        self.read_constant(bytes([0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, ]))
        sentinal = bytes([0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, ])
        raw_term = self.read_until(sentinal)
        self.read_constant(sentinal)
        return from_binkore(raw_term)

    def read_constant(self, constant: bytes) -> None:
        assert self.input[:len(constant)] == constant
        self.input = self.input[len(constant):]

    def read_until(self, constant: bytes) -> bytes:
        index = self.input.find(constant)
        ret = self.input[:index]
        self.input = self.input[index:]
        return ret

    # def read_proof_step(self) -> pg_kore.LLVMRewriteStep:
    #     return None

