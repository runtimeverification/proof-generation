requires "domains.k"

module MAP-TEST
    imports MAP

    syntax KItem ::= select(Map, KItem)

    rule select(Key |-> Val _:Map, Key) => Val

endmodule
