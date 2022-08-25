module REG-COLLATZ-SPEC

imports REG

// loop invariant
claim
  <k> exec => ret(1) </k>
  <pc> 0 </pc>
  <r0> N:Int => 0 </r0>
  <r1> _ => 0 </r1>
  <r2> 0 </r2>
  <r3> 0 </r3>
  <imem>
    0  |-> le r1, r0, 1
    1  |-> not r1, r1
    2  |-> br r1, abs(3), abs(13)
      
    3  |-> div r1, r0, 2
    4  |-> mul r1, r1, 2
    5  |-> add r1, r1, 1
    6  |-> le r1, r1, r0
    7  |-> br r1, abs(8), abs(11)

    8  |-> mul r0, r0, 3
    9  |-> add r0, r0, 1
    10 |-> jump abs(0)

    11 |-> div r0, r0, 2
    12 |-> jump abs(0)

    13 |-> ret r0
  </imem>
  <dmem> .SMap </dmem>
  requires N >=Int 1
  [one-path]

endmodule
