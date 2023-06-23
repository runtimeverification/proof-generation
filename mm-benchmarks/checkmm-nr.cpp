// Metamath database verifier
// Eric Schmidt (eric41293@comcast.net)
//
// I release this code to the public domain under the
// Creative Commons "CC0 1.0 Universal" Public Domain Dedication:
//
// http://creativecommons.org/publicdomain/zero/1.0/
//
// This is a standalone verifier for Metamath database files,
// written in portable C++. Run it with a single file name as the
// parameter.
//
// Some notes:
//
// The code assumes that the character set is compatible with ASCII.
//
// According to the spec, file inclusion commands should not include a file
// that has already been included. Unfortunately, determing whether two
// different size_ts refer to the same file is not easy, and, worse, is
// system-dependant. This program ignores the issue entirely and assumes
// that distinct size_ts name different files. This should be adequate for
// the present, at least.
//
// If the verifier finds an error, it will report it and quit. It will not
// attempt to recover and find more errors. The only condition that generates
// a diagnostic message but doesn't halt the program is an incomplete proof,
// specified by a question mark. In that case, as per the spec, a warning is
// issued and checking continues.
//
// Please let me know of any bugs.

#include <algorithm>
#include <cctype>
#include <cstdlib>
#include <deque>
#include <iostream>
#include <iterator>
#include <limits>
#include <map>
#include <queue>
#include <set>
#include <string>
#include <utility>
#include <vector>

#define MAX_INT 4294967295

std::vector<std::size_t>::iterator findToken(std::vector<std::size_t> v,
                                             std::size_t elem) {
  return std::find(v.begin(), v.end(), elem);
}

