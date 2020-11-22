from __future__ import annotations

from typing import Mapping, List, Tuple, Optional, NewType

from .ast import *
from .visitors import PatternSubstitutionVisitor, SortSubstitutionVisitor, CopyVisitor, FreePatternVariableVisitor


PatternPath = NewType("PatternPath", List[int])


"""
Utility functions on KORE AST
"""
class KoreUtils:
    @staticmethod
    def get_subpattern_by_path(pattern: Pattern, path: PatternPath) -> Pattern:
        if len(path) == 0: return pattern

        assert isinstance(pattern, Application) or isinstance(pattern, MLPattern), \
               "path {} does not exists in pattern {}".format(path, pattern)

        first, *rest = path
        assert first < len(pattern.arguments), "path {} does not exists in pattern {}".format(path, pattern)

        if len(rest):
            return KoreUtils.get_subpattern_by_path(pattern.arguments[first], rest)
        else:
            return pattern.arguments[first]

    """
    path: path to a subpattern
    e.g. in a(b(), c(phi)),
    phi would have the path [ 1, 0 ]
    """
    @staticmethod
    def replace_path_by_pattern(pattern: Pattern, path: PatternPath, replacement: Pattern):
        assert len(path), "empty path"
        assert isinstance(pattern, Application) or isinstance(pattern, MLPattern), \
               "path {} does not exists in pattern {}".format(path, pattern)

        first, *rest = path

        # Application and MLPattern all use .arguments for the list of arguments

        assert first < len(pattern.arguments), "path {} does not exists in pattern {}".format(path, pattern)

        if len(rest):
            KoreUtils.replace_path_by_pattern(pattern.arguments[first], rest, replacement)
        else:
            # do the actual replacement
            pattern.arguments[first] = replacement

    @staticmethod
    def copy_and_replace_path_by_pattern(module: Module, pattern: Pattern, path: PatternPath, replacement: Pattern) -> Pattern:
        copied = KoreUtils.copy_pattern(module, pattern)
        KoreUtils.replace_path_by_pattern(copied, path, replacement)
        return copied

    @staticmethod
    def copy_pattern(module: Module, pattern: Pattern) -> Pattern:
        copied_pattern = pattern.visit(CopyVisitor())
        copied_pattern.resolve(module)
        return copied_pattern

    @staticmethod
    def copy_and_substitute_pattern(module: Module, pattern: Pattern, substitution: Mapping[Variable, Pattern]) -> Pattern:
        copied = KoreUtils.copy_pattern(module, pattern)
        return copied.visit(PatternSubstitutionVisitor(substitution))

    @staticmethod
    def copy_sort(module: Module, sort: Sort) -> Sort:
        copied_sort = sort.visit(CopyVisitor())
        copied_sort.resolve(module)
        return copied_sort

    @staticmethod
    def copy_and_substitute_sort(module: Module, sort: Pattern, substitution: Mapping[SortVariable, Sort]) -> Sort:
        copied = KoreUtils.copy_sort(module, sort)
        return copied.visit(SortSubstitutionVisitor(substitution))

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
        
        copied_rhs = KoreUtils.copy_pattern(alias_def.get_parent(), alias_def.rhs)
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
    def quantify_all_free_variables_in_axiom(module: Module, axiom: Axiom):
        free_vars = axiom.pattern.visit(FreePatternVariableVisitor())
        body = axiom.pattern
        body_sort = KoreUtils.get_sort(module, body)

        for free_var in free_vars:
            body = MLPattern(MLPattern.FORALL, [body_sort], [ free_var, body ])

        axiom.pattern = body

    """
    Quantify all free (pattern) variables in the axioms
    """
    @staticmethod
    def quantify_all_free_variables(module: Module):
        for axiom in module.axioms:
            KoreUtils.quantify_all_free_variables_in_axiom(module, axiom)

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
    def get_sort(module: Module, pattern: Pattern) -> Sort:
        if isinstance(pattern, Variable):
            return pattern.sort

        if isinstance(pattern, Application):
            # NOTE: assuming the application has been resolved
            symbol_def = pattern.symbol.definition
            sort_arguments = pattern.symbol.sort_arguments
            assert len(sort_arguments) == len(symbol_def.sort_variables)

            substitution = { var: arg for var, arg in zip(symbol_def.sort_variables, sort_arguments) }
            return KoreUtils.copy_and_substitute_sort(module, symbol_def.output_sort, substitution)

        if isinstance(pattern, MLPattern):
            # NOTE: as a convention, the first sort in the sort arguments is the output sort
            return pattern.sorts[0]

        assert False, "unable to get the sort of pattern `{}`".format(pattern)

    """
    Remove all universal quantifiers
    """
    @staticmethod
    def strip_forall(pattern: Pattern) -> Pattern:
        while isinstance(pattern, MLPattern) and pattern.construct == MLPattern.FORALL:
            pattern = pattern.arguments[1]
        return pattern
