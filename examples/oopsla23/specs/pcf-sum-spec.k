module PCF-SUM-SPEC

imports PCF

syntax Id ::= "f" [token]
      | "x" [token]

claim add(0, app(fix(f, lambda(x, if(le(x, 0), 0, add(x, app(f, add(x, -1)))))), N:Int)) => (((N +Int 1) *Int N) /Int 2)
  requires N >=Int 0
  [one-path]

// loop invariant
claim app(lambda(x, if(le(x, 0), 0, add(x, app(fix(f, lambda(x, if(le(x, 0), 0, add(x, app(f, add(x, -1)))))), add(x, -1))))), N:Int) ~> addFreezer2(S:Int) =>
      S +Int (((N +Int 1) *Int N) /Int 2)
  requires N >=Int 0
  [one-path]

endmodule
