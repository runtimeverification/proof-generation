// int i = 0;
// int n = 0;
// int k = __VERIFIER_nondet_int();
// if (!(k <= LARGE_INT && k >= -LARGE_INT)) return 0;
// for(i = 0; i < 2*k; i++) {
//     if (i % 2 == 0) {
//         n ++;
//     }
// }
// __VERIFIER_assert(k < 0 || n == k);
// return 0;

module IMP-LOOP-NEW-HALF-SPEC

imports IMP

syntax Id ::= "i" [token]
            | "n" [token]
            | "k" [token]

// main claim
claim
  <k>
    int i, n, k;
    i = 0;
    n = 0;
    k = K:Int;

    while (i < 2 * k) {
      if (i % 2 == 0) {
        n = n + 1;
      } else {}
      i = i + 1;
    }
    =>
    .
  </k>
  <state> .Map => i |-> 2 *Int K n |-> K k |-> K </state>
  requires K >=Int 0

// invariant
claim
  <k>
    while (i < 2 * k) {
      if (i % 2 == 0) {
        n = n + 1;
      } else {}
      i = i + 1;
    }
    => .
    ...
  </k>
  <state>
    i |-> (I => 2 *Int K)
    n |-> (N => N +Int (2 *Int K -Int I) /Int 2)
    k |-> K
  </state>
  requires I <=Int 2 *Int K andBool K >=Int 0

endmodule
