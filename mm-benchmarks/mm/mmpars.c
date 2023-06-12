/*****************************************************************************/
/*        Copyright (C) 2021  NORMAN MEGILL                                  */
/*            License terms:  GNU General Public License                     */
/*****************************************************************************/
/*34567890123456 (79-character line to adjust editor window) 2345678901234567*/

#include <string.h>
#include <stdlib.h>
#include <ctype.h>
#include "mmvstr.h"
#include "mmdata.h"
#include "mminou.h"
#include "mmpars.h"
/* #include "mmcmds.h" */  /* For getContribs() if used */
#include "mmcmdl.h" /* Needed for g_rootDirectory */

long potentialStatements; /* Potential statements in source file (upper
                                 limit) for memory allocation purposes */
flag illegalLabelChar[256]; /* Illegal characters for labels -- initialized
                               by parseLabels() */
/* (Next 2 are global in mmpars.c only) */
long *g_labelKeyBase; /* Start of assertion ($a, $p) labels */
long g_numLabelKeys; /* Number of assertion labels */

long *g_allLabelKeyBase; /* Start of all labels */
long g_numAllLabelKeys; /* Number of all labels */

/* Working structure for parsing proofs */
/* This structure should be deallocated by the ERASE command. */
long g_wrkProofMaxSize = 0; /* Maximum size so far - it may grow */
long wrkMathPoolMaxSize = 0; /* Max mathStringPool size so far - it may grow */
struct wrkProof_struct g_WrkProof;

/* This function returns a pointer to a buffer containing the contents of an
   input file and its 'include' calls.  'Size' returns the buffer's size.
   Partial parsing is done; when 'include' statements are found, this function
   is called recursively.
   The file g_input_fn is assumed to be opened when this is called. */
char *readRawSource(vstring fileBuf, long *size) {
  long charCount = 0;
  char *fbPtr;
  flag insideComment;
  char mode;
  char tmpch;

  charCount = *size;

  /* Look for $[ and $] 'include' statement start and end */
  /* These won't happen since they're now expanded earlier */
  /* But it can't hurt, since the code is already written.
     TODO - clean it up for speedup? */
  fbPtr = fileBuf;
  mode = 0; /* 0 = outside of 'include', 1 = inside of 'include' */
  insideComment = 0; /* 1 = inside $( $) comment */
  while (1) {
    /* Find a keyword or newline */
    tmpch = fbPtr[0];
    if (!tmpch) { /* End of file */
      if (insideComment) {
        rawSourceError(fileBuf, fbPtr - 1, 2,
         "The last comment in the file is incomplete.  \"$)\" was expected.");
      } else {
        if (mode != 0) {
          rawSourceError(fileBuf, fbPtr - 1, 2,
   "The last include statement in the file is incomplete.  \"$]\" was expected."
           );
        }
      }
      break;
    }
    if (tmpch != '$') {
      if (!isgraph((unsigned char)tmpch) && !isspace((unsigned char)tmpch)) {
        rawSourceError(fileBuf, fbPtr, 1,
            cat("Illegal character (ASCII code ",
            str((double)((unsigned char)tmpch)),
            " decimal).",NULL));
      }
      fbPtr++;
      continue;
    }

    /* Detect missing whitespace around keywords (per current
       Metamath language spec) */
    if (fbPtr > fileBuf) {  /* If this '$' is not the 1st file character */
      if (isgraph((unsigned char)(fbPtr[-1]))) {
        /* The character before the '$' is not white space */
        if (!insideComment || fbPtr[1] == ')') {
          /* Inside comments, we only care about the "$)" keyword */
          rawSourceError(fileBuf, fbPtr, 2,
              "A keyword must be preceded by white space.");
        }
      }
    }
    fbPtr++;
    if (fbPtr[0]) {  /* If the character after '$' is not end of file (which
                        would be an error anyway, but detected elsewhere) */
      if (isgraph((unsigned char)(fbPtr[1]))) {
        /* The character after the character after the '$' is not white
           space (nor end of file) */
        if (!insideComment || fbPtr[0] == ')') {
          /* Inside comments, we only care about the "$)" keyword */
          rawSourceError(fileBuf, fbPtr + 1, 1,
              "A keyword must be followed by white space.");
          }
      }
    }

    switch (fbPtr[0]) {
      case '(': /* Start of comment */
        if (insideComment) {
          rawSourceError(fileBuf, fbPtr - 1, 2,
          "Nested comments are not allowed.");
        }
        insideComment = 1;
        continue;
      case ')': /* End of comment */
        if (!insideComment) {
          rawSourceError(fileBuf, fbPtr - 1, 2,
              "A comment terminator was found outside of a comment.");
        }
        insideComment = 0;
        continue;
    }
    if (insideComment) continue;
    switch (fbPtr[0]) {
      case '[':
        if (mode != 0) {
          rawSourceError(fileBuf, fbPtr - 1, 2,
              "Nested include statements are not allowed.");
        } else {
          /* $[ ... $] should have been processed by readSourceAndIncludes() */
          rawSourceError(fileBuf, fbPtr - 1, 2,
              "\"$[\" is unterminated or has ill-formed \"$]\".");
        }
        continue;
      case ']':
        if (mode == 0) {
          rawSourceError(fileBuf, fbPtr - 1, 2,
              "A \"$[\" is required before \"$]\".");
          continue;
        }

        /* Because $[ $] are already expanded here, this should never happen */
        bug(1759);

        continue;

      case '{':
      case '}':
      case '.':
        potentialStatements++; /* Number of potential statements for malloc */
        break;
    } /* End switch fbPtr[0] */
  } /* End while */

  if (fbPtr != fileBuf + charCount) {
    /* To help debugging: */
    printf("fbPtr=%ld fileBuf=%ld charCount=%ld diff=%ld\n",
        (long)fbPtr, (long)fileBuf, charCount, fbPtr - fileBuf - charCount);
    bug(1704);
  }

  //print2("%ld bytes were read into the source buffer.\n", charCount);

  if (*size != charCount) bug(1761);
  return fileBuf;
} /* readRawSource */

/* This function initializes the g_Statement[] structure array and assigns
   sections of the raw input text.  statements is updated.
   g_sourcePtr is assumed to point to the raw input buffer.
   g_sourceLen is assumed to be length of the raw input buffer. */
void parseKeywords(void)
{
  long i, j, k;
  char *fbPtr;
  flag insideComment;
  char mode, type;
  char *startSection;
  char tmpch;
  long dollarPCount = 0; /* For statistics only */
  long dollarACount = 0; /* For statistics only */

  /* Initialization to avoid compiler warning (should not be theoretically
     necessary) */
  type = 0;

  /* Determine the upper limit of the number of new statements added for
     allocation purposes (computed in readRawInput) */
  potentialStatements = potentialStatements + 3; /* To be cautious */
/*E*/if(db5)print2("There are up to %ld potential statements.\n",
/*E*/   potentialStatements);

  /* Reallocate the statement array for all potential statements */
  g_Statement = realloc(g_Statement, (size_t)potentialStatements
      * sizeof(struct statement_struct));
  if (!g_Statement) outOfMemory("#4 (statement)");

  /* Initialize the statement array */
  i = 0;
  g_Statement[i].lineNum = 0;   /* assigned by assignStmtFileAndLineNum() */
  g_Statement[i].fileName = ""; /* assigned by assignStmtFileAndLineNum() */
  g_Statement[i].labelName = "";
  g_Statement[i].uniqueLabel = 0;
  g_Statement[i].type = illegal_;
  g_Statement[i].scope = 0;
  g_Statement[i].beginScopeStatementNum = 0;
  g_Statement[i].endScopeStatementNum = 0;
  g_Statement[i].labelSectionPtr = "";
  g_Statement[i].labelSectionLen = 0;
  g_Statement[i].labelSectionChanged = 0;
  g_Statement[i].statementPtr = ""; /* input to assignStmtFileAndLineNum() */
  g_Statement[i].mathSectionPtr = "";
  g_Statement[i].mathSectionLen = 0;
  g_Statement[i].mathSectionChanged = 0;
  g_Statement[i].proofSectionPtr = "";
  g_Statement[i].proofSectionLen = 0;
  g_Statement[i].proofSectionChanged = 0;
  g_Statement[i].mathString = NULL_NMBRSTRING;
  g_Statement[i].mathStringLen = 0;
  g_Statement[i].proofString = NULL_NMBRSTRING;
  g_Statement[i].reqHypList = NULL_NMBRSTRING;
  g_Statement[i].optHypList = NULL_NMBRSTRING;
  g_Statement[i].numReqHyp = 0;
  g_Statement[i].reqVarList = NULL_NMBRSTRING;
  g_Statement[i].optVarList = NULL_NMBRSTRING;
  g_Statement[i].reqDisjVarsA = NULL_NMBRSTRING;
  g_Statement[i].reqDisjVarsB = NULL_NMBRSTRING;
  g_Statement[i].reqDisjVarsStmt = NULL_NMBRSTRING;
  g_Statement[i].optDisjVarsA = NULL_NMBRSTRING;
  g_Statement[i].optDisjVarsB = NULL_NMBRSTRING;
  g_Statement[i].optDisjVarsStmt = NULL_NMBRSTRING;
  g_Statement[i].pinkNumber = 0;
  g_Statement[i].headerStartStmt = 0;
  for (i = 1; i < potentialStatements; i++) {
    g_Statement[i] = g_Statement[0];
  }

  /* In case there is no relevant statement (originally added for MARKUP
     command) */
  g_Statement[0].labelName = "(N/A)";

/*E*/if(db5)print2("Finished initializing statement array.\n");

  /* Fill in the statement array with raw source text */
  fbPtr = g_sourcePtr;
  mode = 0; /* 0 = label section, 1 = math section, 2 = proof section */
  insideComment = 0; /* 1 = inside comment */
  startSection = fbPtr;

  while (1) {
    /* Find a keyword or newline */
    tmpch = fbPtr[0];
    if (!tmpch) { /* End of file */
      if (mode != 0) {
        sourceError(fbPtr - 1, 2, g_statements,
            "Expected \"$.\" here (last line of file).");
        if (g_statements) { /* Adjustment for error messages */
          startSection = g_Statement[g_statements].labelSectionPtr;
          g_statements--;
        }
      }
      break;
    }

    if (tmpch != '$') {
      fbPtr++;
      continue;
    }
    fbPtr++;
    switch (fbPtr[0]) {
      case '$': /* "$$" means literal "$" */
        fbPtr++;
        continue;
      case '(': /* Start of comment */
        insideComment = 1;
        continue;
      case ')': /* End of comment */
        insideComment = 0;
        continue;
    }
    if (insideComment) continue;
    switch (fbPtr[0]) {
      case 'c':  type = c_; break;
      case 'v':  type = v_; break;
      case 'e':  type = e_; break;
      case 'f':  type = f_; break;
      case 'd':  type = d_; break;
      case 'a':  type = a_; dollarACount++; break;
      case 'p':  type = p_; dollarPCount++; break;
      case '{':  type = lb_; break;
      case '}':  type = rb_; break;
    }
    switch (fbPtr[0]) {
      case 'c':
      case 'v':
      case 'e':
      case 'f':
      case 'd':
      case 'a':
      case 'p':
      case '{':
      case '}':
        if (mode != 0) {
          if (mode == 2 || type != p_) {
            sourceError(fbPtr - 1, 2, g_statements,
                "Expected \"$.\" here.");
          } else {
            sourceError(fbPtr - 1, 2, g_statements,
                "Expected \"$=\" here.");
          }
          continue;
        }
        /* Initialize a new statement */
        g_statements++;
        g_Statement[g_statements].type = type;
        g_Statement[g_statements].labelSectionPtr = startSection;
        g_Statement[g_statements].labelSectionLen = fbPtr - startSection - 1;
        /* The character after label section is used by
           assignStmtFileAndLineNum() to determine the "line number" for the
           statement as a whole */
        g_Statement[g_statements].statementPtr = startSection
            + g_Statement[g_statements].labelSectionLen;
        startSection = fbPtr + 1;
        if (type != lb_ && type != rb_) mode = 1;
        continue;
      default:
        if (mode == 0) {
          sourceError(fbPtr - 1, 2, g_statements, cat(
              "Expected \"$c\", \"$v\", \"$e\", \"$f\", \"$d\",",
              " \"$a\", \"$p\", \"${\", or \"$}\" here.",NULL));
          continue;
        }
        if (mode == 1) {
          if (type == p_ && fbPtr[0] != '=') {
            sourceError(fbPtr - 1, 2, g_statements,
                "Expected \"$=\" here.");
            if (fbPtr[0] == '.') {
              mode = 2; /* If $. switch mode to help reduce error msgs */
            }
          }
          if (type != p_ && fbPtr[0] != '.') {
            sourceError(fbPtr - 1, 2, g_statements,
                "Expected \"$.\" here.");
            continue;
          }
          /* Add math section to statement */
          g_Statement[g_statements].mathSectionPtr = startSection;
          g_Statement[g_statements].mathSectionLen = fbPtr - startSection - 1;
          startSection = fbPtr + 1;
          if (type == p_ && mode != 2 /* !error msg case */) {
            mode = 2; /* Switch mode to proof section */
          } else {
            mode = 0;
          }
          continue;
        } /* End if mode == 1 */
        if (mode == 2) {
          if (fbPtr[0] != '.') {
            sourceError(fbPtr - 1, 2, g_statements,
                "Expected \"$.\" here.");
            continue;
          }
          /* Add proof section to statement */
          g_Statement[g_statements].proofSectionPtr = startSection;
          g_Statement[g_statements].proofSectionLen = fbPtr - startSection - 1;
          startSection = fbPtr + 1;
          mode = 0;
          continue;
        } /* End if mode == 2 */
    } /* End switch fbPtr[0] */
  } /* End while */

  if (fbPtr != g_sourcePtr + g_sourceLen) bug(1706);

  /* Put chars after the last $. into the label section of a dummy statement */
  g_Statement[g_statements + 1].type = illegal_;
  g_Statement[g_statements + 1].labelSectionPtr = startSection;
  g_Statement[g_statements + 1].labelSectionLen = fbPtr - startSection;
  /* Point to last character of file in case we ever need lineNum/fileName */
  g_Statement[g_statements + 1].statementPtr = fbPtr - 1;

  /* Initialize the pink number to print after the statement labels
   in HTML output. */
  /* The pink number only counts $a and $p statements, unlike the statement
     number which also counts $f, $e, $c, $v, ${, $} */
  j = 0;
  k = 0;
  for (i = 1; i <= g_statements; i++) {
    if (g_Statement[i].type == a_ || g_Statement[i].type == p_) {

      /* Use the statement _after_ the previous $a or $p; that is the start
         of the "header area" for use by getSectionHeadings() in mmwtex.c.
         headerStartStmt will be equal to the current statement if the
         previous statement is also a $a or $p) */
      g_Statement[i].headerStartStmt = k + 1;
      k = i;

      j++;
      g_Statement[i].pinkNumber = j;
    }
  }
  /* Also, put the largest pink number in the last statement, no
     matter what it kind it is, so we can look up the largest number in
     pinkHTML() in mmwtex.c */
  g_Statement[g_statements].pinkNumber = j;

/*E*/if(db5){for (i=1; i<=g_statements; i++){
/*E*/  if (i == 5) { print2("(etc.)\n");} else { if (i<5) {
/*E*/  print2("Statement %ld: line %ld file %s.\n",i,g_Statement[i].lineNum,
/*E*/      g_Statement[i].fileName);
/*E*/}}}}
}

/* This function parses the label sections of the g_Statement[] structure array.
   g_sourcePtr is assumed to point to the beginning of the raw input buffer.
   g_sourceLen is assumed to be length of the raw input buffer. */
void parseLabels(void) {
  long i, j, k;
  char *fbPtr;
  char type;
  long stmt;
  flag dupFlag;

  /* Define the legal label characters */
  for (i = 0; i < 256; i++) {
    illegalLabelChar[i] = !isalnum(i);
  }
  illegalLabelChar['-'] = 0;
  illegalLabelChar['_'] = 0;
  illegalLabelChar['.'] = 0;

  /* Scan all statements and extract their labels */
  for (stmt = 1; stmt <= g_statements; stmt++) {
    type = g_Statement[stmt].type;
    fbPtr = g_Statement[stmt].labelSectionPtr;
    fbPtr = fbPtr + whiteSpaceLen(fbPtr);
    j = tokenLen(fbPtr);
    if (j) {
      for (k = 0; k < j; k++) {
        if (illegalLabelChar[(unsigned char)fbPtr[k]]) {
          sourceError(fbPtr + k, 1, stmt,
        "Only letters, digits, \"_\", \"-\", and \".\" are allowed in labels.");
          break;
        }
      }
      switch (type) {
        case d_:
        case rb_:
        case lb_:
        case v_:
        case c_:
          sourceError(fbPtr, j, stmt,
                "A label isn't allowed for this statement type.");
      }
      g_Statement[stmt].labelName = malloc((size_t)j + 1);
      if (!g_Statement[stmt].labelName) outOfMemory("#5 (label)");
      g_Statement[stmt].labelName[j] = 0;
      memcpy(g_Statement[stmt].labelName, fbPtr, (size_t)j);
      fbPtr = fbPtr + j;
      fbPtr = fbPtr + whiteSpaceLen(fbPtr);
      j = tokenLen(fbPtr);
      if (j) {
        sourceError(fbPtr, j, stmt,
            "A statement may have only one label.");
      }
    } else {
      switch (type) {
        case e_:
        case f_:
        case a_:
        case p_:
          sourceError(fbPtr, 2, stmt,
                "A label is required for this statement type.");
      }
    }
  } /* Next stmt */

  /* Make sure there is no token after the last statement */
  fbPtr = g_Statement[g_statements + 1].labelSectionPtr; /* Last (dummy) statement*/
  i = whiteSpaceLen(fbPtr);
  j = tokenLen(fbPtr + i);
  if (j) {
    sourceError(fbPtr + i, j, 0,
        "There should be no tokens after the last statement.");
  }

  /* Sort the labels for later lookup */
  g_labelKey = malloc(((size_t)g_statements + 1) * sizeof(long));
  if (!g_labelKey) outOfMemory("#6 (g_labelKey)");
  for (i = 1; i <= g_statements; i++) {
    g_labelKey[i] = i;
  }
  g_labelKeyBase = &g_labelKey[1];
  g_numLabelKeys = g_statements;
  qsort(g_labelKeyBase, (size_t)g_numLabelKeys, sizeof(long), labelSortCmp);

  /* Skip null labels. */
  for (i = 1; i <= g_statements; i++) {
    if (g_Statement[g_labelKey[i]].labelName[0]) break;
  }
  g_labelKeyBase = &g_labelKey[i];
  g_numLabelKeys = g_statements - i + 1;
/*E*/if(db5)print2("There are %ld non-empty labels.\n", g_numLabelKeys);
/*E*/if(db5){print2("The first (up to 5) sorted labels are:\n");
/*E*/  for (i=0; i<5; i++) {
/*E*/    if (i >= g_numLabelKeys) break;
/*E*/    print2("%s ",g_Statement[g_labelKeyBase[i]].labelName);
/*E*/  } print2("\n");}

  /* Copy the keys for all possible labels for lookup by the
     squishProof command when local labels are generated in packed proofs. */
  g_allLabelKeyBase = malloc((size_t)g_numLabelKeys * sizeof(long));
  if (!g_allLabelKeyBase) outOfMemory("#60 (g_allLabelKeyBase)");
  memcpy(g_allLabelKeyBase, g_labelKeyBase, (size_t)g_numLabelKeys * sizeof(long));
  g_numAllLabelKeys = g_numLabelKeys;

  /* Now back to the regular label stuff. */
  /* Check for duplicate labels */
  /* (This will go away if local labels on hypotheses are allowed.) */
  dupFlag = 0;
  for (i = 0; i < g_numLabelKeys; i++) {
    if (dupFlag) {
      /* This "if" condition causes only the 2nd in a pair of duplicate labels
         to have an error message. */
      dupFlag = 0;
      if (!strcmp(g_Statement[g_labelKeyBase[i]].labelName,
          g_Statement[g_labelKeyBase[i - 1]].labelName)) dupFlag = 1;
    }
    if (i < g_numLabelKeys - 1) {
      if (!strcmp(g_Statement[g_labelKeyBase[i]].labelName,
          g_Statement[g_labelKeyBase[i + 1]].labelName)) dupFlag = 1;
    }
    if (dupFlag) {
      fbPtr = g_Statement[g_labelKeyBase[i]].labelSectionPtr;
      k = whiteSpaceLen(fbPtr);
      j = tokenLen(fbPtr + k);
      sourceError(fbPtr + k, j, g_labelKeyBase[i],
         "This label is declared more than once.  All labels must be unique.");
    }
  }
}