std::vector<std::string> tokens_vector_matching_logic_200_loc = {
        "$c",
        "#Pattern",
        "#ElementVariable",
        "#SetVariable",
        "#Variable",
        "#Symbol",
        "$.",
        "$v",
        "ph0",
        "ph1",
        "ph2",
        "ph3",
        "ph4",
        "ph5",
        "x",
        "y",
        "X",
        "Y",
        "xX",
        "yY",
        "sg0",
        "$.",
        "ph0-is-pattern",
        "$f",
        "#Pattern",
        "ph0",
        "$.",
        "ph1-is-pattern",
        "$f",
        "#Pattern",
        "ph1",
        "$.",
        "ph2-is-pattern",
        "$f",
        "#Pattern",
        "ph2",
        "$.",
        "ph3-is-pattern",
        "$f",
        "#Pattern",
        "ph3",
        "$.",
        "ph4-is-pattern",
        "$f",
        "#Pattern",
        "ph4",
        "$.",
        "ph5-is-pattern",
        "$f",
        "#Pattern",
        "ph5",
        "$.",
        "x-is-element-var",
        "$f",
        "#ElementVariable",
        "x",
        "$.",
        "y-is-element-var",
        "$f",
        "#ElementVariable",
        "y",
        "$.",
        "X-is-element-var",
        "$f",
        "#SetVariable",
        "X",
        "$.",
        "Y-is-element-var",
        "$f",
        "#SetVariable",
        "Y",
        "$.",
        "xX-is-var",
        "$f",
        "#Variable",
        "xX",
        "$.",
        "yY-is-var",
        "$f",
        "#Variable",
        "yY",
        "$.",
        "sg0-is-symbol",
        "$f",
        "#Symbol",
        "sg0",
        "$.",
        "element-var-is-var",
        "$a",
        "#Variable",
        "x",
        "$.",
        "set-var-is-var",
        "$a",
        "#Variable",
        "X",
        "$.",
        "var-is-pattern",
        "$a",
        "#Pattern",
        "xX",
        "$.",
        "symbol-is-pattern",
        "$a",
        "#Pattern",
        "sg0",
        "$.",
        "$c",
        "#Positive",
        "#Negative",
        "#Fresh",
        "#ApplicationContext",
        "#Substitution",
        "#Notation",
        "|-",
        "$.",
        "$c",
        "\\bot",
        "\\imp",
        "\\app",
        "\\exists",
        "\\mu",
        "(",
        ")",
        "$.",
        "bot-is-pattern",
        "$a",
        "#Pattern",
        "\\bot",
        "$.",
        "imp-is-pattern",
        "$a",
        "#Pattern",
        "(",
        "\\imp",
        "ph0",
        "ph1",
        ")",
        "$.",
        "app-is-pattern",
        "$a",
        "#Pattern",
        "(",
        "\\app",
        "ph0",
        "ph1",
        ")",
        "$.",
        "exists-is-pattern",
        "$a",
        "#Pattern",
        "(",
        "\\exists",
        "x",
        "ph0",
        ")",
        "$.",
        "${",
        "mu-is-pattern.0",
        "$e",
        "#Positive",
        "X",
        "ph0",
        "$.",
        "mu-is-pattern",
        "$a",
        "#Pattern",
        "(",
        "\\mu",
        "X",
        "ph0",
        ")",
        "$.",
        "$}",
        "positive-in-var",
        "$a",
        "#Positive",
        "xX",
        "yY",
        "$.",
        "positive-in-symbol",
        "$a",
        "#Positive",
        "xX",
        "sg0",
        "$.",
        "positive-in-bot",
        "$a",
        "#Positive",
        "xX",
        "\\bot",
        "$.",
        "${",
        "positive-in-imp.0",
        "$e",
        "#Negative",
        "xX",
        "ph0",
        "$.",
        "positive-in-imp.1",
        "$e",
        "#Positive",
        "xX",
        "ph1",
        "$.",
        "positive-in-imp",
        "$a",
        "#Positive",
        "xX",
        "(",
        "\\imp",
        "ph0",
        "ph1",
        ")",
        "$.",
        "$}",
        "${",
        "positive-in-app.0",
        "$e",
        "#Positive",
        "xX",
        "ph0",
        "$.",
        "positive-in-app.1",
        "$e",
        "#Positive",
        "xX",
        "ph1",
        "$.",
        "positive-in-app",
        "$a",
        "#Positive",
        "xX",
        "(",
        "\\app",
        "ph0",
        "ph1",
        ")",
        "$.",
        "$}",
        "${",
        "positive-in-exists.0",
        "$e",
        "#Positive",
        "xX",
        "ph0",
        "$.",
        "positive-in-exists",
        "$a",
        "#Positive",
        "xX",
        "(",
        "\\exists",
        "x",
        "ph0",
        ")",
        "$.",
        "$}",
        "${",
        "positive-in-mu.0",
        "$e",
        "#Positive",
        "xX",
        "ph0",
        "$.",
        "positive-in-mu",
        "$a",
        "#Positive",
        "xX",
        "(",
        "\\mu",
        "X",
        "ph0",
        ")",
        "$.",
        "$}",
        "${",
        "$d",
        "xX",
        "ph0",
        "$.",
        "positive-disjoint",
        "$a",
        "#Positive",
        "xX",
        "ph0",
        "$.",
        "$}",
        "${",
        "$d",
        "xX",
        "yY",
        "$.",
        "negative-in-var",
        "$a",
        "#Negative",
        "xX",
        "yY",
        "$.",
        "$}",
        "negative-in-symbol",
        "$a",
        "#Negative",
        "xX",
        "sg0",
        "$.",
        "negative-in-bot",
        "$a",
        "#Negative",
        "xX",
        "\\bot",
        "$.",
        "${",
        "negative-in-imp.0",
        "$e",
        "#Positive",
        "xX",
        "ph0",
        "$.",
        "negative-in-imp.1",
        "$e",
        "#Negative",
        "xX",
        "ph1",
        "$.",
        "negative-in-imp",
        "$a",
        "#Negative",
        "xX",
        "(",
        "\\imp",
        "ph0",
        "ph1",
        ")",
        "$.",
        "$}",
        "${",
        "negative-in-app.0",
        "$e",
        "#Negative",
        "xX",
        "ph0",
        "$.",
        "negative-in-app.1",
        "$e",
        "#Negative",
        "xX",
        "ph1",
        "$.",
        "negative-in-app",
        "$a",
        "#Negative",
        "xX",
        "(",
        "\\app",
        "ph0",
        "ph1",
        ")",
        "$.",
        "$}",
        "${",
        "negative-in-exists.0",
        "$e",
        "#Negative",
        "xX",
        "ph0",
        "$.",
        "negative-in-exists",
        "$a",
        "#Negative",
        "xX",
        "(",
        "\\exists",
        "x",
        "ph0",
        ")",
        "$.",
        "$}",
        "${",
        "negative-in-mu.0",
        "$e",
        "#Negative",
        "xX",
        "ph0",
        "$.",
        "negative-in-mu",
        "$a",
        "#Negative",
        "xX",
        "(",
        "\\mu",
        "X",
        "ph0",
        ")",
        "$.",
        "$}",
        "${",
        "$d",
        "xX",
        "ph0",
        "$.",
        "negative-disjoint",
        "$a",
        "#Negative",
        "xX",
        "ph0",
        "$.",
        "$}",
        "${",
        "$d",
        "xX",
        "yY",
        "$.",
        "fresh-in-var",
        "$a",
        "#Fresh",
        "xX",
        "yY",
        "$.",
        "$}",
        "fresh-in-symbol",
        "$a",
        "#Fresh",
        "xX",
        "sg0",
        "$.",
        "fresh-in-bot",
        "$a",
        "#Fresh",
        "xX",
        "\\bot",
        "$.",
        "${",
        "fresh-in-imp.0",
        "$e",
        "#Fresh",
        "xX",
        "ph0",
        "$.",
        "fresh-in-imp.1",
        "$e",
        "#Fresh",
        "xX",
        "ph1",
        "$.",
        "fresh-in-imp",
        "$a",
        "#Fresh",
        "xX",
        "(",
        "\\imp",
        "ph0",
        "ph1",
        ")",
        "$.",
        "$}",
        "${",
        "fresh-in-app.0",
        "$e",
        "#Fresh",
        "xX",
        "ph0",
        "$.",
        "fresh-in-app.1",
        "$e",
        "#Fresh",
        "xX",
        "ph1",
        "$.",
        "fresh-in-app",
        "$a",
        "#Fresh",
        "xX",
        "(",
        "\\app",
        "ph0",
        "ph1",
        ")",
        "$.",
        "$}",
        "${",
        "$d",
        "xX",
        "x",
        "$.",
        "fresh-in-exists.0",
        "$e",
        "#Fresh",
        "xX",
        "ph0",
        "$.",
        "fresh-in-exists",
        "$a",
        "#Fresh",
        "xX",
        "(",
        "\\exists",
        "x",
        "ph0",
        ")",
        "$.",
        "$}",
        "fresh-in-exists-shadowed",
        "$a",
        "#Fresh",
        "x",
        "(",
        "\\exists",
        "x",
        "ph0",
        ")",
        "$.",
        "${",
        "$d",
        "xX",
        "X",
        "$.",
        "fresh-in-mu.0",
        "$e",
        "#Fresh",
        "xX",
        "ph0",
        "$.",
        "fresh-in-mu",
        "$a",
        "#Fresh",
        "xX",
        "(",
        "\\mu",
        "X",
        "ph0",
        ")",
        "$.",
        "$}",
        "fresh-in-mu-shadowed",
        "$a",
        "#Fresh",
        "X",
        "(",
        "\\mu",
        "X",
        "ph0",
        ")",
        "$.",
        "${",
        "$d",
        "xX",
        "ph0",
        "$.",
        "fresh-disjoint",
        "$a",
        "#Fresh",
        "xX",
        "ph0",
        "$.",
        "$}",
        "${",
        "fresh-in-substitution.0",
        "$e",
        "#Fresh",
        "xX",
        "ph1",
        "$.",
        "fresh-in-substitution.1",
        "$e",
        "#Substitution",
        "ph2",
        "ph0",
        "ph1",
        "xX",
        "$.",
        "fresh-in-substitution",
        "$a",
        "#Fresh",
        "xX",
        "ph2",
        "$.",
        "$}",
        "${",
        "fresh-after-substitution.0",
        "$e",
        "#Fresh",
        "xX",
        "ph0",
        "$.",
        "fresh-after-substitution.1",
        "$e",
        "#Fresh",
        "xX",
        "ph1",
        "$.",
        "fresh-after-substitution.2",
        "$e",
        "#Substitution",
        "ph2",
        "ph0",
        "ph1",
        "yY",
        "$.",
        "fresh-after-substitution",
        "$a",
        "#Fresh",
        "xX",
        "ph2",
        "$.",
        "$}",
        "substitution-var-same",
        "$a",
        "#Substitution",
        "ph0",
        "xX",
        "ph0",
        "xX",
        "$.",
        "${",
        "$d",
        "xX",
        "yY",
        "$.",
        "substitution-var-diff",
        "$a",
        "#Substitution",
        "yY",
        "yY",
        "ph0",
        "xX",
        "$.",
        "$}",
        "substitution-symbol",
        "$a",
        "#Substitution",
        "sg0",
        "sg0",
        "ph0",
        "xX",
        "$.",
        "substitution-bot",
        "$a",
        "#Substitution",
        "\\bot",
        "\\bot",
        "ph0",
        "xX",
        "$.",
        "${",
        "substitution-imp.0",
        "$e",
        "#Substitution",
        "ph1",
        "ph3",
        "ph0",
        "xX",
        "$.",
        "substitution-imp.1",
        "$e",
        "#Substitution",
        "ph2",
        "ph4",
        "ph0",
        "xX",
        "$.",
        "substitution-imp",
        "$a",
        "#Substitution",
        "(",
        "\\imp",
        "ph1",
        "ph2",
        ")",
        "(",
        "\\imp",
        "ph3",
        "ph4",
        ")",
        "ph0",
        "xX",
        "$.",
        "$}",
        "${",
        "substitution-app.0",
        "$e",
        "#Substitution",
        "ph1",
        "ph3",
        "ph0",
        "xX",
        "$.",
        "substitution-app.1",
        "$e",
        "#Substitution",
        "ph2",
        "ph4",
        "ph0",
        "xX",
        "$.",
        "substitution-app",
        "$a",
        "#Substitution",
        "(",
        "\\app",
        "ph1",
        "ph2",
        ")",
        "(",
        "\\app",
        "ph3",
        "ph4",
        ")",
        "ph0",
        "xX",
        "$.",
        "$}",
        "substitution-exists-shadowed",
        "$a",
        "#Substitution",
        "(",
        "\\exists",
        "x",
        "ph1",
        ")",
        "(",
        "\\exists",
        "x",
        "ph1",
        ")",
        "ph0",
        "x",
        "$.",
        "${",
        "$d",
        "xX",
        "x",
        "$.",
        "$d",
        "y",
        "ph0",
        "$.",
        "substitution-exists.0",
        "$e",
        "#Substitution",
        "ph2",
        "ph1",
        "y",
        "x",
        "$.",
        "substitution-exists.1",
        "$e",
        "#Substitution",
        "ph3",
        "ph2",
        "ph0",
        "xX",
        "$.",
        "substitution-exists",
        "$a",
        "#Substitution",
        "(",
        "\\exists",
        "y",
        "ph3",
        ")",
        "(",
        "\\exists",
        "x",
        "ph1",
        ")",
        "ph0",
        "xX",
        "$.",
        "$}",
        "substitution-mu-shadowed",
        "$a",
        "#Substitution",
        "(",
        "\\mu",
        "X",
        "ph1",
        ")",
        "(",
        "\\mu",
        "X",
        "ph1",
        ")",
        "ph0",
        "X",
        "$.",
        "${",
        "$d",
        "xX",
        "X",
        "$.",
        "$d",
        "Y",
        "ph0",
        "$.",
        "substitution-mu.0",
        "$e",
        "#Substitution",
        "ph2",
        "ph1",
        "Y",
        "X",
        "$.",
        "substitution-mu.1",
        "$e",
        "#Substitution",
        "ph3",
        "ph2",
        "ph0",
        "xX",
        "$.",
        "substitution-mu",
        "$a",
        "#Substitution",
        "(",
        "\\mu",
        "Y",
        "ph3",
        ")",
        "(",
        "\\mu",
        "X",
        "ph1",
        ")",
        "ph0",
        "xX",
        "$.",
        "$}",
        "substitution-identity",
        "$a",
        "#Substitution",
        "ph0",
        "ph0",
        "xX",
        "xX",
        "$.",
        "${",
        "yY-free-in-ph0",
        "$e",
        "#Fresh",
        "yY",
        "ph0",
        "$.",
        "ph1-definition",
        "$e",
        "#Substitution",
        "ph1",
        "ph0",
        "yY",
        "xX",
        "$.",
        "${",
        "substitution-fold.0",
        "$e",
        "#Substitution",
        "ph2",
        "ph1",
        "ph3",
        "yY",
        "$.",
        "substitution-fold",
        "$a",
        "#Substitution",
        "ph2",
        "ph0",
        "ph3",
        "xX",
        "$.",
        "$}",
        "${",
        "substitution-unfold.0",
        "$e",
        "#Substitution",
        "ph2",
        "ph0",
        "ph3",
        "xX",
        "$.",
        "substitution-unfold",
        "$a",
        "#Substitution",
        "ph2",
        "ph1",
        "ph3",
        "yY",
        "$.",
        "$}",
        "$}",
        "${",
        "substitution-inverse.0",
        "$e",
        "#Fresh",
        "xX",
        "ph0",
        "$.",
        "substitution-inverse.1",
        "$e",
        "#Substitution",
        "ph1",
        "ph0",
        "xX",
        "yY",
        "$.",
        "substitution-inverse",
        "$a",
        "#Substitution",
        "ph0",
        "ph1",
        "yY",
        "xX",
        "$.",
        "$}",
        "${",
        "substitution-fresh.0",
        "$e",
        "#Fresh",
        "xX",
        "ph0",
        "$.",
        "substitution-fresh",
        "$a",
        "#Substitution",
        "ph0",
        "ph0",
        "ph1",
        "xX",
        "$.",
        "$}",
        "application-context-var",
        "$a",
        "#ApplicationContext",
        "xX",
        "xX",
        "$.",
        "${",
        "$d",
        "xX",
        "ph1",
        "$.",
        "application-context-app-left.0",
        "$e",
        "#ApplicationContext",
        "xX",
        "ph0",
        "$.",
        "application-context-app-left",
        "$a",
        "#ApplicationContext",
        "xX",
        "(",
        "\\app",
        "ph0",
        "ph1",
        ")",
        "$.",
        "$}",
        "${",
        "$d",
        "xX",
        "ph0",
        "$.",
        "application-context-app-right.0",
        "$e",
        "#ApplicationContext",
        "xX",
        "ph1",
        "$.",
        "application-context-app-right",
        "$a",
        "#ApplicationContext",
        "xX",
        "(",
        "\\app",
        "ph0",
        "ph1",
        ")",
        "$.",
        "$}",
        "notation-reflexivity",
        "$a",
        "#Notation",
        "ph0",
        "ph0",
        "$.",
        "${",
        "notation-symmetry.0",
        "$e",
        "#Notation",
        "ph0",
        "ph1",
        "$.",
        "notation-symmetry",
        "$a",
        "#Notation",
        "ph1",
        "ph0",
        "$.",
        "$}",
        "${",
        "notation-transitivity.0",
        "$e",
        "#Notation",
        "ph0",
        "ph1",
        "$.",
        "notation-transitivity.1",
        "$e",
        "#Notation",
        "ph1",
        "ph2",
        "$.",
        "notation-transitivity",
        "$a",
        "#Notation",
        "ph0",
        "ph2",
        "$.",
        "$}",
        "${",
        "notation-positive.0",
        "$e",
        "#Positive",
        "xX",
        "ph0",
        "$.",
        "notation-positive.1",
        "$e",
        "#Notation",
        "ph1",
        "ph0",
        "$.",
        "notation-positive",
        "$a",
        "#Positive",
        "xX",
        "ph1",
        "$.",
        "$}",
        "${",
        "notation-negative.0",
        "$e",
        "#Negative",
        "xX",
        "ph0",
        "$.",
        "notation-negative.1",
        "$e",
        "#Notation",
        "ph1",
        "ph0",
        "$.",
        "notation-negative",
        "$a",
        "#Negative",
        "xX",
        "ph1",
        "$.",
        "$}",
        "${",
        "notation-fresh.0",
        "$e",
        "#Fresh",
        "xX",
        "ph0",
        "$.",
        "notation-fresh.1",
        "$e",
        "#Notation",
        "ph1",
        "ph0",
        "$.",
        "notation-fresh",
        "$a",
        "#Fresh",
        "xX",
        "ph1",
        "$.",
        "$}",
        "${",
        "notation-substitution.0",
        "$e",
        "#Substitution",
        "ph0",
        "ph1",
        "ph2",
        "xX",
        "$.",
        "notation-substitution.1",
        "$e",
        "#Notation",
        "ph3",
        "ph0",
        "$.",
        "notation-substitution.2",
        "$e",
        "#Notation",
        "ph4",
        "ph1",
        "$.",
        "notation-substitution.3",
        "$e",
        "#Notation",
        "ph5",
        "ph2",
        "$.",
        "notation-substitution",
        "$a",
        "#Substitution",
        "ph3",
        "ph4",
        "ph5",
        "xX",
        "$.",
        "$}",
        "${",
        "notation-notation.0",
        "$e",
        "#Notation",
        "ph0",
        "ph1",
        "$.",
        "notation-notation.1",
        "$e",
        "#Notation",
        "ph2",
        "ph0",
        "$.",
        "notation-notation.2",
        "$e",
        "#Notation",
        "ph3",
        "ph1",
        "$.",
        "notation-notation",
        "$p",
        "#Notation",
        "ph2",
        "ph3",
        "$=",
        "(",
        "notation-transitivity",
        "notation-symmetry",
        ")",
        "CADFABDEDBGIHH",
        "$.",
        "$}",
        "${",
        "notation-application-context.0",
        "$e",
        "#ApplicationContext",
        "xX",
        "ph0",
        "$.",
        "notation-application-context.1",
        "$e",
        "#Notation",
        "ph1",
        "ph0",
        "$.",
        "notation-application-context",
        "$a",
        "#ApplicationContext",
        "xX",
        "ph1",
        "$.",
        "$}",
        "${",
        "notation-proof.0",
        "$e",
        "|-",
        "ph0",
        "$.",
        "notation-proof.1",
        "$e",
        "#Notation",
        "ph1",
        "ph0",
        "$.",
        "notation-proof",
        "$a",
        "|-",
        "ph1",
        "$.",
        "$}",
        "${",
        "notation-imp.0",
        "$e",
        "#Notation",
        "ph0",
        "ph2",
        "$.",
        "notation-imp.1",
        "$e",
        "#Notation",
        "ph1",
        "ph3",
        "$.",
        "notation-imp",
        "$a",
        "#Notation",
        "(",
        "\\imp",
        "ph0",
        "ph1",
        ")",
        "(",
        "\\imp",
        "ph2",
        "ph3",
        ")",
        "$.",
        "$}",
        "${",
        "notation-app.0",
        "$e",
        "#Notation",
        "ph0",
        "ph2",
        "$.",
        "notation-app.1",
        "$e",
        "#Notation",
        "ph1",
        "ph3",
        "$.",
        "notation-app",
        "$a",
        "#Notation",
        "(",
        "\\app",
        "ph0",
        "ph1",
        ")",
        "(",
        "\\app",
        "ph2",
        "ph3",
        ")",
        "$.",
        "$}",
        "${",
        "notation-exists.0",
        "$e",
        "#Notation",
        "ph0",
        "ph1",
        "$.",
        "notation-exists",
        "$a",
        "#Notation",
        "(",
        "\\exists",
        "x",
        "ph0",
        ")",
        "(",
        "\\exists",
        "x",
        "ph1",
        ")",
        "$.",
        "$}",
        "${",
        "notation-mu.0",
        "$e",
        "#Notation",
        "ph0",
        "ph1",
        "$.",
        "notation-mu",
        "$a",
        "#Notation",
        "(",
        "\\mu",
        "X",
        "ph0",
        ")",
        "(",
        "\\mu",
        "X",
        "ph1",
        ")",
        "$.",
        "$}",
        "$c",
        "\\not",
        "$.",
        "not-is-pattern",
        "$a",
        "#Pattern",
        "(",
        "\\not",
        "ph0",
        ")",
        "$.",
        "not-is-sugar",
        "$a",
        "#Notation",
        "(",
        "\\not",
        "ph0",
        ")",
        "(",
        "\\imp",
        "ph0",
        "\\bot",
        ")",
        "$.",
        "$c",
        "\\or",
        "$.",
        "or-is-pattern",
        "$a",
        "#Pattern",
        "(",
        "\\or",
        "ph0",
        "ph1",
        ")",
        "$.",
        "or-is-sugar",
        "$a",
        "#Notation",
        "(",
        "\\or",
        "ph0",
        "ph1",
        ")",
        "(",
        "\\imp",
        "(",
        "\\not",
        "ph0",
        ")",
        "ph1",
        ")",
        "$.",
        "$c",
        "\\and",
        "$.",
        "and-is-pattern",
        "$a",
        "#Pattern",
        "(",
        "\\and",
        "ph0",
        "ph1",
        ")",
        "$.",
        "and-is-sugar",
        "$a",
        "#Notation",
        "(",
        "\\and",
        "ph0",
        "ph1",
        ")",
        "(",
        "\\not",
        "(",
        "\\or",
        "(",
        "\\not",
        "ph0",
        ")",
        "(",
        "\\not",
        "ph1",
        ")",
        ")",
        ")",
        "$.",
        "proof-rule-prop-1",
        "$a",
        "|-",
        "(",
        "\\imp",
        "ph0",
        "(",
        "\\imp",
        "ph1",
        "ph0",
        ")",
        ")",
        "$.",
        "proof-rule-prop-2",
        "$a",
        "|-",
        "(",
        "\\imp",
        "(",
        "\\imp",
        "ph0",
        "(",
        "\\imp",
        "ph1",
        "ph2",
        ")",
        ")",
        "(",
        "\\imp",
        "(",
        "\\imp",
        "ph0",
        "ph1",
        ")",
        "(",
        "\\imp",
        "ph0",
        "ph2",
        ")",
        ")",
        ")",
        "$.",
        "proof-rule-prop-3",
        "$a",
        "|-",
        "(",
        "\\imp",
        "(",
        "\\imp",
        "(",
        "\\imp",
        "ph0",
        "\\bot",
        ")",
        "\\bot",
        ")",
        "ph0",
        ")",
        "$.",
        "${",
        "proof-rule-mp.0",
        "$e",
        "|-",
        "(",
        "\\imp",
        "ph0",
        "ph1",
        ")",
        "$.",
        "proof-rule-mp.1",
        "$e",
        "|-",
        "ph0",
        "$.",
        "proof-rule-mp",
        "$a",
        "|-",
        "ph1",
        "$.",
        "$}",
        "${",
        "proof-rule-exists.0",
        "$e",
        "#Substitution",
        "ph0",
        "ph1",
        "y",
        "x",
        "$.",
        "proof-rule-exists",
        "$a",
        "|-",
        "(",
        "\\imp",
        "ph0",
        "(",
        "\\exists",
        "x",
        "ph1",
        ")",
        ")",
        "$.",
        "$}",
        "${",
        "proof-rule-gen.0",
        "$e",
        "|-",
        "(",
        "\\imp",
        "ph0",
        "ph1",
        ")",
        "$.",
        "proof-rule-gen.1",
        "$e",
        "#Fresh",
        "x",
        "ph1",
        "$.",
        "proof-rule-gen",
        "$a",
        "|-",
        "(",
        "\\imp",
        "(",
        "\\exists",
        "x",
        "ph0",
        ")",
        "ph1",
        ")",
        "$.",
        "$}",
        "${",
        "proof-rule-propagation-bot.0",
        "$e",
        "#ApplicationContext",
        "xX",
        "ph0",
        "$.",
        "proof-rule-propagation-bot.1",
        "$e",
        "#Substitution",
        "ph1",
        "ph0",
        "\\bot",
        "xX",
        "$.",
        "proof-rule-propagation-bot",
        "$a",
        "|-",
        "(",
        "\\imp",
        "ph1",
        "\\bot",
        ")",
        "$.",
        "$}",
        "${",
        "proof-rule-propagation-or.0",
        "$e",
        "#ApplicationContext",
        "xX",
        "ph0",
        "$.",
        "proof-rule-propagation-or.1",
        "$e",
        "#Substitution",
        "ph1",
        "ph0",
        "(",
        "\\or",
        "ph4",
        "ph5",
        ")",
        "xX",
        "$.",
        "proof-rule-propagation-or.2",
        "$e",
        "#Substitution",
        "ph2",
        "ph0",
        "ph4",
        "xX",
        "$.",
        "proof-rule-propagation-or.3",
        "$e",
        "#Substitution",
        "ph3",
        "ph0",
        "ph5",
        "xX",
        "$.",
        "proof-rule-propagation-or",
        "$a",
        "|-",
        "(",
        "\\imp",
        "ph1",
        "(",
        "\\or",
        "ph2",
        "ph3",
        ")",
        ")",
        "$.",
        "$}",
        "${",
        "proof-rule-propagation-exists.0",
        "$e",
        "#ApplicationContext",
        "xX",
        "ph0",
        "$.",
        "proof-rule-propagation-exists.1",
        "$e",
        "#Substitution",
        "ph1",
        "ph0",
        "(",
        "\\exists",
        "y",
        "ph3",
        ")",
        "xX",
        "$.",
        "proof-rule-propagation-exists.2",
        "$e",
        "#Substitution",
        "ph2",
        "ph0",
        "ph3",
        "xX",
        "$.",
        "proof-rule-propagation-exists.3",
        "$e",
        "#Fresh",
        "y",
        "ph0",
        "$.",
        "proof-rule-propagation-exists",
        "$a",
        "|-",
        "(",
        "\\imp",
        "ph1",
        "(",
        "\\exists",
        "y",
        "ph2",
        ")",
        ")",
        "$.",
        "$}",
        "${",
        "proof-rule-frame.0",
        "$e",
        "#ApplicationContext",
        "xX",
        "ph0",
        "$.",
        "proof-rule-frame.1",
        "$e",
        "#Substitution",
        "ph1",
        "ph0",
        "ph3",
        "xX",
        "$.",
        "proof-rule-frame.2",
        "$e",
        "#Substitution",
        "ph2",
        "ph0",
        "ph4",
        "xX",
        "$.",
        "proof-rule-frame.3",
        "$e",
        "|-",
        "(",
        "\\imp",
        "ph3",
        "ph4",
        ")",
        "$.",
        "proof-rule-frame",
        "$a",
        "|-",
        "(",
        "\\imp",
        "ph1",
        "ph2",
        ")",
        "$.",
        "$}",
        "${",
        "proof-rule-prefixpoint.0",
        "$e",
        "#Substitution",
        "ph0",
        "ph1",
        "(",
        "\\mu",
        "X",
        "ph1",
        ")",
        "X",
        "$.",
        "proof-rule-prefixpoint",
        "$a",
        "|-",
        "(",
        "\\imp",
        "ph0",
        "(",
        "\\mu",
        "X",
        "ph1",
        ")",
        ")",
        "$.",
        "$}",
        "${",
        "proof-rule-kt.0",
        "$e",
        "#Substitution",
        "ph0",
        "ph1",
        "ph2",
        "X",
        "$.",
        "proof-rule-kt.1",
        "$e",
        "|-",
        "(",
        "\\imp",
        "ph0",
        "ph2",
        ")",
        "$.",
        "proof-rule-kt",
        "$a",
        "|-",
        "(",
        "\\imp",
        "(",
        "\\mu",
        "X",
        "ph1",
        ")",
        "ph2",
        ")",
        "$.",
        "$}",
        "${",
        "proof-rule-set-var-substitution.0",
        "$e",
        "#Substitution",
        "ph0",
        "ph1",
        "ph2",
        "X",
        "$.",
        "proof-rule-set-var-substitution.1",
        "$e",
        "|-",
        "ph1",
        "$.",
        "proof-rule-set-var-substitution",
        "$a",
        "|-",
        "ph0",
        "$.",
        "$}",
        "proof-rule-existence",
        "$a",
        "|-",
        "(",
        "\\exists",
        "x",
        "x",
        ")",
        "$.",
        "${",
        "proof-rule-singleton.0",
        "$e",
        "#ApplicationContext",
        "xX",
        "ph0",
        "$.",
        "proof-rule-singleton.1",
        "$e",
        "#ApplicationContext",
        "yY",
        "ph1",
        "$.",
        "proof-rule-singleton.2",
        "$e",
        "#Substitution",
        "ph3",
        "ph0",
        "(",
        "\\and",
        "x",
        "ph2",
        ")",
        "xX",
        "$.",
        "proof-rule-singleton.3",
        "$e",
        "#Substitution",
        "ph4",
        "ph1",
        "(",
        "\\and",
        "x",
        "(",
        "\\not",
        "ph2",
        ")",
        ")",
        "yY",
        "$.",
        "proof-rule-singleton",
        "$a",
        "|-",
        "(",
        "\\not",
        "(",
        "\\and",
        "ph3",
        "ph4",
        ")",
        ")",
        "$.",
        "$}"};

