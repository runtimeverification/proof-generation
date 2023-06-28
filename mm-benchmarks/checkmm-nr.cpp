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

#include "data_structures/linked_list.hpp"
#include <algorithm>
#include <cctype>
#include <cstdlib>
#include <iostream>
#include <iterator>
#include <limits>
#include <utility>

#include "data_structures/deque.hpp"
#include "data_structures/map.hpp"
#include "data_structures/queue.hpp"
#include "data_structures/set.hpp"
#include "data_structures/vector.hpp"

#define MAX_INT 4294967295

zk::vector<std::size_t>::Iterator findToken(zk::vector<std::size_t> v,
                                            zk::LinkedList<size_t>::Node *head,
                                            std::size_t elem) {
  return v.find(elem, head);
}

// zk::vector<std::size_t> tokens_vector_wff_mapped2 = {
//     8,  18, 26,  34,  46, 48, 56, 70,  78,  86,  94,  48,  102, 104, 46,
//     70, 48, 118, 104, 46, 78, 48, 126, 104, 46,  86,  48,  134, 104, 46,
//     94, 48, 142, 144, 46, 18, 70, 34,  78,  26,  48,  158, 160, 46,  18,
//     94, 34, 18,  86,  34, 70, 26, 26,  168, 134, 126, 102, 142, 142, 48};

typedef zk::LinkedList<std::size_t>::Node Node_size_t;

zk::vector<std::size_t> tokens_vector_wff_mapped;
Node_size_t *tokens_vector_wff_mapped_head = nullptr;

