"""
Extensions to the metamath AST as in proof.metamath.ast
"""

from dataclasses import dataclass
from typing import Any

from ..metamath.ast import Metavariable


@dataclass
class SchematicVariable(Metavariable):
    typecode: str
    num: int

    # def visit(self, visitor: MetamathVisitor[ResultT]) -> ResultT:
    #     return visitor.proxy_visit_schematic_variable(self)  # type: ignore

    def __gt__(self, other: Any) -> bool:
        assert isinstance(other, SchematicVariable)
        return self.num > other.num
