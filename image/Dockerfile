ARG k_git=https://github.com/kframework/k.git
ARG k_version=v5.0.0-bbc70cb
ARG jdk_build=https://download.java.net/java/GA/jdk15.0.2/0d1cfde4252546c6931946de8db48ee2/7/GPL/openjdk-15.0.2_linux-x64_bin.tar.gz
ARG pypy_build=https://downloads.python.org/pypy/pypy3.7-v7.3.4-linux64.tar.bz2
ARG metamath_build=http://us.metamath.org/downloads/metamath.tar.bz2

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
    jlink \
        --output jre \
        --strip-debug \
        --no-header-files \
        --no-man-pages \
        --compress=2 \
        --add-modules $deps

# download pypy3.7
ARG pypy_build
RUN mkdir pypy && cd pypy && \
    wget $pypy_build && \
    tar xf $(basename $pypy_build) && \
    rm $(basename $pypy_build)

# download and build metamath
ARG metamath_build
RUN mkdir metamath && cd metamath && \
    wget $metamath_build && \
    tar xf $(basename $metamath_build) && \
    rm $(basename $metamath_build) && \
    cd * && gcc *.c -o metamath

#####################################################################################

# build the actual image
# we need glibc for openjdk
FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y flex bison z3 && \
    rm -rf /var/lib/apt/lists/*

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
ENV PATH="/opt/k/bin:${PATH}"

COPY --from=BUILD /jre /opt/jre
ENV PATH="/opt/jre/bin:${PATH}"

COPY --from=BUILD /pypy/* /opt/pypy
ENV PATH="/opt/pypy/bin:${PATH}"

COPY --from=BUILD /metamath/metamath/metamath /opt/metamath/bin/metamath
ENV PATH="/opt/metamath/bin:${PATH}"

# set up AE directory
RUN mkdir cav21
WORKDIR /cav21

ADD eval repo/eval
ADD ml repo/ml
ADD scripts repo/scripts
ADD theory repo/theory
ADD requirements.txt repo

RUN pypy3 -m ensurepip && \
    pypy3 -m pip install --no-cache-dir -r repo/requirements.txt

# copy the paper and README.md
# according to the requirements
# of CAV 2021 AE
ADD image/submission-v1.pdf paper.pdf
ADD image/README.md README.md
ADD image/init.sh /root/init.sh

RUN echo ". ~/init.sh" >> /root/.bashrc
