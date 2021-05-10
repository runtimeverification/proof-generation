from __future__ import annotations

from typing import TextIO, Optional, List, Set, Union, Iterable, Any, Dict, Mapping, Tuple, Collection, NamedTuple, TypeVar
from dataclasses import dataclass, field
from io import StringIO

from ml.utils.visitor import Visitor
from ml.utils.printer import Printer


class MetamathVisitor(Visitor):
    """
    This is a less general version
    of metamath that preseves certain structures
    in the source file. All "terms" should look like
    S-expressions. A term without arguments should be
    used without parentheses

    All statements are in the form

    <t_1> [<t_2> ...]

    where t_i's are terms

    All terms basically consists only of constant symbols
    with the only exception being metavariables.
    """
    def visit_children_of_application(self, application: Application) -> List[List[Any]]:
        return [
            [subterm.visit(self) for subterm in application.subterms],
        ]

    def visit_children_of_structured_statement(self, stmt: StructuredStatement) -> List[List[Any]]:
        return [
            [term.visit(self) for term in stmt.terms],
        ]

    def visit_children_of_block(self, block: Block) -> List[List[Any]]:
        return [
            [stmt.visit(self) for stmt in block.statements],
        ]

    def visit_children_of_database(self, database: Database) -> List[List[Any]]:
        return [
            [stmt.visit(self) for stmt in database.statements],
        ]


class BaseAST:
    def __str__(self) -> str:
        stream = StringIO()
        encoder = BaseEncoder(stream)
        encoder.visit(self)
        encoder.flush()
        return stream.getvalue()

    def __repr__(self) -> str:
        return str(self)


@dataclass
class Term(BaseAST):
    def get_metavariables(self) -> Set[str]:
        raise NotImplementedError()

    def substitute(self, substitution: Mapping[str, Term]) -> Term:
        raise NotImplementedError()

    def visit(self, visitor: MetamathVisitor) -> Any:
        raise NotImplementedError()


@dataclass
class Metavariable(Term):
    name: str

    def get_metavariables(self) -> Set[str]:
        return {self.name}

    def substitute(self, substitution: Mapping[str, Term]) -> Term:
        if self.name in substitution:
            return substitution[self.name]
        else:
            return self
    
    def visit(self, visitor: MetamathVisitor) -> Any:
        return visitor.proxy_visit_metavariable(self)

    def __hash__(self) -> int:
        return hash(self.name)

    def __gt__(self, other: Any) -> bool:
        assert isinstance(other, Metavariable)
        return self.name > other.name


@dataclass
class Application(Term):
    symbol: str
    subterms: Tuple[Term, ...] = ()
    hash_cache: Optional[int] = None

    def get_metavariables(self) -> Set[str]:
        metavars = set()
        for subterm in self.subterms:
            metavars.update(subterm.get_metavariables())
        return metavars

    def substitute(self, substitution: Mapping[str, Term]) -> Application:
        return Application(self.symbol, tuple(subterm.substitute(substitution) for subterm in self.subterms))

    def visit(self, visitor: MetamathVisitor) -> Any:
        return visitor.proxy_visit_application(self)

    def __eq__(self, other: Any) -> bool:
        # this function is specifically rewritten
        # to not use recursion since it's used
        # too many times and has become a performance
        # bottleneck
        if not isinstance(other, Application):
            return False

        comparison_left: List[Term] = [self]
        comparison_right: List[Term] = [other]

        while comparison_left:
            left = comparison_left.pop()
            right = comparison_right.pop()

            if isinstance(left, Application) and isinstance(right, Application):
                if left.symbol == right.symbol and len(left.subterms) == len(right.subterms):
                    comparison_left.extend(left.subterms)
                    comparison_right.extend(right.subterms)
                else:
                    return False
            elif not (left == right):
                # fall back to default equality
                return False

        return True

    def __hash__(self) -> int:
        if self.hash_cache is not None:
            return self.hash_cache

        final_hash = hash(self.symbol)
        for subterm in self.subterms:
            final_hash ^= hash(subterm)

        self.hash_cache = final_hash
        return final_hash


class Statement(BaseAST):
    def get_metavariables(self) -> Set[str]:
        return set()

    def substitute(self, substitution: Mapping[str, Term]) -> Statement:
        raise NotImplementedError()

    def visit(self, visitor: MetamathVisitor) -> Any:
        raise NotImplementedError()


@dataclass
class ConstantStatement(Statement):
    constants: Tuple[str, ...]

    def visit(self, visitor: MetamathVisitor) -> Any:
        return visitor.proxy_visit_constant_statement(self)


@dataclass
class VariableStatement(Statement):
    metavariables: Tuple[Metavariable, ...]

    def visit(self, visitor: MetamathVisitor) -> Any:
        return visitor.proxy_visit_variable_statement(self)


@dataclass
class DisjointStatement(Statement):
    metavariables: Tuple[Metavariable, ...]

    def visit(self, visitor: MetamathVisitor) -> Any:
        return visitor.proxy_visit_disjoint_statement(self)


