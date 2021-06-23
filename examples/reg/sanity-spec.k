
module SANITY-SPEC

imports REG

claim
    <k> exec => ret(10) </k>
    <pc> 0 </pc>
    <r0> 0 </r0>
    <r1> 0 </r1>
    <r2> 0 </r2>
    <r3> 0 </r3>
    <imem>
        0 |-> load r0, A
        1 |-> ret r0
    </imem>
    <dmem> store(.SMap, A:Int, 10) => .SMap </dmem>

endmodule
