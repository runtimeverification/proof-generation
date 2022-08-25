module REG-PRODUCT-SPEC

imports REG

claim
    <k> exec => ret(S +Int N *Int M) </k>
    <pc> 0 </pc>
    <r0> N => 0 </r0>
    <r1> M => 0 </r1>
    <r2> S => 0 </r2>
    <r3> 0 </r3>
    <imem>
        0 |-> eq r3, r1, 0
        1 |-> br r3, abs(5), rel(0)
        2 |-> sub r1, r1, 1
        3 |-> add r2, r2, r0
        4 |-> jump abs(0)
        5 |-> ret r2
    </imem>
    <dmem> .SMap </dmem>
    requires N >=Int 0 andBool M >=Int 0

endmodule