/* This functions retrieves all possible math symbols from $c and $v
   statements. */
void parseMathDecl(void) {
  long potentialSymbols;
  long stmt;
  char *fbPtr;
  long i, j, k;
  char *tmpPtr;
  nmbrString *nmbrTmpPtr;
  long oldG_mathTokens;
  void *voidPtr; /* bsearch returned value */

  /* Find the upper limit of the number of symbols declared for
     pre-allocation:  at most, the number of symbols is half the number of
     characters, since $c and $v statements require white space. */
  potentialSymbols = 0;
  for (stmt = 1; stmt <= g_statements; stmt++) {
    switch (g_Statement[stmt].type) {
      case c_:
      case v_:
        potentialSymbols = potentialSymbols + g_Statement[stmt].mathSectionLen;
    }
  }
  potentialSymbols = (potentialSymbols / 2) + 2;
/*E*/if(db5)print2("%ld potential symbols were computed.\n",potentialSymbols);
  g_MathToken = realloc(g_MathToken, (size_t)potentialSymbols *
      sizeof(struct mathToken_struct));
  if (!g_MathToken) outOfMemory("#7 (g_MathToken)");

  /* Scan $c and $v statements to accumulate all possible math symbols */
  g_mathTokens = 0;
  for (stmt = 1; stmt <= g_statements; stmt++) {
    switch (g_Statement[stmt].type) {
      case c_:
      case v_:
        oldG_mathTokens = g_mathTokens;
        fbPtr = g_Statement[stmt].mathSectionPtr;
        while (1) {
          i = whiteSpaceLen(fbPtr);
          j = tokenLen(fbPtr + i);
          if (!j) break;
          tmpPtr = malloc((size_t)j + 1); /* Math symbol name */
          if (!tmpPtr) outOfMemory("#8 (symbol name)");
          tmpPtr[j] = 0; /* End of string */
          memcpy(tmpPtr, fbPtr + i, (size_t)j);
          fbPtr = fbPtr + i + j;
          /* Create a new math symbol */
          g_MathToken[g_mathTokens].tokenName = tmpPtr;
          g_MathToken[g_mathTokens].length = j;
          if (g_Statement[stmt].type == c_) {
            g_MathToken[g_mathTokens].tokenType = (char)con_;
          } else {
            g_MathToken[g_mathTokens].tokenType = (char)var_;
          }
          g_MathToken[g_mathTokens].active = 0;
          g_MathToken[g_mathTokens].scope = 0; /* Unknown for now */
          g_MathToken[g_mathTokens].tmp = 0; /* Not used for now */
          g_MathToken[g_mathTokens].statement = stmt;
          g_MathToken[g_mathTokens].endStatement = g_statements; /* Unknown for now */
                /* (Assign to 'g_statements' in case it's active until the end) */
          g_mathTokens++;
        }

        /* Create the symbol list for this statement */
        j = g_mathTokens - oldG_mathTokens; /* Number of tokens in this statement */
        nmbrTmpPtr = poolFixedMalloc((j + 1) * (long)(sizeof(nmbrString)));
        nmbrTmpPtr[j] = -1;
        for (i = 0; i < j; i++) {
          nmbrTmpPtr[i] = oldG_mathTokens + i;
        }
        g_Statement[stmt].mathString = nmbrTmpPtr;
        g_Statement[stmt].mathStringLen = j;
        if (!j) {
          sourceError(fbPtr, 2, stmt,
           "At least one math symbol should be declared.");
        }
    } /* end switch (g_Statement[stmt].type) */
  } /* next stmt */

/*E*/if(db5)print2("%ld math symbols were declared.\n",g_mathTokens);
  /* Reallocate from potential to actual to reduce memory space */
  /* Add 100 to allow for initial Proof Assistant use, and up to 100
     errors in undeclared token references */
  g_MAX_MATHTOKENS = g_mathTokens + 100;
  g_MathToken = realloc(g_MathToken, (size_t)g_MAX_MATHTOKENS *
      sizeof(struct mathToken_struct));
  if (!g_MathToken) outOfMemory("#10 (g_MathToken)");

  /* Create a special "$|$" boundary token to separate real and dummy ones */
  g_MathToken[g_mathTokens].tokenName = "";
  let(&g_MathToken[g_mathTokens].tokenName, "$|$");
  g_MathToken[g_mathTokens].length = 2; /* Never used */
  g_MathToken[g_mathTokens].tokenType = (char)con_;
  g_MathToken[g_mathTokens].active = 0; /* Never used */
  g_MathToken[g_mathTokens].scope = 0; /* Never used */
  g_MathToken[g_mathTokens].tmp = 0; /* Never used */
  g_MathToken[g_mathTokens].statement = 0; /* Never used */
  g_MathToken[g_mathTokens].endStatement = g_statements; /* Never used */

  /* Sort the math symbols for later lookup */
  g_mathKey = malloc((size_t)g_mathTokens * sizeof(long));
  if (!g_mathKey) outOfMemory("#11 (g_mathKey)");
  for (i = 0; i < g_mathTokens; i++) {
    g_mathKey[i] = i;
  }
  qsort(g_mathKey, (size_t)g_mathTokens, sizeof(long), mathSortCmp);
/*E*/if(db5){print2("The first (up to 5) sorted math tokens are:\n");
/*E*/  for (i=0; i<5; i++) {
/*E*/    if (i >= g_mathTokens) break;
/*E*/    print2("%s ",g_MathToken[g_mathKey[i]].tokenName);
/*E*/  } print2("\n");}

  /* Check for labels with the same name as math tokens */
  /* (This section implements the Metamath spec change proposed by O'Cat that
     lets labels and math tokens occupy the same namespace and thus forbids
     them from having common names.) */
  /* For maximum speed, we scan M math tokens and look each up in the list
     of L labels.  The we have M * log L comparisons, which is optimal when
     (as in most cases) M << L. */
  for (i = 0; i < g_mathTokens; i++) {
    /* See if the math token is in the list of labels */
    voidPtr = (void *)bsearch(g_MathToken[i].tokenName, g_labelKeyBase,
        (size_t)g_numLabelKeys, sizeof(long), labelSrchCmp);
    if (voidPtr) { /* A label matching the token was found */
      stmt = (*(long *)voidPtr); /* Statement number */
      fbPtr = g_Statement[stmt].labelSectionPtr;
      k = whiteSpaceLen(fbPtr);
      j = tokenLen(fbPtr + k);
      /* Note that the line and file are only assigned when requested,
         for speedup. */
      sourceError(fbPtr + k, j, stmt, cat(
         "This label has the same name as the math token declared on line ",
         str((double)(g_Statement[g_MathToken[i].statement].lineNum)),
         " of file \"",
         g_Statement[g_MathToken[i].statement].fileName,
         "\".", NULL));
    }
  }
}

