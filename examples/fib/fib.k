module FIB-SYNTAX

syntax RECNat

syntax RECNat ::= recd0()
syntax RECNat ::= recs(RECNat)
syntax RECNat ::= recplus(RECNat, RECNat) [function]
syntax RECNat ::= recfibb(RECNat) [function]

syntax RECNat ::= start()

endmodule

module FIB
imports K-EQUAL
imports FIB-SYNTAX

rule recplus(recd0(), REC_V_N:RECNat) => REC_V_N:RECNat
rule recplus(recs(REC_V_N:RECNat), REC_V_M:RECNat) => recs(recplus(REC_V_N:RECNat, REC_V_M:RECNat))
rule recfibb(recd0()) => recd0()
rule recfibb(recs(recd0())) => recs(recd0())
rule recfibb(recs(recs(REC_V_N:RECNat))) => recplus(recfibb(recs(REC_V_N:RECNat)), recfibb(REC_V_N:RECNat))

rule start() => recfibb(recs(recs(recs(recs(recd0())))))

endmodule