std::vector<std::string> tokens_vector_peano = {"$c",
                                                "|-",
                                                "wff",
                                                "term",
                                                "var",
                                                "$.",
                                                "$v",
                                                "s",
                                                "t",
                                                "u",
                                                "s0",
                                                "s1",
                                                "t0",
                                                "t1",
                                                "$.",
                                                "ts",
                                                "$f",
                                                "term",
                                                "s",
                                                "$.",
                                                "tt",
                                                "$f",
                                                "term",
                                                "t",
                                                "$.",
                                                "tu",
                                                "$f",
                                                "term",
                                                "u",
                                                "$.",
                                                "ts0",
                                                "$f",
                                                "term",
                                                "s0",
                                                "$.",
                                                "ts1",
                                                "$f",
                                                "term",
                                                "s1",
                                                "$.",
                                                "tt0",
                                                "$f",
                                                "term",
                                                "t0",
                                                "$.",
                                                "tt1",
                                                "$f",
                                                "term",
                                                "t1",
                                                "$.",
                                                "$v",
                                                "v",
                                                "x",
                                                "y",
                                                "z",
                                                "$.",
                                                "varv",
                                                "$f",
                                                "var",
                                                "v",
                                                "$.",
                                                "varx",
                                                "$f",
                                                "var",
                                                "x",
                                                "$.",
                                                "vary",
                                                "$f",
                                                "var",
                                                "y",
                                                "$.",
                                                "varz",
                                                "$f",
                                                "var",
                                                "z",
                                                "$.",
                                                "$c",
                                                "0",
                                                "S",
                                                "+",
                                                "*",
                                                "$.",
                                                "$c",
                                                "BINOP",
                                                "$.",
                                                "$v",
                                                "binop",
                                                "$.",
                                                "binop_",
                                                "$f",
                                                "BINOP",
                                                "binop",
                                                "$.",
                                                "binop_plus",
                                                "$a",
                                                "BINOP",
                                                "+",
                                                "$.",
                                                "binop_times",
                                                "$a",
                                                "BINOP",
                                                "*",
                                                "$.",
                                                "tvar",
                                                "$a",
                                                "term",
                                                "v",
                                                "$.",
                                                "tzero",
                                                "$a",
                                                "term",
                                                "0",
                                                "$.",
                                                "tsucc",
                                                "$a",
                                                "term",
                                                "S",
                                                "s",
                                                "$.",
                                                "tbinop",
                                                "$a",
                                                "term",
                                                "binop",
                                                "s",
                                                "t",
                                                "$.",
                                                "$c",
                                                "not",
                                                "or",
                                                "and",
                                                "implies",
                                                "iff",
                                                "$.",
                                                "$c",
                                                "LOGBINOP",
                                                "$.",
                                                "$v",
                                                "logbinop",
                                                "$.",
                                                "logbinop_",
                                                "$f",
                                                "LOGBINOP",
                                                "logbinop",
                                                "$.",
                                                "logbinopor",
                                                "$a",
                                                "LOGBINOP",
                                                "or",
                                                "$.",
                                                "logbinopand",
                                                "$a",
                                                "LOGBINOP",
                                                "and",
                                                "$.",
                                                "logbinopimplies",
                                                "$a",
                                                "LOGBINOP",
                                                "implies",
                                                "$.",
                                                "logbinopiff",
                                                "$a",
                                                "LOGBINOP",
                                                "iff",
                                                "$.",
                                                "$c",
                                                "=",
                                                "<",
                                                "$.",
                                                "$c",
                                                "BINPRED",
                                                "$.",
                                                "$v",
                                                "binpred",
                                                "$.",
                                                "binpred_",
                                                "$f",
                                                "BINPRED",
                                                "binpred",
                                                "$.",
                                                "binpred_equals",
                                                "$a",
                                                "BINPRED",
                                                "=",
                                                "$.",
                                                "binpred_less_than",
                                                "$a",
                                                "BINPRED",
                                                "<",
                                                "$.",
                                                "$c",
                                                "forall",
                                                "exists",
                                                "$.",
                                                "$c",
                                                "QUANT",
                                                "$.",
                                                "$v",
                                                "quant",
                                                "$.",
                                                "quant_",
                                                "$f",
                                                "QUANT",
                                                "quant",
                                                "$.",
                                                "quant_all",
                                                "$a",
                                                "QUANT",
                                                "forall",
                                                "$.",
                                                "quant_ex",
                                                "$a",
                                                "QUANT",
                                                "exists",
                                                "$.",
                                                "$v",
                                                "phi",
                                                "psi",
                                                "chi",
                                                "$.",
                                                "wff_phi",
                                                "$f",
                                                "wff",
                                                "phi",
                                                "$.",
                                                "wff_psi",
                                                "$f",
                                                "wff",
                                                "psi",
                                                "$.",
                                                "wff-chi",
                                                "$f",
                                                "wff",
                                                "chi",
                                                "$.",
                                                "wff_atom",
                                                "$a",
                                                "wff",
                                                "binpred",
                                                "s",
                                                "t",
                                                "$.",
                                                "wff_not",
                                                "$a",
                                                "wff",
                                                "not",
                                                "psi",
                                                "$.",
                                                "wff_logbinop",
                                                "$a",
                                                "wff",
                                                "logbinop",
                                                "psi",
                                                "phi",
                                                "$.",
                                                "wff_quant",
                                                "$a",
                                                "wff",
                                                "quant",
                                                "v",
                                                "phi",
                                                "$.",
                                                "ax-1",
                                                "$a",
                                                "|-",
                                                "implies",
                                                "phi",
                                                "implies",
                                                "psi",
                                                "phi",
                                                "$.",
                                                "ax-2",
                                                "$a",
                                                "|-",
                                                "implies",
                                                "implies",
                                                "phi",
                                                "implies",
                                                "psi",
                                                "chi",
                                                "implies",
                                                "implies",
                                                "phi",
                                                "psi",
                                                "implies",
                                                "phi",
                                                "chi",
                                                "$.",
                                                "ax-3",
                                                "$a",
                                                "|-",
                                                "implies",
                                                "implies",
                                                "not",
                                                "phi",
                                                "not",
                                                "psi",
                                                "implies",
                                                "psi",
                                                "phi",
                                                "$.",
                                                "${",
                                                "min",
                                                "$e",
                                                "|-",
                                                "phi",
                                                "$.",
                                                "maj",
                                                "$e",
                                                "|-",
                                                "implies",
                                                "phi",
                                                "psi",
                                                "$.",
                                                "ax-mp",
                                                "$a",
                                                "|-",
                                                "psi",
                                                "$.",
                                                "$}",
                                                "bi1",
                                                "$a",
                                                "|-",
                                                "implies",
                                                "iff",
                                                "phi",
                                                "psi",
                                                "implies",
                                                "phi",
                                                "psi",
                                                "$.",
                                                "bi2",
                                                "$a",
                                                "|-",
                                                "implies",
                                                "iff",
                                                "phi",
                                                "psi",
                                                "implies",
                                                "psi",
                                                "phi",
                                                "$.",
                                                "bi3",
                                                "$a",
                                                "|-",
                                                "implies",
                                                "implies",
                                                "phi",
                                                "psi",
                                                "implies",
                                                "implies",
                                                "psi",
                                                "phi",
                                                "iff",
                                                "phi",
                                                "psi",
                                                "$.",
                                                "df-an",
                                                "$a",
                                                "|-",
                                                "iff",
                                                "and",
                                                "phi",
                                                "psi",
                                                "not",
                                                "implies",
                                                "phi",
                                                "not",
                                                "psi",
                                                "$.",
                                                "df-or",
                                                "$a",
                                                "|-",
                                                "iff",
                                                "or",
                                                "phi",
                                                "psi",
                                                "implies",
                                                "not",
                                                "phi",
                                                "psi",
                                                "$.",
                                                "eq-refl",
                                                "$a",
                                                "|-",
                                                "=",
                                                "t",
                                                "t",
                                                "$.",
                                                "eq-sym",
                                                "$a",
                                                "|-",
                                                "implies",
                                                "=",
                                                "s",
                                                "t",
                                                "=",
                                                "t",
                                                "s",
                                                "$.",
                                                "eq-trans",
                                                "$a",
                                                "|-",
                                                "implies",
                                                "and",
                                                "=",
                                                "s",
                                                "t",
                                                "=",
                                                "t",
                                                "u",
                                                "=",
                                                "s",
                                                "u",
                                                "$.",
                                                "eq-congr",
                                                "$a",
                                                "|-",
                                                "implies",
                                                "and",
                                                "=",
                                                "s0",
                                                "s1",
                                                "=",
                                                "t0",
                                                "t1",
                                                "iff",
                                                "binpred",
                                                "s0",
                                                "t0",
                                                "binpred",
                                                "s1",
                                                "t1",
                                                "$.",
                                                "eq-suc",
                                                "$a",
                                                "|-",
                                                "implies",
                                                "=",
                                                "s",
                                                "t",
                                                "=",
                                                "S",
                                                "s",
                                                "S",
                                                "t",
                                                "$.",
                                                "eq-binop",
                                                "$a",
                                                "|-",
                                                "implies",
                                                "and",
                                                "=",
                                                "s0",
                                                "s1",
                                                "=",
                                                "t0",
                                                "t1",
                                                "=",
                                                "binop",
                                                "s0",
                                                "t0",
                                                "binop",
                                                "s1",
                                                "t1",
                                                "$.",
                                                "${",
                                                "$d",
                                                "phi",
                                                "x",
                                                "$.",
                                                "alpha_hyp1",
                                                "$e",
                                                "|-",
                                                "implies",
                                                "phi",
                                                "iff",
                                                "psi",
                                                "chi",
                                                "$.",
                                                "alpha_1",
                                                "$a",
                                                "|-",
                                                "implies",
                                                "phi",
                                                "iff",
                                                "quant",
                                                "x",
                                                "psi",
                                                "quant",
                                                "x",
                                                "chi",
                                                "$.",
                                                "$}",
                                                "${",
                                                "$d",
                                                "phi",
                                                "x",
                                                "$.",
                                                "alpha_hyp2",
                                                "$e",
                                                "|-",
                                                "implies",
                                                "phi",
                                                "chi",
                                                "$.",
                                                "alpha_2",
                                                "$a",
                                                "|-",
                                                "implies",
                                                "phi",
                                                "forall",
                                                "x",
                                                "chi",
                                                "$.",
                                                "$}",
                                                "${",
                                                "$d",
                                                "phi",
                                                "y",
                                                "$.",
                                                "$d",
                                                "psi",
                                                "x",
                                                "$.",
                                                "$d",
                                                "x",
                                                "y",
                                                "$.",
                                                "alpha_3",
                                                "$a",
                                                "|-",
                                                "implies",
                                                "forall",
                                                "x",
                                                "forall",
                                                "y",
                                                "implies",
                                                "=",
                                                "x",
                                                "y",
                                                "iff",
                                                "phi",
                                                "psi",
                                                "iff",
                                                "quant",
                                                "x",
                                                "phi",
                                                "quant",
                                                "y",
                                                "psi",
                                                "$.",
                                                "$}",
                                                "${",
                                                "$d",
                                                "x",
                                                "t",
                                                "$.",
                                                "all_elim",
                                                "$a",
                                                "|-",
                                                "implies",
                                                "forall",
                                                "x",
                                                "phi",
                                                "forall",
                                                "x",
                                                "implies",
                                                "=",
                                                "x",
                                                "t",
                                                "phi",
                                                "$.",
                                                "$}",
                                                "${",
                                                "$d",
                                                "x",
                                                "y",
                                                "$.",
                                                "$d",
                                                "y",
                                                "t",
                                                "$.",
                                                "all_elim_hyp2",
                                                "$e",
                                                "|-",
                                                "implies",
                                                "=",
                                                "x",
                                                "t",
                                                "iff",
                                                "phi",
                                                "chi",
                                                "$.",
                                                "all_elim2",
                                                "$a",
                                                "|-",
                                                "implies",
                                                "=",
                                                "x",
                                                "t",
                                                "iff",
                                                "quant",
                                                "y",
                                                "phi",
                                                "quant",
                                                "y",
                                                "chi",
                                                "$.",
                                                "$}",
                                                "${",
                                                "$d",
                                                "x",
                                                "chi",
                                                "$.",
                                                "$d",
                                                "x",
                                                "t",
                                                "$.",
                                                "all_elim3_hyp1",
                                                "$e",
                                                "|-",
                                                "implies",
                                                "=",
                                                "x",
                                                "t",
                                                "iff",
                                                "phi",
                                                "chi",
                                                "$.",
                                                "all_elim3",
                                                "$a",
                                                "|-",
                                                "implies",
                                                "forall",
                                                "x",
                                                "implies",
                                                "=",
                                                "x",
                                                "t",
                                                "phi",
                                                "chi",
                                                "$.",
                                                "$}",
                                                "exists_def",
                                                "$a",
                                                "|-",
                                                "iff",
                                                "exists",
                                                "x",
                                                "phi",
                                                "not",
                                                "forall",
                                                "x",
                                                "not",
                                                "phi",
                                                "$.",
                                                "pa_ax1",
                                                "$a",
                                                "|-",
                                                "not",
                                                "=",
                                                "0",
                                                "S",
                                                "x",
                                                "$.",
                                                "pa_ax2",
                                                "$a",
                                                "|-",
                                                "implies",
                                                "=",
                                                "S",
                                                "x",
                                                "S",
                                                "y",
                                                "=",
                                                "x",
                                                "y",
                                                "$.",
                                                "pa_ax3",
                                                "$a",
                                                "|-",
                                                "=",
                                                "x",
                                                "+",
                                                "x",
                                                "0",
                                                "$.",
                                                "pa_ax4",
                                                "$a",
                                                "|-",
                                                "=",
                                                "S",
                                                "+",
                                                "x",
                                                "y",
                                                "+",
                                                "x",
                                                "S",
                                                "y",
                                                "$.",
                                                "pa_ax5",
                                                "$a",
                                                "|-",
                                                "=",
                                                "0",
                                                "*",
                                                "x",
                                                "0",
                                                "$.",
                                                "pa_ax6",
                                                "$a",
                                                "|-",
                                                "=",
                                                "+",
                                                "*",
                                                "x",
                                                "y",
                                                "x",
                                                "*",
                                                "x",
                                                "S",
                                                "y",
                                                "$.",
                                                "${",
                                                "$d",
                                                "z",
                                                "x",
                                                "$.",
                                                "$d",
                                                "z",
                                                "y",
                                                "$.",
                                                "pa_ax7",
                                                "$a",
                                                "|-",
                                                "iff",
                                                "<",
                                                "x",
                                                "y",
                                                "exists",
                                                "z",
                                                "=",
                                                "y",
                                                "+",
                                                "x",
                                                "S",
                                                "z",
                                                "$.",
                                                "$}",
                                                "${",
                                                "$d",
                                                "phi",
                                                "x",
                                                "$.",
                                                "$d",
                                                "x",
                                                "y",
                                                "$.",
                                                "induction",
                                                "$a",
                                                "|-",
                                                "implies",
                                                "and",
                                                "forall",
                                                "y",
                                                "implies",
                                                "=",
                                                "y",
                                                "0",
                                                "phi",
                                                "forall",
                                                "x",
                                                "implies",
                                                "forall",
                                                "y",
                                                "implies",
                                                "=",
                                                "y",
                                                "x",
                                                "phi",
                                                "forall",
                                                "y",
                                                "implies",
                                                "=",
                                                "y",
                                                "S",
                                                "x",
                                                "phi",
                                                "forall",
                                                "x",
                                                "forall",
                                                "y",
                                                "implies",
                                                "=",
                                                "y",
                                                "x",
                                                "phi",
                                                "$.",
                                                "$}"};

