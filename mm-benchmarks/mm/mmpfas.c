/*****************************************************************************/
/*        Copyright (C) 2020  NORMAN MEGILL                                  */
/*            License terms:  GNU General Public License                     */
/*****************************************************************************/
/*34567890123456 (79-character line to adjust editor window) 2345678901234567*/

/* mmpfas.c - Proof assistant module */

#include <string.h>
#include <stdlib.h>
#include "mmvstr.h"
#include "mmdata.h"
#include "mminou.h"
#include "mmpars.h"
#include "mmunif.h"
#include "mmpfas.h"
#include "mmwtex.h"

/* Allow user to define INLINE as "inline".  lcc doesn't support inline. */
#ifndef INLINE
#define INLINE
#endif

long g_proveStatement = 0; /* The statement to be proved - global */

long g_dummyVars = 0; /* Total number of dummy variables declared */
long g_pipDummyVars = 0; /* Number of dummy variables used by proof in progress */

/* Structure for holding a proof in progress. */
/* This structure should be deallocated after use. */
struct pip_struct g_ProofInProgress = {
    NULL_NMBRSTRING, NULL_PNTRSTRING, NULL_PNTRSTRING, NULL_PNTRSTRING };

/* Get subproof length of a proof, starting at endStep and going backwards.
   Note that the first step is 0, the second is 1, etc. */
long subproofLen(const nmbrString *proof, long endStep) {
  long stmt, p, lvl;
  lvl = 1;
  p = endStep + 1;
  while (lvl) {
    p--;
    lvl--;
    if (p < 0) bug(1821);
    stmt = proof[p];
    if (stmt < 0) { /* Unknown step or local label */
      continue;
    }
    if (g_Statement[stmt].type == (char)e_ ||
        g_Statement[stmt].type == (char)f_) { /* A hypothesis */
      continue;
    }
    lvl = lvl + g_Statement[stmt].numReqHyp;
  }
  return (endStep - p + 1);
} /* subproofLen */

/* This function puts numNewVars dummy variables, named "$nnn", at the end
   of the g_MathToken array and modifies the global variable g_dummyVars. */
/* Note:  The g_MathToken array will grow forever as this gets called;
   it is never purged, as this might worsen memory fragmentation. */
/* ???Should we add a purge function? */
void declareDummyVars(long numNewVars)
{

  long i;

  long saveTempAllocStack;
  saveTempAllocStack = g_startTempAllocStack;
  g_startTempAllocStack = g_tempAllocStackTop; /* For let() stack cleanup */

  for (i = 0; i < numNewVars; i++) {

    g_dummyVars++;
    /* First, check to see if we need to allocate more g_MathToken memory */
    if (g_mathTokens + 1 + g_dummyVars >= g_MAX_MATHTOKENS) {
      /* The +1 above accounts for the dummy "$|$" boundary token */
      /* Reallocate */
      /* Add 1000 so we won't have to do this very often */
      g_MAX_MATHTOKENS = g_MAX_MATHTOKENS + 1000;
      g_MathToken = realloc(g_MathToken, (size_t)g_MAX_MATHTOKENS *
        sizeof(struct mathToken_struct));
      if (!g_MathToken) outOfMemory("#10 (mathToken)");
    }

    g_MathToken[g_mathTokens + g_dummyVars].tokenName = "";
                                  /* Initialize vstring before let() */
    let(&g_MathToken[g_mathTokens + g_dummyVars].tokenName,
        cat("$", str((double)g_dummyVars), NULL));
    g_MathToken[g_mathTokens + g_dummyVars].length =
        (long)strlen(g_MathToken[g_mathTokens + g_dummyVars].tokenName);
    g_MathToken[g_mathTokens + g_dummyVars].scope = g_currentScope;
    g_MathToken[g_mathTokens + g_dummyVars].active = 1;
    g_MathToken[g_mathTokens + g_dummyVars].tokenType = (char)var_;
    g_MathToken[g_mathTokens + g_dummyVars].tmp = 0;
  }

  g_startTempAllocStack = saveTempAllocStack;

  return;
} /* declareDummyVars */

#define DEFAULT_UNDO_STACK_SIZE 20

