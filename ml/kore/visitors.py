from typing import Set, List, Dict, Tuple, Mapping, TextIO

import re

from ml.utils.ansi import ANSI

from .ast import *


class VisitorStructure:
    """
    A VisitorStructure is a mixin class that defines the
    relation of parents and children in a visitor, in particular,
    which children of a node will be visited and in what order
    """
    def visit(self, ast):
        raise NotImplementedError()


class PatternOnlyVisitorStructure(VisitorStructure):
    """
    Only visit node that may contain (non-attribute) patterns
    """
    def visit_children_of_definition(self, definition: Definition):
        return [
            [self.visit(module) for module in definition.module_map.values()],
        ]

    def visit_children_of_module(self, module: Module):
        return [
            [self.visit(sentence) for sentence in module.all_sentences],
        ]

    def visit_children_of_axiom(self, axiom: Axiom):
        return [
            self.visit(axiom.pattern),
        ]

    def visit_children_of_alias_definition(self, alias_def: AliasDefinition):
        return [
            self.visit(alias_def.rhs),
        ]

    def visit_children_of_application(self, application: Application):
        return [
            [self.visit(arg) for arg in application.arguments],
        ]

    def visit_children_of_ml_pattern(self, ml_pattern: MLPattern):
        return [
            [self.visit(arg) for arg in ml_pattern.arguments],
        ]


class PatternAndSortVisitorStructure(VisitorStructure):
    """
    Explores all patterns and sorts
    """
    def visit_children_of_definition(self, definition: Definition):
        return [
            [self.visit(module) for module in definition.module_map.values()],
        ]

    def visit_children_of_module(self, module: Module):
        return [
            [self.visit(sentence) for sentence in module.all_sentences],
        ]

    def visit_children_of_sort_definition(self, sort_definition: SortDefinition):
        return [
            [self.visit(var) for var in sort_definition.sort_variables],
        ]

    def visit_children_of_sort_instance(self, sort_instance: SortInstance):
        return [
            [self.visit(arg) for arg in sort_instance.arguments],
        ]

    def visit_children_of_symbol_definition(self, symbol_definition: SymbolDefinition):
        return [
            [self.visit(var) for var in symbol_definition.sort_variables],
            [self.visit(sort) for sort in symbol_definition.input_sorts],
            self.visit(symbol_definition.output_sort),
        ]

    def visit_children_of_symbol_instance(self, symbol_instance: SymbolInstance):
        return [
            [self.visit(arg) for arg in symbol_instance.sort_arguments],
        ]

    def visit_children_of_axiom(self, axiom: Axiom):
        return [
            [self.visit(var) for var in axiom.sort_variables],
            self.visit(axiom.pattern),
        ]

    def visit_children_of_alias_definition(self, alias_def: AliasDefinition):
        return [
            self.visit(alias_def.definition),
            self.visit(alias_def.lhs),
            self.visit(alias_def.rhs),
        ]

    def visit_children_of_variable(self, var: Variable):
        return [
            self.visit(var.sort),
        ]

    def visit_children_of_application(self, application: Application):
        return [
            self.visit(application.symbol),
            [self.visit(arg) for arg in application.arguments],
        ]

    def visit_children_of_ml_pattern(self, ml_pattern: MLPattern):
        return [
            [self.visit(sort) for sort in ml_pattern.sorts],
            [self.visit(arg) for arg in ml_pattern.arguments],
        ]