/* This functions parses statement contents, except for proofs */
void parseStatements(void) {
  long stmt;
  char type;
  long i, j, k, m, n, p;
  char *fbPtr;
  long mathStringLen;
  long tokenNum;
  long lowerKey, upperKey;
  long symbolLen, origSymbolLen, mathSectionLen, g_mathKeyNum;
  void *g_mathKeyPtr; /* bsearch returned value */
  int maxScope;
  long reqHyps, optHyps, reqVars, optVars;
  flag reqFlag;
  int undeclErrorCount = 0;
  vstring_def(tmpStr);

  nmbrString *nmbrTmpPtr;

  long *mathTokenSameAs; /* Flag that symbol is unique (for speed up) */
  long *reverseMathKey; /* Map from g_mathTokens to g_mathKey */

  long *labelTokenSameAs; /* Flag that label is unique (for speed up) */
  long *reverseLabelKey; /* Map from statement # to label key */
  flag *labelActiveFlag; /* Flag that label is active */

  struct activeConstStack_struct {
    long tokenNum;
    int scope;
  };
  struct activeConstStack_struct *activeConstStack; /* Stack of active consts */
  long activeConstStackPtr = 0;

  struct activeVarStack_struct {
    long tokenNum;
    int scope;
    char tmpFlag; /* Used by hypothesis variable scan; must be 0 otherwise */
  };
  struct activeVarStack_struct *activeVarStack; /* Stack of active variables */
  nmbrString *wrkVarPtr1;
  nmbrString *wrkVarPtr2;
  long activeVarStackPtr = 0;

  struct activeEHypStack_struct { /* Stack of $e hypotheses */
    long statemNum;
    nmbrString *varList; /* List of variables in the hypothesis */
    int scope;
  };
  struct activeEHypStack_struct *activeEHypStack;
  long activeEHypStackPtr = 0;
  struct activeFHypStack_struct { /* Stack of $f hypotheses */
    long statemNum;
    nmbrString *varList; /* List of variables in the hypothesis */
    int scope;
  };
  struct activeFHypStack_struct *activeFHypStack;
  long activeFHypStackPtr = 0;
  nmbrString *wrkHypPtr1;
  nmbrString *wrkHypPtr2;
  nmbrString *wrkHypPtr3;
  long activeHypStackSize = 30; /* Starting value; could be as large as
                                   g_statements. */

  struct activeDisjHypStack_struct { /* Stack of disjoint variables in $d's */
    long tokenNumA; /* First variable in disjoint pair */
    long tokenNumB; /* Second variable in disjoint pair */
    long statemNum; /* Statement it occurred in */
    int scope;
  };
  struct activeDisjHypStack_struct *activeDisjHypStack;
  nmbrString *wrkDisjHPtr1A;
  nmbrString *wrkDisjHPtr1B;
  nmbrString *wrkDisjHPtr1Stmt;
  nmbrString *wrkDisjHPtr2A;
  nmbrString *wrkDisjHPtr2B;
  nmbrString *wrkDisjHPtr2Stmt;
  long activeDisjHypStackPtr = 0;
  long activeDisjHypStackSize = 30; /* Starting value; could be as large as
                                        about g_mathTokens^2/2 */

  /* Temporary working space */
  long wrkLen;
  nmbrString *wrkNmbrPtr;
  char *wrkStrPtr;

  long maxSymbolLen; /* Longest math symbol (for speedup) */
  flag *symbolLenExists; /* A symbol with this length exists (for speedup) */

  long beginScopeStmtNum = 0;

  /* Initialization to avoid compiler warning (should not be theoretically
     necessary) */
  mathStringLen = 0;
  tokenNum = 0;

  /* Initialize flags for g_mathKey array that identify math symbols as
     unique (when 0) or, if not unique, the flag is a number identifying a group
     of identical names */
  mathTokenSameAs = malloc((size_t)g_mathTokens * sizeof(long));
  if (!mathTokenSameAs) outOfMemory("#12 (mathTokenSameAs)");
  reverseMathKey = malloc((size_t)g_mathTokens * sizeof(long));
  if (!reverseMathKey) outOfMemory("#13 (reverseMathKey)");
  for (i = 0; i < g_mathTokens; i++) {
    mathTokenSameAs[i] = 0; /* 0 means unique */
    reverseMathKey[g_mathKey[i]] = i; /* Initialize reverse map to g_mathKey */
  }
  for (i = 1; i < g_mathTokens; i++) {
    if (!strcmp(g_MathToken[g_mathKey[i]].tokenName,
        g_MathToken[g_mathKey[i - 1]].tokenName)) {
      if (!mathTokenSameAs[i - 1]) mathTokenSameAs[i - 1] = i;
      mathTokenSameAs[i] = mathTokenSameAs[i - 1];
    }
  }

  /* Initialize flags for g_labelKey array that identify labels as
     unique (when 0) or, if not unique, the flag is a number identifying a group
     of identical names */
  labelTokenSameAs = malloc(((size_t)g_statements + 1) * sizeof(long));
  if (!labelTokenSameAs) outOfMemory("#112 (labelTokenSameAs)");
  reverseLabelKey = malloc(((size_t)g_statements + 1) * sizeof(long));
  if (!reverseLabelKey) outOfMemory("#113 (reverseLabelKey)");
  labelActiveFlag = malloc(((size_t)g_statements + 1) * sizeof(flag));
  if (!labelActiveFlag) outOfMemory("#114 (labelActiveFlag)");
  for (i = 1; i <= g_statements; i++) {
    labelTokenSameAs[i] = 0; /* Initialize:  0 = unique */
    reverseLabelKey[g_labelKey[i]] = i; /* Initialize reverse map to g_labelKey */
    labelActiveFlag[i] = 0; /* Initialize */
  }
  for (i = 2; i <= g_statements; i++) {
    if (!strcmp(g_Statement[g_labelKey[i]].labelName,
        g_Statement[g_labelKey[i - 1]].labelName)) {
      if (!labelTokenSameAs[i - 1]) labelTokenSameAs[i - 1] = i;
      labelTokenSameAs[i] = labelTokenSameAs[i - 1];
    }
  }

  /* Initialize variable and hypothesis stacks */

  /* Allocate g_MAX_MATHTOKENS and not just g_mathTokens of them so that
     they can accommodate any extra non-declared tokens (which get
     declared as part of error handling, where the g_MAX_MATHTOKENS
     limit is checked) */
  activeConstStack = malloc((size_t)g_MAX_MATHTOKENS
      * sizeof(struct activeConstStack_struct));
  activeVarStack = malloc((size_t)g_MAX_MATHTOKENS
      * sizeof(struct activeVarStack_struct));
  wrkVarPtr1 = malloc((size_t)g_MAX_MATHTOKENS * sizeof(nmbrString));
  wrkVarPtr2 = malloc((size_t)g_MAX_MATHTOKENS * sizeof(nmbrString));
  if (!activeConstStack || !activeVarStack || !wrkVarPtr1 || !wrkVarPtr2)
      outOfMemory("#14 (activeVarStack)");

  activeEHypStack = malloc((size_t)activeHypStackSize
      * sizeof(struct activeEHypStack_struct));
  activeFHypStack = malloc((size_t)activeHypStackSize
      * sizeof(struct activeFHypStack_struct));
  wrkHypPtr1 = malloc((size_t)activeHypStackSize * sizeof(nmbrString));
  wrkHypPtr2 = malloc((size_t)activeHypStackSize * sizeof(nmbrString));
  wrkHypPtr3 = malloc((size_t)activeHypStackSize * sizeof(nmbrString));
  if (!activeEHypStack || !activeFHypStack || !wrkHypPtr1 || !wrkHypPtr2 ||
      !wrkHypPtr3)
      outOfMemory("#15 (activeHypStack)");

  activeDisjHypStack = malloc((size_t)activeDisjHypStackSize *
      sizeof(struct activeDisjHypStack_struct));
  wrkDisjHPtr1A = malloc((size_t)activeDisjHypStackSize * sizeof(nmbrString));
  wrkDisjHPtr1B = malloc((size_t)activeDisjHypStackSize * sizeof(nmbrString));
  wrkDisjHPtr1Stmt = malloc((size_t)activeDisjHypStackSize
      * sizeof(nmbrString));
  wrkDisjHPtr2A = malloc((size_t)activeDisjHypStackSize * sizeof(nmbrString));
  wrkDisjHPtr2B = malloc((size_t)activeDisjHypStackSize * sizeof(nmbrString));
  wrkDisjHPtr2Stmt = malloc((size_t)activeDisjHypStackSize
      * sizeof(nmbrString));
  if (!activeDisjHypStack
      || !wrkDisjHPtr1A || !wrkDisjHPtr1B || !wrkDisjHPtr1Stmt
      || !wrkDisjHPtr2A || !wrkDisjHPtr2B || !wrkDisjHPtr2Stmt)
      outOfMemory("#27 (activeDisjHypStack)");

  /* Initialize temporary working space for parsing tokens */
  wrkLen = 1;
  wrkNmbrPtr = malloc((size_t)wrkLen * sizeof(nmbrString));
  if (!wrkNmbrPtr) outOfMemory("#22 (wrkNmbrPtr)");
  wrkStrPtr = malloc((size_t)wrkLen + 1);
  if (!wrkStrPtr) outOfMemory("#23 (wrkStrPtr)");

  /* Find declared math symbol lengths (used to speed up parsing) */
  maxSymbolLen = 0;
  for (i = 0; i < g_mathTokens; i++) {
    if (g_MathToken[i].length > maxSymbolLen) {
      maxSymbolLen = g_MathToken[i].length;
    }
  }
  symbolLenExists = malloc(((size_t)maxSymbolLen + 1) * sizeof(flag));
  if (!symbolLenExists) outOfMemory("#25 (symbolLenExists)");
  for (i = 0; i <= maxSymbolLen; i++) {
    symbolLenExists[i] = 0;
  }
  for (i = 0; i < g_mathTokens; i++) {
    symbolLenExists[g_MathToken[i].length] = 1;
  }

  g_currentScope = 0;
  beginScopeStmtNum = 0;

  /* Scan all statements.  Fill in statement structure and look for errors. */
  for (stmt = 1; stmt <= g_statements; stmt++) {

    g_Statement[stmt].beginScopeStatementNum = beginScopeStmtNum;
    /* endScopeStatementNum is always 0 except in ${ statements */
    g_Statement[stmt].endScopeStatementNum = 0;
    g_Statement[stmt].scope = g_currentScope;
    type = g_Statement[stmt].type;
    /******* Determine scope, stack active variables, process math strings ****/

    switch (type) {
      case lb_:
        g_currentScope++;
        if (g_currentScope > 32000) outOfMemory("#16 (more than 32000 \"${\"s)");
            /* Not really an out-of-memory situation, but use the error msg. */
        /* Note that g_Statement[stmt].beginScopeStatementNum for this ${
           points to the previous ${ (or 0 if in outermost scope) */
        beginScopeStmtNum = stmt;
        /* Note that g_Statement[stmt].endScopeStatementNum for this ${
           will be assigned in the rb_ case below. */
        break;
      case rb_:
        /* Remove all variables and hypotheses in current scope from stack */

        while (activeConstStackPtr) {
          if (activeConstStack[activeConstStackPtr - 1].scope < g_currentScope)
              break;
          activeConstStackPtr--;
          g_MathToken[activeConstStack[activeConstStackPtr].tokenNum].active = 0;
          g_MathToken[activeConstStack[activeConstStackPtr].tokenNum
              ].endStatement = stmt;
        }

        while (activeVarStackPtr) {
          if (activeVarStack[activeVarStackPtr - 1].scope < g_currentScope) break;
          activeVarStackPtr--;
          g_MathToken[activeVarStack[activeVarStackPtr].tokenNum].active = 0;
          g_MathToken[activeVarStack[activeVarStackPtr].tokenNum].endStatement
              = stmt;
        }

        while (activeEHypStackPtr) {
          if (activeEHypStack[activeEHypStackPtr - 1].scope < g_currentScope)
              break;
          activeEHypStackPtr--;
          labelActiveFlag[activeEHypStack[activeEHypStackPtr].statemNum] = 0;
                                                   /* Make the label inactive */
          free(activeEHypStack[activeEHypStackPtr].varList);
        }
        while (activeFHypStackPtr) {
          if (activeFHypStack[activeFHypStackPtr - 1].scope < g_currentScope)
              break;
          activeFHypStackPtr--;
          labelActiveFlag[activeFHypStack[activeFHypStackPtr].statemNum] = 0;
                                                   /* Make the label inactive */
          free(activeFHypStack[activeFHypStackPtr].varList);
        }
        while (activeDisjHypStackPtr) {
          if (activeDisjHypStack[activeDisjHypStackPtr - 1].scope
              < g_currentScope) break;
          activeDisjHypStackPtr--;
        }
        g_currentScope--;
        if (g_currentScope < 0) {
          sourceError(g_Statement[stmt].labelSectionPtr +
              g_Statement[stmt].labelSectionLen, 2, stmt,
              "Too many \"$}\"s at this point.");
        }

        if (beginScopeStmtNum > 0) { /* We're not in outermost scope
                  (precaution if there were too many $}'s) */
          if (g_Statement[beginScopeStmtNum].type != lb_) bug(1773);
          /* Populate the previous ${ with a pointer to this $} */
          g_Statement[beginScopeStmtNum].endScopeStatementNum = stmt;
          /* Update beginScopeStmtNum with start of outer scope */
          beginScopeStmtNum
              = g_Statement[beginScopeStmtNum].beginScopeStatementNum;
        }

        break;
      case c_:
      case v_:
        /* Scan all symbols declared (they have already been parsed) and
           flag them as active, add to stack, and check for errors */
        if (type == c_) {
          if (g_currentScope > 0) {
            sourceError(g_Statement[stmt].labelSectionPtr +
                g_Statement[stmt].labelSectionLen, 2, stmt,
        "A \"$c\" constant declaration may occur in the outermost scope only.");
          }
        }

        i = 0; /* Symbol position in mathString */
        nmbrTmpPtr = g_Statement[stmt].mathString;
        while (1) {
          tokenNum = nmbrTmpPtr[i];
          if (tokenNum == -1) break; /* Done scanning symbols in $v or $c */
          if (mathTokenSameAs[reverseMathKey[tokenNum]]) {
            /* The variable name is not unique.  Find out if there's a
               conflict with the others. */
            lowerKey = reverseMathKey[tokenNum];
            upperKey = lowerKey;
            j = mathTokenSameAs[lowerKey];
            while (lowerKey) {
              if (j != mathTokenSameAs[lowerKey - 1]) break;
              lowerKey--;
            }
            while (upperKey < g_mathTokens - 1) {
              if (j != mathTokenSameAs[upperKey + 1]) break;
              upperKey++;
            }
            for (j = lowerKey; j <= upperKey; j++) {
              if (g_MathToken[g_mathKey[j]].active) {
                /* Detect conflicting active vars declared
                   in multiple scopes */
              }
            }

            /* Make sure that no constant has the same name
               as a variable or vice-versa */
            k = 0; /* Flag for $c */
            m = 0; /* Flag for $v */
            for (j = lowerKey; j <= upperKey; j++) {
              if (g_MathToken[g_mathKey[j]].tokenType == (char)con_) k = 1;
              if (g_MathToken[g_mathKey[j]].tokenType == (char)var_) m = 1;
            }
          }

          /* Flag the token as active */
          g_MathToken[tokenNum].active = 1;
          g_MathToken[tokenNum].scope = g_currentScope;

          if (type == v_) {

            /* Identify this stack position in the g_MathToken array, for use
               by the hypothesis variable scan below */
            g_MathToken[tokenNum].tmp = activeVarStackPtr;

            /* Add the symbol to the stack */
            activeVarStack[activeVarStackPtr].tokenNum = tokenNum;
            activeVarStack[activeVarStackPtr].scope = g_currentScope;
            activeVarStack[activeVarStackPtr].tmpFlag = 0;
            activeVarStackPtr++;
          } else {

            /* Add the symbol to the stack */
            activeConstStack[activeConstStackPtr].tokenNum = tokenNum;
            activeConstStack[activeConstStackPtr].scope = g_currentScope;
            activeConstStackPtr++;
          }

          i++;
        }
        break;
      case d_:
      case f_:
      case e_:
      case a_:
      case p_:
        /* Make sure we have enough working space */
        mathSectionLen = g_Statement[stmt].mathSectionLen;
        if (wrkLen < mathSectionLen) {
          free(wrkNmbrPtr);
          free(wrkStrPtr);
          wrkLen = mathSectionLen + 100;
          wrkNmbrPtr = malloc((size_t)wrkLen * sizeof(nmbrString));
          if (!wrkNmbrPtr) outOfMemory("#20 (wrkNmbrPtr)");
          wrkStrPtr = malloc((size_t)wrkLen + 1);
          if (!wrkStrPtr) outOfMemory("#21 (wrkStrPtr)");
        }

        /* Scan the math section for tokens */
        mathStringLen = 0;
        fbPtr = g_Statement[stmt].mathSectionPtr;
        while (1) {
          fbPtr = fbPtr + whiteSpaceLen(fbPtr);
          origSymbolLen = tokenLen(fbPtr);
          if (!origSymbolLen) break; /* Done scanning source line */

          /* Scan for largest matching token from the left */
         nextAdjToken:
          /* don't allow missing white space */
          symbolLen = origSymbolLen;

          memcpy(wrkStrPtr, fbPtr, (size_t)symbolLen);

          /* ???Speed-up is possible by rewriting this now unnecessary code */
          for (; symbolLen > 0; symbolLen = 0) {

            /* symbolLenExists means a symbol of this length was declared */
            if (!symbolLenExists[symbolLen]) continue;
            wrkStrPtr[symbolLen] = 0; /* Define end of trial token to look up */
            g_mathKeyPtr = (void *)bsearch(wrkStrPtr, g_mathKey, (size_t)g_mathTokens,
                sizeof(long), mathSrchCmp);
            if (!g_mathKeyPtr) continue; /* Trial token was not declared */
            g_mathKeyNum = (long *)g_mathKeyPtr - g_mathKey; /* Pointer arithmetic! */
            if (mathTokenSameAs[g_mathKeyNum]) { /* Multiply-declared symbol */
            } else { /* The symbol was declared only once. */
              tokenNum = *((long *)g_mathKeyPtr);
                  /* Same as: tokenNum = g_mathKey[g_mathKeyNum]; but faster */
              if (!g_MathToken[tokenNum].active) {
                sourceError(fbPtr, symbolLen, stmt, "This math symbol is not active (i.e. was not declared in this scope).");
              }
            } /* End if multiply-defined symbol */
            break; /* The symbol was found, so we are done */
          } /* Next symbolLen */
          if (symbolLen == 0) { /* Symbol was not found */
            symbolLen = tokenLen(fbPtr);
            sourceError(fbPtr, symbolLen, stmt, "This math symbol was not declared (with a \"$c\" or \"$v\" statement).");
            g_MathToken[tokenNum].tokenName = "";
            let(&g_MathToken[tokenNum].tokenName, left(fbPtr,symbolLen));
            g_MathToken[tokenNum].length = symbolLen;
            g_MathToken[tokenNum].tokenType = (char)var_;
            /* Prevent stray pointers later */
            g_MathToken[tokenNum].tmp = 0; /* Location in active variable stack */
            if (!activeVarStackPtr) { /* Make a fictitious entry */
              activeVarStack[activeVarStackPtr].tokenNum = tokenNum;
              activeVarStack[activeVarStackPtr].scope = g_currentScope;
              activeVarStack[activeVarStackPtr].tmpFlag = 0;
              activeVarStackPtr++;
            }
          }

          if (type == d_) {
            if (g_MathToken[tokenNum].tokenType == (char)con_) {
              sourceError(fbPtr, symbolLen, stmt,
                  "Constant symbols are not allowed in a \"$d\" statement.");
            }
          } else {
            if (mathStringLen == 0) {
              if (g_MathToken[tokenNum].tokenType != (char)con_) {
                sourceError(fbPtr, symbolLen, stmt, cat(
                    "The first symbol must be a constant in a \"$",
                    chr(type), "\" statement.", NULL));
              }
            } else {
              if (type == f_) {
                if (mathStringLen == 1) {
                  if (g_MathToken[tokenNum].tokenType == (char)con_) {
                    sourceError(fbPtr, symbolLen, stmt,
                "The second symbol must be a variable in a \"$f\" statement.");
                  }
                } else {
                  if (mathStringLen == 2) {
                    sourceError(fbPtr, symbolLen, stmt,
               "There cannot be more than two symbols in a \"$f\" statement.");
                  }
                }
              }
            }
          }

          /* Add symbol to mathString */
          wrkNmbrPtr[mathStringLen] = tokenNum;
          mathStringLen++;
          fbPtr = fbPtr + symbolLen; /* Move on to next symbol */

          if (symbolLen < origSymbolLen) {
            /* This symbol is not separated from next by white space */
            /* Speed-up: don't call tokenLen again; just jump past it */
            origSymbolLen = origSymbolLen - symbolLen;
            goto nextAdjToken; /* (Instead of continue) */
          }
        } /* End while */

        if (type == d_) {
          if (mathStringLen < 2) {
            sourceError(fbPtr, 2, stmt,
                "A \"$d\" statement requires at least two variable symbols.");
          }
        } else {
          if (!mathStringLen) {
            sourceError(fbPtr, 2, stmt,
                "This statement type requires at least one math symbol.");
          } else {
            if (type == f_ && mathStringLen < 2) {
              sourceError(fbPtr, 2, stmt,
                  "A \"$f\" statement requires two math symbols.");
            }
          }
        }

        /* Assign mathString to statement array */
        nmbrTmpPtr = poolFixedMalloc(
            (mathStringLen + 1) * (long)(sizeof(nmbrString)));
        for (i = 0; i < mathStringLen; i++) {
          nmbrTmpPtr[i] = wrkNmbrPtr[i];
        }
        nmbrTmpPtr[mathStringLen] = -1;
        g_Statement[stmt].mathString = nmbrTmpPtr;
        g_Statement[stmt].mathStringLen = mathStringLen;
/*E*/if(db5){if(stmt<5)print2("Statement %ld mathString: %s.\n",stmt,
/*E*/  nmbrCvtMToVString(nmbrTmpPtr)); if(stmt==5)print2("(etc.)\n");}

        break;  /* Switch case break */
      default:
        bug(1707);
    } /* End switch */

    /****** Process hypothesis and variable stacks *******/
    /* (The switch section above does not depend on what is done in this
       section, although this section assumes the above section has been done.
       Variables valid only in this pass of the above section are so
       indicated.) */

    switch (type) {
      case f_:
      case e_:
      case a_:
      case p_:
        /* Flag the label as active */
        labelActiveFlag[stmt] = 1;
    } /* End switch */

    switch (type) {
      case d_:

        nmbrTmpPtr = g_Statement[stmt].mathString;
        /* Stack all possible pairs of disjoint variables */
        for (i = 0; i < mathStringLen - 1; i++) { /* mathStringLen is from the
             above switch section; it is valid only in this pass of the above
             section. */
          p = nmbrTmpPtr[i];
          for (j = i + 1; j < mathStringLen; j++) {
            n = nmbrTmpPtr[j];
            /* Get the disjoint variable pair m and n, sorted by tokenNum */
            if (p < n) {
              m = p;
            } else {
              if (p > n) {
                /* Swap them */
                m = n;
                n = p;
              } else {
                break;
              }
            }
            /* See if this pair of disjoint variables is already on the stack;
               if so, don't add it again */
            for (k = 0; k < activeDisjHypStackPtr; k++) {
              if (m == activeDisjHypStack[k].tokenNumA)
                if (n == activeDisjHypStack[k].tokenNumB)
                  break; /* It matches */
            }
            if (k == activeDisjHypStackPtr) {
              /* It wasn't already on the stack, so add it. */
              /* Increase stack size if necessary */
              if (activeDisjHypStackPtr >= activeDisjHypStackSize) {
                free(wrkDisjHPtr1A);
                free(wrkDisjHPtr1B);
                free(wrkDisjHPtr1Stmt);
                free(wrkDisjHPtr2A);
                free(wrkDisjHPtr2B);
                free(wrkDisjHPtr2Stmt);
                activeDisjHypStackSize = activeDisjHypStackSize + 100;
                activeDisjHypStack = realloc(activeDisjHypStack,
                    (size_t)activeDisjHypStackSize
                    * sizeof(struct activeDisjHypStack_struct));
                wrkDisjHPtr1A = malloc((size_t)activeDisjHypStackSize
                    * sizeof(nmbrString));
                wrkDisjHPtr1B = malloc((size_t)activeDisjHypStackSize
                    * sizeof(nmbrString));
                wrkDisjHPtr1Stmt = malloc((size_t)activeDisjHypStackSize
                    * sizeof(nmbrString));
                wrkDisjHPtr2A = malloc((size_t)activeDisjHypStackSize
                    * sizeof(nmbrString));
                wrkDisjHPtr2B = malloc((size_t)activeDisjHypStackSize
                    * sizeof(nmbrString));
                wrkDisjHPtr2Stmt = malloc((size_t)activeDisjHypStackSize
                    * sizeof(nmbrString));
                if (!activeDisjHypStack
                    || !wrkDisjHPtr1A || !wrkDisjHPtr1B || !wrkDisjHPtr1Stmt
                    || !wrkDisjHPtr2A || !wrkDisjHPtr2B || !wrkDisjHPtr2Stmt)
                    outOfMemory("#28 (activeDisjHypStack)");
              }
              activeDisjHypStack[activeDisjHypStackPtr].tokenNumA = m;
              activeDisjHypStack[activeDisjHypStackPtr].tokenNumB = n;
              activeDisjHypStack[activeDisjHypStackPtr].scope = g_currentScope;
              activeDisjHypStack[activeDisjHypStackPtr].statemNum = stmt;

              activeDisjHypStackPtr++;
            }
          } /* Next j */
        } /* Next i */

        break; /* Switch case break */

      case f_:
      case e_:

        /* Increase stack size if necessary */
        /* For convenience, we will keep the size greater than the sum of
           active $e and $f hypotheses, as this is the size needed for the
           wrkHypPtr's, even though it wastes (temporary) memory for the
           activeE and activeF structure arrays. */
        if (activeEHypStackPtr + activeFHypStackPtr >= activeHypStackSize) {
          free(wrkHypPtr1);
          free(wrkHypPtr2);
          free(wrkHypPtr3);
          activeHypStackSize = activeHypStackSize + 100;
          activeEHypStack = realloc(activeEHypStack, (size_t)activeHypStackSize
              * sizeof(struct activeEHypStack_struct));
          activeFHypStack = realloc(activeFHypStack, (size_t)activeHypStackSize
              * sizeof(struct activeFHypStack_struct));
          wrkHypPtr1 = malloc((size_t)activeHypStackSize * sizeof(nmbrString));
          wrkHypPtr2 = malloc((size_t)activeHypStackSize * sizeof(nmbrString));
          wrkHypPtr3 = malloc((size_t)activeHypStackSize * sizeof(nmbrString));
          if (!activeEHypStack || !activeFHypStack || !wrkHypPtr1 ||
              !wrkHypPtr2 || !wrkHypPtr3) outOfMemory("#32 (activeHypStack)");
        }

        /* Add the hypothesis to the stack */
        if (type == e_) {
          activeEHypStack[activeEHypStackPtr].statemNum = stmt;
          activeEHypStack[activeEHypStackPtr].scope = g_currentScope;
        } else {
          activeFHypStack[activeFHypStackPtr].statemNum = stmt;
          activeFHypStack[activeFHypStackPtr].scope = g_currentScope;
        }

        /* Create the list of variables used by this hypothesis */
        reqVars = 0;
        j = 0;
        nmbrTmpPtr = g_Statement[stmt].mathString;
        k = nmbrTmpPtr[j]; /* Math symbol number */
        while (k != -1) {
          if (g_MathToken[k].tokenType == (char)var_) {
            if (!activeVarStack[g_MathToken[k].tmp].tmpFlag) {
              /* Variable has not been already added to list */
              wrkVarPtr1[reqVars] = k;
              reqVars++;
              activeVarStack[g_MathToken[k].tmp].tmpFlag = 1;
            }
          }
          j++;
          k = nmbrTmpPtr[j];
        }
        nmbrTmpPtr = malloc(((size_t)reqVars + 1) * sizeof(nmbrString));
        if (!nmbrTmpPtr) outOfMemory("#32 (hypothesis variables)");
        memcpy(nmbrTmpPtr, wrkVarPtr1, (size_t)reqVars * sizeof(nmbrString));
        nmbrTmpPtr[reqVars] = -1;
        /* Clear the variable flags for future re-use */
        for (i = 0; i < reqVars; i++) {
          activeVarStack[g_MathToken[nmbrTmpPtr[i]].tmp].tmpFlag = 0;
        }

        if (type == e_) {
          activeEHypStack[activeEHypStackPtr].varList = nmbrTmpPtr;
          activeEHypStackPtr++;
        } else {
          activeFHypStack[activeFHypStackPtr].varList = nmbrTmpPtr;
          activeFHypStackPtr++;
        }

        break;  /* Switch case break */

      case a_:
      case p_:

        /* Scan this statement for required variables */
        reqVars = 0;
        j = 0;
        nmbrTmpPtr = g_Statement[stmt].mathString;
        k = nmbrTmpPtr[j]; /* Math symbol number */
        while (k != -1) {
          if (g_MathToken[k].tokenType == (char)var_) {
            if (!activeVarStack[g_MathToken[k].tmp].tmpFlag) {
              /* Variable has not been already added to list */
              wrkVarPtr1[reqVars] = k;
              reqVars++;
              activeVarStack[g_MathToken[k].tmp].tmpFlag = 2;
                       /* 2 means it's an original variable in the assertion */
                       /* (For error-checking) */
            }
          }
          j++;
          k = nmbrTmpPtr[j];
        }

        /* Scan $e stack for required variables and required hypotheses */
        for (i = 0; i < activeEHypStackPtr; i++) {

          /* Add $e hypotheses to required list */
          wrkHypPtr1[i] = activeEHypStack[i].statemNum;

          /* Add the $e's variables to required variable list */
          nmbrTmpPtr = activeEHypStack[i].varList;
          j = 0; /* Location in variable list */
          k = nmbrTmpPtr[j]; /* Symbol number of variable */
          while (k != -1) {
            if (!activeVarStack[g_MathToken[k].tmp].tmpFlag) {
              /* Variable has not been already added to list */
              wrkVarPtr1[reqVars] = k;
              reqVars++;
            }
            activeVarStack[g_MathToken[k].tmp].tmpFlag = 1;
                            /* Could have been 0 or 2; 1 = in some hypothesis */
            j++;
            k = nmbrTmpPtr[j];
          }
        }

        reqHyps = activeEHypStackPtr; /* The number of required hyp's so far */

        /* We have finished determining required variables, so allocate the
           permanent list for the statement array */
        nmbrTmpPtr = poolFixedMalloc((reqVars + 1)
            * (long)(sizeof(nmbrString)));
        /* if (!nmbrTmpPtr) outOfMemory("#30 (reqVars)"); */
                                              /* Not necessary w/ poolMalloc */
        memcpy(nmbrTmpPtr, wrkVarPtr1, (size_t)reqVars * sizeof(nmbrString));
        nmbrTmpPtr[reqVars] = -1;
        g_Statement[stmt].reqVarList = nmbrTmpPtr;

        /* Scan the list of $f hypotheses to find those that are required */
        optHyps = 0;
        for (i = 0; i < activeFHypStackPtr; i++) {
          nmbrTmpPtr = activeFHypStack[i].varList; /* Variable list */
          tokenNum = nmbrTmpPtr[0];
          if (tokenNum == -1) {
            /* Default if no variables (an error in current version): */
            /* Add it to list of required hypotheses */
            wrkHypPtr1[reqHyps] = activeFHypStack[i].statemNum;
            reqHyps++;
            continue;
          } else {
            reqFlag = activeVarStack[g_MathToken[tokenNum].tmp].tmpFlag;
          }
          if (reqFlag) {
            /* Add it to list of required hypotheses */
            wrkHypPtr1[reqHyps] = activeFHypStack[i].statemNum;
            reqHyps++;
            reqFlag = 1;
            activeVarStack[g_MathToken[tokenNum].tmp].tmpFlag = 1;
                                /* Could have been 2; 1 = in some hypothesis */
          } else {
            /* Add it to list of optional hypotheses */
            wrkHypPtr2[optHyps] = activeFHypStack[i].statemNum;
            optHyps++;
          }

          /* Scan the other variables in the $f hyp to check for conflicts. */
          j = 1;
          tokenNum = nmbrTmpPtr[1];
          while (tokenNum != -1) {
            if (activeVarStack[g_MathToken[tokenNum].tmp].tmpFlag == 2) {
              activeVarStack[g_MathToken[tokenNum].tmp].tmpFlag = 1;
                                /* 2 = in $p; 1 = in some hypothesis */
            }
            if (reqFlag != activeVarStack[g_MathToken[tokenNum].tmp].tmpFlag) {
              k = activeFHypStack[i].statemNum;
              m = nmbrElementIn(1, g_Statement[k].mathString, tokenNum);
              n = nmbrTmpPtr[0];
              break;
            } /* End if */
            j++;
            tokenNum = nmbrTmpPtr[j];
          } /* End while */
        } /* Next i */

        /* Error check:  make sure that all variables in the original statement
           appeared in some hypothesis */
        j = 0;
        nmbrTmpPtr = g_Statement[stmt].mathString;
        k = nmbrTmpPtr[j]; /* Math symbol number */
        while (k != -1) {
          if (g_MathToken[k].tokenType == (char)var_) {
            if (activeVarStack[g_MathToken[k].tmp].tmpFlag == 2) {
              /* The variable did not appear in any hypothesis */
              activeVarStack[g_MathToken[k].tmp].tmpFlag = 1; /* One msg per var*/
            }
          }
          j++;
          k = nmbrTmpPtr[j];
        }

        /* We have finished determining required $e & $f hyps, so allocate the
           permanent list for the statement array */
        /* First, sort the required hypotheses by statement number order
           into wrkHypPtr3 */
        i = 0; /* Start of $e's in wrkHypPtr1 */
        j = activeEHypStackPtr; /* Start of $f's in wrkHypPtr1 */
        for (k = 0; k < reqHyps; k++) {
          if (i >= activeEHypStackPtr) {
            wrkHypPtr3[k] = wrkHypPtr1[j];
            j++;
            continue;
          }
          if (j >= reqHyps) {
            wrkHypPtr3[k] = wrkHypPtr1[i];
            i++;
            continue;
          }
          if (wrkHypPtr1[i] > wrkHypPtr1[j]) {
            wrkHypPtr3[k] = wrkHypPtr1[j];
            j++;
          } else {
            wrkHypPtr3[k] = wrkHypPtr1[i];
            i++;
          }
        }

        /* Now do the allocation */
        nmbrTmpPtr = poolFixedMalloc((reqHyps + 1)
            * (long)(sizeof(nmbrString)));
        /* if (!nmbrTmpPtr) outOfMemory("#33 (reqHyps)"); */
                                       /* Not necessary w/ poolMalloc */
        memcpy(nmbrTmpPtr, wrkHypPtr3, (size_t)reqHyps * sizeof(nmbrString));
        nmbrTmpPtr[reqHyps] = -1;
        g_Statement[stmt].reqHypList = nmbrTmpPtr;
        g_Statement[stmt].numReqHyp = reqHyps;

        /* We have finished determining optional $f hyps, so allocate the
           permanent list for the statement array */
        if (type == p_) { /* Optional ones are not used by $a statements */
          nmbrTmpPtr = poolFixedMalloc((optHyps + 1)
              * (long)(sizeof(nmbrString)));
          memcpy(nmbrTmpPtr, wrkHypPtr2, (size_t)optHyps * sizeof(nmbrString));
          nmbrTmpPtr[optHyps] = -1;
          g_Statement[stmt].optHypList = nmbrTmpPtr;
        }

        /* Scan the list of disjoint variable ($d) hypotheses to find those
           that are required */
        optHyps = 0;
        reqHyps = 0;
        for (i = 0; i < activeDisjHypStackPtr; i++) {
          m = activeDisjHypStack[i].tokenNumA; /* First var in disjoint pair */
          n = activeDisjHypStack[i].tokenNumB; /* 2nd var in disjoint pair */
          if (activeVarStack[g_MathToken[m].tmp].tmpFlag &&
              activeVarStack[g_MathToken[n].tmp].tmpFlag) {
            /* Both variables in the disjoint pair are required, so put the
               disjoint hypothesis in the required list. */
            wrkDisjHPtr1A[reqHyps] = m;
            wrkDisjHPtr1B[reqHyps] = n;
            wrkDisjHPtr1Stmt[reqHyps] =
                activeDisjHypStack[i].statemNum;
            reqHyps++;
          } else {
            /* At least one variable is not required, so the disjoint hypothesis\
               is not required. */
            wrkDisjHPtr2A[optHyps] = m;
            wrkDisjHPtr2B[optHyps] = n;
            wrkDisjHPtr2Stmt[optHyps] =
                activeDisjHypStack[i].statemNum;
            optHyps++;
          }
        }

        /* We have finished determining required $d hyps, so allocate the
           permanent list for the statement array */

        nmbrTmpPtr = poolFixedMalloc((reqHyps + 1)
            * (long)(sizeof(nmbrString)));
        memcpy(nmbrTmpPtr, wrkDisjHPtr1A, (size_t)reqHyps
            * sizeof(nmbrString));
        nmbrTmpPtr[reqHyps] = -1;
        g_Statement[stmt].reqDisjVarsA = nmbrTmpPtr;

        nmbrTmpPtr = poolFixedMalloc((reqHyps + 1)
            * (long)(sizeof(nmbrString)));
        memcpy(nmbrTmpPtr, wrkDisjHPtr1B, (size_t)reqHyps
            * sizeof(nmbrString));
        nmbrTmpPtr[reqHyps] = -1;
        g_Statement[stmt].reqDisjVarsB = nmbrTmpPtr;

        nmbrTmpPtr = poolFixedMalloc((reqHyps + 1)
            * (long)(sizeof(nmbrString)));
        memcpy(nmbrTmpPtr, wrkDisjHPtr1Stmt, (size_t)reqHyps
            * sizeof(nmbrString));
        nmbrTmpPtr[reqHyps] = -1;
        g_Statement[stmt].reqDisjVarsStmt = nmbrTmpPtr;

        /* We have finished determining optional $d hyps, so allocate the
           permanent list for the statement array */

        if (type == p_) { /* Optional ones are not used by $a statements */

          nmbrTmpPtr = poolFixedMalloc((optHyps + 1)
              * (long)(sizeof(nmbrString)));
          memcpy(nmbrTmpPtr, wrkDisjHPtr2A, (size_t)optHyps
              * sizeof(nmbrString));
          nmbrTmpPtr[optHyps] = -1;
          g_Statement[stmt].optDisjVarsA = nmbrTmpPtr;

          nmbrTmpPtr = poolFixedMalloc((optHyps + 1)
              * (long)(sizeof(nmbrString)));
          memcpy(nmbrTmpPtr, wrkDisjHPtr2B, (size_t)optHyps
              * sizeof(nmbrString));
          nmbrTmpPtr[optHyps] = -1;
          g_Statement[stmt].optDisjVarsB = nmbrTmpPtr;

          nmbrTmpPtr = poolFixedMalloc((optHyps + 1)
              * (long)(sizeof(nmbrString)));
          memcpy(nmbrTmpPtr, wrkDisjHPtr2Stmt, (size_t)optHyps
              * sizeof(nmbrString));
          nmbrTmpPtr[optHyps] = -1;
          g_Statement[stmt].optDisjVarsStmt = nmbrTmpPtr;
        }

        /* Create list of optional variables (i.e. active but not required) */
        optVars = 0;
        for (i = 0; i < activeVarStackPtr; i++) {
          if (activeVarStack[i].tmpFlag) {
            activeVarStack[i].tmpFlag = 0; /* Clear it for future use */
          } else {
            wrkVarPtr2[optVars] = activeVarStack[i].tokenNum;
            optVars++;
          }
        }
        /* We have finished determining optional variables, so allocate the
           permanent list for the statement array */
        if (type == p_) { /* Optional ones are not used by $a statements */
          nmbrTmpPtr = poolFixedMalloc((optVars + 1)
              * (long)(sizeof(nmbrString)));
          memcpy(nmbrTmpPtr, wrkVarPtr2, (size_t)optVars * sizeof(nmbrString));
          nmbrTmpPtr[optVars] = -1;
          g_Statement[stmt].optVarList = nmbrTmpPtr;
        }

        if (optVars + reqVars != activeVarStackPtr) bug(1708);

        break;  /* Switch case break */
    }

    /* If a $a statement consists of a single constant,
       e.g. "$a wff $.", it means an empty expression (wff) is allowed.
       Before the user had to allow this manually with
       SET EMPTY_SUBSTITUTION ON; now it is done automatically. */
    type = g_Statement[stmt].type;

    /* Ensure the current Metamath spec is met:  "There may
       not be be two active $f statements containing the same variable.  Each
       variable in a $e, $a, or $p statement must exist in an active $f
       statement."  (Metamath book, p. 94) */
    /* This section of code is stand-alone and may be removed without side
       effects (other than less stringent error checking). */
    /* ??? To do (maybe):  This might be better placed in-line with the scan
       above, for faster speed and to get the pointer to the token for the
       error message, but it would require a careful code analysis above. */
    if (type == a_ || type == p_) {
      /* Scan each hypothesis (and the statement itself in last pass) */
      reqHyps = nmbrLen(g_Statement[stmt].reqHypList);
      for (i = 0; i <= reqHyps; i++) {
        if (i < reqHyps) {
          m = (g_Statement[stmt].reqHypList)[i];
        } else {
          m = stmt;
        }
        if (g_Statement[m].type != f_) { /* Check $e,$a,$p */
          /* This block implements: "Each variable in a $e, $a, or $p
             statement must exist in an active $f statement" (Metamath
             book p. 94). */
          nmbrTmpPtr = g_Statement[m].mathString;
          /* Scan all the vars in the $e (i<reqHyps) or $a/$p (i=reqHyps) */
          for (j = 0; j < g_Statement[m].mathStringLen; j++) {
            tokenNum = nmbrTmpPtr[j];
            if (g_MathToken[tokenNum].tokenType == (char)con_) continue;
                                            /* Ignore constants */
            p = 0;  /* Initialize flag that we found a $f with the variable */
            /* Scan all the mandatory $f's before this $e,$a,$p */
            for (k = 0; k < i; k++) {
              n = (g_Statement[stmt].reqHypList)[k];
              if (g_Statement[n].type != f_) continue; /* Only check $f */
              if (g_Statement[n].mathStringLen != 2) continue; /* This was
                  already verified earlier; but if there was an error, don't
                  cause memory violation by going out of bounds */
              if ((g_Statement[n].mathString)[1] == tokenNum) {
                p = 1;  /* Set flag that we found a $f with the variable */
                break;
              }
            } /* next k ($f hyp scan) */
            if (!p) {
              sourceError(g_Statement[m].mathSectionPtr/*fbPtr*/,
                  0/*tokenLen*/,
                  m/*stmt*/, cat(
                  "The variable \"", g_MathToken[tokenNum].tokenName,
                  "\" does not appear in an active \"$f\" statement.", NULL));
            }
          } /* next j (variable scan) */
        } else { /* g_Statement[m].type == f_ */
          /* This block implements: "There may not be be two active $f
             statements containing the same variable" (Metamath book p. 94). */
          /* Check for duplicate vars in active $f's */
          if (g_Statement[m].mathStringLen != 2) continue;  /* This was
                  already verified earlier; but if there was an error, don't
                  cause memory violation by going out of bounds */
          tokenNum = (g_Statement[m].mathString)[1];
          /* Scan all the mandatory $f's before this $f */
          for (k = 0; k < i; k++) {
            n = (g_Statement[stmt].reqHypList)[k];
            if (g_Statement[n].type != f_) continue; /* Only check $f */
            if (g_Statement[n].mathStringLen != 2) continue;  /* This was
                  already verified earlier; but if there was an error, don't
                  cause memory violation by going out of bounds */
            if ((g_Statement[n].mathString)[1] == tokenNum) {
              /* We found 2 $f's with the same variable */
              sourceError(g_Statement[m].mathSectionPtr/*fbPtr*/,
                  0/*tokenLen*/,
                  m/*stmt*/, cat(
                  "The variable \"", g_MathToken[tokenNum].tokenName,
                "\" already appears in the earlier active \"$f\" statement \"",
                  g_Statement[n].labelName, "\" on line ",
                  str((double)(g_Statement[n].lineNum)),
                  " in file \"",
                  g_Statement[n].fileName,
                  "\".", NULL));
              break; /* Optional: suppresses add'l error msgs for this stmt */
            }
          } /* next k ($f hyp scan) */
        } /* if not $f else is $f */
      } /* next i ($e hyp scan of this statement, or its $a/$p) */
    } /* if stmt is $a or $p */
  } /* Next stmt */

  if (g_currentScope > 0) {
    if (g_currentScope == 1) {
      let(&tmpStr,"A \"$}\" is");
    } else {
      let(&tmpStr,cat(str((double)g_currentScope)," \"$}\"s are",NULL));
    }
    sourceError(g_Statement[g_statements].labelSectionPtr +
        g_Statement[g_statements].labelSectionLen, 2, 0,
        cat(tmpStr," missing at the end of the file.",NULL));
  }

  /* Filter out all hypothesis labels from the label key array.  We do not
     need them anymore, since they are stored locally in each statement
     structure.  Removing them will speed up lookups during proofs, and
     will prevent a lookup from finding an inactive hypothesis label (thus
     forcing an error message). */
  j = 0;
/*E*/if(db5)print2("Number of label keys before filter: %ld",g_numLabelKeys);
  for (i = 0; i < g_numLabelKeys; i++) {
    type = g_Statement[g_labelKeyBase[i]].type;
    if (type == e_ || type == f_) {
      j++;
    } else {
      g_labelKeyBase[i - j] = g_labelKeyBase[i];
    }
  }
  g_numLabelKeys = g_numLabelKeys - j;
/*E*/if(db5)print2(".  After: %ld\n",g_numLabelKeys);

  /* Deallocate temporary space */
  free(mathTokenSameAs);
  free(reverseMathKey);
  free(labelTokenSameAs);
  free(reverseLabelKey);
  free(labelActiveFlag);
  free(activeConstStack);
  free(activeVarStack);
  free(wrkVarPtr1);
  free(wrkVarPtr2);
  for (i = 0; i < activeEHypStackPtr; i++) {
    free(activeEHypStack[i].varList);
  }
  free(activeEHypStack);
  for (i = 0; i < activeFHypStackPtr; i++) {
    free(activeFHypStack[i].varList);
  }
  free(activeFHypStack);
  free(wrkHypPtr1);
  free(wrkHypPtr2);
  free(wrkHypPtr3);
  free(activeDisjHypStack);
  free(wrkDisjHPtr1A);
  free(wrkDisjHPtr1B);
  free(wrkDisjHPtr1Stmt);
  free(wrkDisjHPtr2A);
  free(wrkDisjHPtr2B);
  free(wrkDisjHPtr2Stmt);
  free(wrkNmbrPtr);
  free(wrkStrPtr);
  free(symbolLenExists);
  free_vstring(tmpStr);
}