std::vector<std::string> tokens_vector_reflexivity = {"$c",
                                                      "#Pattern",
                                                      "$.",
                                                      "$c",
                                                      "|-",
                                                      "$.",
                                                      "$c",
                                                      "\\imp",
                                                      "$.",
                                                      "$c",
                                                      "(",
                                                      ")",
                                                      "$.",
                                                      "$v",
                                                      "ph0",
                                                      "ph1",
                                                      "ph2",
                                                      "$.",
                                                      "ph0-is-pattern",
                                                      "$f",
                                                      "#Pattern",
                                                      "ph0",
                                                      "$.",
                                                      "ph1-is-pattern",
                                                      "$f",
                                                      "#Pattern",
                                                      "ph1",
                                                      "$.",
                                                      "ph2-is-pattern",
                                                      "$f",
                                                      "#Pattern",
                                                      "ph2",
                                                      "$.",
                                                      "imp-is-pattern",
                                                      "$a",
                                                      "#Pattern",
                                                      "(",
                                                      "\\imp",
                                                      "ph0",
                                                      "ph1",
                                                      ")",
                                                      "$.",
                                                      "proof-rule-prop-1",
                                                      "$a",
                                                      "|-",
                                                      "(",
                                                      "\\imp",
                                                      "ph0",
                                                      "(",
                                                      "\\imp",
                                                      "ph1",
                                                      "ph0",
                                                      ")",
                                                      ")",
                                                      "$.",
                                                      "proof-rule-prop-2",
                                                      "$a",
                                                      "|-",
                                                      "(",
                                                      "\\imp",
                                                      "(",
                                                      "\\imp",
                                                      "ph0",
                                                      "(",
                                                      "\\imp",
                                                      "ph1",
                                                      "ph2",
                                                      ")",
                                                      ")",
                                                      "(",
                                                      "\\imp",
                                                      "(",
                                                      "\\imp",
                                                      "ph0",
                                                      "ph1",
                                                      ")",
                                                      "(",
                                                      "\\imp",
                                                      "ph0",
                                                      "ph2",
                                                      ")",
                                                      ")",
                                                      ")",
                                                      "$.",
                                                      "${",
                                                      "proof-rule-mp.0",
                                                      "$e",
                                                      "|-",
                                                      "(",
                                                      "\\imp",
                                                      "ph0",
                                                      "ph1",
                                                      ")",
                                                      "$.",
                                                      "proof-rule-mp.1",
                                                      "$e",
                                                      "|-",
                                                      "ph0",
                                                      "$.",
                                                      "proof-rule-mp",
                                                      "$a",
                                                      "|-",
                                                      "ph1",
                                                      "$.",
                                                      "$}",
                                                      "imp-reflexivity",
                                                      "$p",
                                                      "|-",
                                                      "(",
                                                      "\\imp",
                                                      "ph0",
                                                      "ph0",
                                                      ")",
                                                      "$=",
                                                      "ph0-is-pattern",
                                                      "ph0-is-pattern",
                                                      "ph0-is-pattern",
                                                      "imp-is-pattern",
                                                      "imp-is-pattern",
                                                      "ph0-is-pattern",
                                                      "ph0-is-pattern",
                                                      "imp-is-pattern",
                                                      "ph0-is-pattern",
                                                      "ph0-is-pattern",
                                                      "ph0-is-pattern",
                                                      "imp-is-pattern",
                                                      "ph0-is-pattern",
                                                      "imp-is-pattern",
                                                      "imp-is-pattern",
                                                      "ph0-is-pattern",
                                                      "ph0-is-pattern",
                                                      "ph0-is-pattern",
                                                      "imp-is-pattern",
                                                      "imp-is-pattern",
                                                      "ph0-is-pattern",
                                                      "ph0-is-pattern",
                                                      "imp-is-pattern",
                                                      "imp-is-pattern",
                                                      "ph0-is-pattern",
                                                      "ph0-is-pattern",
                                                      "ph0-is-pattern",
                                                      "imp-is-pattern",
                                                      "ph0-is-pattern",
                                                      "proof-rule-prop-2",
                                                      "ph0-is-pattern",
                                                      "ph0-is-pattern",
                                                      "ph0-is-pattern",
                                                      "imp-is-pattern",
                                                      "proof-rule-prop-1",
                                                      "proof-rule-mp",
                                                      "ph0-is-pattern",
                                                      "ph0-is-pattern",
                                                      "proof-rule-prop-1",
                                                      "proof-rule-mp",
                                                      "$."};

