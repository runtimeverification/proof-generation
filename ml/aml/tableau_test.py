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
    assert     is_sat(Symbol("S"))
    assert     is_sat(Not(Symbol("S")))

    assert     is_sat(App(Symbol("S"), Symbol("Y")))
    assert     is_sat(DApp(Not(Symbol("S")), Not(Symbol("Y"))))

    assert     is_sat(And(Symbol("S"), Not(Symbol("Y"))))
    assert not is_sat(And(Symbol("S"), Not(Symbol("S"))))
    assert not is_sat(And(  App(Symbol("S"), Symbol("Y"))
                         , DApp(Not(Symbol("S")), Not(Symbol("Y")))
                         )
                      )

    assert     is_sat(And(Symbol("S"), Not(Symbol("Y"))))
    assert not is_sat(And(Symbol("S"), Not(Symbol("S"))))
    assert not is_sat(And(  App(Symbol("S"), Symbol("Y"))
                         , DApp(Not(Symbol("S")), Not(Symbol("Y")))
                         )
                      )

    assert     is_sat(Or(Symbol("S"), Not(Symbol("S"))))
    assert     is_sat(Or(  App(Symbol("S"), Symbol("Y"))
                        , DApp(Not(Symbol("S")), Not(Symbol("Y")))
                        )
                      )
    assert not is_sat(Or( And(Symbol("S"), Not(Symbol("S")))
                        , And(Symbol("S"), Not(Symbol("S")))
                        )
                     )

    assert     is_sat( Nu(SVar("X"), App(Symbol("S"), SVar("X"))))
    assert not is_sat( And( Nu(SVar("X"), And(Symbol("Y"), App(Symbol("S"), SVar("X"))))
                          , DApp(Not(Symbol("S")), Not(Symbol("Y")))
                          )
                     )

    assert not is_sat(Mu(SVar("X"), App(Symbol("S"), SVar("X"))))

    assert     is_sat(Nu(SVar("X"), And( Mu(SVar("Y"), Or(Symbol("p"), App(Symbol("next") , SVar("Y"))) )
                                       , App(Symbol("next") , SVar("X"))
                                       )))
    assert not is_sat(Mu(SVar("X"), And( Nu(SVar("Y"), Or(Symbol("p"), App(Symbol("next") , SVar("Y"))) )
                                       , App(Symbol("next") , SVar("X"))
                                       )))
