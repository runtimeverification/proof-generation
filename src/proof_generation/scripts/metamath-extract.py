from __future__ import annotations

import argparse
import base64
from pathlib import Path
from typing import TYPE_CHECKING, cast

from ..metamath.ast import (
    Application,
    AxiomaticStatement,
    Block,
    ConstantStatement,
    Database,
    DisjointStatement,
    Encoder,
    EssentialStatement,
    FloatingStatement,
    Metavariable,
    ProvableStatement,
    StructuredStatement,
    VariableStatement,
)
from ..metamath.parser import load_database

if TYPE_CHECKING:
    from collections.abc import Iterable, Iterator

    from ..metamath.ast import Statement, Term, Terms


def get_constants(terms: Terms) -> set[str]:
    ret: set[str] = {'(', ')', '#Variable', '#ElementVariable', '#SetVariable', '#Pattern', '#Symbol'}
    for term in terms:
        if isinstance(term, Application):
            ret = ret.union({term.symbol}, get_constants(term.subterms))
    return ret


def statements_get_constants(statements: Iterable[Statement]) -> set[str]:
    ret = set()
    for statement in statements:
        if isinstance(statement, StructuredStatement):
            ret.update(get_constants(statement.terms))
        elif isinstance(statement, Block):
            ret.update(statements_get_constants(statement.statements))
        elif isinstance(statement, DisjointStatement):
            continue
        else:
            raise RuntimeError('Unexpected statement type', type(statement))
    return ret


def deconstruct_compressed_proof(provable: ProvableStatement) -> tuple[tuple[str, ...], str]:
    proof = provable.proof
    assert proof, f'Proof is missing for {provable.label}'
    lemmas_begin = proof.find('(') + 1
    lemmas_end = proof.find(')', lemmas_begin)
    assert 0 <= lemmas_begin < lemmas_end, f'Can only parse compressed proofs. {provable.label}'
    return (tuple(proof[lemmas_begin:lemmas_end].split()), proof[lemmas_end + 1 :])


def supporting_database_for_provable(
    cut_antecedents: dict[str, FloatingStatement | AxiomaticStatement | Block],
    global_disjoints: set[frozenset[str]],
    provable: ProvableStatement,
    essentials: tuple[DisjointStatement | EssentialStatement, ...],
) -> Database:
    statements: list[Statement] = []

    needed_lemmas, _ = deconstruct_compressed_proof(provable)

    needed_constants = set()
    needed_metavariables = set()
    for needed in (provable, *essentials, *(cut_antecedents[lemma_name] for lemma_name in needed_lemmas)):
        needed_constants.update(statements_get_constants((needed,)))
        needed_metavariables.update(needed.get_metavariables())

    statements.append(ConstantStatement(tuple(needed_constants)))
    if needed_metavariables:
        statements.append(VariableStatement(tuple(Metavariable(var) for var in needed_metavariables)))
    for pair in global_disjoints:
        if pair.issubset(needed_metavariables):
            statements.append(DisjointStatement(tuple(Metavariable(var) for var in pair)))
    for lemma_name, lemma_statement in cut_antecedents.items():
        if lemma_name in needed_lemmas or (
            isinstance(lemma_statement, FloatingStatement) and lemma_statement.metavariable in needed_metavariables
        ):
            statements.append(lemma_statement)
    statements.append(Block((*essentials, provable)))

    return Database(tuple(statements))


def is_axiom(statement: Statement) -> bool:
    if isinstance(statement, AxiomaticStatement):
        return True
    if isinstance(statement, Block):
        substatements = list(statement.statements)
        while substatements:
            substatement, *substatements = substatements
            if isinstance(substatement, Block):
                substatements += substatement.statements
            elif not isinstance(substatement, (DisjointStatement, EssentialStatement, AxiomaticStatement)):
                return False
        return True
    return False


