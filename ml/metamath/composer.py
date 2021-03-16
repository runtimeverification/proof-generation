from __future__ import annotations

from traceback import print_exc

from typing import List, Tuple, Mapping, Callable

from .auto.unification import Unification

from .ast import *
from .visitors import SubstitutionVisitor, CopyVisitor


"""
A proof is a list of (theorem) labels and a final statement that it proves
"""
class Proof:
    def __init__(self, statement: StructuredStatement, script: List[str]):
        self.statement = statement
        self.script = script

    def __str__(self):
        return str(self.statement)


"""
A proof generator that's supposed to prove the statement given to it,
if not, it will raise an error
"""
class AutoProof:
    def prove(self, composer: Composer, statement: StructuredStatement) -> Proof:
        raise NotImplementedError()


class MethodAutoProof(AutoProof):
    def __init__(self, method: Callable[[Composer, StructuredStatement], Proof]):
        self.method = method

    def prove(self, composer: Composer, statement: StructuredStatement) -> Proof:
        return self.method(composer, statement)


"""
A Theorem is any (structured) statement that can be used in a proof
"""
class Theorem:
    def __init__(
        self,
        composer: Composer,
        statement: StructuredStatement,
        floatings: List[Tuple[str, str, str]], # a list of pairs (typecode, metavariable, label),
                                               # in the order that should be instantiated
                                               # (order of the floating statements)
        essentials: List[StructuredStatement], # a list of essential statements (hypotheses)
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

    """
    Treat the theorem itself as a proof of itself, provided
    no essential is needed
    """
    def as_proof(self):
        assert len(self.essentials) == 0
        script = [ label for _, _, label in self.floatings ]
        script.append(self.statement.label)
        copied_statement = CopyVisitor().visit(self.statement)
        copied_statement.label = None
        copied_statement.statement_type = Statement.PROVABLE
        return Proof(copied_statement, script)

    """
    Unify the theorem statement with a target,
    infer as many metavariables as possible, and
    then call self.apply
    """
    def match_and_apply(self, target: StructuredStatement, *args, **kwargs):
        substitution = Unification.match_statements(self.statement, target)
        assert substitution is not None, \
               "failed to unify the target statement `{}` and the theorem `{}`".format(target, self.statement)

        for lhs, rhs in substitution:
            if not isinstance(lhs, Metavariable):
                continue

            var = lhs.name

            if var in kwargs:
                assert self.is_meta_substitution_consistent(kwargs[var], rhs), \
                       "metavariable assignment to {} is not consistent: " \
                       "`{}` and `{}` are both assigned to it".format(var, kwargs[var], rhs)
            else:
                kwargs[var] = rhs

        return self.apply(*args, **kwargs)

    """
    Infer a list of subproofs for the hypotheses from the information given
    """
    def infer_hypotheses(self, *essential_proofs: Proof, **metavar_substitution) -> Tuple[List[Proof], Mapping[str, Term]]:
        substitution = {}
        floating_proofs = []

        assert len(essential_proofs) == len(self.essentials), \
               "unmatched number of subproofs for " \
               "essential statements, expecting {}, {} given".format(len(self.essentials), len(essential_proofs))

        # TODO: check proofs for essential statements
        for essential, essential_proof in zip(self.essentials, essential_proofs):
            # auto proofs will be resolved later
            if isinstance(essential_proof, AutoProof):
                continue

            assert isinstance(essential_proof, Proof), f"wrong proof {essential_proof} of {essential}"

            solution = Unification.match_statements_as_instance(essential, essential_proof.statement)
            assert solution is not None, \
                   "`{}` is not an instance of `{}`".format(essential_proof.statement, essential)

            # check that the unification solution is consistent with
            # the metavariable assignment
            for var, term in solution.items():
                if var in metavar_substitution:
                    assert self.is_meta_substitution_consistent(metavar_substitution[var], term), \
                           "metavariable assignment to {} is not consistent: " \
                           "`{}` and `{}` are both assigned to it".format(var, metavar_substitution[var], term)
                else:
                    # update metavar_substitution to reflect this assignment
                    metavar_substitution[var] = term

        for typecode, var, _ in self.floatings:
            assert var in metavar_substitution, \
                   "assignment to metavariable `{}` cannot be inferred".format(var)

            # this can either be a direct proof,
            # or a term, in which case we will try to
            # prove the typecode for it automatically
            metavar_substituted = metavar_substitution[var]
            
            if isinstance(metavar_substituted, Term):
                typecode_proof = TypecodeProver.prove_typecode(self.composer, typecode, metavar_substituted)

                assert typecode_proof is not None, \
                       "a term `{}` is given for metavariable `{}`, " \
                       "but we couldn't prove that `{} {}`".format(metavar_substituted, var, typecode, metavar_substituted)
            else:
                # should be a proof
                typecode_proof = metavar_substituted

            # check that the proof is in the right form (for floating statements)
            assert len(typecode_proof.statement.terms) == 2, \
                   "wrong proof for `{} {}`, got {}".format(typecode, var, typecode_proof.statement)
            
            proved_typecode, proved_term = typecode_proof.statement.terms

            assert isinstance(proved_typecode, Application) and \
                   proved_typecode.symbol == typecode, \
                   "wrong proof for `{} {}`, got {}".format(typecode, var, typecode_proof.statement)

            substitution[var] = proved_term
            floating_proofs.append(typecode_proof)

        # resolve auto proofs
        essential_proofs = list(essential_proofs)
        subst_visitor = SubstitutionVisitor(substitution)

        for i, proof in enumerate(essential_proofs):
            if isinstance(proof, AutoProof):
                essential_instance = subst_visitor.visit(self.essentials[i])
                try:
                    essential_proofs[i] = proof.prove(self.composer, essential_instance)
                except Exception:
                    print_exc()
                    assert False, f"unable to automatically generate proof for {essential_instance}"

        return floating_proofs + essential_proofs, substitution

    """
    Applies the theorem, given the following arguments:
      - a list of essential proofs, from which we may infer some of
        the metavariables by unification
      - a map from metavariable name -> proof or term (in the latter case we
        will try to prove the typecode automatically)
    """
    def apply(self, *essential_proofs: Proof, **metavar_substitution) -> Proof:
        subproofs, substitution = self.infer_hypotheses(*essential_proofs, **metavar_substitution)

        assert self.statement.label is not None, f"applying a theorem without label: {self.statement}"
        proof_script = []
        for subproof in subproofs:
            proof_script.extend(subproof.script)
        proof_script.append(self.statement.label)

        instance = self.get_conclusion_instance(substitution)
        instance.proof = proof_script

        return Proof(instance, proof_script)
        
    """
    Instead of explicitly referencing the labeled statement,
    we can inline the proof in some other proof to remove
    the dependency. However, the proof script will be longer
    """
    def inline_apply(self, proof_of_theorem: Proof, *essential_proofs: Proof, **metavar_substitution) -> Proof:
        subproofs, substitution = self.infer_hypotheses(*essential_proofs, **metavar_substitution)

        # labels of hypotheses
        hyp_labels = [ label for _, _, label in self.floatings ] + [ essential.label for essential in self.essentials ]
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
class ProofCache:
    # if the proof script size exceeds this
    # number of labels, the proof will be cached
    # as a theorem in the database
    THEOREM_CACHE_THRESHOLD = 64

    # certain tools (e.g. itp) would need all cache disabled
    DISABLED = False

    def __init__(self, composer: Composer):
        self.composer = composer
        self.cache_map = {} # label prefix -> (terms -> proof)
        self.label_map = {} # label prefix -> next index

        self.stat_cache_hit = 0
        self.stat_cache_miss = 0
        self.stat_theorem_cache = 0

    """
    Get the next available label with the given prefix
    """
    def get_next_label(self, domain: str) -> str:
        if domain not in self.label_map:
            self.label_map[domain] = 0

        idx = self.label_map[domain]
        self.label_map[domain] += 1
        return f"{domain}-{idx}"

    """
    Find an existing cached proof by looking up the statement
    """
    def lookup(self, domain: str, statement: Union[StructuredStatement, List[Term]]) -> Optional[Proof]:
        if isinstance(statement, StructuredStatement):
            statement = statement.terms
        terms = tuple(statement)
        return self.cache_map.get(domain, {}).get(terms, None)

    def cache(self, domain: str, proof: Proof, no_theorem_cache: bool=False) -> Proof:
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
        if not no_theorem_cache and len(proof.script) > ProofCache.THEOREM_CACHE_THRESHOLD:
            self.stat_theorem_cache += 1

            theorem_statement = StructuredStatement(
                Statement.PROVABLE,
                proof.statement.terms,
                label=self.get_next_label(domain),
                proof=proof.script,
            )

            theorem = self.composer.load(theorem_statement)
            proof = theorem.as_proof()

        if domain not in self.cache_map:
            self.cache_map[domain] = {}
        self.cache_map[domain][terms] = proof

        return proof


"""
A linked list recording the current theorem context
"""
class Context:
    def __init__(self, prev: Context=None):
        self.prev = prev

        self.active_floatings = [] # list of (typecode, metavariable, label)
        self.active_essentials = [] # list of essential statements

    def add_floating(self, typecode: str, variable: str, label: str):
        self.active_floatings.append((typecode, variable, label))

    def add_essential(self, stmt: StructuredStatement):
        self.active_essentials.append(stmt)

    """
    return a fraction of self.metavariables according to the given set
    """
    def find_floatings(self, metavariables: Set[str]) -> List[Tuple[str, str, str]]:
        fraction = [ (typecode, var, label) for typecode, var, label in self.active_floatings if var in metavariables]
        if self.prev is not None:
            return self.prev.find_floatings(metavariables) + fraction
        else:
            return fraction.copy()

    """
    return all metavariables of the given typecode
    """
    def find_floatings_of_typecode(self, expected_typcode: str) -> List[str]:
        current = [ var for typecode, var, _ in self.active_floatings if typecode == expected_typcode ]
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


"""
Composer is a utility class used for
emitting metamath statements and proofs
"""
class Composer(MetamathVisitor):
    def __init__(self):
        self.context = Context() # outermost context for a database
        self.theorems = {} # label -> Theorem
        self.theorems_by_typecode = {} # typecode -> [ Theorem ], sorted theorems by typecode
        self.statements = [] # all statements at the top level
        self.proof_cache = ProofCache(self)

        # mark each statement with a unique "segment label"
        # so that we can selectively encode certain set of
        # statements before others
        # the stack is used so that one can mark a set
        # of setences in another segment and restore the old
        # segment
        self.segment_stack = [] # a stack of current segments
        self.segments = {} # name -> [indices]

    def load(self, database_or_statement: Union[Database, Statement]):
        if isinstance(database_or_statement, Database):
            assert self.context.prev is None, "loading a database at non-top level"

        self.visit(database_or_statement)

        if isinstance(database_or_statement, Database):
            self.add_indices_to_current_segment(list(range(len(self.statements), len(self.statements) + len(database_or_statement.statements))))
            self.statements += database_or_statement.statements
        else:
            self.add_indices_to_current_segment([ len(self.statements) ])
            self.statements.append(database_or_statement)

            # return the corresponding theorem
            if isinstance(database_or_statement, StructuredStatement):
                if database_or_statement.statement_type in { Statement.AXIOM, Statement.FLOATING, Statement.PROVABLE }:
                    assert database_or_statement.label in self.theorems
                    return self.theorems[database_or_statement.label]

                if database_or_statement.statement_type == Statement.ESSENTITAL:
                    return Theorem(self, database_or_statement, [], [])

    def find_theorem(self, name: str) -> Optional[Theorem]:
        return self.theorems.get(name)

    def get_theorems_of_typecode(self, typecode: str) -> List[Theorem]:
        return self.theorems_by_typecode.get(typecode, [])

    def remove_theorem(self, name: str):
        assert name in self.theorems
        theorem = self.theorems[name]

        del self.theorems[name]

        # also delete it from the typecode map
        stmt = theorem.statement
        if len(stmt.terms) != 0 and \
           isinstance(stmt.terms[0], Application) and \
           len(stmt.terms[0].subterms) == 0 and \
           stmt.terms[0].symbol in self.theorems_by_typecode:
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
        return [ Theorem(self, essential, [], []) for essential in self.context.get_all_essentials() ]

    def encode(self, stream: TextIO, segment=None):
        for stmt in self.statements if segment is None else self.get_segment(segment):
            stmt.encode(stream)
            stream.write("\n")

    def cache_proof(self, *args, **kwargs) -> Proof:
        return self.proof_cache.cache(*args, **kwargs)

    def lookup_proof_cache(self, *args, **kwargs) -> Proof:
        return self.proof_cache.lookup(*args, **kwargs)

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
        if name not in self.segments: return []
        return [ self.statements[i] for i in self.segments[name] ]

    def add_indices_to_current_segment(self, indices: List[int]):
        if len(self.segment_stack) == 0:
            return

        name = self.segment_stack[-1]

        if name not in self.segments:
            self.segments[name] = []
        self.segments[name] += indices

    """
    look up a metavariable, if found, return the typecode,
    otherwise, return None
    """
    def find_metavariable(self, var: str) -> Optional[str]:
        found = self.context.find_floatings({ var })
        if not found: return None
        return found[0][0]

    """
    find metavariables of the given typecode
    """
    def find_metavariables_of_typecode(self, typecode: str) -> List[str]:
        return self.context.find_floatings_of_typecode(typecode)

    def get_all_metavariables(self) -> List[str]:
        return [ var for _, var, _ in self.context.get_all_floatings() ]

    ####################################
    # Composer as a metamath AST visitor
    ####################################

    def previsit_block(self, block: Block):
        self.context = Context(self.context)

    def postvisit_block(self, block: Block, *args):
        self.context = self.context.prev
        assert self.context is not None

    def postvisit_structured_statement(self, stmt: StructuredStatement, *args):
        if stmt.statement_type == Statement.FLOATING:
            typecode, variable = stmt.terms
            self.context.add_floating(typecode.symbol, variable.name, stmt.label)

            # any floating statement is also a theorem
            self.theorems[stmt.label] = Theorem(self, stmt, [], [])
            self.add_theorem_for_typecode(typecode.symbol, self.theorems[stmt.label])

        elif stmt.statement_type == Statement.ESSENTITAL:
            self.context.add_essential(stmt)
        elif stmt.statement_type in { Statement.PROVABLE, Statement.AXIOM }:
            # find all mandatory hypotheses of a statement
            # and build a Theorem object

            essentials = self.context.get_all_essentials()
            metavariables = stmt.get_metavariables()

            for essential in essentials:
                metavariables.update(essential.get_metavariables())

            floatings = self.context.find_floatings(metavariables)

            assert len(floatings) == len(metavariables), \
                   "some metavariables not found in {}, only found {}".format(metavariables, floatings)

            self.theorems[stmt.label] = Theorem(self, stmt, floatings, essentials)

            # add it to the corresponding typecode map
            if len(stmt.terms) != 0 and isinstance(stmt.terms[0], Application) and len(stmt.terms[0].subterms) == 0:
                self.add_theorem_for_typecode(stmt.terms[0].symbol, self.theorems[stmt.label])


class TypecodeProver:
    """
    Try to prove a statement of the form
    <typecode> <term>
    by recursively unify the target with a theorem of this form
    """
    @staticmethod
    def prove_typecode(composer, typecode: str, term: Term):
        expected_statement = StructuredStatement(Statement.PROVABLE, [ Application(typecode), term ])

        # don't cache metavariable statements
        # otherwise it may be caught in infinite recursion in the proof cache
        if not isinstance(term, Metavariable):
            cached_proof = composer.lookup_proof_cache("typecode-cache", expected_statement.terms)
            if cached_proof is not None:
                return cached_proof

        # try to find a matching floating statement first if the term is a metavariable
        if isinstance(term, Metavariable):
            for theorem in composer.get_theorems_of_typecode(typecode):
                if theorem.statement.statement_type == Statement.FLOATING:
                    _, metavar = theorem.statement.terms

                    if metavar.name == term.name:
                        # found a direct proof
                        proof = Proof(expected_statement, [ theorem.statement.label ])
                        if not isinstance(term, Metavariable):
                            proof = composer.cache_proof("typecode-cache", proof)
                        return proof
            # otherwise treat the metavariable as a term

        # TODO: check if this may loop infinitely

        # try to find a non-floating statement without hypotheses and unify
        for theorem in composer.get_theorems_of_typecode(typecode):
            if len(theorem.essentials) <= 1 and \
               theorem.statement.statement_type != Statement.FLOATING and \
               len(theorem.statement.terms) == 2:
                # check that expected_statement is an instance of theorem.statement
                solution = Unification.match_terms_as_instance(theorem.statement.terms[1], term)
                if solution is None: continue

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

                for expected_typecode, metavar, _ in theorem.floatings:
                    assert metavar in solution, f"unable to determine metavarible {metavar} in theorem {theorem}"

                    metavar_proof = TypecodeProver.prove_typecode(composer, expected_typecode, solution[metavar])
                    if metavar_proof is None:
                        failed = True
                        break

                    proof_script.extend(metavar_proof.script)

                if essential_proof is not None:
                    proof_script.extend(essential_proof.script)

                # found a proof
                if not failed:
                    # directly construct the proof here for performance
                    proof_script.append(theorem.statement.label)
                    proof = Proof(expected_statement, proof_script)
                    if not isinstance(term, Metavariable):
                        proof = composer.cache_proof("typecode-cache", proof)
                    return proof

        return None