class FullVisitorStructure(VisitorStructure):
    """
    Explores all children (but avoiding infinite recursion)
    """
    def visit_children_of_definition(self, definition: Definition):
        return [
            [self.visit(module) for module in definition.module_map.values()],
            [self.visit(attr) for attr in definition.attributes],
        ]

    def visit_children_of_module(self, module: Module):
        return [
            [self.visit(sentence) for sentence in module.all_sentences],
            [self.visit(attr) for attr in module.attributes],
        ]

    def visit_children_of_import_statement(self, import_stmt: ImportStatement):
        return [
            [self.visit(attr) for attr in import_stmt.attributes],
        ]

    def visit_children_of_sort_definition(self, sort_definition: SortDefinition):
        return [
            [self.visit(var) for var in sort_definition.sort_variables],
            [self.visit(attr) for attr in sort_definition.attributes],
        ]

    def visit_children_of_sort_instance(self, sort_instance: SortInstance):
        return [
            [self.visit(arg) for arg in sort_instance.arguments],
        ]

    def visit_children_of_sort_variable(self, sort_variable: SortVariable):
        return []

    def visit_children_of_symbol_definition(self, symbol_definition: SymbolDefinition):
        return [
            [self.visit(var) for var in symbol_definition.sort_variables],
            [self.visit(sort) for sort in symbol_definition.input_sorts],
            self.visit(symbol_definition.output_sort),
            [self.visit(attr) for attr in symbol_definition.attributes],
        ]

    def visit_children_of_symbol_instance(self, symbol_instance: SymbolInstance):
        return [
            [self.visit(arg) for arg in symbol_instance.sort_arguments],
        ]

    def visit_children_of_axiom(self, axiom: Axiom):
        return [
            [self.visit(var) for var in axiom.sort_variables],
            self.visit(axiom.pattern),
            [self.visit(attr) for attr in axiom.attributes],
        ]

    def visit_children_of_alias_definition(self, alias_def: AliasDefinition):
        return [
            self.visit(alias_def.definition),
            self.visit(alias_def.lhs),
            self.visit(alias_def.rhs),
            [self.visit(attr) for attr in alias_def.attributes],
        ]

    def visit_children_of_variable(self, var: Variable):
        return [
            self.visit(var.sort),
        ]

    def visit_children_of_string_literal(self, literal: StringLiteral):
        return []

    def visit_children_of_application(self, application: Application):
        return [
            self.visit(application.symbol),
            [self.visit(arg) for arg in application.arguments],
        ]

    def visit_children_of_ml_pattern(self, ml_pattern: MLPattern):
        return [
            [self.visit(sort) for sort in ml_pattern.sorts],
            [self.visit(arg) for arg in ml_pattern.arguments],
        ]


class UnionVisitor(KoreVisitor):
    """
    Union visitor is used for collecting
    information that is unioned at each node
    """
    def postvisit_default(self, x, *args):
        union = set()

        for arg in args:
            if type(arg) is set:
                union = union.union(arg)
            elif type(arg) is list:
                union = union.union(self.postvisit_default(None, *arg))

        return union


class FreePatternVariableVisitor(UnionVisitor, PatternOnlyVisitorStructure):
    """
    Collect free (pattern) variables in a definition
    """
    def postvisit_variable(self, var) -> Set[Variable]:
        return {var}

    def postvisit_ml_pattern(self, ml_pattern: MLPattern, arguments: List[Set[Variable]]) -> Set[Variable]:
        binding_variable = ml_pattern.get_binding_variable()
        free_variables: Set[Variable] = set()

        for var_set in arguments:
            free_variables = free_variables.union(var_set)

        if binding_variable is not None:
            return free_variables.difference({binding_variable})

        return free_variables

    def postvisit_alias_definition(self, alias_def: AliasDefinition, rhs: Set[Variable]):
        return rhs.difference(alias_def.get_binding_variables())


class PatternVariableVisitor(UnionVisitor, PatternOnlyVisitorStructure):
    """
    Collect all variables used in a pattern
    """
    def postvisit_variable(self, var) -> Set[Variable]:
        return {var}


class SortVariableVisitor(UnionVisitor, PatternAndSortVisitorStructure):
    """
    Collect all sort variables used in a pattern
    """
    def postvisit_sort_variable(self, var) -> Set[SortVariable]:
        return {var}


