from __future__ import annotations

from traceback import print_exc

from typing import List, Tuple, Mapping, Callable, Dict, Sequence, Collection, Set, Union, Any, Optional, Iterable, TextIO
from dataclasses import dataclass, field

import re

from io import StringIO

from .auto.unification import Unification

from .ast import *


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


class Theorem:
    """
    A Theorem is any (structured) statement that can be used in a proof
    """
    def __init__(
        self,
        composer: Composer,
        context: Context,
        statement: StructuredStatement,
    ):
        self.composer = composer
        self.context = context
        self.statement = statement

    def get_metavariables(self) -> Set[str]:
        """
        Get all metavariables that are active
        """
        return set(self.context.get_all_floating_metavariables())

    def get_mandatory_hypothesis_labels(self) -> List[str]:
        labels = self.context.get_all_floating_labels()

        for essential in self.context.essentials:
            assert essential.label is not None
            labels.append(essential.label)

        return labels

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
        assert len(self.context.essentials) == 0
        script = self.context.get_all_floating_labels()
        script.append(self.statement.label)
        return Proof.from_script(self.statement, script)

    def match_and_apply(self, target: StructuredStatement, *args: Union[Proof, AutoProof], **kwargs: Union[Proof, Term]) -> Proof:
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

    def infer_hypotheses(self, *essential_proofs: Union[Proof, AutoProof],
                         **metavar_substitution: Union[Proof, Term]) -> Tuple[List[Proof], Mapping[str, Term]]:
        """
        Infer a list of subproofs for the hypotheses from the information given
        """
        substitution = {}
        floating_proofs = []

        assert len(essential_proofs) == len(self.context.essentials), (
            "unmatched number of subproofs for "
            "essential statements, expecting {}, {} given".format(len(self.context.essentials), len(essential_proofs))
        )

        # TODO: check proofs for essential statements
        for i, (essential, essential_proof) in enumerate(zip(self.context.essentials, essential_proofs)):
            # auto proofs will be resolved later
            if isinstance(essential_proof, AutoProof):
                continue

            assert isinstance(essential_proof, Proof), f"wrong proof {essential_proof} of {essential}"

            solution = Unification.match_lists_of_terms_as_instance(essential.terms, essential_proof.conclusion)
            assert solution is not None, "`{}` is not an instance of `{}`".format(essential_proof, essential)

            # check that the unification solution is consistent with
            # the metavariable assignment
            for var, term in solution.items():
                if var in metavar_substitution:
                    assert self.is_meta_substitution_consistent(metavar_substitution[var], term), (
                        "metavariable assignment to {} is not consistent: "
                        "`{}` and `{}` are both assigned to it".format(var, metavar_substitution[var], term)
                    )
                else:
                    # update metavar_substitution to reflect this assignment
                    metavar_substitution[var] = term

        for floating in self.context.floatings:
            typecode = floating.typecode
            var = floating.metavariable

            assert (var in metavar_substitution), "assignment to metavariable `{}` cannot be inferred".format(var)

            # this can either be a direct proof,
            # or a term, in which case we will try to
            # prove the typecode for it automatically
            metavar_substituted = metavar_substitution[var]

            if isinstance(metavar_substituted, Term):
                typecode_proof = TypecodeProver.prove_typecode(self.composer, typecode, metavar_substituted)

                assert typecode_proof is not None, (
                    "a term `{}` is given for metavariable `{}`, "
                    "but we couldn't prove that `{} {}`".format(
                        metavar_substituted, var, typecode, metavar_substituted
                    )
                )
            else:
                # should be a proof
                assert isinstance(metavar_substituted, Proof), f"{metavar_substituted} is not a proof"
                typecode_proof = metavar_substituted

            # check that the proof is in the right form (for floating statements)
            assert (len(typecode_proof.conclusion
                        ) == 2), "wrong proof for `{} {}`, got {}".format(typecode, var, typecode_proof)

            proved_typecode, proved_term = typecode_proof.conclusion

            assert (isinstance(proved_typecode, Application) and proved_typecode.symbol
                    == typecode), "wrong proof for `{} {}`, got {}".format(typecode, var, typecode_proof)

            substitution[var] = proved_term
            floating_proofs.append(typecode_proof)

        # resolve auto proofs
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
        subproofs, substitution = self.infer_hypotheses(*essential_proofs, **metavar_substitution)
        instance = self.get_conclusion_instance(substitution)

        return Proof.from_application(instance, self.statement.label, subproofs)

    def inline_apply(self, proof_of_theorem: Proof, *essential_proofs: Union[Proof, AutoProof], **metavar_substitution: Union[Proof, Term]) -> Proof:
        """
        Instead of explicitly referencing the labeled statement,
        we can inline the proof in some other proof to remove
        the dependency. However, the proof script will be longer
        """
        subproofs, substitution = self.infer_hypotheses(*essential_proofs, **metavar_substitution)

        hyp_labels = self.context.get_all_floating_labels() + \
                     [ essential.label for essential in self.context.essentials ]
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

    # if the proof script size exceeds this
    # number of labels, the proof will be cached
    # as a theorem in the database
    THEOREM_CACHE_THRESHOLD = 10

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
        if (not no_theorem_cache and len(proof) > ProofCache.THEOREM_CACHE_THRESHOLD):
            self.stat_theorem_cache += 1

            theorem_statement = proof.as_statement(self.get_next_label(domain))

            # do not index the cached statements
            theorem = self.composer.load_theorem(theorem_statement, index=False)
            proof = theorem.as_proof()

        if domain not in self.cache_map:
            self.cache_map[domain] = {}
        self.cache_map[domain][terms] = proof

        return proof


