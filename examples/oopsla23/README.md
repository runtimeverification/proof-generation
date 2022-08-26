OOPSLA 2023 Submission Evaluation
---

Some additional prerequisites need to be installed besides the main ones in README.md at the root of the repo.

1. PyPy 3.9+: `sudo apt install pypy3`
2. smetamath from [https://github.com/rod-lin/smetamath-rs](https://github.com/rod-lin/smetamath-rs)

Then, run make to perform all evaluations:

    make

With `-j1`, this will take roughly 50 minutes to finish.

Alternative, you can run each component separately

    make gen               # generate all uncompressed proofs
    make verify            # verify all proofs using smetamath and collect stats
    make compress          # compress all proofs and print the sizes
    make compressed-verify # verify all compressed proofs and collect stats

To re-run all evaluations, run `make clean` and then `make` again.

After make succeeds, generate the LaTeX table by running

    python3 stats.py
