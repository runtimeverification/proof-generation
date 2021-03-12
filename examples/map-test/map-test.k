requires "domains.k"

module MAP-TEST
    imports MAP

    syntax KItem ::= select(Map, KItem)

    // Select by key. 
    rule select(Key |-> Val M:Map, Key) => Val

endmodule
