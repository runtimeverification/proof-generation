OOPSLA 2023 Submission Evaluation
---

Some additional prerequisites need to be installed besides the main ones in README.md at the root of the repo.

1. PyPy 3.9+: `sudo apt install pypy3`
2. [Rust](https://www.rust-lang.org/tools/install)
3. smetamath from [https://github.com/zhengyao-lin/smetamath-rs](https://github.com/zhengyao-lin/smetamath-rs)

Then, run make to perform all evaluations:

    make

With `-j1`, this will take roughly 70 minutes to finish.

To re-run all evaluations, run `make clean` and then `make` again.

After `make` succeeds, generate the LaTeX table by running

    python3 stats.py
