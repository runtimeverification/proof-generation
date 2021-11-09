module IMP-GCD-SPEC

imports IMP

syntax Id ::= "a" [token]
            | "b" [token]

claim
  <k>
    int a, b;
    a = A:Int;
    b = B:Int;
    while (!(a <= b && b <= a)) {
      if (!(a <= b)) {
        a = a - b;
      } else {
        b = b - a;
      }
    }
    =>
    .
  </k>
  <state>
    .Map =>
    a |-> gcd(A, B)
    b |-> gcd(A, B)
  </state>
  requires A >Int 0 andBool B>Int 0

// loop invariant
claim
  <k>
    while (!(a <= b && b <= a)) {
      if (!(a <= b)) {
        a = a - b;
      } else {
        b = b - a;
      }
    }
    =>
    .
  </k>
  <state>
    a |-> (A:Int => gcd(A, B))
    b |-> (B:Int => gcd(A, B))
  </state>
  requires A >Int 0 andBool B>Int 0

endmodule
