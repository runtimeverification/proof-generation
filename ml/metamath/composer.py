from __future__ import annotations

from traceback import print_exc

from typing import List, Tuple, Mapping, Callable, Dict, Sequence

import re

from .auto.unification import Unification

from .ast import *
from .visitors import SubstitutionVisitor, CopyVisitor


class Proof:
    """
    A proof is a list of (theorem) labels and a final statement that it proves
    """
    def __init__(self, statement: StructuredStatement, script: List[str]):
        self.statement = statement
        self.script = script

    def __str__(self):
        return str(self.statement)


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
        statement: StructuredStatement,
        floatings: List[Tuple[str, str, str]],  # a list of pairs (typecode, metavariable, label),
        # in the order that should be instantiated
        # (order of the floating statements)
        essentials: List[StructuredStatement],  # a list of essential statements (hypotheses)
    ):
        self.composer = composer
        self.statement = statement
        self.floatings = floatings
        self.essentials = essentials

    def is_meta_substitution_consistent(self, substituted: Union[Proof, Term], term: Term) -> bool:
        if isinstance(substituted, Proof):
            assert len(substituted.statement.terms) == 2
            return substituted.statement.terms[1] == term
        else:
            return substituted == term

    def get_conclusion_instance(self, substitution: Mapping[str, Term]) -> StructuredStatement:
        instance = SubstitutionVisitor(substitution).visit(self.statement)
        instance.label = None
        instance.statement_type = Statement.PROVABLE
        return instance

    def as_proof(self):
        """
        Treat the theorem itself as a proof of itself, provided
        no essential is needed
        """
        assert len(self.essentials) == 0
        script = [label for _, _, label in self.floatings]
        script.append(self.statement.label)
        copied_statement = CopyVisitor().visit(self.statement)
        copied_statement.label = None
        copied_statement.statement_type = Statement.PROVABLE
        return Proof(copied_statement, script)

    def match_and_apply(self, target: StructuredStatement, *args, **kwargs):
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
                         **metavar_substitution) -> Tuple[List[Proof], Mapping[str, Term]]:
        """
        Infer a list of subproofs for the hypotheses from the information given
        """
        substitution = {}
        floating_proofs = []

        assert len(essential_proofs) == len(self.essentials), (
            "unmatched number of subproofs for "
            "essential statements, expecting {}, {} given".format(len(self.essentials), len(essential_proofs))
        )

        # TODO: check proofs for essential statements
        for i, (essential, essential_proof) in enumerate(zip(self.essentials, essential_proofs)):
            # auto proofs will be resolved later
            if isinstance(essential_proof, AutoProof):
                continue

            assert isinstance(essential_proof, Proof), f"wrong proof {essential_proof} of {essential}"

            solution = Unification.match_statements_as_instance(essential, essential_proof.statement)
            assert solution is not None, "`{}` is not an instance of `{}`".format(essential_proof.statement, essential)

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

        for typecode, var, _ in self.floatings:
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
            assert (len(typecode_proof.statement.terms
                        ) == 2), "wrong proof for `{} {}`, got {}".format(typecode, var, typecode_proof.statement)

            proved_typecode, proved_term = typecode_proof.statement.terms

            assert (isinstance(proved_typecode, Application) and proved_typecode.symbol
                    == typecode), "wrong proof for `{} {}`, got {}".format(typecode, var, typecode_proof.statement)

            substitution[var] = proved_term
            floating_proofs.append(typecode_proof)

        # resolve auto proofs
        subst_visitor = SubstitutionVisitor(substitution)
        final_essential_proofs: List[Proof] = []

        for i, proof in enumerate(essential_proofs):
            if isinstance(proof, Proof):
                final_essential_proofs.append(proof)
            else:
                essential_instance = subst_visitor.visit(self.essentials[i])
                try:
                    final_essential_proofs.append(proof.prove(self.composer, essential_instance))
                except Exception:
                    print_exc()
                    assert (False), f"unable to automatically generate proof for {essential_instance}"

        return floating_proofs + final_essential_proofs, substitution

    def apply(self, *essential_proofs: Union[Proof, AutoProof], **metavar_substitution) -> Proof:
        """
        Applies the theorem, given the following arguments:
        - a list of essential proofs, from which we may infer some of
            the metavariables by unification
        - a map from metavariable name -> proof or term (in the latter case we
            will try to prove the typecode automatically)
        """
        subproofs, substitution = self.infer_hypotheses(*essential_proofs, **metavar_substitution)

        assert (self.statement.label is not None), f"applying a theorem without label: {self.statement}"
        proof_script = []
        for subproof in subproofs:
            proof_script.extend(subproof.script)
        proof_script.append(self.statement.label)

        instance = self.get_conclusion_instance(substitution)
        instance.proof = proof_script

        return Proof(instance, proof_script)

    def inline_apply(self, proof_of_theorem: Proof, *essential_proofs: Proof, **metavar_substitution) -> Proof:
        """
        Instead of explicitly referencing the labeled statement,
        we can inline the proof in some other proof to remove
        the dependency. However, the proof script will be longer
        """
        subproofs, substitution = self.infer_hypotheses(*essential_proofs, **metavar_substitution)

        # labels of hypotheses
        essential_labels = []
        for essential in self.essentials:
            assert essential.label is not None
            essential_labels.append(essential.label)

        hyp_labels = [label for _, _, label in self.floatings] + essential_labels
        assert len(subproofs) == len(hyp_labels)

        hyp_proof_map = dict(zip(hyp_labels, subproofs))

        # create an inlined proof
        proof_script = []

        for label in proof_of_theorem.script:
            if label in hyp_proof_map:
                proof_script += hyp_proof_map[label].script
            else:
                proof_script.append(label)

        instance = self.get_conclusion_instance(substitution)
        instance.proof = proof_script

        return Proof(instance, proof_script)


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
    THEOREM_CACHE_THRESHOLD = 4

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

    def lookup(self, domain: str, statement: Union[StructuredStatement, List[Term]]) -> Optional[Proof]:
        """
        Find an existing cached proof by looking up the statement
        """
        if isinstance(statement, StructuredStatement):
            statement = statement.terms
        terms = tuple(statement)

        domain_cache = self.cache_map.get(domain, None)
        if domain_cache is None:
            return None

        return domain_cache.get(terms, None)

    def cache(self, domain: str, proof: Proof, no_theorem_cache: bool = False) -> Proof:
        if ProofCache.DISABLED:
            return proof

        terms = tuple(proof.statement.terms)
        cached_proof = self.cache_map.get(domain, {}).get(terms, None)

        # print(self.stat_cache_hit, self.stat_cache_miss, self.stat_theorem_cache)

        if cached_proof is not None:
            self.stat_cache_hit += 1
            assert cached_proof.statement.terms == list(terms)
            return cached_proof

        self.stat_cache_miss += 1

        # cache the proof as a theorem
        if (not no_theorem_cache and len(proof.script) > ProofCache.THEOREM_CACHE_THRESHOLD):
            self.stat_theorem_cache += 1

            theorem_statement = StructuredStatement(
                Statement.PROVABLE,
                proof.statement.terms,
                label=self.get_next_label(domain),
                proof=proof.script,
            )

            # do not index the cached statements
            theorem = self.composer.load_theorem(theorem_statement, index=False)
            proof = theorem.as_proof()

        if domain not in self.cache_map:
            self.cache_map[domain] = {}
        self.cache_map[domain][terms] = proof

        return proof


