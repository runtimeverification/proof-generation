from aml import *
from tableau import *

S = Symbol("S")
C = Symbol("C")
NEXT = Symbol("next")
X = SVar("X")
Y = SVar("Y")

def test_definition_list() -> None:
    assert definition_list(X, []) == []
    assert definition_list(Mu(X, App(S, X)), []) == [Mu(X, App(S, X))]
    assert definition_list(Mu(X, Nu(Y, App(S, X))), []) \
        == [ Mu(X, Nu(Y, App(S, X)))
           , Nu(Y, App(S, SVar(0)))
           ]

def test_is_satisfiable() -> None:
    assert     is_sat(S)
    assert     is_sat(Not(S))

    assert     is_sat(App(S, C))
    assert     is_sat(DApp(Not(S), Not(C)))

    assert     is_sat(And(S, Not(C)))
    assert not is_sat(And(S, Not(S)))
    assert not is_sat(And(  App(S, C)
                         , DApp(Not(S), Not(C))
                         )
                      )

    assert     is_sat(And(S, Not(C)))
    assert not is_sat(And(S, Not(S)))
    assert not is_sat(And(  App(S, C)
                         , DApp(Not(S), Not(C))
                         )
                      )

    assert     is_sat(Or(S, Not(S)))
    assert     is_sat(Or(  App(S, C)
                        , DApp(Not(S), Not(C))
                        )
                      )
    assert not is_sat(Or( And(S, Not(S))
                        , And(S, Not(S))
                        )
                     )

    assert     is_sat( Nu(X, App(S, X)))
    assert not is_sat( And( Nu(X, And(C, App(S, X)))
                          , DApp(Not(S), Not(C))
                          )
                     )

    assert not is_sat(Mu(X, App(S, X)))

    assert     is_sat(Nu(X, And( Mu(Y, Or(C, App(NEXT , Y)) )
                                       , App(NEXT , X)
                                       )))
    assert not is_sat(Mu(X, And( Nu(Y, Or(C, App(NEXT , Y)) )
                                       , App(NEXT , X)
                                       )))
