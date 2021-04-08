from aml import *
from tableau import *

def test_closure() -> None:
    assert closure(And(SVar("X"), EVar("Y"))) \
        == [ [SVar("X"), EVar("Y")] ]
    assert closure(And(SVar("X"), Or(EVar("Y"), SVar("Z")))) \
        == [ [SVar("X"), EVar("Y")]
           , [SVar("X"), SVar("Z")]
           ]
    assert closure(Or(SVar("X"), Or(EVar("Y"), SVar("Z")))) \
        == [ [SVar("X")]
           , [EVar("Y")]
           , [SVar("Z")]
           ]
    assert closurePs([Or(SVar("X"), Or(EVar("Y"), SVar("Z"))), Symbol("Q")]) \
        == [ [SVar("X"), Symbol("Q")]
           , [EVar("Y"), Symbol("Q")]
           , [SVar("Z"), Symbol("Q")]
           ]
    assert closure(Mu(SVar("X"), Or(Symbol("z"), App(Symbol("s"), SVar("X"))))) \
        == [ [ Symbol("z") ]
           , [ App(Symbol("s"), Mu(SVar("X"), Or(Symbol("z"), App(Symbol("s"), SVar("X"))))) ]
           ]

def test_is_consitant() -> None:
    assert     Sequent([SVar("X")]).is_consitant()
    assert     Sequent([SVar("X"), Not(SVar("Y"))]).is_consitant()
    assert     Sequent([SVar("X"), Not(EVar("X"))]).is_consitant()
    assert not Sequent([SVar("X"), Not(SVar("X"))]).is_consitant()

def test_children() -> None:
    assert Sequent([SVar("X"), Not(SVar("X"))]).children() == OrNode([])
    assert Sequent([SVar("X"), SVar("X")]).children()      == AndNode([])

    assert Sequent([App(SVar("X"), SVar("Y")), DApp(SVar("P"), SVar("Q"))]).children() \
        == AndNode([ OrNode([ AndNode([ Sequent([SVar("X")])
                                      , Sequent([SVar("Y"), SVar("Q")])
                                      ])
                            , AndNode([ Sequent([SVar("X"), SVar("P")])
                                      , Sequent([SVar("Y")])
                                      ])
                            ])

                   ])

def test_tableau() -> None:
    assert build_tableau(Node.make_nodes([Mu(SVar("X"), App(Symbol("a"), App(Symbol("b"), SVar("X"))))]), []) \
        == AndNode([AndNode([ Sequent([Symbol("a")]),
           AndNode([AndNode([ Sequent([Symbol("b")])
                            , Sequent([App(Symbol("a"), App(Symbol("b"), Mu(SVar("X"), App(Symbol("a"), App(Symbol("b"), SVar("X"))))))])
                   ])])])])
