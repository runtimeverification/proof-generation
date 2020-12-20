module ARITH-SYNTAX

imports DOMAINS

syntax Exp ::= add(Exp, Exp) [strict]
syntax Exp ::= Int

endmodule

module ARITH

imports ARITH-SYNTAX

syntax KResult ::= Int

rule add(A:Int, B:Int) => A +Int B

endmodule
