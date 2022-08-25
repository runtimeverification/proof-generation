module REG-EXP-SPEC

imports REG

// loop invariant
claim
  <k> exec </k>
  <pc> 0 => 7 </pc>
  <r0> N:Int </r0>
  <r1> K:Int => 0 </r1>
  <r2> R:Int => R *Int exp(N, K) </r2>
  <r3> 0 </r3>
  <imem>
    0 |-> le r3, 1, r1
    1 |-> br r3, rel(0), abs(6)
    2 |-> mul r2, r2, r0
    3 |-> add r1, r1, -1
    4 |-> move r3, 0
    5 |-> jump abs(0)
    6 |-> move r3, 0
  </imem>
  <dmem> .SMap </dmem>
  // requires N ==Int 2 andBool K ==Int 4 andBool R ==Int 20
  requires N >Int 0 andBool K >=Int 0 andBool R >Int 0
  [one-path]

endmodule
