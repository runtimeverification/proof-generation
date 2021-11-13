// int i;
// int k;
// k = __VERIFIER_nondet_int();
// if (!(0 <= k && k <= 10)) return 0;
// for (i = 0; i < LARGE_INT * k; i += k) ;
// __VERIFIER_assert(i == LARGE_INT * k);

module IMP-LOOP-NEW-COUNT-BY-K-SPEC

imports IMP

syntax Id ::= "i" [token]
            | "k" [token]

// The main goal
claim
  <k>
    int i, k;
    k = K:Int ;
    i = 0 ;
    while ( i < L:Int * k ) {
        i = i + k ;
    }
    =>
    .
  </k>
  <state>
    .Map =>
    i |-> L *Int K
    k |-> K
  </state>
  requires 1 <=Int K andBool K <=Int 10 andBool L >Int 0

claim
  <k>
    while ( i < L:Int * k ) {
        i = i + k ;
    }
    =>
    . ...
  </k>
  <state>
    i |-> (I:Int => L *Int K)
    k |-> K
  </state>
  requires I <Int L *Int K andBool K >=Int 1 andBool L >=Int 0 andBool I %Int K ==Int 0
  // ensures ?I <Int L *Int K +Int K andBool ?I >=Int L *Int K andBool ?I %Int K ==Int 0

endmodule
