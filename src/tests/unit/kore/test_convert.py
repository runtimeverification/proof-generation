import pyk.kore.syntax as pyk_kore
import pytest
from pyk.kore.parser import KoreParser as PykKoreParser

import proof_generation.kore.ast as pg_kore
from proof_generation.kore.convert import from_pyk
from proof_generation.kore.parser import parse_pattern as pg_parse_pattern

PykSortVar = pyk_kore.SortVar
PykSortApp = pyk_kore.SortApp
PykPattern = pyk_kore.Pattern
PGSortVariable = pg_kore.SortVariable
PGSortInstance = pg_kore.SortInstance


def test_sorts() -> None:
    assert from_pyk(PykSortVar('Foo')) == PGSortVariable('Foo')
    assert from_pyk(PykSortApp('Foo')) == PGSortInstance('Foo', [])
    assert from_pyk(PykSortApp('Foo', (PykSortVar('T'), PykSortApp('Bar')))) == PGSortInstance(
        'Foo', [PGSortVariable('T'), PGSortInstance('Bar', [])]
    )


DATA_SAME_PARSE_INPUT = (
    ('const', 'c{}()'),
    ('app-un', 'f{}(c{}())'),
    ('app-bin', 'f{}(c1{}(), c2{}())'),
    ('app-nested', 'f{}(c1{}(), g{}(c2{}()))'),
    ('const-sort', 'c{Int{}}()'),
    ('const-var-sort', 'c{S}()'),
    ('app-un-param', 'f{Int{}}(c{}())'),
    ('app-bin-param', 'f{Int{}}(c1{}(), c2{}())'),
    ('app-nested-param', 'f{Int{}}(c1{}(), g{}(c2{}()))'),
    ('const-param-nested', 'c{Int{}, List{Bool{}}}()'),
    ('app-un-param-nested', 'f{Int{}, List{Bool{}}}(c{}())'),
    ('app-bin-param-nested', 'f{Int{}, List{Bool{}}}(c1{}(), c2{}())'),
    ('app-bin-nested-param-nested', 'f{Int{}, List{Bool{}}}(c1{}(), g{}(c2{}()))'),
    ('int', r'\dv{Int{}}("12345")'),
    ('bool', r'\dv{Bool{}}("true")'),
    ('string', r'\dv{String{}}("string")'),
    ('var', r'X:Bool{}'),
    ('var-sort-nested', r'Y:List{Int{}}'),
    ('var-sort-var', r'Y:S'),
    ('var-sort-param-nul', r'Y:List{S}'),
    ('var-sort-param-bin', r'Y:Map{S1,S2}'),
    ('app-kitchen-sink', 'f{Int{}, List{Bool{}}}(Y:Map{S1,S2}, g{}(Y:List{S}))'),
)


def pyk_parse_pattern(input: str) -> PykPattern:
    parser = PykKoreParser(input)
    ret = parser.pattern()
    assert parser.eof
    return ret


@pytest.mark.parametrize('id,input', DATA_SAME_PARSE_INPUT, ids=[id for id, _ in DATA_SAME_PARSE_INPUT])
def test_same_parse(id: str, input: str) -> None:
    assert str(from_pyk(pyk_parse_pattern(input))) == str(pg_parse_pattern(input))
    assert pg_parse_pattern(input) == from_pyk(pyk_parse_pattern(input))
