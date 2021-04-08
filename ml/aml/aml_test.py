from aml import *


def test_free_variables() -> None:
    assert EVar("x").free_variables() == set([EVar("x")])
    assert SVar("x").free_variables() == set([SVar("x")])
    assert Symbol("s").free_variables() == set()

    assert And(EVar("x"), SVar("x")).free_variables() == set([EVar("x"), SVar("x")])
    assert And(EVar("x"), SVar("y")).free_variables() == set([EVar("x"), SVar("y")])

    assert Or(EVar("x"), SVar("x")).free_variables() == set([EVar("x"), SVar("x")])
    assert Or(EVar("x"), SVar("y")).free_variables() == set([EVar("x"), SVar("y")])

    assert App(EVar("x"), SVar("x")).free_variables() == set([EVar("x"), SVar("x")])
    assert App(EVar("x"), SVar("y")).free_variables() == set([EVar("x"), SVar("y")])

    assert Not(And(EVar("x"), SVar("x"))).free_variables() == set(
        [EVar("x"), SVar("x")]
    )
    assert Not(And(EVar("x"), SVar("y"))).free_variables() == set(
        [EVar("x"), SVar("y")]
    )

    assert Exists(EVar("x"), SVar("x")).free_variables() == set([SVar("x")])
    assert Exists(EVar("x"), EVar("x")).free_variables() == set()

    assert Forall(EVar("x"), SVar("x")).free_variables() == set([SVar("x")])
    assert Forall(EVar("x"), EVar("x")).free_variables() == set()

    assert Mu(SVar("x"), EVar("x")).free_variables() == set([EVar("x")])
    assert Mu(SVar("x"), SVar("x")).free_variables() == set()

    assert Nu(SVar("x"), EVar("x")).free_variables() == set([EVar("x")])
    assert Nu(SVar("x"), SVar("x")).free_variables() == set()


