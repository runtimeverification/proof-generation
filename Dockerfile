ARG jdk_build=https://download.java.net/java/GA/jdk15.0.2/0d1cfde4252546c6931946de8db48ee2/7/GPL/openjdk-15.0.2_linux-x64_bin.tar.gz

###########################
# Base image for building #
###########################

FROM ubuntu:20.04 AS base

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
        build-essential m4 libgmp-dev libmpfr-dev \
        pkg-config flex bison z3 libz3-dev maven \
        python3 cmake gcc clang-8 lld-8 llvm-8-tools \
        zlib1g-dev libboost-test-dev libyaml-dev \
        libjemalloc-dev wget git curl

# install a custom version of openjdk
ARG jdk_build
RUN mkdir jdk-install && \
    cd jdk-install && \
    wget -q --show-progress $jdk_build && \
    tar xf *.tar.* && \
    mv jdk-* /opt/jdk && \
    cd .. && \
    rm -r jdk-install
ENV PATH="/opt/jdk/bin:${PATH}"

# install haskell
RUN curl -sSL https://get.haskellstack.org/ | sh

######################
# Build dependencies #
######################

FROM base AS build

# clone the K repo
ADD deps/k /k

# the submodules should already be checked out
# git submodule update --init --recursive --depth 1

# build k
RUN cd k && mvn package --batch-mode dependency:go-offline -T 1C -DskipTests

# strip symbols not used for relocation
RUN cd /k/k-distribution/target/release/k && \
    strip --strip-unneeded bin/* $(find lib/kllvm -name "*") | exit 0

# remove some less used binaries
RUN cd /k/k-distribution/target/release/k/bin/ && \
    rm -f kore-format kore-prof kore-repl

# pack a custom jvm with only the components we need
RUN deps=$(jdeps --ignore-missing-deps --print-module-deps k/k-distribution/target/release/k/lib/kframework/java/*.jar) && \
    jlink --output /jre \
          --strip-debug \
          --no-header-files \
          --no-man-pages \
          --compress=2 \
          --add-modules $deps

# Build rust-metamath
ADD deps/rust-metamath /rust-metamath
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s - -y
RUN . "$HOME/.cargo/env" && cd rust-metamath && cargo build --release

# Build smetamath-rs
ADD deps/smetamath-rs /smetamath-rs
RUN . "$HOME/.cargo/env" && cd smetamath-rs && cargo build --release

###################################################
# Pack final image with only runtime dependencies #
###################################################

FROM ubuntu:22.04 AS final

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        tcc libc-dev flex bison z3 pypy3 python3-pip \
        libjemalloc-dev metamath make time xz-utils && \
    rm -rf /var/lib/apt/lists/* && \
    ln -s /usr/bin/tcc /usr/bin/gcc

COPY --from=build /jre /opt/jre
COPY --from=build /k/k-distribution/target/release/k/bin /opt/k/bin
COPY --from=build /k/k-distribution/target/release/k/lib /opt/k/lib
COPY --from=build /k/k-distribution/target/release/k/include /opt/k/include

COPY --from=build /rust-metamath/target/release/rust-metamath /opt/rust-metamath/rust-metamath
COPY --from=build /smetamath-rs/target/release/smetamath /opt/smetamath-rs/smetamath

ENV PATH="/opt/smetamath-rs:/opt/rust-metamath:/opt/k/bin:/opt/jre/bin:${PATH}"

WORKDIR /opt/proof-generation
ADD ml ml
ADD scripts scripts
ADD theory theory
ADD evaluation evaluation
ADD requirements.txt requirements.txt

RUN pypy3 -m pip install -r requirements.txt

WORKDIR /opt/proof-generation/evaluation
