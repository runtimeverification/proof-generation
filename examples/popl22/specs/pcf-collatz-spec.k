module PCF-COLLATZ-SPEC

imports PCF

syntax Id ::= "f" [token]
            | "x" [token]

claim app(fix(f, lambda(x, if(le(x, 1), x, if(le(add(mul(div(x, 2), 2), 1), x), app(f, add(mul(x, 3), 1)), app(f, div(x, 2)))))), N:Int) => 1
    requires N >=Int 1

// loop invariant
claim
    app(lambda(x,
        if(le(x, 1), x,
            if(le(add(mul(div(x, 2), 2), 1), x),
                app(fix(f, lambda(x, if(le(x, 1), x, if(le(add(mul(div(x, 2), 2), 1), x), app(f, add(mul(x, 3), 1)), app(f, div(x, 2)))))),
                    add(mul(x, 3), 1)),
                app(fix(f, lambda(x, if(le(x, 1), x, if(le(add(mul(div(x, 2), 2), 1), x), app(f, add(mul(x, 3), 1)), app(f, div(x, 2)))))),
                    div(x, 2))))),
        N:Int)
    => 1
    requires N >=Int 1

endmodule
