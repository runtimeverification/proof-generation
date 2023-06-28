cmake_minimum_required(VERSION 3.21)
project(mm_benchmarks)

set(CMAKE_CXX_STANDARD 20)

add_executable(mm_benchmarks
        checkmm-nr.cpp)
