from pml import *
from tableau import *

S = Symbol("S")
C = Symbol("C")
NEXT = Symbol("next")
X = SVar("X")
Y = SVar("Y")
e  = EVar("E")
e1 = EVar("E1")
x = EVar("x")

def test_definition_list() -> None:
    assert definition_list(X, []) == []
    assert definition_list(Mu(X, App(S, X)), []) == [Mu(X, App(S, X))]
    assert definition_list(Mu(X, Nu(Y, App(S, X))), []) \
        == [ Mu(X, Nu(Y, App(S, X)))
           , Nu(Y, App(S, SVar(0)))
           ]

def test_is_satisfiable() -> None:
    assert not  is_sat(Bottom())
    assert      is_sat(Top())

#     assert     is_sat(S)
#     assert     is_sat(Not(S))
#
#     assert     is_sat(App(S, C))
#     assert     is_sat(DApp(S, Not(C)))
#
#     assert     is_sat(And(S, Not(C)))
#     assert not is_sat(And(S, Not(S)))
#     assert not is_sat(And(  App(S, C)
#                          , DApp(S, Not(C))
#                          )
#                       )
#
#     assert     is_sat(And(S, Not(C)))
#     assert not is_sat(And(S, Not(S)))
#     assert not is_sat(And(  App(S, C)
#                          , DApp(S, Not(C))
#                          )
#                       )
#
#     assert     is_sat(Or(S, Not(S)))
#     assert     is_sat(Or(  App(S, C)
#                         , DApp(S, Not(C))
#                         )
#                       )
#     assert not is_sat(Or( And(S, Not(S))
#                         , And(S, Not(S))
#                         )
#                      )
#
#     assert     is_sat( Nu(X, App(S, X)))
#     assert not is_sat( And( Nu(X, And(C, App(S, X)))
#                           , DApp(S, Not(C))
#                           )
#                      )
#
#     assert not is_sat(Mu(X, App(S, X)))
#
#     assert     is_sat(Nu(X, And( Mu(Y, Or(C, App(NEXT , Y)) )
#                                        , App(NEXT , X)
#                                        )))
#     assert not is_sat(Mu(X, And( Nu(Y, Or(C, App(NEXT , Y)) )
#                                        , App(NEXT , X)
#                                        )))
#

def test_print_parity_game() -> None:
    p0  = Matches(e, Mu(X, App(S, x)))
    p1  = Matches(e, App(S, App(C), x))
    p21 = Matches(e, App(S, e1, x))
    p22 = Matches(e1, App(C))
    p2  = AllOf(frozenset([ p21 , p22 ]))
    closure = frozenset( [ p0
                         , p1
                         , p2
                         , p21
                         , p22
                         ] )
    assert print_parity_game( PGNode(p0, closure)
                            , { PGNode(p0, closure)  : frozenset([ PGNode(p1, closure) ])
                              , PGNode(p1, closure)  : frozenset([ PGNode(p2, closure) ])
                              , PGNode(p2, closure)  : frozenset([ PGNode(p21, closure), PGNode(p22, closure) ])
                              , PGNode(p21, closure) : frozenset([])
                              , PGNode(p22, closure) : frozenset([])
                              }
                            , definition_list(Mu(X, App(S, x)), [])
                            ) == \
                            [ (0, 1, 1, [1])
                            , (1, 2, 0, [2])
                            , (2, 2, 1, [3, 4])
                            , (3, 2, 0, [])
                            , (4, 2, 0, [])
                            ]
