from pml import *
from tableau import *
from typing import Dict, List

S = Symbol("S")
C = Symbol("C")
NEXT = Symbol("next")
X = SVar("X")
Y = SVar("Y")
e  = EVar("E")
e1 = EVar("E1")
x = EVar("x")
c = EVar("c")
c1 = EVar("c1")
c2 = EVar("c2")
c3 = EVar("c3")
c4 = EVar("c4")

def test_definition_list() -> None:
    assert definition_list(X, []) == []
    assert definition_list(Mu(X, App(S, X)), []) == [Mu(X, App(S, X))]
    assert definition_list(Mu(X, Nu(Y, App(S, X))), []) \
        == [ Mu(X, Nu(Y, App(S, X)))
           , Nu(Y, App(S, SVar(0)))
           ]

def test_add_to_closure() -> None:
    closure = frozenset([ Matches(c, DApp(S, Not(c)))
                        , Matches(c, App(S, c1))
                        , Matches(c, DApp(C))
                        , Matches(c1, App(C))
                        , Matches(c1, DApp(S, Not(c1)))
                        , Matches(c, App(S, App(C)))
                        ])
    closures = set(complete_closure_for_signature([closure], frozenset([c, c1]), [c, c1], { S : 1, C : 0 }))
    assert closures == { closure.union(frozenset([Matches(c1, DApp(S, Not(c)))]))
                       , closure.union(frozenset([Matches(c1,  App(S, c))]))
                       }

