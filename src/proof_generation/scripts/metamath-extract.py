from __future__ import annotations

import argparse
import itertools

from ..metamath.ast import (  # noqa: TC002
    Application,
    AxiomaticStatement,
    ConstantStatement,
    DisjointStatement,
    FloatingStatement,
    Metavariable,
    ProvableStatement,
    Statement,
    StructuredStatement,
    Terms,
    VariableStatement,
)
from ..metamath.backend import NullBackend, StandaloneFileBackend
from ..metamath.composer import Composer, Theorem  # noqa: TC002
from ..metamath.parser import load_database


def get_metamath_symbols(terms: Terms) -> set[str]:
    ret: set[str] = set()
    for term in terms:
        if isinstance(term, Application):
            ret = ret.union({term.symbol}, get_metamath_symbols(term.subterms))
    return ret


def compressed_proof_get_lemmas(proof: str) -> tuple[str, ...]:
    lemmas_begin = proof.find('(') + 1
    lemmas_end = proof.find(')', lemmas_begin)
    assert 0 <= lemmas_begin < lemmas_end, 'Can only parse compressed proofs.'
    return tuple(proof[lemmas_begin:lemmas_end].split())


def theorem_get_disjoints(theorem: Theorem) -> tuple[DisjointStatement, ...]:
    ret = []
    for disjoint in theorem.context.disjoints:
        new_vars = tuple(
            Metavariable(var) for var in theorem.statement.get_metavariables() if var in disjoint.get_metavariables()
        )
        if new_vars:
            ret += [DisjointStatement(new_vars)]
    return tuple(ret)


def copy_with_context(
    hypotheses: tuple[Statement, ...], conclusion: StructuredStatement, output_composer: Composer
) -> None:
    with output_composer.new_context():
        for hypothesis in hypotheses:
            output_composer.load(hypothesis)
        output_composer.load(conclusion)


def extract_proof(input_composer: Composer, output_composer: Composer, theorem_name: str) -> None:
    theorem = input_composer.get_theorem(theorem_name)
    assert isinstance(theorem.statement, ProvableStatement)
    proof = theorem.statement.proof
    assert proof, 'Theorem has no proof.'

    lemmas: tuple[Theorem, ...] = tuple(
        input_composer.get_theorem(lemma) for lemma in compressed_proof_get_lemmas(proof)
    )

    mm_symbols: set[str] = {'(', ')'}
    variables: set[str] = set()
    for t in (*lemmas, theorem):
        for statement in (
            *t.context.essentials,
            *t.context.floatings,
            t.statement,
        ):
            mm_symbols = mm_symbols.union(get_metamath_symbols(statement.terms))
            variables = variables.union(statement.get_metavariables())

    for symbol in mm_symbols:
        output_composer.load(ConstantStatement((symbol,)))
    for variable in variables:
        output_composer.load(VariableStatement((Metavariable(variable),)))

    processed_floatings: list[FloatingStatement] = []
    for floating in itertools.chain(*(lemma.context.floatings for lemma in (*lemmas, theorem))):
        if floating in processed_floatings:
            continue
        processed_floatings += [floating]
        output_composer.load(floating)

    for lemma in lemmas:
        copy_with_context(
            (*theorem_get_disjoints(lemma), *lemma.context.essentials),
            AxiomaticStatement(lemma.statement.label, lemma.statement.terms),
            output_composer,
        )
    copy_with_context(
        (*theorem_get_disjoints(theorem), *theorem.context.essentials),
        theorem.statement,
        output_composer,
    )


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument('input', help='Input Metamath file')
    parser.add_argument('output', help='Output Metamath file')
    parser.add_argument('theorem', help='Name of the theorem to extract')
    args = parser.parse_args()

    input_backend = NullBackend()
    input_composer = Composer(backend=input_backend)
    input_composer.load(load_database(args.input, include_proof=True))

    with StandaloneFileBackend(args.output) as output_backend:
        output_composer = Composer(backend=output_backend)
        extract_proof(input_composer, output_composer, args.theorem)


if __name__ == '__main__':
    main()
