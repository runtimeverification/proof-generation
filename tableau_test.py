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
    assert     SimpleNode([SVar("X")]).is_consitant()
    assert     SimpleNode([SVar("X"), Not(SVar("Y"))]).is_consitant()
    assert     SimpleNode([SVar("X"), Not(EVar("X"))]).is_consitant()
    assert not SimpleNode([SVar("X"), Not(SVar("X"))]).is_consitant()

def test_children() -> None:
    assert SimpleNode([SVar("X"), Not(SVar("X"))]).children() == OrNode([])
    assert SimpleNode([SVar("X"), SVar("X")]).children()      == AndNode([])

    assert SimpleNode([App(SVar("X"), SVar("Y")), DApp(SVar("P"), SVar("Q"))]).children() \
        == AndNode([ OrNode([ AndNode([ SimpleNode([SVar("X")])
                                      , SimpleNode([SVar("Y"), SVar("Q")])
                                      ])
                            , AndNode([ SimpleNode([SVar("X"), SVar("P")])
                                      , SimpleNode([SVar("Y")])
                                      ])
                            ])

                   ])
