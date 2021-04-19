module REVELT-SYNTAX

syntax RECElt
syntax RECList

syntax KItem ::= then(KItem, KItem)
syntax RECList ::= recl(RECElt, RECList)
syntax RECList ::= recnil()
syntax RECElt ::= reca()
syntax RECElt ::= recb()
syntax RECElt ::= recc()
syntax RECElt ::= recd()
syntax RECElt ::= rece()
syntax RECList ::= recconc(RECList, RECList) [function]
syntax RECList ::= recdup(RECList) [function]
syntax RECList ::= recrev(RECList) [function]

endmodule

module REVELT
imports K-EQUAL
imports REVELT-SYNTAX

rule recconc(recl(REC_V_E0:RECElt, REC_V_L1:RECList), REC_V_L2:RECList) => recl(REC_V_E0:RECElt, recconc(REC_V_L1:RECList, REC_V_L2:RECList))
rule recconc(recnil(), REC_V_L2:RECList) => REC_V_L2:RECList
rule recdup(REC_V_L1:RECList) => recconc(REC_V_L1:RECList, REC_V_L1:RECList)
rule recrev(recl(REC_V_E0:RECElt, REC_V_L1:RECList)) => recconc(recrev(REC_V_L1:RECList), recl(REC_V_E0:RECElt, recnil()))
rule recrev(recnil()) => recnil()

// eval: recrev(recdup(recl(reca(), recl(recb(), recl(recc(), recl(recd(), recl(rece(), recnil())))))))

endmodule
