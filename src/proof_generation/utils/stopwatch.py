from __future__ import annotations

import time
from contextlib import contextmanager
from dataclasses import dataclass, field
from typing import TYPE_CHECKING

if TYPE_CHECKING:
    from collections.abc import Generator


@dataclass
class Stopwatch:
    records: dict[str, float] = field(default_factory=lambda: {})  # label -> elapsed in seconds

    @contextmanager
    def start(self, label: str) -> Generator[None, None, None]:
        assert label not in self.records, f"duplicated record '{label}'"
        start = time.time()
        try:
            yield
        finally:
            end = time.time()
            self.records[label] = end - start

    @contextmanager
    def increment(self, label: str) -> Generator[None, None, None]:
        """
        Add additional run time on an existing label
        """
        start = time.time()
        try:
            yield
        finally:
            end = time.time()
            if label not in self.records:
                self.records[label] = 0.0
            self.records[label] += end - start

    def get_elapsed(self, label: str) -> float:
        assert label in self.records, f"label '{label}' does not exist"
        return self.records[label]
