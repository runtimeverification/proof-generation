requires "verification.k"

module FAST-EXP-SPEC

imports VERIFICATION

syntax Id ::= "n" [token]
            | "k" [token]
            | "r" [token]
            | "m" [token]

// claim
//   <k>
//     int n, k, r;

//     n = N:Int;
//     k = K:Int;
//     r = 1;

//     if (k <= 0 && 0 <= k) {} // k == 0
//     else {
//         while (!(k <= 1)) {
//             if (!(k <= (k / 2) * 2)) { // odd(k)
//                 r = r * n;
//             } else {}
//             n = n * n;
//             k = k / 2;
//         }
//         r = r * n;
//     }

//     n = 0;
//     k = 0;
//     =>
//     .
//   </k>
//   <state> .Map => n |-> 0 k |-> 0 r |-> N ^Int K </state>
//   requires N >=Int 0 andBool K >=Int 0

// loop invariant
claim
  <k>
    while (!(k <= 1)) {
      if (!(k <= (k / 2) * 2)) {
        r = r * n;
        k = k + -1;
      } else {
        n = n * n;
        k = k / 2;
      }
    }
    => .
    ...
  </k>
  <state>
    n |-> (N:Int => ?N':Int)
    k |-> (K:Int => 1)
    r |-> (R:Int => ?R':Int)
  </state>
  // requires N ==Int 2 andBool K ==Int 64 andBool R ==Int 1
  requires N >Int 0 andBool K >Int 0 andBool R >Int 0
  ensures R *Int (N ^Int K) ==Int ?R' *Int ?N'

endmodule
