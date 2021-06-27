Matching Logic Proof Checker
----------------------------

This repository contains:

-   A formulation of [matching logic](http://www.matching-logic.org/) in Metamath
    (`theory/matching-logic-*.mm`)
-   A formalization of [Kore](https://github.com/kframework/kore) in matching logic (`theory/kore-*.mm`)
-   An interactive theorem prover specialized for matching logic (`ml/itp`), [more info](ml/itp)
-   An automated prover that can generate proofs of concrete rewriting in Kore,
    given a Kore definition and a trace

Dependencies
------------

The itp and rewrite prover use Python (3.7+). Some dependencies are required:

    python3 -m pip install -r requirements.txt

You would also need to build and install a custom version of K at [here](https://github.com/rod-lin/k/tree/matching-logic-proof-checker),
which uses a modified haskell backend to print extra proof hints for rewriting.

You could also try to use the current version of K but
you would need to add an extra flag `--no-backend-hints` for the `scripts.prove_symbolic`
script below.

The newer versions might **not** work since they may generate different axioms for rewriting.

Examples of generating proofs for concrete rewriting
----------------------------------------------------

Suppose you have a K definition `def.k` with the main module `MAIN`, and a
program `pgm.txt`, you can use

    python3 -m scripts.prove_symbolic def.k MAIN pgm.txt --output rewriting-proof

to generate the (concrete) rewriting proof for the program `pgm.txt` and output
to the `rewriting-proof` directory.

Once that's done, you can use Metamath to verify the proof:

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


Reachability Examples
---

```
EV=/media/rodlin/ext4/popl22-evaluation
/usr/bin/time -v pypy3 -m scripts.prove_reachability $EV/imp/imp.k IMP $EV/imp/sum-spec.k SUM-SPEC --output $EV/imp/sum-proof.mm --standalone
/usr/bin/time -v pypy3 -m scripts.prove_reachability $EV/imp/imp.k IMP $EV/imp/collatz-spec.k COLLATZ-SPEC --output $EV/imp/collatz-proof.mm --standalone
/usr/bin/time -v pypy3 -m scripts.prove_reachability $EV/imp/imp.k IMP $EV/imp/exp-spec.k EXP-SPEC --output $EV/imp/exp-proof.mm --standalone --smt-prelude $EV/imp/prelude.smt2 --z3-tactic "(and-then qfnra-nlsat default)" --unknown-as-sat
/usr/bin/time -v pypy3 -m scripts.prove_reachability $EV/reg/reg.k REG $EV/reg/sum-spec.k SUM-SPEC --output $EV/reg/sum-proof.mm --standalone
/usr/bin/time -v pypy3 -m scripts.prove_reachability $EV/pcf/pcf.k PCF $EV/pcf/sum-spec.k SUM-SPEC --output $EV/pcf/sum-proof.mm --standalone
```
