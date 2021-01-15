module PERMUTATIONS7-SYNTAX

syntax RECNat
syntax RECNatList
syntax RECNatListList

syntax KItem ::= then(KItem, KItem)
syntax RECNat ::= recd0()
syntax RECNat ::= recs(RECNat)
syntax RECNatList ::= recnil()
syntax RECNatList ::= recl(RECNat)
syntax RECNatList ::= recll(RECNatList, RECNatList)
syntax RECNatListList ::= recnilP()
syntax RECNatListList ::= recp(RECNatList)
syntax RECNatListList ::= recpp(RECNatListList, RECNatListList)
syntax RECNatListList ::= recperm(RECNat) [function]
syntax RECNatListList ::= recinsert1(RECNat, RECNatListList) [function]
syntax RECNatListList ::= recinsert0(RECNat, RECNatList) [function]
syntax RECNatListList ::= recmapcons(RECNat, RECNatListList) [function]
syntax RECNatListList ::= recppreduce(RECNatListList, RECNatListList) [function]
syntax RECNatListList ::= recppflat(RECNatListList, RECNatListList) [function]

endmodule

module PERMUTATIONS7
imports K-EQUAL
imports PERMUTATIONS7-SYNTAX

rule recperm(recd0()) => recppreduce(recp(recnil()), recnilP())
rule recperm(recs(recd0())) => recppreduce(recp(recll(recl(recs(recd0())), recnil())), recnilP())
rule recperm(recs(REC_V_N:RECNat)) => recinsert1(recs(REC_V_N:RECNat), recperm(REC_V_N:RECNat))
rule recinsert1(REC_V_N:RECNat, recpp(recp(REC_V_P1:RECNatList), REC_V_Ps:RECNatListList)) => recppreduce(recinsert0(REC_V_N:RECNat, REC_V_P1:RECNatList), recinsert1(REC_V_N:RECNat, REC_V_Ps:RECNatListList))
rule recinsert1(REC_V_N:RECNat, recp(REC_V_P1:RECNatList)) => recinsert0(REC_V_N:RECNat, REC_V_P1:RECNatList)
rule recinsert1(REC_V_N:RECNat, recnilP()) => recnilP()
rule recinsert0(REC_V_N:RECNat, recll(recl(REC_V_M:RECNat), REC_V_P2:RECNatList)) => recppreduce(recp(recll(recl(REC_V_N:RECNat), recll(recl(REC_V_M:RECNat), REC_V_P2:RECNatList))), recmapcons(REC_V_M:RECNat, recinsert0(REC_V_N:RECNat, REC_V_P2:RECNatList)))
rule recinsert0(REC_V_N:RECNat, recnil()) => recppreduce(recp(recll(recl(REC_V_N:RECNat), recnil())), recnilP())
rule recmapcons(REC_V_M:RECNat, recpp(recp(REC_V_P1:RECNatList), REC_V_Ps:RECNatListList)) => recppreduce(recp(recll(recl(REC_V_M:RECNat), REC_V_P1:RECNatList)), recmapcons(REC_V_M:RECNat, REC_V_Ps:RECNatListList))
rule recmapcons(REC_V_M:RECNat, recp(REC_V_P1:RECNatList)) => recp(recll(recl(REC_V_M:RECNat), REC_V_P1:RECNatList))
rule recmapcons(REC_V_M:RECNat, recnilP()) => recnilP()
rule recppreduce(recnilP(), REC_V_Ps2:RECNatListList) => REC_V_Ps2:RECNatListList
rule recppreduce(REC_V_Ps1:RECNatListList, recnilP()) => REC_V_Ps1:RECNatListList
rule recppreduce(REC_V_Ps1:RECNatListList, REC_V_Ps2:RECNatListList) => recppflat(REC_V_Ps1:RECNatListList, recppflat(REC_V_Ps2:RECNatListList, recnilP()))
rule recppflat(recnilP(), REC_V_accumulator:RECNatListList) => REC_V_accumulator:RECNatListList
rule recppflat(recp(REC_V_P1:RECNatList), REC_V_accumulator:RECNatListList) => recpp(recp(REC_V_P1:RECNatList), REC_V_accumulator:RECNatListList)
rule recppflat(recpp(REC_V_Ps1:RECNatListList, REC_V_Ps2:RECNatListList), REC_V_accumulator:RECNatListList) => recppflat(REC_V_Ps1:RECNatListList, recppflat(REC_V_Ps2:RECNatListList, REC_V_accumulator:RECNatListList))

// eval: recperm(recs(recs(recs(recs(recs(recs(recs(recd0()))))))))

endmodule
