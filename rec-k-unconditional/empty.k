module EMPTY-SYNTAX

syntax RECNat

syntax KItem ::= then(KItem, KItem)
syntax RECNat ::= recd0()
syntax RECNat ::= recsucc(RECNat)

endmodule

module EMPTY
imports K-EQUAL
imports EMPTY-SYNTAX


// eval: recd0()

endmodule
