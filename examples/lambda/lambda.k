requires "domains.k"

module LAMBDA-SYNTAX

imports DOMAINS

syntax Term ::= Value
              | Term Term [seqstrict, left]
              | "(" Term ")" [bracket]

syntax Value ::= "lambda" Int Term
               | Int

endmodule

module LAMBDA

imports LAMBDA-SYNTAX

syntax KResult ::= Value

// capture-free substitution
syntax Term ::= substitute(Term, Int, Term) [function, functional]
syntax Bool ::= isFreeIn(Int, Term) [function, functional]
syntax Int ::= maxVarIn(Term) [function, functional]
             | max(Int, Int) [function, functional]

rule (lambda X T) S => substitute(T, X, S)

rule substitute(X, X, T) => T
rule substitute(X, Y, _) => X requires X =/=Int Y
rule substitute(T S, X, R) => substitute(T, X, R) substitute(S, X, R)
rule substitute(lambda X T, X, _) => lambda X T
rule substitute(lambda X T, Y, S) => lambda X substitute(T, Y, S) requires X =/=Int Y andBool notBool isFreeIn(X, S)
rule substitute(lambda X T, Y, S) => lambda X substitute(T, Y, substitute(S, X, maxVarIn(S) +Int 1)) requires X =/=Int Y andBool isFreeIn(X, S)

rule isFreeIn(X, X) => true
rule isFreeIn(X, Y) => false requires X =/=Int Y
rule isFreeIn(X, T S) => isFreeIn(X, T) andBool isFreeIn(X, S)
rule isFreeIn(X, lambda X _) => false
rule isFreeIn(X, lambda Y T) => isFreeIn(X, T) requires X =/=Int Y

rule maxVarIn(X) => X
rule maxVarIn(T S) => max(maxVarIn(T), maxVarIn(S))
rule maxVarIn(lambda X T) => max(X, maxVarIn(T))

rule max(A, B) => A requires A >=Int B
rule max(A, B) => B requires B >=Int A

endmodule