/* Parse proof of one statement in source file.  Uses g_WrkProof structure. */
/* Returns 0 if OK; returns 1 if proof is incomplete (is empty or has '?'
   tokens);  returns 2 if error found; returns 3 if severe error found
   (e.g. RPN stack violation); returns 4 if not a $p statement */
char parseProof(long statemNum)
{

  long i, j, k, m, tok, step;
  char *fbPtr;
  long tokLength;
  long numReqHyp;
  long numOptHyp;
  long numActiveHyp;
  char zapSave;
  flag labelFlag;
  char returnFlag = 0;
  nmbrString *nmbrTmpPtr;
  void *voidPtr; /* bsearch returned value */
  vstring tmpStrPtr;

  flag explicitTargets = 0; /* Proof is of form <target>=<source> */
  /* Source file pointers and token sizes for targets in a /EXPLICIT proof */
  pntrString_def(targetPntr); /* Pointers to target tokens */
  nmbrString_def(targetNmbr); /* Size of target tokens */
  /* Variables for rearranging /EXPLICIT proof */
  nmbrString_def(wrkProofString); /* Holds g_WrkProof.proofString */
  long hypStepNum, hypSubProofLen = 0, conclSubProofLen = 0;
  long matchingHyp;
  nmbrString_def(oldStepNums); /* Just numbers 0 to numSteps-1 */
  pntrString_def(reqHypSubProof); /* Subproofs of hypotheses */
  pntrString_def(reqHypOldStepNums); /* Local label flag for
                                                     subproofs of hypotheses */
  nmbrString_def(rearrangedSubProofs);
  nmbrString_def(rearrangedOldStepNums);
  flag subProofMoved; /* Flag to restart scan after moving subproof */

  if (g_Statement[statemNum].type != p_) {
    bug(1723); /* should never get here */
    g_WrkProof.errorSeverity = 4;
    return 4; /* Do nothing if not $p */
  }
  fbPtr = g_Statement[statemNum].proofSectionPtr; /* Start of proof section */
  if (fbPtr[0] == 0) { /* The proof was never assigned (could be a $p statement
                          with no $=; this would have been detected earlier) */
    g_WrkProof.errorSeverity = 4;
    return 4; /* Pretend it's an empty proof */
  }
  fbPtr = fbPtr + whiteSpaceLen(fbPtr);
  if (fbPtr[0] == '(') { /* "(" is flag for compressed proof */
    g_WrkProof.errorSeverity = parseCompressedProof(statemNum);
    return (g_WrkProof.errorSeverity);
  }

  /* Make sure we have enough working space to hold the proof */
  /* The worst case is less than the number of chars in the source,
     plus the number of active hypotheses */

  numOptHyp = nmbrLen(g_Statement[statemNum].optHypList);
  if (g_Statement[statemNum].proofSectionLen + g_Statement[statemNum].numReqHyp
      + numOptHyp > g_wrkProofMaxSize) {
    if (g_wrkProofMaxSize) { /* Not the first allocation */
      free(g_WrkProof.tokenSrcPtrNmbr);
      free(g_WrkProof.tokenSrcPtrPntr);
      free(g_WrkProof.stepSrcPtrNmbr);
      free(g_WrkProof.stepSrcPtrPntr);
      free(g_WrkProof.localLabelFlag);
      free(g_WrkProof.hypAndLocLabel);
      free(g_WrkProof.localLabelPool);
      poolFree(g_WrkProof.proofString);
      free(g_WrkProof.mathStringPtrs);
      free(g_WrkProof.RPNStack);
      free(g_WrkProof.compressedPfLabelMap);
    }
    g_wrkProofMaxSize = g_Statement[statemNum].proofSectionLen
        + g_Statement[statemNum].numReqHyp + numOptHyp
        + 2; /* 2 is minimum for 1-step proof; the other terms could
                all be 0 */
    g_WrkProof.tokenSrcPtrNmbr = malloc((size_t)g_wrkProofMaxSize
        * sizeof(nmbrString));
    g_WrkProof.tokenSrcPtrPntr = malloc((size_t)g_wrkProofMaxSize
        * sizeof(pntrString));
    g_WrkProof.stepSrcPtrNmbr = malloc((size_t)g_wrkProofMaxSize
        * sizeof(nmbrString));
    g_WrkProof.stepSrcPtrPntr = malloc((size_t)g_wrkProofMaxSize
        * sizeof(pntrString));
    g_WrkProof.localLabelFlag = malloc((size_t)g_wrkProofMaxSize
        * sizeof(flag));
    g_WrkProof.hypAndLocLabel =
        malloc((size_t)g_wrkProofMaxSize * sizeof(struct sortHypAndLoc));
    g_WrkProof.localLabelPool = malloc((size_t)g_wrkProofMaxSize);
    g_WrkProof.proofString =
        poolFixedMalloc(g_wrkProofMaxSize * (long)(sizeof(nmbrString)));
         /* Use poolFixedMalloc instead of poolMalloc so that it won't get
            trimmed by memUsedPoolPurge. */
    g_WrkProof.mathStringPtrs =
        malloc((size_t)g_wrkProofMaxSize * sizeof(nmbrString));
    g_WrkProof.RPNStack = malloc((size_t)g_wrkProofMaxSize * sizeof(nmbrString));
    g_WrkProof.compressedPfLabelMap =
         malloc((size_t)g_wrkProofMaxSize * sizeof(nmbrString));
    if (!g_WrkProof.tokenSrcPtrNmbr ||
        !g_WrkProof.tokenSrcPtrPntr ||
        !g_WrkProof.stepSrcPtrNmbr ||
        !g_WrkProof.stepSrcPtrPntr ||
        !g_WrkProof.localLabelFlag ||
        !g_WrkProof.hypAndLocLabel ||
        !g_WrkProof.localLabelPool ||
        !g_WrkProof.mathStringPtrs ||
        !g_WrkProof.RPNStack
        ) outOfMemory("#99 (g_WrkProof)");
  }

  /* Initialization for this proof */
  g_WrkProof.errorCount = 0; /* Used as threshold for how many error msgs/proof */
  g_WrkProof.numSteps = 0;
  g_WrkProof.numTokens = 0;
  g_WrkProof.numHypAndLoc = 0;
  g_WrkProof.numLocalLabels = 0;
  g_WrkProof.RPNStackPtr = 0;
  g_WrkProof.localLabelPoolPtr = g_WrkProof.localLabelPool;

  /* fbPtr points to the first token now. */

  /* First break up proof section of source into tokens */
  while (1) {
    tokLength = proofTokenLen(fbPtr);
    if (!tokLength) break;
    g_WrkProof.tokenSrcPtrPntr[g_WrkProof.numTokens] = fbPtr;
    g_WrkProof.tokenSrcPtrNmbr[g_WrkProof.numTokens] = tokLength;
    g_WrkProof.numTokens++;
    fbPtr = fbPtr + tokLength;
    fbPtr = fbPtr + whiteSpaceLen(fbPtr);
  }

  /* If there are no tokens, the proof is unknown; make the token a '?' */
  /* (g_WrkProof.tokenSrcPtrPntr won't point to the source, but this is OK since
     there will never be an error message for it.) */
  if (!g_WrkProof.numTokens) {

    /* For now, this is an error. */
    if (!g_WrkProof.errorCount) {
      sourceError(fbPtr, 2, statemNum,
          "The proof is empty.  If you don't know the proof, make it a \"?\".");
    }
    g_WrkProof.errorCount++;
    if (returnFlag < 1) returnFlag = 1;

    /* Allow empty proofs anyway */
    g_WrkProof.numTokens = 1;
    g_WrkProof.tokenSrcPtrPntr[0] = "?";
    g_WrkProof.tokenSrcPtrNmbr[0] = 1; /* Length */
  }

  /* Copy active (opt + req) hypotheses to hypAndLocLabel look-up table */
  nmbrTmpPtr = g_Statement[statemNum].optHypList;
  /* Transfer optional hypotheses */
  while (1) {
    i = nmbrTmpPtr[g_WrkProof.numHypAndLoc];
    if (i == -1) break;
    g_WrkProof.hypAndLocLabel[g_WrkProof.numHypAndLoc].labelTokenNum = i;
    g_WrkProof.hypAndLocLabel[g_WrkProof.numHypAndLoc].labelName =
        g_Statement[i].labelName;
    g_WrkProof.numHypAndLoc++;
  }
  /* Transfer required hypotheses */
  j = g_Statement[statemNum].numReqHyp;
  nmbrTmpPtr = g_Statement[statemNum].reqHypList;
  for (i = 0; i < j; i++) {
    k = nmbrTmpPtr[i];
    g_WrkProof.hypAndLocLabel[g_WrkProof.numHypAndLoc].labelTokenNum = k;
    g_WrkProof.hypAndLocLabel[g_WrkProof.numHypAndLoc].labelName =
        g_Statement[k].labelName;
    g_WrkProof.numHypAndLoc++;
  }

  /* Sort the hypotheses by label name for lookup */
  numActiveHyp = g_WrkProof.numHypAndLoc; /* Save for bsearch later */
  qsort(g_WrkProof.hypAndLocLabel, (size_t)(g_WrkProof.numHypAndLoc),
      sizeof(struct sortHypAndLoc), hypAndLocSortCmp);

  /* Scan the parsed tokens for local label assignments */
  fbPtr = g_WrkProof.tokenSrcPtrPntr[0];
  if (fbPtr[0] == ':') {
    if (!g_WrkProof.errorCount) {
      sourceError(fbPtr, 1, statemNum,
          "The colon at proof step 1 must be preceded by a local label.");
    }
    if (returnFlag < 2) returnFlag = 2;
    g_WrkProof.tokenSrcPtrPntr[0] = "?";
    g_WrkProof.tokenSrcPtrNmbr[0] = 1; /* Length */
    g_WrkProof.errorCount++;
  }
  fbPtr = g_WrkProof.tokenSrcPtrPntr[g_WrkProof.numTokens - 1];
  if (fbPtr[0] == ':') {
    if (!g_WrkProof.errorCount) {
      sourceError(fbPtr, 1, statemNum,
          "The colon in the last proof step must be followed by a label.");
    }
    if (returnFlag < 2) returnFlag = 2;
    g_WrkProof.errorCount++;
    g_WrkProof.numTokens--;
  }
  labelFlag = 0;
  for (tok = 0; tok < g_WrkProof.numTokens; tok++) {
    fbPtr = g_WrkProof.tokenSrcPtrPntr[tok];

    /* If next token is = then this token is a target for /EXPLICIT format,
       so don't increment the proof step number */
    if (tok < g_WrkProof.numTokens - 2) {
      if (((char *)((g_WrkProof.tokenSrcPtrPntr)[tok + 1]))[0] == '=') {
        explicitTargets = 1; /* Flag that proof has explicit targets */
        continue;
      }
    }
    if (fbPtr[0] == '=') continue; /* Skip the = token */

    /* Save pointer to source file vs. step for error messages */
    g_WrkProof.stepSrcPtrNmbr[g_WrkProof.numSteps] =
        g_WrkProof.tokenSrcPtrNmbr[tok]; /* Token length */
    g_WrkProof.stepSrcPtrPntr[g_WrkProof.numSteps] = fbPtr; /* Token ptr */

    /* Save fact that this step has a local label declaration */
    g_WrkProof.localLabelFlag[g_WrkProof.numSteps] = labelFlag;
    labelFlag = 0;

    g_WrkProof.numSteps++;
    if (fbPtr[0] != ':') continue;
  } /* Next i */

  /* Collect all target labels in /EXPLICIT format */
  /* I decided not to make targetPntr, targetNmbr part of the g_WrkProof
     structure since other proof formats don't assign it, so we can't
     reference it reliably outside of this function.  And it would waste
     some memory if we don't use /EXPLICIT, which is intended primarily
     for database maintenance. */

  /* Build the proof string and check the RPN stack */
  g_WrkProof.proofString[g_WrkProof.numSteps] = -1; /* End of proof */
  nmbrZapLen(g_WrkProof.proofString, g_WrkProof.numSteps);
     /* Zap mem pool actual length (because nmbrLen will be used later on this)*/

  for (step = 0; step < g_WrkProof.numSteps; step++) {
    tokLength = g_WrkProof.stepSrcPtrNmbr[step];
    fbPtr = g_WrkProof.stepSrcPtrPntr[step];

    /* Handle unknown proof steps */
    if (fbPtr[0] == '?') {
      if (returnFlag < 1) returnFlag = 1;
                                      /* Flag that proof is partially unknown */
      g_WrkProof.proofString[step] = -(long)'?';
      /* Treat "?" like a hypothesis - push stack and continue */
      g_WrkProof.RPNStack[g_WrkProof.RPNStackPtr] = step;
      g_WrkProof.RPNStackPtr++;
      continue;
    }

    /* Temporarily zap the token's end with a null for string comparisons */
    zapSave = fbPtr[tokLength];
    fbPtr[tokLength] = 0; /* Zap source */

    /* See if the proof token is a hypothesis or local label ref. */
    voidPtr = (void *)bsearch(fbPtr, g_WrkProof.hypAndLocLabel,
        (size_t)(g_WrkProof.numHypAndLoc), sizeof(struct sortHypAndLoc),
        hypAndLocSrchCmp);
    if (voidPtr) {
      fbPtr[tokLength] = zapSave; /* Unzap source */
      j = ((struct sortHypAndLoc *)voidPtr)->labelTokenNum; /* Label lookup number */
      g_WrkProof.proofString[step] = j; /* Proof string */

      /* Push the stack */
      g_WrkProof.RPNStack[g_WrkProof.RPNStackPtr] = step;
      g_WrkProof.RPNStackPtr++;

      if (j < 0) { /* It's a local label reference */
      } else { /* It's a hypothesis reference */
        if (j <= 0) bug(1709);
      }
      continue;
    } /* End if local label or hypothesis */

    /* See if token is an assertion label */
    voidPtr = (void *)bsearch(fbPtr, g_labelKeyBase, (size_t)g_numLabelKeys,
        sizeof(long), labelSrchCmp);
    fbPtr[tokLength] = zapSave; /* Unzap source */
    if (!voidPtr) {
      if (!g_WrkProof.errorCount) {
        sourceError(fbPtr, tokLength, statemNum, cat(
            "The token at proof step ",
            str((double)step + 1),
            " is not an active statement label or a local label.",NULL));
      }
      g_WrkProof.errorCount++;
      g_WrkProof.proofString[step] = -(long)'?';
      /* Push the stack */
      g_WrkProof.RPNStack[g_WrkProof.RPNStackPtr] = step;
      g_WrkProof.RPNStackPtr++;
      if (returnFlag < 2) returnFlag = 2;
      continue;
    }

    /* It's an assertion ($a or $p) */
    j = *(long *)voidPtr; /* Statement number */
    if (g_Statement[j].type != a_ && g_Statement[j].type != p_) bug(1710);
    g_WrkProof.proofString[step] = j; /* Assign $a/$p label to proof string */

    if (j >= statemNum) { /* Error */
      if (!g_WrkProof.errorCount) {
        if (j == statemNum) {
          sourceError(fbPtr, tokLength, statemNum, cat(
              "The label at proof step ",
              str((double)step + 1),
              " is the label of this statement.  A statement may not be used to",
              " prove itself.",NULL));
        } else {
          sourceError(fbPtr, tokLength, statemNum, cat(
              "The label \"", g_Statement[j].labelName, "\" at proof step ",
              str((double)step + 1),
              " is the label of a future statement (at line ",
              str((double)(g_Statement[j].lineNum)),
              " in file ",g_Statement[j].fileName,
      ").  Only local labels or previous, active statements may be referenced.",
              NULL));
        }
      }
      g_WrkProof.errorCount++;
      if (returnFlag < 2) returnFlag = 2;
    }

    /* It's a valid assertion, so pop the stack */
    numReqHyp = g_Statement[j].numReqHyp;

    /* Pop the stack */
    g_WrkProof.RPNStackPtr = g_WrkProof.RPNStackPtr - numReqHyp;
    g_WrkProof.RPNStack[g_WrkProof.RPNStackPtr] = step;
    g_WrkProof.RPNStackPtr++;
  } /* Next step */

  g_WrkProof.errorSeverity = returnFlag;
  return returnFlag;
} /* parseProof() */

