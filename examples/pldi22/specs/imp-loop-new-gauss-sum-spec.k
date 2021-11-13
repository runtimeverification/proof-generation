// int n, sum, i;
// n = __VERIFIER_nondet_int();
// if (!(1 <= n && n <= 1000)) return 0;
// sum = 0;
// for(i = 1; i <= n; i++) {
//     sum = sum + i;
// }
// __VERIFIER_assert(2*sum == n*(n+1));
// return 0;

module IMP-LOOP-NEW-GAUSS-SUM-SPEC

imports IMP

syntax Id ::= "i" [token]
            | "sum" [token]

// main claim
claim
  <k>
    int i, sum;
    sum = 0;
    i = 1;
    while (i <= N) {
      sum = sum + i;
      i = i + 1;
    }
    =>
    .
  </k>
  <state> .Map => i |-> N +Int 1 sum |-> ((N +Int 1) *Int N /Int 2) </state>
  requires N >=Int 0

claim
  <k>
    while (i <= N) {
      sum = sum + i;
      i = i + 1;
    }
    => .
    ...
  </k>
  <state>
    i |-> (I => N +Int 1)
    sum |-> (S:Int => S +Int ((I +Int N) *Int (N -Int I +Int 1) /Int 2))
  </state>
  requires I <=Int N +Int 1

endmodule
