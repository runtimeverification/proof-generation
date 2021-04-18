ARG k_git=https://github.com/kframework/k.git
ARG k_version=v5.0.0-bbc70cb
ARG jdk_build=https://download.java.net/java/GA/jdk15.0.2/0d1cfde4252546c6931946de8db48ee2/7/GPL/openjdk-15.0.2_linux-x64_bin.tar.gz

# we first build the kframework and haskell backend
FROM ubuntu:20.04 AS BUILD

ARG k_git
ARG k_version
ARG jdk_build

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y \
        build-essential curl wget git m4 \
        libgmp-dev libmpfr-dev pkg-config flex bison \
        maven python3 cmake gcc clang-8 lld-8 \
        llvm-8-tools zlib1g-dev libboost-test-dev \
        libyaml-dev libjemalloc-dev

# install a custom version of openjdk
# TODO: this is a hack around a bug of jlink
# in openjdk 11 in ubuntu 20.04
RUN mkdir jdk-install && \
    cd jdk-install && \
    wget $jdk_build && \
    tar xzf *.tar.gz && \
    mv jdk-* /opt/jdk && \
    cd .. && \
    rm -r jdk-install
ENV PATH="/opt/jdk/bin:${PATH}"

RUN curl -sSL https://get.haskellstack.org/ | sh

RUN git clone --depth 1 --branch $k_version $k_git k_repo && \
    cd k_repo && \
    git submodule update --depth 1 --init --recursive

RUN cd k_repo && mvn -T 1C package -Dllvm.backend.skip -DskipTests

# pack a custom jvm with only the components we need
RUN deps=$(jdeps --ignore-missing-deps --print-module-deps k_repo/k-distribution/target/release/k/lib/kframework/java/*.jar) && \
    jlink --output jre --strip-debug --compress=2 --add-modules $deps

# build the actual image
# we need glibc for openjdk
FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y gcc flex bison python3 z3 && \
    apt-get clean

# NOTE: we might need these for the llvm backend
# libjemalloc-dev libgmp-dev
# libmpfr-dev libyaml-0-2
# llvm-8 clang-8 lld-8 libstdc++-9-dev

COPY --from=BUILD /k_repo/k-distribution/target/release/k/bin /opt/k/bin
COPY --from=BUILD /k_repo/k-distribution/target/release/k/lib /opt/k/lib
COPY --from=BUILD /k_repo/k-distribution/target/release/k/include /opt/k/include

# currently don't need these binaries
RUN rm /opt/k/bin/kore-repl \
       /opt/k/bin/kore-prof \
       /opt/k/bin/kore-parser \
       /opt/k/bin/kore-format

COPY --from=BUILD /jre /opt/jre

ENV PATH="/opt/k/bin:${PATH}"
ENV PATH="/opt/jre/bin:${PATH}"