/* Parse proof in compressed format */
/* Parse proof of one statement in source file.  Uses wrkProof structure. */
/* Returns 0 if OK; returns 1 if proof is incomplete (is empty or has '?'
   tokens);  returns 2 if error found; returns 3 if severe error found
   (e.g. RPN stack violation); returns 4 if not a $p statement */
char parseCompressedProof(long statemNum)
{

  long i, j, k, step, stmt;
  char *fbPtr;
  char *fbStartProof;
  char *labelStart;
  long tokLength;
  long numReqHyp;
  long numOptHyp;
  char zapSave;
  flag breakFlag;
  char returnFlag = 0;
  nmbrString *nmbrTmpPtr;
  void *voidPtr; /* bsearch returned value */
  vstring tmpStrPtr;
  flag hypLocUnkFlag;  /* Hypothesis, local label ref, or unknown step */
  long labelMapIndex;

  static unsigned char chrWeight[256]; /* Proof label character weights */
  static unsigned char chrType[256]; /* Proof character types */
  static flag chrTablesInited = 0;
  static char *digits = "0123456789";
  static char *letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
  static char labelChar = ':';
  static long lettersLen;
  static long digitsLen;

  /* Used to detect old buggy compression */
  long bggyProofLen;
  char bggyZapSave;
  flag bggyAlgo;

  /* Initialization to avoid compiler warning (should not be theoretically
     necessary) */
  labelStart = "";

  /* Do one-time initialization */
  if (!chrTablesInited) {
    chrTablesInited = 1;

    /* Compression standard with all cap letters */
    /* (For 500-700 step proofs, we only lose about 18% of file size --
        but the compressed proof is more pleasing to the eye) */
    letters = "ABCDEFGHIJKLMNOPQRST"; /* LSB is base 20 */
    digits = "UVWXY"; /* MSB's are base 5 */
    labelChar = 'Z'; /* Was colon */

    lettersLen = (long)strlen(letters);
    digitsLen = (long)strlen(digits);

    /* Initialize compressed proof label character weights */
    /* Initialize compressed proof character types */
    for (i = 0; i < 256; i++) {
      chrWeight[i] = 0;
      chrType[i] = 6; /* Illegal */
    }
    j = lettersLen;
    for (i = 0; i < j; i++) {
      chrWeight[(long)(letters[i])] = (unsigned char)i;
      chrType[(long)(letters[i])] = 0; /* Letter */
    }
    j = digitsLen;
    for (i = 0; i < j; i++) {
      chrWeight[(long)(digits[i])] = (unsigned char)i;
      chrType[(long)(digits[i])] = 1; /* Digit */
    }
    for (i = 0; i < 256; i++) {
      if (isspace(i)) chrType[i] = 3; /* White space */
    } /* Next i */
    chrType[(long)(labelChar)] = 2; /* Colon */
    chrType['$'] = 4; /* Dollar */
    chrType['?'] = 5; /* Question mark */
  }

  if (g_Statement[statemNum].type != p_) {
    bug(1724); /* should never get here */
    return 4; /* Do nothing if not $p */
  }
  fbPtr = g_Statement[statemNum].proofSectionPtr; /* Start of proof section */
  if (fbPtr[0] == 0) { /* The proof was never assigned (could be a $p statement
                          with no $=; this would have been detected earlier) */
    bug(1711);
  }
  fbPtr = fbPtr + whiteSpaceLen(fbPtr);
  if (fbPtr[0] != '(') { /* ( is flag for start of compressed proof */
    bug(1712);
  }

  /* Make sure we have enough working space to hold the proof */
  /* The worst case is less than the number of chars in the source,
     plus the number of active hypotheses */

  numOptHyp = nmbrLen(g_Statement[statemNum].optHypList);
  if (g_Statement[statemNum].proofSectionLen + g_Statement[statemNum].numReqHyp
      + numOptHyp > g_wrkProofMaxSize) {
    if (g_wrkProofMaxSize) { /* Not the first allocation */
      free(g_WrkProof.tokenSrcPtrNmbr);
      free(g_WrkProof.tokenSrcPtrPntr);
      free(g_WrkProof.stepSrcPtrNmbr);
      free(g_WrkProof.stepSrcPtrPntr);
      free(g_WrkProof.localLabelFlag);
      free(g_WrkProof.hypAndLocLabel);
      free(g_WrkProof.localLabelPool);
      poolFree(g_WrkProof.proofString);
      free(g_WrkProof.mathStringPtrs);
      free(g_WrkProof.RPNStack);
      free(g_WrkProof.compressedPfLabelMap);
    }
    g_wrkProofMaxSize = g_Statement[statemNum].proofSectionLen
        + g_Statement[statemNum].numReqHyp + numOptHyp;
    g_WrkProof.tokenSrcPtrNmbr = malloc((size_t)g_wrkProofMaxSize
        * sizeof(nmbrString));
    g_WrkProof.tokenSrcPtrPntr = malloc((size_t)g_wrkProofMaxSize
        * sizeof(pntrString));
    g_WrkProof.stepSrcPtrNmbr = malloc((size_t)g_wrkProofMaxSize
        * sizeof(nmbrString));
    g_WrkProof.stepSrcPtrPntr = malloc((size_t)g_wrkProofMaxSize
        * sizeof(pntrString));
    g_WrkProof.localLabelFlag = malloc((size_t)g_wrkProofMaxSize
        * sizeof(flag));
    g_WrkProof.hypAndLocLabel =
        malloc((size_t)g_wrkProofMaxSize * sizeof(struct sortHypAndLoc));
    g_WrkProof.localLabelPool = malloc((size_t)g_wrkProofMaxSize);
    g_WrkProof.proofString =
        poolFixedMalloc(g_wrkProofMaxSize * (long)(sizeof(nmbrString)));
         /* Use poolFixedMalloc instead of poolMalloc so that it won't get
            trimmed by memUsedPoolPurge. */
    g_WrkProof.mathStringPtrs =
        malloc((size_t)g_wrkProofMaxSize * sizeof(nmbrString));
    g_WrkProof.RPNStack = malloc((size_t)g_wrkProofMaxSize * sizeof(nmbrString));
    g_WrkProof.compressedPfLabelMap =
         malloc((size_t)g_wrkProofMaxSize * sizeof(nmbrString));
    if (!g_WrkProof.tokenSrcPtrNmbr ||
        !g_WrkProof.tokenSrcPtrPntr ||
        !g_WrkProof.stepSrcPtrNmbr ||
        !g_WrkProof.stepSrcPtrPntr ||
        !g_WrkProof.localLabelFlag ||
        !g_WrkProof.hypAndLocLabel ||
        !g_WrkProof.localLabelPool ||
        !g_WrkProof.mathStringPtrs ||
        !g_WrkProof.RPNStack
        ) outOfMemory("#99 (g_WrkProof)");
  }

  /* Initialization for this proof */
  g_WrkProof.errorCount = 0; /* Used as threshold for how many error msgs/proof */
  g_WrkProof.numSteps = 0;
  g_WrkProof.numTokens = 0;
  g_WrkProof.numHypAndLoc = 0;
  g_WrkProof.numLocalLabels = 0;
  g_WrkProof.RPNStackPtr = 0;
  g_WrkProof.localLabelPoolPtr = g_WrkProof.localLabelPool;

  fbPtr++;
  /* fbPtr points to the first token now. */

  /****** This part of the code is heavily borrowed from the regular
   ****** proof parsing, with local label and RPN handling removed,
   ****** in order to easily parse the label section. */

  /* First break up the label section of proof into tokens */
  while (1) {
    fbPtr = fbPtr + whiteSpaceLen(fbPtr);
    tokLength = proofTokenLen(fbPtr);
    if (!tokLength) {
      if (!g_WrkProof.errorCount) {
        sourceError(fbPtr, 2, statemNum,
            "A \")\" which ends the label list is not present.");
      }
      g_WrkProof.errorCount++;
      if (returnFlag < 3) returnFlag = 3;
      break;
    }
    if (fbPtr[0] == ')') {  /* End of label list */
      fbPtr++;
      break;
    }
    g_WrkProof.stepSrcPtrPntr[g_WrkProof.numSteps] = fbPtr;
    g_WrkProof.stepSrcPtrNmbr[g_WrkProof.numSteps] = tokLength;
    g_WrkProof.numSteps++;
    fbPtr = fbPtr + tokLength;
  }

  fbStartProof = fbPtr; /* Save pointer to start of compressed proof */

  /* Copy active (opt + req) hypotheses to hypAndLocLabel look-up table */
  nmbrTmpPtr = g_Statement[statemNum].optHypList;
  /* Transfer optional hypotheses */
  while (1) {
    i = nmbrTmpPtr[g_WrkProof.numHypAndLoc];
    if (i == -1) break;
    g_WrkProof.hypAndLocLabel[g_WrkProof.numHypAndLoc].labelTokenNum = i;
    g_WrkProof.hypAndLocLabel[g_WrkProof.numHypAndLoc].labelName =
        g_Statement[i].labelName;
    g_WrkProof.numHypAndLoc++;
  }
  /* Transfer required hypotheses */
  j = g_Statement[statemNum].numReqHyp;
  nmbrTmpPtr = g_Statement[statemNum].reqHypList;
  for (i = 0; i < j; i++) {
    k = nmbrTmpPtr[i];
    g_WrkProof.hypAndLocLabel[g_WrkProof.numHypAndLoc].labelTokenNum = -1000 - k;
       /* Required hypothesis labels are not allowed; the -1000 - k is a
          flag that tells that they are required for error detection */
    g_WrkProof.hypAndLocLabel[g_WrkProof.numHypAndLoc].labelName =
        g_Statement[k].labelName;
    g_WrkProof.numHypAndLoc++;
  }

  /* Sort the hypotheses by label name for lookup */
  qsort(g_WrkProof.hypAndLocLabel, (size_t)(g_WrkProof.numHypAndLoc),
      sizeof(struct sortHypAndLoc), hypAndLocSortCmp);

  /* Build the proof string (actually just a list of labels) */
  g_WrkProof.proofString[g_WrkProof.numSteps] = -1; /* End of proof */
  nmbrZapLen(g_WrkProof.proofString, g_WrkProof.numSteps);
     /* Zap mem pool actual length (because nmbrLen will be used later on this)*/

  /* Scan proof string with the label list (not really proof steps; we're just
     using the structure for convenience) */
  for (step = 0; step < g_WrkProof.numSteps; step++) {
    tokLength = g_WrkProof.stepSrcPtrNmbr[step];
    fbPtr = g_WrkProof.stepSrcPtrPntr[step];

    /* Temporarily zap the token's end with a null for string comparisons */
    zapSave = fbPtr[tokLength];
    fbPtr[tokLength] = 0; /* Zap source */

    /* See if the proof token is a hypothesis */
    voidPtr = (void *)bsearch(fbPtr, g_WrkProof.hypAndLocLabel,
        (size_t)(g_WrkProof.numHypAndLoc), sizeof(struct sortHypAndLoc),
        hypAndLocSrchCmp);
    if (voidPtr) {
      /* It's a hypothesis reference */
      fbPtr[tokLength] = zapSave; /* Unzap source */
      j = ((struct sortHypAndLoc *)voidPtr)->labelTokenNum;
                                                       /* Label lookup number */

      /* Make sure it's not a required hypothesis, which is implicitly
         declared */
      if (j < 0) { /* Minus is used as flag for required hypothesis */
        j = -1000 - j; /* Restore it to prevent side effects of the error */
        if (!g_WrkProof.errorCount) {
          sourceError(fbPtr, tokLength, statemNum,
              "Required hypotheses may not be explicitly declared.");
        }
        g_WrkProof.errorCount++;
        /* Tolerate this error so we can continue to work
           on proof in Proof Assistant */
        if (returnFlag < 1) returnFlag = 1;
      }

      g_WrkProof.proofString[step] = j; /* Proof string */
      if (j <= 0) bug(1713);
      continue;
    } /* End if hypothesis */

    /* See if token is an assertion label */
    voidPtr = (void *)bsearch(fbPtr, g_labelKeyBase, (size_t)g_numLabelKeys,
        sizeof(long), labelSrchCmp);
    fbPtr[tokLength] = zapSave; /* Unzap source */
    if (!voidPtr) {
      if (!g_WrkProof.errorCount) {
        sourceError(fbPtr, tokLength, statemNum,
         "This token is not the label of an assertion or optional hypothesis.");
      }
      g_WrkProof.errorCount++;
      g_WrkProof.proofString[step] = -(long)'?';
      if (returnFlag < 2) returnFlag = 2;
      continue;
    }

    /* It's an assertion ($a or $p) */
    j = *(long *)voidPtr; /* Statement number */
    if (g_Statement[j].type != a_ && g_Statement[j].type != p_) bug(1714);
    g_WrkProof.proofString[step] = j; /* Proof string */

    if (j >= statemNum) { /* Error */
      if (!g_WrkProof.errorCount) {
        if (j == statemNum) {
          sourceError(fbPtr, tokLength, statemNum, cat(
              "The label at proof step ",
              str((double)step + 1),
             " is the label of this statement.  A statement may not be used to",
              " prove itself.",NULL));
        } else {
          sourceError(fbPtr, tokLength, statemNum, cat(
              "The label \"", g_Statement[j].labelName, "\" at proof step ",
              str((double)step + 1),
              " is the label of a future statement (at line ",
              str((double)(g_Statement[j].lineNum)),
              " in file ",g_Statement[j].fileName,
              ").  Only previous statements may be referenced.",
              NULL));
        }
      }
      g_WrkProof.errorCount++;
      if (returnFlag < 2) returnFlag = 2;
    }
  } /* Next step */

  /******* Create the starting label map (local labels will be
           added as they are found) *****/
  g_WrkProof.compressedPfNumLabels = g_Statement[statemNum].numReqHyp;
  nmbrTmpPtr = g_Statement[statemNum].reqHypList;
  for (i = 0; i < g_WrkProof.compressedPfNumLabels; i++) {
    g_WrkProof.compressedPfLabelMap[i] = nmbrTmpPtr[i];
  }
  for (i = 0; i < g_WrkProof.numSteps; i++) {
    g_WrkProof.compressedPfLabelMap[i + g_WrkProof.compressedPfNumLabels] =
        g_WrkProof.proofString[i];
  }
  g_WrkProof.compressedPfNumLabels = g_WrkProof.compressedPfNumLabels +
      g_WrkProof.numSteps;

  /* Re-initialization for the actual proof */
  g_WrkProof.numSteps = 0;
  g_WrkProof.RPNStackPtr = 0;

  /******* Parse the compressed part of the proof *****/

  /* Check to see if the old buggy compression is used.  If so,
     warn the user to reformat, and switch to the buggy algorithm so that
     parsing can proceed. */
  bggyProofLen = g_Statement[statemNum].proofSectionLen -
             (fbPtr - g_Statement[statemNum].proofSectionPtr);
  /* Zap a zero at the end of the proof so we can use C string operations */
  bggyZapSave = fbPtr[bggyProofLen];
  fbPtr[bggyProofLen] = 0;
  /* If the proof has "UVA" but doesn't have "UUA", it means the buggy
     algorithm was used. */
  bggyAlgo = 0;
  if (strstr(fbPtr, "UV") != NULL) {
    if (strstr(fbPtr, "UU") == NULL) {
      bggyAlgo = 1;
      print2("?Warning: the proof of \"%s\" uses obsolete compression.\n",
          g_Statement[statemNum].labelName);
      print2(" Please SAVE PROOF * / COMPRESSED to reformat your proofs.\n");
    }
  }
  fbPtr[bggyProofLen] = bggyZapSave;

  /* (Build the proof string and check the RPN stack) */
  fbPtr = fbStartProof;
  breakFlag = 0;
  labelMapIndex = 0;
  while (1) {
    switch (chrType[(long)(fbPtr[0])]) {
      case 0: /* "Letter" (i.e. A...T) */
        if (!labelMapIndex) labelStart = fbPtr; /* Save for error msg */

        /* Save pointer to source file vs. step for error messages */
        tokLength = fbPtr - labelStart + 1; /* Token length */
        g_WrkProof.stepSrcPtrNmbr[g_WrkProof.numSteps] = tokLength;
        g_WrkProof.stepSrcPtrPntr[g_WrkProof.numSteps] = labelStart; /* Token ptr */

        /* Corrected algorithm provided by Marnix Klooster. */
        /* Decoding can be done as follows:
             * n := 0
             * for each character c:
                * if c in ['U'..'Y']: n := n * 5 + (c - 'U' + 1)
                * if c in ['A'..'T']: n := n * 20 + (c - 'A' + 1) */
        labelMapIndex = labelMapIndex * lettersLen +
            chrWeight[(long)(fbPtr[0])];
        if (labelMapIndex >= g_WrkProof.compressedPfNumLabels) {
          if (!g_WrkProof.errorCount) {
            sourceError(labelStart, tokLength, statemNum, cat(
     "This compressed label reference is outside the range of the label list.",
                "  The compressed label value is ", str((double)labelMapIndex),
                " but the largest label defined is ",
                str((double)(g_WrkProof.compressedPfNumLabels - 1)), ".", NULL));
          }
          g_WrkProof.errorCount++;
          if (returnFlag < 2) returnFlag = 2;
          labelMapIndex = 0; /* Make it something legal to avoid side effects */
        }

        stmt = g_WrkProof.compressedPfLabelMap[labelMapIndex];
        g_WrkProof.proofString[g_WrkProof.numSteps] = stmt;

        /* Update stack */
        hypLocUnkFlag = 0;
        if (stmt < 0) { /* Local label or '?' */
          hypLocUnkFlag = 1;
        } else {
          if (g_Statement[stmt].type != (char)a_ &&
              g_Statement[stmt].type != (char)p_) hypLocUnkFlag = 1;
                                                               /* Hypothesis */
        }
        if (hypLocUnkFlag) { /* Hypothesis, local label ref, or unknown step */
          g_WrkProof.RPNStack[g_WrkProof.RPNStackPtr] = g_WrkProof.numSteps;
          g_WrkProof.RPNStackPtr++;
        } else { /* An assertion */

          /* It's a valid assertion, so pop the stack */
          numReqHyp = g_Statement[stmt].numReqHyp;

          /* Pop the stack */
          g_WrkProof.RPNStackPtr = g_WrkProof.RPNStackPtr - numReqHyp;
          g_WrkProof.RPNStack[g_WrkProof.RPNStackPtr] = g_WrkProof.numSteps;
          g_WrkProof.RPNStackPtr++;
        }

        g_WrkProof.numSteps++;
        labelMapIndex = 0; /* Reset it for next label */
        break;

      case 1: /* "Digit" (i.e. U...Y) */
        if (!labelMapIndex) {
          labelMapIndex = chrWeight[(long)(fbPtr[0])] + 1;
          labelStart = fbPtr; /* Save label start for error msg */
        } else {
          labelMapIndex = labelMapIndex * digitsLen +
              chrWeight[(long)(fbPtr[0])] + 1;
          if (bggyAlgo) labelMapIndex--; /* Adjust for buggy algorithm */
        }
        break;

      case 2: /* "Colon" (i.e. Z) */
        break;

      case 3: /* White space */
        break;

      case 4: /* Dollar */
        /* See if we're at the end of the statement */
        if (fbPtr[1] == '.') {
          breakFlag = 1;
          break;
        }
        break;

      case 5: /* Question mark */
        break;

      case 6: /* Illegal */
        break;
      default:
        bug(1715);
        break;
    } /* End switch chrType[fbPtr[0]] */

    if (breakFlag) break;
    fbPtr++;
  } /* End while (1) */

  if (labelMapIndex) { /* In the middle of some digits */
    if (!g_WrkProof.errorCount) {
      sourceError(fbPtr, 1, statemNum,
       "A compressed label character was expected here.");
    }
    g_WrkProof.errorCount++;
    if (returnFlag < 2) returnFlag = 2;
  }

  /* If proof is empty, make it have one unknown step */
  if (g_WrkProof.numSteps == 0) {

    /* For now, this is an error. */
    if (!g_WrkProof.errorCount) {
      sourceError(fbPtr, 2, statemNum,
          "The proof is empty.  If you don't know the proof, make it a \"?\".");
    }
    g_WrkProof.errorCount++;

    /* Save pointer to source file vs. step for error messages */
    g_WrkProof.stepSrcPtrNmbr[g_WrkProof.numSteps] = 1;
    g_WrkProof.stepSrcPtrPntr[g_WrkProof.numSteps] = fbPtr; /* Token ptr */

    g_WrkProof.proofString[g_WrkProof.numSteps] = -(long)'?';
    if (returnFlag < 1) returnFlag = 1; /* Flag that proof has unknown steps */

    /* Update stack */
    g_WrkProof.RPNStack[g_WrkProof.RPNStackPtr] = g_WrkProof.numSteps;
    g_WrkProof.RPNStackPtr++;

    g_WrkProof.numSteps++;
  }

  g_WrkProof.proofString[g_WrkProof.numSteps] = -1; /* End of proof */
  nmbrZapLen(g_WrkProof.proofString, g_WrkProof.numSteps);
    /* Zap mem pool actual length (because nmbrLen will be used later on this)*/

  /* The stack should have one entry */
  if (g_WrkProof.RPNStackPtr != 1) {
    tmpStrPtr = shortDumpRPNStack();
    fbPtr = g_WrkProof.stepSrcPtrPntr[g_WrkProof.numSteps - 1];
    if (!g_WrkProof.errorCount) {
      sourceError(fbPtr, proofTokenLen(fbPtr), statemNum,
          cat("After proof step ",
          str((double)(g_WrkProof.numSteps))," (the last step), the ",
          tmpStrPtr,".  It should contain exactly one entry.",NULL));
    }
    g_WrkProof.errorCount++;
   if (returnFlag < 3) returnFlag = 3;
  }

  g_WrkProof.errorSeverity = returnFlag;
  return returnFlag;
} /* parseCompressedProof */

