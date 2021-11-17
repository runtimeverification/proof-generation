module PCF-PRODUCT-SPEC

imports PCF

syntax Id ::= "f" [token]
            | "x" [token]
            | "y" [token]

claim add(app(app(
    fix(f, lambda(x, lambda(y, if(eq(x, 0), 0, add(y, app(app(f, sub(x, 1)), y)))))),
    N:Int), M:Int), 0) => N *Int M
    requires N >=Int 0 andBool M >=Int 0

// loop invariant
claim if(eq(N:Int, 0), 0,
         add(M:Int, app(app(fix(f, lambda(x, lambda(y, if(eq(x, 0), 0, add(y, app(app(f, sub(x, 1)), y)))))), sub(N, 1)), M)))
      ~> addFreezer2(S:Int) => S +Int (N *Int M)
    requires N >=Int 0 andBool M >=Int 0

endmodule
