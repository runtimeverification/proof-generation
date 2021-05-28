requires "domains.k"

module SIMPLE-MAP

imports K-EQUAL

syntax SimpleMap ::= consMap(KItem, KItem, SimpleMap) | nilMap()
syntax Maybe ::= Just(KItem) | Nothing()

syntax Maybe ::= lookupMap(SimpleMap, KItem) [function, functional]
syntax SimpleMap ::= removeMap(SimpleMap, KItem) [function, functional]
syntax SimpleMap ::= setMap(SimpleMap, KItem, KItem) [function, functional]

rule lookupMap(consMap(K, V, _), K) => Just(V)
rule lookupMap(consMap(K, _, R), K') => lookupMap(R, K') requires K =/=K K'
rule lookupMap(nilMap(), _) => Nothing()

rule removeMap(consMap(K, _, R), K) => R
rule removeMap(consMap(K, V, R), K') => consMap(K, V, removeMap(R, K')) requires K =/=K K'
rule removeMap(nilMap(), _) => nilMap()

rule setMap(M, K, V) => consMap(K, V, removeMap(M, K))

endmodule

module IMP-SYNTAX

imports DOMAINS-SYNTAX

syntax AExp  ::= Int
               | Id
               | "-" AExp                   [strict]
               | AExp "/" AExp              [seqstrict]
               | "(" AExp ")"               [bracket]
               > AExp "+" AExp              [seqstrict]

syntax BExp  ::= Bool
               | AExp "<=" AExp             [seqstrict]
               | "not" BExp                 [strict]
               | "(" BExp ")"               [bracket]
               > BExp "and" BExp

syntax Block ::= "{" "}"
               | "{" Stmt "}"

syntax Stmt  ::= Block
               | Id "=" AExp                [strict(2)]
               | "if" "(" BExp ")"
                 Block "else" Block         [strict(1)]
               | "while" "(" BExp ")" Block
               > Stmt Stmt                  [left]

syntax Pgm ::= Stmt

endmodule

module IMP-CUSTOM-MAP

imports IMP-SYNTAX
imports K-EQUAL
imports SIMPLE-MAP
imports DOMAINS

syntax KResult ::= Int | Bool

configuration
    <imp>
        <k> $PGM:Pgm </k>
        <env> nilMap() </env>
    </imp>

// variable lookup
rule <k> X:Id => lookupMap(M, X) ~> X:Id ... </k>
     <env> M </env>

rule Just(A:Int) ~> _:Id => A

// arithmetic
rule - A:Int => 0 -Int A
rule A:Int + B:Int => A +Int B
rule A:Int / B:Int => A /Int B

rule not A:Bool => notBool A
rule A:Int <= B:Int => A <=Int B
rule A:Bool and B:Bool => A andBool B

// block
rule { } => .
rule { S } => S

// control flow
rule if ( C:Bool ) B1:Block else _ => B1 requires C
rule if ( C:Bool ) _ else B2:Block => B2 requires notBool C

rule while ( C ) B => if ( C ) { B while (C) B } else {}

// assignment
rule <k> X = A:Int => . ... </k>
     <env> M => setMap(M, X, A) </env>

// sequential composition
rule S1:Stmt S2:Stmt => S1 ~> S2

endmodule