def axiom_get_label(statement: Statement) -> str:
    # TODO: We have all this complexity because the `substitution-fold/unfold` axiom is stated in
    # a non-standard way. I don't want to change that until after the PoC.
    if isinstance(statement, AxiomaticStatement):
        return statement.label
    elif isinstance(statement, Block):
        label = None
        substatements = list(statement.statements)
        while substatements:
            substatement, *substatements = substatements
            if isinstance(substatement, Block):
                substatements += substatement.statements
            elif isinstance(substatement, (DisjointStatement, EssentialStatement)):
                continue
            else:
                assert isinstance(substatement, AxiomaticStatement)
                label = substatement.label
        assert label, statement
        return label
    else:
        raise AssertionError('Statement is not axiom?')


def deconstruct_provable(
    statement: ProvableStatement | Block,
) -> tuple[tuple[DisjointStatement | EssentialStatement, ...], ProvableStatement]:
    if isinstance(statement, ProvableStatement):
        return ((), statement)
    elif isinstance(statement, Block):
        assert not is_axiom(statement)
        for substatement in statement.statements[:-1]:
            assert isinstance(substatement, (DisjointStatement, EssentialStatement)), substatement
        assert isinstance(statement.statements[-1], ProvableStatement)
        return (
            cast('tuple[DisjointStatement | EssentialStatement, ...]', tuple(statement.statements[:-1])),
            statement.statements[-1],
        )


def construct_axiom(
    antecedents: tuple[DisjointStatement | EssentialStatement, ...], consequent: ProvableStatement
) -> AxiomaticStatement | Block:
    if not antecedents:
        return AxiomaticStatement(consequent.label, consequent.terms)
    return Block((*antecedents, AxiomaticStatement(consequent.label, consequent.terms)))


def slice_database(input_database: Database, include: set[str], exclude: set[str]) -> Iterator[tuple[str, Database]]:
    """Of the top-level statements, only floating statements are mandatory hypothesis.
    They are thus order sensitive.
    """
    cut_antecedents: dict[str, FloatingStatement | AxiomaticStatement | Block] = {}
    global_disjoints: set[frozenset[str]] = set()

    for statement in input_database.statements:
        """Constants and variables can be ignored since we can deduce the set of constants from the parsed statement."""
        if isinstance(statement, (ConstantStatement, VariableStatement)):
            continue
        elif isinstance(statement, DisjointStatement):
            for var1 in statement.metavariables:
                for var2 in statement.metavariables:
                    if var1 != var2:
                        global_disjoints.add(frozenset({var1.name, var2.name}))
        elif isinstance(statement, FloatingStatement):
            cut_antecedents[statement.label] = statement
        elif is_axiom(statement):
            cut_antecedents[axiom_get_label(statement)] = cast('AxiomaticStatement | Block', statement)
        elif isinstance(statement, (ProvableStatement, Block)):
            antecedents, consequent = deconstruct_provable(statement)
            if (consequent.label in include) and (consequent.label not in exclude):
                yield (
                    consequent.label,
                    supporting_database_for_provable(cut_antecedents, global_disjoints, consequent, antecedents),
                )
            cut_antecedents[consequent.label] = construct_axiom(antecedents, consequent)
        else:
            assert 'Unanticipated statement type', type(statement)


