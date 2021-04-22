from typing import Generic, TypeVar

from .ast import BaseAST

T = TypeVar("T", bound=BaseAST)


class KoreSugarer(Generic[T]):
    """
    A Sugarer implements two methods:
    - sugar: BaseAST -> BaseAST
    - desugar: BaseAST -> BaseAST

    An implementation of it usually
    implements classes extending Pattern
    e.g. KoreMap
    """
    def sugar(self, ast: T) -> T:
        raise NotImplementedError()

    def desugar(self, ast: T) -> T:
        raise NotImplementedError()