void rawSourceError(char *startFile, char *ptr, long tokLen, vstring errMsg) {
  char *startLine;
  char *endLine;
  vstring_def(errLine);
  vstring_def(errorMsg);
  vstring_def(fileName);
  long lineNum;

  let(&errorMsg, errMsg); /* Prevent deallocation of errMsg */

  /* Get the line with the error on it */
  startLine = ptr;
  while (startLine[0] != '\n' && startLine > startFile) {
    startLine--;
  }
  if (startLine[0] == '\n' && startLine != ptr /* In case of 0-length line */)
    startLine++; /* Go to 1st char on line */
  endLine = ptr;
  while (endLine[0] != '\n' && endLine[0] != 0) {
    endLine++;
  }
  endLine--;
  let(&errLine, space(endLine - startLine + 1));
  if (endLine - startLine + 1 < 0) bug(1721);
  memcpy(errLine, startLine, (size_t)(endLine - startLine) + 1);
  errorMessage(errLine, lineNum, ptr - startLine + 1, tokLen, errorMsg,
      fileName, 0, (char)error_);
  print2("\n");
  free_vstring(errLine);
  free_vstring(errorMsg);
  free_vstring(fileName);
} /* rawSourceError */

/* The global g_sourcePtr is assumed to point to the start of the raw input
     buffer.
   The global g_sourceLen is assumed to be length of the raw input buffer.
   The global g_IncludeCall array is referenced. */
void sourceError(char *ptr, long tokLen, long stmtNum, vstring errMsg)
{
  char *startLine;
  char *endLine;
  vstring_def(errLine);
  long lineNum;
  vstring_def(fileName);
  vstring_def(errorMsg);

  /* Used for the case where a source file section has been modified */
  char *locSourcePtr;

  /* Initialize local pointers to raw input source */
  locSourcePtr = g_sourcePtr;

  let(&errorMsg, errMsg); /* errMsg may become deallocated if this function is
                         called with a string function argument (cat, etc.) */

  if (!stmtNum) {
    lineNum = 0;
    goto SKIP_LINE_NUM; /* This isn't a source file parse */
  }
  if (ptr < g_sourcePtr || ptr > g_sourcePtr + g_sourceLen) {
    /* The pointer is outside the raw input buffer, so it must be a
       SAVEd proof or other overwritten section, so there is no line number. */
    /* Reassign the beginning and end of the source pointer to the
       changed section */
    if (g_Statement[stmtNum].labelSectionChanged == 1
         && ptr >= g_Statement[stmtNum].labelSectionPtr
         && ptr <= g_Statement[stmtNum].labelSectionPtr
             + g_Statement[stmtNum].labelSectionLen) {
      locSourcePtr = g_Statement[stmtNum].labelSectionPtr;
    } else if (g_Statement[stmtNum].mathSectionChanged == 1
         && ptr >= g_Statement[stmtNum].mathSectionPtr
         && ptr <= g_Statement[stmtNum].mathSectionPtr
             + g_Statement[stmtNum].mathSectionLen) {
      locSourcePtr = g_Statement[stmtNum].mathSectionPtr;
    } else if (g_Statement[stmtNum].proofSectionChanged == 1
         && ptr >= g_Statement[stmtNum].proofSectionPtr
         && ptr <= g_Statement[stmtNum].proofSectionPtr
             + g_Statement[stmtNum].proofSectionLen) {
      locSourcePtr = g_Statement[stmtNum].proofSectionPtr;
    } else {
      /* ptr points to neither the original source nor a modified section */
      bug(1741);
    }

    lineNum = 0;
    goto SKIP_LINE_NUM;
  }

 SKIP_LINE_NUM:
  /* Get the line with the error on it */
  if (lineNum != 0 && ptr > locSourcePtr) {
    startLine = ptr - 1; /* Allows pointer to point to \n. */
  } else {
    /* Special case:  Error message starts at beginning of file or
       the beginning of a changed section. */
    /* Or, it's a non-source statement; must not point to \n. */
    startLine = ptr;
  }

  /* Scan back to beginning of line with error */
  while (startLine[0] != '\n' && startLine > locSourcePtr) startLine--;
  if (startLine[0] == '\n') startLine++;

  /* Scan forward to end of line with error */
  endLine = ptr;
  while (endLine[0] != '\n' && endLine[0] != 0) {
    endLine++;
  }
  endLine--;

  /* Save line with error (with no newline on it) */
  let(&errLine, space(endLine - startLine + 1));
  memcpy(errLine, startLine, (size_t)(endLine - startLine) + 1);

  if (!lineNum) {
    /* Not a source file parse */
    errorMessage(errLine, lineNum, ptr - startLine + 1, tokLen, errorMsg,
        NULL, stmtNum, (char)error_);
  } else {
    errorMessage(errLine, lineNum,
        ptr - startLine + 1, tokLen, /* column */
        errorMsg,
        fileName,
        stmtNum,
        (char)error_ /* severity */);
  }
  free_vstring(errLine);
  free_vstring(errorMsg);
  free_vstring(fileName);
} /* sourceError */

