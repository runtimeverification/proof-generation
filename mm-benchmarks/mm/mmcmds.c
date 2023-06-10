/*****************************************************************************/
/*        Copyright (C) 2020  NORMAN MEGILL                                  */
/*            License terms:  GNU General Public License                     */
/*****************************************************************************/
/*34567890123456 (79-character line to adjust editor window) 2345678901234567*/

/* mmcmds.c - assorted user commands */

#include <string.h>
#include <stdlib.h>
#include "mmvstr.h"
#include "mmdata.h"
#include "mmcmdl.h" /* For g_texFileName */
#include "mmcmds.h"
#include "mminou.h"
#include "mmpars.h"
#include "mmveri.h"
#include "mmwtex.h" /* For g_htmlVarColor,... */


/* This implements the READ command (although the / VERIFY qualifier is
   processed separately in metamath.c). */
void readInput(void)
{
  vstring_def(fullInput_fn);

  let(&fullInput_fn, cat(g_rootDirectory, g_input_fn, NULL));

  g_sourcePtr = readSourceAndIncludes(g_input_fn, &g_sourceLen);
  if (g_sourcePtr == NULL) {
    print2(
"?Source was not read due to error(s).  Please correct and try again.\n");
    goto RETURN_POINT;
  }

  g_sourcePtr = readRawSource(g_sourcePtr, &g_sourceLen);
  parseKeywords();
  parseLabels();
  parseMathDecl();
  parseStatements();
  g_sourceHasBeenRead = 1;

 RETURN_POINT:
  free_vstring(fullInput_fn);
} /* readInput */

/* Free up all memory space and initialize all variables */
void eraseSource(void)    /* ERASE command */
{
  long i;
  vstring_def(tmpStr);

  /* Deallocate g_WrkProof structure if g_wrkProofMaxSize != 0 */
  /* Assigned in parseProof() in mmpars.c */
  if (g_wrkProofMaxSize) { /* It has been allocated */
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
    g_wrkProofMaxSize = 0;
  }

  if (g_statements == 0) {
    /* Already called */
    memFreePoolPurge(0);
    return;
  }

  for (i = 0; i <= g_includeCalls; i++) {
    free_vstring(g_IncludeCall[i].source_fn);
    free_vstring(g_IncludeCall[i].included_fn);
    free_vstring(g_IncludeCall[i].current_includeSource);
  }
  g_includeCalls = -1;

  /* Deallocate the g_Statement[] array */
  for (i = 1; i <= g_statements + 1; i++) { /* g_statements + 1 is a dummy statement
                                          to hold source after last statement */

    if (g_Statement[i].fileName[0]) free(g_Statement[i].fileName);
    if (g_Statement[i].labelName[0]) free(g_Statement[i].labelName);
    if (g_Statement[i].mathString != NULL_NMBRSTRING)
        poolFree(g_Statement[i].mathString);
    if (g_Statement[i].proofString != NULL_NMBRSTRING)
        poolFree(g_Statement[i].proofString);
    if (g_Statement[i].reqHypList != NULL_NMBRSTRING)
        poolFree(g_Statement[i].reqHypList);
    if (g_Statement[i].optHypList != NULL_NMBRSTRING)
        poolFree(g_Statement[i].optHypList);
    if (g_Statement[i].reqVarList != NULL_NMBRSTRING)
        poolFree(g_Statement[i].reqVarList);
    if (g_Statement[i].optVarList != NULL_NMBRSTRING)
        poolFree(g_Statement[i].optVarList);
    if (g_Statement[i].reqDisjVarsA != NULL_NMBRSTRING)
        poolFree(g_Statement[i].reqDisjVarsA);
    if (g_Statement[i].reqDisjVarsB != NULL_NMBRSTRING)
        poolFree(g_Statement[i].reqDisjVarsB);
    if (g_Statement[i].reqDisjVarsStmt != NULL_NMBRSTRING)
        poolFree(g_Statement[i].reqDisjVarsStmt);
    if (g_Statement[i].optDisjVarsA != NULL_NMBRSTRING)
        poolFree(g_Statement[i].optDisjVarsA);
    if (g_Statement[i].optDisjVarsB != NULL_NMBRSTRING)
        poolFree(g_Statement[i].optDisjVarsB);
    if (g_Statement[i].optDisjVarsStmt != NULL_NMBRSTRING)
        poolFree(g_Statement[i].optDisjVarsStmt);

    if (g_Statement[i].labelSectionChanged == 1) {
      /* Deallocate text before label if not original source */
      free_vstring(g_Statement[i].labelSectionPtr);
    }
    if (g_Statement[i].mathSectionChanged == 1) {
      /* Deallocate math symbol text if not original source */
      free_vstring(g_Statement[i].mathSectionPtr);
    }
    if (g_Statement[i].proofSectionChanged == 1) {
      /* Deallocate proof if not original source */
      free_vstring(g_Statement[i].proofSectionPtr);
    }
  } /* Next i (statement) */


  memFreePoolPurge(0);
  g_errorCount = 0;

  free(g_Statement);
  free(g_IncludeCall);  /* Will be initialized in initBigArrays */
  free(g_MathToken);
  free(g_sourcePtr);
  free(g_labelKey);
  free(g_mathKey);
  free(g_allLabelKeyBase);

  /* Deallocate the texdef/htmldef storage */
  eraseTexDefs();

  g_extHtmlStmt = 0; /* May be used by a non-zero test; init to be safe */

  /* Initialize and deallocate mathbox information */
  g_mathboxStmt = 0; /* Used by a non-zero test in mmwtex.c to see if assigned */
  free_nmbrString(g_mathboxStart);
  free_nmbrString(g_mathboxEnd);
  for (i = 1; i <= g_mathboxes; i++) {
    free_vstring(*(vstring *)(&g_mathboxUser[i - 1]));
  }
  free_pntrString(g_mathboxUser);
  g_mathboxes = 0;

  /* Allocate big arrays */
  initBigArrays();
  getMarkupFlag(0, RESET); /* Erase the cached markup flag storage */

  /* Erase the contributor markup cache */
  free_vstring(tmpStr);
  tmpStr = getContrib(0 /*stmt is ignored*/, GC_RESET);

  /* getContrib uses g_statements (global var), so don't do this earlier */
  g_statements = 0; /* getContrib uses g_statements for loop limit */
} /* eraseSource */

