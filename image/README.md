## Welcome!

Depending on where are you reading this:

- If you are reading this on the web, we have prepared a [docker image](https://hub.docker.com/r/zl38/matching-logic-proof-checker) that contains all software required for artifact evaluation.

    To get started, make sure that you have `docker-19.03.8+` installed (lower versions probably work too, but this is the version we were using). Then run the following to pull and start the container:

    ```
    docker run -it zl38/matching-logic-proof-checker:cav21-ae
    ```

- If you are reading this in the docker image mentioned above, there is also an online version of this [README](https://github.com/kframework/matching-logic-proof-checker/blob/cav21-ae/image/README.md) for convenience.

If you are interested in setting up everything from scratch, the following section sketches the steps.

In the directory `/cav21` (which would be the initial directory when you start the container), you can find a few files/directories:

- `README.md` is the same as this document.
- `paper.pdf` is a copy of our paper.
- `repo` is a directory containing our proof generator as well as source code of examples used in our evaluation section.

Furthermore, this image contains a slim bulid of the [K framework](https://kframework.org/) with the haskell backend.

## Setting up from scratch (OPTIONAL)

In our public [repository](https://github.com/kframework/matching-logic-proof-checker/tree/cav21-ae), you can find a Dockerfile in `image/`, and you can build the Docker image used in this artifact evaluation by running the following from the root of the repo:

```
docker build -f image/Dockerfile .
```

This might take a while (~50 min on a laptop with 8 Intel i7 CPUs and 16 gigs of memory), since we need to build the K framework.

To run our proof generation separately without using the Dockerfile, you would need to do the following:

- Install K framework following the instructions on [https://github.com/kframework/k](https://github.com/kframework/k). Note that we currently only support the exact version `v5.0.0-bbc70cb`, so you need to check out this tag before building.
- Then install python3.7+ and pypy3.7+ (see [https://www.pypy.org/download.html](https://www.pypy.org/download.html))
- Finally, run

    ```
    python3 -m scripts.run_test <k definition> <main module name> <program> --output <output proof>
    ```

    to generate a proof object for concrete execution of the given `<program>`.

Please see [https://github.com/kframework/matching-logic-proof-checker](https://github.com/kframework/matching-logic-proof-checker)
for more information.

## Brief recap of our paper

[K framework](https://kframework.org/) is a language framework that allows one to define the operational semantics of a language and derive various tools (interpreter, symbolic execution engine, bounded model checking, etc.) from a single definition.

In the paper, we propose a method to generate proof objects for tasks that K does. Namely, we formalize K in a variant of FOL called matching logic, as well as relevant theories like rewriting. Then we are able to (in matching logic) prove certain facts given a theory derived from the K definition.

We have formalized matching logic in a theorem prover called [Metamath](http://us.metamath.org/) and implemented proof object generation for concrete rewriting, which is what we present here in this artifact evaluation.

## Basic usage

First, change the directory to `/cav21/repo`.

Suppose we have the following:

- A language definition in K: `kdef.k`, whose entry module name is `LANG`
- A program file `pgm.txt`

To generate a proof for concrete rewriting, run

```
$ python3 -m scripts.run_test <k definition> <main module name> <program> --output <output proof>
```

which will output the proof object (in Metamath) to `<output proof>`.

Then, we can use a (third-party) Metamath proof checker to check the proof. The image contains the official reference implementation written in C, which you can run using the following:

```
$ metamath <output proof>/goal.mm
Metamath - Version 0.196 31-Dec-2020          Type HELP for help, EXIT to exit.
<loading logs omitted>
130492902 bytes were read into the source buffer.
The source has 6930 statements; 1180 are $a and 2813 are $p.
No errors were found.  However, proofs were not checked.  Type VERIFY PROOF *
if you want to check them.
MM>
```

To verify all proofs, run

```
MM> verify proof *
0 10%  20%  30%  40%  50%  60%  70%  80%  90% 100%
..................................................
All proofs in the database were verified in 12.72 s.
```

One can also inspect the content of the proof object, although it's not quite readable right now. At the end of the `[goal.mm](http://goal.mm)` file, one can find a statement of the form:

```
goal $p |-
	( \kore-valid \kore-sort-SortGeneratedTopCell
		( \kore-rewrites-star <term1> <term2> ) )
$= <proof> $.
```

which encodes a claim that `<term1>` rewrites to (`\kore-rewrites-star`) to `<term2>` in zero or more steps, and `<term1>` should be an encoding of the input program as a K configuration, and `<term2>` should be the final result of the execution.

As an example, we can generate proof object for the K definition located at `eval/two-counters`

```
$ python3 -m scripts.run_test eval/two-counters/two-counters.k TWO-COUNTERS eval/two-counters/input-10.two-counters --output proof-of-two-counters
- kompiling /cav21/repo/eval/two-counters/two-counters.k
+ kompile --backend haskell --directory /cav21/repo/eval/two-counters/.ml-proof-cache-two-counters --main-module TWO-COUNTERS --debug /cav21/repo/eval/two-counters/two-counters.k
- generating snapshots
+ kast --directory /cav21/repo/eval/two-counters/.ml-proof-cache-two-counters --output kore /cav21/repo/eval/two-counters/input-10.two-counters
+ krun --directory /cav21/repo/eval/two-counters/.ml-proof-cache-two-counters --depth 1 --output kore /cav21/repo/eval/two-counters/input-10.two-counters
+ krun --directory /cav21/repo/eval/two-counters/.ml-proof-cache-two-counters --depth 2 --output kore /cav21/repo/eval/two-counters/input-10.two-counters
+ krun --directory /cav21/repo/eval/two-counters/.ml-proof-cache-two-counters --depth 3 --output kore /cav21/repo/eval/two-counters/input-10.two-counters
+ krun --directory /cav21/repo/eval/two-counters/.ml-proof-cache-two-counters --depth 4 --output kore /cav21/repo/eval/two-counters/input-10.two-counters
+ krun --directory /cav21/repo/eval/two-counters/.ml-proof-cache-two-counters --depth 5 --output kore /cav21/repo/eval/two-counters/input-10.two-counters
+ krun --directory /cav21/repo/eval/two-counters/.ml-proof-cache-two-counters --depth 6 --output kore /cav21/repo/eval/two-counters/input-10.two-counters
+ krun --directory /cav21/repo/eval/two-counters/.ml-proof-cache-two-counters --depth 7 --output kore /cav21/repo/eval/two-counters/input-10.two-counters
+ krun --directory /cav21/repo/eval/two-counters/.ml-proof-cache-two-counters --depth 8 --output kore /cav21/repo/eval/two-counters/input-10.two-counters
+ krun --directory /cav21/repo/eval/two-counters/.ml-proof-cache-two-counters --depth 9 --output kore /cav21/repo/eval/two-counters/input-10.two-counters
+ krun --directory /cav21/repo/eval/two-counters/.ml-proof-cache-two-counters --depth 10 --output kore /cav21/repo/eval/two-counters/input-10.two-counters
+ krun --directory /cav21/repo/eval/two-counters/.ml-proof-cache-two-counters --depth 11 --output kore /cav21/repo/eval/two-counters/input-10.two-counters
- generating proof
+ pypy3 -m ml.rewrite /cav21/repo/eval/two-counters/.ml-proof-cache-two-counters/two-counters-kompiled/definition.kore TWO-COUNTERS --prelude theory/prelude.mm --snapshots /cav21/repo/eval/two-counters/.ml-proof-cache-two-counters/snapshots-input-10 --output /cav21/repo/proof-of-two-counters
...
```

## Reproducing evaluation results

Our paper evaluates the proof generator on a selected set of tests from the REC (Rewrite Engine Competition) benchmark, using reduced input size. To reproduce the data in the paper (Table 1), run the following benchmark script:

```
$ python3 -m scripts.benchmark eval/* output.csv
```

This will take a while (~40 min on a laptop with Intel i7 CPUs and 16 gigs of memory) because we need to run `kompile` (to compile a k definition) and `krun` to obtain a term for each step of rewriting. Currently, we use a naive way to obtain each step of rewriting by calling `krun` multiple times. Since each run of `krun` incurs some loading time, the second step (`generating snapshots`) can be quite slow, so we don't count this part in our performance data, as they can be re-implemented much more efficiently inside the K framework.

When it finishes, `output.csv` will contain performance statistics from the tests. The correspondence between the column names in the CSV file and the columns in Table 1 is as follows:

- `gen-module` = proof generation/sem (unit: seconds)
- `gen-rewrite` = proof generation/rewrite (unit: seconds)
- `gen-total` = proof generation/total (unit: seconds)
- `mm-prelude` = proof checking/logic (unit: seconds)
- `mm-rewrite` = proof checking/task (unit: seconds)
- `mm-total` = proof checking/total (unit: seconds)
- `loc-total-wrapped` = proof size/kLOC (the unit in the CSV file is LOC instead of kLOC)
- `size-total` = proof size/megabytes (the unit in the CSV file is bytes instead of megabytes)
