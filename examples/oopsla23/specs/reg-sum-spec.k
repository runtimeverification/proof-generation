module REG-SUM-SPEC

imports REG

claim
  <k> exec => ret(((N +Int 1) *Int N) /Int 2) </k>
  <pc> 0 </pc>
  <r0> N => 0 </r0>
  <r1> 0 </r1>
  <r2> 0 </r2>
  <r3> 0 </r3>
  <imem>
    0 |-> le r2, r0, 0
    1 |-> not r2, r2
    2 |-> br r2, abs(3), abs(6)
    3 |-> add r1, r1, r0
    4 |-> add r0, r0, -1
    5 |-> jump abs(0)
    6 |-> ret r1
  </imem>
  <dmem> .SMap </dmem>
  requires 0 <=Int N
  [one-path]

// loop invariant
claim
  <k> exec => ret(S +Int (((N +Int 1) *Int N) /Int 2)) </k>
  <pc> 0 </pc>
  <r0> N:Int => 0 </r0>
  <r1> S:Int => 0 </r1>
  <r2> _ => 0 </r2>
  <r3> 0 </r3>
  <imem>
    0 |-> le r2, r0, 0
    1 |-> not r2, r2
    2 |-> br r2, abs(3), abs(6)
    3 |-> add r1, r1, r0
    4 |-> add r0, r0, -1
    5 |-> jump abs(0)
    6 |-> ret r1
  </imem>
  <dmem> .SMap </dmem>
  requires 0 <=Int N
  [one-path]

endmodule
