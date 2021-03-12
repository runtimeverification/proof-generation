Matching Logic Proof Checker
---

This repository contains:
  - A formulation of [matching μ-logic](http://www.matching-logic.org/index.php/Matching_Logic)
    in Metamath (`theory/matching-logic-*.mm`)
  - A formalization of [Kore](https://github.com/kframework/kore) in matching logic (`theory/kore-*.mm`)
  - An interactive theorem prover specialized for matching logic (`ml/itp`), [more info](ml/itp)
  - A automated prover that can generate proofs of concrete rewriting in Kore, given
    a Kore definition and a trace

## Dependencies

The itp and rewrite prover use Python (3.7+), so some dependencies are required:
```
python3 -m pip install -r requirements.txt
```

## Examples of generating proofs for concrete rewriting

### Foo (`examples/foo/foo.k`)
```
python3 -m ml.rewrite examples/foo/foo.k.kore FOO --prelude theory/kore-lemmas.mm --snapshots examples/foo/snapshots --output tmp
```

### Nat (`examples/nat-dv/nat-dv.k`)
```
python3 -m ml.rewrite examples/nat-dv/nat-dv.k.kore NAT-DV --prelude theory/kore-lemmas.mm --snapshots examples/nat-dv/snapshots --output tmp
```

### Fib (`examples/fib/fib.k`)
```
python3 -m ml.rewrite examples/fib/fib.k.kore FIB --prelude theory/kore-lemmas.mm --snapshots examples/fib/snapshots --output tmp
```

## Unification

This is the minimal example for map unification:

https://github.com/kframework/matching-logic-proof-checker/tree/main/examples/map-test

```
requires "domains.k"
module MAP-TEST
    imports MAP
    syntax KItem ::= select(Map, KItem)
    rule select(Key |-> Val _:Map, Key) => Val
endmodule
```

There are three programs in that directory:

```
pgm-no-aci.map-test
select(1 |-> 2 2 |-> 3, 1)
pgm-id.map-test
select(1 |-> 2, 1)
pgm-comm.map-test
select(1 |-> 2 2 |-> 3, 2)
pgm-ac.map-test
select(1 |-> 2 2 |-> 3 3 |-> 4, 3)
```

If you run
`python3 -m scripts.run-test examples/map-test/map-test.k MAP-TEST examples/map-test/pgm-no-aci.map-test --output tmp`
to prove the rewriting of `pgm-no-aci.map-test`, it would work
but for the other three programs, it would give an exception about not being able to find rewriting axioms for the pattern

Essentially two things have to be done (or how I would do it):
1. We need to find all the ACI axioms for maps. This kind of thing is currently done in this loop over all axioms: https://github.com/kframework/matching-logic-proof-checker/blob/main/ml/rewrite/env.py#L522. And one would need to somehow identify what the ACI axioms would look like for maps (or ideally for any constructors), then store it in some new fields of the ProofEnvironment class
2. Then once we have this information, the rest of the changes can be implemented in this file: https://github.com/kframework/matching-logic-proof-checker/blob/main/ml/rewrite/unification.py. Namely, in the class `UnificationProofGenerator`, one needs to implement the unification of two map patterns. 