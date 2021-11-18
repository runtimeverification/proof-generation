from __future__ import annotations

from typing import Mapping, List, Tuple, Optional, NewType, TypeVar, Union, Dict, TextIO, Any, Iterable, Set

import sys

from io import StringIO

from .ast import (
    Pattern,
    BaseAST,
    Axiom,
    Axiom,
    Sort,
    SortInstance,
    SortDefinition,
    SymbolDefinition,
    Variable,
    Module,
    Definition,
    AliasDefinition,
    Application,
    MLPattern,
    SortVariable,
    StringLiteral,
    KoreVisitor,
    Claim,
)
from .visitors import (
    PatternOnlyVisitorStructure,
    PatternSubstitutionVisitor,
    SortSubstitutionVisitor,
    CopyVisitor,
    FreePatternVariableVisitor,
    QuantifierTester,
    PatternVariableVisitor,
    SortVariableVisitor,
    PatternVariableRenamer,
)
from .pretty import PrettyPrinter
"""
Path to a subpattern of a pattern or an axiom
"""
PatternPath = List[int]

AST = TypeVar("AST", bound=BaseAST[Any])
P = TypeVar("P", bound=Pattern)
PA = TypeVar("PA", Pattern, Axiom)
PAS = TypeVar("PAS", Pattern, Axiom, Sort)


class AliasDefinitionExpander(KoreVisitor[BaseAST[Any], None], PatternOnlyVisitorStructure[BaseAST[Any], None]):
    """
    Exapand a given list of alias definitions
    Assuming the definitions are not interdependent
    """
    def __init__(self, alias_definitions: Iterable[AliasDefinition]):
        super().__init__()
        self.changed = False
        self.alias_map: Dict[str, AliasDefinition] = {}

        for alias_def in alias_definitions:
            self.alias_map[alias_def.definition.symbol] = alias_def

    @staticmethod
    def expand_alias_def(application: Application, alias_def: AliasDefinition) -> Pattern:
        """
        Expand one pattern that uses an alias definition
        and return a new pattern
        """

        assert application.symbol.definition == alias_def.definition

        variables = alias_def.get_binding_variables()

        if len(application.arguments) != len(variables):
            application.error_with_position("unmatched number of arguments in the use of alias")

        assignment = {var: arg for var, arg in zip(variables, application.arguments)}
        assignment_visitor: PatternSubstitutionVisitor[Pattern] = PatternSubstitutionVisitor(assignment)

        copied_rhs = KoreUtils.copy_ast(alias_def.get_parent(), alias_def.rhs)
        assignment_visitor.visit(copied_rhs)

        return copied_rhs

    def postvisit_axiom(self, axiom: Axiom, *args: Any) -> None:
        if isinstance(axiom.pattern, Application):
            symbol_name = axiom.pattern.symbol.get_symbol_name()
            if symbol_name in self.alias_map:
                axiom.pattern = AliasDefinitionExpander.expand_alias_def(axiom.pattern, self.alias_map[symbol_name])

    def expand_in_application_or_ml_pattern(self, pattern: Union[Application, MLPattern]) -> None:
        for i, arg in enumerate(pattern.arguments):
            if isinstance(arg, Application):
                symbol_name = arg.symbol.get_symbol_name()
                if symbol_name in self.alias_map:
                    self.changed = True
                    pattern.arguments[i] = AliasDefinitionExpander.expand_alias_def(arg, self.alias_map[symbol_name])

    def postvisit_application(self, application: Application, *args: Any) -> None:
        self.expand_in_application_or_ml_pattern(application)

    def postvisit_ml_pattern(self, ml_pattern: MLPattern, *args: Any) -> None:
        self.expand_in_application_or_ml_pattern(ml_pattern)


