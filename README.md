Paper #23 Generating Proof Certificates for a Language-Agnostic Deductive Program Verifier
---

# Introduction

This Docker image contains tooling and experiment setup that support experimental claims in our paper.
These claims are:

1. [Section 6, Figure 5] The performance data of proof generation and checking. The Getting Started section describes how to generate a table with comparable results.

2. [Section 2, Trust Base and Proof Checkers] Excluding the trust on the programming languages used to implement our proof generator and checker (e.g. Python and Metamath) and some code used to implement encoding (e.g. `kompile`), our trust base mainly consists of a 240-line axiomatization of matching logic in Metamath. The reviewer can check the core matching logic axiomatization located at `theory/matching-logic.mm` (and the 240-line re-formatted version at `theory/matching-logic-240-loc.mm`). All of our generated proof files (`evaluation/proofs/*.mm` files generated in the Getting Started section) are prefixed with this axiomatization.

3. [Section 1] The claim that our proof generation is language-agnostic, which is supported by the fact our evaluation consists of programs in three different languages: IMP, PCF, REG. The reviewer can find the definitions of these languages in `evaluation/definitions`, and all program specifications in `evaluation/specs` contain programs written in these languages.

# Getting Started

For the Available and Functional badges, this section describes how to reproduce Figure 5 in our paper.

1. Install Docker (this image has been tested on Docker 20.10.22 on an x86-64 machine).
2. Obatin our Docker image `paper-23.tar.gz` from [Zenodo](https://doi.org/10.5281/zenodo.7482286).
3. Load the image into Docker: `docker load < paper-23.tar.gz`
4. Run the image in an interactive console: `docker run -it oopsla23-paper-23-ae`
5. Within the container, change to the `evaluation` directory: `cd evaluation`
6. Run the evaluation and collect all stats: `make -j<n>` where `<n>` can be set to a reasonable number according to the number of CPU cores in your machine.
7. Output the results as a LaTeX tabular: `python3 stats.py`

On a machine with an Intel i7-12700K processor (14-core, 20-thread) and 32 GiB of memory, these steps took about 10 minutes to finish (using `make -j20` for step 6).

The final table generated in step 7 should have comparable results to Figure 5 in our paper.

# How to Interpret the Results

This sections assumes that the reader has finished all the steps in the previous section.

In step 6 in the previous section, we are running through 20 test cases mentioned in Section 6, Figure 5 of our paper.

Take `sum.imp` for example, whose specification can be found at `evaluations/specs/imp-sum-spec.k`.
We first compile IMP's language semantics at `evaluation/definitions/imp.k` using `kompile`.
Then we call `kprove` (K's program verifier) to verify the specification `evaluations/specs/imp-sum-spec.k`.
At the same time, `kprove` is also instructed to output "proof hints" to help with our proof generation tool (see Section 4.2).
In this example, the proof hints can be found at `evaluation/definitions/.ml-proof-cache-imp/reachability-task-imp-sum-spec.yml`, which contains all symbolic rewriting steps and related substitutions.

If `kprove` succeeds, our proof generation tool is called with the proof hints to generate the final proof in Metamath format,
which can be located at `evaluation/proofs/imp-sum.mm` once the process finishes.
We then check the output proof using two different Metamath implementations (`smetamath-rs` and `rust-metamath`) and collect timing statistics.

The reader is also welcome to verify the proof using a different Metamath implementation.
For example, to verify the proof using Metamath's official C implementation (included in the image), run
```
$ metamath evaluation/proofs/imp-sum.mm
Reading source file "proofs/imp-sum.mm"... 37007155 bytes
37007155 bytes were read into the source buffer.
The source has 19402 statements; 2467 are $a and 11111 are $p.
No errors were found.  However, proofs were not checked.  Type VERIFY PROOF *
if you want to check them.
MM> verify proof *
0 10%  20%  30%  40%  50%  60%  70%  80%  90% 100%
..................................................
Warning: The following $p statement(s) were not proved:  smt-query-10,
 smt-query-11, smt-query-12, smt-query-13, smt-query-37, smt-query-38,
 smt-query-39, smt-query-40, smt-query-41, smt-query-42, smt-query-43,
 smt-query-51, smt-query-53, smt-query-54
```
There would be some warnings about missing proofs for SMT queries since currently we do not generate proofs for them (see Section 7.2).

# Step-by-Step Instructions

For the Reusable badge, we describe in this section how to generate proofs for potentially new program specifications.
We will still use the `sum.imp` example, but the same procedure can be used for different programs or languages.

To get started, we need to prepare two things:
- Semantics of a programming language written in K, and
- A program specification in this language.

In our image, the `example` directory contains exactly these two things:
- `imp.k` is the language semantics for IMP, and
- `spec.k` is the specification of a simple summing program.

To verify the specification using K, run
```
cd example
kompile --backend haskell imp.k
kprove spec.k
```
If `kprove` succeeds, it should output `#Top`.

Once the verification is successful, we can call our proof generation tool to produce a full proof in matching logic:
```
cd /opt/proof-generation
pypy3 -m scripts.prove_reachability example/imp.k IMP example/spec.k SPEC --standalone -o examples/spec-proof.mm
```
This will produce the proof file in `examples/spec-proof.mm`, which can be verified using any implementation of Metamath.
