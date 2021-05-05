from __future__ import annotations

from typing import TextIO, Optional, List, Set, Union, Iterable, Any, Dict, Mapping
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
    def visit_children_of_application(self, application: Application):
        return [
            [subterm.visit(self) for subterm in application.subterms],
        ]

    def visit_children_of_structured_statement(self, stmt: StructuredStatement):
        return [
            [term.visit(self) for term in stmt.terms],
        ]

    def visit_children_of_block(self, block: Block):
        return [
            [stmt.visit(self) for stmt in block.statements],
        ]

    def visit_children_of_database(self, database: Database):
        return [
            [stmt.visit(self) for stmt in database.statements],
        ]


class BaseAST:
    def __str__(self) -> str:
        return Encoder.encode_string(self)

    def __repr__(self) -> str:
        return str(self)


class Term(BaseAST):
    def get_metavariables(self) -> Set[str]:
        raise NotImplementedError()

    def visit(self, visitor: MetamathVisitor):
        raise NotImplementedError()


class Metavariable(Term):
    def __init__(self, name: str):
        super().__init__()
        self.name = name

    def get_metavariables(self) -> Set[str]:
        return {self.name}

    def visit(self, visitor: MetamathVisitor):
        visitor.previsit_metavariable(self)
        children = visitor.visit_children_of_metavariable(self)
        return visitor.postvisit_metavariable(self, *children)

    def __eq__(self, other):
        if isinstance(other, Metavariable):
            return self.name == other.name
        return False

    def __hash__(self) -> int:
        return hash(self.name)


class Application(Term):
    def __init__(self, symbol: str, subterms: Iterable[Term] = []):
        super().__init__()
        self.symbol = symbol
        self.subterms = list(subterms)
        self.hash_cache: Optional[int] = None

    def get_metavariables(self) -> Set[str]:
        metavars = set()
        for subterm in self.subterms:
            metavars.update(subterm.get_metavariables())
        return metavars

    def visit(self, visitor: MetamathVisitor):
        visitor.previsit_application(self)
        children = visitor.visit_children_of_application(self)
        return visitor.postvisit_application(self, *children)

    def __eq__(self, other):
        # this function is specifically rewritten
        # to not use recursion since it's used
        # too many times and has become a performance
        # bottleneck
        if not isinstance(other, Application):
            return False

        comparison_left = [self]
        comparison_right = [other]

        while comparison_left:
            left = comparison_left.pop()
            right = comparison_right.pop()

            if type(left) == type(right) == Application:
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
    CONSTANT = "c"
    VARIABLE = "v"
    DISJOINT = "d"
    AXIOM = "a"
    FLOATING = "f"
    ESSENTITAL = "e"
    PROVABLE = "p"

    def visit(self, visitor: MetamathVisitor):
        raise NotImplementedError()


class Comment(Statement):
    def __init__(self, text: str):
        super().__init__()
        self.text = text
        assert "$(" not in text and "$)" not in text

    def visit(self, visitor: MetamathVisitor):
        visitor.previsit_comment(self)
        children = visitor.visit_children_of_comment(self)
        return visitor.postvisit_comment(self, *children)


class IncludeStatement(Statement):
    def __init__(self, path: str):
        super().__init__()
        self.path = path

    def visit(self, visitor: MetamathVisitor):
        visitor.previsit_include_statement(self)
        children = visitor.visit_children_of_include_statement(self)
        return visitor.postvisit_include_statement(self, *children)


class RawStatement(Statement):
    """
    A list of tokens without any structures.
    Constant and variable statements are of this kind
    """
    def __init__(self, statement_type: str, tokens: List[str], label: Optional[str] = None):
        super().__init__()
        self.statement_type = statement_type
        self.tokens = tokens
        self.label = label

    def visit(self, visitor: MetamathVisitor):
        visitor.previsit_raw_statement(self)
        children = visitor.visit_children_of_raw_statement(self)
        return visitor.postvisit_raw_statement(self, *children)


