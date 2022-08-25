module VERIFICAITON

imports DOMAINS

syntax Int ::= exp(Int, Int) [function, functional, smt-hook((^ #1 #2))]
syntax Int ::= gcd(Int, Int) [function, functional, smt-hook((gcd #1 #2))]

// rule ( I +Int K ) %Int K => I %Int K [simplification]

endmodule
