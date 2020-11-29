from __future__ import annotations

from typing import List, Optional, Mapping, NewType

from proof.metamath.ast import StructuredStatement, Metavariable, Term, MetamathVisitor
from proof.metamath.composer import Composer, Proof

from .ast import *
from .extension import SchematicVariable, SubstitutionVisitor


GoalStack = NewType("GoalStack", List[StructuredStatement])
ProofStack = NewType("ProofStack", List[Proof])


"""
Stores general information accessible during a proof
"""
class Environment:
    def __init__(self, composer: Composer):
        self.composer = composer
        self.schematic_vars = []

    def get_next_schematic_variable(self, typecode: str) -> SchematicVariable:
        var = SchematicVariable(typecode, len(self.schematic_vars))
        self.schematic_vars.append(var)
        return var

    """
    (Recursively) resolve to the actual concrete term assigned to it
    NOTE: by concrete I mean a term without schematic variables
    """
    def resolve_schematic_variables(self, term: Term) -> Term:
        if isinstance(term, SchematicVariable):
            assert term.assigned is not None, f"schematic variable {term.name} has not been assigned"
            return self.resolve_schematic_variables(term.assigned)

        metavars = term.get_metavariables()
        schematic_substitution = {}

        for metavar in metavars:
            if metavar.startswith("$"):
                var = self.get_nth_schematic_variable(int(metavar[1:]))
                # recursively resolve this
                # TODO: check if this is possible to recursively depend on itself
                subterm = self.resolve_schematic_variables(var)
                schematic_substitution[var.name] = subterm

        return SubstitutionVisitor(schematic_substitution).visit(term)

    def get_nth_schematic_variable(self, num: int) -> SchematicVariable:
        return self.schematic_vars[num]