std::vector<std::string> tokens_vector_simple = {
        "$c",   "0",  "+",   "=",   "->",  "(",    ")",   "term", "wff", "|-",
        "$.",   "$v", "t",   "r",   "s",   "P",    "Q",   "$.",   "tt",  "$f",
        "term", "t",  "$.",  "tr",  "$f",  "term", "r",   "$.",   "ts",  "$f",
        "term", "s",  "$.",  "wp",  "$f",  "wff",  "P",   "$.",   "wq",  "$f",
        "wff",  "Q",  "$.",  "tze", "$a",  "term", "0",   "$.",   "tpl", "$a",
        "term", "(",  "t",   "+",   "r",   ")",    "$.",  "weq",  "$a",  "wff",
        "t",    "=",  "r",   "$.",  "wim", "$a",   "wff", "(",    "P",   "->",
        "Q",    ")",  "$.",  "a1",  "$a",  "|-",   "(",   "t",    "=",   "r",
        "->",   "(",  "t",   "=",   "s",   "->",   "r",   "=",    "s",   ")",
        ")",    "$.", "a2",  "$a",  "|-",  "(",    "t",   "+",    "0",   ")",
        "=",    "t",  "$.",  "${",  "min", "$e",   "|-",  "P",    "$.",  "maj",
        "$e",   "|-", "(",   "P",   "->",  "Q",    ")",   "$.",   "mp",  "$a",
        "|-",   "Q",  "$.",  "$}",  "th1", "$p",   "|-",  "t",    "=",   "t",
        "$=",   "tt", "tze", "tpl", "tt",  "weq",  "tt",  "tt",   "weq", "tt",
        "a2",   "tt", "tze", "tpl", "tt",  "weq",  "tt",  "tze",  "tpl", "tt",
        "weq",  "tt", "tt",  "weq", "wim", "tt",   "a2",  "tt",   "tze", "tpl",
        "tt",   "tt", "a1",  "mp",  "mp",  "$."};

