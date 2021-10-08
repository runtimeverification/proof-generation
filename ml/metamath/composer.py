from __future__ import annotations

from traceback import print_exc
from contextlib import contextmanager

from typing import List, Tuple, Mapping, Callable, Dict, Sequence, Collection, Set, Union, Any, Optional, Iterable, TextIO, Generator, overload
from dataclasses import dataclass, field

import re

from io import StringIO

from ml.utils.hook import Hookable

from .auto.unification import Unification
import ml.metamath.auto

from .ast import *
from .backend import Backend, NullBackend, SegmentLabel, DEFAULT_SEGMENT
from .utils import MetamathUtils

from typing import TYPE_CHECKING
if TYPE_CHECKING:
    from .auto.typecode import TypecodeProver


@dataclass
class Proof:
    """
    A Metamath proof is a DAG with each node being a
    statement label and the number of children
    should be equal to the nmuber of mandatory hypotheses

    This data structure allows both reference to other proofs
    and raw, unparsed proofs to save space
    """

    conclusion: Terms
    """
    a node is either:
      - a label, which can be used for any node in the tree
      - a Proof, which can only be used for non-leaf nodes
      - a list of label, which can only be used for leaf nodes (unparsed Metamath proof format)
    """
    nodes: Tuple[Union[str, Tuple[str, ...]], ...]
    """
    conclusions for each dag
    NOTE: node_to_conclusion[0] == self.internal_conclusions
    """
    node_to_conclusion: Tuple[Terms, ...]
    """
    A proof DAG should have a unique source at 0
    if a node has no out-edges, it MAY NOT have an entry in self.dag
    """
    dag: Dict[int, Tuple[int, ...]]

    @staticmethod
    def from_script(statement: StructuredStatement, script: Union[str, Iterable[str]]) -> Proof:
        """
        Make a proof from the normal proof format as a list of labels
        """
        return Proof(statement.terms, (script if isinstance(script, str) else tuple(script), ), (statement.terms, ), {})

    @staticmethod
    def from_application(statement: StructuredStatement, root: str, children: Collection[Proof]) -> Proof:
        """
        Combine the proof DAGs
        """

        dag: Dict[int, Tuple[int, ...]] = {}
        nodes: List[Union[str, Tuple[str, ...]]] = [root]
        node_to_conclusion: List[Terms] = [statement.terms]
        children_of_root: List[int] = []

        next_node = 1
        conclusion_to_node: Dict[Terms, int] = {}

        # a greedy algorithm to combine common subproofs
        for subproof in children:
            # add each subproof as a disjoint subtree in the new proof
            prev_num_nodes = next_node
            node_map: Dict[int, int] = {}
            new_conclusion_to_node: Dict[Terms, int] = {}

            # add all nodes in the subproof
            for i, item in enumerate(subproof.nodes):
                item_conclusion = subproof.node_to_conclusion[i]
                shared_node = conclusion_to_node.get(item_conclusion)

                if shared_node is not None:
                    # found a subtree with the same conclusion
                    node_map[i] = shared_node
                else:
                    # subtree with new conclusion
                    node_map[i] = next_node
                    nodes.append(item)
                    node_to_conclusion.append(item_conclusion)
                    new_conclusion_to_node[item_conclusion] = next_node
                    next_node += 1

            # add all edges in the subproof
            for i, neighbors in subproof.dag.items():
                new_node = node_map[i]
                if new_node >= prev_num_nodes:
                    dag[node_map[i]] = tuple(node_map[n] for n in neighbors)

            children_of_root.append(node_map[0])
            conclusion_to_node.update(new_conclusion_to_node)

        if len(children):
            dag[0] = tuple(children_of_root)

        return Proof(statement.terms, tuple(nodes), tuple(node_to_conclusion), dag)

    def as_statement(self, label: str) -> StructuredStatement:
        """
        Encode as a provable statement
        """
        return ProvableStatement(label, self.conclusion, self.encode_normal())

    def as_compressed_statement(self, label: str, context: Context) -> StructuredStatement:
        """
        Same as above but uses compressed proof
        """
        mandatory_labels = context.flatten(StructuredStatement(label, self.conclusion)).get_all_mandatory_labels()
        # print(mandatory_labels)
        script = self.encode_compressed(mandatory_labels)
        return ProvableStatement(label, self.conclusion, script)

    def is_leaf(self, node: int) -> bool:
        return node not in self.dag

    def get_children_of(self, node: int) -> Tuple[int, ...]:
        return self.dag.get(node, ())

    def flatten(self, output_script: List[str], root: int = 0) -> None:
        """
        Flatten encodes a recursive hierarchy of proofs
        as the normal Metamath proof format
        """
        for child in self.get_children_of(root):
            self.flatten(output_script, child)

        subproof = self.nodes[root]

        if isinstance(subproof, str):
            output_script.append(subproof)
        else:
            output_script.extend(subproof)

    def is_proof_of(self, statement: StructuredStatement) -> bool:
        return self.conclusion == tuple(statement.terms)

    def __len__(self) -> int:
        size = 0
        for subproof in self.nodes:
            if isinstance(subproof, str):
                size += 1
            else:
                size += len(subproof)
        return size

    def __str__(self) -> str:
        return f"<proof of {' '.join(map(str, self.conclusion))}>"

    @staticmethod
    def encode_index(n: int) -> str:
        """
        Encode an index in the Metamath compressed proof format
        """

        number = n - 1
        final_letter = chr(ord("A") + number % 20)
        if number < 20:
            return final_letter

        number //= 20

        letters = []
        while True:
            number -= 1
            letters.append(chr(ord("U") + ((number % 5))))
            number //= 5
            if not number:
                break

        letters.reverse()
        letters.append(final_letter)
        return "".join(letters)

    @staticmethod
    def compress_script(mandatory: Iterable[str], proof: List[str]) -> str:
        label_to_letter = {"?": "?"}
        mandatory_list = list(mandatory)

        # rank the labels by frequency
        frequency = {}
        for label in proof:
            # ? and mandatory labels are handled differently
            if label == "?" or label in mandatory_list:
                continue

            if label not in frequency:
                frequency[label] = 0

            frequency[label] += 1

        sorted_frequency = sorted(list(frequency.items()), reverse=True, key=lambda t: t[1])
        unique_labels = [label for label, _ in sorted_frequency]

        for i, hyp in enumerate(mandatory_list + unique_labels):
            label_to_letter[hyp] = Proof.encode_index(i + 1)

        labels_str = " ".join(["("] + unique_labels + [")"])
        letters = [label_to_letter[label] for label in proof]
        letters_str = "".join(letters)

        return labels_str + " " + letters_str

    def encode_normal(self) -> str:
        """
        Encode a proof in the normal format (i.e. a list of space-separated labels)
        """
        script: List[str] = []
        self.flatten(script)
        return " ".join(script)

    def encode_compressed(self, mandatory_hypotheses: Iterable[str]) -> str:
        """
        Encode a proof in the compressed format
        This requires some context information, namely the mandatory hypotheses
        of the statement in the order they are defined
        """
        # TODO: share subtrees
        script: List[str] = []
        self.flatten(script)
        return Proof.compress_script(mandatory_hypotheses, script)