Terms = Tuple[Term, ...]
StmtT = TypeVar("StmtT", bound="StructuredStatement")


@dataclass
class StructuredStatement(Statement):
    label: str
    terms: Terms

    def get_metavariables(self) -> Set[str]:
        metavars = set()
        for term in self.terms:
            metavars.update(term.get_metavariables())
        return metavars

    def substitute(self: StmtT, substitution: Mapping[str, Term]) -> StmtT:
        return type(self)(self.label, tuple(term.substitute(substitution) for term in self.terms))

    def visit(self, visitor: MetamathVisitor) -> Any:
        return visitor.proxy_visit_structured_statement(self)


@dataclass
class FloatingStatement(StructuredStatement):
    typecode: str = field(default="", init=False)
    metavariable: str = field(default="", init=False)

    def __post_init__(self) -> None:
        assert len(self.terms) == 2 and \
               isinstance(self.terms[0], Application) and \
               isinstance(self.terms[1], Metavariable)
        self.typecode = self.terms[0].symbol
        self.metavariable = self.terms[1].name


class EssentialStatement(StructuredStatement): ...


class ConclusionStatement(StructuredStatement): ...


class AxiomaticStatement(ConclusionStatement): ...


@dataclass
class ProvableStatement(ConclusionStatement):
    proof: Optional[Proof] = None


@dataclass
class Comment(Statement):
    text: str

    def visit(self, visitor: MetamathVisitor) -> Any:
        return visitor.proxy_visit_comment(self)


@dataclass
class IncludeStatement(Statement):
    path: str

    def visit(self, visitor: MetamathVisitor) -> Any:
        return visitor.proxy_visit_include_statement(self)


@dataclass
class Block(Statement):
    """
    A block is a list of statements,
    while itself is also a statement
    """

    statements: Tuple[Statement, ...]

    def visit(self, visitor: MetamathVisitor) -> Any:
        return visitor.proxy_visit_block(self)


@dataclass
class Database(BaseAST):
    """
    A database consists of a single outermost block
    and some auxiliary information
    e.g. set of variables and mapping from labels to statements
    """
    
    statements: Tuple[Statement, ...]

    def visit(self, visitor: MetamathVisitor) -> Any:
        return visitor.proxy_visit_database(self)


class Proof:
    """
    A Metamath proof is a tree with each node being a
    statement label and the number of children
    should be equal to the nmuber of mandatory hypotheses

    This datastructure allows both reference to other proofs
    and raw, unparsed proofs to save space
    """
    def __init__(self, conclusion: Iterable[Term]):
        self.conclusion: Terms = tuple(conclusion)

        self.nodes: List[Union[str, Tuple[str, ...]]] = []
        # a node is either:
        # - a label, which can be used for any node in the tree
        # - a Proof, which can only be used for non-leaf nodes
        # - a list of label, which can only be used for leaf nodes (unparsed Metamath proof format)

        self.node_to_conclusion: List[Terms] = []
        # conclusions for each dag
        # note that node_to_conclusion[0] == self.internal_conclusions

        self.dag: Dict[int, List[int]] = {}
        # a proof DAG should have a unique source at 0
        # for now it's always a tree
        # if a node has no out-edges, it SHOULD NOT
        # have an entry in self.dag

    @staticmethod
    def from_script(statement: StructuredStatement, script: Union[str, Iterable[str]]) -> Proof:
        """
        Make a proof from the normal proof format as a list of labels
        """
        proof = Proof(statement.terms)
        proof.nodes = [script if isinstance(script, str) else tuple(script)]
        proof.node_to_conclusion = [proof.conclusion]
        return proof

    def add_subproof(self, subproof: Proof, conclusion_to_node: Dict[Tuple[Term, ...], int] = {}) -> int:
        """
        Add a disconnected subproof

        conclusion_to_node is a dictionary to keep track of nodes
        with duplicated conclusions, provided by the caller to
        reduce proof size
        """
        prev_num_nodes = next_node = len(self.nodes)

        node_map: Dict[int, int] = {}
        # from the old node from the new node

        new_conclusion_to_node = {}

        for i, item in enumerate(subproof.nodes):
            item_conclusion = subproof.node_to_conclusion[i]
            shared_node = conclusion_to_node.get(item_conclusion)

            if shared_node is not None:
                node_map[i] = shared_node
            else:
                node_map[i] = next_node
                self.nodes.append(item)
                self.node_to_conclusion.append(item_conclusion)
                new_conclusion_to_node[item_conclusion] = next_node
                next_node += 1

        for i, neighbors in subproof.dag.items():
            new_node = node_map[i]
            if new_node >= prev_num_nodes:
                self.dag[node_map[i]] = [node_map[n] for n in neighbors]

        conclusion_to_node.update(new_conclusion_to_node)

        return node_map[0]

    @staticmethod
    def from_application(statement: StructuredStatement, root: str, children: Collection[Proof]) -> Proof:
        """
        Combine the proof DAGs
        """

        proof = Proof(statement.terms)
        proof.nodes = [root]
        proof.node_to_conclusion = [proof.conclusion]

        conclusion_to_node: Dict[Tuple[Term, ...], int] = {}
        if len(children) != 0:
            proof.dag[0] = []
            for child in children:
                child_root = proof.add_subproof(child, conclusion_to_node)
                proof.dag[0].append(child_root)

        return proof

    def as_statement(self, label: str) -> StructuredStatement:
        """
        Encode as a provable statement
        """
        return ProvableStatement(label, self.conclusion, self)

    def is_leaf(self, node: int) -> bool:
        return node not in self.dag

    def get_children_of(self, node: int) -> List[int]:
        return self.dag.get(node, [])

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
    def compress_script(mandatory: List[str], proof: List[str]) -> str:
        label_to_letter = {"?": "?"}

        # rank the labels by frequency
        frequency = {}
        for label in proof:
            # ? and mandatory labels are handled differently
            if label == "?" or label in mandatory:
                continue

            if label not in frequency:
                frequency[label] = 0

            frequency[label] += 1

        sorted_frequency = sorted(list(frequency.items()), reverse=True, key=lambda t: t[1])
        unique_labels = [label for label, _ in sorted_frequency]

        for i, hyp in enumerate(mandatory + unique_labels):
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

    def encode_compressed(self, mandatory_hypotheses: List[str]) -> str:
        """
        Encode a proof in the compressed format
        This requires some context information, namely the mandatory hypotheses
        of the statement in the order they are defined
        """
        # TODO: share subtrees
        script: List[str] = []
        self.flatten(script)
        return Proof.compress_script(mandatory_hypotheses, script)


