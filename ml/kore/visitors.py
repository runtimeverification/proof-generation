from typing import Set, List, Dict, Tuple, Mapping, TextIO, Any, Generic, TypeVar

import re

from ml.utils.ansi import ANSI
from ml.utils.visitor import TreeT, ResultT, ChildrenResultT, UnionVisitor, ConjunctionVisitor, DisjunctionVisitor

from .ast import *

BaseASTT = TypeVar("BaseASTT", bound=BaseAST[Any])


class VisitorStructure(Generic[TreeT, ResultT]):
    """
    A VisitorStructure is a mixin class that defines the
    relation of parents and children in a visitor, in particular,
    which children of a node will be visited and in what order
    """
    def visit(self, ast: TreeT) -> ResultT:
        raise NotImplementedError()


class PatternOnlyVisitorStructure(VisitorStructure[BaseASTT, ResultT]):
    """
    Only visit node that may contain (non-attribute) patterns
    """
    def visit_children_of_definition(self, definition: Definition) -> List[ChildrenResultT[ResultT]]:
        return [
            [self.visit(module) for module in definition.module_map.values()],  # type: ignore
        ]

    def visit_children_of_module(self, module: Module) -> List[ChildrenResultT[ResultT]]:
        return [
            [self.visit(sentence) for sentence in module.all_sentences],  # type: ignore
        ]

    def visit_children_of_axiom(self, axiom: Axiom) -> List[ChildrenResultT[ResultT]]:
        return [
            self.visit(axiom.pattern),  # type: ignore
        ]

    def visit_children_of_alias_definition(self, alias_def: AliasDefinition) -> List[ChildrenResultT[ResultT]]:
        return [
            self.visit(alias_def.rhs),  # type: ignore
        ]

    def visit_children_of_application(self, application: Application) -> List[ChildrenResultT[ResultT]]:
        return [
            [self.visit(arg) for arg in application.arguments],  # type: ignore
        ]

    def visit_children_of_ml_pattern(self, ml_pattern: MLPattern) -> List[ChildrenResultT[ResultT]]:
        return [
            [self.visit(arg) for arg in ml_pattern.arguments],  # type: ignore
        ]


class PatternAndSortVisitorStructure(VisitorStructure[BaseASTT, ResultT]):
    """
    Explores all patterns and sorts
    """
    def visit_children_of_definition(self, definition: Definition) -> List[ChildrenResultT[ResultT]]:
        return [
            [self.visit(module) for module in definition.module_map.values()],  # type: ignore[arg-type]
        ]

    def visit_children_of_module(self, module: Module) -> List[ChildrenResultT[ResultT]]:
        return [
            [self.visit(sentence) for sentence in module.all_sentences],  # type: ignore[arg-type]
        ]

    def visit_children_of_sort_definition(self, sort_definition: SortDefinition) -> List[ChildrenResultT[ResultT]]:
        return [
            [self.visit(var) for var in sort_definition.sort_variables],  # type: ignore[arg-type]
        ]

    def visit_children_of_sort_instance(self, sort_instance: SortInstance) -> List[ChildrenResultT[ResultT]]:
        return [
            [self.visit(arg) for arg in sort_instance.arguments],  # type: ignore[arg-type]
        ]

    def visit_children_of_symbol_definition(self,
                                            symbol_definition: SymbolDefinition) -> List[ChildrenResultT[ResultT]]:
        return [
            [self.visit(var) for var in symbol_definition.sort_variables],  # type: ignore[arg-type]
            [self.visit(sort) for sort in symbol_definition.input_sorts],  # type: ignore[arg-type]
            self.visit(symbol_definition.output_sort),  # type: ignore[arg-type]
        ]

    def visit_children_of_symbol_instance(self, symbol_instance: SymbolInstance) -> List[ChildrenResultT[ResultT]]:
        return [
            [self.visit(arg) for arg in symbol_instance.sort_arguments],  # type: ignore[arg-type]
        ]

    def visit_children_of_axiom(self, axiom: Axiom) -> List[ChildrenResultT[ResultT]]:
        return [
            [self.visit(var) for var in axiom.sort_variables],  # type: ignore[arg-type]
            self.visit(axiom.pattern),  # type: ignore[arg-type]
        ]

    def visit_children_of_alias_definition(self, alias_def: AliasDefinition) -> List[ChildrenResultT[ResultT]]:
        return [
            self.visit(alias_def.definition),  # type: ignore[arg-type]
            self.visit(alias_def.lhs),  # type: ignore[arg-type]
            self.visit(alias_def.rhs),  # type: ignore[arg-type]
        ]

    def visit_children_of_variable(self, var: Variable) -> List[ChildrenResultT[ResultT]]:
        return [
            self.visit(var.sort),  # type: ignore[arg-type]
        ]

    def visit_children_of_application(self, application: Application) -> List[ChildrenResultT[ResultT]]:
        return [
            self.visit(application.symbol),  # type: ignore[arg-type]
            [self.visit(arg) for arg in application.arguments],  # type: ignore[arg-type]
        ]

    def visit_children_of_ml_pattern(self, ml_pattern: MLPattern) -> List[ChildrenResultT[ResultT]]:
        return [
            [self.visit(sort) for sort in ml_pattern.sorts],  # type: ignore[arg-type]
            [self.visit(arg) for arg in ml_pattern.arguments],  # type: ignore[arg-type]
        ]