std::vector<std::size_t> tokens_vector_wff_mapped = {
    8,  18, 26,  34,  46, 48, 56, 70,  78,  86,  94,  48,  102, 104, 46,
    70, 48, 118, 104, 46, 78, 48, 126, 104, 46,  86,  48,  134, 104, 46,
    94, 48, 142, 144, 46, 18, 70, 34,  78,  26,  48,  158, 160, 46,  18,
    94, 34, 18,  86,  34, 70, 26, 26,  168, 134, 126, 102, 142, 142, 48};

std::queue<std::size_t> tokens;

std::set<std::size_t> constants;

typedef std::vector<std::size_t> Expression;

// The first parameter is the statement of the hypothesis, the second is
// true iff the hypothesis is floating.
typedef std::pair<Expression, bool> Hypothesis;

std::map<std::size_t, Hypothesis> hypotheses;

std::set<std::size_t> variables;

// An axiom or a theorem.
struct Assertion {
  // Hypotheses of this axiom or theorem.
  std::deque<std::size_t> hypotheses;
  std::set<std::pair<std::size_t, std::size_t>> disjvars;
  // Statement of axiom or theorem.
  Expression expression;
};

std::map<std::size_t, Assertion> assertions;

struct Scope {
  std::set<std::size_t> activevariables;
  // Labels of active hypotheses
  std::vector<std::size_t> activehyp;
  std::vector<std::set<std::size_t>> disjvars;
  // Map from variable to label of active floating hypothesis
  std::map<std::size_t, std::size_t> floatinghyp;
};

std::vector<Scope> scopes;

// Determine if a size_t is used as a label
inline bool labelused(std::size_t const label) {
  return hypotheses.find(label) != hypotheses.end() ||
         assertions.find(label) != assertions.end();
}

// Find active floating hypothesis corresponding to variable, or empty size_t
// if there isn't one.
std::size_t getfloatinghyp(std::size_t const var) {
  for (std::vector<Scope>::const_iterator iter(scopes.begin());
       iter != scopes.end(); ++iter) {
    std::map<std::size_t, std::size_t>::const_iterator const loc(
        iter->floatinghyp.find(var));
    if (loc != iter->floatinghyp.end())
      return loc->second;
  }

  return MAX_INT;
}

// Determine if a size_t is an active variable.
bool isactivevariable(std::size_t const str) {
  for (std::vector<Scope>::const_iterator iter(scopes.begin());
       iter != scopes.end(); ++iter) {
    if (iter->activevariables.find(str) != iter->activevariables.end())
      return true;
  }
  return false;
}

// Determine if a size_t is the label of an active hypothesis.
bool isactivehyp(std::size_t const str) {
  for (std::vector<Scope>::const_iterator iter(scopes.begin());
       iter != scopes.end(); ++iter) {
    if (std::find(iter->activehyp.begin(), iter->activehyp.end(), str) !=
        iter->activehyp.end())
      return true;
  }
  return false;
}

// Determine if there is an active disjoint variable restriction on
// two different variables.
bool isdvr(std::size_t var1, std::size_t var2) {
  if (var1 == var2)
    return false;
  for (std::vector<Scope>::const_iterator iter(scopes.begin());
       iter != scopes.end(); ++iter) {
    for (std::vector<std::set<std::size_t>>::const_iterator iter2(
             iter->disjvars.begin());
         iter2 != iter->disjvars.end(); ++iter2) {
      if (iter2->find(var1) != iter2->end() &&
          iter2->find(var2) != iter2->end())
        return true;
    }
  }
  return false;
}

// Determine if a character is white space in Metamath.
inline bool ismmws(char const ch) {
  // This doesn't include \v ("vertical tab"), as the spec omits it.
  return ch == ' ' || ch == '\n' || ch == '\t' || ch == '\f' || ch == '\r';
}

// Determine if a token is a label token.
bool islabeltoken(std::size_t const token) { return token & 1; }

// Determine if a token is a math symbol token.
inline bool ismathsymboltoken(std::size_t const token) { return token & 2; }

// Determine if a token consists solely of upper-case letters or question marks
bool containsonlyupperorq(std::size_t token) { return token & 4; }

// Construct an Assertion from an Expression. That is, determine the
// mandatory hypotheses and disjoint variable restrictions.
// The Assertion is inserted into the assertions collection,
// and is returned by reference.
Assertion &constructassertion(std::size_t const label, Expression const &exp) {
  Assertion &assertion(
      assertions.insert(std::make_pair(label, Assertion())).first->second);

  assertion.expression = exp;

  std::set<std::size_t> varsused;

  // Determine variables used and find mandatory hypotheses

  for (Expression::const_iterator iter(exp.begin()); iter != exp.end();
       ++iter) {
    if (variables.find(*iter) != variables.end())
      varsused.insert(*iter);
  }

  for (std::vector<Scope>::const_reverse_iterator iter(scopes.rbegin());
       iter != scopes.rend(); ++iter) {
    std::vector<std::size_t> const &hypvec(iter->activehyp);
    for (std::vector<std::size_t>::const_reverse_iterator iter2(
             hypvec.rbegin());
         iter2 != hypvec.rend(); ++iter2) {
      Hypothesis const &hyp(hypotheses.find(*iter2)->second);
      if (hyp.second && varsused.find(hyp.first[1]) != varsused.end()) {
        // Mandatory floating hypothesis
        assertion.hypotheses.push_front(*iter2);
      } else if (!hyp.second) {
        // Essential hypothesis
        assertion.hypotheses.push_front(*iter2);
        for (Expression::const_iterator iter3(hyp.first.begin());
             iter3 != hyp.first.end(); ++iter3) {
          if (variables.find(*iter3) != variables.end())
            varsused.insert(*iter3);
        }
      }
    }
  }

  // Determine mandatory disjoint variable restrictions
  for (std::vector<Scope>::const_iterator iter(scopes.begin());
       iter != scopes.end(); ++iter) {
    std::vector<std::set<std::size_t>> const &disjvars(iter->disjvars);
    for (std::vector<std::set<std::size_t>>::const_iterator iter2(
             disjvars.begin());
         iter2 != disjvars.end(); ++iter2) {
      std::set<std::size_t> dset;
      std::set_intersection(iter2->begin(), iter2->end(), varsused.begin(),
                            varsused.end(), std::inserter(dset, dset.end()));

      for (std::set<std::size_t>::const_iterator diter(dset.begin());
           diter != dset.end(); ++diter) {
        std::set<std::size_t>::const_iterator diter2(diter);
        ++diter2;
        for (; diter2 != dset.end(); ++diter2)
          assertion.disjvars.insert(std::make_pair(*diter, *diter2));
      }
    }
  }

  return assertion;
}

// Read an expression from the token stream. Returns true iff okay.
bool readexpression(char stattype, std::size_t label, std::size_t terminator,
                    Expression *exp) {
  if (tokens.empty()) {
    std::cerr << "Unfinished $" << stattype << " statement " << label
              << std::endl;
    return false;
  }

  std::size_t type = tokens.front();

  if (constants.find(type) == constants.end()) {
    std::cerr << "First symbol in $" << stattype << " statement " << label
              << " is " << type << " which is not a constant" << std::endl;
    return false;
  }

  tokens.pop();

  exp->push_back(type);

  std::size_t token;

  while (!tokens.empty() && (token = tokens.front()) != terminator) {
    tokens.pop();

    if (constants.find(token) == constants.end() &&
        (getfloatinghyp(token) == INT_MAX)) {
      std::cerr << "In $" << stattype << " statement " << label << " token "
                << token
                << " found which is not a constant or variable in an"
                   " active $f statement"
                << std::endl;
      return false;
    }

    exp->push_back(token);
  }

  if (tokens.empty()) {
    std::cerr << "Unfinished $" << stattype << " statement " << label
              << std::endl;
    return false;
  }

  tokens.pop(); // Discard terminator token

  return true;
}

// Make a substitution of variables. The result is put in "destination",
// which should be empty.
void makesubstitution(Expression const &original,
                      std::map<std::size_t, Expression> substmap,
                      Expression *destination) {
  for (Expression::const_iterator iter(original.begin());
       iter != original.end(); ++iter) {
    std::map<std::size_t, Expression>::const_iterator const iter2(
        substmap.find(*iter));
    if (iter2 == substmap.end()) {
      // Constant
      destination->push_back(*iter);
    } else {
      // Variable
      std::copy(iter2->second.begin(), iter2->second.end(),
                std::back_inserter(*destination));
    }
  }
}

