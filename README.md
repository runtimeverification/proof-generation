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

The itp and rewrite prover use Python (3.7+). Some dependencies are required:
```
python3 -m pip install -r requirements.txt
```

Note that we have been using the K version at tag `v5.0.0-bbc70cb` or commit hash `bbc70cb`.
The newer version might generate different axioms for rewriting.

## Examples of generating proofs for concrete rewriting

Suppose you have a K definition `def.k` with the main module `MAIN`,
and a program `pgm.txt`, you can use

```
python3 -m scripts.run-test def.k MAIN pgm.txt --output rewriting-proof
```
to generate the (concrete) rewriting proof for the program `pgm.txt` and output to the `rewriting-proof` directory.

Once that's done, you can use Metamath to verify the proof:
```
$ metamath rewriting-proof/goal.mm
...
77192945 bytes were read into the source buffer.
The source has 9148 statements; 4352 are $a and 1776 are $p.
No errors were found.  However, proofs were not checked.  Type VERIFY PROOF *
if you want to check them.
MM> verify proof *
0 10%  20%  30%  40%  50%  60%  70%  80%  90% 100%
..................................................
MM>
```