class FullVisitorStructure(VisitorStructure[BaseASTT, ResultT]):
    """
    Explores all children (but avoiding infinite recursion)
    """
    def visit_children_of_definition(self, definition: Definition) -> List[ChildrenResultT[ResultT]]:
        return [
            [self.visit(module) for module in definition.module_map.values()],  # type: ignore[arg-type]
            [self.visit(attr) for attr in definition.attributes],  # type: ignore[arg-type]
        ]

    def visit_children_of_module(self, module: Module) -> List[ChildrenResultT[ResultT]]:
        return [
            [self.visit(sentence) for sentence in module.all_sentences],  # type: ignore[arg-type]
            [self.visit(attr) for attr in module.attributes],  # type: ignore[arg-type]
        ]

    def visit_children_of_import_statement(self, import_stmt: ImportStatement) -> List[ChildrenResultT[ResultT]]:
        return [
            [self.visit(attr) for attr in import_stmt.attributes],  # type: ignore[arg-type]
        ]

    def visit_children_of_sort_definition(self, sort_definition: SortDefinition) -> List[ChildrenResultT[ResultT]]:
        return [
            [self.visit(var) for var in sort_definition.sort_variables],  # type: ignore[arg-type]
            [self.visit(attr) for attr in sort_definition.attributes],  # type: ignore[arg-type]
        ]

    def visit_children_of_sort_instance(self, sort_instance: SortInstance) -> List[ChildrenResultT[ResultT]]:
        return [
            [self.visit(arg) for arg in sort_instance.arguments],  # type: ignore[arg-type]
        ]

    def visit_children_of_sort_variable(self, sort_variable: SortVariable) -> List[ChildrenResultT[ResultT]]:
        return []

    def visit_children_of_symbol_definition(self,
                                            symbol_definition: SymbolDefinition) -> List[ChildrenResultT[ResultT]]:
        return [
            [self.visit(var) for var in symbol_definition.sort_variables],  # type: ignore[arg-type]
            [self.visit(sort) for sort in symbol_definition.input_sorts],  # type: ignore[arg-type]
            self.visit(symbol_definition.output_sort),  # type: ignore[arg-type]
            [self.visit(attr) for attr in symbol_definition.attributes],  # type: ignore[arg-type]
        ]

    def visit_children_of_symbol_instance(self, symbol_instance: SymbolInstance) -> List[ChildrenResultT[ResultT]]:
        return [
            [self.visit(arg) for arg in symbol_instance.sort_arguments],  # type: ignore[arg-type]
        ]

    def visit_children_of_axiom(self, axiom: Axiom) -> List[ChildrenResultT[ResultT]]:
        return [
            [self.visit(var) for var in axiom.sort_variables],  # type: ignore[arg-type]
            self.visit(axiom.pattern),  # type: ignore[arg-type]
            [self.visit(attr) for attr in axiom.attributes],  # type: ignore[arg-type]
        ]

    def visit_children_of_alias_definition(self, alias_def: AliasDefinition) -> List[ChildrenResultT[ResultT]]:
        return [
            self.visit(alias_def.definition),  # type: ignore[arg-type]
            self.visit(alias_def.lhs),  # type: ignore[arg-type]
            self.visit(alias_def.rhs),  # type: ignore[arg-type]
            [self.visit(attr) for attr in alias_def.attributes],  # type: ignore[arg-type]
        ]

    def visit_children_of_variable(self, var: Variable) -> List[ChildrenResultT[ResultT]]:
        return [
            self.visit(var.sort),  # type: ignore[arg-type]
        ]

    def visit_children_of_string_literal(self, literal: StringLiteral) -> List[ChildrenResultT[ResultT]]:
        return []

    def visit_children_of_application(self, application: Application) -> List[ChildrenResultT[ResultT]]:
        return [
            self.visit(application.symbol),  # type: ignore[arg-type]
            [self.visit(arg) for arg in application.arguments],  # type: ignore[arg-type]
        ]

    def visit_children_of_ml_pattern(self, ml_pattern: MLPattern) -> List[ChildrenResultT[ResultT]]:
        return [
            [self.visit(sort) for sort in ml_pattern.sorts],  # type: ignore[arg-type]
            [self.visit(arg) for arg in ml_pattern.arguments],  # type: ignore[arg-type]
        ]


