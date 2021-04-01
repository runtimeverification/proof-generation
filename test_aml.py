from aml import *

def test_free_variables():
    assert EVar("x").free_variables() == set([EVar("x")])
    assert SVar("x").free_variables() == set([SVar("x")])
    assert Symbol("s").free_variables() == set()

    assert And(EVar("x"), SVar("x")).free_variables() == set([EVar("x"), SVar("x")])
    assert And(EVar("x"), SVar("y")).free_variables() == set([EVar("x"), SVar("y")])

    assert Or(EVar("x"), SVar("x")).free_variables() == set([EVar("x"), SVar("x")])
    assert Or(EVar("x"), SVar("y")).free_variables() == set([EVar("x"), SVar("y")])

    assert App(EVar("x"), SVar("x")).free_variables() == set([EVar("x"), SVar("x")])
    assert App(EVar("x"), SVar("y")).free_variables() == set([EVar("x"), SVar("y")])

    assert Not(And(EVar("x"), SVar("x"))).free_variables() == set([EVar("x"), SVar("x")])
    assert Not(And(EVar("x"), SVar("y"))).free_variables() == set([EVar("x"), SVar("y")])

    assert Exists(EVar("x"), SVar("x")).free_variables() == set([SVar("x")])
    assert Exists(EVar("x"), EVar("x")).free_variables() == set()

    assert Forall(EVar("x"), SVar("x")).free_variables() == set([SVar("x")])
    assert Forall(EVar("x"), EVar("x")).free_variables() == set()

    # TODO: This should not typecheck!
    # assert Exists(SVar("x"), EVar("x")).free_variables() == set()
    # assert Exists("x", EVar("x")).free_variables() == set()
