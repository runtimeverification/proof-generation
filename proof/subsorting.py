from typing import Mapping, Set, List, Tuple, Optional

from .kore import ast as kore

from .metamath.composer import Theorem


"""
A data structure that stores the subsort
relation (a strict partial order)
"""
class SubsortRelation:
    def __init__(self):
        self.adj_list: \
            Mapping[kore.SortInstance, List[Tuple[kore.SortInstance, Theorem]]] = {}
        # SortInstance -> [ ( supersort, subsorting lemma ) ... ]

    def is_subsort(self, sort1: kore.SortInstance, sort2: kore.SortInstance) -> Optional[Theorem]:
        if sort1 == sort2: return True
        if sort1 not in self.adj_list: return False
        if sort2 in self.adj_list[sort1]: return True

        for intermediate in self.adj_list[sort1]:
            if self.is_subsort(intermediate, sort2):
                raise NotImplementedError("non-immediate subsorting not supported")
                # TODO: use injection lemma to chain subsorts

        return False

    """
    Add sort1 < sort2
    """
    def add_subsort(self, sort1: kore.SortInstance, sort2: kore.SortInstance, subsort_axiom: Theorem):
        assert sort1 != sort2, f"subsort relation should be irreflexive: {sort1} </ {sort2}"
        assert not self.is_subsort(sort2, sort1), f"cyclic subsorting: {sort1} ? {sort2}"

        if sort1 not in self.adj_list:
            self.adj_list[sort1] = []
        self.adj_list[sort1].append((sort2, subsort_axiom))

    def __str__(self):
        return "\n".join([
            "{} < {}".format(sort, ", ".join([ str(supersort) for supersort, _ in supersorts ]))
            for sort, supersorts in self.adj_list.items()
        ])
