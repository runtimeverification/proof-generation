module SOUNDNESSOFPARALLELENGINES-SYNTAX

syntax RECN

syntax KItem ::= then(KItem, KItem)
syntax RECN ::= recd0()
syntax RECN ::= recs(RECN)
syntax RECN ::= recg(RECN)
syntax RECN ::= recf(RECN) [function]

endmodule

module SOUNDNESSOFPARALLELENGINES
imports K-EQUAL
imports SOUNDNESSOFPARALLELENGINES-SYNTAX

rule recf(recg(recd0())) => recd0()
rule recf(recg(recs(REC_V_X:RECN))) => recf(recg(REC_V_X:RECN))

// eval: recf(recg(recs(recd0())))

endmodule
