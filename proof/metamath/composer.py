from __future__ import annotations

from typing import List, Tuple, Mapping

from .auto.typecode import TypecodeProver
from .auto.unification import Unification

from .ast import *
from .visitors import SubstitutionVisitor


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
A Theorem is any (structured) statement that can be used in a proof
"""
class Theorem:
    def __init__(
        self,
        composer: Composer,
        statement: StructuredStatement,
        floatings: List[Tuple[str, str]], # a list of pairs (typecode, metavariable),
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

    """
    Treat the theorem itself as a proof of itself, provided
    no essential is needed
    """
    def as_proof(self):
        assert len(self.essentials) == 0
        return self.match_and_apply(self.statement)

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
    Applies the theorem, given the following arguments:
      - a list of essential proofs, from which we may infer some of
        the metavariables by unification
      - a map from metavariable name -> proof or term (in the latter case we
        will try to prove the typecode automatically)
    """
    def apply(self, *essential_proofs: Proof, **metavar_substitution) -> Proof:
        substitution = {}
        script = []

        assert len(essential_proofs) == len(self.essentials), \
               "unmatched number of subproofs for " \
               "essential statements, expecting {}, {} given".format(len(self.essentials), len(essential_proofs))

        # TODO: check proofs for essential statements
        for essential, essential_proof in zip(self.essentials, essential_proofs):
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

        for typecode, var in self.floatings:
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
            script += typecode_proof.script

        for essential_proof in essential_proofs:
            script += essential_proof.script

        assert self.statement.label is not None, f"applying a theorem without label: {self.statement}"

        script.append(self.statement.label)

        instance = SubstitutionVisitor(substitution).visit(self.statement)
        instance.label = None
        instance.statement_type = Statement.PROVABLE
        instance.proof = script

        return Proof(instance, script)


"""
A linked list recording the current theorem context
"""
class Context:
    def __init__(self, prev: Context=None):
        self.prev = prev

        self.active_floatings = [] # list of (typecode, metavariable)
        self.active_essentials = [] # list of essential statements

    def add_floating(self, typecode: str, variable: str):
        self.active_floatings.append((typecode, variable))

    def add_essential(self, stmt: StructuredStatement):
        self.active_essentials.append(stmt)

    """
    return a fraction of self.metavariables according to the given set
    """
    def find_floatings(self, metavariables: Set[str]) -> List[Tuple[str, str]]:
        fraction = [ (typecode, var) for typecode, var in self.active_floatings if var in metavariables]
        if self.prev is not None:
            return self.prev.find_floatings(metavariables) + fraction
        else:
            return fraction

    """
    return all metavariables of the given typecode
    """
    def find_floatings_of_typecode(self, expected_typcode: str) -> List[str]:
        current = [ var for typecode, var in self.active_floatings if typecode == expected_typcode ]
        if self.prev is not None:
            return self.find_floatings_of_typecode(expected_typcode) + current
        else:
            return current

    def get_all_floatings(self) -> List[Tuple[str, str]]:
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
            return self.active_essentials


"""
Composer is a utility class used for
emitting metamath statements and proofs
"""
class Composer(MetamathVisitor):
    def __init__(self):
        self.context = Context() # outermost context for a database
        self.theorems = {} # label -> Theorem
        self.statements = [] # all statements at the top level

    def load(self, database_or_statement: Union[Database, Statement]):
        if isinstance(database_or_statement, Database):
            assert self.context.prev is None, "loading a database at non-top level"

        self.visit(database_or_statement)

        if isinstance(database_or_statement, Database):
            self.statements += database_or_statement.statements
        else:
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

    def remove_theorem(self, name: str):
        assert name in self.theorems
        del self.theorems[name]

    def find_essential(self, name: str) -> Optional[Theorem]:
        essential = self.context.find_essential(name)
        if essential:
            return Theorem(self, essential, [], [])
        else:
            return None

    def get_all_essentials(self) -> List[Theorem]:
        return [ Theorem(self, essential, [], []) for essential in self.context.get_all_essentials() ]

    def encode(self, stream: TextIO):
        for stmt in self.statements:
            stmt.encode(stream)
            stream.write("\n")

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
        return [ var for _, var in self.context.get_all_floatings() ]

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
            self.context.add_floating(typecode.symbol, variable.name)

            # any floating statement is also a theorem
            self.theorems[stmt.label] = Theorem(self, stmt, [], [])
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

            self.theorems[stmt.label] = Theorem(self, stmt, floatings.copy(), essentials.copy())
