from __future__ import annotations

from contextlib import contextmanager
from typing import TYPE_CHECKING

if TYPE_CHECKING:
    from collections.abc import Generator
    from typing import TextIO


class Printer:
    """
    Base class for an printer
    """

    def __init__(self, output: TextIO, tab: str = '  '):
        super().__init__()
        self.output = output
        self.tab = tab
        self.current_indentation = ''
        self.line_buffer: list[str] = []

    def indent(self) -> None:
        self.current_indentation += self.tab

    def deindent(self) -> None:
        assert len(self.current_indentation) >= len(self.tab), 'cannot de-indent further'
        self.current_indentation = self.current_indentation[: -len(self.tab)]

    @contextmanager
    def indentation(self) -> Generator[None, None, None]:
        self.indent()
        yield
        self.deindent()

    def flush(self) -> None:
        for i, s in enumerate(self.line_buffer):
            if i == len(self.line_buffer) - 1:
                s = s.rstrip()
            self.output.write(s)
        self.line_buffer = []

    def is_line_buffer_empty(self) -> bool:
        for s in self.line_buffer:
            if len(s) != 0 and not s.isspace() and (len(self.tab) == 0 or s != (len(s) // len(self.tab)) * self.tab):
                return False
        return True

    def write(self, msg: str) -> None:
        for i, line in enumerate(msg.split('\n')):
            if i != 0:
                self.flush()
                self.output.write('\n')

            if self.is_line_buffer_empty():
                self.line_buffer = [self.current_indentation]

            self.line_buffer.append(line)
