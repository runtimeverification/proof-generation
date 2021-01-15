module CHECK1-SYNTAX

syntax RECUSingleton
syntax RECNat

syntax KItem ::= then(KItem, KItem)
syntax RECUSingleton ::= recUcons(RECNat)
syntax RECNat ::= recd0()
syntax RECNat ::= recsucc(RECNat)

endmodule

module CHECK1
imports K-EQUAL
imports CHECK1-SYNTAX


// eval: recd0()

endmodule
