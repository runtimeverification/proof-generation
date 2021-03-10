module ARITH-SYNTAX

imports DOMAINS

syntax Exp ::= add(Exp, Exp) [strict(1, 2)]
syntax Exp ::= minus(Exp, Exp) [strict(2, 1)]
syntax Exp ::= wtf(Exp, Exp, Exp)
syntax Exp ::= Int

endmodule

module ARITH

imports ARITH-SYNTAX

syntax KResult ::= Int | Bool

rule add(A:Int, B:Int) => A +Int B
rule minus(A:Int, B:Int) => A -Int B

context wtf(HOLE:Exp, _:Exp, _:Exp)
context wtf(_:Int, _:Exp, HOLE:Exp)
context wtf(_:Int, HOLE:Exp, _:Int)

rule wtf(X:Int, Y:Int, Z:Int) => X +Int Y -Int Z

endmodule