def test_substitute() -> None:
    assert Exists(EVar("x"), EVar("x")).substitute(EVar("x"), EVar("v")) == Exists(
        EVar("x"), EVar("x")
    )
    assert Exists(EVar("x"), SVar("x")).substitute(EVar("x"), EVar("v")) == Exists(
        EVar("x"), SVar("x")
    )
    assert Exists(EVar("y"), EVar("x")).substitute(EVar("x"), EVar("v")) == Exists(
        EVar("y"), EVar("v")
    )
    assert Exists(EVar("y"), SVar("x")).substitute(EVar("x"), EVar("v")) == Exists(
        EVar("y"), SVar("x")
    )

    assert Exists(EVar("x"), EVar("x")).substitute(SVar("x"), EVar("v")) == Exists(
        EVar("x"), EVar("x")
    )
    assert Exists(EVar("x"), SVar("x")).substitute(SVar("x"), EVar("v")) == Exists(
        EVar("x"), EVar("v")
    )
    assert Exists(EVar("y"), EVar("x")).substitute(SVar("x"), EVar("v")) == Exists(
        EVar("y"), EVar("x")
    )
    assert Exists(EVar("y"), SVar("x")).substitute(SVar("x"), EVar("v")) == Exists(
        EVar("y"), EVar("v")
    )

    assert Forall(EVar("x"), EVar("x")).substitute(EVar("x"), EVar("v")) == Forall(
        EVar("x"), EVar("x")
    )
    assert Forall(EVar("x"), SVar("x")).substitute(EVar("x"), EVar("v")) == Forall(
        EVar("x"), SVar("x")
    )
    assert Forall(EVar("y"), EVar("x")).substitute(EVar("x"), EVar("v")) == Forall(
        EVar("y"), EVar("v")
    )
    assert Forall(EVar("y"), SVar("x")).substitute(EVar("x"), EVar("v")) == Forall(
        EVar("y"), SVar("x")
    )

    assert Forall(EVar("x"), EVar("x")).substitute(SVar("x"), EVar("v")) == Forall(
        EVar("x"), EVar("x")
    )
    assert Forall(EVar("x"), SVar("x")).substitute(SVar("x"), EVar("v")) == Forall(
        EVar("x"), EVar("v")
    )
    assert Forall(EVar("y"), EVar("x")).substitute(SVar("x"), EVar("v")) == Forall(
        EVar("y"), EVar("x")
    )
    assert Forall(EVar("y"), SVar("x")).substitute(SVar("x"), EVar("v")) == Forall(
        EVar("y"), EVar("v")
    )

    assert Mu(SVar("x"), EVar("x")).substitute(EVar("x"), EVar("v")) == Mu(
        SVar("x"), EVar("v")
    )
    assert Mu(SVar("x"), SVar("x")).substitute(EVar("x"), EVar("v")) == Mu(
        SVar("x"), SVar("x")
    )
    assert Mu(SVar("y"), SVar("x")).substitute(EVar("x"), EVar("v")) == Mu(
        SVar("y"), SVar("x")
    )
    assert Mu(SVar("y"), EVar("x")).substitute(EVar("x"), EVar("v")) == Mu(
        SVar("y"), EVar("v")
    )

    assert Mu(SVar("x"), EVar("x")).substitute(SVar("x"), EVar("v")) == Mu(
        SVar("x"), EVar("x")
    )
    assert Mu(SVar("x"), SVar("x")).substitute(SVar("x"), EVar("v")) == Mu(
        SVar("x"), SVar("x")
    )
    assert Mu(SVar("y"), EVar("x")).substitute(SVar("x"), EVar("v")) == Mu(
        SVar("y"), EVar("x")
    )
    assert Mu(SVar("y"), SVar("x")).substitute(SVar("x"), EVar("v")) == Mu(
        SVar("y"), EVar("v")
    )

    assert Nu(SVar("x"), EVar("x")).substitute(EVar("x"), EVar("v")) == Nu(
        SVar("x"), EVar("v")
    )
    assert Nu(SVar("x"), SVar("x")).substitute(EVar("x"), EVar("v")) == Nu(
        SVar("x"), SVar("x")
    )
    assert Nu(SVar("y"), SVar("x")).substitute(EVar("x"), EVar("v")) == Nu(
        SVar("y"), SVar("x")
    )
    assert Nu(SVar("y"), EVar("x")).substitute(EVar("x"), EVar("v")) == Nu(
        SVar("y"), EVar("v")
    )

    assert Nu(SVar("x"), EVar("x")).substitute(SVar("x"), EVar("v")) == Nu(
        SVar("x"), EVar("x")
    )
    assert Nu(SVar("x"), SVar("x")).substitute(SVar("x"), EVar("v")) == Nu(
        SVar("x"), SVar("x")
    )
    assert Nu(SVar("y"), EVar("x")).substitute(SVar("x"), EVar("v")) == Nu(
        SVar("y"), EVar("x")
    )
    assert Nu(SVar("y"), SVar("x")).substitute(SVar("x"), EVar("v")) == Nu(
        SVar("y"), EVar("v")
    )

    assert And(
        Or(SVar("a"), SVar("b")), App(App(Symbol("c"), SVar("d")), SVar("e"))
    ).substitute(SVar("a"), SVar("x")) == And(
        Or(SVar("x"), SVar("b")), App(App(Symbol("c"), SVar("d")), SVar("e"))
    )
    assert And(
        Or(SVar("a"), SVar("b")), App(App(Symbol("c"), SVar("d")), SVar("e"))
    ).substitute(SVar("b"), SVar("x")) == And(
        Or(SVar("a"), SVar("x")), App(App(Symbol("c"), SVar("d")), SVar("e"))
    )
    assert And(
        Or(SVar("a"), SVar("b")), App(App(Symbol("c"), SVar("d")), SVar("e"))
    ).substitute(SVar("c"), SVar("x")) == And(
        Or(SVar("a"), SVar("b")), App(App(Symbol("c"), SVar("d")), SVar("e"))
    )
    assert And(
        Or(SVar("a"), SVar("b")), App(App(Symbol("c"), SVar("d")), SVar("e"))
    ).substitute(SVar("d"), SVar("x")) == And(
        Or(SVar("a"), SVar("b")), App(App(Symbol("c"), SVar("x")), SVar("e"))
    )
    assert And(
        Or(SVar("a"), SVar("b")), App(App(Symbol("c"), SVar("d")), SVar("e"))
    ).substitute(SVar("e"), SVar("x")) == And(
        Or(SVar("a"), SVar("b")), App(App(Symbol("c"), SVar("d")), SVar("x"))
    )
