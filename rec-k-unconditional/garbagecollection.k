module GARBAGECOLLECTION-SYNTAX

syntax RECNat

syntax KItem ::= then(KItem, KItem)
syntax RECNat ::= recd0()
syntax RECNat ::= recs(RECNat)
syntax RECNat ::= recp()
syntax RECNat ::= recn()
syntax RECNat ::= recd1() [function]
syntax RECNat ::= recf(RECNat, RECNat, RECNat, RECNat, RECNat) [function]
syntax RECNat ::= recc(RECNat, RECNat) [function]

endmodule

module GARBAGECOLLECTION
imports K-EQUAL
imports GARBAGECOLLECTION-SYNTAX

rule recd1() => recs(recd0())
rule recc(recd0(), REC_V_Y:RECNat) => REC_V_Y:RECNat
rule recc(recs(REC_V_X:RECNat), REC_V_Y:RECNat) => recs(recc(REC_V_X:RECNat, REC_V_Y:RECNat))
rule recf(REC_V_X:RECNat, REC_V_Y:RECNat, recs(REC_V_Z:RECNat), REC_V_T:RECNat, REC_V_U:RECNat) => recf(REC_V_X:RECNat, REC_V_Y:RECNat, REC_V_Z:RECNat, recc(REC_V_T:RECNat, REC_V_T:RECNat), REC_V_U:RECNat)
rule recf(REC_V_X:RECNat, recs(REC_V_Y:RECNat), recd0(), REC_V_T:RECNat, REC_V_U:RECNat) => recf(REC_V_X:RECNat, REC_V_Y:RECNat, recp(), REC_V_T:RECNat, REC_V_T:RECNat)
rule recf(recs(REC_V_X:RECNat), recd0(), recd0(), REC_V_T:RECNat, REC_V_U:RECNat) => recf(REC_V_X:RECNat, recn(), recp(), recd1(), recd0())
rule recf(recd0(), recd0(), recd0(), REC_V_T:RECNat, REC_V_U:RECNat) => REC_V_T:RECNat
rule recf(REC_V_X:RECNat, recs(REC_V_Y:RECNat), recp(), REC_V_T:RECNat, REC_V_U:RECNat) => recf(REC_V_X:RECNat, REC_V_Y:RECNat, recp(), REC_V_T:RECNat, recs(REC_V_U:RECNat))
rule recf(REC_V_X:RECNat, recd0(), recp(), REC_V_T:RECNat, REC_V_U:RECNat) => recf(REC_V_X:RECNat, recn(), recp(), recs(REC_V_T:RECNat), REC_V_U:RECNat)
rule recf(recs(REC_V_X:RECNat), recn(), recp(), REC_V_T:RECNat, REC_V_U:RECNat) => recf(REC_V_X:RECNat, recn(), recp(), REC_V_T:RECNat, REC_V_U:RECNat)
rule recf(recd0(), recn(), recp(), REC_V_T:RECNat, REC_V_U:RECNat) => REC_V_U:RECNat

// eval: recf(recs(recs(recs(recs(recs(recs(recd0())))))), recs(recs(recs(recs(recs(recd0()))))), recs(recs(recd0())), recd0(), recd1())
// eval: recf(recs(recs(recs(recs(recd0())))), recs(recs(recs(recd0()))), recs(recs(recs(recs(recs(recd0()))))), recd0(), recd1())

endmodule
