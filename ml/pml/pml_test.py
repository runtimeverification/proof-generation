from pml import *

x = EVar("x")
y = EVar("y")
v = EVar("v")

s = Symbol("s")

X = SVar("x")
Y = SVar("y")

def test_free_variables() -> None:
    assert x.free_variables() == set([x])
    assert SVar("x").free_variables() == set([SVar("x")])

    assert And(x, SVar("x")).free_variables() == set([x, SVar("x")])
    assert And(x, SVar("y")).free_variables() == set([x, SVar("y")])

    assert Or(x, SVar("x")).free_variables() == set([x, SVar("x")])
    assert Or(x, SVar("y")).free_variables() == set([x, SVar("y")])

    assert App(s, SVar("x")).free_variables() == set([SVar("x")])
    assert App(s, SVar("y")).free_variables() == set([SVar("y")])

    assert DApp(s, SVar("x")).free_variables() == set([SVar("x")])
    assert DApp(s, SVar("y")).free_variables() == set([SVar("y")])

    assert Not(And(x, SVar("x"))).free_variables() == set([x, SVar("x")])
    assert Not(And(x, SVar("y"))).free_variables() == set([x, SVar("y")])

    assert Exists([x], SVar("x")).free_variables() == set([SVar("x")])
    assert Exists([x], x).free_variables() == set()

    assert Forall([x], SVar("x")).free_variables() == set([SVar("x")])
    assert Forall([x], x).free_variables() == set()

    assert Mu(SVar("x"), x).free_variables() == set([x])
    assert Mu(SVar("x"), SVar("x")).free_variables() == set()

    assert Nu(SVar("x"), x).free_variables() == set([x])
    assert Nu(SVar("x"), SVar("x")).free_variables() == set()

def test_substitute() -> None:
    assert Exists(x, x).substitute(x, v) == Exists(x, x)
    assert Exists(x, SVar("x")).substitute(x, v) == Exists(x, SVar("x"))
    assert Exists(y, x).substitute(x, v) == Exists(y, v)
    assert Exists(y, SVar("x")).substitute(x, v) == Exists(y, SVar("x"))

    assert Exists(x, x).substitute(SVar("x"), v) == Exists(x, x)
    assert Exists(x, SVar("x")).substitute(SVar("x"), v) == Exists(x, v)
    assert Exists(y, x).substitute(SVar("x"), v) == Exists(y, x)
    assert Exists(y, SVar("x")).substitute(SVar("x"), v) == Exists(y, v)

    assert Forall(x, x).substitute(x, v) == Forall(x, x)
    assert Forall(x, SVar("x")).substitute(x, v) == Forall(x, SVar("x"))
    assert Forall(y, x).substitute(x, v) == Forall(y, v)
    assert Forall(y, SVar("x")).substitute(x, v) == Forall(y, SVar("x"))

    assert Forall(x, x).substitute(SVar("x"), v) == Forall(x, x)
    assert Forall(x, SVar("x")).substitute(SVar("x"), v) == Forall(x, v)
    assert Forall(y, x).substitute(SVar("x"), v) == Forall(y, x)
    assert Forall(y, SVar("x")).substitute(SVar("x"), v) == Forall(y, v)

    assert Mu(X, x).substitute(x, v) == Mu(X, v)
    assert Mu(X, X).substitute(x, v) == Mu(X, X)
    assert Mu(Y, X).substitute(x, v) == Mu(Y, X)
    assert Mu(Y, x).substitute(x, v) == Mu(Y, v)

    assert Mu(X, x).substitute(X, v) == Mu(X, x)
    assert Mu(X, X).substitute(X, v) == Mu(X, X)
    assert Mu(Y, x).substitute(X, v) == Mu(Y, x)
    assert Mu(Y, X).substitute(X, v) == Mu(Y, v)

    assert Nu(X, x).substitute(x, v) == Nu(X, v)
    assert Nu(X, X).substitute(x, v) == Nu(X, X)
    assert Nu(Y, X).substitute(x, v) == Nu(Y, X)
    assert Nu(Y, x).substitute(x, v) == Nu(Y, v)

    assert Nu(X, x).substitute(X, v) == Nu(X, x)
    assert Nu(X, X).substitute(X, v) == Nu(X, X)
    assert Nu(Y, x).substitute(X, v) == Nu(Y, x)
    assert Nu(Y, X).substitute(X, v) == Nu(Y, v)

#    assert And(Or(SVar("a"), SVar("b")), App(App(Symbol("c"), SVar("d")), SVar("e"))).substitute(SVar("a"), SVar("x")) \
#        == And(Or(SVar("x"), SVar("b")), App(App(Symbol("c"), SVar("d")), SVar("e")))
#    assert And(Or(SVar("a"), SVar("b")), App(App(Symbol("c"), SVar("d")), SVar("e"))).substitute(SVar("b"), SVar("x")) \
#        == And(Or(SVar("a"), SVar("x")), App(App(Symbol("c"), SVar("d")), SVar("e")))
#    assert And(Or(SVar("a"), SVar("b")), App(App(Symbol("c"), SVar("d")), SVar("e"))).substitute(SVar("c"), SVar("x")) \
#        == And(Or(SVar("a"), SVar("b")), App(App(Symbol("c"), SVar("d")), SVar("e")))
#    assert And(Or(SVar("a"), SVar("b")), App(App(Symbol("c"), SVar("d")), SVar("e"))).substitute(SVar("d"), SVar("x")) \
#        == And(Or(SVar("a"), SVar("b")), App(App(Symbol("c"), SVar("x")), SVar("e")))
#    assert And(Or(SVar("a"), SVar("b")), App(App(Symbol("c"), SVar("d")), SVar("e"))).substitute(SVar("e"), SVar("x")) \
#        == And(Or(SVar("a"), SVar("b")), App(App(Symbol("c"), SVar("d")), SVar("x")))
