from __future__ import annotations

from dataclasses import dataclass, field
from io import StringIO
from typing import TYPE_CHECKING, TypeVar

from ..utils.printer import Printer
from ..utils.visitor import ResultT, Visitor

if TYPE_CHECKING:
    from collections.abc import Mapping
    from typing import Any, TextIO


class MetamathVisitor(Visitor['BaseAST', ResultT]):
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

    def visit_children_of_application(self, application: Application) -> list[list[Any]]:
        return [
            [subterm.visit(self) for subterm in application.subterms],
        ]

    def visit_children_of_structured_statement(self, stmt: StructuredStatement) -> list[list[Any]]:
        return [
            [term.visit(self) for term in stmt.terms],
        ]

    def visit_children_of_block(self, block: Block) -> list[list[Any]]:
        return [
            [stmt.visit(self) for stmt in block.statements],
        ]

    def visit_children_of_database(self, database: Database) -> list[list[Any]]:
        return [
            [stmt.visit(self) for stmt in database.statements],
        ]


class BaseAST:
    def __str__(self) -> str:
        return Encoder.encode_string(self, omit_proof=True)

    def __repr__(self) -> str:
        return str(self)


@dataclass
class Term(BaseAST):
    def get_metavariables(self) -> set[str]:
        raise NotImplementedError()

    def substitute(self, substitution: Mapping[str, Term]) -> Term:
        raise NotImplementedError()

    def visit(self, visitor: MetamathVisitor[ResultT]) -> ResultT:
        raise NotImplementedError()

    def get_size(self) -> int:
        raise NotImplementedError()


@dataclass
class Metavariable(Term):
    name: str

    def get_metavariables(self) -> set[str]:
        return {self.name}

    def substitute(self, substitution: Mapping[str, Term]) -> Term:
        if self.name in substitution:
            return substitution[self.name]
        else:
            return self

    def visit(self, visitor: MetamathVisitor[ResultT]) -> ResultT:
        return visitor.proxy_visit_metavariable(self)  # type: ignore

    def get_size(self) -> int:
        return 1

    def __hash__(self) -> int:
        return hash(self.name)

    def __gt__(self, other: Any) -> bool:
        assert isinstance(other, Metavariable)
        return self.name > other.name


@dataclass
class Application(Term):
    symbol: str
    subterms: tuple[Term, ...] = ()
    hash_cache: int | None = field(default=None, compare=False)

    def get_metavariables(self) -> set[str]:
        metavars = set()
        for subterm in self.subterms:
            metavars.update(subterm.get_metavariables())
        return metavars

    def substitute(self, substitution: Mapping[str, Term]) -> Application:
        return Application(self.symbol, tuple(subterm.substitute(substitution) for subterm in self.subterms))

    def visit(self, visitor: MetamathVisitor[ResultT]) -> ResultT:
        return visitor.proxy_visit_application(self)  # type: ignore

    def get_size(self) -> int:
        return 1 + sum(term.get_size() for term in self.subterms)

    def __hash__(self) -> int:
        if self.hash_cache is not None:
            return self.hash_cache

        final_hash = hash(self.symbol)
        for subterm in self.subterms:
            final_hash ^= hash(subterm)

        self.hash_cache = final_hash
        return final_hash


class Statement(BaseAST):
    def get_metavariables(self) -> set[str]:
        return set()

    def substitute(self, substitution: Mapping[str, Term]) -> Statement:
        raise NotImplementedError()

    def visit(self, visitor: MetamathVisitor[ResultT]) -> ResultT:
        raise NotImplementedError()


@dataclass
class ConstantStatement(Statement):
    constants: tuple[str, ...]

    def visit(self, visitor: MetamathVisitor[ResultT]) -> ResultT:
        return visitor.proxy_visit_constant_statement(self)  # type: ignore


@dataclass
class VariableStatement(Statement):
    metavariables: tuple[Metavariable, ...]

    def visit(self, visitor: MetamathVisitor[ResultT]) -> ResultT:
        return visitor.proxy_visit_variable_statement(self)  # type: ignore


@dataclass
class DisjointStatement(Statement):
    metavariables: tuple[Metavariable, ...]

    def visit(self, visitor: MetamathVisitor[ResultT]) -> ResultT:
        return visitor.proxy_visit_disjoint_statement(self)  # type: ignore


Terms = tuple[Term, ...]
StmtT = TypeVar('StmtT', bound='StructuredStatement')


@dataclass
class StructuredStatement(Statement):
    label: str
    terms: Terms

    def get_metavariables(self) -> set[str]:
        metavars = set()
        for term in self.terms:
            metavars.update(term.get_metavariables())
        return metavars

    def substitute(self: StmtT, substitution: Mapping[str, Term]) -> StmtT:
        return type(self)(self.label, tuple(term.substitute(substitution) for term in self.terms))

    def visit(self, visitor: MetamathVisitor[ResultT]) -> ResultT:
        return visitor.proxy_visit_structured_statement(self)  # type: ignore


@dataclass
class FloatingStatement(StructuredStatement):
    typecode: str = field(default='', init=False)
    metavariable: str = field(default='', init=False)

    def __post_init__(self) -> None:
        assert (
            len(self.terms) == 2 and isinstance(self.terms[0], Application) and isinstance(self.terms[1], Metavariable)
        )
        self.typecode = self.terms[0].symbol
        self.metavariable = self.terms[1].name


