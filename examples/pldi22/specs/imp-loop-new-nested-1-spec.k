// int n = __VERIFIER_nondet_int();
// int m = __VERIFIER_nondet_int();
// int k = 0;
// int i,j;
// if (!(10 <= n && n <= 10000)) return 0;
// if (!(10 <= m && m <= 10000)) return 0;
// for (i = 0; i < n; i++) {
//   for (j = 0; j < m; j++) {
//     k ++;
//   }
// }
// __VERIFIER_assert(k >= 100);
// return 0;

module IMP-LOOP-NEW-NESTED-1-SPEC

imports IMP

syntax Id ::= "n" [token]
            | "m" [token]
            | "k" [token]
            | "i" [token]
            | "j" [token]

// main claim
claim
  <k>
    int n, m, k, i, j;
    n = N:Int;
    m = M:Int;
    k = 0;
    i = 0;
    while (i < n) {
      j = 0;
      while (j < m) {
        k = k + 1;
        j = j + 1;
      }
      i = i + 1;
    }
    =>
    .
  </k>
  <state> .Map => n |-> N m |-> M i |-> N j |-> M k |-> N *Int M </state>
  requires N >Int 0 andBool M >Int 0

// invariant
claim
  <k>
    while (j < m) {
      k = k + 1;
      j = j + 1;
    }
    => .
    ...
  </k>
  <state>
    n |-> N
    m |-> M
    i |-> I
    j |-> (J => M)
    k |-> (K => K +Int M -Int J)
  </state>
  requires N >Int 0 andBool M >Int 0 andBool J <=Int M

// invariant
claim
  <k>
    while (i < n) {
      j = 0;
      while (j < m) {
        k = k + 1;
        j = j + 1;
      }
      i = i + 1;
    }
    => .
    ...
  </k>
  <state>
    n |-> N
    m |-> M
    i |-> (I => N)
    j |-> (J => M)
    k |-> (K => K +Int M *Int (N -Int I))
  </state>
  requires N >Int 0 andBool M >Int 0 andBool I <Int N

endmodule
