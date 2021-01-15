module FACTORIAL6-SYNTAX

syntax RECNat

syntax KItem ::= then(KItem, KItem)
syntax RECNat ::= recd0()
syntax RECNat ::= recs(RECNat)
syntax RECNat ::= recplus(RECNat, RECNat) [function]
syntax RECNat ::= rectimes(RECNat, RECNat) [function]
syntax RECNat ::= recfact(RECNat) [function]

endmodule

module FACTORIAL6
imports K-EQUAL
imports FACTORIAL6-SYNTAX

rule recplus(recd0(), REC_V_N:RECNat) => REC_V_N:RECNat
rule recplus(recs(REC_V_N:RECNat), REC_V_M:RECNat) => recs(recplus(REC_V_N:RECNat, REC_V_M:RECNat))
rule rectimes(recd0(), REC_V_N:RECNat) => recd0()
rule rectimes(recs(REC_V_N:RECNat), REC_V_M:RECNat) => recplus(REC_V_M:RECNat, rectimes(REC_V_N:RECNat, REC_V_M:RECNat))
rule recfact(recd0()) => recs(recd0())
rule recfact(recs(REC_V_N:RECNat)) => rectimes(recs(REC_V_N:RECNat), recfact(REC_V_N:RECNat))

// eval: recfact(recs(recs(recs(recs(recs(recs(recd0())))))))

endmodule