vstring shortDumpRPNStack(void) {
  vstring_def(tmpStr);
  return tmpStr;
} /* shortDumpRPNStack */

/* Label comparison for qsort */
int labelSortCmp(const void *key1, const void *key2) {
  /* Returns -1 if key1 < key2, 0 if equal, 1 if key1 > key2 */
  return strcmp(g_Statement[ *((long *)key1) ].labelName,
      g_Statement[ *((long *)key2) ].labelName);
} /* labelSortCmp */

/* Label comparison for bsearch */
int labelSrchCmp(const void *key, const void *data) {
  /* Returns -1 if key < data, 0 if equal, 1 if key > data */
  return strcmp(key, g_Statement[ *((long *)data) ].labelName);
} /* labelSrchCmp */

/* Math symbol comparison for qsort */
int mathSortCmp(const void *key1, const void *key2) {
  /* Returns -1 if key1 < key2, 0 if equal, 1 if key1 > key2 */
  return strcmp(g_MathToken[ *((long *)key1) ].tokenName,
      g_MathToken[ *((long *)key2) ].tokenName);
}

/* Math symbol comparison for bsearch */
/* Here, key is pointer to a character string. */
int mathSrchCmp(const void *key, const void *data) {
  /* Returns -1 if key < data, 0 if equal, 1 if key > data */
  return strcmp(key, g_MathToken[ *((long *)data) ].tokenName);
}

/* Hypotheses and local label comparison for qsort */
int hypAndLocSortCmp(const void *key1, const void *key2) {
  /* Returns -1 if key1 < key2, 0 if equal, 1 if key1 > key2 */
  return strcmp(
    ((struct sortHypAndLoc *)key1)->labelName,
    ((struct sortHypAndLoc *)key2)->labelName);
}

/* Hypotheses and local label comparison for bsearch */
/* Here, key is pointer to a character string. */
int hypAndLocSrchCmp(const void *key, const void *data) {
  /* Returns -1 if key < data, 0 if equal, 1 if key > data */
  return strcmp(key, ((struct sortHypAndLoc *)data)->labelName);
}

/* This function returns the length of the white space starting at ptr.
   Comments are considered white space.  ptr should point to the first character
   of the white space.  If ptr does not point to a white space character, 0
   is returned.  If ptr points to a null character, 0 is returned. */
long whiteSpaceLen(char *ptr) {
  long i = 0;
  char tmpchr;
  char *ptr1;
  while (1) {
    tmpchr = ptr[i];
    if (!tmpchr) return (i); /* End of string */
    if (tmpchr == '$') {
      if (ptr[i + 1] == '(') {
        while (1) {
          /*ptr1 = strchr(ptr + i + 2, '$'); */
          /* in-line code for speed */
          /* (for the lcc-win32 compiler, this speeds it up from 94 sec
              for set.mm read to 4 sec) */
          for (ptr1 = ptr + i + 2; ptr1[0] != '$'; ptr1++) {
            if (ptr1[0] == 0) {
              if ('$' != 0)
                ptr1 = NULL;
              break;
            }
          }
          /* end in-line strchr code */
          if (!ptr1) {
            return i + (long)strlen(&ptr[i]); /* Unterminated comment - goto EOF */
          }
          if (ptr1[1] == ')') break;
          i = ptr1 - ptr;
        }
        i = ptr1 - ptr + 2;
        continue;
      } else {
        if (ptr[i + 1] == '!') {
          ptr1 = strchr(ptr + i + 2, '\n');
          if (!ptr1) bug(1716);
          i = ptr1 - ptr + 1;
          continue;
        }
        return i;
      }
    } /* if (tmpchr == '$') */
    if (isgraph((unsigned char)tmpchr)) return i;
    i++;
  }
  return 0; /* Dummy return - never happens */
} /* whiteSpaceLen */

/* For .mm file splitting */
/* This function is like whiteSpaceLen() except that comments are NOT
   considered white space.  ptr should point to the first character
   of the white space.  If ptr does not point to a white space character, 0
   is returned.  If ptr points to a null character, 0 is returned. */
long rawWhiteSpaceLen(char *ptr) {
  long i = 0;
  char tmpchr;
  while (1) {
    tmpchr = ptr[i];
    if (!tmpchr) return (i); /* End of string */
    if (isgraph((unsigned char)tmpchr)) return i;
    i++;
  }
  return 0; /* Dummy return - never happens */
} /* rawWhiteSpaceLen */

/* This function returns the length of the token (non-white-space) starting at
   ptr.  Comments are considered white space.  ptr should point to the first
   character of the token.  If ptr points to a white space character, 0
   is returned.  If ptr points to a null character, 0 is returned.  If ptr
   points to a keyword, 0 is returned.  A keyword ends a token. */
/* Tokens may be of the form "$nn"; this is tolerated (used in parsing
   user math strings in parseMathTokens()).  An (illegal) token of this form
   in the source will be detected earlier, so this won't cause
   syntax violations to slip by in the source. */
long tokenLen(char *ptr)
{
  long i = 0;
  char tmpchr;
  while (1) {
    tmpchr = ptr[i];
    if (tmpchr == '$') {
      if (ptr[i + 1] == '$') { /* '$$' character */
        i = i + 2;
        continue;
      } else {
        /* Tolerate digit after "$" */
        if (ptr[i + 1] >= '0' && ptr[i + 1] <= '9') {
          i = i + 2;
          continue;
        } else {
          return i; /* Keyword or comment */
        }
      }
    }
    if (!isgraph((unsigned char)tmpchr)) return i; /* White space or null */
    i++;
  }
  return 0; /* Dummy return (never happens) */
} /* tokenLen */

/* This function returns the length of the token (non-white-space) starting at
   ptr.  Comments are considered white space.  ptr should point to the first
   character of the token.  If ptr points to a white space character, 0
   is returned.  If ptr points to a null character, 0 is returned. */
/* Unlike tokenLen(), keywords are not treated as special.  In particular:
   if ptr points to a keyword, 0 is NOT returned (instead, 2 is returned),
   and a keyword does NOT end a token (which is a relic of days before
   whitespace surrounding a token was part of the spec, but still serves
   a useful purpose in token() for friendlier error detection). */
long rawTokenLen(char *ptr)
{
  long i = 0;
  char tmpchr;
  while (1) {
    tmpchr = ptr[i];
    if (!isgraph((unsigned char)tmpchr)) return i; /* White space or null */
    i++;
  }
  return 0; /* Dummy return (never happens) */
} /* rawTokenLen */

/* This function returns the length of the proof token starting at
   ptr.  Comments are considered white space.  ptr should point to the first
   character of the token.  If ptr points to a white space character, 0
   is returned.  If ptr points to a null character, 0 is returned.  If ptr
   points to a keyword, 0 is returned.  A keyword ends a token.
   ":" and "?" and "(" and ")" and "=" are considered tokens. */
long proofTokenLen(char *ptr)
{
  long i = 0;
  char tmpchr;
  if (ptr[0] == ':') return 1; /* The token is a colon */
  if (ptr[0] == '?') return 1; /* The token is a "?" */
  if (ptr[0] == '(') return 1; /* The token is a "(" (compressed proof) */
  if (ptr[0] == ')') return 1; /* The token is a ")" (compressed proof) */
  if (ptr[0] == '=') return 1; /* The token is a "=" (/EXPLICIT proof) */
  while (1) {
    tmpchr = ptr[i];
    if (tmpchr == '$') {
      if (ptr[i + 1] == '$') { /* '$$' character */
        i = i + 2;
        continue;
      } else {
        return i; /* Keyword or comment */
      }
    }
    if (!isgraph((unsigned char)tmpchr)) return i; /* White space or null */
    if (tmpchr == ':') return i; /* Colon ends a token */
    if (tmpchr == '?') return i; /* "?" ends a token */
    if (tmpchr == '(') return i; /* "(" ends a token */
    if (tmpchr == ')') return i; /* ")" ends a token */
    if (tmpchr == '=') return i; /* "=" ends a token */
    i++;
  }
  return 0; /* Dummy return - never happens */
}

/* Counts the number of \n between start for length chars.
   If length = -1, then use end-of-string 0 to stop.
   If length >= 0, then scan at most length chars, but stop
       if end-of-string 0 is found. */
long countLines(const char *start, long length) {
  long lines, i;
  lines = 0;
  if (length == -1) {
    i = 0;
    while (1) {
      if (start[i] == '\n') lines++;
      if (start[i] == 0) break;
      i++;
    }
  } else {
    for (i = 0; i < length; i++) {
      if (start[i] == '\n') lines++;
      if (start[i] == 0) break;
    }
  }
  return lines;
} /* countLines */

/* For .mm file splitting */
/* Get the next real $[...$] or virtual $( Begin $[... inclusion */
/* This uses the convention of mmvstr.c where beginning of a string
   is position 1.  However, startOffset = 0 means no offset i.e.
   start at fileBuf. */
void getNextInclusion(char *fileBuf, long startOffset, /* inputs */
    /* outputs: */
    long *cmdPos1, long *cmdPos2,
    long *endPos1, long *endPos2,
    char *cmdType, /* 'B' = "$( Begin [$..." through "$( End [$...",
                      'I' = "[$...",
                      'S' = "$( Skip [$...",
                      'E' = Start missing matched End
                      'N' = no include found; includeFn = "" */
    vstring *fileName /* name of included file */
    )
{

/*
cmdType = 'B' or 'E':
      ....... $( Begin $[ prop.mm $] $)   ......   $( End $[ prop.mm $] $) ...
       ^      ^           ^^^^^^^       ^          ^                      ^
  startOffset cmdPos1    fileName  cmdPos2     endPos1              endPos2
                                             (=0 if no End)   (=0 if no End)

   Note: in the special case of Begin, cmdPos2 points _after_ the whitespace
   after "$( Begin $[ prop.mm $] $)" i.e. the whitespace is considered part of
   the Begin command.  The is needed because prop.mm content doesn't
   necessarily start with whitespace.  prop.mm does, however, end with
   whitespace (\n) as enforced by readFileToString().

cmdType = 'I':
      ............... $[ prop.mm $]  ..............
       ^              ^  ^^^^^^^   ^
  startOffset   cmdPos1 fileName  cmdPos2     endPos1=0  endPos2=0

cmdType = 'S':
      ....... $( Skip $[ prop.mm $] $)   ......
       ^      ^          ^^^^^^^      ^
  startOffset cmdPos1    fileName  cmdPos2     endPos1=0  endPos2=0
*/
  char *fbPtr;
  char *tmpPtr;
  flag lookForEndMode = 0; /* 1 if inside of $( Begin, End, Skip... */
  long i, j;

  fbPtr = fileBuf + startOffset;

  while (1) {
    fbPtr = fbPtr + rawWhiteSpaceLen(fbPtr); /* Count $( as a token */
    j = rawTokenLen(fbPtr); /* Treat $(, $[ as tokens */
    if (j == 0) {
      *cmdType = 'N'; /* No include found */
      break;  /* End of file */
    }
    if (fbPtr[0] != '$') {
      fbPtr = fbPtr + j;
      continue;
    }

    /* Process normal include $[ $] */
    if (fbPtr[1] == '[') {
      if (lookForEndMode == 0) {
        /* If lookForEndMode is 1, ignore everything until we find a matching
           "$( End $[..." */
        *cmdPos1 = fbPtr - fileBuf + 1; /* 1 = beginning of file */
        fbPtr = fbPtr + j;
        fbPtr = fbPtr + whiteSpaceLen(fbPtr); /* Comments = whitespace here */
        j = rawTokenLen(fbPtr); /* Should be file name */
        /* Note that mid, seg, left, right do not waste time computing
           the length of the input string fbPtr */
        let(&(*fileName), left(fbPtr, j));
        fbPtr = fbPtr + j;
        fbPtr = fbPtr + whiteSpaceLen(fbPtr); /* Comments = whitespace here */
        j = rawTokenLen(fbPtr);
        if (j == 2/*speedup*/ && !strncmp("$]", fbPtr, (size_t)j)) {
          *cmdPos2 = fbPtr - fileBuf + j + 1;
          *endPos1 = 0;
          *endPos2 = 0;
          *cmdType = 'I';
          return;
        }
        /* TODO - more precise error message */
        print2("?Missing \"$]\" after \"$[ %s\"\n", *fileName);
        fbPtr = fbPtr + j;
        continue; /* Not a completed include */
      } /* if (lookForEndMode == 0) */
      fbPtr = fbPtr + j;
      continue; /* Either not a legal include - error detected later,
             or we're in lookForEndMode */
    /* Process markup-type include inside comment */
    } else if (fbPtr[1] == '(') {
      /* Process comment starting at "$(" */
      if (lookForEndMode == 0) {
        *cmdPos1 = fbPtr - fileBuf + 1;
      } else {
        *endPos1 = fbPtr - fileBuf + 1;
      }
      fbPtr = fbPtr + j;
      fbPtr = fbPtr + rawWhiteSpaceLen(fbPtr); /* comment != whitespace */
      j = rawTokenLen(fbPtr);
      *cmdType = '?';
      if (j == 5/*speedup*/ && !strncmp("Begin", fbPtr, (size_t)j)) {
        /* If lookForEndMode is 1, we're looking for End matching earlier Begin */
        if (lookForEndMode == 0) {
          *cmdType = 'B';
        }
      } else if (j == 4/*speedup*/ && !strncmp("Skip", fbPtr, (size_t)j)) {
        /* If lookForEndMode is 1, we're looking for End matching earlier Begin */
        if (lookForEndMode == 0) {
          *cmdType = 'S';
        }
      } else if (j == 3/*speedup*/ && !strncmp("End", fbPtr, (size_t)j)) {
        /* If lookForEndMode is 0, there was no matching Begin */
        if (lookForEndMode == 1) {
          *cmdType = 'E';
        }
      }
      if (*cmdType == '?') { /* The comment doesn't qualify as $[ $] markup */
        /* Find end of comment and continue */
        goto GET_PASSED_END_OF_COMMENT;
      } else {
        /* It's Begin or Skip or End */
        fbPtr = fbPtr + j;
        fbPtr = fbPtr + rawWhiteSpaceLen(fbPtr);
        j = rawTokenLen(fbPtr);
        if (j != 2 || strncmp("$[", fbPtr, (size_t)j)) {
          /* Find end of comment and continue */
          goto GET_PASSED_END_OF_COMMENT;
        }
        fbPtr = fbPtr + j;
        fbPtr = fbPtr + rawWhiteSpaceLen(fbPtr);  /* comment != whitespace */
        j = rawTokenLen(fbPtr);
        /* Note that mid, seg, left, right do not waste time computing
           the length of the input string fbPtr */
        if (lookForEndMode == 0) {
          /* It's Begin or Skip */
          let(&(*fileName), left(fbPtr, j));
        } else {
          /* It's an End command */
          if (strncmp(*fileName, fbPtr, (size_t)j)) {
            /* But the file name didn't match, so it's not a matching End */
            /* Find end of comment and continue */
            goto GET_PASSED_END_OF_COMMENT;
          }
        }
        fbPtr = fbPtr + j;
        fbPtr = fbPtr + rawWhiteSpaceLen(fbPtr);  /* comment != whitespace */
        j = rawTokenLen(fbPtr);
        if (j != 2 || strncmp("$]", fbPtr, (size_t)j)) {
          /* The token after the file name isn't "$]" */
          /* Find end of comment and continue */
          goto GET_PASSED_END_OF_COMMENT;
        }
        fbPtr = fbPtr + j;
        fbPtr = fbPtr + rawWhiteSpaceLen(fbPtr);  /* comment != whitespace */
        j = rawTokenLen(fbPtr);
        if (j != 2 || strncmp("$)", fbPtr, (size_t)j)) {
          /* The token after the "$]" isn't "$)" */
          /* Find end of comment and continue */
          goto GET_PASSED_END_OF_COMMENT;
        }
        /* We are now at the end of "$( Begin/Skip/End $[ file $] $)" */
        fbPtr = fbPtr + j;
        if (lookForEndMode == 0) {
          *cmdPos2 = fbPtr - fileBuf + 1
            + ((*cmdType == 'B') ? 1 : 0);/*after whitespace for 'B' (see above)*/
          if (*cmdType == 'S') {  /* Skip command; we're done */
            *endPos1 = 0;
            *endPos2 = 0;
            return;
          }
          if (*cmdType != 'B') bug(1742);
          lookForEndMode = 1;
        } else { /* We're at an End */
          if (*cmdType != 'E') bug(1743);
          /*lookForEndMode = 0;*/ /* Not needed since we will return soon */
          *cmdType = 'B'; /* Restore it to B for Begin/End pair */
          *endPos2 = fbPtr - fileBuf + 1;
          return;
        }
        continue; /* We're past Begin; start search for End */
      } /* Begin, End, or Skip */
    } else if (i != i + 1) { /* Suppress "unreachable code" warning for bug trap below */
      /* It's '$' not followed by '[' or '('; j is token length */
      fbPtr = fbPtr + j;
      continue;
    }
    bug(1746); /* Should never get here */
   GET_PASSED_END_OF_COMMENT:
    /* Note that fbPtr should be at beginning of last token found, which
       may be "$)" (in which case i will be 1 from the instr) */

    /* Don't use instr because it computes string length each call */
    /*i = instr(1, fbPtr, "$)");*/ /* Normally this will be fast because we only
        have to find the end of the comment that we're in */
    /* Emulate the instr() */
    tmpPtr = fbPtr;
    i = 0;
    while (1) {
      /* Emulate strchr */
      while (tmpPtr[0] != '$') {
        if (tmpPtr[0] == 0) break;
        tmpPtr++;
      }
      if (tmpPtr[0] == 0) {
        i = 0;
        break;
      }
      if (tmpPtr[1] == ')') {
        i = tmpPtr - fbPtr + 1;
        break;
      }
      tmpPtr++;
    } /* while (1) */

    if (i == 0) {
      /* TODO: better error msg */
      printf("?End of comment not found\n");
      i = (long)strlen(fileBuf); /* Slow, but this is a rare error */
      fbPtr = fileBuf + i; /* Points to null at end of fileBuf */
    } else {
      fbPtr = fbPtr + i + 2 - 1; /* Skip the "$)" - skip 2 characters, then
           back up 1 since the instr result starts at 1 */
    }
    /* continue; */  /* Not necessary since we're at end of loop */
  } /* while (1) */
  if (j != 0) bug(1744); /* Should be at end of file */
  if (lookForEndMode == 1) {
    /* We didn't find an End */
    *cmdType = 'E';
    *endPos1 = 0; *endPos2 = 0;
  } else {
    *cmdType = 'N'; /* no include was found */
    *cmdPos1 = 0; *cmdPos2 = 0; *endPos1 = 0; *endPos2 = 0;
    free_vstring(*fileName);
  }
  return;
} /* getNextInclusion */