void init_tokens_vector_wff_mapped() {
  tokens_vector_wff_mapped.push_front(8, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(18, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(26, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(34, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(46, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(48, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(56, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(70, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(78, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(86, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(94, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(48, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(102, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(104, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(46, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(70, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(48, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(118, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(104, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(46, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(78, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(48, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(126, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(104, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(46, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(86, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(48, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(134, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(104, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(46, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(94, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(48, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(142, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(144, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(46, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(18, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(70, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(34, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(78, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(26, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(48, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(158, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(160, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(46, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(18, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(94, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(34, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(18, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(86, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(34, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(70, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(26, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(26, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(168, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(134, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(126, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(102, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(142, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(142, tokens_vector_wff_mapped_head);
  tokens_vector_wff_mapped.push_front(48, tokens_vector_wff_mapped_head);
}

zk::queue<std::size_t> tokens;
Node_size_t *tokens_head = nullptr;

zk::set<std::size_t> constants;
Node_size_t *constants_head = nullptr;

typedef zk::vector<std::size_t> Expression;
Node_size_t *Expression_head = nullptr;

// The first parameter is the statement of the hypothesis, the second is
// true iff the hypothesis is floating.
typedef struct {
  Expression expression;
  bool floating;
} Hypothesis;

zk::map<std::size_t, Hypothesis> hypotheses;
zk::LinkedList<zk::map<std::size_t, Hypothesis>::Entry>::Node *hypotheses_head =
    nullptr;

zk::set<std::size_t> variables;
Node_size_t *variables_head = nullptr;

typedef struct {
  std::size_t first;
  std::size_t second;
} disvar;
// An axiom or a theorem.
struct Assertion {
  // Hypotheses of this axiom or theorem.
  zk::deque<std::size_t> hypotheses;
  Node_size_t *hypotheses_head = nullptr;
  zk::set<disvar> disjvars;
  zk::LinkedList<zk::set<disvar>>::Node *disjvars_head = nullptr;
  // Statement of axiom or theorem.
  Expression expression;
  zk::LinkedList<std::size_t>::Node *expression_head = nullptr;
};

zk::map<std::size_t, Assertion> assertions;
zk::LinkedList<zk::map<std::size_t, Assertion>::Entry>::Node *assertions_head =
    nullptr;

typedef zk::LinkedList<zk::map<int, int>::Entry>::Node Node_ii_map;

struct Scope {
  zk::set<std::size_t> activevariables;
  Node_size_t *activevariables_head = nullptr;
  // Labels of active hypotheses
  zk::vector<std::size_t> activehyp;
  Node_size_t *activehyp_head = nullptr;

  zk::vector<zk::set<std::size_t>> disjvars;
  zk::LinkedList<zk::set<std::size_t>>::Node *disjvar_head = nullptr;
  // Map from variable to label of active floating hypothesis
  zk::map<std::size_t, std::size_t> floatinghyp;
  zk::LinkedList<zk::map<std::size_t, std::size_t>::Entry>::Node
      *floatinghyp_head = nullptr;
};

zk::vector<Scope> scopes;
zk::LinkedList<Scope>::Node *scope_head = nullptr;

// Determine if a size_t is used as a label
inline bool labelused(std::size_t const label) {
  return hypotheses.find(label, hypotheses_head) != hypotheses.end() ||
         assertions.find(label, assertions_head) != assertions.end();
}

// Find active floating hypothesis corresponding to variable, or empty size_t
// if there isn't one.
std::size_t getfloatinghyp(std::size_t const var) {
  for (zk::vector<Scope>::Iterator iter(scope_head); iter != scopes.end();
       ++iter) {
    zk::map<std::size_t, std::size_t>::Iterator loc(
        iter->floatinghyp.find(var, iter->floatinghyp_head));
    if (loc != iter->floatinghyp.end())
      return loc->second;
  }

  return MAX_INT;
}

// Determine if a size_t is an active variable.
bool isactivevariable(std::size_t const str) {
  for (zk::vector<Scope>::Iterator iter(scope_head); iter != scopes.end();
       ++iter) {
    if (iter->activevariables.find(str, iter->activevariables_head) !=
        iter->activevariables.end())
      return true;
  }
  return false;
}

// Determine if a size_t is the label of an active hypothesis.
bool isactivehyp(std::size_t const str) {
  for (zk::vector<Scope>::Iterator iter(scope_head); iter != scopes.end();
       ++iter) {
    if (iter->activehyp.find(str, iter->activehyp_head) !=
        iter->activehyp.end())
      return true;
  }
  return false;
}

// Determine if there is an active disjoint variable restriction on
// two different variables.
/*bool isdvr(std::size_t var1, std::size_t var2) {
  if (var1 == var2)
    return false;
  for (zk::vector<Scope>::Iterator iter(scope_head);
       iter != scopes.end(); ++iter) {
    for (zk::vector<zk::set<std::size_t>>::Iterator iter2(
             iter->disjvars.begin(iter->disjvar_head));
         iter2 != iter->disjvars.end(); ++iter2) {
      if (iter2->find(var1) != iter2->end() &&
          iter2->find(var2) != iter2->end())
        return true;
    }
  }
  return false;
}*/

// Determine if a character is white space in Metamath.
inline bool ismmws(char const ch) {
  // This doesn't include \v ("vertical tab"), as the spec omits it.
  return ch == ' ' || ch == '\n' || ch == '\t' || ch == '\f' || ch == '\r';
}

// Determine if a token is a label token.
bool islabeltoken(std::size_t const token) {
  return token == 46 || token == 70 || token == 78 || token == 86 ||
         token == 94 || token == 102 || token == 118 || token == 126 ||
         token == 134 || token == 142 || token == 158 || token == 190 ||
         token == 198;
}

// Determine if a token is a math symbol token.
inline bool ismathsymboltoken(std::size_t const token) {
  return !(token == 8 || token == 48 || token == 56 || token == 104 ||
           token == 144 || token == 160 || token == 168 || token > 200);
}

// Determine if a token consists solely of upper-case letters or question marks
bool containsonlyupperorq(std::size_t token) { return token == 179; }

// Construct an Assertion from an Expression. That is, determine the
// mandatory hypotheses and disjoint variable restrictions.
// The Assertion is inserted into the assertions collection,
// and is returned by reference.
Assertion &constructassertion(std::size_t const label, Expression &exp,
Node_size_t * exp_head) { assertions.insert(label, Assertion(),
assertions_head); Assertion &assertion(assertions.at(label, assertions_head));

  assertion.expression = exp;

  zk::set<std::size_t> varsused;
  Node_size_t *varsused_head = nullptr;

  // Determine variables used and find mandatory hypotheses

  for (Expression::Iterator iter(exp_head); iter != exp.end();
       ++iter) {
    if (variables.find(*iter, variables_head) != variables.end())
      varsused.insert(*iter, varsused_head);
  }

  /*for (zk::vector<Scope>::ReverseIterator iter(scopes.rbegin());
       iter != scopes.rend(); ++iter) {
    zk::vector<std::size_t> const &hypvec(iter->activehyp);
    for (zk::vector<std::size_t>::ReverseIterator iter2(hypvec.rbegin());
         iter2 != hypvec.rend(); ++iter2) {
      Hypothesis const &hyp(hypotheses.find(*iter2)->second);
      if (hyp.second && varsused.find(hyp.first[1]) != varsused.end()) {
        // Mandatory floating hypothesis
        assertion.hypotheses.push_front(*iter2);
      } else if (!hyp.second) {
        // Essential hypothesis
        assertion.hypotheses.push_front(*iter2);
        for (Expression::Iterator iter3(hyp.first.begin());
             iter3 != hyp.first.end(); ++iter3) {
          if (variables.find(*iter3, variables_head) != variables.end())
            varsused.insert(*iter3, varsused_head);
        }
      }
    }
  }*/

  // Determine mandatory disjoint variable restrictions
  /*for (zk::vector<Scope>::Iterator iter(scopes.begin());
       iter != scopes.end(); ++iter) {
    zk::vector<zk::set<std::size_t>> const &disjvars(iter->disjvars);
    for (zk::vector<zk::set<std::size_t>>::Iterator iter2(
             disjvars.begin());
         iter2 != disjvars.end(); ++iter2) {
      zk::set<std::size_t> dset;
      std::set_intersection(iter2->begin(), iter2->end(), varsused.begin(),
                            varsused.end(), std::inserter(dset, dset.end()));

      for (zk::set<std::size_t>::Iterator diter(dset.begin());
           diter != dset.end(); ++diter) {
        zk::set<std::size_t>::Iterator diter2(diter);
        ++diter2;
        for (; diter2 != dset.end(); ++diter2)
          assertion.disjvars.insert(std::make_pair(*diter, *diter2));
      }
    }
  }*/

  return assertion;
}

// Read an expression from the token stream. Returns true iff okay.
bool readexpression(char stattype, std::size_t label, std::size_t terminator,
                    Expression *exp, Node_size_t *exp_head) {
  if (tokens.empty(tokens_head)) {
    std::cerr << "Unfinished $" << stattype << " statement " << label
              << std::endl;
    return false;
  }

  std::size_t type = tokens.front(tokens_head);

  if (constants.find(type, constants_head) == constants.end()) {
    std::cerr << "First symbol in $" << stattype << " statement " << label
              << " is " << type << " which is not a constant" << std::endl;
    return false;
  }

  tokens.pop(tokens_head);

  exp->push_back(type, exp_head);

  std::size_t token;

  while (!tokens.empty(tokens_head) &&
         (token = tokens.front(tokens_head)) != terminator) {
    tokens.pop(tokens_head);

    if (constants.find(token, constants_head) == constants.end() &&
        (getfloatinghyp(token) == INT_MAX)) {
      std::cerr << "In $" << stattype << " statement " << label << " token "
                << token
                << " found which is not a constant or variable in an"
                   " active $f statement"
                << std::endl;
      return false;
    }

    exp->push_back(token, exp_head);
  }

  if (tokens.empty(tokens_head)) {
    std::cerr << "Unfinished $" << stattype << " statement " << label
              << std::endl;
    return false;
  }

  tokens.pop(tokens_head); // Discard terminator token

  return true;
}

// Make a substitution of variables. The result is put in "destination",
// which should be empty.
void makesubstitution(
    Expression &original, Node_size_t *original_head,
    zk::map<std::size_t, Expression> substmap,
    zk::LinkedList<zk::map<std::size_t, Expression>::Entry>::Node
        *substmap_head,
    Expression *destination, Node_size_t *destination_head) {
  for (Expression::Iterator iter(original_head); iter != original.end();
       ++iter) {
    zk::map<std::size_t, Expression>::Iterator iter2(
        substmap.find(*iter, substmap_head));
    if (iter2 == substmap.end()) {
      // Constant
      destination->push_back(*iter, destination_head);
    } else {
      // Variable
      // std::copy(iter2->second.begin(), iter2->second.end(),
      //           std::back_inserter(*destination));
    }
  }
}

// Get the raw numbers from compressed proof format.
// The letter Z is translated as 0.
bool getproofnumbers(std::size_t label, zk::vector<std::size_t> proof,
                     Node_size_t *proof_head,
                     zk::vector<std::size_t> *proofnumbers,
                     Node_size_t *proofnumbers_head) {
  std::size_t const size_max(std::numeric_limits<std::size_t>::max());

  std::size_t num(0u);
  bool justgotnum(false);
  for (auto iter = proof.begin(proof_head); iter != proof.end(); ++iter) {
    if (*iter <= 84) {                            // 'T'
      std::size_t const addval(*iter - (65 - 1)); // 'A'

      if (num > size_max / 20 || 20 * num > size_max - addval) {
        std::cerr << "Overflow computing numbers in compressed proof "
                     "of "
                  << label << std::endl;
        return false;
      }

      proofnumbers->push_back(20 * num + addval, proofnumbers_head);
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

      proofnumbers->push_back(0, proofnumbers_head);
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
/*
// Subroutine for proof verification. Verify a proof step referencing an
// assertion (i.e., not a hypothesis).
bool verifyassertionref(std::size_t thlabel, std::size_t reflabel,
                        zk::vector<Expression> *stack) {
  Assertion const &assertion(assertions.find(reflabel)->second);
  if (stack->size() < assertion.hypotheses.size()) {
    std::cerr << "In proof of theorem " << thlabel
              << " not enough items found on stack" << std::endl;
    return false;
  }

  zk::vector<Expression>::size_type const base(stack->size() -
                                               assertion.hypotheses.size());

  zk::map<std::size_t, Expression> substitutions;

  // Determine substitutions and check that we can unify
  for (zk::deque<std::size_t>::size_type i(0); i < assertion.hypotheses.size();
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
  for (zk::set<std::pair<std::size_t, std::size_t>>::Iterator iter(
           assertion.disjvars.begin());
       iter != assertion.disjvars.end(); ++iter) {
    Expression const &exp1(substitutions.find(iter->first)->second);
    Expression const &exp2(substitutions.find(iter->second)->second);

    zk::set<std::size_t> exp1vars;
    for (Expression::Iterator exp1iter(exp1.begin()); exp1iter != exp1.end();
         ++exp1iter) {
      if (variables.find(*exp1iter) != variables.end())
        exp1vars.insert(*exp1iter);
    }

    zk::set<std::size_t> exp2vars;
    for (Expression::Iterator exp2iter(exp2.begin()); exp2iter != exp2.end();
         ++exp2iter) {
      if (variables.find(*exp2iter) != variables.end())
        exp2vars.insert(*exp2iter);
    }

    for (zk::set<std::size_t>::Iterator exp1iter(exp1vars.begin());
         exp1iter != exp1vars.end(); ++exp1iter) {
      for (zk::set<std::size_t>::Iterator exp2iter(exp2vars.begin());
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
*/
// Verify a regular proof. The "proof" argument should be a non-empty sequence
// of valid labels. Return true iff the proof is correct.
bool verifyregularproof(std::size_t label, Assertion &theorem,
                        zk::vector<std::size_t> &proof,
                        Node_size_t *substmap_head) {
  zk::vector<Expression> stack;
  zk::LinkedList<Expression>::Node *stack_head;
  for (zk::vector<std::size_t>::Iterator proofstep(substmap_head);
       proofstep != proof.end(); ++proofstep) {
    // If step is a hypothesis, just push it onto the stack.
    zk::map<std::size_t, Hypothesis>::Iterator hyp(
        hypotheses.find(*proofstep, hypotheses_head));
    if (hyp != hypotheses.end()) {
      stack.push_back(hyp->second.expression, stack_head);
      continue;
    }

    // It must be an axiom or theorem
    // bool const okay(verifyassertionref(label, *proofstep, &stack));
    // if (!okay)
    //   return false;
  }

  if (stack.size() != 1) {
    std::cerr << "Proof of theorem " << label
              << " does not end with only one item on the stack" << std::endl;
    return false;
  }

  // if (stack[0] != theorem.expression) {
  //   std::cerr << "Proof of theorem " << label << " proves wrong statement"
  //             << std::endl;
  // }

  return true;
}

// Verify a compressed proof
bool verifycompressedproof(std::size_t label, Assertion &theorem,
                           zk::vector<std::size_t> &labels,
                           zk::LinkedList<std::size_t>::Node *labels_head,
                           zk::vector<std::size_t> &proofnumbers,
                           Node_size_t *proofnumbers_head) {
  zk::vector<Expression> stack;
  zk::LinkedList<Expression>::Node *stack_head;

  std::size_t const mandhypt(theorem.hypotheses.size(theorem.hypotheses_head));
  std::size_t const labelt(mandhypt + labels.size());

  zk::vector<Expression> savedsteps;
  zk::LinkedList<Expression>::Node *savedsteps_head;
  for (zk::vector<std::size_t>::Iterator iter(proofnumbers_head);
       iter != proofnumbers.end(); ++iter) {
    // Save the last proof step if 0
    if (*iter == 0) {
      savedsteps.push_back(stack.back(stack_head), savedsteps_head);
      continue;
    }

    // If step is a mandatory hypothesis, just push it onto the stack.
    if (*iter <= mandhypt) {
      stack.push_back(
          hypotheses
              .find(theorem.hypotheses.at(*iter - 1, theorem.expression_head),
                    hypotheses_head)
              ->second.expression,
          stack_head);
    } else if (*iter <= labelt) {
      std::size_t const proofstep(labels.at(*iter - mandhypt - 1, labels_head));

      // If step is a (non-mandatory) hypothesis,
      // just push it onto the stack.
      zk::map<std::size_t, Hypothesis>::Iterator hyp(
          hypotheses.find(proofstep, hypotheses_head));
      if (hyp != hypotheses.end()) {
        stack.push_back(hyp->second.expression, stack_head);
        continue;
      }

      // It must be an axiom or theorem
      // bool const okay(verifyassertionref(label, proofstep, &stack));
      // if (!okay)
      //   return false;
    } else // Must refer to saved step
    {
      if (*iter > labelt + savedsteps.size()) {
        std::cerr << "Number in compressed proof of " << label << " is too high"
                  << std::endl;
        return false;
      }

      stack.push_back(savedsteps.at(*iter - labelt - 1, savedsteps_head),
                      stack_head);
    }
  }

  if (stack.size() != 1) {
    std::cerr << "Proof of theorem " << label
              << " does not end with only one item on the stack" << std::endl;
    return false;
  }

  // if (stack[0] != theorem.expression) {
  //   std::cerr << "Proof of theorem " << label << " proves wrong statement"
  //             << std::endl;
  // }

  return true;
}

// Parse $p statement. Return true iff okay.
bool parsep(std::size_t label) {
  Expression newtheorem;
  Node_size_t *newtheorem_head;
  bool const okay(
      readexpression('p', label, 168, &newtheorem, newtheorem_head)); // $=
  if (!okay) {
    return false;
  }

  // Assertion const &assertion(constructassertion(label, newtheorem));

  // Now for the proof

  if (tokens.empty(tokens_head)) {
    std::cerr << "Unfinished $p statement " << label << std::endl;
    return false;
  }

  if (tokens.front(tokens_head) == 11) { // (
    // Compressed proof
    tokens.pop(tokens_head);

    // Get labels

    zk::vector<std::size_t> labels;
    Node_size_t *labels_head;
    std::size_t token;
    while (!tokens.empty(tokens_head) &&
           (token = tokens.front(tokens_head)) != 12) { // )
      tokens.pop(tokens_head);
      labels.push_back(token, labels_head);
      if (token == label) {
        std::cerr << "Proof of theorem " << label << " refers to itself"
                  << std::endl;
        return false;
      } /* else if (assertion.hypotheses.find(token, assertion.hypotheses_head)
       !=
                  != assertion.hypotheses.end()) {
         std::cerr << "Compressed proof of theorem " << label
                   << " has mandatory hypothesis " << token << " in label list"
                   << std::endl;
         return false;
       }
       */
      else if (assertions.find(token, assertions_head) == assertions.end() &&
               !isactivehyp(token)) {
        std::cerr << "Proof of theorem " << label << " refers to " << token
                  << " which is not an active statement" << std::endl;
        return false;
      }
    }

    if (tokens.empty(tokens_head)) {
      std::cerr << "Unfinished $p statement " << label << std::endl;
      return false;
    }

    tokens.pop(tokens_head); // Discard ) token

    // Get proof steps

    zk::vector<std::size_t> proof;
    Node_size_t *proof_head;
    while (!tokens.empty(tokens_head) &&
           (token = tokens.front(tokens_head)) != 48) { // $.
      tokens.pop(tokens_head);

      proof.push_back(token, proof_head);
      if (!containsonlyupperorq(token)) {
        std::cerr << "Bogus character found in compressed proof of " << label
                  << std::endl;
        return false;
      }
    }

    if (tokens.empty(tokens_head)) {
      std::cerr << "Unfinished $p statement " << label << std::endl;
      return false;
    }

    if (proof.empty()) {
      std::cerr << "Theorem " << label << " has no proof" << std::endl;
      return false;
    }

    tokens.pop(tokens_head); // Discard $. token

    if (findToken(proof, proof_head, 27) != proof.end()) { // ?
      std::cerr << "Warning: Proof of theorem " << label << " is incomplete"
                << std::endl;
      return true; // Continue processing file
    }

    zk::vector<std::size_t> proofnumbers;
    Node_size_t *proofnumbers_head;
    // proofnumbers.reserve(proof.size()); // Preallocate for efficiency
    bool okay(getproofnumbers(label, proof, proof_head, &proofnumbers,
                              proofnumbers_head));
    if (!okay)
      return false;

    // okay = verifycompressedproof(label, assertion, labels, labels_head,
    // proofnumbers, proofnumbers_head); if (!okay)
    //  return false;
  } else {
    // Regular (uncompressed proof)
    zk::vector<std::size_t> proof;
    Node_size_t *proof_head;
    bool incomplete(false);
    std::size_t token;
    while (!tokens.empty(tokens_head) &&
           (token = tokens.front(tokens_head)) != 48) { // $.
      tokens.pop(tokens_head);
      proof.push_back(token, proof_head);
      if (token == 27) // ?
        incomplete = true;
      else if (token == label) {
        std::cerr << "Proof of theorem " << label << " refers to itself"
                  << std::endl;
        return false;
      } else if (assertions.find(token, assertions_head) == assertions.end() &&
                 !isactivehyp(token)) {
        std::cerr << "Proof of theorem " << label << " refers to " << token
                  << " which is not an active statement" << std::endl;
        return false;
      }
    }

    if (tokens.empty(tokens_head)) {
      std::cerr << "Unfinished $p statement " << label << std::endl;
      return false;
    }

    if (proof.empty()) {
      std::cerr << "Theorem " << label << " has no proof" << std::endl;
      return false;
    }

    tokens.pop(tokens_head); // Discard $. token

    if (incomplete) {
      std::cerr << "Warning: Proof of theorem " << label << " is incomplete"
                << std::endl;
      return true; // Continue processing file
    }

    // bool okay(verifyregularproof(label, assertion, proof));
    // if (!okay)
    //   return false;
  }

  return true;
}

// Parse $e statement. Return true iff okay.
bool parsee(std::size_t label) {
  Expression newhyp;
  Node_size_t *newhyp_head;
  bool const okay(readexpression('e', label, 48, &newhyp, newhyp_head)); // $.
  if (!okay) {
    return false;
  }

  // Create new essential hypothesis
  Hypothesis hyp = {newhyp, false};
  hypotheses.insert(label, hyp, hypotheses_head);
  ;
  scopes.back(scope_head)
      .activehyp.push_back(label, scopes.back(scope_head).activehyp_head);

  return true;
}

// Parse $a statement. Return true iff okay.
bool parsea(std::size_t label) {
  Expression newaxiom;
  Node_size_t *newaxiom_head;
  bool const okay(
      readexpression('a', label, 48, &newaxiom, newaxiom_head)); // $.
  if (!okay) {
    return false;
  }

  //constructassertion(label, newaxiom, newaxiom_head);

  return true;
}

// Parse $f statement. Return true iff okay.
bool parsef(std::size_t label) {
  if (tokens.empty(tokens_head)) {
    std::cerr << "Unfinished $f statement" << label << std::endl;
    return false;
  }

  std::size_t type(tokens.front(tokens_head));

  if (constants.find(type, constants_head) == constants.end()) {
    std::cerr << "First symbol in $f statement " << label << " is " << type
              << " which is not a constant" << std::endl;
    return false;
  }

  tokens.pop(tokens_head);

  if (tokens.empty(tokens_head)) {
    std::cerr << "Unfinished $f statement " << label << std::endl;
    return false;
  }

  std::size_t variable(tokens.front(tokens_head));
  if (!isactivevariable(variable)) {
    std::cerr << "Second symbol in $f statement " << label << " is " << variable
              << " which is not an active variable" << std::endl;
    return false;
  }
  if (getfloatinghyp(variable) != MAX_INT) {
    std::cerr << "The variable " << variable
              << " appears in a second $f statement " << label << std::endl;
    return false;
  }

  tokens.pop(tokens_head);

  if (tokens.empty(tokens_head)) {
    std::cerr << "Unfinished $f statement" << label << std::endl;
    return false;
  }

  if (tokens.front(tokens_head) != 48) { // $.
    std::cerr << "Expected end of $f statement " << label << " but found "
              << tokens.front(tokens_head) << std::endl;
    return false;
  }

  tokens.pop(tokens_head); // Discard $. token

  // Create new floating hypothesis
  Expression newhyp;
  zk::LinkedList<size_t>::Node *newhyp_head = nullptr;

  newhyp.push_back(type, newhyp_head);
  newhyp.push_back(variable, newhyp_head);
  Hypothesis hyp = {newhyp, false};
  hypotheses.insert(label, hyp, hypotheses_head);
  auto activehyp_head = scopes.back(scope_head).activehyp_head;
  scopes.back(scope_head).activehyp.push_back(label, activehyp_head);
  scopes.back(scope_head)
      .floatinghyp.insert(variable, label,
                          scopes.back(scope_head).floatinghyp_head);

  return true;
}

// Parse labeled statement. Return true iff okay.
bool parselabel(std::size_t label) {
  if (constants.find(label, constants_head) != constants.end()) {
    std::cerr << "Attempt to reuse constant " << label << " as a label"
              << std::endl;
    return false;
  }

  if (variables.find(label, variables_head) != variables.end()) {
    std::cerr << "Attempt to reuse variable " << label << " as a label"
              << std::endl;
    return false;
  }

  if (labelused(label)) {
    std::cerr << "Attempt to reuse label " << label << std::endl;
    return false;
  }

  if (tokens.empty(tokens_head)) {
    std::cerr << "Unfinished labeled statement" << std::endl;
    return false;
  }

  std::size_t const type(tokens.front(tokens_head));
  tokens.pop(tokens_head);

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
  zk::set<std::size_t> dvars;
  Node_size_t *dvars_head = nullptr;

  std::size_t token;

  while (!tokens.empty(tokens_head) &&
         (token = tokens.front(tokens_head)) != 48) { // $.
    tokens.pop(tokens_head);

    if (!isactivevariable(token)) {
      std::cerr << "Token " << token << " is not an active variable, "
                << "but was found in a $d statement" << std::endl;
      return false;
    }

    bool const duplicate(!dvars.insert(token, dvars_head));
    if (duplicate) {
      std::cerr << "$d statement mentions " << token << " twice" << std::endl;
      return false;
    }
  }

  if (tokens.empty(tokens_head)) {
    std::cerr << "Unterminated $d statement" << std::endl;
    return false;
  }

  if (dvars.size(dvars_head) < 2) {
    std::cerr << "Not enough items in $d statement" << std::endl;
    return false;
  }

  // Record it
  auto head = scopes.back(scope_head).disjvar_head;
  scopes.back(scope_head).disjvars.push_back(dvars, head);

  tokens.pop(tokens_head); // Discard $. token

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
  while (!tokens.empty(tokens_head) &&
         (token = tokens.front(tokens_head)) != 48) { // $.
    tokens.pop(tokens_head);
    listempty = false;

    if (!ismathsymboltoken(token)) {
      std::cerr << "Attempt to declare " << token << " as a constant"
                << std::endl;
      return false;
    }
    if (variables.find(token, variables_head) != variables.end()) {
      std::cerr << "Attempt to redeclare variable " << token << " as a constant"
                << std::endl;
      return false;
    }
    if (labelused(token)) {
      std::cerr << "Attempt to reuse label " << token << " as a constant"
                << std::endl;
      return false;
    }
    bool const alreadydeclared(!constants.insert(token, constants_head));
    if (alreadydeclared) {
      std::cerr << "Attempt to redeclare constant " << token << std::endl;
      return false;
    }
  }

  if (tokens.empty(tokens_head)) {
    std::cerr << "Unterminated $c statement" << std::endl;
    return false;
  }

  if (listempty) {
    std::cerr << "Empty $c statement" << std::endl;
    return false;
  }

  tokens.pop(tokens_head); // Discard $. token

  return true;
}

// Parse $v statement. Return true iff okay.
bool parsev() {
  std::size_t token;
  bool listempty(true);
  while (!tokens.empty(tokens_head) &&
         (token = tokens.front(tokens_head)) != 48) { // $.
    tokens.pop(tokens_head);
    listempty = false;

    if (!ismathsymboltoken(token)) {
      std::cerr << "Attempt to declare " << token << " as a variable"
                << std::endl;
      return false;
    }
    if (constants.find(token, constants_head) != constants.end()) {
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
    variables.insert(token, variables_head);
    auto activevariables_head = scopes.back(scope_head).activevariables_head;
    scopes.back(scope_head).activevariables.insert(token, activevariables_head);
  }

  if (tokens.empty(tokens_head)) {
    std::cerr << "Unterminated $v statement" << std::endl;
    return false;
  }

  if (listempty) {
    std::cerr << "Empty $v statement" << std::endl;
    return false;
  }

  tokens.pop(tokens_head); // Discard $. token

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
    init_tokens_vector_wff_mapped();
    typename zk::vector<size_t>::Iterator iter(tokens_vector_wff_mapped_head);
    for (; iter != tokens_vector_wff_mapped.end(); ++iter) {
      tokens.push(*iter, tokens_head);
    }
    break;
  }
  default:
    std::cerr << "<fileno> does not correspond to an input file." << std::endl;
    return EXIT_FAILURE;
  }

  scopes.push_back(Scope(), scope_head);

  while (!tokens.empty(tokens_head)) {
    std::size_t const token(tokens.front(tokens_head));
    tokens.pop(tokens_head);

    bool okay(true);

    if (islabeltoken(token)) {
      okay = parselabel(token);
    } else if (token == 208) { // $d
      okay = parsed();
    } else if (token == 216) { // ${
      scopes.push_back(Scope(), scope_head);
    } else if (token == 224) { // $}
      scopes.pop_back(scope_head);
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

// int main() { return 0; }