class Context:
    """
    A linked list recording the current theorem context
    """
    def __init__(self, prev: Context = None):
        self.prev = prev

        self.active_floatings: List[Tuple[str, str, str]] = []  # list of (typecode, metavariable, label)
        self.active_essentials: List[StructuredStatement] = []  # list of essential statements

    def add_floating(self, typecode: str, variable: str, label: str):
        self.active_floatings.append((typecode, variable, label))

    def add_essential(self, stmt: StructuredStatement):
        self.active_essentials.append(stmt)

    def find_floatings(self, metavariables: Set[str]) -> List[Tuple[str, str, str]]:
        """
        return a fraction of self.metavariables according to the given set
        """
        fraction = [(typecode, var, label) for typecode, var, label in self.active_floatings if var in metavariables]
        if self.prev is not None:
            return self.prev.find_floatings(metavariables) + fraction
        else:
            return fraction.copy()

    def find_floatings_of_typecode(self, expected_typcode: str) -> List[str]:
        """
        return all metavariables of the given typecode
        """
        current = [var for typecode, var, _ in self.active_floatings if typecode == expected_typcode]
        if self.prev is not None:
            return self.find_floatings_of_typecode(expected_typcode) + current
        else:
            return current

    def get_all_floatings(self) -> List[Tuple[str, str, str]]:
        if self.prev is not None:
            return self.prev.get_all_floatings() + self.active_floatings
        else:
            return self.active_floatings

    def find_essential(self, label: str) -> Optional[StructuredStatement]:
        for essential in self.active_essentials:
            if essential.label == label:
                return essential

        if self.prev is not None:
            return self.prev.find_essential(label)
        else:
            return None

    def get_all_essentials(self) -> List[StructuredStatement]:
        if self.prev is not None:
            return self.prev.get_all_essentials() + self.active_essentials
        else:
            return self.active_essentials.copy()


