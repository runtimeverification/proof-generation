from __future__ import annotations

from typing import TextIO, Optional, List, Set, Union
from io import StringIO

from ml.utils.visitor import Visitor

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


class MetamathVisitor(Visitor):
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
    def encode(self, stream: TextIO):
        raise NotImplementedError()

    def __str__(self):
        stream = StringIO()
        self.encode(stream)
        return stream.getvalue()

    def __repr__(self):
        return str(self)


class Term(BaseAST):
    def encode(self, stream: TextIO):
        raise NotImplementedError()

    def get_metavariables(self) -> Set[str]:
        raise NotImplementedError()

    def visit(self, visitor: MetamathVisitor):
        raise NotImplementedError()


class Metavariable(Term):
    def __init__(self, name: str):
        super().__init__()
        self.name = name

    def encode(self, stream: TextIO):
        stream.write(self.name)

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
    def __init__(self, symbol: str, subterms: List[Term] = []):
        super().__init__()
        self.symbol = symbol
        self.subterms = subterms
        self.hash_cache = None

    def encode(self, stream: TextIO):
        if len(self.subterms):
            stream.write("( ")
            stream.write(self.symbol)
            for subterm in self.subterms:
                stream.write(" ")
                assert isinstance(subterm, Term), "not a term: {}".format(subterm)
                subterm.encode(stream)
            stream.write(" )")
        else:
            stream.write(self.symbol)

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
                if left.symbol == right.symbol and len(left.subterms) == len(
                    right.subterms
                ):
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

    def encode(self, stream: TextIO):
        raise NotImplementedError()

    def visit(self, visitor: MetamathVisitor):
        raise NotImplementedError()


class Comment(Statement):
    def __init__(self, text: str):
        super().__init__()
        self.text = text
        assert "$(" not in text and "$)" not in text

    def encode(self, stream: TextIO):
        stream.write("\n$(")
        if not self.text[:-1].isspace():
            stream.write(" ")

        stream.write(self.text)

        if not self.text[-1:].isspace():
            stream.write(" ")
        stream.write("$)")

    def visit(self, visitor: MetamathVisitor):
        visitor.previsit_comment(self)
        children = visitor.visit_children_of_comment(self)
        return visitor.postvisit_comment(self, *children)


class IncludeStatement(Statement):
    def __init__(self, path: str):
        super().__init__()
        self.path = path

    def encode(self, stream: TextIO):
        stream.write("$[ ")
        stream.write(self.path)
        stream.write(" $]")

    def visit(self, visitor: MetamathVisitor):
        visitor.previsit_include_statement(self)
        children = visitor.visit_children_of_include_statement(self)
        return visitor.postvisit_include_statement(self, *children)


"""
A list of tokens without any structures.
Constant and variable statements are of this kind
"""


class RawStatement(Statement):
    def __init__(
        self, statement_type: str, tokens: List[str], label: Optional[str] = None
    ):
        super().__init__()
        self.statement_type = statement_type
        self.tokens = tokens
        self.label = label

    def encode(self, stream: TextIO):
        if self.label is not None:
            stream.write(self.label)
            stream.write(" ")

        stream.write("$")
        stream.write(self.statement_type)

        for token in self.tokens:
            stream.write(" ")
            stream.write(token)

        stream.write(" $.")

    def visit(self, visitor: MetamathVisitor):
        visitor.previsit_raw_statement(self)
        children = visitor.visit_children_of_raw_statement(self)
        return visitor.postvisit_raw_statement(self, *children)


"""
Structured statement will be parsed as a list of S-expressions
"""


class StructuredStatement(Statement):
    def __init__(
        self,
        statement_type: str,
        terms: List[Term],
        label: Optional[str] = None,
        proof: Optional[List[str]] = None,
    ):
        super().__init__()
        self.statement_type = statement_type
        self.terms = terms
        self.label = label
        self.proof = proof

    def encode(self, stream: TextIO):
        if self.label is not None:
            stream.write(self.label)
            stream.write(" ")

        stream.write("$")
        stream.write(self.statement_type)

        for term in self.terms:
            stream.write(" ")
            term.encode(stream)

        if self.proof is not None:
            stream.write(" $=")
            for label in self.proof:
                stream.write(" ")
                stream.write(label)
        elif self.statement_type == Statement.PROVABLE:
            # the statement is marked provable but no proof is given
            stream.write(" $= ?")

        stream.write(" $.")

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
                self.statement_type == other.statement_type
                and self.terms == other.terms
                and self.label == other.label
                and self.proof == other.proof
            )
        return False


"""
A block is a list of statements,
while itself is also a statement
"""


class Block(Statement):
    def __init__(self, statements: List[Statement]):
        self.statements = statements

    def encode(self, stream: TextIO):
        stream.write("${\n")
        for stmt in self.statements:
            stmt.encode(stream)
            stream.write("\n")
        stream.write("$}")

    def visit(self, visitor: MetamathVisitor):
        visitor.previsit_block(self)
        children = visitor.visit_children_of_block(self)
        return visitor.postvisit_block(self, *children)


"""
A database consists of a single outermost block
and some auxiliary information
e.g. set of variables and mapping from labels to statements
"""


class Database(BaseAST):
    def __init__(self, statements: List[Statement]):
        self.statements = statements

    def encode(self, stream: TextIO):
        for stmt in self.statements:
            stmt.encode(stream)
            stream.write("\n")

    def visit(self, visitor: MetamathVisitor):
        visitor.previsit_database(self)
        children = visitor.visit_children_of_database(self)
        return visitor.postvisit_database(self, *children)