def test_build_tableaux() -> None:
    constants = [c, c1, c2, c3, c4]

    assertion = Matches(c, Bottom())
    signature : Dict[Symbol, int] = {} 
    closures = set(build_closures(assertion, constants, signature))
    assert closures == set()
    tableaux = build_tableaux(assertion, constants, signature)
    assert tableaux == []

    assertion = Matches(c, Top())
    signature = {}
    closures = set(build_closures(assertion, constants, signature))
    assert closures == {frozenset([assertion])}
    tableaux = build_tableaux(assertion, constants, signature)
    assert tableaux == [ { frozenset([assertion]) : frozenset() } ]

    assertion = Matches(c, App(C))
    signature = { C : 0 }
    closures = set(build_closures(assertion, constants, signature))
    assert closures == {frozenset([assertion])}
    tableaux = build_tableaux(assertion, constants, signature)
    assert tableaux == [ { frozenset([assertion]) : frozenset() } ]

    assertion = Matches(c, DApp(C))
    signature = { C : 0 }
    closures = set(build_closures(assertion, constants, signature))
    assert closures == {frozenset([assertion])}
    tableaux = build_tableaux(assertion, constants, signature)
    assert tableaux == [ { frozenset([assertion]) : frozenset() } ]
    assertion = Matches(c, App(S, App(C)))
    signature = { S : 1, C : 0 }

    m_0_____ = Matches(c,   App(S,     c))
    m_1_____ = Matches(c,  DApp(S, Not(c)))
    m__0____ = Matches(c,   App(C))
    m__1____ = Matches(c,  DApp(C))
    m___0___ = Matches(c,   App(S, c1))
    m____0__ = Matches(c1, App(S, c1))
    m____1__ = Matches(c1, DApp(S, Not(c1)))
    m_____0_ = Matches(c1, App(S, c))
    m_____1_ = Matches(c1, DApp(S, Not(c)))
    m______0 = Matches(c1, App(C))
    m______1 = Matches(c1, DApp(C))

    cl_00___ = frozenset([assertion, m_0_____,  m__0____])
    cl_10___ = frozenset([assertion, m_1_____,  m__0____])
    cl_01___ = frozenset([assertion, m_0_____,  m__1____])
    cl_11___ = frozenset([assertion, m_1_____,  m__1____])

    closures = set(build_closures(assertion, constants, signature))
    assert closures == { cl_00___, cl_10___, cl_01___, cl_11___ }
    tableaux = build_tableaux(assertion, [c, c1], signature)

    cl_next___0000 = frozenset([m___0___, m____0__, m_____0_, m______0])
    cl_next___0010 = frozenset([m___0___, m____0__, m_____1_, m______0])
    cl_next___0100 = frozenset([m___0___, m____1__, m_____0_, m______0])
    cl_next___0110 = frozenset([m___0___, m____1__, m_____1_, m______0])
    cl_next___0001 = frozenset([m___0___, m____0__, m_____0_, m______1])
    cl_next___0011 = frozenset([m___0___, m____0__, m_____1_, m______1])
    cl_next___0101 = frozenset([m___0___, m____1__, m_____0_, m______1])
    cl_next___0111 = frozenset([m___0___, m____1__, m_____1_, m______1])
    cl_next = [ cl_next___0000, cl_next___0010, cl_next___0100, cl_next___0110 ]

    assert tableaux[0] == { cl_00___ :  frozenset([cl_00___]) }
    assert cl_01___.union(cl_next___0000) in tableaux[1][cl_01___]
    assert cl_01___.union(cl_next___0010) in tableaux[1][cl_01___]
    assert cl_01___.union(cl_next___0100) in tableaux[1][cl_01___]
    assert cl_01___.union(cl_next___0110) in tableaux[1][cl_01___]
    assert tableaux[1][cl_01___] == frozenset([ cl_01___.union(cl_next___0000)
                                              , cl_01___.union(cl_next___0010)
                                              , cl_01___.union(cl_next___0100)
                                              , cl_01___.union(cl_next___0110)
                                              ])

    assertion = Matches(c, And(App(C), DApp(C)))
    closures = set(build_closures(assertion, constants, { C : 0 }))
    assert closures == set()
    tableaux = build_tableaux(assertion, constants, signature)
    assert tableaux == [ ]

    assertion = Matches(c, And(App(S, App(C)), DApp(S, DApp(C))))
    closures = set(build_closures(assertion, [c], { C : 0, S : 1 }))
    cl_00 =  frozenset( [ assertion
                        , Matches(c, App(S, App(C)))
                        , Matches(c, DApp(S, DApp(C)))
                        , Matches(c,  App(S, c))
                        , Matches(c,  App(C))
                        ])
    cl_01 =  frozenset([ assertion
                       , Matches(c,  App(S,  App(C)))
                       , Matches(c, DApp(S, DApp(C)))
                       , Matches(c, DApp(S, Not(c)))
                       , Matches(c,  App(C))
                       ])
    cl_10 =  frozenset([ assertion
                       , Matches(c,  App(S,  App(C)))
                       , Matches(c, DApp(S, DApp(C)))
                       , Matches(c,  App(S, c))
                       , Matches(c, DApp(C))
                       ])
    cl_11 =  frozenset([ assertion
                       , Matches(c,  App(S,  App(C)))
                       , Matches(c, DApp(S, DApp(C)))
                       , Matches(c, DApp(S, Not(c)))
                       , Matches(c, DApp(C))
                       ])

    assert closures == { cl_00,  cl_01, cl_10, cl_11 }
    tableaux = build_tableaux(assertion, [c], signature)
    # Tableaux size grows quickly for larger constant lists
    # 1 --> 0.28s
    # 2 --> 0.36s
    # 3 --> 0.56s
    # 4 --> 25s
    # Tests for larger set of constants gets cumbersome, so we will test more complicated tests using `is_sat`.
    assert(len(tableaux)) == 4
    assert { cl_00 : frozenset([cl_00]) } in tableaux
    assert { cl_01 : frozenset() } in tableaux
    assert { cl_10 : frozenset() } in tableaux
    assert { cl_11 : frozenset() } in tableaux

def xtest_is_satisfiable() -> None:
    assert not is_sat(Bottom())
    assert     is_sat(Top())

    assert not is_sat(And(EVar('c'), Not(EVar('c'))))
    assert not is_sat(And(Not(EVar('c')), EVar('c')))

    assert     is_sat(App(S))
    assert     is_sat(DApp(S))
    assert not is_sat(And(App(S),DApp(S)))

    assert     is_sat(App(S, App(C)))

#    assert not is_sat(And(App(S, App(C)), DApp(S, DApp(C))))



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
