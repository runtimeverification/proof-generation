requires "domains.k"

module MAP-TEST
    imports MAP

    syntax KItem ::= select(Map, KItem)
    syntax Map ::= merge(Map, Map) [function, functional]

    // Select by key. 
    rule select(Key |-> Val _:Map, Key) => Val

    rule merge(M1, M2) => M1 M2

endmodule
