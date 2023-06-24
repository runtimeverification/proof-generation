#include <algorithm>
#include <cassert>
#include <cstdlib>
#include <iostream>
#include <limits>
#include <string>
#include <utility>
#include <vector>


struct TS {
  std::string token;
  unsigned int tv;
  unsigned int mv;
};

std::vector<std::string> all_tokens_vector = {
    "$c", "(",  ")",  "->", "wff", "$.", "$v", "p",  "q",    "r",
    "s",  "wp", "$f", "wq", "wr",  "ws", "w2", "$a", "wnew", "$p",
    "$=", "?",  "e",  "a",  "$e",  "$d", "${", "$}"};

std::vector<std::string> tokens_vector_wff = {
    "$c", "(",    ")",  "->",  "wff", "$.", "$v", "p",  "q",  "r",
    "s",  "$.",   "wp", "$f",  "wff", "p",  "$.", "wq", "$f", "wff",
    "q",  "$.",   "wr", "$f",  "wff", "r",  "$.", "ws", "$f", "wff",
    "s",  "$.",   "w2", "$a",  "wff", "(",  "p",  "->", "q",  ")",
    "$.", "wnew", "$p", "wff", "(",   "s",  "->", "(",  "r",  "->",
    "p",  ")",    ")",  "$=",  "ws",  "wr", "wp", "w2", "w2", "$."};

std::vector<struct TS> tokeninfo;

// Determine if a token is a label token.
bool islabeltoken(std::string const token) {
  for (std::string::const_iterator iter(token.begin()); iter != token.end();
       ++iter) {
    unsigned char const ch(*iter);
    if (!(std::isalnum(ch) || ch == '.' || ch == '-' || ch == '_'))
      return false;
  }
  return true;
}

// Determine if a token is a math symbol token.
inline bool ismathsymboltoken(std::string const token) {
  return token.find('$') == std::string::npos;
}

// Determine if a token consists solely of upper-case letters or question marks
bool containsonlyupperorq(std::string token) {
  for (std::string::const_iterator iter(token.begin()); iter != token.end();
       ++iter) {
    if (!std::isupper(*iter) && *iter != '?')
      return false;
  }
  return true;
}

#define N 3
unsigned int truthvalue(bool p[][N], unsigned tk) {
  assert(N < sizeof(unsigned int));

  unsigned int r = 0;
  for (unsigned i = 0; i < N; i++) {
    r = r << 1;
    r = r | p[tk][i];
  }
  return r;
}

void printtokenmapping() {
  std::cout << "Tokens"
            << "\t==>\t"
            << "Mapped numbers" << std::endl;
  std::cout << "---------------------------------------------------"
            << std::endl;
  for (unsigned i = 0; i < tokeninfo.size(); i++) {
    std::cout << tokeninfo[i].token << "\t==>\t" << tokeninfo[i].mv
              << std::endl;
  }
}

void printmappedwff() {
  std::cout << std::endl
            << "---------------------------------------------------"
            << std::endl;
  std::cout << "std::vector<std::string> tokens_vector_wff_mapped = {"
            << std::endl;
  for (unsigned j = 0; j < tokens_vector_wff.size(); j++) {
    std::string s(tokens_vector_wff[j]);
    for (unsigned i = 0; i < tokeninfo.size(); i++) {
      if (s.compare(tokeninfo[i].token) == 0) {

        std::cout << "    " << tokeninfo[i].mv;
        if (j < tokens_vector_wff.size() - 1) {
          std::cout << ",";
        }
        std::cout << std::endl;
        break;
      }
    }
  }
  std::cout << "};" << std::endl;
}

bool gettokenmapping() {
  bool (*p[N])(std::string const t);
  p[0] = islabeltoken;
  p[1] = ismathsymboltoken;
  p[2] = containsonlyupperorq;

  bool result[all_tokens_vector.size()][N];

  for (unsigned f = 0; f < N; f++) {
    for (unsigned i = 0; i < all_tokens_vector.size(); i++) {
      result[i][f] = (*p[f])(all_tokens_vector[i]);
    }
  }

     std::cout << "\t\t" << "islabeltoken"
               << "\t" << "ismathsymboltoken"
               << "\t" << "containsonlyupperorq" << std::endl;
     for (unsigned i = 0; i < all_tokens_vector.size(); i++) {
         std::cout << all_tokens_vector[i] << "\t\t\t";
         for (unsigned j = 0; j < N; j++) {
             std::cout << result[i][j] << "\t\t\t";
         }
         std::cout << std::endl;
     }

  tokeninfo.resize(all_tokens_vector.size());
  for (unsigned i = 0; i < all_tokens_vector.size(); i++) {
    tokeninfo[i].token = all_tokens_vector[i];
    tokeninfo[i].tv = truthvalue(result, i);
  }

  for (unsigned i = 0; i < tokeninfo.size(); i++) {
    unsigned tvp = tokeninfo[i].tv & (1 << N) - 1;
    unsigned cp = i + 1 << N;
    tokeninfo[i].mv = tvp | cp;
  }

  return true;
}

int main(int argc, char **argv) {
  if (argc != 2) {
    std::cerr << "Syntax: checkmm <fileno>" << std::endl;
    return EXIT_FAILURE;
  }

  switch (argv[1][0]) {
  case '0': {
    gettokenmapping();
    printtokenmapping();
    printmappedwff();
    break;
  }
  default:
    std::cerr << "<fileno> does not correspond to an input file." << std::endl;
    return EXIT_FAILURE;
  }

  return 0;
}
