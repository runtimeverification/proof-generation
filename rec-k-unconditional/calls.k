module CALLS-SYNTAX

syntax RECS

syntax KItem ::= then(KItem, KItem)
syntax RECS ::= recnullaryconstructor()
syntax RECS ::= recunaryconstructor(RECS)
syntax RECS ::= recnaryconstructor(RECS, RECS, RECS)
syntax RECS ::= recnullaryfunction() [function]
syntax RECS ::= recunaryfunction(RECS) [function]
syntax RECS ::= recnaryfunction(RECS, RECS, RECS) [function]
syntax RECS ::= reca() [function]
syntax RECS ::= recb() [function]
syntax RECS ::= recc() [function]
syntax RECS ::= recd() [function]
syntax RECS ::= rece() [function]
syntax RECS ::= recf() [function]

endmodule

module CALLS
imports K-EQUAL
imports CALLS-SYNTAX

rule recnullaryfunction() => recnullaryconstructor()
rule recunaryfunction(REC_V_x:RECS) => recunaryconstructor(REC_V_x:RECS)
rule recnaryfunction(REC_V_x:RECS, REC_V_y:RECS, REC_V_z:RECS) => recnaryconstructor(REC_V_x:RECS, REC_V_y:RECS, REC_V_z:RECS)
rule reca() => recnullaryconstructor()
rule recb() => recunaryconstructor(recnullaryconstructor())
rule recc() => recnaryconstructor(recnullaryconstructor(), recnullaryconstructor(), recnullaryconstructor())
rule recd() => recnullaryfunction()
rule rece() => recunaryfunction(recnullaryfunction())
rule recf() => recnaryfunction(recnullaryfunction(), recnullaryfunction(), recnullaryfunction())

// eval: recnullaryconstructor()
// eval: recunaryconstructor(recnullaryconstructor())
// eval: recnaryconstructor(recnullaryconstructor(), recnullaryconstructor(), recnullaryconstructor())
// eval: recnullaryfunction()
// eval: recunaryfunction(recnullaryfunction())
// eval: recnaryfunction(recnullaryfunction(), recnullaryfunction(), recnullaryfunction())

endmodule