class StructuredStatement(Statement):
    """
    Structured statement will be parsed as a list of S-expressions
    """
    def __init__(
        self,
        statement_type: str,
        terms: List[Term],
        label: Optional[str] = None,
        proof: Optional[Proof] = None,
    ):
        super().__init__()
        self.statement_type = statement_type
        self.terms = terms
        self.label = label
        self.proof = proof

    def get_metavariables(self) -> Set[str]:
        metavars = set()
        for term in self.terms:
            metavars.update(term.get_metavariables())
        return metavars

    def visit(self, visitor: MetamathVisitor):
        visitor.previsit_structured_statement(self)
        children = visitor.visit_children_of_structured_statement(self)
        return visitor.postvisit_structured_statement(self, *children)

    def __eq__(self, other) -> bool:
        if isinstance(other, StructuredStatement):
            return (
                self.statement_type == other.statement_type and self.terms == other.terms and self.label == other.label
                and self.proof == other.proof
            )
        return False


class Block(Statement):
    """
    A block is a list of statements,
    while itself is also a statement
    """
    def __init__(self, statements: Iterable[Statement]):
        self.statements = list(statements)

    def visit(self, visitor: MetamathVisitor):
        visitor.previsit_block(self)
        children = visitor.visit_children_of_block(self)
        return visitor.postvisit_block(self, *children)


class Database(BaseAST):
    """
    A database consists of a single outermost block
    and some auxiliary information
    e.g. set of variables and mapping from labels to statements
    """
    def __init__(self, statements: List[Statement]):
        self.statements = statements

    def visit(self, visitor: MetamathVisitor):
        visitor.previsit_database(self)
        children = visitor.visit_children_of_database(self)
        return visitor.postvisit_database(self, *children)


class Proof:
    """
    A Metamath proof is a tree with each node being a
    statement label and the number of children
    should be equal to the nmuber of mandatory hypotheses

    This datastructure allows both reference to other proofs
    and raw, unparsed proofs to save space
    """
    def __init__(self, conclusion: List[Term]):
        self.conclusion = conclusion

        self.nodes: Dict[int, Union[str, Proof, List[str]]] = {}
        # a node is either:
        # - a label, which can be used for any node in the tree
        # - a Proof, which can only be used for non-leaf nodes
        # - a list of label, which can only be used for leaf nodes (unparsed Metamath proof format)

        self.dag: Dict[int, List[int]] = {}
        # a proof DAG should have a unique source at 0
        # for now it's always a tree
        # if a node has no out-edges, it SHOULD NOT
        # have an entry in self.dag

    @staticmethod
    def from_script(statement: StructuredStatement, script: Union[str, List[str]]) -> Proof:
        """
        Make a proof from the normal proof format as a list of labels
        """
        proof = Proof(statement.terms)
        proof.nodes[0] = script
        return proof

    @staticmethod
    def from_application(statement: StructuredStatement, root: str, children: List[Proof]) -> Proof:
        proof = Proof(statement.terms)
        proof.nodes[0] = root

        if len(children) != 0:
            proof.dag[0] = []
            for i, child in enumerate(children):
                proof.nodes[i + 1] = child
                proof.dag[0].append(i + 1)

        return proof

    def as_statement(self, label: Optional[str] = None) -> StructuredStatement:
        """
        Encode as a provable statement
        """
        return StructuredStatement(
            Statement.PROVABLE,
            self.conclusion,
            label=label,
            proof=self,
        )

    def is_leaf(self, node: int) -> bool:
        return node not in self.dag

    def get_children_of(self, node: int) -> List[int]:
        return self.dag.get(node, [])

    def flatten(self, output_script: List[str], root: int = 0):
        """
        Flatten encodes a recursive hierarchy of proofs
        as the normal Metamath proof format
        """
        for child in self.get_children_of(root):
            self.flatten(output_script, child)

        subproof = self.nodes[root]

        if isinstance(subproof, str):
            output_script.append(subproof)
        elif isinstance(subproof, Proof):
            subproof.flatten(output_script)
        else:
            output_script.extend(subproof)

    def substitute_leaves(self, new_conclusion: StructuredStatement, substitution: Mapping[str, Proof]) -> Proof:
        """
        Substitute some leaf nodes with the given proofs
        """
        new_proof = Proof(new_conclusion.terms)
        new_proof.dag = self.dag

        for node, subproof in self.nodes.items():
            if self.is_leaf(node):
                if isinstance(subproof, str):
                    if subproof in substitution:
                        new_proof.nodes[node] = substitution[subproof]
                    else:
                        new_proof.nodes[node] = subproof
                    continue

                if isinstance(subproof, Proof):
                    # if the subproof is a Proof object
                    # it has to be flattened because
                    # we cannot infer its new conclusion
                    # without context

                    subproof_script: List[str] = []
                    subproof.flatten(subproof_script)
                else:
                    subproof_script = subproof

                # substitute labels in a proof script
                new_script = []
                for label in subproof_script:
                    if label in substitution:
                        flattened: List[str] = []
                        substitution[label].flatten(flattened)
                        new_script.extend(flattened)
                    else:
                        new_script.append(label)

                new_proof.nodes[node] = new_script
            else:
                new_proof.nodes[node] = subproof

        return new_proof

    def __len__(self) -> int:
        size = 0
        for subproof in self.nodes.values():
            if isinstance(subproof, str):
                size += 1
            else:
                size += len(subproof)
        return size

    def __str__(self):
        return f"<proof of {' '.join(self.conclusion)}>"

    def encode(self) -> str:
        script: List[str] = []
        self.flatten(script)
        return " ".join(script)


