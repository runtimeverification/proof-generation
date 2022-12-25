Paper #23 Generating Proof Certificates for a Language-Agnostic Deductive Program Verifier
---

### Getting Started
1. Install Docker (this image has been tested on Docker 20.10.22 on an x86-64 machine).
2. Obatin our Docker image from TODO. Suppose it is named `paper-223.tar.gz`.
3. Load the image into Docker: `docker load < paper-223.tar.gz`
4. Run the image: `docker run -it oopsla23-paper-23-ae`
5. Change to the `evaluation` directory: `cd evaluation`
6. Run the evaluation and collect all stats: `make -j<n>` where `<n>` can be set to a reasonable number according to the number of CPU cores in your machine.
   On a machine with an Intel i7-12700K processor (14-core, 20-thread) and 32 GiB of memory, `make -j20` took around 8 minutes to finish.
7. Output the results as a LaTeX tabular: `python3 stats.py`

The final table should have comparable results to Figure 5 in our paper.