class EssentialStatement(StructuredStatement):
    ...


class ConclusionStatement(StructuredStatement):
    ...


class AxiomaticStatement(ConclusionStatement):
    ...


@dataclass
class ProvableStatement(ConclusionStatement):
    proof: str | None = None


@dataclass
class Comment(Statement):
    text: str

    def visit(self, visitor: MetamathVisitor[ResultT]) -> ResultT:
        return visitor.proxy_visit_comment(self)  # type: ignore


@dataclass
class IncludeStatement(Statement):
    path: str

    def visit(self, visitor: MetamathVisitor[ResultT]) -> ResultT:
        return visitor.proxy_visit_include_statement(self)  # type: ignore


@dataclass
class Block(Statement):
    """
    A block is a list of statements,
    while itself is also a statement
    """

    statements: tuple[Statement, ...]

    def visit(self, visitor: MetamathVisitor[ResultT]) -> ResultT:
        return visitor.proxy_visit_block(self)  # type: ignore


@dataclass
class Database(BaseAST):
    """
    A database consists of a single outermost block
    and some auxiliary information
    e.g. set of variables and mapping from labels to statements
    """

    statements: tuple[Statement, ...]

    def visit(self, visitor: MetamathVisitor[ResultT]) -> ResultT:
        return visitor.proxy_visit_database(self)  # type: ignore


class Encoder(Printer, Visitor[BaseAST, None]):
    """
    Encoder for Metamath AST with options
    """

    def __init__(self, output: TextIO, tab: str = '   ', omit_proof: bool = False):
        super().__init__(output, tab)
        self.omit_proof = omit_proof

    @staticmethod
    def encode(output: TextIO, ast: BaseAST, *args: Any, **kwargs: Any) -> None:
        encoder = Encoder(output, *args, **kwargs)
        encoder.visit(ast)
        encoder.flush()

    @staticmethod
    def encode_string(ast: BaseAST, *args: Any, **kwargs: Any) -> str:
        stream = StringIO()
        Encoder.encode(stream, ast, *args, **kwargs)
        return stream.getvalue()

    def postvisit_metavariable(self, metavar: Metavariable) -> None:
        self.write(metavar.name)

    def postvisit_application(self, application: Application) -> None:
        if len(application.subterms) == 0:
            self.write(application.symbol)
        else:
            self.write('( ')
            self.write(application.symbol)

            for subterm in application.subterms:
                self.write(' ')
                assert isinstance(subterm, Term), f'not a term: {subterm}'
                self.visit(subterm)

            self.write(' )')

    def postvisit_constant_statement(self, constant_statement: ConstantStatement) -> None:
        self.write('$c')
        for constant in constant_statement.constants:
            self.write(' ')
            self.write(constant)
        self.write(' $.')

    def postvisit_variable_statement(self, variable_statement: VariableStatement) -> None:
        self.write('$v')
        for metavar in variable_statement.metavariables:
            self.write(' ')
            self.visit(metavar)
        self.write(' $.')

    def postvisit_disjoint_statement(self, disjoint_statement: DisjointStatement) -> None:
        self.write('$d')
        for metavar in disjoint_statement.metavariables:
            self.write(' ')
            self.visit(metavar)
        self.write(' $.')

    def postvisit_comment(self, comment: Comment) -> None:
        self.write('\n$(')
        if not comment.text[:-1].isspace():
            self.write(' ')

        with self.indentation():
            self.write(comment.text)

        if not comment.text[-1:].isspace():
            self.write(' ')
        self.write('$)')

    def postvisit_include_statement(self, include: IncludeStatement) -> None:
        self.write('$[ ')
        self.write(include.path)
        self.write(' $]')

    def get_statement_type(self, stmt: StructuredStatement) -> str:
        if isinstance(stmt, FloatingStatement):
            return 'f'
        elif isinstance(stmt, EssentialStatement):
            return 'e'
        elif isinstance(stmt, AxiomaticStatement):
            return 'a'
        elif isinstance(stmt, ProvableStatement):
            return 'p'
        else:
            return '?'

    def postvisit_structured_statement(self, stmt: StructuredStatement) -> None:
        if stmt.label:
            self.write(stmt.label)
            self.write(' ')

        self.write('$')
        self.write(self.get_statement_type(stmt))

        for term in stmt.terms:
            self.write(' ')
            self.visit(term)

        if isinstance(stmt, ProvableStatement):
            if stmt.proof is not None:
                if self.omit_proof:
                    self.write(' $= <omitted>')
                else:
                    self.write(' $= ')
                    self.write(stmt.proof)
            else:
                self.write(' $= ?')

        self.write(' $.')

    def postvisit_block(self, block: Block) -> None:
        self.write('${ ')

        with self.indentation():
            for i, stmt in enumerate(block.statements):
                self.visit(stmt)
                if i + 1 != len(block.statements):
                    self.write('\n')
                else:
                    self.write(' ')

        self.write('$}')

    def postvisit_database(self, database: Database) -> None:
        for stmt in database.statements:
            self.visit(stmt)
            self.write('\n')
