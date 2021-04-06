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