// Get the raw numbers from compressed proof format.
// The letter Z is translated as 0.
bool getproofnumbers(std::size_t label, std::vector<std::size_t> proof,
                     std::vector<std::size_t> *proofnumbers) {
  std::size_t const size_max(std::numeric_limits<std::size_t>::max());

  std::size_t num(0u);
  bool justgotnum(false);
  for (auto iter = proof.begin(); iter != proof.end(); ++iter) {
    if (*iter <= 84) {                            // 'T'
      std::size_t const addval(*iter - (65 - 1)); // 'A'

      if (num > size_max / 20 || 20 * num > size_max - addval) {
        std::cerr << "Overflow computing numbers in compressed proof "
                     "of "
                  << label << std::endl;
        return false;
      }

      proofnumbers->push_back(20 * num + addval);
      num = 0;
      justgotnum = true;
    } else if (*iter <= 84) {               // 'Y'
      std::size_t const addval(*iter - 84); // 'T'

      if (num > size_max / 5 || 5 * num > size_max - addval) {
        std::cerr << "Overflow computing numbers in compressed proof "
                     "of "
                  << label << std::endl;
        return false;
      }

      num = 5 * num + addval;
      justgotnum = false;
    } else { // It must be Z
      if (!justgotnum) {
        std::cerr << "Stray Z found in compressed proof of " << label
                  << std::endl;
        return false;
      }

      proofnumbers->push_back(0);
      justgotnum = false;
    }
  }

  if (num != 0) {
    std::cerr << "Compressed proof of theorem " << label
              << " ends in unfinished number" << std::endl;
    return false;
  }

  return true;
}

// Subroutine for proof verification. Verify a proof step referencing an
// assertion (i.e., not a hypothesis).
bool verifyassertionref(std::size_t thlabel, std::size_t reflabel,
                        std::vector<Expression> *stack) {
  Assertion const &assertion(assertions.find(reflabel)->second);
  if (stack->size() < assertion.hypotheses.size()) {
    std::cerr << "In proof of theorem " << thlabel
              << " not enough items found on stack" << std::endl;
    return false;
  }

  std::vector<Expression>::size_type const base(stack->size() -
                                                assertion.hypotheses.size());

  std::map<std::size_t, Expression> substitutions;

  // Determine substitutions and check that we can unify
  for (std::deque<std::size_t>::size_type i(0); i < assertion.hypotheses.size();
       ++i) {
    Hypothesis const &hypothesis(
        hypotheses.find(assertion.hypotheses[i])->second);
    if (hypothesis.second) {
      // Floating hypothesis of the referenced assertion
      if (hypothesis.first[0] != (*stack)[base + i][0]) {
        std::cout << "In proof of theorem " << thlabel << " unification failed"
                  << std::endl;
        return false;
      }
      Expression &subst(
          substitutions
              .insert(std::make_pair(hypothesis.first[1], Expression()))
              .first->second);
      std::copy((*stack)[base + i].begin() + 1, (*stack)[base + i].end(),
                std::back_inserter(subst));
    } else {
      // Essential hypothesis
      Expression dest;
      makesubstitution(hypothesis.first, substitutions, &dest);
      if (dest != (*stack)[base + i]) {
        std::cerr << "In proof of theorem " << thlabel << " unification failed"
                  << std::endl;
        return false;
      }
    }
  }

  // Remove hypotheses from stack
  stack->erase(stack->begin() + base, stack->end());

  // Verify disjoint variable conditions
  for (std::set<std::pair<std::size_t, std::size_t>>::const_iterator iter(
           assertion.disjvars.begin());
       iter != assertion.disjvars.end(); ++iter) {
    Expression const &exp1(substitutions.find(iter->first)->second);
    Expression const &exp2(substitutions.find(iter->second)->second);

    std::set<std::size_t> exp1vars;
    for (Expression::const_iterator exp1iter(exp1.begin());
         exp1iter != exp1.end(); ++exp1iter) {
      if (variables.find(*exp1iter) != variables.end())
        exp1vars.insert(*exp1iter);
    }

    std::set<std::size_t> exp2vars;
    for (Expression::const_iterator exp2iter(exp2.begin());
         exp2iter != exp2.end(); ++exp2iter) {
      if (variables.find(*exp2iter) != variables.end())
        exp2vars.insert(*exp2iter);
    }

    for (std::set<std::size_t>::const_iterator exp1iter(exp1vars.begin());
         exp1iter != exp1vars.end(); ++exp1iter) {
      for (std::set<std::size_t>::const_iterator exp2iter(exp2vars.begin());
           exp2iter != exp2vars.end(); ++exp2iter) {
        if (!isdvr(*exp1iter, *exp2iter)) {
          std::cerr << "In proof of theorem " << thlabel
                    << " disjoint variable restriction violated" << std::endl;
          return false;
        }
      }
    }
  }

  // Done verification of this step. Insert new statement onto stack.
  Expression dest;
  makesubstitution(assertion.expression, substitutions, &dest);
  stack->push_back(dest);

  return true;
}

// Verify a regular proof. The "proof" argument should be a non-empty sequence
// of valid labels. Return true iff the proof is correct.
bool verifyregularproof(std::size_t label, Assertion const &theorem,
                        std::vector<std::size_t> const &proof) {
  std::vector<Expression> stack;
  for (std::vector<std::size_t>::const_iterator proofstep(proof.begin());
       proofstep != proof.end(); ++proofstep) {
    // If step is a hypothesis, just push it onto the stack.
    std::map<std::size_t, Hypothesis>::const_iterator hyp(
        hypotheses.find(*proofstep));
    if (hyp != hypotheses.end()) {
      stack.push_back(hyp->second.first);
      continue;
    }

    // It must be an axiom or theorem
    bool const okay(verifyassertionref(label, *proofstep, &stack));
    if (!okay)
      return false;
  }

  if (stack.size() != 1) {
    std::cerr << "Proof of theorem " << label
              << " does not end with only one item on the stack" << std::endl;
    return false;
  }

  if (stack[0] != theorem.expression) {
    std::cerr << "Proof of theorem " << label << " proves wrong statement"
              << std::endl;
  }

  return true;
}

// Verify a compressed proof
bool verifycompressedproof(std::size_t label, Assertion const &theorem,
                           std::vector<std::size_t> const &labels,
                           std::vector<std::size_t> const &proofnumbers) {
  std::vector<Expression> stack;

  std::size_t const mandhypt(theorem.hypotheses.size());
  std::size_t const labelt(mandhypt + labels.size());

  std::vector<Expression> savedsteps;
  for (std::vector<std::size_t>::const_iterator iter(proofnumbers.begin());
       iter != proofnumbers.end(); ++iter) {
    // Save the last proof step if 0
    if (*iter == 0) {
      savedsteps.push_back(stack.back());
      continue;
    }

    // If step is a mandatory hypothesis, just push it onto the stack.
    if (*iter <= mandhypt) {
      stack.push_back(
          hypotheses.find(theorem.hypotheses[*iter - 1])->second.first);
    } else if (*iter <= labelt) {
      std::size_t const proofstep(labels[*iter - mandhypt - 1]);

      // If step is a (non-mandatory) hypothesis,
      // just push it onto the stack.
      std::map<std::size_t, Hypothesis>::const_iterator hyp(
          hypotheses.find(proofstep));
      if (hyp != hypotheses.end()) {
        stack.push_back(hyp->second.first);
        continue;
      }

      // It must be an axiom or theorem
      bool const okay(verifyassertionref(label, proofstep, &stack));
      if (!okay)
        return false;
    } else // Must refer to saved step
    {
      if (*iter > labelt + savedsteps.size()) {
        std::cerr << "Number in compressed proof of " << label << " is too high"
                  << std::endl;
        return false;
      }

      stack.push_back(savedsteps[*iter - labelt - 1]);
    }
  }

  if (stack.size() != 1) {
    std::cerr << "Proof of theorem " << label
              << " does not end with only one item on the stack" << std::endl;
    return false;
  }

  if (stack[0] != theorem.expression) {
    std::cerr << "Proof of theorem " << label << " proves wrong statement"
              << std::endl;
  }

  return true;
}

// Parse $p statement. Return true iff okay.
bool parsep(std::size_t label) {
  Expression newtheorem;
  bool const okay(readexpression('p', label, 4, &newtheorem)); // $=
  if (!okay) {
    return false;
  }

  Assertion const &assertion(constructassertion(label, newtheorem));

  // Now for the proof

  if (tokens.empty()) {
    std::cerr << "Unfinished $p statement " << label << std::endl;
    return false;
  }

  if (tokens.front() == 11) { // (
    // Compressed proof
    tokens.pop();

    // Get labels

    std::vector<std::size_t> labels;
    std::size_t token;
    while (!tokens.empty() && (token = tokens.front()) != 12) { // )
      tokens.pop();
      labels.push_back(token);
      if (token == label) {
        std::cerr << "Proof of theorem " << label << " refers to itself"
                  << std::endl;
        return false;
      } else if (std::find(assertion.hypotheses.begin(),
                           assertion.hypotheses.end(),
                           token) != assertion.hypotheses.end()) {
        std::cerr << "Compressed proof of theorem " << label
                  << " has mandatory hypothesis " << token << " in label list"
                  << std::endl;
        return false;
      } else if (assertions.find(token) == assertions.end() &&
                 !isactivehyp(token)) {
        std::cerr << "Proof of theorem " << label << " refers to " << token
                  << " which is not an active statement" << std::endl;
        return false;
      }
    }

    if (tokens.empty()) {
      std::cerr << "Unfinished $p statement " << label << std::endl;
      return false;
    }

    tokens.pop(); // Discard ) token

    // Get proof steps

    std::vector<std::size_t> proof;
    while (!tokens.empty() && (token = tokens.front()) != 48) { // $.
      tokens.pop();

      proof.push_back(token);
      if (!containsonlyupperorq(token)) {
        std::cerr << "Bogus character found in compressed proof of " << label
                  << std::endl;
        return false;
      }
    }

    if (tokens.empty()) {
      std::cerr << "Unfinished $p statement " << label << std::endl;
      return false;
    }

    if (proof.empty()) {
      std::cerr << "Theorem " << label << " has no proof" << std::endl;
      return false;
    }

    tokens.pop(); // Discard $. token

    if (findToken(proof, 27) != proof.end()) { // ?
      std::cerr << "Warning: Proof of theorem " << label << " is incomplete"
                << std::endl;
      return true; // Continue processing file
    }

    std::vector<std::size_t> proofnumbers;
    proofnumbers.reserve(proof.size()); // Preallocate for efficiency
    bool okay(getproofnumbers(label, proof, &proofnumbers));
    if (!okay)
      return false;

    okay = verifycompressedproof(label, assertion, labels, proofnumbers);
    if (!okay)
      return false;
  } else {
    // Regular (uncompressed proof)
    std::vector<std::size_t> proof;
    bool incomplete(false);
    std::size_t token;
    while (!tokens.empty() && (token = tokens.front()) != 48) { // $.
      tokens.pop();
      proof.push_back(token);
      if (token == 27) // ?
        incomplete = true;
      else if (token == label) {
        std::cerr << "Proof of theorem " << label << " refers to itself"
                  << std::endl;
        return false;
      } else if (assertions.find(token) == assertions.end() &&
                 !isactivehyp(token)) {
        std::cerr << "Proof of theorem " << label << " refers to " << token
                  << " which is not an active statement" << std::endl;
        return false;
      }
    }

    if (tokens.empty()) {
      std::cerr << "Unfinished $p statement " << label << std::endl;
      return false;
    }

    if (proof.empty()) {
      std::cerr << "Theorem " << label << " has no proof" << std::endl;
      return false;
    }

    tokens.pop(); // Discard $. token

    if (incomplete) {
      std::cerr << "Warning: Proof of theorem " << label << " is incomplete"
                << std::endl;
      return true; // Continue processing file
    }

    bool okay(verifyregularproof(label, assertion, proof));
    if (!okay)
      return false;
  }

  return true;
}

