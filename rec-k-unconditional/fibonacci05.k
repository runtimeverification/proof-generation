module FIBONACCI05-SYNTAX

syntax RECNat

syntax KItem ::= then(KItem, KItem)
syntax RECNat ::= recd0()
syntax RECNat ::= recs(RECNat)
syntax RECNat ::= recplus(RECNat, RECNat) [function]
syntax RECNat ::= recfibb(RECNat) [function]

endmodule

module FIBONACCI05
imports K-EQUAL
imports FIBONACCI05-SYNTAX

rule recplus(recd0(), REC_V_N:RECNat) => REC_V_N:RECNat
rule recplus(recs(REC_V_N:RECNat), REC_V_M:RECNat) => recs(recplus(REC_V_N:RECNat, REC_V_M:RECNat))
rule recfibb(recd0()) => recd0()
rule recfibb(recs(recd0())) => recs(recd0())
rule recfibb(recs(recs(REC_V_N:RECNat))) => recplus(recfibb(recs(REC_V_N:RECNat)), recfibb(REC_V_N:RECNat))

// eval: recfibb(recs(recs(recs(recs(recs(recd0()))))))
// eval: recfibb(recfibb(recs(recs(recs(recs(recs(recd0())))))))
// eval: recfibb(recfibb(recfibb(recs(recs(recs(recs(recs(recd0()))))))))
// eval: recfibb(recfibb(recfibb(recfibb(recs(recs(recs(recs(recs(recd0())))))))))
// eval: recfibb(recfibb(recfibb(recfibb(recfibb(recs(recs(recs(recs(recs(recd0()))))))))))

endmodule