/* If verify = 0, parse the proofs only for gross error checking.
   If verify = 1, do the full verification. */
void verifyProofs(vstring labelMatch, flag verifyFlag) {
  vstring_def(emptyProofList);
  long i, k;
  long lineLen = 0;
  vstring_def(header);
  flag errorFound;
#ifdef CLOCKS_PER_SEC
  clock_t clockStart;
#endif

#ifdef __WATCOMC__
  vstring_def(tmpStr);
#endif

#ifdef CLOCKS_PER_SEC
  clockStart = clock();  /* Retrieve start time */
#endif
  if (!strcmp("*", labelMatch) && verifyFlag) {
    /* Use status bar */
    let(&header, "0 10%  20%  30%  40%  50%  60%  70%  80%  90% 100%");
    print2("%s\n", header);
    free_vstring(header);
  }

  errorFound = 0;
  for (i = 1; i <= g_statements; i++) {
    if (!strcmp("*", labelMatch) && verifyFlag) {
      while (lineLen < (50 * i) / g_statements) {
        print2(".");
        lineLen++;
      }
    }

    if (g_Statement[i].type != p_) continue;
    if (!matchesList(g_Statement[i].labelName, labelMatch, '*', '?')) continue;
    if (strcmp("*",labelMatch) && verifyFlag) {
      /* If not *, print individual labels */
      lineLen = lineLen + (long)strlen(g_Statement[i].labelName) + 1;
      if (lineLen > 72) {
        lineLen = (long)strlen(g_Statement[i].labelName) + 1;
        print2("\n");
      }
      print2("%s ",g_Statement[i].labelName);
    }

    k = parseProof(i);
    if (k >= 2) errorFound = 1;
    if (k < 2) { /* $p with no error */
      if (verifyFlag) {
        if (verifyProof(i) >= 2) errorFound = 1;
        cleanWrkProof(); /* Deallocate verifyProof storage */
      }
    }
    if (k == 1) {
      let(&emptyProofList, cat(emptyProofList, ", ", g_Statement[i].labelName,
          NULL));
    }
  }
  if (verifyFlag) {
    print2("\n");
  }

  if (emptyProofList[0]) {
    printLongLine(cat(
        "Warning: The following $p statement(s) were not proved:  ",
        right(emptyProofList,3), NULL)," ","  ");
  }
  if (!emptyProofList[0] && !errorFound && !strcmp("*", labelMatch)) {
    if (verifyFlag) {
#ifdef CLOCKS_PER_SEC
      print2("All proofs in the database were verified in %1.2f s.\n",
           (double)((1.0 * (double)(clock() - clockStart)) / CLOCKS_PER_SEC));
#else
      print2("All proofs in the database were verified.\n");
#endif
    } else {
      print2("All proofs in the database passed the syntax-only check.\n");
    }
  }
  free_vstring(emptyProofList); /* Deallocate */
} /* verifyProofs */