class OrderedPatternVariableVisitor(UnionVisitor, PatternOnlyVisitorStructure):
    """
    Collect all variables used in a pattern (in order of visit)
    """
    def __init__(self):
        self.index = 0

    def postvisit_variable(self, var) -> Set[Tuple[int, Variable]]:
        i = self.index
        self.index += 1
        return {(i, var)}


class ConjunctionVisitor(KoreVisitor):
    """
    Tests if every node satisfy certain condition
    """
    def postvisit_default(self, x, *args) -> bool:
        result = True

        for arg in args:
            if type(arg) is bool:
                result = result and arg
            elif type(arg) is list:
                result = result and self.postvisit_default(None, *arg)

        return result


class QuantifierTester(ConjunctionVisitor, PatternOnlyVisitorStructure):
    """
    Tests if a given pattern is quantifier free
    """
    def postvisit_ml_pattern(self, pattern: MLPattern, arguments: List[bool]) -> bool:
        if (pattern.construct == MLPattern.FORALL or pattern.construct == MLPattern.EXISTS):
            return False
        else:
            return self.postvisit_default(None, *arguments)


class PatternSubstitutionVisitor(KoreVisitor, PatternOnlyVisitorStructure):
    """
    In place substitution of pattern variables
    Note: this visitor does not detect free variable capturing
    """
    def __init__(self, substitution: Mapping[Variable, Pattern]):
        super().__init__()
        self.substitution = dict(substitution)
        self.shadowing_stack: List[Dict[Variable, Pattern]] = []

    def postvisit_variable(self, var) -> Pattern:
        if var in self.substitution:
            return self.substitution[var]
        return var

    # need to update everything that are potentially
    # parents of variables: all (compound) patterns, axioms, and alias definition

    def postvisit_axiom(self, axiom: Axiom, pattern) -> Axiom:
        axiom.pattern = pattern
        return axiom

    def previsit_alias_definition(self, alias_def: AliasDefinition):
        binding_variables = alias_def.get_binding_variables()
        overlap = set(binding_variables).intersection(set(self.substitution.keys()))
        if len(overlap):
            shadowed_substitution = {}
            for key in overlap:
                shadowed_substitution[key] = self.substitution[key]
                del self.substitution[key]
            self.shadowing_stack.append(shadowed_substitution)

    def postvisit_alias_definition(self, alias_def: AliasDefinition, rhs) -> AliasDefinition:
        alias_def.rhs = rhs

        # restore the substitution
        binding_variables = alias_def.get_binding_variables()
        overlap = set(binding_variables).intersection(set(self.substitution.keys()))
        if len(overlap):
            shadowed_substitution = self.shadowing_stack.pop()
            assert set(shadowed_substitution.keys()) == overlap
            for key in shadowed_substitution:
                self.substitution[key] = shadowed_substitution[key]

        return alias_def

    def postvisit_application(self, application: Application, arguments: List[Pattern]) -> Application:
        application.arguments = arguments
        return application

    def previsit_ml_pattern(self, ml_pattern: MLPattern):
        # shadow the binded variable
        binding_variable = ml_pattern.get_binding_variable()
        if binding_variable is not None and binding_variable in self.substitution:
            self.shadowing_stack.append({binding_variable: self.substitution[binding_variable]})
            del self.substitution[binding_variable]

    def postvisit_ml_pattern(self, ml_pattern: MLPattern, arguments: List[Pattern]) -> MLPattern:
        # restore the substitution
        binding_variable = ml_pattern.get_binding_variable()
        if binding_variable is not None and binding_variable in self.substitution:
            ((variable, assigned), ) = self.shadowing_stack.pop().items()
            assert variable == binding_variable
            self.substitution[variable] = assigned

        # update arguments
        ml_pattern.arguments = arguments
        return ml_pattern


