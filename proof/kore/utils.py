from __future__ import annotations

from typing import Mapping, List, Tuple, Optional, NewType

from .ast import *
from .visitors import PatternSubstitutionVisitor, SortSubstitutionVisitor, CopyVisitor, FreePatternVariableVisitor


"""
Path to a subpattern of a pattern or an axiom
"""
PatternPath = NewType("PatternPath", List[int])


"""
Utility functions on KORE AST
"""
class KoreUtils:
    @staticmethod
    def copy_ast(module: Module, ast: BaseAST) -> BaseAST:
        copy_ast = ast.visit(CopyVisitor())
        copy_ast.resolve(module)
        return copy_ast

    @staticmethod
    def copy_and_substitute_pattern(ast: Union[Pattern, Axiom], substitution: Mapping[Variable, Pattern]) -> Union[Pattern, Axiom]:
        copied = KoreUtils.copy_ast(ast.get_module(), ast)
        return PatternSubstitutionVisitor(substitution).visit(copied)

    @staticmethod
    def copy_and_substitute_sort(ast: Union[Pattern, Axiom, Sort], substitution: Mapping[SortVariable, Sort]) -> Union[Pattern, Axiom, Sort]:
        copied = KoreUtils.copy_ast(ast.get_module(), ast)
        return SortSubstitutionVisitor(substitution).visit(copied)

    @staticmethod
    def get_subpattern_by_path(ast: Union[Pattern, Axiom], path: PatternPath) -> Union[Pattern, Axiom]:
        if len(path) == 0: return ast

        first, *rest = path

        if isinstance(ast, Axiom):
            assert first == 0, f"axiom {ast} only have one immediate subpattern"
            return KoreUtils.get_subpattern_by_path(ast.pattern, rest)

        assert isinstance(ast, Application) or isinstance(ast, MLPattern), \
               "path {} does not exists in pattern {}".format(path, ast)

        assert first < len(ast.arguments), f"path {path} does not exists in pattern {ast}"

        if len(rest):
            return KoreUtils.get_subpattern_by_path(ast.arguments[first], rest)
        else:
            return ast.arguments[first]

    """
    path: path to a subpattern
    e.g. in a(b(), c(phi)),
    phi would have the path [ 1, 0 ]
    """
    @staticmethod
    def replace_path_by_pattern(ast: Union[Pattern, Axiom], path: PatternPath, replacement: Pattern):
        assert len(path), "empty path"

        first, *rest = path

        if isinstance(ast, Axiom):
            assert first == 0, f"axiom {ast} only have one immediate subpattern"

            if len(rest):
                KoreUtils.replace_path_by_pattern(ast.pattern, rest, replacement)
            else:
                # TODO: check for free sort variables
                ast.pattern = replacement
            return

        assert isinstance(ast, Application) or isinstance(ast, MLPattern), \
               "path {} does not exists in pattern {}".format(path, ast)

        # Application and MLPattern all use .arguments for the list of arguments

        assert first < len(ast.arguments), "path {} does not exists in pattern {}".format(path, ast)

        if len(rest):
            KoreUtils.replace_path_by_pattern(ast.arguments[first], rest, replacement)
        else:
            # do the actual replacement
            ast.arguments[first] = replacement

    @staticmethod
    def copy_and_replace_path_by_pattern(ast: Union[Pattern, Axiom], path: PatternPath, replacement: Pattern) -> Union[Pattern, Axiom]:
        copied = KoreUtils.copy_ast(ast.get_module(), ast)
        KoreUtils.replace_path_by_pattern(copied, path, replacement)
        return copied

    """
    Expand one pattern that uses an alias definition
    and return a new pattern
    """
    @staticmethod
    def expand_alias_def(application: Application, alias_def: AliasDefinition) -> Pattern:
        assert application.symbol.definition == alias_def.definition

        variables = alias_def.get_binding_variables()

        if len(application.arguments) != len(variables):
            application.error_with_position("unmatched number of arguments in the use of alias")

        assignment = { var: arg for var, arg in zip(variables, application.arguments) }
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
                        parent.arguments[i] = KoreUtils.expand_alias_def(arg, alias_def)
                        break
                else:
                    assert False, "unable to find corresponding child"
            elif isinstance(parent, AliasDefinition):
                if parent.rhs == user:
                    parent.rhs = KoreUtils.expand_alias_def(parent.rhs, alias_def)
            elif isinstance(parent, Axiom):
                assert parent.pattern == user
                parent.pattern = KoreUtils.expand_alias_def(parent.pattern, alias_def)
            else:
                user.error_with_position("unable to instantiate alias")

    """
    Replace all alias uses with their definition
    """
    @staticmethod
    def instantiate_all_alias_uses(module: Module):
        alias_defs = list(module.alias_map.values())
        for alias_def in alias_defs:
            KoreUtils.instantiate_one_alias_use(module, alias_def)

        for alias_def in alias_defs:
            module.remove_sentence(alias_def)

    """
    Quantify all free (pattern) variables in the given axiom
    """
    @staticmethod
    def quantify_all_free_variables_in_axiom(axiom: Axiom):
        free_vars = axiom.pattern.visit(FreePatternVariableVisitor())
        body = axiom.pattern
        body_sort = KoreUtils.infer_sort(body)

        for free_var in free_vars:
            body = MLPattern(MLPattern.FORALL, [body_sort], [ free_var, body ])

        axiom.pattern = body
        axiom.resolve(axiom.get_module())

    """
    Quantify all free (pattern) variables in the axioms
    """
    @staticmethod
    def quantify_all_free_variables(module: Module):
        for axiom in module.axioms:
            KoreUtils.quantify_all_free_variables_in_axiom(axiom)

    @staticmethod
    def unify_sorts(sort1: Sort, sort2: Sort) -> Optional[Mapping[SortVariable, Sort]]:
        if isinstance(sort1, SortVariable):
            return { sort1: sort2 }
        
        if isinstance(sort2, SortVariable):
            return { sort2: sort1 }
        
        assert isinstance(sort1, SortInstance) and \
               isinstance(sort2, SortInstance)
        
        if sort1.definition != sort2.definition:
            return None

        if len(sort1.arguments) != len(sort2.arguments):
            return None

        substitution = {}
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
            assert len(sort_arguments) == len(symbol_def.sort_variables)

            substitution = { var: arg for var, arg in zip(symbol_def.sort_variables, sort_arguments) }
            return KoreUtils.copy_and_substitute_sort(symbol_def.output_sort, substitution)

        if isinstance(pattern, MLPattern):
            # NOTE: as a convention, the last sort in the sort arguments is the output sort
            return pattern.sorts[-1]

        assert False, "unable to get the sort of pattern `{}`".format(pattern)

    """
    Remove all universal quantifiers
    """
    @staticmethod
    def strip_forall(pattern: Pattern) -> Pattern:
        while isinstance(pattern, MLPattern) and pattern.construct == MLPattern.FORALL:
            pattern = pattern.arguments[1]
        return pattern
