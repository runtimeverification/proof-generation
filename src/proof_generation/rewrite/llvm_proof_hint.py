from __future__ import annotations

import struct
from dataclasses import dataclass
from typing import TYPE_CHECKING

from ..kore.convert import from_binkore
from ..kore.utils import KoreUtils
from .tasks import AppliedRule, ConstrainedPattern, RewritingStep, RewritingTask, Substitution  # noqa: TC002
from .templates import KoreTemplates

if TYPE_CHECKING:
    from proof_generation.kore.ast import Axiom, Definition, Pattern, Variable


@dataclass
class LLVMRewriteStep:
    rule_ordinal: int
    substitution: tuple[tuple[str, Pattern], ...]
    post_config: Pattern

    def to_rewriting_step(self, ordinal_list: tuple[Axiom, ...], pre: ConstrainedPattern) -> RewritingStep:
        rule = ordinal_list[self.rule_ordinal]
        assert KoreTemplates.is_rewrite_axiom(rule)

        variables = KoreUtils.get_free_variables(rule.pattern)
        variable_map = {var.name: var for var in variables}
        resolved_subst: tuple[tuple[Variable, Pattern], ...] = ()

        for var_name, val in self.substitution:
            resolved_subst = resolved_subst + ((variable_map[var_name], val),)

        applied_rule = AppliedRule(
            results=(ConstrainedPattern.from_pattern(self.post_config),),
            rule_id=KoreTemplates.get_axiom_unique_id(rule),
            substitution=Substitution(resolved_subst),
        )
        return RewritingStep(initial=pre, applied_rules=(applied_rule,), remainders=())


@dataclass
class LLVMRewriteTrace:
    initial_config: Pattern
    trace: tuple[LLVMRewriteStep, ...]

    @staticmethod
    def parse(input: bytes) -> LLVMRewriteTrace:
        parser = LLVMRewriteTraceParser(input)
        ret = parser.read_rewrite_trace()
        assert parser.eof()
        return ret

    def to_task(self, ordinal_list: tuple[Axiom, ...]) -> RewritingTask:
        initial = ConstrainedPattern.from_pattern(self.initial_config)
        finals = (ConstrainedPattern.from_pattern(self.trace[-1].post_config),)

        pre = initial
        steps: tuple[RewritingStep, ...] = ()
        for step in self.trace:
            steps = steps + (step.to_rewriting_step(ordinal_list, pre),)
            pre = ConstrainedPattern.from_pattern(step.post_config)
        return RewritingTask(initial, finals, steps)


def make_ordinal_list(definition: Definition) -> tuple[Axiom, ...]:
    """The LLVM proof hints rely on the exact lexical index of axioms in the Kore definition.
    So, we keep a copy of this list around, before preprocessing the axioms or otherwise modifying the definition.
    """
    ret: tuple[Axiom, ...] = ()
    for _, module in definition.module_map.items():
        ret = ret + tuple(module.axioms)
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
        traces: tuple[LLVMRewriteStep, ...] = ()
        while self.input:
            traces = traces + (self.read_rewrite_step(),)
        return LLVMRewriteTrace(init_config, traces)

    def read_guarded_term(self) -> Pattern:
        self.read_constant(bytes([0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF]))
        return self.read_term_with_sentinel()

    def read_term_with_sentinel(self) -> Pattern:
        sentinal = bytes(
            [
                0xCC,
                0xCC,
                0xCC,
                0xCC,
                0xCC,
                0xCC,
                0xCC,
                0xCC,
            ]
        )
        raw_term = self.read_until(sentinal)
        self.read_constant(sentinal)
        return from_binkore(raw_term)

    def read_rewrite_step(self) -> LLVMRewriteStep:
        ordinal = self.read_uint64()
        arity = self.read_uint64()

        substitution: tuple[tuple[str, Pattern], ...] = ()
        for _ in range(arity):
            variable_name = self.read_varaiable_name()
            target = self.read_term_with_sentinel()
            substitution = substitution + ((variable_name, target),)

        term = self.read_guarded_term()
        return LLVMRewriteStep(ordinal, substitution, term)

    def read_varaiable_name(self) -> str:
        ret = self.read_until(b'\x00').decode('ascii')
        self.read_constant(b'\x00')
        return ret

    def read_constant(self, constant: bytes) -> None:
        assert self.input[: len(constant)] == constant
        self.input = self.input[len(constant) :]

    def read_uint64(self) -> int:
        index = 8
        raw = self.input[:index]
        self.input = self.input[index:]
        little_endian_long_long = '<Q'
        return struct.unpack(little_endian_long_long, raw)[0]

    def read_until(self, constant: bytes) -> bytes:
        index = self.input.find(constant)
        ret = self.input[:index]
        self.input = self.input[index:]
        return ret

    def eof(self) -> bool:
        return len(self.input) == 0