// Parse $e statement. Return true iff okay.
bool parsee(std::size_t label) {
  Expression newhyp;
  bool const okay(readexpression('e', label, 48, &newhyp)); // $.
  if (!okay) {
    return false;
  }

  // Create new essential hypothesis
  hypotheses.insert(std::make_pair(label, std::make_pair(newhyp, false)));
  scopes.back().activehyp.push_back(label);

  return true;
}

// Parse $a statement. Return true iff okay.
bool parsea(std::size_t label) {
  Expression newaxiom;
  bool const okay(readexpression('a', label, 48, &newaxiom)); // $.
  if (!okay) {
    return false;
  }

  constructassertion(label, newaxiom);

  return true;
}

// Parse $f statement. Return true iff okay.
bool parsef(std::size_t label) {
  if (tokens.empty()) {
    std::cerr << "Unfinished $f statement" << label << std::endl;
    return false;
  }

  std::size_t type(tokens.front());

  if (constants.find(type) == constants.end()) {
    std::cerr << "First symbol in $f statement " << label << " is " << type
              << " which is not a constant" << std::endl;
    return false;
  }

  tokens.pop();

  if (tokens.empty()) {
    std::cerr << "Unfinished $f statement " << label << std::endl;
    return false;
  }

  std::size_t variable(tokens.front());
  if (!isactivevariable(variable)) {
    std::cerr << "Second symbol in $f statement " << label << " is " << variable
              << " which is not an active variable" << std::endl;
    return false;
  }
  if (getfloatinghyp(variable) != 0) {
    std::cerr << "The variable " << variable
              << " appears in a second $f statement " << label << std::endl;
    return false;
  }

  tokens.pop();

  if (tokens.empty()) {
    std::cerr << "Unfinished $f statement" << label << std::endl;
    return false;
  }

  if (tokens.front() != 48) { // $.
    std::cerr << "Expected end of $f statement " << label << " but found "
              << tokens.front() << std::endl;
    return false;
  }

  tokens.pop(); // Discard $. token

  // Create new floating hypothesis
  Expression newhyp;
  newhyp.push_back(type);
  newhyp.push_back(variable);
  hypotheses.insert(std::make_pair(label, std::make_pair(newhyp, true)));
  scopes.back().activehyp.push_back(label);
  scopes.back().floatinghyp.insert(std::make_pair(variable, label));

  return true;
}

// Parse labeled statement. Return true iff okay.
bool parselabel(std::size_t label) {
  if (constants.find(label) != constants.end()) {
    std::cerr << "Attempt to reuse constant " << label << " as a label"
              << std::endl;
    return false;
  }

  if (variables.find(label) != variables.end()) {
    std::cerr << "Attempt to reuse variable " << label << " as a label"
              << std::endl;
    return false;
  }

  if (labelused(label)) {
    std::cerr << "Attempt to reuse label " << label << std::endl;
    return false;
  }

  if (tokens.empty()) {
    std::cerr << "Unfinished labeled statement" << std::endl;
    return false;
  }

  std::size_t const type(tokens.front());
  tokens.pop();

  bool okay(true);
  if (type == 160) { // $p
    okay = parsep(label);
  } else if (type == 200) { // $e
    okay = parsee(label);
  } else if (type == 144) { // $a
    okay = parsea(label);
  } else if (type == 104) { // $f
    okay = parsef(label);
  } else {
    std::cerr << "Unexpected token " << type << " encountered" << std::endl;
    return false;
  }

  return okay;
}

// Parse $d statement. Return true iff okay.
bool parsed() {
  std::set<std::size_t> dvars;

  std::size_t token;

  while (!tokens.empty() && (token = tokens.front()) != 48) { // $.
    tokens.pop();

    if (!isactivevariable(token)) {
      std::cerr << "Token " << token << " is not an active variable, "
                << "but was found in a $d statement" << std::endl;
      return false;
    }

    bool const duplicate(!dvars.insert(token).second);
    if (duplicate) {
      std::cerr << "$d statement mentions " << token << " twice" << std::endl;
      return false;
    }
  }

  if (tokens.empty()) {
    std::cerr << "Unterminated $d statement" << std::endl;
    return false;
  }

  if (dvars.size() < 2) {
    std::cerr << "Not enough items in $d statement" << std::endl;
    return false;
  }

  // Record it
  scopes.back().disjvars.push_back(dvars);

  tokens.pop(); // Discard $. token

  return true;
}

// Parse $c statement. Return true iff okay.
bool parsec() {
  if (scopes.size() > 1) {
    std::cerr << "$c statement occurs in inner block" << std::endl;
    return false;
  }

  std::size_t token;
  bool listempty(true);
  while (!tokens.empty() && (token = tokens.front()) != 48) { // $.
    tokens.pop();
    listempty = false;

    if (!ismathsymboltoken(token)) {
      std::cerr << "Attempt to declare " << token << " as a constant"
                << std::endl;
      return false;
    }
    if (variables.find(token) != variables.end()) {
      std::cerr << "Attempt to redeclare variable " << token << " as a constant"
                << std::endl;
      return false;
    }
    if (labelused(token)) {
      std::cerr << "Attempt to reuse label " << token << " as a constant"
                << std::endl;
      return false;
    }
    bool const alreadydeclared(!constants.insert(token).second);
    if (alreadydeclared) {
      std::cerr << "Attempt to redeclare constant " << token << std::endl;
      return false;
    }
  }

  if (tokens.empty()) {
    std::cerr << "Unterminated $c statement" << std::endl;
    return false;
  }

  if (listempty) {
    std::cerr << "Empty $c statement" << std::endl;
    return false;
  }

  tokens.pop(); // Discard $. token

  return true;
}

// Parse $v statement. Return true iff okay.
bool parsev() {
  std::size_t token;
  bool listempty(true);
  while (!tokens.empty() && (token = tokens.front()) != 48) { // $.
    tokens.pop();
    listempty = false;

    if (!ismathsymboltoken(token)) {
      std::cerr << "Attempt to declare " << token << " as a variable"
                << std::endl;
      return false;
    }
    if (constants.find(token) != constants.end()) {
      std::cerr << "Attempt to redeclare constant " << token << " as a variable"
                << std::endl;
      return false;
    }
    if (labelused(token)) {
      std::cerr << "Attempt to reuse label " << token << " as a variable"
                << std::endl;
      return false;
    }
    bool const alreadyactive(isactivevariable(token));
    if (alreadyactive) {
      std::cerr << "Attempt to redeclare active variable " << token
                << std::endl;
      return false;
    }
    variables.insert(token);
    scopes.back().activevariables.insert(token);
  }

  if (tokens.empty()) {
    std::cerr << "Unterminated $v statement" << std::endl;
    return false;
  }

  if (listempty) {
    std::cerr << "Empty $v statement" << std::endl;
    return false;
  }

  tokens.pop(); // Discard $. token

  return true;
}

int main(int argc, char **argv) {
  if (argc != 2) {
    std::cerr << "Syntax: checkmm <fileno>" << std::endl;
    return EXIT_FAILURE;
  }

  switch (argv[1][0]) {
  case '0': // matching-logic-200-loc.mm
  {
    // for (std::size_t s : tokens_vector_matching_logic_200_loc) {
    //   tokens.push(s);
    // }
    // break;
    std::cerr << "Not added yet." << std::endl;
    return EXIT_FAILURE;
  }
  case '1': // peano.mm
  {
    // for (std::size_t s : tokens_vector_peano) {
    //   tokens.push(s);
    // }
    // break;
    std::cerr << "Not added yet." << std::endl;
    return EXIT_FAILURE;
  }
  case '2': // reflexivity.mm
  {
    // for (std::size_t s : tokens_vector_reflexivity) {
    //   tokens.push(s);
    // }
    // break;
    std::cerr << "Not added yet." << std::endl;
    return EXIT_FAILURE;
  }
  case '3': // simple.mm
  {
    std::cerr << "Not added yet." << std::endl;
    return EXIT_FAILURE;
    // for (std::size_t s : tokens_vector_simple) {
    //   tokens.push(s);
    // }
    // break;
  }
  case '4': // sum.mm
    std::cerr << "Not added yet." << std::endl;
    return EXIT_FAILURE;
  case '5': // wff.mm
  {
    // for (std::size_t s : tokens_vector_wff) {
    //   tokens.push(s);
    // }
    // break;
    std::cerr << "Not added yet." << std::endl;
    return EXIT_FAILURE;
  }
  case '6': // wff.mm mapped
  {
    for (int s : tokens_vector_wff_mapped) {
      tokens.push(s);
    }
    break;
  }
  default:
    std::cerr << "<fileno> does not correspond to an input file." << std::endl;
    return EXIT_FAILURE;
  }

  scopes.push_back(Scope());

  while (!tokens.empty()) {
    std::size_t const token(tokens.front());
    tokens.pop();

    bool okay(true);

    if (islabeltoken(token)) {
      okay = parselabel(token);
    } else if (token == 208) { // $d
      okay = parsed();
    } else if (token == 216) { // ${
      scopes.push_back(Scope());
    } else if (token == 224) { // $}
      scopes.pop_back();
      if (scopes.empty()) {
        std::cerr << "$} without corresponding ${" << std::endl;
        return EXIT_FAILURE;
      }
    } else if (token == 8) { // $c
      okay = parsec();
    } else if (token == 56) { // $v
      okay = parsev();
    } else {
      std::cerr << "Unexpected token " << token << " encountered" << std::endl;
      return EXIT_FAILURE;
    }
    if (!okay)
      return EXIT_FAILURE;
  }

  if (scopes.size() > 1) {
    std::cerr << "${ without corresponding $}" << std::endl;
    return EXIT_FAILURE;
  }

  return 0;
}
