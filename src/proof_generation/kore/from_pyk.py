from __future__ import annotations

from dataclasses import dataclass
from typing import overload

import pyk.kore.syntax as pyk_kore
from pyk.kllvm import load

load  # Only needed to quench the autoformatter.


from pyk.kllvm import ast as kllvm_kore
from pyk.kllvm.convert import llvm_to_kore

import proof_generation.kore.ast as pg_kore
import proof_generation.rewrite.tasks as Substitution

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
    rule_ordinal: int
    substitution: Substitution
    post_config: pyk_kore.Pattern



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
    term_with_sentinel := serialized_term 0xcccccccccccccccc
    guarded_term := 0xffffffffffffffff term_with_sentinel
    variable := null_terminated_name term_with_sentinel
    ordinal := uint64
    arity := uint64
    rewrite_trace := ordinal arity variable* guarded_term
    initial_config := guarded_term
    proof_trace := initial_config rewrite_trace*
    """

    def __init__(self, input: bytes):
        self.input = input

    def read_rewrite_trace(self) -> LLVMRewriteTrace:
        init_config = self.read_guarded_term()
        traces = ()
        while self.input:
            traces = traces + (self.read_rewrite_step(),)
        return LLVMRewriteTrace(init_config, traces)

    def read_guarded_term(self) -> pg_kore.Pattern:
        self.read_constant(bytes( [ 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, ] ) )
        return self.read_term_with_sentinel()

    def read_term_with_sentinel(self) -> pg_kore.Pattern:
        sentinal = bytes( [ 0xCC, 0xCC, 0xCC, 0xCC, 0xCC, 0xCC, 0xCC, 0xCC, ] )
        raw_term = self.read_until(sentinal)
        self.read_constant(sentinal)
        return from_binkore(raw_term)

    def read_rewrite_step(self) -> pg_kore.LLVMRewriteStep:
        ordinal = self.read_uint64()
        arity = self.read_uint64()

        substitution: tuple[tuple[pg_kore.Variable, pg_kore.Pattern], ...] = ()
        for i in range(arity):
            variable_name = self.read_variable()
            target = self.read_term_with_sentinel()
            substitution = substitution + ((variable_name, target))

        term = self.read_guarded_term()
        return LLVMRewriteStep(ordinal, substitution, term)

    def read_variable(self) -> pg_kore.Variable:
        ret = str(self.read_until(b'\x00'))
        self.read_constant(b'\x00')
        return pg_kore.Variable(ret, sort='Unknown')

    def read_constant(self, constant: bytes) -> None:
        assert self.input[: len(constant)] == constant
        self.input = self.input[len(constant) :]

    def read_uint64(self) -> int:
        index = 8
        # TODO: This is pretty hacky, going via strings, but works for now.
        raw = self.input[:index]
        ret = int(raw[::-1].hex(), 16)
        self.input = self.input[index:]
        return ret

    def read_until(self, constant: bytes) -> bytes:
        index = self.input.find(constant)
        ret = self.input[:index]
        self.input = self.input[index:]
        return ret

    # def read_proof_step(self) -> pg_kore.LLVMRewriteStep:
    #     return None
