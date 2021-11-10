module IMP-HALF-SPEC

imports IMP

syntax Id ::= "a" [token]
            | "b" [token]
            | "c" [token]

claim
  <k>
    int a, b, c;
    a = A:Int;
    b = 0;
    c = 0;
    while (b + 2 <= a) {
      b = b + 2;
      c = c + 1;
    }
    =>
    .
  </k>
  <state> .Map => a |-> A b |-> A -Int A %Int 2 c |-> A /Int 2 </state>
  requires A >=Int 0

// loop invariant
claim
  <k>
    while (b + 2 <= a) {
      b = b + 2;
      c = c + 1;
    }
    => .
    ...
  </k>
  <state>
    a |-> A:Int
    b |-> (B:Int => A -Int (A -Int B) %Int 2)
    c |-> (C:Int => C +Int (A -Int B) /Int 2)
  </state>
  requires A >=Int 0 andBool B <=Int A

endmodule
