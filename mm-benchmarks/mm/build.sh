#!/bin/bash

ZKL_LLVM_DIR=/home/robertorosmaninho/rv/zk-experiments/zkllvm
CRYPTO3_LIB_DIR=${ZKL_LLVM_DIR}/libs/crypto3
CLANG_EXE=${ZKL_LLVM_DIR}/build/libs/circifier/llvm/bin/clang-16
BOOST_1_82_0_DIR=/home/robertorosmaninho/rv/boost_1_82_0

${CLANG_EXE} -target assigner -Xclang -no-opaque-pointers -Xclang -fpreserve-vec3-type -std=c99 -D__ZKLLVM__ \
-I ${CRYPTO3_LIB_DIR}/algebra/include \
-I ${ZKL_LLVM_DIR}/build/include \
-I ${BOOST_1_82_0_DIR}/build/include \
-I ${CRYPTO3_LIB_DIR}/block/include \
-I ${BOOST_1_82_0_DIR}/build/include \
-I ${ZKL_LLVM_DIR}/libs/blueprint/include \
-I ${CRYPTO3_LIB_DIR}/codec/include \
-I ${CRYPTO3_LIB_DIR}/containers/include \
-I ${CRYPTO3_LIB_DIR}/hash/include \
-I ${CRYPTO3_LIB_DIR}/kdf/include \
-I ${CRYPTO3_LIB_DIR}/mac/include \
-I ${CRYPTO3_LIB_DIR}/marshalling/core/include \
-I ${CRYPTO3_LIB_DIR}/marshalling/algebra/include \
-I ${CRYPTO3_LIB_DIR}/marshalling/multiprecision/include \
-I ${CRYPTO3_LIB_DIR}/marshalling/zk/include \
-I ${CRYPTO3_LIB_DIR}/math/include \
-I ${CRYPTO3_LIB_DIR}/modes/include \
-I ${CRYPTO3_LIB_DIR}/multiprecision/include \
-I ${CRYPTO3_LIB_DIR}/passhash/include \
-I ${CRYPTO3_LIB_DIR}/pbkdf/include \
-I ${CRYPTO3_LIB_DIR}/pkmodes/include \
-I ${CRYPTO3_LIB_DIR}/pkpad/include \
-I ${CRYPTO3_LIB_DIR}/pubkey/include \
-I ${CRYPTO3_LIB_DIR}/random/include \
-I ${CRYPTO3_LIB_DIR}/stream/include \
-I ${CRYPTO3_LIB_DIR}/vdf/include \
-I ${CRYPTO3_LIB_DIR}/zk/include \
-I ${ZKL_LLVM_DIR}/libs/stdlib/libcpp \
-I ${ZKL_LLVM_DIR}/libs/stdlib/libc/include \
-emit-llvm -O1 -c main.c -O3 -funroll-loops -finline-functions -fomit-frame-pointer -Wall -pedantic \
-Wno-unused-but-set-variable -Wno-misleading-indentation -Wno-writable-strings