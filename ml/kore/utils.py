from __future__ import annotations

from typing import Mapping, List, Tuple, Optional, NewType, TypeVar, Union, Dict

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
)
from .visitors import (
    PatternSubstitutionVisitor,
    SortSubstitutionVisitor,
    CopyVisitor,
    FreePatternVariableVisitor,
    QuantifierTester,
    PatternVariableVisitor,
    SortVariableVisitor,
)


"""
Path to a subpattern of a pattern or an axiom
"""
PatternPath = List[int]


AST = TypeVar("AST", bound=BaseAST)
P = TypeVar("P", bound=Pattern)
PA = TypeVar("PA", Pattern, Axiom)
PAS = TypeVar("PAS", Pattern, Axiom, Sort)


class KoreUtils:
    """
    Utility functions on KORE AST
    """

    @staticmethod
    def copy_ast(module: Module, ast: AST) -> AST:
        copy_ast = ast.visit(CopyVisitor())
        copy_ast.resolve(module)
        return copy_ast

    @staticmethod
    def copy_pattern(pattern: P) -> P:
        return KoreUtils.copy_ast(pattern.get_module(), pattern)

    @staticmethod
    def copy_and_substitute_pattern(
        ast: PAS, substitution: Mapping[Variable, Pattern]
    ) -> PAS:
        copied = KoreUtils.copy_ast(ast.get_module(), ast)
        return PatternSubstitutionVisitor(substitution).visit(copied)

    @staticmethod
    def copy_and_substitute_sort(
        ast: PAS, substitution: Mapping[SortVariable, Sort]
    ) -> PAS:
        """
        Note that the substitution should be sort variable -> sort
        """
        copied = KoreUtils.copy_ast(ast.get_module(), ast)
        return SortSubstitutionVisitor(substitution).visit(copied)

    @staticmethod
    def get_subpattern_by_path(
        ast: Union[Pattern, Axiom], path: PatternPath
    ) -> Union[Pattern, Axiom]:
        if not path:
            return ast

        first, *rest = path

        if isinstance(ast, Axiom):
            assert first == 0, f"axiom {ast} only have one immediate subpattern"
            return KoreUtils.get_subpattern_by_path(ast.pattern, rest)

        assert isinstance(ast, Application) or isinstance(
            ast, MLPattern
        ), "path {} does not exists in pattern {}".format(path, ast)

        assert first < len(
            ast.arguments
        ), f"path {path} does not exists in pattern {ast}"
        return KoreUtils.get_subpattern_by_path(ast.arguments[first], rest)

    @staticmethod
    def replace_path_by_pattern_in_axiom(
        axiom: Axiom, path: PatternPath, replacement: Pattern
    ) -> Axiom:
        """
        path: path to a subpattern
        e.g. in a(b(), c(phi)),
        phi would have the path [ 1, 0 ]
        """

        assert len(path) != 0
        first, *rest = path
        assert first == 0, f"axiom {axiom} only have one immediate subpattern"
        axiom.pattern = KoreUtils.replace_path_by_pattern_in_pattern(
            axiom.pattern, rest, replacement
        )
        return axiom

    @staticmethod
    def replace_path_by_pattern_in_pattern(
        pattern: Pattern, path: PatternPath, replacement: Pattern
    ) -> Pattern:
        if not path:
            return replacement

        first, *rest = path

        assert isinstance(pattern, Application) or isinstance(
            pattern, MLPattern
        ), "path {} does not exists in pattern {}".format(path, pattern)

        # Application and MLPattern all use .arguments for the list of arguments
        assert first < len(
            pattern.arguments
        ), "path {} does not exists in pattern {}".format(path, pattern)
        pattern.arguments[first] = KoreUtils.replace_path_by_pattern_in_pattern(
            pattern.arguments[first], rest, replacement
        )
        return pattern

    @staticmethod
    def copy_and_replace_path_by_pattern_in_axiom(
        ast: Axiom, path: PatternPath, replacement: Pattern
    ) -> Axiom:
        copied = KoreUtils.copy_ast(ast.get_module(), ast)
        return KoreUtils.replace_path_by_pattern_in_axiom(copied, path, replacement)

    @staticmethod
    def expand_alias_def(
        application: Application, alias_def: AliasDefinition
    ) -> Pattern:
        """
        Expand one pattern that uses an alias definition
        and return a new pattern
        """

        assert application.symbol.definition == alias_def.definition

        variables = alias_def.get_binding_variables()

        if len(application.arguments) != len(variables):
            application.error_with_position(
                "unmatched number of arguments in the use of alias"
            )

        assignment = {var: arg for var, arg in zip(variables, application.arguments)}
        assignment_visitor = PatternSubstitutionVisitor(assignment)

        copied_rhs = KoreUtils.copy_ast(alias_def.get_module(), alias_def.rhs)
        copied_rhs.visit(assignment_visitor)

        return copied_rhs

    @staticmethod
    def instantiate_one_alias_use(module: Module, alias_def: AliasDefinition):
        for user in alias_def.definition.users:
            parent = user.get_parent()

            if isinstance(parent, Application) or isinstance(parent, MLPattern):
                for i, arg in enumerate(parent.arguments):
                    if arg == user:
                        assert isinstance(arg, Application)
                        parent.arguments[i] = KoreUtils.expand_alias_def(arg, alias_def)
                        break
                else:
                    assert False, "unable to find corresponding child"
            elif isinstance(parent, AliasDefinition):
                if parent.rhs == user:
                    assert isinstance(parent.rhs, Application)
                    parent.rhs = KoreUtils.expand_alias_def(parent.rhs, alias_def)
            elif isinstance(parent, Axiom):
                assert parent.pattern == user
                assert isinstance(parent.pattern, Application)
                parent.pattern = KoreUtils.expand_alias_def(parent.pattern, alias_def)
            else:
                user.error_with_position("unable to instantiate alias")

    @staticmethod
    def instantiate_all_alias_uses(module: Module):
        """
        Replace all alias uses with their definition
        """
        alias_defs = list(module.alias_map.values())
        for alias_def in alias_defs:
            KoreUtils.instantiate_one_alias_use(module, alias_def)

        for alias_def in alias_defs:
            module.remove_sentence(alias_def)

    @staticmethod
    def quantify_all_free_variables_in_axiom(axiom: Axiom):
        """
        Quantify all free (pattern) variables in the given axiom
        """

        free_vars = axiom.pattern.visit(FreePatternVariableVisitor())
        body = axiom.pattern
        body_sort = KoreUtils.infer_sort(body)

        for free_var in free_vars:
            body = MLPattern(MLPattern.FORALL, [body_sort], [free_var, body])

        axiom.pattern = body
        axiom.resolve(axiom.get_module())

    @staticmethod
    def quantify_all_free_variables(module: Module):
        """
        Quantify all free (pattern) variables in the axioms
        """
        for axiom in module.axioms:
            KoreUtils.quantify_all_free_variables_in_axiom(axiom)

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
            # NOTE: assuming the application has been resolved
            symbol_def = pattern.symbol.definition
            sort_arguments = pattern.symbol.sort_arguments

            assert isinstance(symbol_def, SymbolDefinition)
            assert len(sort_arguments) == len(symbol_def.sort_variables)

            substitution = {
                var: arg for var, arg in zip(symbol_def.sort_variables, sort_arguments)
            }
            return KoreUtils.copy_and_substitute_sort(
                symbol_def.output_sort, substitution
            )

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