class AutoProof:
    """
    A proof generator that's supposed to prove the statement given to it,
    if not, it will raise an error
    """
    def prove(self, composer: Composer, statement: StructuredStatement) -> Proof:
        raise NotImplementedError()


class MethodAutoProof(AutoProof):
    def __init__(self, method: Callable[[Composer, StructuredStatement], Proof]):
        self.method = method

    def prove(self, composer: Composer, statement: StructuredStatement) -> Proof:
        return self.method(composer, statement)


@dataclass
class Theorem:
    """
    A Theorem is any (structured) statement that can be used in a proof
    """
    composer: Composer
    statement: StructuredStatement
    context: TheoremContext = field(default_factory=lambda: TheoremContext())

    def get_metavariables(self) -> Set[str]:
        """
        Get all metavariables that are active
        """
        return set(self.context.get_all_floating_metavariables())

    def get_all_mandatory_labels(self) -> Tuple[str, ...]:
        return self.context.get_all_mandatory_labels()

    def is_meta_substitution_consistent(self, substituted: Union[Proof, Term], term: Term) -> bool:
        if isinstance(substituted, Proof):
            assert len(substituted.conclusion) == 2
            return substituted.conclusion[1] == term
        else:
            return substituted == term

    def get_conclusion_instance(self, substitution: Mapping[str, Term]) -> StructuredStatement:
        return self.statement.substitute(substitution)

    def as_proof(self) -> Proof:
        """
        Treat the theorem itself as a proof of itself, provided
        no essential is needed
        """

        essential_proofs = []

        for essential in self.context.essentials:
            for existing_essentials in self.composer.get_all_essentials():
                if essential.terms == existing_essentials.statement.terms:
                    # apply all essentials as the same statement
                    essential_proofs.append(existing_essentials.statement.label)
                    break
            else:
                assert False, f"unable to prove obligation {essential} from existing hypotheses"

        return Proof.from_script(
            self.statement,
            self.context.get_all_floating_labels() + tuple(essential_proofs) + (self.statement.label, ),
        )

    def match_and_apply(
        self, target: StructuredStatement, *args: Union[Proof, AutoProof], **kwargs: Union[Proof, Term]
    ) -> Proof:
        """
        Unify the theorem statement with a target,
        infer as many metavariables as possible, and
        then call self.apply
        """
        substitution = Unification.match_statements(self.statement, target)
        assert (substitution is not None
                ), "failed to unify the target statement `{}` and the theorem `{}`".format(target, self.statement)

        for lhs, rhs in substitution:
            if not isinstance(lhs, Metavariable):
                continue

            var = lhs.name

            if var in kwargs:
                assert self.is_meta_substitution_consistent(kwargs[var], rhs), (
                    "metavariable assignment to {} is not consistent: "
                    "`{}` and `{}` are both assigned to it".format(var, kwargs[var], rhs)
                )
            else:
                kwargs[var] = rhs

        return self.apply(*args, **kwargs)

    @overload
    def infer_metavariable_substitution(
        self,
        target: Optional[StructuredStatement],
        essential_proofs: Tuple[Union[Proof, AutoProof], ...],
        metavar_substitution: Mapping[str, Term],
    ) -> Mapping[str, Term]:
        ...

    @overload
    def infer_metavariable_substitution(
        self,
        target: Optional[StructuredStatement],
        essential_proofs: Tuple[Union[Proof, AutoProof], ...],
        metavar_substitution: Mapping[str, Union[Proof, Term]],
    ) -> Mapping[str, Union[Proof, Term]]:
        ...

    def infer_metavariable_substitution(
        self,
        target: Optional[StructuredStatement],
        essential_proofs: Tuple[Union[Proof, AutoProof], ...],
        metavar_substitution: Mapping[str, Union[Proof, Term]],
    ) -> Mapping[str, Union[Proof, Term]]:
        """
        Infer the metavariable substitution using the given information
        """
        substitution: Dict[str, Union[Proof, Term]] = dict(metavar_substitution)

        assert len(essential_proofs) == len(self.context.essentials), (
            "unmatched number of subproofs for "
            "essential statements, expecting {}, {} given".format(len(self.context.essentials), len(essential_proofs))
        )

        if target is not None:
            match_substitution = Unification.match_statements(self.statement, target)
            assert match_substitution is not None, \
                   f"failed to unify the target statement `{target}` and the theorem `{self.statement}`"

            for lhs, rhs in match_substitution:
                if not isinstance(lhs, Metavariable):
                    continue

                var = lhs.name

                if var in substitution:
                    assert self.is_meta_substitution_consistent(substitution[var], rhs), \
                           f"metavariable assignment to {var} is not consistent: " \
                           f"`{substitution[var]}` and `{rhs}` are both assigned to it"
                else:
                    substitution[var] = rhs

        # TODO: check proofs for essential statements
        for essential, essential_proof in zip(self.context.essentials, essential_proofs):
            # auto proofs will be resolved later
            if isinstance(essential_proof, AutoProof):
                continue

            assert isinstance(essential_proof, Proof), f"wrong proof {essential_proof} of {essential}"

            solution = Unification.match_lists_of_terms_as_instance(essential.terms, essential_proof.conclusion)
            assert solution is not None, f"`{essential_proof}` is not an instance of `{essential}`"

            # check that the unification solution is consistent with
            # the metavariable assignment
            for var, term in solution.items():
                if var in substitution:
                    assert self.is_meta_substitution_consistent(substitution[var], term), \
                           f"metavariable assignment to {var} is not consistent: " \
                           f"`{substitution[var]}` and `{term}` are both assigned to it"

                else:
                    # update metavar_substitution to reflect this assignment
                    substitution[var] = term

        return substitution

    def infer_hypothesis_proofs(
        self,
        essential_proofs: Tuple[Union[Proof, AutoProof], ...],
        metavar_substitution: Mapping[str, Union[Proof, Term]],
    ) -> Tuple[List[Proof], Mapping[str, Term]]:
        """
        Infer a list of subproofs for the hypotheses from the information given
        """
        metavar_substitution = self.infer_metavariable_substitution(None, essential_proofs, metavar_substitution)
        substitution: Dict[str, Term] = {}
        floating_proofs = []

        for floating in self.context.floatings:
            typecode = floating.typecode
            var = floating.metavariable

            assert var in metavar_substitution, f"assignment to metavariable `{var}` cannot be inferred"

            # this can either be a direct proof,
            # or a term, in which case we will try to
            # prove the typecode for it automatically
            metavar_substituted = metavar_substitution[var]

            if isinstance(metavar_substituted, Term):
                typecode_proof = ml.metamath.auto.typecode.TypecodeProver.prove_typecode(
                    self.composer, typecode, metavar_substituted
                )

                assert typecode_proof is not None, \
                       f"a term `{metavar_substituted}` is given for metavariable `{var}`, " \
                       f"but we couldn't prove that `{typecode} {metavar_substituted}`"
            else:
                # should be a proof
                assert isinstance(metavar_substituted, Proof), f"{metavar_substituted} is not a proof"
                typecode_proof = metavar_substituted

            # check that the proof is in the right form (for floating statements)
            assert len(typecode_proof.conclusion) == 2, \
                   f"wrong proof for `{typecode} {var}`, got {typecode_proof}"

            proved_typecode, proved_term = typecode_proof.conclusion

            assert isinstance(proved_typecode, Application) and \
                   proved_typecode.symbol == typecode, \
                   f"wrong proof for `{typecode} {var}`, got {typecode_proof}"

            substitution[var] = proved_term
            floating_proofs.append(typecode_proof)

        # resolve all auto proof
        final_essential_proofs: List[Proof] = []

        for i, proof in enumerate(essential_proofs):
            if isinstance(proof, Proof):
                final_essential_proofs.append(proof)
            else:
                essential_instance = self.context.essentials[i].substitute(substitution)
                try:
                    final_essential_proofs.append(proof.prove(self.composer, essential_instance))
                except Exception:
                    print_exc()
                    assert (False), f"unable to automatically generate proof for {essential_instance}"

        return floating_proofs + final_essential_proofs, substitution

    def apply(self, *essential_proofs: Union[Proof, AutoProof], **metavar_substitution: Union[Proof, Term]) -> Proof:
        """
        Applies the theorem, given the following arguments:
        - a list of essential proofs, from which we may infer some of
            the metavariables by unification
        - a map from metavariable name -> proof or term (in the latter case we
            will try to prove the typecode automatically)
        """
        subproofs, substitution = self.infer_hypothesis_proofs(essential_proofs, metavar_substitution)
        instance = self.get_conclusion_instance(substitution)

        return Proof.from_application(instance, self.statement.label, subproofs)

    def inline_apply(
        self, proof_of_theorem: Proof, *essential_proofs: Union[Proof, AutoProof], **metavar_substitution: Union[Proof,
                                                                                                                 Term]
    ) -> Proof:
        """
        Instead of explicitly referencing the labeled statement,
        we can inline the proof in some other proof to remove
        the dependency. However, the proof script will be longer
        """
        subproofs, substitution = self.infer_hypothesis_proofs(essential_proofs, metavar_substitution)

        hyp_labels = self.context.get_all_mandatory_labels()
        assert len(subproofs) == len(hyp_labels)
        hyp_proof_map = dict(zip(hyp_labels, subproofs))

        # create an inlined proof
        proof_script: List[str] = []
        proof_of_theorem.flatten(proof_script)

        new_proof_script = []

        for label in proof_script:
            if label in hyp_proof_map:
                script: List[str] = []
                hyp_proof_map[label].flatten(script)
                new_proof_script.extend(script)
            else:
                new_proof_script.append(label)

        instance = self.get_conclusion_instance(substitution)

        # instantiate the hypotheses with actual proofs
        return Proof.from_script(instance, new_proof_script)


