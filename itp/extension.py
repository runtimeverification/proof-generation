"""
Extensions to the metamath AST as in proof.metamath.ast
"""

from typing import Optional

from proof.metamath.ast import StructuredStatement, Metavariable, Term, MetamathVisitor
from proof.metamath.composer import Composer, Proof
from proof.metamath.visitors import SubstitutionVisitor as OldSubstitutionVisitor
from proof.metamath.visitors import CopyVisitor as OldCopyVisitor


class SchematicVariable(Metavariable):
    def __init__(self, typecode: str, num: int):
        # here we are assuming no metavariable starts with $
        super().__init__(f"${num}")
        self.num = num
        self.typecode = typecode

    def visit(self, visitor: MetamathVisitor):
        return visitor.proxy_visit_schematic_variable(self)


class SubstitutionVisitor(OldSubstitutionVisitor):
    def postvisit_schematic_variable(self, var: SchematicVariable) -> Term:
        if var.name in self.substitution: return self.substitution[var.name]
        return SchematicVariable(var.typecode, var.num)

class CopyVisitor(OldCopyVisitor):
    def postvisit_schematic_variable(self, var: SchematicVariable) -> SchematicVariable:
        return SchematicVariable(var.typecode, var.num)
