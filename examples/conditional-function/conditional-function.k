module CONDITIONAL-FUNCTION

imports DOMAINS

syntax Foo ::= foo(Int)
             | bar(Foo)

syntax Int ::= factorial(Int) [function]

rule bar(foo(X:Int)) => foo(factorial(X))

rule factorial(X:Int) => X *Int factorial(X -Int 1)
    requires X >=Int 1

rule factorial(0) => 1

endmodule
