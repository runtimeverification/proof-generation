module CHECK2-SYNTAX

syntax RECBool

syntax KItem ::= then(KItem, KItem)
syntax RECBool ::= rectrue()
syntax RECBool ::= recfalse()
syntax RECBool ::= recnotBool(RECBool) [function]
syntax RECBool ::= recandBool(RECBool, RECBool) [function]
syntax RECBool ::= recorBool(RECBool, RECBool) [function]
syntax RECBool ::= recxorBool(RECBool, RECBool) [function]
syntax RECBool ::= recimpliesBool(RECBool, RECBool) [function]
syntax RECBool ::= reciffBool(RECBool, RECBool) [function]
syntax RECBool ::= receqBool(RECBool, RECBool) [function]
syntax RECBool ::= recneBool(RECBool, RECBool) [function]

endmodule

module CHECK2
imports K-EQUAL
imports CHECK2-SYNTAX

rule recnotBool(rectrue()) => recfalse()
rule recnotBool(recfalse()) => rectrue()
rule recandBool(REC_V_P:RECBool, rectrue()) => REC_V_P:RECBool
rule recandBool(REC_V_P:RECBool, recfalse()) => recfalse()
rule recorBool(REC_V_P:RECBool, rectrue()) => rectrue()
rule recorBool(REC_V_P:RECBool, recfalse()) => REC_V_P:RECBool
rule recxorBool(REC_V_P:RECBool, REC_V_Q:RECBool) => recorBool(recandBool(REC_V_P:RECBool, recnotBool(REC_V_Q:RECBool)), recandBool(REC_V_Q:RECBool, recnotBool(REC_V_P:RECBool)))
rule recimpliesBool(REC_V_P:RECBool, REC_V_Q:RECBool) => recorBool(REC_V_Q:RECBool, recnotBool(REC_V_P:RECBool))
rule reciffBool(REC_V_P:RECBool, REC_V_Q:RECBool) => recandBool(recimpliesBool(REC_V_P:RECBool, REC_V_Q:RECBool), recimpliesBool(REC_V_Q:RECBool, REC_V_P:RECBool))
rule receqBool(REC_V_P:RECBool, REC_V_Q:RECBool) => reciffBool(REC_V_P:RECBool, REC_V_Q:RECBool)
rule recneBool(REC_V_P:RECBool, REC_V_Q:RECBool) => recxorBool(REC_V_P:RECBool, REC_V_Q:RECBool)

// eval: recneBool(recfalse(), rectrue())

endmodule
