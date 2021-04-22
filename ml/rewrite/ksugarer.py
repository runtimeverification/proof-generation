from typing import List, Tuple, Any

import ml.kore.ast as kore

from ml.kore.visitors import KoreVisitor, PatternOnlyVisitorStructure
from ml.kore.sugarer import KoreSugarer
"""
Some extension of the Kore AST
"""


class PatternSugar(kore.Pattern):
    def __init__(self, module: kore.Module):
        super().__init__()
        super().resolve(module)

    def desugar(self) -> kore.Pattern:
        raise NotImplementedError()

    def absorb(self, pattern: kore.Pattern):
        raise NotImplementedError()

    def __str__(self) -> str:
        return str(KPatternSugarer.desugar(self))

    def visit(self, visitor: kore.KoreVisitor) -> Any:
        desugared = self.desugar()
        result = desugared.visit(visitor)
        # absorb any in-place changes
        self.absorb(desugared)

        # TODO: if the result is some
        # container containing Pattern
        # then this would not work
        if isinstance(result, kore.Pattern):
            return KPatternSugarer.sugar(result)

        return result


class KMapItem(PatternSugar):
    MAPSTO_SYMBOL = "Lbl'UndsPipe'-'-GT-Unds'"

    def __init__(self, module: kore.Pattern, key: kore.Pattern, value: kore.Pattern):
        super().__init__(module)
        self.key = key
        self.value = value

    def desugar(self) -> kore.Pattern:
        mapsto_pattern = kore.Application(
            kore.SymbolInstance(KMapItem.MAPSTO_SYMBOL, []),
            [self.key, self.value],
        )
        mapsto_pattern.resolve(self.get_module())
        return mapsto_pattern

    def absort(self, pattern: kore.Pattern):
        assert isinstance(pattern, kore.Application) and \
               pattern.symbol.get_symbol_name() == KMapItem.MAPSTO_SYMBOL and \
               len(pattern.arguments) == 2

        self.key = pattern.arguments[0]
        self.value = pattern.arguments[1]


class KPatternSugarer(KoreVisitor, PatternOnlyVisitorStructure, KoreSugarer[kore.Pattern]):
    def postvisit_application(self, application: kore.Application) -> kore.Pattern:
        symbol_name = application.symbol.get_symbol_name()

        if symbol_name == KMapItem.MAPSTO_SYMBOL:
            assert len(application.arguments) == 2
            return KMapItem(application.get_module(), application.arguments[0], application.arguments[1])

        return application

    def sugar(self, pattern: kore.Pattern) -> kore.Pattern:
        return self.visit(pattern)

    def desugar(self, pattern: kore.Pattern) -> kore.Pattern:
        pass
