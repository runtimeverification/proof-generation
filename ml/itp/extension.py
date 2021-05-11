"""
Extensions to the metamath AST as in proof.metamath.ast
"""

from typing import Optional, Any

from ml.utils.visitor import ResultT

from ml.metamath.ast import StructuredStatement, Metavariable, Term, MetamathVisitor, Proof
from ml.metamath.composer import Composer


class SchematicVariable(Metavariable):
    def __init__(self, typecode: str, num: int):
        # here we are assuming no metavariable starts with $
        super().__init__(f"${num}")
        self.num = num
        self.typecode = typecode

    def visit(self, visitor: MetamathVisitor[ResultT]) -> ResultT:
        return visitor.proxy_visit_schematic_variable(self)  # type: ignore

    def __gt__(self, other: Any) -> bool:
        assert isinstance(other, SchematicVariable)
        return self.num > other.num
