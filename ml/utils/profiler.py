from typing import Any, Generator

import linecache
from contextlib import contextmanager

try:
    import tracemalloc
    from tracemalloc import Snapshot
except:
    tracemalloc = None  # type: ignore
    Snapshot = Any  # type: ignore


class MemoryProfiler:
    @staticmethod
    def start(num_frames: int = 2) -> None:
        assert tracemalloc is not None, "cannot import module tracemalloc"
        tracemalloc.start(num_frames)

    @staticmethod
    def stop() -> None:
        assert tracemalloc is not None, "cannot import module tracemalloc"
        tracemalloc.stop()

    @staticmethod
    def print_snapshot(snapshot: Snapshot, num_top_stats: int = 10) -> None:
        # modified from the example: https://docs.python.org/3/library/tracemalloc.html#tracemalloc.stop

        snapshot = snapshot.filter_traces(
            (
                tracemalloc.Filter(False, "<frozen importlib._bootstrap>"),
                tracemalloc.Filter(False, "<unknown>"),
            )
        )
        top_stats = snapshot.statistics("traceback")

        total = sum(stat.size for stat in top_stats)
        print(f"### Total allocated size: {round(total / 1024, 1)} KiB")

        other = top_stats[num_top_stats:]
        if other:
            size = sum(stat.size for stat in other)
            print(f"### {len(other)} other: {round(size / 1024, 1)} KiB")

        print(f"### Top {num_top_stats} entries")

        for index, stat in enumerate(top_stats[:num_top_stats], 1):
            print(f"### {index}: {round(stat.size / 1024, 1)} KiB")

            for line in stat.traceback.format():
                print(f"  > {line}")

    @staticmethod
    def print_current_snapshot(*args: Any, **kwargs: Any) -> None:
        assert tracemalloc is not None, "cannot import module tracemalloc"
        MemoryProfiler.print_snapshot(tracemalloc.take_snapshot(), *args, **kwargs)

    @staticmethod
    @contextmanager
    def profiler(*args: Any) -> Generator[None, None, None]:
        MemoryProfiler.start(*args)
        try:
            yield
        finally:
            MemoryProfiler.stop()
