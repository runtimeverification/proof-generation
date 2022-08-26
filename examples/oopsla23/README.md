OOPSLA 2023 Submission Evaluation
---

Some additional prerequisites need to be installed besides the main ones in README.md at the root of the repo.

1. PyPy 3.9+: `sudo apt install pypy3`
2. smetamath from [https://github.com/rod-lin/smetamath-rs](https://github.com/rod-lin/smetamath-rs)

Then, run the following commands to perform the evaluation:

    make                   # generate all proofs without compression and collect stats
    make verify            # verify all proofs using smetamath and collect stats
    make compress          # compress all proofs and print the sizes
    make compressed-verify # verify all compressed proofs and collect stats