class Encoder(Printer):
    """
    Encoder for Metamath AST with options
    """
    def __init__(self, output: TextIO, tab: str = "   ", omit_proof: bool = True):
        super().__init__(output, tab)
        self.omit_proof = omit_proof

    @staticmethod
    def encode(output: TextIO, ast: BaseAST, *args, **kwargs):
        printer = Encoder(output, *args, **kwargs)
        printer.visit(ast)
        printer.flush()

    @staticmethod
    def encode_string(ast: BaseAST, *args, **kwargs) -> str:
        stream = StringIO()
        Encoder.encode(stream, ast, *args, **kwargs)
        return stream.getvalue()

    def postvisit_metavariable(self, metavar: Metavariable):
        self.write(metavar.name)

    def postvisit_application(self, application: Application):
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

    def postvisit_comment(self, comment: Comment):
        self.write("\n$(")
        if not comment.text[:-1].isspace():
            self.write(" ")

        with self.indentation():
            self.write(comment.text)

        if not comment.text[-1:].isspace():
            self.write(" ")
        self.write("$)")

    def postvisit_include_statement(self, include: IncludeStatement):
        self.write("$[ ")
        self.write(include.path)
        self.write(" $]")

    def postvisit_raw_statement(self, stmt: RawStatement):
        if stmt.label is not None:
            self.write(stmt.label)
            self.write(" ")

        self.write("$")
        self.write(stmt.statement_type)

        for token in stmt.tokens:
            self.write(" ")
            self.write(token)

        self.write(" $.")

    def postvisit_structured_statement(self, stmt: StructuredStatement):
        if stmt.label is not None:
            self.write(stmt.label)
            self.write(" ")

        self.write("$")
        self.write(stmt.statement_type)

        for term in stmt.terms:
            self.write(" ")
            self.visit(term)

        if stmt.statement_type == Statement.PROVABLE:
            if stmt.proof is not None:
                if self.omit_proof:
                    self.write(" $= <omitted>")
                else:
                    self.write(" $= ")
                    self.write(stmt.proof.encode())
            else:
                self.write(" $= ?")

        self.write(" $.")

    def postvisit_block(self, block: Block):
        self.write("${ ")

        with self.indentation():
            for i, stmt in enumerate(block.statements):
                self.visit(stmt)
                if i + 1 != len(block.statements):
                    self.write("\n")
                else:
                    self.write(" ")

        self.write("$}")

    def postvisit_database(self, database: Database):
        for stmt in database.statements:
            self.visit(stmt)
