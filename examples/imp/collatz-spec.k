module COLLATZ-SPEC

imports IMP

syntax Id ::= "n" [token]

claim
    <k>
        while (!(n <= 1)) {
            if ((n / 2) * 2 + 1 <= n) {
                n = n * 3 + 1;
            } else {
                n = n / 2;
            }
        }
        =>
        .
    </k>
    <state>
        n |-> (N => 1)
    </state>
    requires N >Int 0

endmodule
