from __future__ import annotations

import argparse
from pathlib import Path
from typing import Iterable, Iterator, cast

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
    Statement,
    StructuredStatement,
    Terms,
    VariableStatement,
)
from ..metamath.parser import load_database


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


def compressed_proof_get_lemmas(proof: str) -> tuple[str, ...]:
    lemmas_begin = proof.find('(') + 1
    lemmas_end = proof.find(')', lemmas_begin)
    assert 0 <= lemmas_begin < lemmas_end, 'Can only parse compressed proofs.'
    return tuple(proof[lemmas_begin:lemmas_end].split())


def supporting_database_for_provable(
    cut_antecedents: dict[str, FloatingStatement | AxiomaticStatement | Block],
    global_disjoints: set[frozenset[str]],
    provable: ProvableStatement,
    essentials: tuple[DisjointStatement | EssentialStatement, ...],
) -> Database:
    statements: list[Statement] = []

    proof = provable.proof
    assert proof, f'Proof is missing for {provable.label}'
    needed_lemmas = compressed_proof_get_lemmas(proof)

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
        assert label
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


def slice_database(input_database: Database) -> Iterator[tuple[str, Database]]:
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
            yield (
                consequent.label,
                supporting_database_for_provable(cut_antecedents, global_disjoints, consequent, antecedents),
            )
            cut_antecedents[consequent.label] = construct_axiom(antecedents, consequent)
        else:
            assert 'Unanticipated statement type', type(statement)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument('input', help='Input Metamath file')
    parser.add_argument('output', help='Output Metamath directory')
    args = parser.parse_args()

    print('Parsing database.')
    input_database = load_database(args.input, include_proof=True)
    print('Database parsed.')

    output_dir = Path(args.output)
    output_dir.mkdir()
    for label, slice in slice_database(input_database):
        with open(output_dir / (label + '.mm'), 'w') as output_file:
            Encoder.encode(output_file, slice)
        print(f'Extracted {label}.', end='\x1b[2K\r')


if __name__ == '__main__':
    main()