class SortSubstitutionVisitor(KoreVisitor, PatternAndSortVisitorStructure):
    """
    In place substitution of sort variables
    """
    def __init__(self, substitution: Mapping[SortVariable, Sort]):
        super().__init__()
        self.substitution = substitution

    def postvisit_axiom(self, axiom: Axiom, *args) -> Axiom:
        # an axiom is assumed to have no free sort variables
        return axiom

    def postvisit_sort_instance(self, sort_instance: SortInstance, arguments: List[Sort]) -> SortInstance:
        sort_instance.arguments = arguments
        return sort_instance

    def postvisit_sort_variable(self, sort_variable: SortVariable) -> Sort:
        if sort_variable in self.substitution:
            return self.substitution[sort_variable]
        else:
            return sort_variable

    def postvisit_symbol_instance(self, symbol_instance: SymbolInstance, sort_arguments: List[Sort]) -> SymbolInstance:
        symbol_instance.sort_arguments = sort_arguments
        return symbol_instance

    def postvisit_variable(self, variable: Variable, sort: Sort) -> Variable:
        variable.sort = sort
        return variable

    def postvisit_ml_pattern(self, ml_pattern: MLPattern, sorts: List[Sort], arguments: List[Pattern]) -> Pattern:
        ml_pattern.sorts = sorts
        return ml_pattern


class CopyVisitor(KoreVisitor, FullVisitorStructure):
    """
    Make a copy of the given AST
    Note: the result of the copy is left in unresolved form
    we have to call resolve() again to relink all the
    references to definitions
    """
    def postvisit_default(self, x, *args):
        raise NotImplementedError()

    def postvisit_definition(self, definition: Definition, *args) -> Definition:
        return Definition(*args)

    def postvisit_module(self, module: Module, *args) -> Module:
        return Module(module.name, *args)

    def postvisit_import_statement(self, import_stmt: ImportStatement, *args) -> ImportStatement:
        return ImportStatement(
            import_stmt.module if isinstance(import_stmt.module, str) else import_stmt.module.name,
            *args,
        )

    def postvisit_sort_definition(self, sort_definition: SortDefinition, *args) -> SortDefinition:
        definition = SortDefinition(sort_definition.sort_id, *args)
        definition.hooked = sort_definition.hooked
        return definition

    def postvisit_sort_instance(self, sort_instance: SortInstance, *args) -> SortInstance:
        return SortInstance(
            sort_instance.definition if isinstance(sort_instance.definition, str) else sort_instance.definition.sort_id,
            *args,
        )

    def postvisit_sort_variable(self, sort_variable: SortVariable) -> SortVariable:
        return SortVariable(sort_variable.name)

    def postvisit_symbol_definition(self, definition: SymbolDefinition, *args) -> SymbolDefinition:
        definition = SymbolDefinition(
            definition.symbol,
            *args,
        )
        definition.hooked = definition.hooked
        return definition

    def postvisit_symbol_instance(self, instance: SymbolInstance, *args) -> SymbolInstance:
        return SymbolInstance(
            instance.definition if isinstance(instance.definition, str) else instance.definition.symbol,
            *args,
        )

    def postvisit_axiom(self, axiom: Axiom, *args) -> Axiom:
        sentence = Axiom(*args)
        sentence.is_claim = axiom.is_claim
        return sentence

    def postvisit_alias_definition(self, alias_def: AliasDefinition, *args) -> AliasDefinition:
        return AliasDefinition(*args)

    def postvisit_variable(self, var: Variable, *args) -> Variable:
        var_copy = Variable(var.name, *args)
        var_copy.is_set_variable = var.is_set_variable
        return var_copy

    def postvisit_string_literal(self, literal: StringLiteral) -> StringLiteral:
        return StringLiteral(literal.content)

    def postvisit_application(self, application: Application, *args) -> Application:
        return Application(*args)

    def postvisit_ml_pattern(self, ml_pattern: MLPattern, *args) -> MLPattern:
        return MLPattern(ml_pattern.construct, *args)
