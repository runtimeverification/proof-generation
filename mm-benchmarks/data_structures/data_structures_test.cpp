//#define ZKLLVM

#ifdef ZKLLVM
#include <nil/crypto3/algebra/curves/pallas.hpp>
#endif

#include "unit_tests.hpp"

#ifdef ZKLLVM
using namespace nil::crypto3::algebra::curves;

[[circuit]] typename pallas::base_field_type::value_type
circuit_main(typename pallas::base_field_type::value_type a,
             typename pallas::base_field_type::value_type b) {

  //testString();
  testLinkedList();
  testVector();
  testMap();
  testDeque();
  testSet();
  testQueue();

  return a + b;
}
#endif

#ifndef ZKLLVM
int main() {
//  testString();
  testLinkedList();
  std::cout << std::endl;
  testVector();
  std::cout << std::endl;
  testMap();
  std::cout << std::endl;
  testDeque();
  std::cout << std::endl;
  testSet();
  std::cout << std::endl;
  testQueue();
  return 0;
}
#endif