def int_to_abbreviation(n: int) -> str:
    bits_needed = max(n.bit_length(), 1)
    bytes_needed = -(bits_needed // -8)  # Division, rounding up.
    n_as_bytes = n.to_bytes(bytes_needed, byteorder='little')
    n_as_base64 = base64.b64encode(n_as_bytes, altchars=b'.-')
    ascii = n_as_base64.decode('ascii')
    while ascii[-1] == '=':
        ascii = ascii[:-1]
    return ascii


abbreviation_index: dict[str, str] = {
    'goal': 'goal',
    '#Variable': '#Variable',
    '#ElementVariable': '#ElementVariable',
    '#SetVariable': '#SetVariable',
    '#Pattern': '#Pattern',
    '#Symbol': '#Symbol',
}


def abbreviate(name: str) -> str:
    if not name in abbreviation_index:
        abbreviation_index[name] = int_to_abbreviation(len(abbreviation_index))
    assert abbreviation_index[name], abbreviation_index
    return abbreviation_index[name]


def abbreviate_constructors(term: Term) -> Term:
    if isinstance(term, Metavariable):
        return Metavariable(abbreviate(term.name))
    elif isinstance(term, Application):
        return Application(abbreviate(term.symbol), term.subterms)
    else:
        raise RuntimeError(f'Unexpected term type, {type(term)}')


def terms_abbreviate_constructors(terms: Terms) -> Terms:
    return tuple(term.bottom_up(abbreviate_constructors) for term in terms)


def abbreviate_lemmas(statement: Statement) -> Statement:
    if not isinstance(statement, StructuredStatement):
        return statement
    else:
        new_label = abbreviate(statement.label)

        if isinstance(statement, FloatingStatement):
            return FloatingStatement(new_label, terms_abbreviate_constructors(statement.terms))
        elif isinstance(statement, EssentialStatement):
            return EssentialStatement(new_label, terms_abbreviate_constructors(statement.terms))
        elif isinstance(statement, AxiomaticStatement):
            return AxiomaticStatement(new_label, terms_abbreviate_constructors(statement.terms))
        elif isinstance(statement, ProvableStatement):
            if statement.proof:
                lemmas: Iterable[str]
                lemmas, lemma_applications = deconstruct_compressed_proof(statement)
                lemmas = (abbreviate(lemma) for lemma in lemmas)
                proof = '( {} ) {}'.format(' '.join(lemmas), lemma_applications)
            return ProvableStatement(new_label, terms_abbreviate_constructors(statement.terms), proof=proof)
        else:
            raise RuntimeError(f'Unexpected statement type, {type(statement)}')


def collect_provable_names(database: Database) -> set[str]:
    ret = set()

    def collect(stmt: Statement) -> Statement:
        nonlocal ret
        if isinstance(stmt, ProvableStatement):
            ret.add(stmt.label)
        return stmt

    database.bottom_up(collect)
    return ret


def dependency_graph(database: Database) -> dict[str, tuple[str, ...]]:
    ret = {}

    def collect(stmt: Statement) -> Statement:
        nonlocal ret
        if isinstance(stmt, ProvableStatement):
            lemmas, _ = deconstruct_compressed_proof(stmt)
            ret[stmt.label] = lemmas
        return stmt

    database.bottom_up(collect)

    return ret


def transitive_closure(dependency_graph: dict[str, tuple[str, ...]], include: list[str]) -> set[str]:
    unprocessed_lemmas: list[str] = include
    ret: set[str] = set()
    while unprocessed_lemmas:
        lemma, *unprocessed_lemmas = unprocessed_lemmas
        if lemma in dependency_graph and lemma not in ret:
            unprocessed_lemmas += dependency_graph[lemma]
        ret.add(lemma)
    return ret


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument('input', help='Input Metamath database path')
    parser.add_argument('output', help='Output directory')
    parser.add_argument('--exclude', help='Path to metatmath database containing lemmas to exclude')
    parser.add_argument('--abbreviate-lemma-names', required=False, action=argparse.BooleanOptionalAction)
    args = parser.parse_args()

    print('Parsing database...', end='', flush=True)
    input_database = load_database(args.input, include_proof=True)
    print(' Done.')

    output_dir = Path(args.output)
    output_dir.mkdir()

    exclude: set[str] = set()
    if args.exclude:
        print('Parsing exclude database...', end='', flush=True)
        excluded_database = load_database(args.exclude, include_proof=False)
        print(' Done.')
        exclude = collect_provable_names(excluded_database)

    deps = dependency_graph(input_database)
    include: set[str] = transitive_closure(deps, ['goal'])

    if args.abbreviate_lemma_names:
        print('Abbreviating Lemma names...', end='', flush=True)
        input_database = input_database.bottom_up(abbreviate_lemmas)
        exclude = {abbreviation_index[lemma] for lemma in exclude if lemma in abbreviation_index}
        include = {abbreviation_index[lemma] for lemma in include if lemma in abbreviation_index}
        print(' Done.')

    for label, slice in slice_database(input_database, include=include, exclude=exclude):
        with open(output_dir / (label + '.mm'), 'w') as output_file:
            Encoder.encode(output_file, slice)
        print(f'Extracted {label}.', end='\x1b[2K\r', flush=True)


if __name__ == '__main__':
    main()