class ProofCache:
    """
    Proof cache holds a list of generated proofs
    and their corresponding statements.

    When a new proof is generated, if one passes
    the proof through the `cache` method, it would
    return a proof with the same statement except that:
    - if the proof is already in the cache, return the
        original proof
    - if not, load this proof into the composer as a theorem
        and return a proof using the theorem

    TODO: add cache eviction when the cache map gets too large
    TODO: add heuristics to not cache "small" and "infrequent" proofs
    """

    # When the proof script size exceeds
    # <THEOREM_CACHE_THRESHOLD> * statement size
    # we still cache the proof as a separate theorem
    THEOREM_CACHE_THRESHOLD = 1

    # certain tools (e.g. itp) would need all cache disabled
    DISABLED = False

    def __init__(self, composer: Composer):
        self.composer = composer
        self.cache_map: Dict[str, Dict[Tuple[Term, ...], Proof]] = {}  # label prefix -> (terms -> proof)
        self.label_map: Dict[str, int] = {}  # label prefix -> next index

        self.stat_cache_hit = 0
        self.stat_cache_miss = 0
        self.stat_theorem_cache = 0

    def get_next_label(self, domain: str) -> str:
        """
        Get the next available label with the given prefix
        """
        domain = re.sub(r"[^a-zA-Z0-9_\-.]", "", domain)

        if domain not in self.label_map:
            self.label_map[domain] = 0

        idx = self.label_map[domain]
        self.label_map[domain] += 1
        return f"{domain}-{idx}"

    def lookup(self, domain: str, statement_or_terms: Union[StructuredStatement, Terms]) -> Optional[Proof]:
        """
        Find an existing cached proof by looking up the statement
        """
        if isinstance(statement_or_terms, StructuredStatement):
            terms = statement_or_terms.terms
        else:
            terms = statement_or_terms

        domain_cache = self.cache_map.get(domain, None)
        if domain_cache is None:
            return None

        return domain_cache.get(terms, None)

    def cache(self, domain: str, proof: Proof, no_theorem_cache: bool = False) -> Proof:
        if ProofCache.DISABLED:
            return proof

        terms = proof.conclusion
        cached_proof = self.cache_map.get(domain, {}).get(terms, None)

        # print(self.stat_cache_hit, self.stat_cache_miss, self.stat_theorem_cache)

        if cached_proof is not None:
            self.stat_cache_hit += 1
            assert cached_proof.conclusion == terms
            return cached_proof

        self.stat_cache_miss += 1

        # cache the proof as a theorem
        if not no_theorem_cache and \
           len(proof) > ProofCache.THEOREM_CACHE_THRESHOLD * sum(map(lambda t: t.get_size(), terms)):
            self.stat_theorem_cache += 1

            # do not index the cached statements
            theorem = self.composer.load_proof_as_statement(
                self.get_next_label(domain), proof, index=False, top_level=True
            )
            proof = theorem.as_proof()

        if domain not in self.cache_map:
            self.cache_map[domain] = {}
        self.cache_map[domain][terms] = proof

        return proof


