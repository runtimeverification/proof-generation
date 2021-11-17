module PCF-GCD-SPEC

imports PCF

syntax Id ::= "f" [token]
            | "x" [token]
            | "y" [token]

claim app(app(
    fix(f, lambda(x, lambda(y, if(eq(x, y), x, if(le(x, y), app(app(f, x), sub(y, x)), app(app(f, sub(x, y)), y)))))),
    N:Int), M:Int) => gcd(N, M)
    requires N >Int 0 andBool M >Int 0

claim if(eq(N:Int, M:Int), N, if(le(N, M),
         app(app(fix(f, lambda(x, lambda(y, if(eq(x, y), x, if(le(x, y), app(app(f, x), sub(y, x)), app(app(f, sub(x, y)), y)))))), N), sub(M, N)),
         app(app(fix(f, lambda(x, lambda(y, if(eq(x, y), x, if(le(x, y), app(app(f, x), sub(y, x)), app(app(f, sub(x, y)), y)))))), sub(N, M)), M)))
    => gcd(N, M)
    requires N >Int 0 andBool M >Int 0

endmodule
