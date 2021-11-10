module IMP-SUM-SPEC

imports IMP

syntax Id ::= "n" [token]
            | "sum" [token]

claim
  <k>
    int n, sum;
    n = N:Int;
    sum = 0;
    while (!(n <= 0)) {
      sum = sum + n;
      n = n + -1;
    }
    =>
    .
  </k>
  <state> .Map => n |-> 0 sum |-> ((N +Int 1) *Int N /Int 2) </state>
  requires N >=Int 0

claim
  <k>
    while (!(n <= 0)) {
      sum = sum + n;
      n = n + -1;
    }
    => .
    ...
  </k>
  <state>
    n |-> (N:Int => 0)
    sum |-> (S:Int => S +Int ((N +Int 1) *Int N /Int 2))
  </state>
  requires N >=Int 0

endmodule
