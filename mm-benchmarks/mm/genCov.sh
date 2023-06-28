#!/bin/bash

if [[ -f metamath.gcda ]]; then
    echo "Removing old gcda files"
    rm *.gcda
fi

if [[ -f metamath.gcno ]]; then
    echo "Removing old gcno files"
    rm *.gcno
fi

if [[ -f metamath.gcov ]]; then
    echo "Removing old gcov files"
    rm *.gcov
fi

if [[ -f coverage_wff.info ]]; then
    echo "Removing old info files"
    rm *.info
fi

if [[ -d CodeCoverage ]]; then
    echo "Removing old CodeCoverage directory"
    rm -rf CodeCoverage
fi

if [[ -f a.out ]]; then
    echo "Removing old a.out file"
    rm a.out
fi

if [[ -f metamath.o ]]; then
    echo "Removing old object files"
    rm *.o
fi

MM_BENCHMARKS_DIR="/Users/robertorosmaninho/rv/proof-generation/mm-benchmarks"

gcc m*.c -coverage -c  -O3 -funroll-loops -finline-functions \
  -fomit-frame-pointer -Wall -pedantic -Wno-unused-variable \
  -Wno-unused-but-set-variable -Wno-sometimes-uninitialized \
  -Wno-uninitialized
gcc --coverage *.o

shopt -s nullglob
for i in "$MM_BENCHMARKS_DIR"/*.mm; do
    TEST=$(basename "$i")
    TESTNAME=${TEST%%.*}
    echo "Executing test $i"
    ./a.out "read $i" "verify proof *" 'exit'
    echo "Generating coverage for $i"
    gcov *.gcno
    echo "Generating info for $i"
    geninfo . -b . -o "coverage_${TESTNAME}".info
done

lcov --rc branch_coverage=1 --add-tracefile coverage_matching-logic-200-loc.info \
  -a coverage_peano.info -a coverage_reflexivity.info -a coverage_simple.info \
  -a coverage_sum.info -a coverage_wff.info -o merged.info

genhtml merged.info -o CodeCoverage