@dataclass
class TheoremContext:
    """
    Theorem context is a flattened snapshot of Context
    """

    floatings: Tuple[FloatingStatement, ...] = ()
    essentials: Tuple[EssentialStatement, ...] = ()
    disjoints: Tuple[DisjointStatement, ...] = ()

    def get_all_floating_labels(self) -> Tuple[str, ...]:
        return tuple(floating.label for floating in self.floatings)

    def get_all_floating_metavariables(self) -> Tuple[str, ...]:
        return tuple(floating.metavariable for floating in self.floatings)

    def get_all_essential_labels(self) -> Tuple[str, ...]:
        return tuple(essential.label for essential in self.essentials)

    def get_all_mandatory_labels(self) -> Tuple[str, ...]:
        return self.get_all_floating_labels() + self.get_all_essential_labels()


@dataclass
class Context:
    """
    A context at a particular in a database,
    which includes active floating, essential, and disjoint statements
    """

    floatings: List[FloatingStatement] = field(default_factory=lambda: [])
    essentials: List[EssentialStatement] = field(default_factory=lambda: [])
    disjoints: List[DisjointStatement] = field(default_factory=lambda: [])
    statements: List[Statement] = field(default_factory=lambda: [])  # all statements in the context
    prev: Optional[Context] = None

    def flatten(self, statement: StructuredStatement) -> TheoremContext:
        """
        Returns a compressed one-layer context,
        including only metavariables used in the essentials
        and a given statement
        """
        essentials = self.get_all_essentials()

        metavariables = statement.get_metavariables()
        for essential in essentials:
            metavariables.update(essential.get_metavariables())

        floatings = self.find_floatings(metavariables)

        return TheoremContext(tuple(floatings), tuple(essentials), tuple(self.get_all_disjoints()))

    def get_top(self) -> Context:
        """
        Get the top level context
        """

        if self.prev is None:
            return self
        else:
            return self.prev.get_top()

    def add_statement(self, stmt: Statement) -> None:
        if isinstance(stmt, FloatingStatement):
            self.add_floating(stmt)
        elif isinstance(stmt, EssentialStatement):
            self.add_essential(stmt)
        elif isinstance(stmt, DisjointStatement):
            self.add_disjoint(stmt)

        self.statements.append(stmt)

    def add_floating(self, floating: FloatingStatement) -> None:
        self.floatings.append(floating)

    def add_essential(self, essential: EssentialStatement) -> None:
        self.essentials.append(essential)

    def add_disjoint(self, disjoint: DisjointStatement) -> None:
        self.disjoints.append(disjoint)

    def find_floatings(self, metavariables: Set[str]) -> List[FloatingStatement]:
        """
        return a fraction of self.metavariables according to the given set
        """
        fraction = [floating for floating in self.floatings if floating.metavariable in metavariables]
        if self.prev is not None:
            return self.prev.find_floatings(metavariables) + fraction
        else:
            return fraction

    def find_floatings_of_typecode(self, expected_typcode: str) -> List[str]:
        """
        return all metavariables of the given typecode
        """
        current = [floating.metavariable for floating in self.floatings if floating.typecode == expected_typcode]
        if self.prev is not None:
            return self.prev.find_floatings_of_typecode(expected_typcode) + current
        else:
            return current

    def get_all_floatings(self) -> List[FloatingStatement]:
        if self.prev is not None:
            return self.prev.get_all_floatings() + self.floatings
        else:
            return self.floatings.copy()

    def get_all_floating_metavariables(self) -> List[str]:
        metavars = [floating.metavariable for floating in self.floatings]
        if self.prev is not None:
            return self.prev.get_all_floating_metavariables() + metavars
        else:
            return metavars

    def find_essential(self, label: str) -> Optional[StructuredStatement]:
        for essential in self.essentials:
            if essential.label == label:
                return essential

        if self.prev is not None:
            return self.prev.find_essential(label)
        else:
            return None

    def get_all_essentials(self) -> List[EssentialStatement]:
        if self.prev is not None:
            return self.prev.get_all_essentials() + self.essentials
        else:
            return self.essentials.copy()

    def get_all_disjoints(self) -> List[DisjointStatement]:
        if self.prev is not None:
            return self.prev.get_all_disjoints() + self.disjoints
        else:
            return self.disjoints.copy()

    def are_metavariables_disjoint(self, metavars: Collection[str]) -> bool:
        """
        Check if a given list of metavariables are disjoint
        """

        distinct_metavars = set(metavars)

        # same metavariable appears more than once
        if len(distinct_metavars) < len(metavars):
            return False

        for disjoint in self.disjoints:
            if distinct_metavars.issubset({var.name for var in disjoint.metavariables}):
                return True

        if self.prev is None:
            return False

        return self.prev.are_metavariables_disjoint(distinct_metavars)


