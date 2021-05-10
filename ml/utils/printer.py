from typing import TextIO, Generator

from contextlib import contextmanager


class Printer:
    """
    Base class for an printer
    """
    def __init__(self, output: TextIO, tab: str = "  "):
        super().__init__()
        self.depth = 0
        self.output = output
        self.tab = tab
        self.line_buffer = ""

    def indent(self) -> None:
        self.depth += 1

    def deindent(self) -> None:
        assert self.depth != 0, "cannot de-indent further"
        self.depth -= 1

    @contextmanager
    def indentation(self) -> Generator[None, None, None]:
        self.indent()
        yield
        self.deindent()

    def flush(self) -> None:
        self.output.write(self.line_buffer.rstrip())
        self.line_buffer = ""

    def write(self, msg: str) -> None:
        tab = self.depth * self.tab
        lines = msg.split("\n")

        for i, line in enumerate(lines):
            if i != 0:
                self.flush()
                self.output.write("\n")

            if self.line_buffer.strip() == "" and \
               not self.line_buffer.startswith(tab) and \
               line.strip() != "":
                self.line_buffer = tab

            self.line_buffer += line