T = TypeVar("T")
KoreUnionVisitor = UnionVisitor[BaseAST[Any], T]


class FreePatternVariableVisitor(KoreUnionVisitor[Variable], PatternOnlyVisitorStructure[BaseAST[Any], Set[Variable]]):
    """
    Collect free (pattern) variables in a definition
    """
    def postvisit_variable(self, var: Variable) -> Set[Variable]:
        return {var}

    def postvisit_ml_pattern(self, ml_pattern: MLPattern, arguments: List[Set[Variable]]) -> Set[Variable]:
        binding_variable = ml_pattern.get_binding_variable()
        free_variables: Set[Variable] = set()

        for var_set in arguments:
            free_variables = free_variables.union(var_set)

        if binding_variable is not None:
            return free_variables.difference({binding_variable})

        return free_variables

    def postvisit_alias_definition(self, alias_def: AliasDefinition, rhs: Set[Variable]) -> Set[Variable]:
        return rhs.difference(alias_def.get_binding_variables())


class PatternVariableVisitor(KoreUnionVisitor[Variable], PatternOnlyVisitorStructure[BaseAST[Any], Set[Variable]]):
    """
    Collect all variables used in a pattern
    """
    def postvisit_variable(self, var: Variable) -> Set[Variable]:
        return {var}


class SortVariableVisitor(KoreUnionVisitor[SortVariable], PatternAndSortVisitorStructure[BaseAST[Any],
                                                                                         Set[SortVariable]]):
    """
    Collect all sort variables used in a pattern
    """
    def postvisit_sort_variable(self, var: SortVariable) -> Set[SortVariable]:
        return {var}


class OrderedPatternVariableVisitor(KoreUnionVisitor[Tuple[int, Variable]],
                                    PatternOnlyVisitorStructure[BaseAST[Any], Set[Tuple[int, Variable]]]):
    """
    Collect all variables used in a pattern (in order of visit)
    """
    def __init__(self) -> None:
        self.index = 0

    def postvisit_variable(self, var: Variable) -> Set[Tuple[int, Variable]]:
        i = self.index
        self.index += 1
        return {(i, var)}


KoreConjunctionVisitor = ConjunctionVisitor[BaseAST[Any]]
KoreDisjunctionVisitor = DisjunctionVisitor[BaseAST[Any]]


class QuantifierTester(KoreConjunctionVisitor, PatternOnlyVisitorStructure[BaseAST[Any], bool]):
    """
    Tests if a given pattern is quantifier free
    """
    def postvisit_ml_pattern(self, pattern: MLPattern, arguments: List[bool]) -> bool:
        if (pattern.construct == MLPattern.FORALL or pattern.construct == MLPattern.EXISTS):
            return False
        else:
            for arg in arguments:
                if not arg: return False
            return True


class ApplicationSubpatternTester(KoreDisjunctionVisitor, PatternOnlyVisitorStructure[BaseAST[Any], bool]):
    """
    Tests if a given set of application subpatterns is present
    """
    def __init__(self, subpatterns: Tuple[Application, ...]):
        super().__init__()
        self.subpatterns = subpatterns

    def postvisit_application(self, pattern: Application, arguments: List[bool]) -> bool:
        for subpattern in self.subpatterns:
            if pattern == subpattern:
                return True

        for arg in arguments:
            if arg:
                return True

        return False


class PatternSubstitutionVisitor(KoreVisitor[BaseASTT, BaseASTT], PatternOnlyVisitorStructure[BaseASTT, BaseASTT]):
    """
    In place substitution of pattern variables
    Note: this visitor does not detect free variable capturing
    """
    def __init__(self, substitution: Mapping[Variable, Pattern]):
        super().__init__()
        self.substitution: Dict[Variable, Pattern] = dict(substitution)
        self.shadowing_stack: List[Dict[Variable, Pattern]] = []

    def postvisit_variable(self, var: Variable) -> Pattern:
        if var in self.substitution:
            return self.substitution[var]
        return var

    # need to update everything that are potentially
    # parents of variables: all (compound) patterns, axioms, and alias definition

    def postvisit_axiom(self, axiom: Axiom, pattern: Pattern) -> Axiom:
        axiom.pattern = pattern
        return axiom

    def previsit_alias_definition(self, alias_def: AliasDefinition) -> None:
        binding_variables = alias_def.get_binding_variables()
        overlap = set(binding_variables).intersection(set(self.substitution.keys()))
        if len(overlap):
            shadowed_substitution = {}
            for key in overlap:
                shadowed_substitution[key] = self.substitution[key]
                del self.substitution[key]
            self.shadowing_stack.append(shadowed_substitution)

    def postvisit_alias_definition(self, alias_def: AliasDefinition, rhs: Pattern) -> AliasDefinition:
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

    def previsit_ml_pattern(self, ml_pattern: MLPattern) -> None:
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


