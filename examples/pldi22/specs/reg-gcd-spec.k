module REG-GCD-SPEC

imports REG

claim
    <k> exec => ret(gcd(N, M)) </k>
    <pc> 0 </pc>
    <r0> N => 0 </r0>
    <r1> M => 0 </r1>
    <r2> _ => 0 </r2>
    <r3> 0 </r3>
    <imem>
        0 |-> eq r2, r0, r1
        1 |-> br r2, abs(8), rel(0)
        2 |-> le r2, r0, r1
        3 |-> br r2, rel(0), abs(6)
        4 |-> sub r1, r1, r0
        5 |-> jump abs(0)
        6 |-> sub r0, r0, r1
        7 |-> jump abs(0)
        8 |-> ret r0
    </imem>
    <dmem> .SMap </dmem>
    requires N >Int 0 andBool M >Int 0

endmodule