@dataclass
class Context:
    """
    A context at a particular in a database,
    which includes active floating, essential, and disjoint statements
    """
    
    floatings: List[FloatingStatement] = field(default_factory=lambda: [])
    essentials: List[EssentialStatement] = field(default_factory=lambda: [])
    disjoints: List[DisjointStatement] = field(default_factory=lambda: [])
    prev: Optional[Context] = None

    def flatten(self, statement: StructuredStatement) -> Context:
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

        return Context(floatings, essentials, self.get_all_disjoints())

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

    def get_all_floating_labels(self) -> List[str]:
        labels = [ floating.label for floating in self.floatings ]
        if self.prev is not None:
            return self.prev.get_all_floating_labels() + labels
        else:
            return labels

    def get_all_floating_metavariables(self) -> List[str]:
        metavars = [ floating.metavariable for floating in self.floatings ]
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

    def get_all_essential_labels(self) -> List[str]:
        labels = [ essential.label for essential in self.essentials ]
        if self.prev is not None:
            return self.prev.get_all_essential_labels() + labels
        else:
            return labels

    def get_all_mandatory_hypotheses_labels(self) -> List[str]:
        return self.get_all_floating_labels() + self.get_all_essential_labels()

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
            if distinct_metavars.issubset(set(disjoint.metavariables)):
                return True

        if self.prev is None:
            return False

        return self.prev.are_metavariables_disjoint(distinct_metavars)


