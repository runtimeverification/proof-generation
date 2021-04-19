# Welcome!

## Quick installation

- Install Docker following [https://docs.docker.com/get-docker/](https://docs.docker.com/get-docker/) (version ≥ `19.03.8`)
- Download the Docker image as a `cav21-paper1-docker-image.tar.gz`.
- Load and run the image:

    ```
    $ docker load --input cav21-paper1-docker-image.tar.gz
    $ docker run -it zl38/matching-logic-proof-checker:cav21-ae
    ```

- Run all experiments in the paper

    ```
    /cav21# python3 -m scripts.benchmark eval/* output.csv
    ```

    Output can be found in `output.csv`

The directory `/cav21` is organized as follows:

- `README.md` is the same as this document.
- `cav21-paper1.pdf` is a copy of our paper.
- The rest of the directory contains source code and tests of our tool.
    - Tests are in `eval/`

The rest of the document is organized as follows:

- Overview
- Functional badge
- Available badge
- Reusable badge

## Overview

We propose a method to generate proof objects for program executions.

[K framework](https://kframework.org/) is a language framework that allows one to define the operational semantics of a language and derive various tools (interpreter, symbolic execution engine, bounded model checking, etc.) from a single definition.

We have formalized matching logic in a theorem prover called [Metamath](http://us.metamath.org/) and implemented proof object generation for concrete execution, which is what we present here in this artifact evaluation.

## Functional badge

Our paper evaluates the proof generator on a selected set of tests from the REC (Rewrite Engine Competition) benchmark, using reduced input size. To reproduce the data in the paper (Table 1), run the following benchmark script:

```
$ python3 -m scripts.benchmark eval/* output.csv
```

This will take a while (~40 min on a laptop with Intel i7 CPUs and 16 gigs of memory).

When it finishes, `output.csv` will contain performance statistics on proof generation and proof checking (the time to generate proof parameters such as execution traces is not included). The columns in `output.csv` (also Table 1 in the paper) are as follows:

- `module-name` + `pgm` = programs
- `gen-total` = proof generation time - total
    - `gen-module` = proof generation time - semantics
    - `gen-rewrite` = proof generation time - rewrite
- `mm-total` = proof checking time - total
    - `mm-prelude` = proof checking time - logic
    - `mm-rewrite` = proof checking time - task
- `loc-total-wrapped` = proof size - kLOC (the unit in the CSV file is LOC instead of kLOC)
- `size-total` = proof size - megabytes (the unit in the CSV file is bytes instead of megabytes)

## Available badge

We have uploaded the Docker image to Zenodo, and the permanent link should be present in the artifact submission.

## Reusable badge

### Set up our tool outside the image

To run our proof generation separately without using the Dockerfile, you would need to do the following:

- Install K framework following the instructions on [https://github.com/kframework/k](https://github.com/kframework/k). Note that we currently only support the exact version `v5.0.0-bbc70cb`, so you need to check out this tag before building.
- Then install python3.7+ and pypy3.7+ (see [https://www.pypy.org/download.html](https://www.pypy.org/download.html))
- Finally, run

    ```
    python3 -m scripts.run_test <k definition> <main module name> <program> --output <output proof>
    ```

    to generate a proof object for concrete execution of the given `<program>`.

Note that this might be outdated at the time you are readng it, so ideally you can follow the instruction on [https://github.com/kframework/matching-logic-proof-checker](https://github.com/kframework/matching-logic-proof-checker) to try out our tool.

### Build Docker image

The Dockerfile used to build the image can be found at [https://github.com/kframework/matching-logic-proof-checker/blob/cav21-ae/image/Dockerfile](https://github.com/kframework/matching-logic-proof-checker/blob/cav21-ae/image/Dockerfile).

To build it, run the following from the root of this [repo](https://github.com/kframework/matching-logic-proof-checker/tree/cav21-ae):

```
docker build -f image/Dockerfile .
```

This might take a while (~50 min on a laptop with 8 Intel i7 CPUs and 16 gigs of memory), since we need to build the K framework.

### Usage of the tool on new inputs

We explain how our tool can be used for new inputs.

Our tool takes the following as input:

- A formal definition of a programming language L, defined using the [K framework](https://kframework.org),
- A program in the language L.

To generate a proof of execution for the program run (at the root of the repo or `/cav21` in the image)

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

As an example, we can generate proof object for the K definition located at `eval/two-counters`

```
$ python3 -m scripts.run_test eval/two-counters/two-counters.k TWO-COUNTERS eval/two-counters/input-10.two-counters --output proof-of-two-counters
```

### Examples of new inputs

In this section we give some examples of new inputs not presented in the paper.

`examples/lambda/lambda.k` is a K definition of untyped pure lambda calculus (using integers as variables).

To generate the proof object for concrete execution of a term

```
((lambda 1 (lambda 2 (2 1))) (lambda 2 2)) (lambda 1 1)
```

Run:

```
$ python3 -m scripts.run_test examples/lambda/lambda.k LAMBDA examples/lambda/pgm-1.lambda --output proof-of-lambda-pgm-1
```

The output proof can be checked:

```
$ metamath proof-of-lambda-pgm-1/goal.mm
...
MM> verify proof *
0 10%  20%  30%  40%  50%  60%  70%  80%  90% 100%
..................................................
Warning: The following $p statement(s) were not proved: 
 LblUndsandBoolUnds-domain-fact-0, LblnotBoolUnds-domain-fact-0,
 LblUndsandBoolUnds-domain-fact-1, LblUndsandBoolUnds-domain-fact-2,
 LblUndsandBoolUnds-domain-fact-3, LblnotBoolUnds-domain-fact-1,
 LblUndsandBoolUnds-domain-fact-4, LblUndsandBoolUnds-domain-fact-5,
 LblnotBoolUnds-domain-fact-2, LblUndsandBoolUnds-domain-fact-6,
 LblUndsEqlsEqlsIntUnds-domain-fact-0, LblnotBoolUnds-domain-fact-3,
 LblnotBoolUnds-domain-fact-4, LblUndsandBoolUnds-domain-fact-7,
 LblUndsEqlsEqlsIntUnds-domain-fact-1, LblnotBoolUnds-domain-fact-5,
 LblUndsEqlsEqlsIntUnds-domain-fact-2, LblnotBoolUnds-domain-fact-6,
 LblUndsandBoolUnds-domain-fact-8, LblUndsandBoolUnds-domain-fact-9,
 LblnotBoolUnds-domain-fact-7, LblUndsandBoolUnds-domain-fact-10,
 LblUndsandBoolUnds-domain-fact-11, LblnotBoolUnds-domain-fact-8,
 LblUndsandBoolUnds-domain-fact-12, LblUndsEqlsEqlsIntUnds-domain-fact-3,
 LblnotBoolUnds-domain-fact-9, LblUndsandBoolUnds-domain-fact-13,
 LblnotBoolUnds-domain-fact-10, LblUndsandBoolUnds-domain-fact-14,
 LblUndsandBoolUnds-domain-fact-15, LblnotBoolUnds-domain-fact-11,
 LblUndsandBoolUnds-domain-fact-16, LblUndsEqlsEqlsIntUnds-domain-fact-4,
 LblnotBoolUnds-domain-fact-12
```

Note that we are not currently proving facts about domain values like integers, so these are stated as assumptions in the proof object.