class KoreUtils:
    """
    Utility functions on KORE AST
    """
    @staticmethod
    def copy_ast(module: Module, ast: AST) -> AST:
        copy_ast = ast.visit(CopyVisitor())
        copy_ast.resolve(module)
        return copy_ast  # type: ignore

    @staticmethod
    def copy_pattern(pattern: P) -> P:
        return KoreUtils.copy_ast(pattern.get_parent(), pattern)

    @staticmethod
    def copy_and_substitute_pattern(
        ast: PAS, substitution: Mapping[Variable, Pattern], module: Optional[Module] = None
    ) -> PAS:
        copied = KoreUtils.copy_ast(module or ast.get_parent(), ast)
        return PatternSubstitutionVisitor(substitution).visit(copied)  # type: ignore

    @staticmethod
    def copy_and_substitute_sort(
        ast: PAS, substitution: Mapping[SortVariable, Sort], module: Optional[Module] = None
    ) -> PAS:
        """
        Note that the substitution should be sort variable -> sort
        """
        copied = KoreUtils.copy_ast(module or ast.get_parent(), ast)
        return SortSubstitutionVisitor(substitution).visit(copied)  # type: ignore

    @staticmethod
    def get_subpattern_by_path(ast: Union[Pattern, Axiom], path: PatternPath) -> Union[Pattern, Axiom]:
        if not path:
            return ast

        first, *rest = path

        if isinstance(ast, Axiom):
            assert first == 0, f"axiom {ast} only have one immediate subpattern"
            return KoreUtils.get_subpattern_by_path(ast.pattern, rest)

        assert isinstance(ast, Application) or isinstance(ast, MLPattern
                                                          ), "path {} does not exists in pattern {}".format(path, ast)

        assert first < len(ast.arguments), f"path {path} does not exists in pattern {ast}"
        return KoreUtils.get_subpattern_by_path(ast.arguments[first], rest)

    @staticmethod
    def replace_path_by_pattern_in_axiom(axiom: Axiom, path: PatternPath, replacement: Pattern) -> Axiom:
        """
        path: path to a subpattern
        e.g. in a(b(), c(phi)),
        phi would have the path [ 1, 0 ]
        """

        assert len(path) != 0
        first, *rest = path
        assert first == 0, f"axiom {axiom} only have one immediate subpattern"
        axiom.pattern = KoreUtils.replace_path_by_pattern_in_pattern(axiom.pattern, rest, replacement)
        return axiom

    @staticmethod
    def replace_path_by_pattern_in_pattern(pattern: Pattern, path: PatternPath, replacement: Pattern) -> Pattern:
        if not path:
            return replacement

        first, *rest = path

        assert isinstance(pattern, Application) or isinstance(
            pattern, MLPattern
        ), "path {} does not exists in pattern {}".format(path, pattern)

        # Application and MLPattern all use .arguments for the list of arguments
        assert first < len(pattern.arguments), "path {} does not exists in pattern {}".format(path, pattern)
        pattern.arguments[first] = KoreUtils.replace_path_by_pattern_in_pattern(
            pattern.arguments[first], rest, replacement
        )
        return pattern

    @staticmethod
    def copy_and_replace_path_by_pattern_in_axiom(ast: Axiom, path: PatternPath, replacement: Pattern) -> Axiom:
        copied = KoreUtils.copy_ast(ast.get_parent(), ast)
        return KoreUtils.replace_path_by_pattern_in_axiom(copied, path, replacement)

    @staticmethod
    def copy_and_replace_path_by_pattern_in_pattern(ast: Pattern, path: PatternPath, replacement: Pattern) -> Pattern:
        copied = KoreUtils.copy_ast(ast.get_parent(), ast)
        return KoreUtils.replace_path_by_pattern_in_pattern(copied, path, replacement)

    @staticmethod
    def instantiate_all_alias_uses(module: Module) -> None:
        """
        Replace all alias uses with their definition
        and remove all alias definitions
        """
        alias_defs = list(module.alias_map.values())
        expander = AliasDefinitionExpander(alias_defs)

        # keep expanding until no further change is made
        while True:
            expander.changed = False
            expander.visit(module)
            if not expander.changed:
                break

        for alias_def in alias_defs:
            module.remove_sentence(alias_def)

    @staticmethod
    def get_free_variables(ast: BaseAST[Any]) -> Set[Variable]:
        return FreePatternVariableVisitor().visit(ast)

    @staticmethod
    def get_free_sort_variables(ast: BaseAST[Any]) -> Set[SortVariable]:
        return SortVariableVisitor().visit(ast)

    @staticmethod
    def quantify_all_free_variables_in_axiom(axiom: Axiom) -> None:
        """
        Quantify all free (pattern) variables in the given axiom
        """

        free_vars = list(FreePatternVariableVisitor().visit(axiom.pattern))
        free_vars.sort(key=lambda v: v.name, reverse=True)

        body = axiom.pattern
        body_sort = KoreUtils.infer_sort(body)

        for free_var in free_vars:
            body = MLPattern(MLPattern.FORALL, [body_sort], [free_var, body])

        axiom.pattern = body
        axiom.resolve(axiom.get_parent())

    @staticmethod
    def quantify_all_free_variables(module: Module) -> None:
        """
        Quantify all free (pattern) variables in the axioms
        """
        for axiom in module.axioms:
            KoreUtils.quantify_all_free_variables_in_axiom(axiom)

    @staticmethod
    def rename_variable_with_prefix(axiom: Axiom, prefix: str) -> Tuple[Axiom, Dict[Variable, Variable]]:
        """
        Return a new axiom with all variables renamed to the form <prefix><E|S><number>
        """
        variables = PatternVariableVisitor().visit(axiom)
        renaming = {}

        for i, var in enumerate(variables):
            renaming[var] = Variable(f"{prefix}{'S' if var.is_set_variable else 'E'}{i}", var.sort, var.is_set_variable)

        new_pattern = KoreUtils.copy_ast(axiom.get_parent(), axiom)
        new_pattern.visit(PatternVariableRenamer(renaming))
        new_pattern.resolve(axiom.get_parent())

        return new_pattern, renaming

    @staticmethod
    def unify_sorts(sort1: Sort, sort2: Sort) -> Optional[Mapping[SortVariable, Sort]]:
        if isinstance(sort1, SortVariable):
            return {sort1: sort2}

        if isinstance(sort2, SortVariable):
            return {sort2: sort1}

        assert isinstance(sort1, SortInstance) and isinstance(sort2, SortInstance)

        if sort1.definition != sort2.definition:
            return None

        if len(sort1.arguments) != len(sort2.arguments):
            return None

        substitution: Dict[SortVariable, Sort] = {}

        for sub1, sub2 in zip(sort1.arguments, sort2.arguments):
            sub_substitution = KoreUtils.unify_sorts(sub1, sub2)
            if sub_substitution is None:
                return None

            for var, sort in sub_substitution.items():
                # TODO: they only need to be unifiable
                if var in substitution and sort != substitution:
                    return None

            substitution.update(sub_substitution)

        return substitution

    @staticmethod
    def infer_sort(pattern: Pattern) -> Sort:
        if isinstance(pattern, Variable):
            return pattern.sort

        if isinstance(pattern, Application):
            symbol_def = pattern.symbol.definition
            sort_arguments = pattern.symbol.sort_arguments

            assert isinstance(symbol_def, SymbolDefinition), \
                   f"cannot infer the sort of {pattern} without context"
            assert len(sort_arguments) == len(symbol_def.sort_variables)

            substitution = {var: arg for var, arg in zip(symbol_def.sort_variables, sort_arguments)}
            return KoreUtils.copy_and_substitute_sort(symbol_def.output_sort, substitution)

        if isinstance(pattern, MLPattern):
            # NOTE: as a convention, the last sort in the sort arguments is the output sort
            return pattern.sorts[-1]

        assert False, "unable to get the sort of pattern `{}`".format(pattern)

    @staticmethod
    def strip_forall(pattern: Pattern) -> Pattern:
        """
        Remove all universal quantifiers
        """
        while isinstance(pattern, MLPattern) and pattern.construct == MLPattern.FORALL:
            pattern = pattern.arguments[1]
        return pattern

    @staticmethod
    def strip_exists(pattern: Pattern) -> Pattern:
        while isinstance(pattern, MLPattern) and pattern.construct == MLPattern.EXISTS:
            pattern = pattern.arguments[1]
        return pattern

    @staticmethod
    def decompose_junction(pattern: Pattern, construct: str) -> List[Pattern]:
        """
        NOTE: here a single pattern that doesn't start with the specified construct
        is also considered a junction (of a single clause)
        """
        if not isinstance(pattern, MLPattern) or pattern.construct != construct:
            return [pattern]

        junction = []

        for arg in pattern.arguments:
            junction += KoreUtils.decompose_junction(arg, construct)

        return junction

    @staticmethod
    def decompose_disjunction(pattern: Pattern) -> List[Pattern]:
        return KoreUtils.decompose_junction(pattern, MLPattern.OR)

    @staticmethod
    def is_quantifier_free(pattern: Pattern) -> bool:
        return QuantifierTester().visit(pattern)

    @staticmethod
    def is_existential(pattern: Pattern) -> bool:
        """
        Tests if a pattern starts with existential quantifier(s)
        and the innermost pattern is a quantifier free pattern
        """
        return KoreUtils.is_quantifier_free(KoreUtils.strip_exists(pattern))

    @staticmethod
    def is_concrete(pattern: Pattern) -> bool:
        """
        Have no pattern variable
        """
        return len(PatternVariableVisitor().visit(pattern)) == 0

    @staticmethod
    def is_concrete_sort(sort: Sort) -> bool:
        """
        Have no sort variable
        """
        return len(SortVariableVisitor().visit(sort)) == 0

    @staticmethod
    def is_non_sort_parametric_symbol(symbol_definition: SymbolDefinition) -> bool:
        """
        Tests that the given symbol definition is not parametric in any sort variable
        """
        for input_sort in symbol_definition.input_sorts:
            if not KoreUtils.is_concrete_sort(input_sort):
                return False
        return KoreUtils.is_concrete_sort(symbol_definition.output_sort)

    @staticmethod
    def pretty_print(ast: BaseAST[Any], stream: TextIO = sys.stdout, *args: Any, **kwargs: Any) -> None:
        PrettyPrinter.encode(stream, ast, *args, **kwargs)
        stream.write("\n")

    @staticmethod
    def construct_top(sort: Sort) -> MLPattern:
        return MLPattern(MLPattern.TOP, [sort], [])

    @staticmethod
    def construct_bottom(sort: Sort) -> MLPattern:
        return MLPattern(MLPattern.BOTTOM, [sort], [])

    @staticmethod
    def construct_not(pattern: Pattern) -> MLPattern:
        sort = KoreUtils.infer_sort(pattern)
        return MLPattern(MLPattern.NOT, [sort], [pattern])

    @staticmethod
    def construct_dv(sort: Sort, literal: str) -> MLPattern:
        return MLPattern(MLPattern.DV, [sort], [StringLiteral(literal)])

    @staticmethod
    def construct_unary_ml_pattern(construct: str, pattern: Pattern) -> MLPattern:
        sort = KoreUtils.infer_sort(pattern)
        return MLPattern(construct, [sort], [pattern])

    @staticmethod
    def construct_binary_ml_pattern(construct: str, left: Pattern, right: Pattern) -> MLPattern:
        left_sort = KoreUtils.infer_sort(left)
        right_sort = KoreUtils.infer_sort(right)
        assert left_sort == right_sort or \
               (isinstance(left_sort, SortInstance) and \
                isinstance(right_sort, SortInstance) and \
                left_sort.get_sort_id() == right_sort.get_sort_id()), \
               f"unmatched sort {left_sort} and {right_sort}"
        return MLPattern(construct, [left_sort], [left, right])

    @staticmethod
    def construct_and(left: Pattern, right: Pattern) -> MLPattern:
        return KoreUtils.construct_binary_ml_pattern(MLPattern.AND, left, right)

    @staticmethod
    def construct_or(left: Pattern, right: Pattern) -> MLPattern:
        return KoreUtils.construct_binary_ml_pattern(MLPattern.OR, left, right)

    @staticmethod
    def construct_always(pattern: Pattern) -> MLPattern:
        return KoreUtils.construct_unary_ml_pattern(MLPattern.ALWAYS, pattern)

    @staticmethod
    def construct_circularity(pattern: Pattern) -> MLPattern:
        return KoreUtils.construct_unary_ml_pattern(MLPattern.CIRCULARITY, pattern)

    @staticmethod
    def construct_rewrites(left: Pattern, right: Pattern) -> MLPattern:
        return KoreUtils.construct_binary_ml_pattern(MLPattern.REWRITES, left, right)

    @staticmethod
    def construct_one_path_reaches_star(left: Pattern, right: Pattern) -> MLPattern:
        return KoreUtils.construct_binary_ml_pattern(MLPattern.ONE_PATH_REACHES_STAR, left, right)

    @staticmethod
    def construct_one_path_reaches_plus(left: Pattern, right: Pattern) -> MLPattern:
        return KoreUtils.construct_binary_ml_pattern(MLPattern.ONE_PATH_REACHES_PLUS, left, right)

    @staticmethod
    def construct_rewrites_star(left: Pattern, right: Pattern) -> MLPattern:
        return KoreUtils.construct_binary_ml_pattern(MLPattern.REWRITES_STAR, left, right)

    @staticmethod
    def construct_rewrites_plus(left: Pattern, right: Pattern) -> MLPattern:
        return KoreUtils.construct_binary_ml_pattern(MLPattern.REWRITES_PLUS, left, right)

    @staticmethod
    def construct_implies(left: Pattern, right: Pattern) -> MLPattern:
        return KoreUtils.construct_binary_ml_pattern(MLPattern.IMPLIES, left, right)

    @staticmethod
    def construct_iff(left: Pattern, right: Pattern) -> MLPattern:
        return KoreUtils.construct_binary_ml_pattern(MLPattern.IFF, left, right)

    @staticmethod
    def construct_equals(output_sort: Sort, left: Pattern, right: Pattern) -> MLPattern:
        left_sort = KoreUtils.infer_sort(left)
        right_sort = KoreUtils.infer_sort(right)
        assert left_sort == right_sort, \
               f"unmatched sort {left_sort} and {right_sort}"
        return MLPattern(MLPattern.EQUALS, [left_sort, output_sort], [left, right])

    @staticmethod
    def construct_exists(var: Variable, pattern: Pattern) -> MLPattern:
        sort = KoreUtils.infer_sort(pattern)
        return MLPattern(MLPattern.EXISTS, [sort], [var, pattern])

    @staticmethod
    def construct_forall(var: Variable, pattern: Pattern) -> MLPattern:
        sort = KoreUtils.infer_sort(pattern)
        return MLPattern(MLPattern.FORALL, [sort], [var, pattern])

    @staticmethod
    def destruct_ml_pattern(construct: str, pattern: Pattern) -> List[Pattern]:
        assert isinstance(pattern, MLPattern) and \
               pattern.construct == construct and \
               len(pattern.arguments) == MLPattern.get_number_of_arguments_for_construct(construct), \
               f"expecting {pattern} to be a {construct}"
        return pattern.arguments

    @staticmethod
    def destruct_and(pattern: Pattern) -> List[Pattern]:
        return KoreUtils.destruct_ml_pattern(MLPattern.AND, pattern)

    @staticmethod
    def destruct_or(pattern: Pattern) -> List[Pattern]:
        return KoreUtils.destruct_ml_pattern(MLPattern.OR, pattern)

    @staticmethod
    def destruct_always(pattern: Pattern) -> List[Pattern]:
        return KoreUtils.destruct_ml_pattern(MLPattern.ALWAYS, pattern)

    @staticmethod
    def destruct_circularity(pattern: Pattern) -> List[Pattern]:
        return KoreUtils.destruct_ml_pattern(MLPattern.CIRCULARITY, pattern)

    @staticmethod
    def destruct_rewrites(pattern: Pattern) -> List[Pattern]:
        return KoreUtils.destruct_ml_pattern(MLPattern.REWRITES, pattern)

    @staticmethod
    def destruct_rewrites_star(pattern: Pattern) -> List[Pattern]:
        return KoreUtils.destruct_ml_pattern(MLPattern.REWRITES_STAR, pattern)

    @staticmethod
    def destruct_rewrites_plus(pattern: Pattern) -> List[Pattern]:
        return KoreUtils.destruct_ml_pattern(MLPattern.REWRITES_PLUS, pattern)

    @staticmethod
    def destruct_one_path_reaches_star(pattern: Pattern) -> List[Pattern]:
        return KoreUtils.destruct_ml_pattern(MLPattern.ONE_PATH_REACHES_STAR, pattern)

    @staticmethod
    def destruct_one_path_reaches_plus(pattern: Pattern) -> List[Pattern]:
        return KoreUtils.destruct_ml_pattern(MLPattern.ONE_PATH_REACHES_PLUS, pattern)

    @staticmethod
    def destruct_equals(pattern: Pattern) -> List[Pattern]:
        return KoreUtils.destruct_ml_pattern(MLPattern.EQUALS, pattern)

    @staticmethod
    def destruct_implies(pattern: Pattern) -> List[Pattern]:
        return KoreUtils.destruct_ml_pattern(MLPattern.IMPLIES, pattern)

    @staticmethod
    def destruct_not(pattern: Pattern) -> List[Pattern]:
        return KoreUtils.destruct_ml_pattern(MLPattern.NOT, pattern)

    @staticmethod
    def destruct_iff(pattern: Pattern) -> List[Pattern]:
        return KoreUtils.destruct_ml_pattern(MLPattern.IFF, pattern)

    @staticmethod
    def destruct_ceil(pattern: Pattern) -> List[Pattern]:
        return KoreUtils.destruct_ml_pattern(MLPattern.CEIL, pattern)

    @staticmethod
    def destruct_in(pattern: Pattern) -> List[Pattern]:
        return KoreUtils.destruct_ml_pattern(MLPattern.IN, pattern)

    @staticmethod
    def destruct_exists(pattern: Pattern) -> Tuple[Variable, Pattern]:
        var, body = KoreUtils.destruct_ml_pattern(MLPattern.EXISTS, pattern)
        assert isinstance(var, Variable)
        return var, body

    @staticmethod
    def destruct_forall(pattern: Pattern) -> Tuple[Variable, Pattern]:
        var, body = KoreUtils.destruct_ml_pattern(MLPattern.FORALL, pattern)
        assert isinstance(var, Variable)
        return var, body

    @staticmethod
    def destruct_dv(pattern: Pattern) -> Tuple[Sort, StringLiteral]:
        value, = KoreUtils.destruct_ml_pattern(MLPattern.DV, pattern)
        assert isinstance(pattern, MLPattern) and isinstance(value, StringLiteral)
        sort, = pattern.sorts
        return sort, value

    @staticmethod
    def is_top(pattern: Pattern) -> bool:
        return isinstance(pattern, MLPattern) and pattern.construct == MLPattern.TOP

    @staticmethod
    def is_bottom(pattern: Pattern) -> bool:
        return isinstance(pattern, MLPattern) and pattern.construct == MLPattern.BOTTOM

    @staticmethod
    def is_and(pattern: Pattern) -> bool:
        return isinstance(pattern, MLPattern) and pattern.construct == MLPattern.AND

    @staticmethod
    def is_implies(pattern: Pattern) -> bool:
        return isinstance(pattern, MLPattern) and pattern.construct == MLPattern.IMPLIES

    @staticmethod
    def is_always(pattern: Pattern) -> bool:
        return isinstance(pattern, MLPattern) and pattern.construct == MLPattern.ALWAYS

    @staticmethod
    def is_circularity(pattern: Pattern) -> bool:
        return isinstance(pattern, MLPattern) and pattern.construct == MLPattern.CIRCULARITY

    @staticmethod
    def is_not(pattern: Pattern) -> bool:
        return isinstance(pattern, MLPattern) and pattern.construct == MLPattern.NOT

    @staticmethod
    def is_or(pattern: Pattern) -> bool:
        return isinstance(pattern, MLPattern) and pattern.construct == MLPattern.OR

    @staticmethod
    def is_forall(pattern: Pattern) -> bool:
        return isinstance(pattern, MLPattern) and pattern.construct == MLPattern.FORALL

    @staticmethod
    def is_exists(pattern: Pattern) -> bool:
        return isinstance(pattern, MLPattern) and pattern.construct == MLPattern.EXISTS

    @staticmethod
    def is_equals(pattern: Pattern) -> bool:
        return isinstance(pattern, MLPattern) and pattern.construct == MLPattern.EQUALS

    @staticmethod
    def is_ceil(pattern: Pattern) -> bool:
        return isinstance(pattern, MLPattern) and pattern.construct == MLPattern.CEIL

    @staticmethod
    def is_in(pattern: Pattern) -> bool:
        return isinstance(pattern, MLPattern) and pattern.construct == MLPattern.IN

    @staticmethod
    def is_rewrites(pattern: Pattern) -> bool:
        return isinstance(pattern, MLPattern) and pattern.construct == MLPattern.REWRITES

    @staticmethod
    def is_rewrites_star(pattern: Pattern) -> bool:
        return isinstance(pattern, MLPattern) and pattern.construct == MLPattern.REWRITES_STAR

    @staticmethod
    def is_rewrites_plus(pattern: Pattern) -> bool:
        return isinstance(pattern, MLPattern) and pattern.construct == MLPattern.REWRITES_PLUS

    @staticmethod
    def is_dv(pattern: Pattern) -> bool:
        return isinstance(pattern, MLPattern) and pattern.construct == MLPattern.DV

    @staticmethod
    def destruct_nested_ml_pattern(construct: str, pattern: Pattern) -> Tuple[Pattern, ...]:
        if isinstance(pattern, MLPattern) and pattern.construct == construct:
            left, right = KoreUtils.destruct_ml_pattern(construct, pattern)
            return KoreUtils.destruct_nested_ml_pattern(construct, left) + \
                   KoreUtils.destruct_nested_ml_pattern(construct, right)
        else:
            return pattern,

    @staticmethod
    def destruct_nested_and(pattern: Pattern) -> Tuple[Pattern, ...]:
        return KoreUtils.destruct_nested_ml_pattern(MLPattern.AND, pattern)

    @staticmethod
    def destruct_nested_or(pattern: Pattern) -> Tuple[Pattern, ...]:
        return KoreUtils.destruct_nested_ml_pattern(MLPattern.OR, pattern)