class Composer:
    """
    Composer is a utility class used for
    emitting metamath statements and proofs
    """
    def __init__(self) -> None:
        self.context = Context()  # outermost context for a database
        self.theorems: Dict[str, Theorem] = {}  # label -> Theorem
        self.theorems_by_typecode: Dict[str, List[Theorem]] = {}  # typecode -> [ Theorem ], sorted theorems by typecode
        self.statements: List[Statement] = []  # all statements at the top level
        self.proof_cache = ProofCache(self)

        # mark each statement with a unique "segment label"
        # so that we can selectively encode certain set of
        # statements before others
        # the stack is used so that one can mark a set
        # of setences in another segment and restore the old
        # segment
        self.segment_stack: List[str] = []  # a stack of current segments
        self.segments: Dict[str, List[int]] = {}  # name -> [indices]

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

    def add_theorem_for_typecode(self, typecode: str, theorem: Theorem) -> None:
        if typecode not in self.theorems_by_typecode:
            self.theorems_by_typecode[typecode] = []
        self.theorems_by_typecode[typecode].append(theorem)

    def find_essential(self, name: str) -> Optional[Theorem]:
        essential = self.context.find_essential(name)
        if essential:
            return Theorem(self, Context(), essential)
        else:
            return None

    def get_all_essentials(self) -> List[Theorem]:
        return [Theorem(self, Context(), essential) for essential in self.context.get_all_essentials()]

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

        return self.context.are_metavariables_disjoint({term1.name, term2.name})

    def encode(self, stream: TextIO, segment: Optional[str] = None, **args: Any) -> None:
        statements = self.statements if segment is None else self.get_segment(segment)
        Encoder.encode(self, stream, Database(tuple(statements)), **args)

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

    def get_segment(self, name: str) -> List[Statement]:
        if name not in self.segments:
            return []
        return [self.statements[i] for i in self.segments[name]]

    def add_indices_to_current_segment(self, indices: List[int]) -> None:
        if len(self.segment_stack) == 0:
            return

        name = self.segment_stack[-1]

        if name not in self.segments:
            self.segments[name] = []
        self.segments[name] += indices

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

    def load_theorem(self, statement: StructuredStatement, index: bool = True) -> Theorem:
        theorem = self.load(statement, index)
        assert theorem is not None, f"expecting statement {statement} to be a theorem"
        return theorem

    def load(
        self,
        database_or_statement: Union[Database, Statement],
        index: bool = True,
        stop_at: Optional[str] = None
    ) -> Optional[Theorem]:
        """
        Add a structured statement/block/database to the composer
        Optionally return a theorem corresponding to the given statement

        When stop_at is specified, the loading procedure will stop
        after a statement with label stop_at is loaded.
        In particular, the Context will also stay at the given point
        """
        if isinstance(database_or_statement, Database):
            assert self.context.prev is None, "loading a database at non-top level"
            for statement in database_or_statement.statements:
                theorem = self.load(statement, index, stop_at)
                if theorem is not None and stop_at is not None and theorem.statement.label == stop_at:
                    return theorem

            return None
        elif isinstance(database_or_statement, Statement):
            if self.context.prev is None:
                # add top level statements
                self.add_indices_to_current_segment([len(self.statements)])
                self.statements.append(database_or_statement)

            if isinstance(database_or_statement, Block):
                prev_context = self.context
                self.context = Context(prev=self.context)

                for statement in database_or_statement.statements:
                    theorem = self.load(statement, index, stop_at)
                    if theorem is not None and stop_at is not None and theorem.statement.label == stop_at:
                        return theorem

                self.context = prev_context
                return None
            else:
                return self.load_statement(database_or_statement, index)

        else:
            assert False, f"unable to load {database_or_statement}"

    def load_statement(self, stmt: Statement, index: bool = True) -> Optional[Theorem]:
        if not isinstance(stmt, StructuredStatement):
            return None

        theorem = None

        if isinstance(stmt, FloatingStatement):
            self.context.add_floating(stmt)
        elif isinstance(stmt, EssentialStatement):
            self.context.add_essential(stmt)
        elif isinstance(stmt, DisjointStatement):
            self.context.add_disjoint(stmt)

        if isinstance(stmt, FloatingStatement):
            self.theorems[stmt.label] = theorem = Theorem(self, Context(), stmt)
            if index:
                self.index_statement(stmt)

        elif isinstance(stmt, EssentialStatement):
            theorem = Theorem(self, Context(), stmt)

        elif isinstance(stmt, ConclusionStatement):
            self.theorems[stmt.label] = theorem = Theorem(self, self.context.flatten(stmt), stmt)
            if index:
                self.index_statement(stmt)        

        return theorem


