requires "verification.k"

module PCF-SYNTAX

imports DOMAINS-SYNTAX

syntax Variable ::= Id
syntax Abstraction ::= lambda(Variable, Term)

syntax Int ::= "-" Int [function, functional]

syntax Base ::= if(Term, Term, Term) [strict(1)]
              | add(Term, Term)
              | sub(Term, Term)
              | mul(Term, Term)
              | div(Term, Term)      [seqstrict]
              | le(Term, Term)       [seqstrict]
              | eq(Term, Term)       [seqstrict]
              | not(Term)            [strict]

syntax Value ::= Int | Bool | Abstraction

syntax Term ::= Variable
              | Value
              | Base
              | app(Term, Term)      [seqstrict]
              | fix(Variable, Term)

syntax KItem ::= addFreezer1(Term) | addFreezer2(Int)
syntax KItem ::= subFreezer1(Term) | subFreezer2(Int)
syntax KItem ::= mulFreezer1(Term) | mulFreezer2(Int)

endmodule

module PCF

imports DOMAINS
imports PCF-SYNTAX
imports VERIFICAITON

syntax KResult ::= Value

rule - V:Int => 0 -Int V

// substitution that COULD potentially have variable capturing
// but since we are dealing with closed terms this is fine 
syntax Term ::= substitute(Term, Variable, Term) [function, functional]

rule substitute(V:Int, _, _) => V
rule substitute(B:Bool, _, _) => B

rule substitute(X:Variable, X, T) => T
rule substitute(Y:Variable, X, _) => Y requires X =/=K Y

rule substitute(if(T1, T2, T3), X, T) => if(substitute(T1, X, T), substitute(T2, X, T), substitute(T3, X, T))
rule substitute(add(T1, T2), X, T) => add(substitute(T1, X, T), substitute(T2, X, T))
rule substitute(sub(T1, T2), X, T) => sub(substitute(T1, X, T), substitute(T2, X, T))
rule substitute(mul(T1, T2), X, T) => mul(substitute(T1, X, T), substitute(T2, X, T))
rule substitute(div(T1, T2), X, T) => div(substitute(T1, X, T), substitute(T2, X, T))
rule substitute(le(T1, T2), X, T) => le(substitute(T1, X, T), substitute(T2, X, T))
rule substitute(eq(T1, T2), X, T) => eq(substitute(T1, X, T), substitute(T2, X, T))
rule substitute(not(T'), X, T) => not(substitute(T', X, T))

rule substitute(app(T1, T2), X, T) => app(substitute(T1, X, T), substitute(T2, X, T))

rule substitute(lambda(X, T'), X, _) => lambda(X, T')
rule substitute(lambda(Y, T'), X, T) => lambda(Y, substitute(T', X, T)) requires X =/=K Y

rule substitute(fix(X, T'), X, _) => fix(X, T')
rule substitute(fix(Y, T'), X, T) => fix(Y, substitute(T', X, T)) requires X =/=K Y

rule if(true, T, _) => T
rule if(false, _, T) => T
rule eq(V1:Int, V2:Int) => V1 ==Int V2
rule le(V1:Int, V2:Int) => V1 <=Int V2
rule not(V:Bool) => notBool V

// manually handling strictness since we need to describe the loop invariant
rule add(V1:Int, V2:Int) => V1 +Int V2
rule add(V1:Term, V2:Term) => V1 ~> addFreezer1(V2) requires notBool isKResult(V1)
rule V1:Int ~> addFreezer1(V2) => add(V1, V2)
rule add(V1:Int, V2:Term) => V2 ~> addFreezer2(V1) requires notBool isKResult(V2)
rule V2:Int ~> addFreezer2(V1) => add(V1, V2)

rule sub(V1:Int, V2:Int) => V1 -Int V2
rule sub(V1:Term, V2:Term) => V1 ~> subFreezer1(V2) requires notBool isKResult(V1)
rule V1:Int ~> subFreezer1(V2) => sub(V1, V2)
rule sub(V1:Int, V2:Term) => V2 ~> subFreezer2(V1) requires notBool isKResult(V2)
rule V2:Int ~> subFreezer2(V1) => sub(V1, V2)

rule mul(V1:Int, V2:Int) => V1 *Int V2
rule mul(V1:Term, V2:Term) => V1 ~> mulFreezer1(V2) requires notBool isKResult(V1)
rule V1:Int ~> mulFreezer1(V2) => mul(V1, V2)
rule mul(V1:Int, V2:Term) => V2 ~> mulFreezer2(V1) requires notBool isKResult(V2)
rule V2:Int ~> mulFreezer2(V1) => mul(V1, V2)

rule div(V1:Int, V2:Int) => V1 /Int V2 requires V2 =/=Int 0

rule app(lambda(X, T), V:Value) => substitute(T, X, V)
rule fix(F, T) => substitute(T, F, fix(F, T))

endmodule
