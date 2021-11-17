requires "verification.k"

module REG-SYNTAX

imports DOMAINS-SYNTAX

syntax ControlCommand ::= "exec" | ret(Int)

syntax Immediate ::= Int
syntax Register ::= "r0" | "r1" | "r2" | "r3"
syntax Operand ::= Immediate | Register

syntax Address ::= rel(Int) | abs(Int)

syntax Instruction ::= "load"  Register "," Operand               [strict(2)]
                     | "store" Operand "," Operand                [seqstrict]
                     | "move"  Register "," Operand               [strict(2)]
                     | "add"   Register "," Operand "," Operand   [seqstrict(2, 3)]
                     | "sub"   Register "," Operand "," Operand   [seqstrict(2, 3)]
                     | "mul"   Register "," Operand "," Operand   [seqstrict(2, 3)]
                     | "div"   Register "," Operand "," Operand   [seqstrict(2, 3)]
                     | "eq"    Register "," Operand "," Operand   [seqstrict(2, 3)]
                     | "le"    Register "," Operand "," Operand   [seqstrict(2, 3)]
                     | "not"   Register "," Operand               [strict(2)]
                     | "br"    Operand "," Address "," Address    [strict(1)]
                     | "jump"  Address
                     | "ret"   Operand                            [seqstrict]

endmodule

module SMAP

imports DOMAINS

syntax SMap ::= ".SMap"
              | store(SMap, Int, Int)

syntax KItem ::= select(SMap, Int)

rule select(store(_, A, V), A) => V
rule select(store(M, B, _), A) => select(M, A) requires A =/=Int B

endmodule

module REG

imports DOMAINS
imports REG-SYNTAX
imports SMAP
imports VERIFICAITON

configuration
    <T>
        <k> exec </k>
        <pc> 0 </pc>
        <r0> 0 </r0>
        <r1> 0 </r1>
        <r2> 0 </r2>
        <r3> 0 </r3>
        <imem> .Map </imem>
        <dmem> .SMap </dmem>
    </T>

syntax KResult ::= Int

// Execute the next instruction
rule <k> exec => I ~> exec ... </k>
     <pc> A => A +Int 1 </pc>
     <imem> A |-> I ... </imem>

// Register lookup
rule <k> r0 => V ... </k> <r0> V </r0>
rule <k> r1 => V ... </k> <r1> V </r1>
rule <k> r2 => V ... </k> <r2> V </r2>
rule <k> r3 => V ... </k> <r3> V </r3>

// Register set
syntax KItem ::= setRegister(Register, KItem) [strict(2)]
rule <k> setRegister(r0, V:Int) => . ... </k> <r0> _ => V </r0>
rule <k> setRegister(r1, V:Int) => . ... </k> <r1> _ => V </r1>
rule <k> setRegister(r2, V:Int) => . ... </k> <r2> _ => V </r2>
rule <k> setRegister(r3, V:Int) => . ... </k> <r3> _ => V </r3>

// Intruction semantics
rule <k> ret V:Int ~> exec => ret(V) ... </k>
     <pc> _ => 0 </pc>
     <r0> _ => 0 </r0>
     <r1> _ => 0 </r1>
     <r2> _ => 0 </r2>
     <r3> _ => 0 </r3>
     <dmem> _ => .SMap </dmem> // so that we don't need to determine SMap equality

rule <k> load R:Register, A:Int => setRegister(R, select(M, A)) ... </k>
     <dmem> M </dmem>

rule <k> store A:Int, V:Int => . ... </k>
     <dmem> M => store(M, A, V) </dmem>

rule move R:Register, V:Int => setRegister(R, V)

rule add R:Register, V1:Int, V2:Int => setRegister(R, V1 +Int V2)
rule sub R:Register, V1:Int, V2:Int => setRegister(R, V1 -Int V2)
rule mul R:Register, V1:Int, V2:Int => setRegister(R, V1 *Int V2)
rule div R:Register, V1:Int, V2:Int => setRegister(R, V1 /Int V2) requires V2 =/=Int 0

rule eq R:Register, V1:Int, V2:Int => setRegister(R, 1) requires V1 ==Int V2
rule eq R:Register, V1:Int, V2:Int => setRegister(R, 0) requires notBool (V1 ==Int V2)

rule le R:Register, V1:Int, V2:Int => setRegister(R, 1) requires V1 <=Int V2
rule le R:Register, V1:Int, V2:Int => setRegister(R, 0) requires notBool (V1 <=Int V2)

rule not R:Register, V:Int => setRegister(R, 0) requires V ==Int 1
rule not R:Register, V:Int => setRegister(R, 1) requires V ==Int 0

// Conditiona/unconditional branching
rule br I:Int, A, _ => jump A requires I ==Int 1
rule br I:Int, _, A => jump A requires I ==Int 0

rule <k> jump rel(A) => . ... </k>
     <pc> PC => PC +Int A </pc>

rule <k> jump abs(A) => . ... </k>
     <pc> _ => A </pc>

endmodule