class TypecodeProver:
    @staticmethod
    def check_typecode(
        composer: Composer,
        typecode: str,
        term: Term,
        # allow extra typecode check
        extension: Optional[Callable[[str, Term], bool]] = None,
    ) -> bool:
        """
        Check if the term can be proven to have the given typecode,
        without producing any proof
        """
        # try to find a matching floating statement first if the term is a metavariable
        if isinstance(term, Metavariable):
            for theorem in composer.get_theorems_of_typecode(typecode):
                if isinstance(theorem.statement, FloatingStatement):
                    _, metavar = theorem.statement.terms
                    assert isinstance(metavar, Metavariable)

                    if metavar.name == term.name:
                        return True
            # otherwise treat the metavariable as a term

        # try to find a non-floating statement without hypotheses and unify
        for theorem in composer.get_theorems_of_typecode(typecode):
            if (len(theorem.context.essentials) <= 1 and not isinstance(theorem.statement, FloatingStatement)
                    and len(theorem.statement.terms) == 2):
                # check that expected_statement is an instance of theorem.statement
                solution = Unification.match_terms_as_instance(theorem.statement.terms[1], term)
                if solution is None:
                    continue

                for floating in theorem.context.floatings:
                    if not TypecodeProver.check_typecode(composer, floating.typecode, solution[floating.metavariable],
                                                         extension=extension):
                        break
                else:
                    return True

        if extension is not None:
            return extension(typecode, term)

        return False

    @staticmethod
    def prove_typecode(composer: Composer, typecode: str, term: Term) -> Optional[Proof]:
        """
        Try to prove a statement of the form
        <typecode> <term>
        by recursively unify the target with a theorem of this form
        """

        # TODO: these checks are a bit too specialized
        if (typecode == "#Variable" or typecode == "#ElementVariable"
                or typecode == "#SetVariable") and not isinstance(term, Metavariable):
            return None

        if typecode == "#Symbol" and (not isinstance(term, Application) or len(term.subterms) != 0):
            return None

        expected_statement = ProvableStatement("", (Application(typecode), term))

        cached_proof = composer.lookup_proof_cache("typecode-cache-" + typecode, expected_statement.terms)
        if cached_proof is not None:
            return cached_proof

        # try to find a matching floating statement first if the term is a metavariable
        if isinstance(term, Metavariable):
            for theorem in composer.get_theorems_of_typecode(typecode):
                if isinstance(theorem.statement, FloatingStatement):
                    _, metavar = theorem.statement.terms
                    assert isinstance(metavar, Metavariable)

                    if metavar.name == term.name:
                        # found a direct proof
                        proof = Proof.from_script(expected_statement, theorem.statement.label)
                        return composer.cache_proof("typecode-cache-" + typecode, proof)
            # otherwise treat the metavariable as a term

        # TODO: check if this may loop infinitely

        # try to find a non-floating statement without hypotheses and unify
        for theorem in composer.get_theorems_of_typecode(typecode):
            if (len(theorem.context.essentials) <= 1 and not isinstance(theorem.statement, FloatingStatement)
                    and len(theorem.statement.terms) == 2):
                # check that expected_statement is an instance of theorem.statement
                solution = Unification.match_terms_as_instance(theorem.statement.terms[1], term)
                if solution is None:
                    continue

                essential_proof = None

                # try to find an exact essential that matches the hypotheses
                if len(theorem.context.essentials):
                    hypothesis= theorem.context.essentials[0].substitute(solution)
                    for essential in composer.get_all_essentials():
                        if hypothesis.terms == essential.statement.terms:
                            essential_proof = essential.apply()
                            break
                    else:
                        continue

                # try to recursively prove that each of the subterms in the solution
                # also have the suitable typecode
                subproofs = []
                failed = False

                for floating in theorem.context.floatings:
                    assert (floating.metavariable in solution), f"unable to determine metavarible {floating.metavariable} in theorem {theorem}"

                    metavar_proof = TypecodeProver.prove_typecode(composer, floating.typecode, solution[floating.metavariable])
                    if metavar_proof is None:
                        failed = True
                        break

                    subproofs.append(metavar_proof)

                if essential_proof is not None:
                    subproofs.append(essential_proof)

                # found a proof
                if not failed:
                    # directly construct the proof here for performance
                    assert theorem.statement.label is not None
                    proof = Proof.from_application(expected_statement, theorem.statement.label, subproofs)
                    return composer.cache_proof("typecode-cache-" + typecode, proof)

        return None


class Encoder(BaseEncoder):
    def __init__(self, composer: Composer, *args: Any, compressed: bool = True, **kwargs: Any) -> None:
        super().__init__(*args, **kwargs)
        self.composer = composer
        self.compressed = compressed

    @staticmethod
    def encode(composer: Composer, output: TextIO, ast: BaseAST, *args: Any, **kwargs: Any) -> None:
        encoder = Encoder(composer, output, *args, **kwargs)
        encoder.visit(ast)
        encoder.flush()

    @staticmethod
    def encode_string(composer: Composer, ast: BaseAST, *args: Any, **kwargs: Any) -> str:
        stream = StringIO()
        Encoder.encode(composer, stream, ast, *args, **kwargs)
        return stream.getvalue()

    def encode_proof(self, stmt: ProvableStatement) -> None:
        assert stmt.proof is not None

        if self.compressed:
            theorem = self.composer.get_theorem(stmt.label)
            mandatory = theorem.get_mandatory_hypothesis_labels()

            self.write(stmt.proof.encode_compressed(mandatory))
        else:
            self.write(stmt.proof.encode_normal())
