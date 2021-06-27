module EXP-SPEC

imports IMP

syntax Id ::= "n" [token]
            | "k" [token]
            | "r" [token]

claim
  <k>
    while (1 <= k) {
        r = r * n;
        k = k + -1;
    }
    => .
    ...
  </k>
  <state>
    n |-> N:Int
    k |-> (K:Int => 0)
    r |-> (R:Int => R *Int exp(N, K))
  </state>
  // requires N ==Int 2 andBool K ==Int 4 andBool R ==Int 20
  requires N >Int 0 andBool K >=Int 0 andBool R >Int 0

endmodule