class Composer(Hookable):
    """
    Composer is a utility class used for
    emitting metamath statements and proofs
    """
    def __init__(self, *, backend: Backend = NullBackend()) -> None:
        self.context = Context()  # outermost context for a database
        self.theorems: Dict[str, Theorem] = {}  # label -> Theorem
        self.theorems_by_typecode: Dict[str, List[Theorem]] = {}  # typecode -> [ Theorem ], sorted theorems by typecode
        self.proof_cache = ProofCache(self)

        # mark each statement with a unique "segment label"
        # so that we can selectively encode certain set of
        # statements before others
        # the stack is used so that one can mark a set
        # of setences in another segment and restore the old
        # segment
        self.segment_stack: List[SegmentLabel] = [DEFAULT_SEGMENT]  # a stack of current segments
        self.backend = backend

        self.notation_axiom_graph: Dict[str, Tuple[Theorem, str]] = {}  # symbol -> (theorem, symbol)
        self.notation_congruence: Dict[str, Tuple[Theorem,
                                                  Tuple[int, ...]]] = {}  # symbol -> [ (theorem, order of subterms) ]

        self.substitution_lemmas: Dict[str, Tuple[Theorem,
                                                  Tuple[int, ...]]] = {}  # symbol -> [ (theorem, order of subterms) ]

        self.fresh_lemmas: Dict[str, Tuple[Theorem, Tuple[int, ...]]] = {}  # symbol -> [ (theorem, order of subterms) ]

        self.positive_lemmas: Dict[Tuple[bool, str],
                                   Tuple[Theorem,
                                         Tuple[int, ...]]] = {}  # (sign, symbol) -> [ (theorem, order of subterms) ]

    def find_theorem(self, name: str) -> Optional[Theorem]:
        return self.theorems.get(name)

    def get_theorem(self, name: str) -> Theorem:
        """
        Same as find_theorem but raises an exception if not found
        """
        theorem = self.find_theorem(name)
        assert theorem is not None, f"cannot find theorem {name}"
        return theorem

    def get_theorems_of_typecode(self, typecode: str) -> List[Theorem]:
        return self.theorems_by_typecode.get(typecode, [])

    def remove_theorem(self, name: str) -> None:
        assert name in self.theorems
        theorem = self.theorems[name]

        del self.theorems[name]

        # also delete it from the typecode map
        stmt = theorem.statement
        if (len(stmt.terms) != 0 and isinstance(stmt.terms[0], Application) and len(stmt.terms[0].subterms) == 0
                and stmt.terms[0].symbol in self.theorems_by_typecode):
            for i, theorem in enumerate(self.theorems_by_typecode[stmt.terms[0].symbol]):
                if theorem.statement.label == name:
                    self.theorems_by_typecode[stmt.terms[0].symbol].pop(i)
                    break

        Composer.run_hooks("remove", self, name)

    def add_theorem_for_typecode(self, typecode: str, theorem: Theorem) -> None:
        if typecode not in self.theorems_by_typecode:
            self.theorems_by_typecode[typecode] = []
        self.theorems_by_typecode[typecode].append(theorem)

    def find_essential(self, name: str) -> Optional[Theorem]:
        essential = self.context.find_essential(name)
        if essential:
            return Theorem(self, essential)
        else:
            return None

    def get_all_essentials(self) -> List[Theorem]:
        return [Theorem(self, essential) for essential in self.context.get_all_essentials()]

    def get_all_disjoints(self) -> List[DisjointStatement]:
        return self.context.get_all_disjoints()

    def are_terms_disjoint(self, term1: Term, term2: Term) -> bool:
        """
        Check if the given two terms have disjoint metavariables
        in the current context
        """
        if isinstance(term1, Application):
            for subterm in term1.subterms:
                if not self.are_terms_disjoint(subterm, term2):
                    return False
            return True

        if isinstance(term2, Application):
            for subterm in term2.subterms:
                if not self.are_terms_disjoint(term1, subterm):
                    return False
            return True

        assert isinstance(term1, Metavariable) and isinstance(term2, Metavariable)

        return self.context.are_metavariables_disjoint((term1.name, term2.name))

    def cache_proof(self, *args: Any, **kwargs: Any) -> Proof:
        return self.proof_cache.cache(*args, **kwargs)

    def lookup_proof_cache(self, domain: str, key: Union[StructuredStatement, Terms]) -> Optional[Proof]:
        return self.proof_cache.lookup(domain, key)

    """
    This implements simple segmentation mechanism. To start a segment,
    call start_segment(name). To end a segment, call end_segment.
    To get all statements in a segment, call get_segment
    """

    def start_segment(self, name: str) -> None:
        self.segment_stack.append(name)

    def end_segment(self) -> None:
        self.segment_stack.pop()

    def get_current_segment(self) -> SegmentLabel:
        return self.segment_stack[-1]

    @contextmanager
    def in_segment(self, name: str) -> Generator[None, None, None]:
        self.start_segment(name)
        try:
            yield
        finally:
            self.end_segment()

    def find_metavariable(self, var: str) -> Optional[str]:
        """
        look up a metavariable, if found, return the typecode,
        otherwise, return None
        """
        found = self.context.find_floatings({var})
        if not found:
            return None
        return found[0].typecode

    def find_metavariables_of_typecode(self, typecode: str) -> List[str]:
        """
        find metavariables of the given typecode
        """
        return self.context.find_floatings_of_typecode(typecode)

    def get_all_metavariables(self) -> List[str]:
        return self.context.get_all_floating_metavariables()

    def index_statement(self, stmt: StructuredStatement) -> None:
        """
        Index the statement for more efficient search later
        """
        # index by the typecode
        if (len(stmt.terms) != 0 and isinstance(stmt.terms[0], Application) and len(stmt.terms[0].subterms) == 0):
            self.add_theorem_for_typecode(stmt.terms[0].symbol, self.theorems[stmt.label])

        Composer.run_hooks("index", self, self.theorems[stmt.label])

    def push_context(self) -> None:
        self.context = Context(prev=self.context)

    def pop_context(self) -> None:
        assert self.context.prev is not None
        block = Block(tuple(self.context.statements))
        self.context = self.context.prev
        self.add_statement_at_context(self.context, block)

    @contextmanager
    def new_context(self, top_level: bool = False) -> Generator[None, None, None]:
        if top_level:
            old_context = self.context
            self.context = self.context.get_top()

        self.push_context()
        try:
            yield
        finally:
            self.pop_context()

            if top_level:
                self.context = old_context

    def add_statement_at_context(self, context: Context, statement: Statement) -> None:
        context.add_statement(statement)

        if context.prev is None:
            # write the top level statements to the backend
            self.backend.dump_statement(self.get_current_segment(), statement)
            context.statements = []

    def record_theorem_at_context(self,
                                  context: Context,
                                  statement: Statement,
                                  index: bool = True) -> Optional[Theorem]:
        """
        Create theorem object for a statement if applicable and add it to the theorem dict
        """

        if isinstance(statement, FloatingStatement) or isinstance(statement, EssentialStatement):
            # floating and essential statements do not have free metavariables
            theorem = Theorem(self, statement)
        elif isinstance(statement, ConclusionStatement):
            theorem = Theorem(self, statement, context.flatten(statement))
        else:
            return None

        # add to the theorem dictionary
        if isinstance(statement, FloatingStatement) or isinstance(statement, ConclusionStatement):
            self.theorems[statement.label] = theorem
            if index:
                self.index_statement(statement)

        return theorem

    def load_proof_as_statement(self, label: str, proof: Proof, top_level: bool = False, **kwargs: Any) -> Theorem:
        """
        Convert the proof to a labeled statement and load it into the composer
        """

        if top_level:
            context = self.context.get_top()
        else:
            context = self.context
        stmt = proof.as_compressed_statement(label, context)
        return self.load(stmt, top_level=top_level, **kwargs)

    @overload
    def load(self, ast: StructuredStatement, **kwargs: Any) -> Theorem:
        ...

    @overload
    def load(
        self, ast: Union[Database, Block, ConstantStatement, VariableStatement, DisjointStatement], **kwargs: Any
    ) -> None:
        ...

    @overload
    def load(self, ast: Statement, **kwargs: Any) -> Optional[Theorem]:
        ...

    def load(
        self,
        ast: Union[Database, Statement],
        *,
        index: bool = True,
        stop_at: Optional[str] = None,
        top_level: bool = False,
        **kwargs: Any,  # a placeholder to make overload typing easier
    ) -> Optional[Theorem]:
        """
        Add a structured statement/block/database to the composer
        Optionally return a theorem corresponding to the given statement

        When stop_at is specified, the loading procedure will stop
        after a statement with label stop_at is loaded.
        In particular, the Context will also stay at the given point

        Parameters:
        index: index theorems by their typecode for faster lookup
        stop_at: stop lodaing when a specific label is encounter, and keep the context right at the point
        top_level: add the given statement (which cannot be a block) at the top level before any unfinished block
        """

        if top_level:
            assert stop_at is None, "cannot set top_level and stop_at at the same time"
            assert not isinstance(ast, Block), \
                   "cannot load a block directly at the top level"

        if isinstance(ast, Database):
            assert self.context.prev is None, "loading a database at non-top level"
            for statement in ast.statements:
                theorem = self.load(statement, index=index, stop_at=stop_at)
                if theorem is not None and theorem.statement.label == stop_at:
                    return theorem
            return None

        elif isinstance(ast, Block):
            self.push_context()
            for statement in ast.statements:
                theorem = self.load(statement, index=index, stop_at=stop_at)
                if theorem is not None and theorem.statement.label == stop_at:
                    return theorem
            self.pop_context()
            return None

        else:
            stmt = ast
            assert isinstance(stmt, Statement)

            # get the indicated context: current or top level
            if top_level or isinstance(stmt, VariableStatement) or isinstance(stmt, ConstantStatement):
                context = self.context.get_top()
            else:
                context = self.context

            self.add_statement_at_context(context, stmt)

            return self.record_theorem_at_context(context, stmt, index=index)
