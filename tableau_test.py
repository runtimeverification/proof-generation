from aml import *
from tableau import *
from typing import Optional

def tp(p: Pattern, parent: Optional[TracedPattern] = None) -> TracedPattern:
    return TracedPattern(parent, p)

def test_closure() -> None:
    def closure(p: Pattern) -> list[list[Pattern]]:
        return [[traced.pattern for traced in ltp] for ltp in tp(p).closure()]

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
    assert closure(And(Or(SVar("X"), Or(EVar("Y"), SVar("Z"))), Symbol("Q"))) \
        == [ [SVar("X"), Symbol("Q")]
           , [EVar("Y"), Symbol("Q")]
           , [SVar("Z"), Symbol("Q")]
           ]
    assert closure(Mu(SVar("X"), Or(Symbol("z"), App(Symbol("s"), SVar("X"))))) \
        == [ [ Symbol("z") ]
           , [ App(Symbol("s"), Mu(SVar("X"), Or(Symbol("z"), App(Symbol("s"), SVar("X"))))) ]
           ]

def test_is_consitant() -> None:
    assert     Sequent([tp(SVar("X"))]).is_consitant()
    assert     Sequent([tp(SVar("X")), tp(Not(SVar("Y")))]).is_consitant()
    assert     Sequent([tp(SVar("X")), tp(Not(EVar("X")))]).is_consitant()
    assert not Sequent([tp(SVar("X")), tp(Not(SVar("X")))]).is_consitant()


def test_definition_list() -> None:
    assert definition_list(SVar("X"), []) == []
    assert definition_list(Mu(SVar("X"), App(Symbol("S"), SVar("X"))), []) == [Mu(SVar("X"), App(Symbol("S"), SVar("X")))]
    assert definition_list(Mu(SVar("X"), Nu(SVar("Y"), App(Symbol("S"), SVar("X")))), []) \
        == [ Mu(SVar("X"), Nu(SVar("Y"), App(Symbol("S"), SVar("X"))))
           , Nu(SVar("Y"), App(Symbol("S"), SVar(0)))
           ]

def test_children() -> None:
    assert Sequent([tp(SVar("X")), tp(Not(SVar("X")))]).children() == OrNode([])
    assert Sequent([tp(SVar("X")), tp(SVar("X"))]).children()      == AndNode([])

    app = tp(App(SVar("X"), SVar("Y")))
    dapp = tp(DApp(SVar("P"), SVar("Q")))
    assert Sequent([app, dapp]).children() \
        == AndNode([ OrNode([ AndNode([ Sequent([tp(SVar("X"))])
                                      , Sequent([tp(SVar("Y")), tp(SVar("Q"))])
                                      ])
                            , AndNode([ Sequent([tp(SVar("X")), tp(SVar("P"))])
                                      , Sequent([tp(SVar("Y"))])
                                      ])
                            ])
                   ])

def test_quasimodel() -> None:
    mu = tp(Mu(SVar("X"), App(Symbol("a"), App(Symbol("b"), SVar("X")))), None)
    assert build_quasimodel(Node.make_nodes([mu.pattern]), []) \
        == AndNode([AndNode([ Sequent([tp(Symbol("a"), mu)]),
           AndNode([AndNode([ Sequent([tp(Symbol("b"), mu)])
                            , Sequent([tp( App(Symbol("a"), App( Symbol("b") , mu.pattern))
                                         , tp(mu.pattern, mu)
                                         )
                                      ])])])])])

    assert build_quasimodel(Node.make_nodes([ Or( App( Symbol("S") , And(SVar("X"), Not(SVar("X"))) )
                                                , App( Symbol("S") , And(SVar("X"), Not(SVar("X"))) )
                                                )
                                           ]), []) \
        == OrNode([])

    mu = tp(Mu(SVar("X"), And(Symbol("a"), App(Symbol("b"), SVar("X")))))
    assert build_quasimodel(Node.make_nodes([mu.pattern]), []) \
        == AndNode([AndNode([ Sequent([ tp(Symbol("b"), mu)])
                            , Sequent([ tp(Symbol("a"), tp(mu.pattern, mu))
                                      , tp( App(Symbol("b"), mu.pattern)
                                          , tp(mu.pattern, mu)
                                          )
                                      ]
                       )])])

