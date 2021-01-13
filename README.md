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
