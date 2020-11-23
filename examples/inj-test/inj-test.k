module INJ-TEST

imports DOMAINS

syntax Foo ::= foo(Int)
syntax Bar ::= bar(Int)
syntax Oof ::= oof(Int)

syntax Foo ::= Bar
syntax Bar ::= Oof

syntax Foo ::= f(Foo)

rule f(X:Bar) => f(oof(1))

endmodule
