module IMP-PRODUCT-SPEC

imports IMP

syntax Id ::= "a" [token]
            | "b" [token]
            | "c" [token]

claim
  <k>
    int a, b, c;
    a = A:Int;
    b = B:Int;
    c = 0;
    while (1 <= b) {
      c = c + a;
      b = b - 1;
    }
    =>
    .
  </k>
  <state> .Map => a |-> A b |-> 0 c |-> A *Int B </state>
  requires A >=Int 0 andBool B >=Int 0

// loop invariant
claim
  <k>
    while (1 <= b) {
      c = c + a;
      b = b - 1;
    }
    => .
    ...
  </k>
  <state>
    a |-> A:Int
    b |-> (B:Int => 0)
    c |-> (C:Int => C +Int A *Int B)
  </state>
  requires A >=Int 0 andBool B >=Int 0

endmodule