class Composer:
    """
    Composer is a utility class used for
    emitting metamath statements and proofs
    """
    def __init__(self):
        self.context = Context()  # outermost context for a database
        self.theorems = {}  # label -> Theorem
        self.theorems_by_typecode = ({})  # typecode -> [ Theorem ], sorted theorems by typecode
        self.statements = []  # all statements at the top level
        self.proof_cache = ProofCache(self)

        # mark each statement with a unique "segment label"
        # so that we can selectively encode certain set of
        # statements before others
        # the stack is used so that one can mark a set
        # of setences in another segment and restore the old
        # segment
        self.segment_stack = []  # a stack of current segments
        self.segments = {}  # name -> [indices]

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

    def remove_theorem(self, name: str):
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

    def add_theorem_for_typecode(self, typecode: str, theorem: Theorem):
        if typecode not in self.theorems_by_typecode:
            self.theorems_by_typecode[typecode] = []
        self.theorems_by_typecode[typecode].append(theorem)

    def find_essential(self, name: str) -> Optional[Theorem]:
        essential = self.context.find_essential(name)
        if essential:
            return Theorem(self, essential, [], [])
        else:
            return None

    def get_all_essentials(self) -> List[Theorem]:
        return [Theorem(self, essential, [], []) for essential in self.context.get_all_essentials()]

    def encode(self, stream: TextIO, segment=None):
        for stmt in self.statements if segment is None else self.get_segment(segment):
            stmt.encode(stream)
            stream.write("\n")

    def cache_proof(self, *args, **kwargs) -> Proof:
        return self.proof_cache.cache(*args, **kwargs)

    def lookup_proof_cache(self, domain: str, key) -> Optional[Proof]:
        return self.proof_cache.lookup(domain, key)

    # """
    # This implements simple segmentation mechanism. To start a segment,
    # call start_segment(name). To end a segment, call end_segment.
    # To get all statements in a segment, call get_segment
    # """
    def start_segment(self, name: str):
        self.segment_stack.append(name)

    def end_segment(self):
        self.segment_stack.pop()

    def get_segment(self, name: str) -> List[Statement]:
        if name not in self.segments:
            return []
        return [self.statements[i] for i in self.segments[name]]

    def add_indices_to_current_segment(self, indices: List[int]):
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
        return found[0][0]

    def find_metavariables_of_typecode(self, typecode: str) -> List[str]:
        """
        find metavariables of the given typecode
        """
        return self.context.find_floatings_of_typecode(typecode)

    def get_all_metavariables(self) -> List[str]:
        return [var for _, var, _ in self.context.get_all_floatings()]

    def index_statement(self, stmt: StructuredStatement):
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

    def load(self, database_or_statement: Union[Database, Statement], index: bool = True) -> Optional[Theorem]:
        """
        Add a structured statement/block/database to the composer
        Optionally return a theorem corresponding to the given statement
        """
        if isinstance(database_or_statement, Database):
            assert self.context.prev is None, "loading a database at non-top level"
            for statement in database_or_statement.statements:
                self.load(statement, index)

            return None
        elif isinstance(database_or_statement, Statement):
            if self.context.prev is None:
                # add top level statements
                self.add_indices_to_current_segment([len(self.statements)])
                self.statements.append(database_or_statement)

            if isinstance(database_or_statement, Block):
                self.context = Context(self.context)
                for statement in database_or_statement.statements:
                    self.load(statement, index)
                self.context = self.context.prev
                return None
            else:
                return self.load_statement(database_or_statement, index)

        else:
            assert False, f"unable to load {database_or_statement}"

    def load_statement(self, stmt: Statement, index: bool = True) -> Optional[Theorem]:
        if not isinstance(stmt, StructuredStatement):
            return None

        theorem = None

        if stmt.statement_type == Statement.FLOATING:
            typecode, variable = stmt.terms
            assert isinstance(typecode, Application)
            assert isinstance(variable, Metavariable)

            self.context.add_floating(typecode.symbol, variable.name, stmt.label)

            # any floating statement is also a theorem
            self.theorems[stmt.label] = theorem = Theorem(self, stmt, [], [])

            if index:
                self.index_statement(stmt)

        elif stmt.statement_type == Statement.ESSENTITAL:
            self.context.add_essential(stmt)
            theorem = Theorem(self, stmt, [], [])

        elif stmt.statement_type in {Statement.PROVABLE, Statement.AXIOM}:
            # find all mandatory hypotheses of a statement
            # and build a Theorem object

            essentials = self.context.get_all_essentials()
            metavariables = stmt.get_metavariables()

            for essential in essentials:
                metavariables.update(essential.get_metavariables())

            floatings = self.context.find_floatings(metavariables)

            assert len(floatings) == len(metavariables), "some metavariables not found in {}, only found {}".format(
                metavariables, floatings
            )

            self.theorems[stmt.label] = theorem = Theorem(self, stmt, floatings, essentials)

            if index:
                self.index_statement(stmt)

        return theorem


