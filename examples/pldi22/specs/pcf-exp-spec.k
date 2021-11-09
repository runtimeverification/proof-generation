module PCF-EXP-SPEC

imports PCF

syntax Id ::= "f" [token]
            | "n" [token]
            | "k" [token]

claim mul(1, app(app(fix(f, lambda(n, lambda(k, if(le(k, 0), 1, mul(n, app(app(f, n), add(k, -1))))))), N), K)) => exp(N, K)
    requires N >Int 0 andBool K >=Int 0 andBool R >Int 0

// loop invariant
claim
    if(le(K, 0), 1, mul(N, app(app(fix(f, lambda(n, lambda(k, if(le(k, 0), 1, mul(n, app(app(f, n), add(k, -1))))))), N), add(K, -1)))) ~> mulFreezer2(R)
    => R *Int exp(N, K)
    requires N >Int 0 andBool K >=Int 0 andBool R >Int 0

endmodule