/* This function returns a pointer to a buffer containing the contents of an
   input file and its 'include' calls.  'Size' returns the buffer's size.  */
/* TODO - ability to flag error to skip raw source function */
/* Recursive function that processes a found include */
/* If NULL is returned, it means a serious error occurred (like missing file)
   and reading should be aborted. */
/* Globals used:  g_IncludeCall[], g_includeCalls */
vstring readInclude(const char *fileBuf, long fileBufOffset,
    const char *sourceFileName, long *size, long parentLineNum, flag *errorFlag)
{
  long i;
  long inclSize;
  vstring_def(newFileBuf);
  vstring_def(inclPrefix);
  vstring_def(tmpSource);
  vstring_def(inclSource);
  vstring_def(oldSource);
  vstring_def(inclSuffix);

  long startOffset;
  long cmdPos1;
  long cmdPos2;
  long endPos1;
  long endPos2;
  char cmdType;
  long oldInclSize = 0; /* Init to avoid compiler warning */
  long newInclSize = 0; /* Init to avoid compiler warning */
  long befInclLineNum;
  long aftInclLineNum;
  vstring_def(includeFn);
  vstring_def(fullInputFn);
  vstring_def(fullIncludeFn);
  long alreadyInclBy;
  long saveInclCalls;

  let(&newFileBuf, fileBuf);  /* TODO - can this be avoided for speedup? */
  /* Look for and process includes */
  startOffset = 0;

  while (1) {
    getNextInclusion(newFileBuf, startOffset, /* inputs */
        /* outputs: */
        &cmdPos1, &cmdPos2,
        &endPos1, &endPos2,
        &cmdType, /* 'B' = "$( Begin [$..." through "$( End [$...",
                     'I' = "[$...",
                     'S' = "$( Skip [$...",
           TODO: add error code for missing $]?
                     'E' = Begin missing matched End
                     'N' = no include found; includeFn = "" */
        &includeFn /* name of included file */ );
    /*
    cmdType = 'B' or 'E':
          ....... $( Begin $[ prop.mm $] $)   ......   $( End $[ prop.mm $] $) ...
           ^      ^           ^^^^^^^       ^          ^                      ^
      startOffset cmdPos1    fileName  cmdPos2     endPos1              endPos2
                                                 (=0 if no End)   (=0 if no End)

       Note: in the special case of Begin, cmdPos2 points _after_ the whitespace
       after "$( Begin $[ prop.mm $] $)" i.e. the whitespace is considered part of
       the Begin command.  The is needed because prop.mm content doesn't
       necessarily start with whitespace.  prop.mm does, however, end with
       whitespace (\n) as enforced by readFileToString().

    cmdType = 'I':
          ............... $[ prop.mm $]  ..............
           ^              ^  ^^^^^^^   ^
      startOffset   cmdPos1 fileName  cmdPos2     endPos1=0  endPos2=0

    cmdType = 'S':
          ....... $( Skip $[ prop.mm $] $)   ......
           ^      ^          ^^^^^^^      ^
      startOffset cmdPos1    fileName  cmdPos2     endPos1=0  endPos2=0
    */

    if (cmdType == 'N') break; /* No (more) includes */
    if (cmdType == 'E') {
      /* TODO: Better error msg here or in getNextInclude */
      print2("?Error: \"$( Begin $[...\" without matching \"$( End $[...\"\n");
      startOffset = cmdPos2; /* Get passed the bad "$( Begin $[..." */
      *errorFlag = 1;
      continue;
    }

    /* Count lines between start of last source continuation and end of
       the inclusion, before the newFileBuf is modified */

    if (g_IncludeCall[g_includeCalls].pushOrPop != 1) bug(1764);
    /*
    contLineNum = g_IncludeCall[g_includeCalls].current_line
      + countLines(newFileBuf, ((cmdType == 'B') ? endPos2 : cmdPos2)
          - g_IncludeCall[g_includeCalls].current_offset);\
    */

    /* If we're here, cmdType is 'B', 'I', or 'S' */

    /* Create 2 new includeCall entries before recursive call, so that
       alreadyInclBy will scan entries in proper order (e.g. if this
       include calls itself at a deeper level - weird but not illegal - the
       deeper one should be Skip'd per the Metamath spec). */
    /* This entry is identified by pushOrPop = 0 */
    g_includeCalls++;
    /* We will use two more entries here (include call and return), and
       in parseKeywords() a dummy additional top entry is assumed to exist.
       Thus the comparison must be to 3 less than g_MAX_INCLUDECALLS. */
    if (g_includeCalls >= g_MAX_INCLUDECALLS - 3) {
      g_MAX_INCLUDECALLS = g_MAX_INCLUDECALLS + 20;
/*E*/if(db5)print2("'Include' call table was increased to %ld entries.\n",
/*E*/    g_MAX_INCLUDECALLS);
      g_IncludeCall = realloc(g_IncludeCall, (size_t)g_MAX_INCLUDECALLS *
          sizeof(struct includeCall_struct));
      if (g_IncludeCall == NULL) outOfMemory("#2 (g_IncludeCall)");
    }
    g_IncludeCall[g_includeCalls].pushOrPop = 0;

    /* This entry is identified by pushOrPop = 1 */
    g_includeCalls++;
    g_IncludeCall[g_includeCalls].pushOrPop = 1;
    /* Save the value before recursive calls will increment the global
       g_includeCalls */
    saveInclCalls = g_includeCalls;

    g_IncludeCall[saveInclCalls - 1].included_fn = "";  /* Initialize string */
    let(&(g_IncludeCall[saveInclCalls - 1].included_fn), includeFn); /* Name of the
       file in the inclusion statement e.g. "$( Begin $[ included_fn..." */
    g_IncludeCall[saveInclCalls].included_fn = "";
    let(&g_IncludeCall[saveInclCalls].included_fn,
        sourceFileName); /* Continuation of parent file after this include */

    /* See if includeFn file has already been included */
    alreadyInclBy = -1;
    for (i = 0; i <= saveInclCalls - 2; i++) {
      if (g_IncludeCall[i].pushOrPop == 0
         && !strcmp(g_IncludeCall[i].included_fn, includeFn)) {
        /*
        print2("%s",cat(
            "(File \"",
            g_IncludeCall[g_includeCalls].source_fn,
            "\", referenced at line ",
            str((double)(g_IncludeCall[g_includeCalls].calledBy_line)),
            " in \"",
            g_IncludeCall[g_includeCalls].calledBy_fn,
            "\", has already been included.)\n",NULL));
        */
        alreadyInclBy = i;
        break;
      }
    }
    if (alreadyInclBy == -1) {
      /* This is the first time the included file has been included */
      switch (cmdType) {
        case 'B':
          let(&inclPrefix, seg(newFileBuf, cmdPos1, cmdPos2 - 1)); /* Keep trailing
              \n (or other whitespace) as part of prefix for the special
              case of Begin - cmdPos2 points to char after \n */
          let(&inclSuffix, seg(newFileBuf, endPos1, endPos2 - 1));
          let(&tmpSource, seg(newFileBuf, cmdPos2, endPos1 - 1));  /* Save the
              included source */
          inclSize = endPos1 - cmdPos2; /* Actual included source size */

          /* Get the parent line number up to the inclusion */
          befInclLineNum = parentLineNum + countLines(
              newFileBuf + startOffset + 1,
              cmdPos2 - 1 - startOffset);
          g_IncludeCall[saveInclCalls - 1].current_line = befInclLineNum - 1;
          aftInclLineNum = befInclLineNum + countLines(newFileBuf
              + cmdPos2/*start at (cmdPos2+1)th character*/,
              endPos2 - cmdPos2 - 1) + 1;
          g_IncludeCall[saveInclCalls].current_line = aftInclLineNum - 1;
          parentLineNum = aftInclLineNum;

          /* Call recursively to expand any includes in the included source */
          /* Use parentLineNum since the inclusion source is in the parent file */
          free_vstring(inclSource);
          inclSource = readInclude(tmpSource,
              fileBufOffset + cmdPos1 - 1 + (long)strlen(inclPrefix), /*new offset*/
              /*includeFn,*/ sourceFileName,
              &inclSize /*input/output*/, befInclLineNum, &(*errorFlag));

          oldInclSize = endPos2 - cmdPos1; /* Includes old prefix and suffix */
          /*newInclSize = oldInclSize;*/ /* Includes new prefix and suffix */
          newInclSize = (long)strlen(inclPrefix) + inclSize +
                (long)strlen(inclSuffix); /* Includes new prefix and suffix */
          /* It is already a Begin comment, so leave it alone */
          /* *size = *size; */
          /* Adjust starting position for next inclusion search */
          startOffset = cmdPos1 + newInclSize - 1; /* -1 since startOffset is 0-based but
              cmdPos2 is 1-based */
          break;
        case 'I':
          /* Read the included file */
            print2(
                "?Error: file \"%s%s\" (included in \"%s\") was not found\n",
                fullIncludeFn, g_rootDirectory, sourceFileName);
          break;
        case 'S':
            print2(
                "?Error: file \"%s%s\" (included in \"%s\") was not found\n",
                fullIncludeFn, g_rootDirectory, sourceFileName);
          break;
        default:
          bug(1745);
      } /* end switch (cmdType) */
    } else {
      /* This file has already been included.  Change Begin and $[ $] to
         Skip.  alreadyInclBy is the index of the previous g_IncludeCall that
         included it. */
      if (!(alreadyInclBy > 0)) bug(1765);
      switch (cmdType) {
        case 'S':
          /* It is already Skipped, so leave it alone */
          /* *size = *size; */
          /* Adjust starting position for next inclusion search */
          let(&inclPrefix, seg(newFileBuf, cmdPos1, cmdPos2 - 1));
          let(&inclSuffix, "");

          /* Get the parent line number up to the inclusion */
          befInclLineNum = parentLineNum + countLines(
              newFileBuf + startOffset + 1,
              cmdPos1 - 1 - startOffset);
          g_IncludeCall[saveInclCalls - 1].current_line = befInclLineNum;
          aftInclLineNum = befInclLineNum + countLines(newFileBuf
              + cmdPos1/*start at (cmdPos1+1)th character*/,
              cmdPos2 - cmdPos1 /*- 1*/);
          g_IncludeCall[saveInclCalls].current_line = aftInclLineNum - 1;
          parentLineNum = aftInclLineNum;

          let(&inclSource, ""); /* Final source to be stored - none */
          inclSize = 0; /* Size of just the included source */
          oldInclSize = cmdPos2 - cmdPos1; /* Includes old prefix and suffix */
          newInclSize = oldInclSize; /* Includes new prefix and suffix */
          startOffset = cmdPos1 + newInclSize - 1; /* -1 since startOffset is
              0-based but cmdPos2 is 1-based */
          if (startOffset != cmdPos2 - 1) bug(1772);
          break;
        default:
          bug(1745);
      } /* end switch(cmdType) */
    } /* if alreadyInclBy == -1 */

    /* Assign structure with information for subsequent passes and
       (later) error messages */
    g_IncludeCall[saveInclCalls - 1].source_fn = "";  /* Name of the file where the
       inclusion source is located (= parent file for $( Begin $[... etc.) */
    g_IncludeCall[saveInclCalls - 1].current_offset = fileBufOffset + cmdPos1 - 1
        + (long)strlen(inclPrefix) - 1; /* This is the starting character position
            of the included file w.r.t entire source buffer */
    if (alreadyInclBy >= 0 || cmdType == 'B') {
      /* No external file was included, so let the includeFn be the
         same as the source */
      let(&g_IncludeCall[saveInclCalls - 1].source_fn, sourceFileName);
    } else {
      /* It hasn't been included yet, and cmdType is 'I' or 'S', meaning
         that we bring in an external file */
      let(&g_IncludeCall[saveInclCalls - 1].source_fn, includeFn); /* $[ $], Begin,
          or Skip file name for this inclusion */
      /*
      g_IncludeCall[saveInclCalls - 1].current_line = 0; */ /* The line number
          of the start of the included file (=1) */
    }
    g_IncludeCall[saveInclCalls - 1].current_includeSource = inclSource; /* let() not
        needed because we're just assigning a new name to inclSource */
    inclSource = ""; /* Detach from
        g_IncludeCall[saveInclCalls - 1].current_includeSource for later reuse */
    let(&g_IncludeCall[saveInclCalls - 1].current_includeSource, "");
    g_IncludeCall[saveInclCalls - 1].current_includeLength = inclSize; /* Length of the file
        to be included (0 if the file was previously included) */

    /* Initialize a new include call for the continuation of the parent. */
    /* This entry is identified by pushOrPop = 1 */
    g_IncludeCall[saveInclCalls].source_fn = "";  /* Name of the file to be
        included */
    let(&g_IncludeCall[saveInclCalls].source_fn,
        sourceFileName); /* Source file containing
         this inclusion */
    g_IncludeCall[saveInclCalls].current_offset = fileBufOffset + cmdPos1
        + newInclSize - 1;
        /* This is the position of the continuation of the parent */
    g_IncludeCall[saveInclCalls].current_includeSource = ""; /* (Currently) assigned
        only if we may need it for a later Begin comparison */
    g_IncludeCall[saveInclCalls].current_includeLength = 0; /* Length of the file
        to be included (0 if the file was previously included) */
  } /* while (1) */

  /* Deallocate strings */
  free_vstring(inclSource);
  free_vstring(tmpSource);
  free_vstring(oldSource);
  free_vstring(inclPrefix);
  free_vstring(inclSuffix);
  free_vstring(includeFn);
  free_vstring(fullInputFn);
  free_vstring(fullIncludeFn);

  return newFileBuf;
} /* readInclude */

/* This function returns a pointer to a buffer containing the contents of an
   input file and its 'include' calls.  'Size' returns the buffer's size.  */
/* TODO - ability to flag error to skip raw source function */
/* If NULL is returned, it means a serious error occurred (like missing file)
   and reading should be aborted. */
vstring readSourceAndIncludes(const char *inputFn /*input*/, long *size /*output*/) {
  long i;
/*D*//* long j; */
/*D*//* vstring_def(s); */
  vstring_def(fileBuf);
  vstring_def(newFileBuf);

  vstring_def(fullInputFn);
  flag errorFlag = 0;

  /* Read starting file */
  let(&fullInputFn, cat(g_rootDirectory, inputFn, NULL));
  fileBuf = readFileToString(fullInputFn, 1/*verbose*/, &(*size));
  if (fileBuf == NULL) {
    print2("?Error: file \"%s\" was not found\n", fullInputFn);
    fileBuf = "";
    *size = 0;
    errorFlag = 1;
    /* goto RETURN_POINT; */ /* Don't go now so that g_IncludeCall[]
         strings will be initialized.  If error, then blank fileBuf will
         cause main while loop to break immediately after first
         getNextInclusion() call. */
  }
  //print2("Reading source file \"%s\"... %ld bytes\n", fullInputFn, *size);
  free_vstring(fullInputFn);

  /* Create a fictitious initial include for the main file (at least 2
     g_IncludeCall structure array entries have been already been allocated
     in initBigArrays() in mmdata.c) */
  g_includeCalls = 0;
  g_IncludeCall[g_includeCalls].pushOrPop = 0; /* 0 means start of included file,
       1 means continuation of including file */
  g_IncludeCall[g_includeCalls].source_fn = "";
  let(&g_IncludeCall[g_includeCalls].source_fn, inputFn); /* $[ $], Begin,
      of Skip file name for this inclusion */
  g_IncludeCall[g_includeCalls].included_fn = "";
  let(&g_IncludeCall[g_includeCalls].included_fn, inputFn); /* $[ $], Begin,
      of Skip file name for this inclusion */
  g_IncludeCall[g_includeCalls].current_offset = 0;  /* This is the starting
      character position of the included file w.r.t entire source buffer */
  g_IncludeCall[g_includeCalls].current_line = 1; /* The line number
      of the start of the included file (=1) or the continuation line of
      the parent file */
  g_IncludeCall[g_includeCalls].current_includeSource = ""; /* (Currently) assigned
      only if we may need it for a later Begin comparison */
  g_IncludeCall[g_includeCalls].current_includeLength = *size; /* Length of the file
      to be included (0 if the file was previously included) */

  /* Create a fictitious entry for the "continuation" after the
     main file, to make error message line searching easier */
  g_includeCalls++;
  g_IncludeCall[g_includeCalls].pushOrPop = 1; /* 0 means start of included file,
       1 means continuation of including file */
  g_IncludeCall[g_includeCalls].source_fn = "";
  /*let(&g_IncludeCall[g_includeCalls].source_fn, inputFn);*/ /* Leave empty;
        there is no "continuation" file for the main file, so no need to assign
        (it won't be used) */
  g_IncludeCall[g_includeCalls].included_fn = "";
  /*let(&g_IncludeCall[g_includeCalls].included_fn, inputFn);*/ /* $[ $], Begin,
      of Skip file name for this inclusion */
  g_IncludeCall[g_includeCalls].current_line = -1; /* Ideally this should be
      countLines(fileBuf), but since it's never used we don't bother to
      call countLines(fileBuf) to save CPU time */
  g_IncludeCall[g_includeCalls].current_includeSource = ""; /* (Currently) assigned
      only if we may need it for a later Begin comparison */
  g_IncludeCall[g_includeCalls].current_includeLength = 0; /* The "continuation"
      of the main file is fictitious, so just set it to 0 length */

  /* Recursively expand the source of an included file */
  newFileBuf = "";
  newFileBuf = readInclude(fileBuf, 0, /*inputFn,*/ inputFn, &(*size),
      1/*parentLineNum*/, &errorFlag);
  g_IncludeCall[1].current_offset = *size;  /* This is the starting
      character position of the included file w.r.t entire source buffer.
      Here, it points to the nonexistent character just beyond end of main file
      (after all includes are expanded).
      Note that readInclude() may change g_includeCalls, so use 1 explicitly. */
  free_vstring(fileBuf); /* Deallocate */
/*D*//*printf("*size=%ld\n",*size);                                       */
/*D*//*for(i=0;i<*size;i++){                                              */
/*D*//*  free_vstring(s);                                                     */
/*D*//*s=getFileAndLineNum(newFileBuf,newFileBuf+i,&j);                   */
/*D*//*printf("i=%ld ln=%ld fn=%s ch=%c\n",i,j,s,(newFileBuf+i)[0]);  }   */
  if (errorFlag == 1) {
    /* The read should be aborted by the caller. */
    /* Deallocate the strings in the g_IncludeCall[] structure. */
    for (i = 0; i <= g_includeCalls; i++) {
      free_vstring(g_IncludeCall[i].source_fn);
      free_vstring(g_IncludeCall[i].included_fn);
      free_vstring(g_IncludeCall[i].current_includeSource);
      g_includeCalls = -1; /* For the eraseSource() function in mmcmds.c */
    }
    return NULL;
  } else {
/*D*//*for (i=0; i<=g_includeCalls;i++)                                       */
/*D*//*  printf("i=%ld p=%ld f=%s,%s l=%ld o=%ld s=%ld\n",                  */
/*D*//*i,(long)g_IncludeCall[i].pushOrPop,g_IncludeCall[i].source_fn,           */
/*D*//*g_IncludeCall[i].included_fn,g_IncludeCall[i].current_line,              */
/*D*//*g_IncludeCall[i].current_offset,g_IncludeCall[i].current_includeLength); */
    return newFileBuf;
  }
} /* readSourceAndIncludes */