class SortSubstitutionVisitor(KoreVisitor[BaseASTT, BaseASTT], PatternAndSortVisitorStructure[BaseASTT, BaseASTT]):
    """
    In place substitution of sort variables
    """
    def __init__(self, substitution: Mapping[SortVariable, Sort]):
        super().__init__()
        self.substitution = substitution

    def postvisit_axiom(self, axiom: Axiom, *args: Any) -> Axiom:
        new_sort_variables = []

        for sort_var in axiom.sort_variables:
            if sort_var not in self.substitution:
                new_sort_variables.append(sort_var)

        for substitute in self.substitution.values():
            for free_sort_var in SortVariableVisitor().visit(substitute):
                # assert free_sort_var in new_sort_variables, \
                #        f"free sort variable {free_sort_var} after substitution"
                if free_sort_var not in new_sort_variables:
                    new_sort_variables.append(free_sort_var)

        axiom.sort_variables = new_sort_variables
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


class CopyVisitor(KoreVisitor[BaseASTT, BaseASTT], FullVisitorStructure[BaseASTT, BaseASTT]):
    """
    Make a copy of the given AST
    Note: the result of the copy is left in unresolved form
    we have to call resolve() again to relink all the
    references to definitions
    """
    def postvisit_definition(self, definition: Definition, *args: Any) -> Definition:
        return Definition(*args)

    def postvisit_module(self, module: Module, *args: Any) -> Module:
        return Module(module.name, *args)

    def postvisit_import_statement(self, import_stmt: ImportStatement, *args: Any) -> ImportStatement:
        return ImportStatement(
            import_stmt.module if isinstance(import_stmt.module, str) else import_stmt.module.name,
            *args,
        )

    def postvisit_sort_definition(self, sort_definition: SortDefinition, *args: Any) -> SortDefinition:
        definition = SortDefinition(sort_definition.sort_id, *args)
        definition.hooked = sort_definition.hooked
        return definition

    def postvisit_sort_instance(self, sort_instance: SortInstance, *args: Any) -> SortInstance:
        return SortInstance(
            sort_instance.definition if isinstance(sort_instance.definition, str) else sort_instance.definition.sort_id,
            *args,
        )

    def postvisit_sort_variable(self, sort_variable: SortVariable) -> SortVariable:
        return SortVariable(sort_variable.name)

    def postvisit_symbol_definition(self, definition: SymbolDefinition, *args: Any) -> SymbolDefinition:
        definition = SymbolDefinition(
            definition.symbol,
            *args,
        )
        definition.hooked = definition.hooked
        return definition

    def postvisit_symbol_instance(self, instance: SymbolInstance, *args: Any) -> SymbolInstance:
        return SymbolInstance(
            instance.definition if isinstance(instance.definition, str) else instance.definition.symbol,
            *args,
        )

    def postvisit_axiom(self, axiom: Axiom, *args: Any) -> Axiom:
        sentence = Axiom(*args)
        sentence.is_claim = axiom.is_claim
        return sentence

    def postvisit_alias_definition(self, alias_def: AliasDefinition, *args: Any) -> AliasDefinition:
        return AliasDefinition(*args)

    def postvisit_variable(self, var: Variable, *args: Any) -> Variable:
        var_copy = Variable(var.name, *args)
        var_copy.is_set_variable = var.is_set_variable
        return var_copy

    def postvisit_string_literal(self, literal: StringLiteral) -> StringLiteral:
        return StringLiteral(literal.content)

    def postvisit_application(self, application: Application, *args: Any) -> Application:
        return Application(*args)

    def postvisit_ml_pattern(self, ml_pattern: MLPattern, *args: Any) -> MLPattern:
        return MLPattern(ml_pattern.construct, *args)


class PatternVariableRenamer(KoreVisitor[BaseASTT, BaseASTT], PatternOnlyVisitorStructure[BaseASTT, BaseASTT]):
    """
    Consistently rename all variables appearing in the pattern
    """
    def __init__(self, substitution: Mapping[Variable, Variable]):
        super().__init__()
        self.substitution = substitution

    def postvisit_variable(self, var: Variable) -> Pattern:
        assert var in self.substitution
        return self.substitution[var]

    def postvisit_axiom(self, axiom: Axiom, pattern: Pattern) -> Axiom:
        axiom.pattern = pattern
        return axiom

    def postvisit_application(self, application: Application, arguments: List[Pattern]) -> Application:
        application.arguments = arguments
        return application

    def postvisit_ml_pattern(self, ml_pattern: MLPattern, arguments: List[Pattern]) -> MLPattern:
        ml_pattern.arguments = arguments
        return ml_pattern