class TypecodeProver:
    """
    Try to prove a statement of the form
    <typecode> <term>
    by recursively unify the target with a theorem of this form
    """
    @staticmethod
    def prove_typecode(composer: Composer, typecode: str, term: Term) -> Optional[Proof]:
        # TODO: these checks are a bit too specialized
        if (typecode == "#Variable" or typecode == "#ElementVariable"
                or typecode == "#SetVariable") and not isinstance(term, Metavariable):
            return None

        if typecode == "#Symbol" and (not isinstance(term, Application) or len(term.subterms) != 0):
            return None

        expected_statement = StructuredStatement(Statement.PROVABLE, [Application(typecode), term])

        cached_proof = composer.lookup_proof_cache("typecode-cache-" + typecode, expected_statement.terms)
        if cached_proof is not None:
            return cached_proof

        # try to find a matching floating statement first if the term is a metavariable
        if isinstance(term, Metavariable):
            for theorem in composer.get_theorems_of_typecode(typecode):
                if theorem.statement.statement_type == Statement.FLOATING:
                    _, metavar = theorem.statement.terms
                    assert isinstance(metavar, Metavariable)

                    if metavar.name == term.name:
                        # found a direct proof
                        assert theorem.statement.label is not None
                        proof = Proof(expected_statement, [theorem.statement.label])
                        proof = composer.cache_proof("typecode-cache-" + typecode, proof)
                        return proof
            # otherwise treat the metavariable as a term

        # TODO: check if this may loop infinitely

        # try to find a non-floating statement without hypotheses and unify
        for theorem in composer.get_theorems_of_typecode(typecode):
            if (len(theorem.essentials) <= 1 and theorem.statement.statement_type != Statement.FLOATING
                    and len(theorem.statement.terms) == 2):
                # check that expected_statement is an instance of theorem.statement
                solution = Unification.match_terms_as_instance(theorem.statement.terms[1], term)
                if solution is None:
                    continue

                essential_proof = None

                # try to find an exact essential that matches the hypotheses
                if len(theorem.essentials):
                    hypothesis = SubstitutionVisitor(solution).visit(theorem.essentials[0])
                    for essential in composer.get_all_essentials():
                        if hypothesis.terms == essential.statement.terms:
                            essential_proof = essential.apply()
                            break
                    else:
                        continue

                # try to recursively prove that each of the subterms in the solution
                # also have the suitable typecode
                proof_script = []
                failed = False

                for expected_typecode, var, _ in theorem.floatings:
                    assert (var in solution), f"unable to determine metavarible {var} in theorem {theorem}"

                    metavar_proof = TypecodeProver.prove_typecode(composer, expected_typecode, solution[var])
                    if metavar_proof is None:
                        failed = True
                        break

                    proof_script.extend(metavar_proof.script)

                if essential_proof is not None:
                    proof_script.extend(essential_proof.script)

                # found a proof
                if not failed:
                    # directly construct the proof here for performance
                    assert theorem.statement.label is not None
                    proof_script.append(theorem.statement.label)
                    proof = Proof(expected_statement, proof_script)
                    proof = composer.cache_proof("typecode-cache-" + typecode, proof)
                    return proof

        return None
