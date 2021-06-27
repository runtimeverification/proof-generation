from __future__ import annotations

from typing import Tuple, Dict, Optional, TextIO, Any
from dataclasses import dataclass
from abc import ABC, abstractmethod

import os
import lzma

from .ast import Statement, Encoder, IncludeStatement

SegmentLabel = Optional[str]
DEFAULT_SEGMENT = None


class Backend(ABC):
    """
    A backend determines how to handle the output statements
    For instance, we could:
      - save the statement in some files
      - discard everything
      - verify the proofs in runtime and then discard them
    """
    @abstractmethod
    def dump_statement(self, segment: SegmentLabel, statement: Statement) -> None:
        ...


class NullBackend(Backend):
    """
    Discards all statements
    """
    def dump_statement(self, segment: SegmentLabel, statement: Statement) -> None:
        return None


class StandaloneFileBackend(Backend):
    """
    Store everything (including the prelude file)
    to a standalone output file
    """
    def __init__(self, path: str, compression: bool = False):
        self.path = path
        self.compression = compression

        # assert not os.path.exists(path), f"file {path} already exists"

        if compression:
            self.file_handle: TextIO = lzma.open(path, "wt")
        else:
            self.file_handle = open(path, "w")

    def __enter__(self) -> StandaloneFileBackend:
        return self

    def __exit__(self, *args: Any) -> None:
        self.close()

    def dump_statement(self, segment: SegmentLabel, statement: Statement) -> None:
        Encoder.encode(self.file_handle, statement)
        self.file_handle.write("\n")

    def close(self) -> None:
        self.file_handle.close()


class MultipleFileBackend(Backend):
    """
    A backend that outputs the proof to multiple
    files. It stores a DAG for dependencies between the
    output Metamath files
    """
    @dataclass
    class Node:
        full_path: str  # e.g. database.mm
        file_handle: TextIO
        dependencies: Tuple[str, ...]

    def __init__(self, path: str, graph: Tuple[Tuple[SegmentLabel, Optional[str], Tuple[str, ...]], ...]):
        """
        format of graph: ( (segment label, file_name, (... dependencies on other labels)), ... )
        """

        self.path = path
        self.graph: Dict[SegmentLabel, Optional[MultipleFileBackend.Node]] = {}

        if not os.path.exists(self.path):
            os.mkdir(self.path)
        else:
            assert os.path.isdir(self.path)

        for label, file_name, dependencies in graph:
            if file_name is None:
                self.graph[label] = None
                continue

            full_path = os.path.realpath(os.path.join(self.path, file_name))
            file_handle = open(full_path, "w")
            node = MultipleFileBackend.Node(full_path, file_handle, dependencies)
            self.graph[label] = node

        self.write_headers()

    def __enter__(self) -> MultipleFileBackend:
        return self

    def __exit__(self, *args: Any) -> None:
        self.close()

    def write_headers(self) -> None:
        for label, node in self.graph.items():
            if node is None:
                continue

            # write dependencies as include statements
            for dep_label in node.dependencies:
                if dep_label in self.graph:
                    dep_node = self.graph[dep_label]
                    assert dep_node is not None
                    include = IncludeStatement(dep_node.full_path)
                else:
                    include = IncludeStatement(dep_label)

                self.dump_statement(label, include)

    def dump_statement(self, segment: SegmentLabel, statement: Statement) -> None:
        assert segment in self.graph, f"segment '{segment}' does not exist"

        node = self.graph[segment]
        if node is None:
            return

        stream = node.file_handle
        Encoder.encode(stream, statement)
        stream.write("\n")

    def close(self) -> None:
        for node in self.graph.values():
            if node is not None:
                node.file_handle.close()
        self.graph = {}
