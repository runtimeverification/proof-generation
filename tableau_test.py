from aml import *
from tableau import *
from typing import Optional

def test_definition_list() -> None:
    assert definition_list(SVar("X"), []) == []
    assert definition_list(Mu(SVar("X"), App(Symbol("S"), SVar("X"))), []) == [Mu(SVar("X"), App(Symbol("S"), SVar("X")))]
    assert definition_list(Mu(SVar("X"), Nu(SVar("Y"), App(Symbol("S"), SVar("X")))), []) \
        == [ Mu(SVar("X"), Nu(SVar("Y"), App(Symbol("S"), SVar("X"))))
           , Nu(SVar("Y"), App(Symbol("S"), SVar(0)))
           ]

def test_is_satisfiable() -> None:
    assert     is_satisfiable([Symbol("X")])
    assert     is_satisfiable([Symbol("X"), Not(Symbol("Y"))])
    assert not is_satisfiable([Symbol("X"), Not(Symbol("X"))])

    assert     is_satisfiable([App(Symbol("X"), Symbol("Y"))])
    assert     is_satisfiable([DApp(Not(Symbol("X")), Not(Symbol("Y")))])
    assert not is_satisfiable([  App(Symbol("X"), Symbol("Y"))
                              , DApp(Not(Symbol("X")), Not(Symbol("Y")))
                              ])

    assert     is_satisfiable([And(Symbol("X"), Not(Symbol("Y")))])
    assert not is_satisfiable([And(Symbol("X"), Not(Symbol("X")))])
    assert not is_satisfiable([And(  App(Symbol("X"), Symbol("Y"))
                                  , DApp(Not(Symbol("X")), Not(Symbol("Y")))
                                  )
                              ])

    assert     is_satisfiable([And(Symbol("X"), Not(Symbol("Y")))])
    assert not is_satisfiable([And(Symbol("X"), Not(Symbol("X")))])
    assert not is_satisfiable([And(  App(Symbol("X"), Symbol("Y"))
                                  , DApp(Not(Symbol("X")), Not(Symbol("Y")))
                                  )
                              ])

    assert     is_satisfiable([Or(Symbol("X"), Not(Symbol("X")))])
    assert     is_satisfiable([Or(  App(Symbol("X"), Symbol("Y"))
                                 , DApp(Not(Symbol("X")), Not(Symbol("Y")))
                                 )
                              ])
    assert not is_satisfiable([Or( And(Symbol("X"), Not(Symbol("X")))
                                 , And(Symbol("X"), Not(Symbol("X")))
                                 )]
                             )
