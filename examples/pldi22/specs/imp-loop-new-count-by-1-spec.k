// int i;
// for (i = 0; i < LARGE_INT; i++) ;
// __VERIFIER_assert(i == LARGE_INT);
// return 0;

module IMP-LOOP-NEW-COUNT-BY-1-SPEC

imports IMP

syntax Id ::= "i" [token]

// The main goal
claim
  <k>
    int i ;
    i = 0 ;
    while ( i < L:Int ) {
        i = i + 1 ;
    }
    =>
    .
  </k>
  <state>
    .Map => i |-> L
  </state>
  requires L >=Int 0

claim
  <k>
    while ( i < L:Int ) {
        i = i + 1 ;
    }
    =>
    .
    ...
  </k>
  <state>
    i |-> (I => L)
  </state>
  requires I <=Int L

endmodule
