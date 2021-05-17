module IMP-SYNTAX
  imports DOMAINS-SYNTAX
  syntax AExp  ::= Int | String | Id
                 | "++" Id
                 | "read" "(" ")"
                 | "-" AExp                   [strict]
                 | "(" AExp ")"               [bracket]
                 > AExp "/" AExp              [left, strict, division]
                 > AExp "+" AExp              [left, strict]
                 > "spawn" Block
                 > Id "=" AExp                [strict(2)]
  syntax BExp  ::= Bool
                 | AExp "<=" AExp             [seqstrict, latex({#1}\leq{#2})]
                 | "!" BExp                   [strict]
                 | "(" BExp ")"               [bracket]
                 > BExp "&&" BExp             [left, strict(1)]
  syntax Block ::= "{" Stmts "}"
  syntax Stmt  ::= Block
                 | AExp ";"                   [strict]
                 | "if" "(" BExp ")"
                   Block "else" Block         [strict(1)]
                 | "while" "(" BExp ")" Block
                 | "int" Ids ";"
                 | "print" "(" AExps ")" ";"
                 | "halt" ";"
                 > "join" AExp ";"            [strict]

  syntax Ids   ::= List{Id,","}
  syntax AExps ::= List{AExp,","}
  syntax Stmts ::= List{Stmt,""}
  syntax AExps ::= Ids
endmodule


module IMP
  imports IMP-SYNTAX
  imports DOMAINS
  configuration <T color="yellow">
                  <threads color="orange">
                    <thread multiplicity="*" color="blue">
                      <k color="green"> $PGM:Stmts </k>
                      <env color="LightSkyBlue"> .Map </env>
                      <id color="black"> 0 </id>
                    </thread>
                  </threads>
//                <br/>
                  <store color="red"> .Map </store>
//                  <input color="magenta"> .List </input>
//                  <output color="Orchid"> .List </output>
                  <input color="magenta" stream="stdin"> .List </input>
                  <output color="Orchid" stream="stdout"> .List </output>
                </T>
// Replace the <input/> and <output/> cells with the next two in order to
// initialize the input buffer through krun
//     <input color="magenta"> $IN:List </input>
//     <output color="Orchid"> .List </output>
// Replace the <input/> and <output/> cells with the next two to connect the
// input/output buffers to stdin/stdout through krun
//     <input color="magenta" stream="stdin"> .List </input>
//     <output color="Orchid" stream="stdout"> .List </output>
// Replace the <input/> and <output/> cells with the next two to connect the
// input/output buffers to stdin/stdout and also allow input through krun
//     <input color="magenta" stream="stdin"> $IN:List </input>
//     <output color="Orchid" stream="stdout"> .List </output>

  syntax KResult ::= Int | Bool
  rule <k> X:Id => I ...</k>
       <env>... X |-> N ...</env>
       <store>... N |-> I ...</store>  [lookup]
  rule I1 / I2 => I1 /Int I2  when I2 =/=Int 0
  rule I1 + I2 => I1 +Int I2
  rule - I => 0 -Int I
  rule I1 <= I2 => I1 <=Int I2
  rule ! T => notBool T
  rule true && B => B
  rule false && _ => false

  rule _:Int; => .
  rule <k> X = I:Int => I ...</k>
       <env>... X |-> N ...</env>
       <store>... N |-> (_ => I) ...</store>  [assignment]

  rule .Stmts => .
  rule S:Stmt Ss:Stmts => S ~> Ss  [structural]

  rule if (true)  S else _ => S
  rule if (false) _ else S => S

  rule while (B) S => if (B) {S while (B) S} else {.Stmts}  [structural]

  syntax KResult ::= String
  rule Str1 + Str2 => Str1 +String Str2

  rule <k> ++X => I +Int 1 ...</k>
       <env>... X |-> N ...</env>
       <store>... N |-> (I => I +Int 1) ...</store>  [increment]

  rule <k> read() => I ...</k>
       <input> ListItem(I:Int) => .List ...</input>  [read]

  syntax Printable ::= Int | String

/* currently it is necessary to subsort Printable to AExp,
  but future K should be able to infer that automatically. */
  syntax AExp ::= Printable

  context print(HOLE:AExp, _AEs:AExps);

  rule <k> print(P:Printable,AEs => AEs); ...</k>
       <output>... .List => ListItem(P) </output>  [print]
  rule print(.AExps); => .  [structural]

  rule <k> halt; ~> _ => . </k>

  rule <k> spawn S => !T:Int ...</k> <env> Rho </env>
       (.Bag => <thread>... <k> S </k> <env> Rho </env> <id> !T </id> ...</thread>)

  rule <k> join(T); => . ...</k> <thread>... <k>.</k> <id>T</id> ...</thread>

  rule <k> {Ss} => Ss ~> Rho ...</k> <env> Rho </env>  [structural]

  rule <k> int (X,Xs => Xs); ...</k>
       <env> Rho => Rho[X <- !N:Int] </env>
       <store>... .Map => !N |-> 0 ...</store>
  rule int .Ids; => .  [structural]

  rule <k> Rho => . ...</k> <env> _ => Rho </env>    [structural]

// verification ids
  syntax Id ::= "n"     [token]
              | "sum"   [token]
              | "a"     [token]
              | "b"     [token]
              | "c"     [token]
endmodule