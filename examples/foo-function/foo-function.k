module FOO-FUNCTION

imports DOMAINS

syntax Foo ::= foo(Int)
             | bar(Foo)
             | id(Foo) [function, functional]

rule id(F:Foo) => F
rule bar(foo(X:Int)) => id(id(foo(X)))

endmodule
