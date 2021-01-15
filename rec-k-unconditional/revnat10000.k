module REVNAT10000-SYNTAX

syntax RECNat
syntax RECList

syntax KItem ::= then(KItem, KItem)
syntax RECList ::= recl(RECNat, RECList)
syntax RECList ::= recnil()
syntax RECNat ::= recd0()
syntax RECNat ::= recs(RECNat)
syntax RECNat ::= recd10() [function]
syntax RECNat ::= recplus(RECNat, RECNat) [function]
syntax RECNat ::= rectimes(RECNat, RECNat) [function]
syntax RECList ::= recgen(RECNat) [function]
syntax RECList ::= recconc(RECList, RECList) [function]
syntax RECList ::= recrev(RECList) [function]

endmodule

module REVNAT10000
imports K-EQUAL
imports REVNAT10000-SYNTAX

rule recd10() => recs(recs(recs(recs(recs(recs(recs(recs(recs(recs(recd0()))))))))))
rule recplus(recd0(), REC_V_N:RECNat) => REC_V_N:RECNat
rule recplus(recs(REC_V_N:RECNat), REC_V_M:RECNat) => recs(recplus(REC_V_N:RECNat, REC_V_M:RECNat))
rule rectimes(recd0(), REC_V_N:RECNat) => recd0()
rule rectimes(recs(REC_V_N:RECNat), REC_V_M:RECNat) => recplus(REC_V_M:RECNat, rectimes(REC_V_N:RECNat, REC_V_M:RECNat))
rule recgen(recs(REC_V_N:RECNat)) => recl(recs(REC_V_N:RECNat), recgen(REC_V_N:RECNat))
rule recgen(recd0()) => recl(recd0(), recnil())
rule recconc(recl(REC_V_E:RECNat, REC_V_L1:RECList), REC_V_L2:RECList) => recl(REC_V_E:RECNat, recconc(REC_V_L1:RECList, REC_V_L2:RECList))
rule recconc(recnil(), REC_V_L2:RECList) => REC_V_L2:RECList
rule recrev(recl(REC_V_E:RECNat, REC_V_L1:RECList)) => recconc(recrev(REC_V_L1:RECList), recl(REC_V_E:RECNat, recnil()))
rule recrev(recnil()) => recnil()

// eval: recrev(recgen(rectimes(recd10(), rectimes(recd10(), rectimes(recd10(), recd10())))))

endmodule
