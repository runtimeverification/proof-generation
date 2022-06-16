# rust-metamath
A Metamath verifier written in rust


other verifier's that I will probably take inspiration from.


https://github.com/david-a-wheeler/metamath-knife

https://github.com/david-a-wheeler/mmverify.py






# Running

Compile it with `cargo build --release`, the binary should be in `/target/release`

Change to the correct directory then do `path/to/binary name-of-mm-file.mm`




# Features/Goals

The main goal of this project is to provide a faster metamath checker than the
default, as we've had some issues relating to its performance.

## Potential Features


### Extending Metamath

Some potential ideas for extending metamath would be adding some sort of
modularity in the import system. For instance, something similar to the python
module system in order to allow reuse of labels. 

Another idea is implementing some sort of tagging system, in case you want to
only verify a certain subset of your theorems, you could specifiy a certain tag
that you want to verify (or maybe ignore). 

### Paralellism

Incorporating parallelism to the verifying part would be nice, and I will
probably take inspiration from the metamath knife repo. I noticed that they also
parallelize the parsing, which I'm probably not going to implement because I
think the verifying part is the slow part, and it won't matter if the parsing is
already fast enough. 

### Caching 

Again taking inspiriation from the other rust checker, create some system of
caching results so repeated verifications can be faster by only checking proofs
that have changed. This would also mean creating a REPL like system, which may
be another feature. 

### ITP

Integration with an interactive theorem prover may also be a possibility. I'm
not exactly sure what features I would want to add. 

### Diagnostic information

Provide information such as how long certain proofs took, or how much space
certain proofs take. This could be used to identify which proofs should try to
be reworked. 

# Why Rust

Rust is a very fast language, and I prefer it over C and C++. 