class BaseEncoder(Printer, Visitor):
    """
    Encoder for Metamath AST with options
    """
    def __init__(self, output: TextIO, tab: str = "   ", omit_proof: bool = False):
        super().__init__(output, tab)
        self.omit_proof = omit_proof

    def postvisit_metavariable(self, metavar: Metavariable) -> None:
        self.write(metavar.name)

    def postvisit_application(self, application: Application) -> None:
        if len(application.subterms) == 0:
            self.write(application.symbol)
        else:
            self.write("( ")
            self.write(application.symbol)

            for subterm in application.subterms:
                self.write(" ")
                assert isinstance(subterm, Term), "not a term: {}".format(subterm)
                self.visit(subterm)

            self.write(" )")

    def postvisit_constant_statement(self, constant_statement: ConstantStatement) -> None:
        self.write("$c")
        for constant in constant_statement.constants:
            self.write(" ")
            self.write(constant)
        self.write(" $.")

    def postvisit_variable_statement(self, variable_statement: VariableStatement) -> None:
        self.write("$v")
        for metavar in variable_statement.metavariables:
            self.write(" ")
            self.visit(metavar)
        self.write(" $.")

    def postvisit_disjoint_statement(self, disjoint_statement: DisjointStatement) -> None:
        self.write("$d")
        for metavar in disjoint_statement.metavariables:
            self.write(" ")
            self.visit(metavar)
        self.write(" $.")

    def postvisit_comment(self, comment: Comment) -> None:
        self.write("\n$(")
        if not comment.text[:-1].isspace():
            self.write(" ")

        with self.indentation():
            self.write(comment.text)

        if not comment.text[-1:].isspace():
            self.write(" ")
        self.write("$)")

    def postvisit_include_statement(self, include: IncludeStatement) -> None:
        self.write("$[ ")
        self.write(include.path)
        self.write(" $]")

    def encode_proof(self, stmt: ProvableStatement) -> None:
        assert stmt.proof is not None
        self.write(stmt.proof.encode_normal())

    def get_statement_type(self, stmt: StructuredStatement) -> str:
        if isinstance(stmt, FloatingStatement):
            return "f"
        elif isinstance(stmt, EssentialStatement):
            return "e"
        elif isinstance(stmt, AxiomaticStatement):
            return "a"
        elif isinstance(stmt, ProvableStatement):
            return "p"
        
        assert False, f"not a valid structured statement {stmt}"

    def postvisit_structured_statement(self, stmt: StructuredStatement) -> None:
        if stmt.label:
            self.write(stmt.label)
            self.write(" ")

        self.write("$")
        self.write(self.get_statement_type(stmt))

        for term in stmt.terms:
            self.write(" ")
            self.visit(term)

        if isinstance(stmt, ProvableStatement):
            if stmt.proof is not None:
                if self.omit_proof:
                    self.write(" $= <omitted>")
                else:
                    self.write(" $= ")
                    self.encode_proof(stmt)
            else:
                self.write(" $= ?")

        self.write(" $.")

    def postvisit_block(self, block: Block) -> None:
        self.write("${ ")

        with self.indentation():
            for i, stmt in enumerate(block.statements):
                self.visit(stmt)
                if i + 1 != len(block.statements):
                    self.write("\n")
                else:
                    self.write(" ")

        self.write("$}")

    def postvisit_database(self, database: Database) -> None:
        for stmt in database.statements:
            self.visit(stmt)
            self.write("\n")
