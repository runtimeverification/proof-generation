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
#include "mmpfas.h"
#include "mmunif.h" /* For g_bracketMatchInit, g_minSubstLen,
                       ...and g_firstConst */

/* Local prototypes */
vstring bigAdd(vstring bignum1, vstring bignum2);
vstring bigSub(vstring bignum1, vstring bignum2);

/* For HTML output */
vstring_def(g_printStringForReferencedBy);

/* For MIDI */
flag g_midiFlag = 0;
vstring_def(g_midiParam);

/* Get the HTML string of dummy variables used by a proof for the
   theorem's web page.  It should be called only if we're in
   HTML output mode i.e.  SHOW STATEMENT .../HTML or /ALT_HTML */
/* This is HARD-CODED FOR SET.MM and will not produce meaningful
   output for other databases (so far none) with $d's */
/* Caller must deallocate returned string */
vstring htmlDummyVars(long showStmt)
{
  nmbrString *optDVA; /* Pointer only; not allocated directly */
  nmbrString *optDVB; /* Pointer only; not allocated directly */
  long numDVs;
  nmbrString *optHyp; /* Pointer only; not allocated directly */
  long numOptHyps;
  vstring_def(str1);
  long k, l, n, hypStmt;

  /* Variables used while collecting a statement's dummy variables in $d's */
  long dummyVarCount; /* # of (different) dummy vars found in $d statements */
  vstring_def(dummyVarUsed); /* 'Y'/'N' indicators that we found that var */
  vstring_def(htmlDummyVarList); /* Output HTML string */
  long dummyVar; /* Current variable in a $d; test if it's a dummy variable */

  /* This function should be called only for web page generation */
  if (!g_htmlFlag) bug(261);

  if (g_Statement[showStmt].type != p_) bug(262);
  if (strcmp("|-", g_MathToken[
            (g_Statement[showStmt].mathString)[0]].tokenName)) {
    /* Don't process syntax statements */
    goto RETURN_POINT;
  }

  optDVA = g_Statement[showStmt].optDisjVarsA;
  optDVB = g_Statement[showStmt].optDisjVarsB;
  numDVs = nmbrLen(optDVA);
  optHyp = g_Statement[showStmt].optHypList;
  numOptHyps = nmbrLen(optHyp);

  if (numDVs == 0) {  /* Don't create a hint list if no $d's */
    /*let(&htmlDummyVarList, "(no restrictions)");*/
    goto RETURN_POINT;
  }

  dummyVarCount = 0;
  if (numDVs != 0) {

    /* Update g_WrkProof.proofString with current proof so we can
       search it later to see if it uses the dummy variable */
    parseProof(showStmt); /* Prints message if severe error */

    /* Create an array of Y/N indicators that variable is occurs in a
       $d statement as a dummy variable */
    let(&dummyVarUsed, string(g_mathTokens, 'N'));
    for (k = 0; k < numDVs; k++) {
      for (l = 1; l <= 2; l++) {
        if (l == 1) {
          dummyVar = optDVA[k];
        } else {
          dummyVar = optDVB[k];
        }
        /* At this point, dummyVar is just a var in the $d; we
           must still check that it is in the optHypList */
        /* See if potential dummyVar is in optHypList */
        if (dummyVarUsed[dummyVar] == 'N') {
          for (n = 0; n < numOptHyps; n++) {
            /* Check whether dummyVar matches the 2nd token of an
               optional hypothesis list entry e.g. "x" in "set x" */
            hypStmt = g_Statement[showStmt].optHypList[n];
            if (g_Statement[hypStmt].mathString[1] == dummyVar) {
              /* dummyVar is a dummy variable */

              /* See if it is used by the proof */
              /* g_WrkProof.proofString was updated by parseProof(showStmt)
                 above */
              if (nmbrElementIn(1, g_WrkProof.proofString, hypStmt) == 0) {
                break; /* It's not used by the proof; stop hyp scan */
              }

              dummyVarUsed[dummyVar] = 'Y';
              dummyVarCount++;
              /* tokenToTex allocates str1; must deallocate it first */
              free_vstring(str1);
              /* Convert token to htmldef/althtmldef string */
              str1 = tokenToTex(g_MathToken[dummyVar].tokenName,
                  showStmt);
              let(&htmlDummyVarList, cat(htmlDummyVarList, " ", str1, NULL));
              break; /* Found a match, so stop further checking */
            }
          } /* next n, 0 to numOptHyps-1*/
        } /* if dummy var not used (yet) */
      } /* next l */
    } /* next k */
  } /* if (numDVs != 0) */

  if (dummyVarCount > 0) {
    let(&htmlDummyVarList, cat(
        "<CENTER>",
         "<A HREF=\"",

         /* g_htmlHome is set by htmlhome in $t comment */
         (instr(1, g_htmlHome, "mmset.html") > 0) ?
             "mmset.html" :
             /* The following link will work in the NF and other
                "Proof Explorers" */
             "../mpeuni/mmset.html",

        "#dvnote1\">Dummy variable",
        /* Determine whether singular or plural */
        dummyVarCount > 1 ? "s" : "",
        "</A> ",
        /* Put a span around the variable list to localize
           the use of the special math font for ALT_HTML */
        (g_altHtmlFlag ? cat("<SPAN ", g_htmlFont, ">", NULL) : ""),
        htmlDummyVarList,
        (g_altHtmlFlag ? "</SPAN>" : ""),
        dummyVarCount > 1 ? " are mutually distinct and" : " is",
        " distinct from all other variables.",
        "</CENTER>",
        NULL));
  } /* htmlDummyVars */

 RETURN_POINT:
  /* Deallocate strings */
  free_vstring(dummyVarUsed);
  free_vstring(str1);

  return htmlDummyVarList;
} /* htmlDummyVars */

/* Get the HTML string of "allowed substitutions" list for an axiom
   or theorem's web page.  It should be called only if we're in
   HTML output mode i.e.  SHOW STATEMENT .../HTML or /ALT_HTML */
/* This is HARD-CODED FOR SET.MM and will not produce meaningful
   output for other databases (so far none) with $d's */
/* Caller must deallocate returned string */
vstring htmlAllowedSubst(long showStmt)
{
  nmbrString *reqHyp; /* Pointer only; not allocated directly */
  long numReqHyps;
  nmbrString *reqDVA; /* Pointer only; not allocated directly */
  nmbrString *reqDVB; /* Pointer only; not allocated directly */
  long numDVs;
  nmbrString_def(setVar); /* set (individual) variables */
  char *strptr;
  vstring_def(str1);
  long setVars;
  long wffOrClassVar;
  vstring_def(setVarDVFlag);
  flag found, first;
  long i, j, k;
  vstring_def(htmlAllowedList);
  long countInfo = 0;

  reqDVA = g_Statement[showStmt].reqDisjVarsA;
  reqDVB = g_Statement[showStmt].reqDisjVarsB;
  numDVs = nmbrLen(reqDVA);

  reqHyp = g_Statement[showStmt].reqHypList;
  numReqHyps = nmbrLen(reqHyp);

  /* This function should be called only for web page generation */
  if (!g_htmlFlag) bug(250);

  if (g_Statement[showStmt].mathStringLen < 1) bug(254);
  if (strcmp("|-", g_MathToken[
            (g_Statement[showStmt].mathString)[0]].tokenName)) {
    /* Don't process syntax statements */
    goto RETURN_POINT;
  }

  if (numDVs == 0) {  /* Don't create a hint list if no $d's */
    goto RETURN_POINT;
  }

  /* Collect list of all set variables in the theorem */
  /* First, count the number of set variables */
  setVars = 0;
  for (i = 0; i < numReqHyps; i++) {
    /* Scan "setvar" variables */
    if (g_Statement[reqHyp[i]].type == (char)e_) continue;
    if (g_Statement[reqHyp[i]].type != (char)f_) bug(251);
    if (g_Statement[reqHyp[i]].mathStringLen != 2)
      bug(252); /* $f must have 2 tokens */
    strptr = g_MathToken[
              (g_Statement[reqHyp[i]].mathString)[0]].tokenName;
    /* THE FOLLOWING IS SPECIFIC TO set.mm */
    if (strcmp("setvar", strptr)) continue;
                                  /* Not a set variable */
    setVars++;
  }
  /* Next, create a list of them in setVar[] */
  j = 0;
  nmbrLet(&setVar, nmbrSpace(setVars));
  for (i = 0; i < numReqHyps; i++) {
    /* Scan "setvar" variables */
    if (g_Statement[reqHyp[i]].type == (char)e_) continue;
    strptr = g_MathToken[
              (g_Statement[reqHyp[i]].mathString)[0]].tokenName;
    if (strcmp("setvar", strptr)) continue;
                                  /* Not a set variable */
    setVar[j] = (g_Statement[reqHyp[i]].mathString)[1];
    j++;
  }
  if (j != setVars) bug(253);

  /* Scan "wff" and "class" variables for attached $d's */
  for (i = 0; i < numReqHyps; i++) {
    /* Look for a "wff" and "class" variable */
    if (g_Statement[reqHyp[i]].type == (char)e_) continue;
    strptr = g_MathToken[
              (g_Statement[reqHyp[i]].mathString)[0]].tokenName;
    if (strcmp("wff", strptr) && strcmp("class", strptr)) continue;
                                  /* Not a wff or class variable */
    wffOrClassVar = (g_Statement[reqHyp[i]].mathString)[1];
    let(&setVarDVFlag, string(setVars, 'N')); /* No $d yet */
    /* Scan for attached $d's */
    for (j = 0; j < numDVs; j++) {
      found = 0;
      if (wffOrClassVar == reqDVA[j]) {
        for (k = 0; k < setVars; k++) {
          if (setVar[k] == reqDVB[j]) {
            setVarDVFlag[k] = 'Y';
            found = 1;
            break;
          }
        }
      }
      if (found) continue;
      /* Repeat with swapped $d arguments */
      if (wffOrClassVar == reqDVB[j]) {
        for (k = 0; k < setVars; k++) {
          if (setVar[k] == reqDVA[j]) {
            setVarDVFlag[k] = 'Y';
            break;
          }
        }
      }
    } /* next $d */

    /* Collect set vars that don't have $d's with this wff or class var */
    /* First, if there aren't any, then omit this wff or class var */
    found = 0;
    for (j = 0; j < setVars; j++) {
      if (setVarDVFlag[j] == 'N') {
        found = 1;
        break;
      }
    }
    if (found == 0) continue; /* All set vars have $d with this wff or class */

    free_vstring(str1);
    str1 = tokenToTex(g_MathToken[wffOrClassVar].tokenName, showStmt);
         /* tokenToTex allocates str1; we must deallocate it eventually */
    countInfo++;
    let(&htmlAllowedList, cat(htmlAllowedList, " &nbsp; ",
        str1, "(", NULL));
    first = 1;
    for (j = 0; j < setVars; j++) {
      if (setVarDVFlag[j] == 'N') {
        free_vstring(str1);
        str1 = tokenToTex(g_MathToken[setVar[j]].tokenName, showStmt);
        let(&htmlAllowedList, cat(htmlAllowedList,
            (first == 0) ? "," : "", str1, NULL));
        if (first == 0) countInfo++;
        first = 0;
      }
    }
    let(&htmlAllowedList, cat(htmlAllowedList, ")", NULL));
  } /* next i (wff or class var) */

 RETURN_POINT:

  if (htmlAllowedList[0] != 0) {
    let(&htmlAllowedList, cat("<CENTER>",
        "<A HREF=\"",

        /* g_htmlHome is set by htmlhome in $t comment */
        (instr(1, g_htmlHome, "mmset.html") > 0) ?
            "mmset.html" :
            /* The following link will work in the NF and other
               "Proof Explorers" */
            "../mpeuni/mmset.html",

        "#allowedsubst\">Allowed substitution</A> hint",
        ((countInfo != 1) ? "s" : ""), ": ",
        (g_altHtmlFlag ? cat("<SPAN ", g_htmlFont, ">", NULL) : ""),
        htmlAllowedList,
        (g_altHtmlFlag ? "</SPAN>" : ""),
        "</CENTER>", NULL));
  }

  /* Deallocate strings */
  free_nmbrString(setVar);
  free_vstring(str1);
  free_vstring(setVarDVFlag);

  return htmlAllowedList;
} /* htmlAllowedSubst */

/* Show details of one proof step */
/* Note:  detailStep is the actual step number (starting with 1), not
   the actual step - 1. */
void showDetailStep(long statemNum, long detailStep) {

  long i, j, plen, step, stmt, sourceStmt, targetStmt;
  vstring_def(tmpStr);
  vstring_def(tmpStr1);
  nmbrString_def(proof);
  nmbrString_def(localLabels);
  nmbrString_def(localLabelNames);
  nmbrString_def(targetHyps);
  long nextLocLabNum = 1; /* Next number to be used for a local label */
  void *voidPtr; /* bsearch result */
  char type;

  /* Error check */
  i = parseProof(statemNum);
  if (i) {
    printLongLine("?The proof is incomplete or has an error", "", " ");
    return;
  }
  plen = nmbrLen(g_WrkProof.proofString);
  if (plen < detailStep || detailStep < 1) {
    printLongLine(cat("?The step number should be from 1 to ",
        str((double)plen), NULL), "", " ");
    return;
  }

  /* Structure getStep is declared in mmveri.h. */
  getStep.stepNum = detailStep; /* Non-zero is flag for verifyProof */
  parseProof(statemNum); /* ???Do we need to do this again? */
  verifyProof(statemNum);

  nmbrLet(&proof, g_WrkProof.proofString); /* The proof */
  plen = nmbrLen(proof);

  /* Collect local labels */
  for (step = 0; step < plen; step++) {
    stmt = proof[step];
    if (stmt <= -1000) {
      stmt = -1000 - stmt;
      if (!nmbrElementIn(1, localLabels, stmt)) {
        nmbrLet(&localLabels, nmbrAddElement(localLabels, stmt));
      }
    }
  }

  /* localLabelNames[] hold an integer which, when converted to string,
    is the local label name. */
  nmbrLet(&localLabelNames, nmbrSpace(plen));

  /* Get the target hypotheses */
  nmbrLet(&targetHyps, nmbrGetTargetHyp(proof, statemNum));

  /* Get local labels */
  for (step = 0; step < plen; step++) {
    stmt = proof[step];
    if (stmt >= 0) {
      if (nmbrElementIn(1, localLabels, step)) {
        /* This statement declares a local label */
        /* First, get a name for the local label, using the next integer that
           does not match any integer used for a statement label. */
        let(&tmpStr1, str((double)nextLocLabNum));
        while (1) {
          voidPtr = (void *)bsearch(tmpStr,
              g_allLabelKeyBase, (size_t)g_numAllLabelKeys,
              sizeof(long), labelSrchCmp);
          if (!voidPtr) break; /* It does not conflict */
          nextLocLabNum++; /* Try the next one */
          let(&tmpStr1, str((double)nextLocLabNum));
        }
        localLabelNames[step] = nextLocLabNum;
        nextLocLabNum++; /* Prepare for next local label */
      }
    }
  } /* Next step */

  /* Print the step */
  let(&tmpStr, g_Statement[targetHyps[detailStep - 1]].labelName);
  let(&tmpStr1, ""); /* Local label declaration */
  stmt = proof[detailStep - 1];
  if (stmt < 0) {
    if (stmt <= -1000) {
      stmt = -1000 - stmt;
      /* stmt is now the step number a local label refers to */
      let(&tmpStr, cat(tmpStr,"=", str((double)(localLabelNames[stmt])), NULL));
      type = g_Statement[proof[stmt]].type;
    } else {
      if (stmt != -(long)'?') bug(207);
      let(&tmpStr, cat(tmpStr,"=",chr(-stmt), NULL)); /* '?' */
      type = '?';
    }
  } else {
    if (nmbrElementIn(1, localLabels, detailStep - 1)) {
      /* This statement declares a local label */
      let(&tmpStr1, cat(str((double)(localLabelNames[detailStep - 1])), ":",
          NULL));
    }
    let(&tmpStr, cat(tmpStr, "=", g_Statement[stmt].labelName, NULL));
    type = g_Statement[stmt].type;
  }

  /* Print the proof line */
  printLongLine(cat("Proof step ",
      str((double)detailStep),
      ":  ",
      tmpStr1,
      tmpStr,
      " $",
      chr(type),
      " ",
      nmbrCvtMToVString(g_WrkProof.mathStringPtrs[detailStep - 1]),
      NULL),
      "  ",
      " ");

  /* Print details about the step */
  let(&tmpStr, cat("This step assigns ", NULL));
  let(&tmpStr1, "");
  stmt = proof[detailStep - 1];
  sourceStmt = stmt;
  if (stmt < 0) {
    if (stmt <= -1000) {
      stmt = -1000 - stmt;
      /* stmt is now the step number a local label refers to */
      let(&tmpStr, cat(tmpStr, "step ", str((double)stmt),
          " (via local label reference \"",
          str((double)(localLabelNames[stmt])), "\") to ", NULL));
    } else {
      if (stmt != -(long)'?') bug(208);
      let(&tmpStr, cat(tmpStr, "an unknown statement to ", NULL));
    }
  } else {
    let(&tmpStr, cat(tmpStr, "source \"", g_Statement[stmt].labelName,
        "\" ($", chr(g_Statement[stmt].type), ") to ", NULL));
    if (nmbrElementIn(1, localLabels, detailStep - 1)) {
      /* This statement declares a local label */
      let(&tmpStr1, cat("  This step also declares the local label ",
          str((double)(localLabelNames[detailStep - 1])),
          ", which is used later on.",
          NULL));
    }
  }
  targetStmt = targetHyps[detailStep - 1];
  if (detailStep == plen) {
    let(&tmpStr, cat(tmpStr, "the final assertion being proved.", NULL));
  } else {
    let(&tmpStr, cat(tmpStr, "target \"", g_Statement[targetStmt].labelName,
    "\" ($", chr(g_Statement[targetStmt].type), ").", NULL));
  }

  let(&tmpStr, cat(tmpStr, tmpStr1, NULL));

  if (sourceStmt >= 0) {
    if (g_Statement[sourceStmt].type == a_
        || g_Statement[sourceStmt].type == p_) {
      j = nmbrLen(g_Statement[sourceStmt].reqHypList);
      if (j != nmbrLen(getStep.sourceHyps)) bug(209);
      if (!j) {
        let(&tmpStr, cat(tmpStr,
            "  The source assertion requires no hypotheses.", NULL));
      } else {
        if (j == 1) {
          let(&tmpStr, cat(tmpStr,
              "  The source assertion requires the hypothesis ", NULL));
        } else {
          let(&tmpStr, cat(tmpStr,
              "  The source assertion requires the hypotheses ", NULL));
        }
        for (i = 0; i < j; i++) {
          let(&tmpStr, cat(tmpStr, "\"",
              g_Statement[g_Statement[sourceStmt].reqHypList[i]].labelName,
              "\" ($",
              chr(g_Statement[g_Statement[sourceStmt].reqHypList[i]].type),
              ", step ", str((double)(getStep.sourceHyps[i] + 1)), ")", NULL));
          if (i == 0 && j == 2) {
            let(&tmpStr, cat(tmpStr, " and ", NULL));
          }
          if (i < j - 2 && j > 2) {
            let(&tmpStr, cat(tmpStr, ", ", NULL));
          }
          if (i == j - 2 && j > 2) {
            let(&tmpStr, cat(tmpStr, ", and ", NULL));
          }
        }
        let(&tmpStr, cat(tmpStr, ".", NULL));
      }
    }
  }

  if (detailStep < plen) {
    let(&tmpStr, cat(tmpStr,
         "  The parent assertion of the target hypothesis is \"",
        g_Statement[getStep.targetParentStmt].labelName, "\" ($",
        chr(g_Statement[getStep.targetParentStmt].type),", step ",
        str((double)(getStep.targetParentStep)), ").", NULL));
  } else {
    let(&tmpStr, cat(tmpStr,
        "  The target has no parent because it is the assertion being proved.",
        NULL));
  }

  printLongLine(tmpStr, "", " ");

  if (sourceStmt >= 0) {
    if (g_Statement[sourceStmt].type == a_
        || g_Statement[sourceStmt].type == p_) {
      print2("The source assertion before substitution was:\n");
      printLongLine(cat("    ", g_Statement[sourceStmt].labelName, " $",
          chr(g_Statement[sourceStmt].type), " ", nmbrCvtMToVString(
          g_Statement[sourceStmt].mathString), NULL),
          "        ", " ");
      j = nmbrLen(getStep.sourceSubstsNmbr);
      if (j == 1) {
        printLongLine(cat(
            "The following substitution was made to the source assertion:",
            NULL),""," ");
      } else {
        printLongLine(cat(
            "The following substitutions were made to the source assertion:",
            NULL),""," ");
      }
      if (!j) {
        print2("    (None)\n");
      } else {
        print2("    Variable  Substituted with\n");
        for (i = 0; i < j; i++) {
          printLongLine(cat("     ",
              g_MathToken[getStep.sourceSubstsNmbr[i]].tokenName," ",
              space(9 - (long)strlen(
                g_MathToken[getStep.sourceSubstsNmbr[i]].tokenName)),
              nmbrCvtMToVString(getStep.sourceSubstsPntr[i]), NULL),
              "                ", " ");
        }
      }
    }
  }

  if (detailStep < plen) {
    print2("The target hypothesis before substitution was:\n");
    printLongLine(cat("    ", g_Statement[targetStmt].labelName, " $",
        chr(g_Statement[targetStmt].type), " ", nmbrCvtMToVString(
        g_Statement[targetStmt].mathString), NULL),
        "        ", " ");
    j = nmbrLen(getStep.targetSubstsNmbr);
    if (j == 1) {
      printLongLine(cat(
          "The following substitution was made to the target hypothesis:",
          NULL),""," ");
    } else {
      printLongLine(cat(
          "The following substitutions were made to the target hypothesis:",
          NULL),""," ");
    }
    if (!j) {
      print2("    (None)\n");
    } else {
      print2("    Variable  Substituted with\n");
      for (i = 0; i < j; i++) {
        printLongLine(cat("     ",
            g_MathToken[getStep.targetSubstsNmbr[i]].tokenName, " ",
            space(9 - (long)strlen(
              g_MathToken[getStep.targetSubstsNmbr[i]].tokenName)),
            nmbrCvtMToVString(getStep.targetSubstsPntr[i]), NULL),
            "                ", " ");
      }
    }
  }

  cleanWrkProof();
  getStep.stepNum = 0; /* Zero is flag for verifyProof to ignore getStep info */

  /* Deallocate getStep contents */
  j = pntrLen(getStep.sourceSubstsPntr);
  for (i = 0; i < j; i++) {
    nmbrLet((nmbrString **)(&getStep.sourceSubstsPntr[i]),
        NULL_NMBRSTRING);
  }
  j = pntrLen(getStep.targetSubstsPntr);
  for (i = 0; i < j; i++) {
    nmbrLet((nmbrString **)(&getStep.targetSubstsPntr[i]),
        NULL_NMBRSTRING);
  }
  free_nmbrString(getStep.sourceHyps);
  free_pntrString(getStep.sourceSubstsPntr);
  free_nmbrString(getStep.sourceSubstsNmbr);
  free_pntrString(getStep.targetSubstsPntr);
  free_nmbrString(getStep.targetSubstsNmbr);

  /* Deallocate other strings */
  free_vstring(tmpStr);
  free_vstring(tmpStr1);
  free_nmbrString(localLabels);
  free_nmbrString(localLabelNames);
  free_nmbrString(proof);
  free_nmbrString(targetHyps);
} /* showDetailStep */

/* Summary of statements in proof for SHOW PROOF / STATEMENT_SUMMARY */
void proofStmtSumm(long statemNum, flag essentialFlag, flag texFlag) {

  long i, j, k, pos, stmt, plen, slen, step;
  char type;
  vstring_def(statementUsedFlags); /* 'Y'/'N' flag that statement is used */
  vstring_def(str1);
  vstring_def(str2);
  vstring_def(str3);
  nmbrString_def(statementList);
  nmbrString_def(proof);
  nmbrString_def(essentialFlags);

  /* This section is never called in HTML mode anymore.  The code is
     left in though just in case we somehow get here and the user continues
     through the bug. */
  if (texFlag && g_htmlFlag) bug(239);

  if (!texFlag) {
    print2("Summary of statements used in the proof of \"%s\":\n",
        g_Statement[statemNum].labelName);
  } else {
    g_outputToString = 1; /* Flag for print2 to add to g_printString */
    if (!g_htmlFlag) {
      print2("\n");
      print2("\\vspace{1ex} %%3\n");
      printLongLine(cat("Summary of statements used in the proof of ",
          "{\\tt ",
          asciiToTt_temp(g_Statement[statemNum].labelName),
          "}:", NULL), "", " ");
    } else {
      printLongLine(cat("Summary of statements used in the proof of ",
          "<B>",
          asciiToTt_temp(g_Statement[statemNum].labelName),
          "</B>:", NULL), "", "\"");
    }
    g_outputToString = 0;
    fprintf(g_texFilePtr, "%s", g_printString);
    free_vstring(g_printString);
  }

  if (g_Statement[statemNum].type != p_) {
    print2("  This is not a provable ($p) statement.\n");
    return;
  }

  /* Don't use bad proofs (incomplete proofs are ok) */
  if (parseProof(statemNum) > 1) {
    /* The proof has an error, so use the empty proof */
    nmbrLet(&proof, nmbrAddElement(NULL_NMBRSTRING, -(long)'?'));
  } else {
    nmbrLet(&proof, g_WrkProof.proofString);
  }

  plen = nmbrLen(proof);
  /* Get the essential step flags, if required */
  if (essentialFlag) {
    nmbrLet(&essentialFlags, nmbrGetEssential(proof));
  }

  for (step = 0; step < plen; step++) {
    if (essentialFlag) {
      if (!essentialFlags[step]) continue;     /* Ignore floating hypotheses */
    }
    stmt = proof[step];
    if (stmt < 0) {
      continue; /* Ignore '?' and local labels */
    }
    if (1) { /* Limit list to $a and $p only */
      if (g_Statement[stmt].type != a_ && g_Statement[stmt].type != p_) {
        continue;
      }
    }
    /* Add this statement to the statement list if not already in it */
    if (!nmbrElementIn(1, statementList, stmt)) {
      nmbrLet(&statementList, nmbrAddElement(statementList, stmt));
    }
  } /* Next step */

  /* Prepare the output */
  /* First, fill in the statementUsedFlags char array.  This allows us to sort
     the output by statement number without calling a sort routine. */
  slen = nmbrLen(statementList);
  let(&statementUsedFlags, string(g_statements + 1, 'N')); /* Init. to 'no' */
  for (pos = 0; pos < slen; pos++) {
    stmt = statementList[pos];
    if (stmt > statemNum || stmt < 1) bug(210);
    statementUsedFlags[stmt] = 'Y';
  }
  /* Next, build the output string */
  for (stmt = 1; stmt < statemNum; stmt++) {
    if (statementUsedFlags[stmt] == 'Y') {
      assignStmtFileAndLineNum(stmt);
      let(&str1, cat(" is located on line ",
          str((double)(g_Statement[stmt].lineNum)),
          " of the file ", NULL));
      if (!texFlag) {
        print2("\n");
        printLongLine(cat("Statement ", g_Statement[stmt].labelName, str1,
          "\"", g_Statement[stmt].fileName,
          "\".",NULL), "", " ");
      } else {
        g_outputToString = 1; /* Flag for print2 to add to g_printString */
        if (!g_htmlFlag) {
          print2("\n");
          print2("\n");
          print2("\\vspace{1ex} %%4\n");
          printLongLine(cat("Statement {\\tt ",
              asciiToTt_temp(g_Statement[stmt].labelName), "} ",
              str1, "{\\tt ",
              asciiToTt_temp(g_Statement[stmt].fileName),
              "}.", NULL), "", " ");
          print2("\n");
        } else {
          printLongLine(cat("Statement <B>",
              asciiToTt_temp(g_Statement[stmt].labelName), "</B> ",
              str1, " <B>",
              asciiToTt_temp(g_Statement[stmt].fileName),
              "</B> ", NULL), "", "\"");
        }
        g_outputToString = 0;
        fprintf(g_texFilePtr, "%s", g_printString);
        free_vstring(g_printString);
      }

      free_vstring(str1);
      str1 = getDescription(stmt);
      if (str1[0]) {
        if (!texFlag) {
          printLongLine(cat("\"", str1, "\"", NULL), "", " ");
        } else {
          printTexComment(str1,              /* Sends result to g_texFilePtr */
              1, /* 1 = htmlCenterFlag */
              PROCESS_EVERYTHING, /* actionBits */
              1 /* 1 = fileCheck */);
        }
      }

      j = nmbrLen(g_Statement[stmt].reqHypList);
      for (i = 0; i < j; i++) {
        k = g_Statement[stmt].reqHypList[i];
        if (!essentialFlag || g_Statement[k].type != f_) {
          let(&str2, cat("  ",g_Statement[k].labelName,
              " $", chr(g_Statement[k].type), " ", NULL));
          if (!texFlag) {
            printLongLine(cat(str2,
                nmbrCvtMToVString(g_Statement[k].mathString), " $.", NULL),
                "      "," ");
          } else {
            let(&str3, space((long)strlen(str2)));
            printTexLongMath(g_Statement[k].mathString,
                str2, str3, 0, 0);
          }
        }
      }

      let(&str1, "");
      type = g_Statement[stmt].type;
      if (type == p_) let(&str1, " $= ...");
      let(&str2, cat("  ", g_Statement[stmt].labelName,
          " $",chr(type), " ", NULL));
      if (!texFlag) {
        printLongLine(cat(str2,
            nmbrCvtMToVString(g_Statement[stmt].mathString),
            str1, " $.", NULL), "      ", " ");
      } else {
        let(&str3, space((long)strlen(str2)));
        printTexLongMath(g_Statement[stmt].mathString,
            str2, str3, 0, 0);
      }
    } /* End if (statementUsedFlag[stmt] == 'Y') */
  } /* Next stmt */

  free_vstring(statementUsedFlags); /* 'Y'/'N' flag that statement is used */
  free_vstring(str1);
  free_vstring(str2);
  free_vstring(str3);
  free_nmbrString(statementList);
  free_nmbrString(proof);
  free_nmbrString(essentialFlags);
} /* proofStmtSumm */

/* Traces back the statements used by a proof, recursively. */
/* Returns 1 if at least one label is printed (or would be printed in
   case testOnlyFlag=1); otherwise, returns 0.
   Returns -1 if the process was aborted */
/* matchList suppresses all output except labels matching matchList */
/* testOnlyFlag prevents any printout; it is used to determine whether
   there is an unwanted axiom for MINIMIZE_WITH /FORBID. */
/* abortOnQuit is set to 1 if we want to abort early if the user selects
   'Q to quit' at the prompt, and if so we return -1 */
char traceProof(long statemNum,
  flag essentialFlag,
  flag axiomFlag,
  vstring matchList,
  vstring traceToList,
  flag testOnlyFlag,
  flag abortOnQuit)
{

  long stmt, pos;
  vstring_def(statementUsedFlags); /* y/n flags that statement is used */
  vstring_def(outputString);
  nmbrString_def(unprovedList);
  char foundFlag = 0;

  /* Make sure we're calling this with $p statements only */
  if (g_Statement[statemNum].type != (char)p_) bug(249);

  if (!testOnlyFlag) {
    flag notQuitPrint;
    if (axiomFlag) {
      notQuitPrint = print2(
  "Statement \"%s\" assumes the following axioms ($a statements):\n",
          g_Statement[statemNum].labelName);
    } else if (traceToList[0] == 0) {
      notQuitPrint = print2(
  "The proof of statement \"%s\" uses the following earlier statements:\n",
          g_Statement[statemNum].labelName);
    } else {
      notQuitPrint = print2(
  "The proof of statement \"%s\" traces back to \"%s\" via:\n",
          g_Statement[statemNum].labelName, traceToList);
    }
    if (abortOnQuit && !notQuitPrint) {
      foundFlag = -1;
      goto TRACE_RETURN;
    }
  }

  traceProofWork(statemNum,
      essentialFlag,
      traceToList, /* /TO argument of SHOW TRACE_BACK */
      &statementUsedFlags,
      &unprovedList);
  if ((signed)(strlen(statementUsedFlags)) != g_statements + 1) bug(226);

  /* Build the output string */
  let(&outputString, "");
  for (stmt = 1; stmt < statemNum; stmt++) {
    if (statementUsedFlags[stmt] == 'Y') {

      if (matchList[0]) {  /* There is a list to match */
        /* Don't include unmatched labels */
        if (!matchesList(g_Statement[stmt].labelName, matchList, '*', '?'))
          continue;
      }

      /* Skip rest of scan in testOnlyFlag mode */
      foundFlag = 1; /* At least one label would be printed */
      if (testOnlyFlag) {
        goto TRACE_RETURN;
      }
      if (axiomFlag) {
        if (g_Statement[stmt].type == a_) {
          let(&outputString, cat(outputString, " ", g_Statement[stmt].labelName,
              NULL));
        }
      } else {
        let(&outputString, cat(outputString, " ", g_Statement[stmt].labelName,
            NULL));
        switch (g_Statement[stmt].type) {
          case a_: let(&outputString, cat(outputString, "($a)", NULL)); break;
          case e_: let(&outputString, cat(outputString, "($e)", NULL)); break;
          case f_: let(&outputString, cat(outputString, "($f)", NULL)); break;
        }
      }
    } /* End if (statementUsedFlag[stmt] == 'Y') */
  } /* Next stmt */

  /* Skip printing in testOnlyFlag mode */
  if (testOnlyFlag) {
    goto TRACE_RETURN;
  }

  if (outputString[0]) {
    let(&outputString, cat(" ", outputString, NULL));
  } else {
    let(&outputString, "  (None)");
  }

  /* Print the output */
  printLongLine(outputString, "  ", " ");

  /* Print any unproved statements */
  if (nmbrLen(unprovedList)) {
    print2("Warning: The following traced statement(s) were not proved:\n");
    let(&outputString, "");
    for (pos = 0; pos < nmbrLen(unprovedList); pos++) {
      let(&outputString, cat(outputString, " ", g_Statement[unprovedList[
          pos]].labelName, NULL));
    }
    let(&outputString, cat("  ", outputString, NULL));
    printLongLine(outputString, "  ", " ");
  }

 TRACE_RETURN:
  /* Deallocate */
  free_vstring(outputString);
  free_vstring(statementUsedFlags);
  free_nmbrString(unprovedList);
  return foundFlag;
} /* traceProof */

/* Traces back the statements used by a proof, recursively.  Returns
   a nmbrString with a list of statements and unproved statements */
void traceProofWork(long statemNum,
  flag essentialFlag,
  vstring traceToList, /* /TO argument of SHOW TRACE_BACK */
  vstring *statementUsedFlagsP, /* 'Y'/'N' flag that statement is used */
  nmbrString **unprovedListP)
{

  long pos, stmt, plen, slen, step;
  nmbrString_def(statementList);
  nmbrString_def(proof);
  nmbrString_def(essentialFlags);
  vstring_def(traceToFilter);
  vstring_def(str1);
  long j;

  /* Preprocess the "SHOW TRACE_BACK ... / TO" traceToList list if any */
  if (traceToList[0] != 0) {
    let(&traceToFilter, string(g_statements + 1, 'N')); /* Init. to 'no' */
    /* Wildcard match scan */
    for (stmt = 1; stmt <= g_statements; stmt++) {
      if (g_Statement[stmt].type != (char)a_
          && g_Statement[stmt].type != (char)p_)
        continue; /* Not a $a or $p statement; skip it */
      /* Wildcard matching */
      if (!matchesList(g_Statement[stmt].labelName, traceToList, '*', '?'))
        continue;
      free_vstring(str1);
      str1 = traceUsage(stmt /*g_showStatement*/,
          1, /*recursiveFlag*/
          statemNum /* cutoffStmt */);
      traceToFilter[stmt] = 'Y'; /* Include the statement we're showing
                                    usage of */
      if (str1[0] == 'Y') {  /* There is some usage */
        for (j = stmt + 1; j <= g_statements; j++) {
          /* OR in the usage to the filter */
          if (str1[j] == 'Y') traceToFilter[j] = 'Y';
        }
      }
    } /* Next i (statement number) */
  } /* if (traceToList[0] != 0) */

  nmbrLet(&statementList, nmbrSpace(g_statements));
  statementList[0] = statemNum;
  slen = 1;
  free_nmbrString(*unprovedListP); /* List of unproved statements */
  let(&(*statementUsedFlagsP), string(g_statements + 1, 'N')); /* Init. to 'no' */
  (*statementUsedFlagsP)[statemNum] = 'Y';
  for (pos = 0; pos < slen; pos++) {
    if (g_Statement[statementList[pos]].type != p_) {
      continue; /* Not a $p */
    }

    /* Don't use bad proofs (incomplete proofs are ok) */
    if (parseProof(statementList[pos]) > 1) {
      /* The proof has an error, so use the empty proof */
      nmbrLet(&proof, nmbrAddElement(NULL_NMBRSTRING, -(long)'?'));
    } else {
      nmbrLet(&proof, g_WrkProof.proofString);
    }

    plen = nmbrLen(proof);
    /* Get the essential step flags, if required */
    if (essentialFlag) {
      nmbrLet(&essentialFlags, nmbrGetEssential(proof));
    }
    for (step = 0; step < plen; step++) {
      if (essentialFlag) {
        if (!essentialFlags[step]) continue;  /* Ignore floating hypotheses */
      }
      stmt = proof[step];
      if (stmt < 0) {
        if (stmt > -1000) {
          /* '?' */
          if (!nmbrElementIn(1, *unprovedListP, statementList[pos])) {
            nmbrLet(&(*unprovedListP), nmbrAddElement(*unprovedListP,
                statementList[pos]));  /* Add to list of unproved statements */
          }
        }
        continue; /* Ignore '?' and local labels */
      }
      if (1) { /* Limit list to $a and $p only */
        if (g_Statement[stmt].type != a_ && g_Statement[stmt].type != p_) {
          continue;
        }
      }
      /* Add this statement to the statement list if not already in it */
      if ((*statementUsedFlagsP)[stmt] == 'N') {
        if (traceToList[0] == 0) {
          statementList[slen] = stmt;
          slen++;
          (*statementUsedFlagsP)[stmt] = 'Y';
        } else { /* TRACE_BACK / TO */
          if (traceToFilter[stmt] == 'Y') {
            statementList[slen] = stmt;
            slen++;
            (*statementUsedFlagsP)[stmt] = 'Y';
          }
        }
      }
    } /* Next step */
  } /* Next pos */

  /* Deallocate */
  free_nmbrString(essentialFlags);
  free_nmbrString(proof);
  free_nmbrString(statementList);
  free_vstring(str1);
  return;
} /* traceProofWork */

nmbrString_def(stmtFoundList);
long indentShift = 0;

/* Traces back the statements used by a proof, recursively, with tree display.*/
void traceProofTree(long statemNum,
  flag essentialFlag, long endIndent)
{
  if (g_Statement[statemNum].type != p_) {
    print2("Statement %s is not a $p statement.\n",
        g_Statement[statemNum].labelName);
    return;
  }

  printLongLine(cat("The proof tree traceback for statement \"",
      g_Statement[statemNum].labelName,
      "\" follows.  The statements used by each proof are indented one level in,",
      " below the statement being proved.  Hypotheses are not included.",
      NULL),
      "", " ");
  print2("\n");

  free_nmbrString(stmtFoundList);
  indentShift = 0;
  traceProofTreeRec(statemNum, essentialFlag, endIndent, 0);
  free_nmbrString(stmtFoundList);
} /* traceProofTree */

void traceProofTreeRec(long statemNum,
  flag essentialFlag, long endIndent, long recursDepth)
{
  long i, pos, stmt, plen, slen, step;
  vstring_def(outputStr);
  nmbrString_def(localFoundList);
  nmbrString_def(localPrintedList);
  flag unprovedFlag = 0;
  nmbrString_def(proof);
  nmbrString_def(essentialFlags);

  free_vstring(outputStr);
  outputStr = getDescription(statemNum); /* Get statement comment */
  let(&outputStr, edit(outputStr, 8 + 16 + 128)); /* Trim and reduce spaces */
  slen = len(outputStr);
  for (i = 0; i < slen; i++) {
    /* Change newlines to spaces in comment */
    if (outputStr[i] == '\n') {
      outputStr[i] = ' ';
    }
  }

#define INDENT_INCR 3
#define MAX_LINE_LEN 79

  if ((recursDepth * INDENT_INCR - indentShift) >
      (g_screenWidth - MAX_LINE_LEN) + 50) {
    indentShift = indentShift + 40 + (g_screenWidth - MAX_LINE_LEN);
    print2("****** Shifting indentation.  Total shift is now %ld.\n",
      (long)indentShift);
  }
  if ((recursDepth * INDENT_INCR - indentShift) < 1 && indentShift != 0) {
    indentShift = indentShift - 40 - (g_screenWidth - MAX_LINE_LEN);
    print2("****** Shifting indentation.  Total shift is now %ld.\n",
      (long)indentShift);
  }

  let(&outputStr, cat(space(recursDepth * INDENT_INCR - indentShift),
      g_Statement[statemNum].labelName, " $", chr(g_Statement[statemNum].type),
      "  \"", edit(outputStr, 8 + 128), "\"", NULL));

  if (len(outputStr) > MAX_LINE_LEN + (g_screenWidth - MAX_LINE_LEN)) {
    let(&outputStr, cat(left(outputStr,
        MAX_LINE_LEN + (g_screenWidth - MAX_LINE_LEN) - 3), "...", NULL));
  }

  if (g_Statement[statemNum].type == p_ || g_Statement[statemNum].type == a_) {
    /* Only print assertions to reduce output bulk */
    print2("%s\n", outputStr);
  }

  if (g_Statement[statemNum].type != p_) {
    free_vstring(outputStr);
    return;
  }

  if (endIndent) {
    /* An indentation level limit is set */
    if (endIndent < recursDepth + 2) {
      free_vstring(outputStr);
      return;
    }
  }

  /* Don't use bad proofs (incomplete proofs are ok) */
  if (parseProof(statemNum) > 1) {
    /* The proof has an error, so use the empty proof */
    nmbrLet(&proof, nmbrAddElement(NULL_NMBRSTRING, -(long)'?'));
  } else {
    nmbrLet(&proof, g_WrkProof.proofString);
  }

  plen = nmbrLen(proof);
  /* Get the essential step flags, if required */
  if (essentialFlag) {
    nmbrLet(&essentialFlags, nmbrGetEssential(proof));
  }
  nmbrLet(&localFoundList, NULL_NMBRSTRING);
  nmbrLet(&localPrintedList, NULL_NMBRSTRING);
  for (step = 0; step < plen; step++) {
    if (essentialFlag) {
      if (!essentialFlags[step]) continue;
                                                /* Ignore floating hypotheses */
    }
    stmt = proof[step];
    if (stmt < 0) {
      if (stmt > -1000) {
        /* '?' */
        unprovedFlag = 1;
      }
      continue; /* Ignore '?' and local labels */
    }
    if (!nmbrElementIn(1, localFoundList, stmt)) {
      nmbrLet(&localFoundList, nmbrAddElement(localFoundList, stmt));
    }
    if (!nmbrElementIn(1, stmtFoundList, stmt)) {
      traceProofTreeRec(stmt, essentialFlag, endIndent, recursDepth + 1);
      nmbrLet(&localPrintedList, nmbrAddElement(localPrintedList, stmt));
      nmbrLet(&stmtFoundList, nmbrAddElement(stmtFoundList, stmt));
    }
  } /* Next step */

  /* See if there are any old statements printed previously */
  slen = nmbrLen(localFoundList);
  let(&outputStr, "");
  for (pos = 0; pos < slen; pos++) {
    stmt = localFoundList[pos];
    if (!nmbrElementIn(1, localPrintedList, stmt)) {
      /* Don't include $f, $e in output */
      if (g_Statement[stmt].type == p_ || g_Statement[stmt].type == a_) {
        let(&outputStr, cat(outputStr, " ",
            g_Statement[stmt].labelName, NULL));
      }
    }
  }

  if (len(outputStr)) {
    printLongLine(cat(space(INDENT_INCR * (recursDepth + 1) - 1 - indentShift),
      outputStr, " (shown above)", NULL),
      space(INDENT_INCR * (recursDepth + 2) - indentShift), " ");
  }

  if (unprovedFlag) {
    printLongLine(cat(space(INDENT_INCR * (recursDepth + 1) - indentShift),
      "*** Statement ", g_Statement[statemNum].labelName, " has not been proved."
      , NULL),
      space(INDENT_INCR * (recursDepth + 2)), " ");
  }

  free_vstring(outputStr);
  free_nmbrString(localFoundList);
  free_nmbrString(localPrintedList);
  free_nmbrString(proof);
  free_nmbrString(essentialFlags);
} /* traceProofTreeRec */

/* Called by SHOW TRACE_BACK <label> / COUNT_STEPS */
/* Counts the number of steps a completely exploded proof would require */
/* (Recursive) */
/* 0 is returned if some assertions have incomplete proofs. */
double countSteps(long statemNum, flag essentialFlag)
{
  static double *stmtCount;
  static double *stmtNodeCount;
  static long *stmtDist;
  static long *stmtMaxPath;
  static double *stmtAveDist;
  static long *stmtProofLen; /* The actual number of steps in stmt's proof */
  static long *stmtUsage; /* The number of times the statement is used */
  static long level = 0;
  static flag unprovedFlag;

  long stmt, plen, step, i, j, k;
  long essentialplen;
  nmbrString_def(proof);
  double stepCount; /* The total steps if fully expanded */

  static vstring *stmtBigCount; /* Unlimited precision stmtCount */
  vstring_def(stepBigCount); /* Unlimited precision stepCount */
  vstring_def(tmpBig1);

  double stepNodeCount;
  double stepDistSum;
  nmbrString_def(essentialFlags);
  vstring_def(tmpStr);
  long actualSteps, actualSubTheorems;
  long actualSteps2, actualSubTheorems2;

  /* Initialization to avoid compiler warning (should not be theoretically
     necessary) */
  essentialplen = 0;

  /* If this is the top level of recursion, initialize things */
  if (!level) {
    stmtCount = malloc((sizeof(double) * ((size_t)g_statements + 1)));
    stmtBigCount = malloc((sizeof(vstring) * ((size_t)g_statements + 1)));
    stmtNodeCount = malloc(sizeof(double) * ((size_t)g_statements + 1));
    stmtDist = malloc(sizeof(long) * ((size_t)g_statements + 1));
    stmtMaxPath = malloc(sizeof(long) * ((size_t)g_statements + 1));
    stmtAveDist = malloc(sizeof(double) * ((size_t)g_statements + 1));
    stmtProofLen = malloc(sizeof(long) * ((size_t)g_statements + 1));
    stmtUsage = malloc(sizeof(long) * ((size_t)g_statements + 1));
    if (!stmtCount || !stmtNodeCount || !stmtDist || !stmtMaxPath ||
        !stmtAveDist || !stmtProofLen || !stmtUsage) {
      print2("?Memory overflow.  Step count will be wrong.\n");
      if (stmtCount) free(stmtCount);
      if (stmtBigCount) free(stmtBigCount);
      if (stmtNodeCount) free(stmtNodeCount);
      if (stmtDist) free(stmtDist);
      if (stmtMaxPath) free(stmtMaxPath);
      if (stmtAveDist) free(stmtAveDist);
      if (stmtProofLen) free(stmtProofLen);
      if (stmtUsage) free(stmtUsage);
      return (0);
    }
    for (stmt = 1; stmt < g_statements + 1; stmt++) {
      stmtCount[stmt] = 0;
      stmtBigCount[stmt] = "";
      stmtUsage[stmt] = 0;
      stmtDist[stmt] = 0;
    }
    unprovedFlag = 0; /* Flag that some proof wasn't complete */
  }
  level++;
  stepCount = 0;
  let(&stepBigCount, "0"); /* "" and "0" both mean 0 */
  stepNodeCount = 0;
  stepDistSum = 0;
  stmtDist[statemNum] = -2; /* Forces at least one assignment */

  if (g_Statement[statemNum].type != (char)p_) {
    /* $a, $e, or $f */
    stepCount = 1;
    let(&stepBigCount, "1");
    stepNodeCount = 0;
    stmtDist[statemNum] = 0;
    goto returnPoint;
  }

  /* Don't use bad proofs (incomplete proofs are ok) */
  if (parseProof(statemNum) > 1) {
    /* The proof has an error, so use the empty proof */
    nmbrLet(&proof, nmbrAddElement(NULL_NMBRSTRING, -(long)'?'));
  } else {
    /* Use proof as it is saved (so user can choose compressed or not) */
    nmbrLet(&proof, g_WrkProof.proofString); /* The proof */
  }

  plen = nmbrLen(proof);
  /* Get the essential step flags, if required */
  if (essentialFlag) {
    nmbrLet(&essentialFlags, nmbrGetEssential(proof));
  }
  essentialplen = 0;
  for (step = 0; step < plen; step++) {
    /* Use the following loop to get an alternate maximum path */
    if (essentialFlag) {
      if (!essentialFlags[step]) continue;     /* Ignore floating hypotheses */
    }
    essentialplen++;
    stmt = proof[step];
    if (stmt < 0) {
      if (stmt <= -1000) {
        /* User can choose to count compressed or normal steps by saving
           the proof that way */
        /* A local label does not add a proof step in the web page proof */
        continue;
      } else {
        /* '?' */
        unprovedFlag = 1;
        stepCount = stepCount + 1;

        free_vstring(tmpBig1);
        tmpBig1 = bigAdd(stepBigCount, "1");
        let(&stepBigCount, tmpBig1);

        stepNodeCount = stepNodeCount + 1;
        stepDistSum = stepDistSum + 1;
      }
    } else {
      if (stmtCount[stmt] == 0) {
        /* It has not been computed yet - call this function recursively */
        stepCount = stepCount + countSteps(stmt, essentialFlag);
      } else {
        /* It has already been computed */
        stepCount = stepCount + stmtCount[stmt];
      }

      /* In either case, stmtBigCount[stmt] will be populated now */
      free_vstring(tmpBig1);
      tmpBig1 = bigAdd(stepBigCount, stmtBigCount[stmt]);
      let(&stepBigCount, tmpBig1);

      if (g_Statement[stmt].type == (char)p_) {
        /*stepCount--;*/ /* -1 to account for the replacement of this step */
        for (j = 0; j < g_Statement[stmt].numReqHyp; j++) {
          k = g_Statement[stmt].reqHypList[j];
          if (!essentialFlag || g_Statement[k].type == (char)e_) {
            stepCount--;

            /* In either case, stmtBigCount[stmt] will be populated now */
            free_vstring(tmpBig1);
            tmpBig1 = bigSub(stepBigCount, "1");
            let(&stepBigCount, tmpBig1);
          }
        }
      }
      stmtUsage[stmt]++;
      if (stmtDist[statemNum] < stmtDist[stmt] + 1) {
        stmtDist[statemNum] = stmtDist[stmt] + 1;
        stmtMaxPath[statemNum] = stmt;
      }
      stepNodeCount = stepNodeCount + stmtNodeCount[stmt];
      stepDistSum = stepDistSum + stmtAveDist[stmt] + 1;
    }
  } /* Next step */

 returnPoint:

  /* Assign step count to statement list */
  stmtCount[statemNum] = stepCount;

  if ((stmtBigCount[statemNum])[0] != 0) bug(264);
  let(&stmtBigCount[statemNum], stepBigCount);

  stmtNodeCount[statemNum] = stepNodeCount + 1;
  stmtAveDist[statemNum] = (double)stepDistSum / (double)essentialplen;
  stmtProofLen[statemNum] = essentialplen;

  free_nmbrString(proof);
  free_nmbrString(essentialFlags);

  level--;
  /* If this is the top level of recursion, deallocate */
  if (!level) {
    if (unprovedFlag) stepCount = 0; /* Don't mislead user */

    /* Compute the total actual steps, total actual subtheorems */
    actualSteps = stmtProofLen[statemNum];
    actualSubTheorems = 0;
    actualSteps2 = actualSteps; /* Steps w/ single-use subtheorems eliminated */
    actualSubTheorems2 = 0; /* Multiple-use subtheorems only */
    for (i = 1; i < statemNum; i++) {
      if (g_Statement[i].type == (char)p_ && stmtCount[i] != 0) {
        actualSteps = actualSteps + stmtProofLen[i];
        actualSubTheorems++;
        if (stmtUsage[i] > 1) {
          actualSubTheorems2++;
          actualSteps2 = actualSteps2 + stmtProofLen[i];
        } else {
          actualSteps2 = actualSteps2 + stmtProofLen[i] - 1;
          for (j = 0; j < g_Statement[i].numReqHyp; j++) {
            /* Subtract out hypotheses if subtheorem eliminated */
            k = g_Statement[i].reqHypList[j];
            if (!essentialFlag || g_Statement[k].type == (char)e_) {
              actualSteps2--;
            }
          }
        }
      }
    }

    j = statemNum;
    for (i = stmtDist[statemNum]; i >= 0; i--) {
      if (stmtDist[j] != i) bug(214);
      let(&tmpStr, cat(tmpStr, " <- ", g_Statement[j].labelName,
          NULL));
      j = stmtMaxPath[j];
    }
    printLongLine(cat(
       "The statement's actual proof has ",
           str((double)(stmtProofLen[statemNum])), " steps.  ",
       "Backtracking, a total of ", str((double)actualSubTheorems),
           " different subtheorems are used.  ",
       "The statement and subtheorems have a total of ",
           str((double)actualSteps), " actual steps.  ",
       "If subtheorems used only once were eliminated,",
           " there would be a total of ",
           str((double)actualSubTheorems2), " subtheorems, and ",
       "the statement and subtheorems would have a total of ",
           str((double)actualSteps2), " steps.  ",
       "The proof would have ",

       stepBigCount,
       strlen(stepBigCount) < 6 ? ""
           : cat(" =~ ",
                 left(
                    str((double)
                        ((5.0 + val(left(stepBigCount, 3))) / 100.0)),
                    3),
                 " x 10^",
                 str((double)strlen(stepBigCount) - 1), NULL),

       " steps if fully expanded back to axiom references.  ",
       "The maximum path length is ",
       str((double)(stmtDist[statemNum])),
       ".  A longest path is:  ", right(tmpStr, 5), " .", NULL),
       "", " ");
    free_vstring(tmpStr);

    free(stmtCount);
    free(stmtNodeCount);
    free(stmtDist);
    free(stmtMaxPath);
    free(stmtAveDist);
    free(stmtProofLen);
    free(stmtUsage);

    /* Deallocate the big number strings */
    for (stmt = 1; stmt < g_statements + 1; stmt++) {
      free_vstring(stmtBigCount[stmt]);
    }
    free(stmtBigCount);
  }

  /* Deallocate local strings */
  free_vstring(tmpBig1);
  free_vstring(stepBigCount);

  return stepCount;
} /* countSteps */

/* Add two arbitrary precision nonnegative integers represented
   as strings of digits e.g. bigAdd("1234", "55") returns "1289".
   Zero can be represented by "", "0", "00", etc. */
/* This is a slow, unsophisticated algorithm intended for use by
   countSteps() i.e. SHOW TRACE_BACK .../COUNT_STEPS */
/* The caller must deallocate the returned string, and the string arguments
   must not be volatile i.e. will not be freed by unrelated 'let()' */
vstring bigAdd(vstring bignum1, vstring bignum2) {
  long len1, len2, maxlen, p, p1, p2, p3;
  char d1, d2, carry, dsum;
  vstring_def(bignum3);
  len1 = (long)strlen(bignum1);
  len2 = (long)strlen(bignum2);
  maxlen = (len1 < len2 ? len2 : len1);
  let(&bignum3, space(maxlen + 1)); /* +1 to allow for final carry */
  carry = 0;
  for (p = 1; p <= maxlen; p++) {
    p1 = len1 - p;
    p2 = len2 - p;
    d1 = (char)(p1 >= 0 ? bignum1[p1] - '0' : 0);
    d2 = (char)(p2 >= 0 ? bignum2[p2] - '0' : 0);
    dsum = (char)(d1 + d2 + carry);
    if (dsum > 9) {
      dsum = (char)(dsum - 10);
      carry = 1;
    } else {
      carry = 0;
    }
    p3 = maxlen + 1 - p;
    bignum3[p3] = (char)(dsum + '0');
  }
  bignum3[0] = (char)(carry + '0');
  while (bignum3[0] == '0') {
    /* Suppress leading 0s */
    let(&bignum3, right(bignum3, 2));
  }
  return bignum3;
}

/* Subtract a nonnegative number (2nd arg) from a larger nonnegative number
   (1st arg).  If the 1st arg is smaller than the 2nd, results are
   not meaningful; there is no error checking for this.  */
/* This is a slow, unsophisticated algorithm intended for use by
   countSteps() i.e. SHOW TRACE_BACK .../COUNT_STEPS */
/* The caller must deallocate the returned string */
/* The arguments must be strings that will not be freed by unrelated 'let()' */
vstring bigSub(vstring bignum1, vstring bignum2) {
  long len1, len3, p;
  vstring_def(bignum3);
  vstring_def(bignum1cmpl);
  len1 = (long)strlen(bignum1);
  let(&bignum1cmpl, space(len1));
  for (p = 0; p <= len1 - 1; p++) {
    /* Take 9s complement of 1st arg */
    bignum1cmpl[p] = (char)(9 - (bignum1[p] - '0') + '0');
  }
  bignum3 = bigAdd(bignum1cmpl, bignum2);
  len3 = (long)strlen(bignum3);
  if (len3 < len1) {
    /* We need to pad 0s before taking 9s complement */
    let(&bignum3, cat(string(len1 - len3, '0'), bignum3, NULL));
    len3 = len1;
  }
  for (p = 0; p <= len3 - 1; p++) {
    /* Take 9s complement of result */
    bignum3[p] = (char)(9 - (bignum3[p] - '0') + '0');
  }
  while (bignum3[0] == '0') {
    /* Suppress leading 0s */
    let(&bignum3, right(bignum3, 2));
  }
  free_vstring(bignum1cmpl); /* Deallocate */
  return bignum3;
}

/**** 12-Nov-2018 nm In case multiplication is ever needed, this
  code will do it but is commented out because currently there
  is no need for it.
****************************************************************************
/@ Multiply an arbitrary precision nonnegative integers by a positive
   digit e.g. bigMulDigit("123", 9) returns "1107".
   Zero can be represented by "", "0", "00", etc. @/
/@ This is a slow, unsophisticated algorithm intended for use by
   SHOW TRACE_BACK .../COUNT_STEPS @/
/@ The caller must deallocate the returned string @/
/@ The arguments must be strings that will not be freed by unrelated 'let()' @/
vstring bigMulDigit(vstring bignum1, long digit) {
  long len1, p, p1, p3;
  char d1, carry, dprod;
  vstring_def(bignum3);
  len1 = (long)strlen(bignum1);
  let(&bignum3, space(len1 + 1)); /@ +1 to allow for final carry @/
  carry = 0;
  for (p = 1; p <= len1; p++) {
    p1 = len1 - p;
    d1 = (char)(bignum1[p1] - '0');
    dprod = (char)((d1 @ digit) + carry);
    if (dprod > 9) {
      carry = dprod / 10;
      dprod = dprod % 10;
    } else {
      carry = 0;
    }
    p3 = len1 + 1 - p;
    bignum3[p3] = (char)(dprod + '0');
  }
  bignum3[0] = (char)(carry + '0');
  while (bignum3[0] == '0') {
    /@ Suppress leading 0s @/
    let(&bignum3, right(bignum3, 2));
  }
  return bignum3;
}

/@ Multiply two arbitrary precision nonnegative integers represented
   as strings of digits e.g. bigMul("1234", "55") returns "67870".
   Zero can be represented by "", "0", "00", etc. @/
/@ This is a slow, unsophisticated algorithm intended for use by
   SHOW TRACE_BACK .../COUNT_STEPS @/
/@ The caller must deallocate the returned string @/
/@ The arguments must be strings that will not be freed by 'let()' @/
vstring bigMul(vstring bignum1, vstring bignum2) {
  long len2, p, p2;
  char d2;
  vstring_def(bignum3);
  vstring_def(bigdprod);
  vstring_def(bigpprod);
  len2 = (long)strlen(bignum2);
  for (p = 1; p <= len2; p++) {
    p2 = len2 - p;
    d2 = (char)(bignum2[p2] - '0');
    if (d2 > 0) {
      free_vstring(bigdprod);
      bigdprod = bigMulDigit(bignum1, d2);
      if (p > 1) {
        /@ Shift the digit product by adding trailing 0s @/
        let(&bigdprod, cat(bigdprod, string(p - 1, '0'), NULL));
      }
      free_vstring(bigpprod);
      bigpprod = bigAdd(bignum3, bigdprod); /@ Accumulate partial product @/
      let(&bignum3, bigpprod);
    }
  } /@ next p @/
  free_vstring(bigdprod);
  free_vstring(bigpprod);
  return bignum3;
}
**** end commented out section added 12-Nov-2018 ***/

/* Traces what statements require the use of a given statement */
/* The output string must be deallocated by the user. */
/* The return string [0] will be 'Y' or 'N' depending on whether there are any
   statements that use statemNum.  Return string [i] will be 'Y' or 'N'
   depending on whether g_Statement[i] uses statemNum.  All i will be populated
   with 'Y'/'N' even if not $a or $p (always 'N' for non-$a,$p). */
/* Optional 'cutoffStmt' parameter:  if nonzero, then
   statements above cutoffStmt will not be scanned (for speedup) */
vstring traceUsage(long statemNum,
  flag recursiveFlag,
  long cutoffStmt /* for speedup */) {

  long lastPos, stmt, slen, pos;
  flag tmpFlag;
  vstring_def(statementUsedFlags); /* 'Y'/'N' flag that statement is used */
  nmbrString_def(statementList);
  nmbrString_def(proof);

  /* For speed-up code */
  char *fbPtr;
  char *fbPtr2;
  char zapSave;
  flag notEFRec; /* Not ($e or $f or recursive) */

  if (g_Statement[statemNum].type == e_ || g_Statement[statemNum].type == f_
      || recursiveFlag) {
    notEFRec = 0;
  } else {
    notEFRec = 1;
  }

  nmbrLet(&statementList, nmbrAddElement(statementList, statemNum));
  lastPos = 1;

  /* For speedup (in traceProofWork), scan only up to cutoffStmt if it
     is specified, otherwise scan all statements. */
  if (cutoffStmt == 0) cutoffStmt = g_statements;

  /*for (stmt = statemNum + 1; stmt <= g_statements; stmt++) {*/ /* Scan all stmts*/
  for (stmt = statemNum + 1; stmt <= cutoffStmt; stmt++) { /* Scan stmts*/
    if (g_Statement[stmt].type != p_) continue; /* Ignore if not $p */

    /* Speed up:  Do a character search for the statement label in the proof,
       before parsing the proof.  Skip this if the label refers to a $e or $f
       because these might not have their labels explicit in a compressed
       proof.  Also, bypass speed up in case of recursive search. */
    if (notEFRec) {
      fbPtr = g_Statement[stmt].proofSectionPtr; /* Start of proof */
      if (fbPtr[0] == 0) { /* The proof was never assigned */
        continue; /* Don't bother */
      }
      fbPtr = fbPtr + whiteSpaceLen(fbPtr); /* Get past white space */
      if (fbPtr[0] == '(') { /* "(" is flag for compressed proof */
        fbPtr2 = fbPtr;
        while (fbPtr2[0] != ')') {
          fbPtr2++;
          if (fbPtr2[0] == 0) bug(217); /* Didn't find closing ')' */
        }
      } else {
        /* A non-compressed proof; use whole proof */
        fbPtr2 = g_Statement[stmt].proofSectionPtr +
            g_Statement[stmt].proofSectionLen;
      }
      zapSave = fbPtr2[0];
      fbPtr2[0] = 0; /* Zap source for character string termination */
      if (!instr(1, fbPtr, g_Statement[statemNum].labelName)) {
        fbPtr2[0] = zapSave; /* Restore source buffer */
        /* There is no string match for label in proof; don't bother to
           parse. */
        continue;
      } else {
        /* The label was found in the ASCII source.  Proceed with parse. */
        fbPtr2[0] = zapSave; /* Restore source buffer */
      }
    } /* (End of speed-up code) */

    /* Don't use bad proofs (incomplete proofs are ok) */
    if (parseProof(stmt) > 1) {
      /* The proof has an error, so use the empty proof */
      nmbrLet(&proof, nmbrAddElement(NULL_NMBRSTRING, -(long)'?'));
    } else {
      nmbrLet(&proof, g_WrkProof.proofString);
    }

    tmpFlag = 0;
    for (pos = 0; pos < lastPos; pos++) {
      if (nmbrElementIn(1, proof, statementList[pos])) {
        tmpFlag = 1;
        break;
      }
    }
    if (!tmpFlag) continue;
    /* The traced statement is used in this proof */
    /* Add this statement to the statement list */
    nmbrLet(&statementList, nmbrAddElement(statementList, stmt));
    if (recursiveFlag) lastPos++;
  } /* Next stmt */

  slen = nmbrLen(statementList);

  /* Prepare the output */
  /* First, fill in the statementUsedFlags char array.  This allows us to sort
     the output by statement number without calling a sort routine. */
  let(&statementUsedFlags, string(g_statements + 1, 'N')); /* Init. to 'no' */
  if (slen > 1) statementUsedFlags[0] = 'Y';  /* Used by at least one */
  for (pos = 1; pos < slen; pos++) { /* Start with 1 (ignore traced statement)*/
    stmt = statementList[pos];
    if (stmt <= statemNum || g_Statement[stmt].type != p_ || stmt > g_statements)
        bug(212);
    statementUsedFlags[stmt] = 'Y';
  }
  free_nmbrString(statementList);
  free_nmbrString(proof);
  return statementUsedFlags;
} /* traceUsage */

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

/* This function implements the WRITE SOURCE command. */
/* Note that the labelSection, mathSection, and proofSection do not
   contain keywords ($a, $p,...; $=; $.).  The keywords are added
   by outputStatement. */
void writeSource(
  flag reformatFlag /* 1 = "/ FORMAT", 2 = "/REWRAP" */,
  flag splitFlag,  /* /SPLIT - write out separate $[ $] includes */
  flag noVersioningFlag, /* /NO_VERSIONING - no ~1 backup */
  flag keepSplitsFlag, /* /KEEP_INCLUDES - don't delete included
                        files when /SPIT is not specified */
  vstring extractLabelList /* "" means /EXTRACT wasn't specified */
  )
{

  /* Temporary variables and strings */
  long i;
  vstring_def(buffer);
  vstring_def(fullOutput_fn);
  FILE *fp;

  let(&fullOutput_fn, cat(g_rootDirectory, g_output_fn, NULL));

  if (splitFlag == 0 /* If 1, it will have message from writeSplitSource() */
      && extractLabelList[0] == 0) {  /* If non-zero, it will have messages
                     from writeExtractedSource() */
    print2("Writing \"%s\"...\n", fullOutput_fn);
  }

  if (extractLabelList[0] != 0) {
    writeExtractedSource(
       extractLabelList, /* EXTRACT label list argument provided by user */
       fullOutput_fn,
       noVersioningFlag
       );
    /* All the writing was done by writeExtractedSource() so just return */
    goto RETURN_POINT;
  }

  if (reformatFlag > 0) {
    /* Now the outputSource function just reformats and puts the
       source back into the g_Statement[] array.  So we don't need
       to do it when we're not reformatting/wrapping */
    /* TODO: turn this into a REWRAP command */
    /* Process statements */
    for (i = 1; i <= g_statements + 1; i++) {
      free_vstring(buffer); /* Deallocate vstring */

      buffer = outputStatement(i, reformatFlag);
    } /* next i */
  } /* if (reformatFlag > 0) */

  /* Get put the g_Statement[] array into one linear buffer */
  free_vstring(buffer);
  buffer = writeSourceToBuffer();
  if (splitFlag == 1) { /* Write includes as separate files */

    /* Make sure we aren't overwriting one of the include files */
    for (i = 1; i <= g_includeCalls; i++) {  /* Start at 1 to skip main file */
      if (g_IncludeCall[i].pushOrPop == 0 /* Don't include pop back to main file */
          && !strcmp(g_output_fn, g_IncludeCall[i].included_fn)) {
        print2(
"?The output was not written because the main output file name is\n");
        print2(
"  the same as an included file.  Use a different name.\n");
        goto RETURN_POINT;
      }
    }

    /* Note that writeSplitSource requires a file name without path since
       it is called recursively for file inclusions where path is added */
    writeSplitSource(&buffer, g_output_fn, noVersioningFlag, keepSplitsFlag);
  } else {  /* Write a non-split version */
    fp = fSafeOpen(fullOutput_fn, "w", noVersioningFlag);
    if (fp == NULL) {
      print2("?Error trying to write \"%s\".\n", fp);
    } else {
      fprintf(fp, "%s", buffer); /* Write the non-split output file */
      fclose(fp);
      if (keepSplitsFlag == 0) {
        deleteSplits(&buffer, noVersioningFlag); /* Delete any old includes */
      }
    }
  }

  print2("%ld source statement(s) were written.\n", g_statements);

 RETURN_POINT:
  free_vstring(buffer); /* Deallocate vstring */
  free_vstring(fullOutput_fn); /* Deallocate vstring */
  return;
} /* writeSource */

/* Get info for WRITE SOURCE ... / EXTRACT */
void writeExtractedSource(
    vstring extractLabelList, /* EXTRACT argument provided by user */
    vstring fullOutput_fn,
    flag noVersioningFlag)
{
  vstring_def(statementUsedFlags); /* Y/N flags that statement is used */
  long stmt, stmtj, scpStmt, strtScpStmt, endScpStmt, j, p1, p2, p3, p4;
  vstring_def(extractNeeded);
  nmbrString_def(unprovedList); /* Needed for traceProofWork()
                                                 but not used */
  nmbrString_def(mstring); /* Temporary holder for math string */
  long maxStmt; /* The largest statement number (excluding $t) */
  long hyp, hyps, mtkn, mtkns, dv, dvs;
  long dollarTStmt; /* $t statement */
  vstring_def(dollarTCmt); /* $t comment */
  char zapChar; /* For finding $t statement */
  char *tmpPtr; /* For finding $t statement */
  vstring_def(hugeHdrNeeded); /* N/M/Y that output needs the huge header */
  vstring_def(bigHdrNeeded);                              /* big */
  vstring_def(smallHdrNeeded);                            /* small */
  vstring_def(tinyHdrNeeded);                             /* tiny */
  char hdrNeeded;
  /* The following 8 are needed for getSectionHeadings() */
  vstring_def(hugeHdr);
  vstring_def(bigHdr);
  vstring_def(smallHdr);
  vstring_def(tinyHdr);
  vstring_def(hugeHdrComment);
  vstring_def(bigHdrComment);
  vstring_def(smallHdrComment);
  vstring_def(tinyHdrComment);

  vstring_def(mathTokenDeclared);
  vstring_def(undeclaredC);
  vstring_def(undeclaredV);
  long extractedStmts;
  vstring_def(hdrSuffix);
  FILE *fp;
  vstring_def(buf);

  /* Note that extractNeeded is 1-based to match 1-based
     indices of the g_Statement array.  We also may need labelSection of entry
     g_statements + 1 for text after last statement, which explains the +2. */
  let(&extractNeeded, string(g_statements + 2, 'N'));

  /* First, do the trace_backs for the statements in user's / EXTRACT argument */
  /* By scanning backwards, we get a speedup by not having to trace
     a statement twice, especially if we did "/ EXTRACT *" */
  print2("Tracing back through proofs for $a and $p statements needed...\n");
  if (!strcmp(extractLabelList, "*")) {
    print2(
       "   This may take up to 10 minutes.  (For audio alert when done,\n");
    print2("   type ahead \"b\" then \"<enter>\".)\n");
  }

  for (stmt = g_statements; stmt >= 1; stmt--) {
    if (extractNeeded[stmt] == 'Y') {
      /* We've already traced this back, so skip it */
      continue;
    }
    /* Wildcard matching */
    if (!matchesList(g_Statement[stmt].labelName, extractLabelList, '*', '?'))
      continue;
    if (g_Statement[stmt].type == (char)a_) {
      extractNeeded[stmt] = 'Y'; /* Add in axioms but don't trace */
      continue;
    }
    if (g_Statement[stmt].type != (char)p_)
      continue; /* Not a $p statement; skip it */
    traceProofWork(stmt,
        0, /*essentialFlag,*/
        "", /*traceToList,*/ /* /TO argument of SHOW TRACE_BACK */
        &statementUsedFlags,
        &unprovedList);
    if ((signed)(strlen(statementUsedFlags)) != g_statements + 1) bug(268);
    /* OR in all the statements found by the trace */
    for (stmtj = 1; stmtj <= stmt; stmtj++) {
      if (statementUsedFlags[stmtj] == 'Y')
        extractNeeded[stmtj] = 'Y';
    }
  } /* next stmt */

  /* Next, we add in all necessary  ${ $} scoping statements */
  print2("Determining which ${ and $} scoping statements are needed...\n");
  for (stmt = 1; stmt <= g_statements; stmt++) {
    if (extractNeeded[stmt] == 'Y'
        /* All flagged statements so far will be $a or $p */
        /* Skip the forward $}'s that this loop populates (is it
           necessary? */
        && (g_Statement[stmt].type == a_ || g_Statement[stmt].type == p_)) {
      scpStmt = stmt;
      while (g_Statement[scpStmt].beginScopeStatementNum != 0) {
        /* We're still in an inner scope */
        strtScpStmt = g_Statement[scpStmt].beginScopeStatementNum;
        if (g_Statement[strtScpStmt].type != lb_) bug(269);
        if (extractNeeded[strtScpStmt] == 'Y')
          /* We've already processed this ${ */
          break;
        endScpStmt = g_Statement[strtScpStmt].endScopeStatementNum;
        if (g_Statement[endScpStmt].type != rb_) bug(270);
        extractNeeded[strtScpStmt] = 'Y';
        extractNeeded[endScpStmt] = 'Y';
        scpStmt = strtScpStmt;
      }
    } /* if extraction needed */
  } /* next stmt */

  /* Next, we add in hypotheses and variable declarations for all $a's and $p's */
  print2("Adding in $e and $f hypotheses and $d provisos...\n");
  for (stmt = 1; stmt <= g_statements; stmt++) {
    if (extractNeeded[stmt] == 'Y'
        /* All flagged statements so far will be $a or $p */
        /* Skip the ${'s and $}'s that earlier loop populates (is it
           necessary? */
        && (g_Statement[stmt].type == a_ || g_Statement[stmt].type == p_)) {
      hyps = g_Statement[stmt].numReqHyp;
      for (hyp = 0; hyp < hyps; hyp++) {
        extractNeeded[g_Statement[stmt].reqHypList[hyp]] = 'Y';
      }
      hyps = nmbrLen(g_Statement[stmt].optHypList);
      for (hyp = 0; hyp < hyps; hyp++) {
        extractNeeded[g_Statement[stmt].optHypList[hyp]] = 'Y';
      }
      mtkns = nmbrLen(g_Statement[stmt].reqVarList);
      for (mtkn = 0; mtkn < mtkns; mtkn++) {
        /* Flag the $v statement for a required variable */
        /* (This may be redundant because of next stmt loop below) */
        extractNeeded[g_MathToken[
            (g_Statement[stmt].reqVarList)[mtkn]].statement] = 'Y';
      }
      mtkns = nmbrLen(g_Statement[stmt].optVarList);
      for (mtkn = 0; mtkn < mtkns; mtkn++) {
        /* Flag the $v statement for an optional variable */
        extractNeeded[g_MathToken[
            (g_Statement[stmt].optVarList)[mtkn]].statement] = 'Y';
      }
      dvs = nmbrLen(g_Statement[stmt].reqDisjVarsStmt);
      for (dv = 0; dv < dvs; dv++) {
        /* Flag the $d statement */
        extractNeeded[(g_Statement[stmt].reqDisjVarsStmt)[dv]] = 'Y';
      }
      dvs = nmbrLen(g_Statement[stmt].optDisjVarsStmt);
      for (dv = 0; dv < dvs; dv++) {
        /* Flag the $d statement */
        extractNeeded[(g_Statement[stmt].optDisjVarsStmt)[dv]] = 'Y';
      }
    } /* if extraction needed */
  } /* next stmt */

  /* Next, add in the $c, $v required by all statements */
  print2("Determining which $c and $v statements are needed...\n");
  for (stmt = 1; stmt <= g_statements; stmt++) {
    if (extractNeeded[stmt] == 'Y'
        /* All $a, $p, $f, $e */
        && (g_Statement[stmt].type == a_
             || g_Statement[stmt].type == p_
             || g_Statement[stmt].type == e_
             || g_Statement[stmt].type == f_
           )) {
      nmbrLet(&mstring, g_Statement[stmt].mathString);
      mtkns = g_Statement[stmt].mathStringLen;
      for (mtkn = 0; mtkn < mtkns; mtkn++) {
        /* Flag the $c or $v statement for the token */
        extractNeeded[g_MathToken[mstring[mtkn]].statement] = 'Y';
      }
    } /* if extract needed */
  } /* next stmt */

  /* Get largest statement number (excluding $t comment) */
  maxStmt = 0;
  for (stmt = g_statements; stmt >= 1; stmt--) {
    if (extractNeeded[stmt] == 'Y') {
      maxStmt = stmt;
      break;
    }
  }

  /* Find the $t statement */  /* (Should this be done globally somewhere?) */
  print2("Locating the $t statement if any...\n");
  dollarTStmt = 0;
  let(&dollarTCmt, "");
  /* Note that g_Statement[g_statements + 1] is a special (empty) statement whose
     labelSection holds any comment after the last statement.  It is possible
     that the $t statement could be there. */
  for (stmt = 1; stmt <= g_statements + 1; stmt++) {
    /* We do low-level zapping in the xxx.mm input file buffer for speed */
    tmpPtr = g_Statement[stmt].labelSectionPtr;
    j = g_Statement[stmt].labelSectionLen;
    zapChar = tmpPtr[j]; /* Save the original character */
    tmpPtr[j] = 0; /* Create an end-of-string */
    p1 = instr(1, tmpPtr, "$t");
    if (p1 != 0) { /* Found the $t */
      dollarTStmt = stmt;
      /* Get the full $t comment */
      p2 = instr(p1, tmpPtr, "$)");
      let(&dollarTCmt, left(tmpPtr, p2 + 1));
      /* We need the above because rinstr doesn't have starting arg */
      p1 = rinstr(dollarTCmt, "$(");
      /* Search backwards for non-space or beginning of string */
      p1--;
      while (p1 != 0) {
        if (dollarTCmt[p1 - 1] != ' ') break;
        p1--;
      }
      let(&dollarTCmt, cat("\n", seg(dollarTCmt, p1 + 1, p2 + 1), NULL));
    }
    tmpPtr[j] = zapChar; /* Restore the xxx.mm input file buffer */
    if (dollarTStmt != 0) {
      break; /* Found the $t, so no reason to continue */
    }
  }

  /* Get header information about which headers to use */
  print2("Analyzing scopes of section headings...\n");
  let(&hugeHdrNeeded, string(g_statements + 2, 'N'));
  let(&bigHdrNeeded, string(g_statements + 2, 'N'));
  let(&smallHdrNeeded, string(g_statements + 2, 'N'));
  let(&tinyHdrNeeded, string(g_statements + 2, 'N'));
  /* Scan the database to determine which headers exist */
  for (stmt = 1; stmt <= maxStmt; stmt++) {
    getSectionHeadings(stmt, &hugeHdr, &bigHdr, &smallHdr,
        &tinyHdr,
        &hugeHdrComment, &bigHdrComment, &smallHdrComment,
        &tinyHdrComment,
        1, /* fineResolution */
        1 /* fullComment */);
    if (hugeHdr[0] != 0) hugeHdrNeeded[stmt] = '?'; /* Don't know yet */
    if (bigHdr[0] != 0) bigHdrNeeded[stmt] = '?';
    if (smallHdr[0] != 0) smallHdrNeeded[stmt] = '?';
    if (tinyHdr[0] != 0) tinyHdrNeeded[stmt] = '?';
  } /* next stmt */

  /* For each tiny header, scan until next tiny, small, big, or huge header
     is found (which means end of the tiny header's scope).  Set '?' to
     'Y' if a used stmt is found along the way (meaning the header should
     be in the output file) or to 'N' otherwise.  Then do the same starting
     from small, then big, then huge header. */
  for (stmt = 1; stmt <= maxStmt; stmt++) {
    /* We do ALL statements, not just $a, $p, so that headers will go to
       the right place in the output file.  We called getSectionHeadings()
       with fineResolution=1 above so that "header area" will be 1 statement
       rather than the multiple-statement content between successive $a/$p
       statements. */
    if (tinyHdrNeeded[stmt] == '?') {
      hdrNeeded = 0;
      for (stmtj = stmt; stmtj <= maxStmt; stmtj++) {
        if (hugeHdrNeeded[stmtj] != 'N' || bigHdrNeeded[stmtj] != 'N'
            || smallHdrNeeded[stmtj] != 'N' || tinyHdrNeeded[stmtj] != 'N') {
          /* The scope of header at stmt has ended with no used statement
             found, so header is not needed; abort the scan */
          if (stmtj > stmt) break; /* Ignore starting point of scan since we
              are looking for a later header to end the scope */
        }
        if (extractNeeded[stmtj] == 'Y') {
          hdrNeeded = 1;
          /* We now know the header is needed, so abort the scan */
          break;
        }
      }
      if (hdrNeeded == 1) {
        tinyHdrNeeded[stmt] = 'Y';
      } else {
        tinyHdrNeeded[stmt] = 'N';
      }
    } /* if tinyHdrNeeded[stmt] == '?' */
    if (smallHdrNeeded[stmt] == '?') {
      hdrNeeded = 0;
      for (stmtj = stmt; stmtj <= maxStmt; stmtj++) {
        if (hugeHdrNeeded[stmtj] != 'N' || bigHdrNeeded[stmtj] != 'N'
            || smallHdrNeeded[stmtj] != 'N') {
          /* The scope of header at stmt has ended with no used statement
             found, so header is not needed; abort the scan */
          if (stmtj > stmt) break; /* Ignore starting point of scan since we
              are looking for a later header to end the scope */
        }
        if (extractNeeded[stmtj] == 'Y') {
          hdrNeeded = 1;
          /* We now know the header is needed, so abort the scan */
          break;
        }
      }
      if (hdrNeeded == 1) {
        smallHdrNeeded[stmt] = 'Y';
      } else {
        smallHdrNeeded[stmt] = 'N';
      }
    } /* if smallHdrNeeded[stmt] == '?' */
    if (bigHdrNeeded[stmt] == '?') {
      hdrNeeded = 0;
      /*for (stmtj = stmt + 1; stmtj <= maxStmt; stmtj++) {*/
      for (stmtj = stmt; stmtj <= maxStmt; stmtj++) {
        if (hugeHdrNeeded[stmtj] != 'N' || bigHdrNeeded[stmtj] != 'N') {
          /* The scope of header at stmt has ended with no used statement
             found, so header is not needed; abort the scan */
          if (stmtj > stmt) break;
        }
        if (extractNeeded[stmtj] == 'Y') {
          hdrNeeded = 1;
          /* We now know the header is needed, so abort the scan */
          break;
          /*if (stmtj > stmt) break;*/ /* Ignore starting point of scan since we
              are looking for a later header to end the scope */
        }
      }
      if (hdrNeeded == 1) {
        bigHdrNeeded[stmt] = 'Y';
      } else {
        bigHdrNeeded[stmt] = 'N';
      }
    } /* if bigHdrNeeded[stmt] == '?' */
    if (hugeHdrNeeded[stmt] == '?') {
      hdrNeeded = 0;
      for (stmtj = stmt; stmtj <= maxStmt; stmtj++) {
        if (hugeHdrNeeded[stmtj] != 'N') {
          /* The scope of header at stmt has ended with no used statement
             found, so header is not needed; abort the scan */
          if (stmtj > stmt) break; /* Ignore starting point of scan since we
              are looking for a later header to end the scope */
        }
        if (extractNeeded[stmtj] == 'Y') {
          hdrNeeded = 1;
          /* We now know the header is needed, so abort the scan */
          break;
        }
      }
      if (hdrNeeded == 1) {
        hugeHdrNeeded[stmt] = 'Y';
      } else {
        hugeHdrNeeded[stmt] = 'N';
      }
    } /* if hugeHdrNeeded[stmt] == '?' */
  } /* next stmt */

  /* Collect all $c and $v tokens that are not declared in the
     extract, so they can be included in the output .mm to satisfy
     the htmldefs and for use in ` math ` comment markup */
  print2("Building $c and $v statements for unused math tokens...\n");
  let(&mathTokenDeclared, string(g_mathTokens, 'N'));
  for (stmt = 1; stmt <= g_statements; stmt++) {
    if (extractNeeded[stmt] == 'Y'
       && (g_Statement[stmt].type == c_
           || g_Statement[stmt].type == v_)) {
      mtkns = g_Statement[stmt].mathStringLen;
      for (mtkn = 0; mtkn < mtkns; mtkn++) {
        /* Flag the math token as being declared */
        mathTokenDeclared[(g_Statement[stmt].mathString)[mtkn]] = 'Y';
      }
    }
  }
  /* Build $c and $v statements for undeclared math tokens.  They are used to
     make the database consistent with the htmldef's in the $t comment. */
  let(&undeclaredC, "");
  let(&undeclaredV, "");
  for (mtkn = 0; mtkn < g_mathTokens; mtkn++) {
    if (mathTokenDeclared[mtkn] == 'N') {
      if (g_MathToken[mtkn].tokenType == con_) {
        let(&undeclaredC, cat(undeclaredC, " ", g_MathToken[mtkn].tokenName,
            NULL));
      } else {
        if (g_MathToken[mtkn].tokenType != var_) bug(271);
        /* Before adding it to the unused var list, make sure it isn't declared
           in another scope */
        p1 = 0;
        for (j = 0; j < g_mathTokens; j++) {
          if (j == mtkn) continue;
          if (!strcmp(g_MathToken[mtkn].tokenName, g_MathToken[j].tokenName)) {
            /* See if it the $v was already declared in another scope */
            if (mathTokenDeclared[j] == 'Y') {
              p1 = 1;
              break;
            }
          }
        }
        if (p1 == 0) {
          let(&undeclaredV, cat(undeclaredV, " ", g_MathToken[mtkn].tokenName,
            NULL));
        }
        /* Tag the variable as declared for use in later j loops above, so it
           won't be added to the undeclaredV twice */
        mathTokenDeclared[mtkn] = 'Y';
      }
    }
  } /* next mtkn */

  /* Write the output file */
  /* (We don't call the standard output functions because there's too
     much customization needed) */
  print2("Creating the final output file \"%s\"...\n", fullOutput_fn);

  fp = fSafeOpen(fullOutput_fn, "w", noVersioningFlag);
  if (fp == NULL) {
    print2("?Error trying to write \"%s\".\n", fp);
    goto EXTRACT_RETURN;
  }

  /* Get the first line of the .mm file that normally has version and date */
  /* (The memcpy to buf is not really necessary, just a safety
     measure in case the input file has garbage with no "\n".) */
  let(&buf, space(g_Statement[1].labelSectionLen));
  memcpy(buf, g_Statement[1].labelSectionPtr,
      (size_t)(g_Statement[1].labelSectionLen));
  let(&buf, left(buf, instr(1, buf, "\n") - 1)); /* This will not include the \n */
  let(&buf, right(edit(buf, 8/*leading space*/), 3)); /* Take off $( */
  j = (long)strlen(" Extracted from: ");
  if (!strcmp(left(buf, j), " Extracted from: ")) {
    /* Prevent "Extracted from:" accumulation if sent through /EXTRACT again */
    let(&buf, right(buf, j + 1));
  }
  fprintf(fp, "$( Extracted from: %s", buf);
  if (instr(1, buf, "$)") == 0) fprintf(fp, " $)");
  fprintf(fp,
      "\n$( Created %s %s using \"READ '%s'\" then\n",
      date(), time_(), g_input_fn);
  fprintf(fp,
      "   \"WRITE SOURCE '%s' /EXTRACT %s\" $)",
      fullOutput_fn, extractLabelList);

  extractedStmts = 0; /* How many statements were extracted */
  for (stmt = 1; stmt <= g_statements + 1; stmt++) {
    /* If the header is part of the labelSection of an extracted stmt,
       we don't want to add a newline in order for extractions to be
       stable (i.e. more lines aren't added when we extract from an
       extraction). */
    if (extractNeeded[stmt] == 'Y') {
      let(&hdrSuffix, "");
    } else {
      let(&hdrSuffix, "\n");
    }
    /* Output headers if needed */
    if (hugeHdrNeeded[stmt] == 'Y'
        || bigHdrNeeded[stmt] == 'Y'
        || smallHdrNeeded[stmt] == 'Y'
        || tinyHdrNeeded[stmt] == 'Y') {
      getSectionHeadings(stmt, &hugeHdr, &bigHdr, &smallHdr, &tinyHdr,
          &hugeHdrComment, &bigHdrComment, &smallHdrComment,
          &tinyHdrComment,
          1, /*fineResolution*/
          1 /*fullComment*/
          );
      freeTempAlloc();
      if (hugeHdrNeeded[stmt] == 'Y') {
        fixUndefinedLabels(extractNeeded, &hugeHdrComment);
        fprintf(fp, "%s", cat(hugeHdr, hugeHdrComment, hdrSuffix, NULL));
      }
      if (bigHdrNeeded[stmt] == 'Y') {
        fixUndefinedLabels(extractNeeded, &bigHdrComment);
        fprintf(fp, "%s", cat(bigHdr, bigHdrComment, hdrSuffix, NULL));
      }
      if (smallHdrNeeded[stmt] == 'Y') {
        fixUndefinedLabels(extractNeeded, &smallHdrComment);
        fprintf(fp, "%s", cat(smallHdr, smallHdrComment, hdrSuffix, NULL));
      }
      if (tinyHdrNeeded[stmt] == 'Y') {
        fixUndefinedLabels(extractNeeded, &tinyHdrComment);
        fprintf(fp, "%s", cat(tinyHdr, tinyHdrComment, hdrSuffix, NULL));
      }
    } /* if header(s) needed */

    /* Output $t statement if needed */
    if (dollarTStmt == stmt) {
      fprintf(fp, "\n%s", dollarTCmt);
    }

    /* Output statement if needed */
    if (extractNeeded[stmt] == 'Y') {
      free_vstring(buf);
      buf = getDescriptionAndLabel(stmt);

      fixUndefinedLabels(extractNeeded, &buf);

      fprintf(fp, "%s", buf);
      if (stmt == g_statements + 1) bug(272); /* Text below last statement
           isn't (currently) used - do we need it? */
      if (stmt != g_statements + 1) {
        extractedStmts++; /* For final message */
        fprintf(fp, "$%c", g_Statement[stmt].type);
        if (g_Statement[stmt].type != lb_ && g_Statement[stmt].type != rb_) {
          /* $v $c $d $e $f $a $p */
          let(&buf, space(g_Statement[stmt].mathSectionLen));
          memcpy(buf, g_Statement[stmt].mathSectionPtr,
              (size_t)(g_Statement[stmt].mathSectionLen));
          fprintf(fp, "%s", buf);
          if (g_Statement[stmt].type != p_) {
            fprintf(fp, "$.");
/*D*//*fprintf(fp, "#%ld#",stmt);*/
          } else {
            /* $p */
            fprintf(fp, "$=");
            let(&buf, space(g_Statement[stmt].proofSectionLen));
            memcpy(buf, g_Statement[stmt].proofSectionPtr,
                (size_t)(g_Statement[stmt].proofSectionLen));
            fprintf(fp, "%s$.", buf);
          }
        } /* if not ${ $} */
        if (extractNeeded[stmt + 1] == 'N') {
/*D*//*printf("added \\n stmt=%ld type=%c,%c\n",stmt+1,g_Statement[stmt].type,g_Statement[stmt+1].type);*/
          /* Put a newline following end of statement since the next
             statement's label section will be suppressed */
          fprintf(fp, "\n");
        }
      } /* if (stmt != statements + 1) */
    } /* if (extractNeeded[stmt] == 'Y') */
  } /* next stmt */

  /* Add in unused $c, $v at the end to satisfy htmldefs */
  if (g_outputToString == 1) bug(273); /* Should be turned off here */
  if (g_printString[0] != 0) bug(274);
  g_outputToString = 1;
  if (undeclaredC[0] != 0) {
    print2("\n");
    print2("  $( Unused constants to satisfy "
      "the htmldef's in the $ t comment. $)\n");
    printLongLine(cat("  $c", undeclaredC, " $.", NULL), "    ", " ");
  }
  if (undeclaredV[0] != 0) {
    print2("\n");
    print2("  $( Unused variables to satisfy "
      "the htmldef's in the $ t comment. $)\n");
    printLongLine(cat("  $v", undeclaredV, " $.", NULL), "    ", " ");
  }
  g_outputToString = 0;
  if (g_printString[0] != 0) {
    fprintf(fp, "%s", g_printString);
    free_vstring(g_printString);
  }

  /* Write the non-split output file */
  fclose(fp);
  j = 0; p1 = 0; p2 = 0; p3 = 0; p4 = 0;
  for (stmt = 1; stmt <= g_statements; stmt++) {
    if (extractNeeded[stmt] == 'Y') {
      j++;
      if (g_Statement[stmt].type == a_) {
        p1++;
        if (!strcmp("ax-", left(g_Statement[stmt].labelName, 3))) p3++;
        if (!strcmp("df-", left(g_Statement[stmt].labelName, 3))) p4++;
        freeTempAlloc(); /* Deallocate stack created by left() */
      }
      if (g_Statement[stmt].type == p_) p2++;
    }
  }
  print2(
"Extracted %ld statements incl. %ld $a (%ld \"ax-\", %ld \"df-\"), %ld $p.\n",
      j, p1, p3, p4, p2);

 EXTRACT_RETURN:
  /* Deallocate */
  free_vstring(extractNeeded);
  free_vstring(statementUsedFlags);
  free_nmbrString(unprovedList);
  free_nmbrString(mstring);
  free_vstring(dollarTCmt);
  free_vstring(hugeHdrNeeded);
  free_vstring(bigHdrNeeded);
  free_vstring(smallHdrNeeded);
  free_vstring(tinyHdrNeeded);
  free_vstring(hugeHdr);   /* Deallocate memory */
  free_vstring(bigHdr);   /* Deallocate memory */
  free_vstring(smallHdr); /* Deallocate memory */
  free_vstring(tinyHdr); /* Deallocate memory */
  free_vstring(hugeHdrComment);   /* Deallocate memory */
  free_vstring(bigHdrComment);   /* Deallocate memory */
  free_vstring(smallHdrComment); /* Deallocate memory */
  free_vstring(tinyHdrComment); /* Deallocate memory */
  free_vstring(mathTokenDeclared);
  free_vstring(undeclaredC);
  free_vstring(undeclaredV);
  free_vstring(buf);
  return;
} /* getExtractionInfo */

/* Some labels in comments may not exist in statements extracted
   with WRITE SOURCE ... / EXTRACT.  This function changes them
   to external links to us.metamath.org. */
void fixUndefinedLabels(vstring extractNeeded/*'Y'/'N' list*/,
    vstring *buf/*header comment*/) {
  long p1, p2, p3;
  vstring_def(label);
  vstring_def(newLabelWithTilde);
  vstring_def(restOfComment);
  int mathMode; /* char gives Wconversion gcc warning */
#define ASCII_4 4

  /* Change ~ in math symbols to non-printable ASCII 4 to prevent
     interpretation as label indicator */
  p1 = (long)strlen(*buf);
  mathMode = 0;
  for (p2 = 0; p2 < p1; p2++) {
    if ((*buf)[p2] == '`') {
      mathMode = 1 - mathMode;
      continue;
    }
    if ((*buf)[p2] == '~' && mathMode == 1) {
      (*buf)[p2] = ASCII_4;
    }
  }

  p1 = 0;
  let(&(*buf), cat(*buf, " \n", NULL)); /* Ensure white space after last label */
  while (1) {
    p1 = instr(p1 + 1, *buf, "~");
    if (p1 == 0) break;
    if (p1 - 2 >= 0) { /* Prevent out-of-bounds access */
      if ((*buf)[p1 - 2] == '~') {
        continue; /* it is a ~~ escape; don't process */
      }
    }
    while (1) {
      /* Get beyond any whitespace between ~ and label */
      if ((*buf)[p1 + 1] == 0) break; /* end of string */
      if ((*buf)[p1 + 1] != ' ' && (*buf)[p1 + 1] != '\n') {
        /* Found a non-space character, assume it is start of label */
        break;
      }
      p1++; /* Move past the whitespace */
    }
    if ((*buf)[p1 + 1] == 0) break; /* Ignore stray ~ at end of comment */
    p2 = instr(p1 + 2, *buf, " ");
    p3 = instr(p1 + 2, *buf, "\n");
    if (p3 < p2) p2 = p3;  /* p2 is end of label */
    let(&label, seg(*buf, p1 + 2, p2 - 1));
    let(&restOfComment, right(*buf, p2));
    p3 = lookupLabel(label);
    if (p3 == -1) continue; /* Not a statement label (e.g. ~ http://...) */
    if (extractNeeded[p3] == 'Y') continue; /* Label link won't be broken */
    /* Change label to external link */
    let(&newLabelWithTilde, cat(label,
        "\n ~ http://us.metamath.org/mpeuni/",
        label, ".html", NULL));
    let(&(*buf), cat(left(*buf, p1 - 1), newLabelWithTilde, NULL));
    /* Adjust pointer to go past the modified label */
    p1 = p1 + (long)strlen(newLabelWithTilde)
          - ((long)strlen(label) + 2/*for "~ "*/);
    /* Put newline if not at end of line - assumes no trailing spaces in .mm! */
    /* We do this to prevent too-long lines.  But if we're already at end
       of line, we don't want to create a paragraph, so we don't add newline. */
    if (restOfComment[0] == '\n') {
      let(&(*buf), cat(*buf, restOfComment, NULL));
    } else {
      let(&(*buf), cat(*buf, "\n", restOfComment, NULL));
    }
  }
  let(&(*buf), left(*buf, (long)strlen(*buf) - 2));
       /* Take off the '\n' we added at beginning of this function */

  /* Restore ASCII 4 to ~ */
  p1 = (long)strlen(*buf);
  for (p2 = 0; p2 < p1; p2++) {
    if ((*buf)[p2] == ASCII_4) (*buf)[p2] = '~';
  }

  free_vstring(label); /* Deallocate */
  free_vstring(newLabelWithTilde); /* Deallocate */
  free_vstring(restOfComment); /* Deallocate */
  return;
} /* fixUndefinedLabels */

void writeDict(void)
{
  print2("This function has not been implemented yet.\n");
  return;
} /* writeDict */

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

  /* g_MathToken[g_mathTokens].tokenName is assigned in
     parseMathDecl() by let().  eraseSource() should free every g_MathToken and
     there are (g_mathTokens + g_dummyVars) tokens. */
  for (i = 0; i <= g_mathTokens + g_dummyVars; i++) {
    free_vstring(g_MathToken[i].tokenName);
  }

  memFreePoolPurge(0);
  g_errorCount = 0;

  free(g_Statement);
  free(g_IncludeCall);  /* Will be initialized in initBigArrays */
  free(g_MathToken);
  g_dummyVars = 0; /* For Proof Assistant */
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

  /* 2-Oct-2017 nm Future possibility: add 'reset' parameter to unify() to clear
     the 5 variables below */
  g_bracketMatchInit = 0; /* Clear to force mmunif.c to scan $a's again */
  g_minSubstLen = 1; /* Initialize to the default SET EMPTY_SUBSTITUTION OFF */
  /* Clear g_firstConst to trigger clearing of g_lastConst and
     g_oneConst in mmunif.c */
  free_nmbrString(g_firstConst);
  /* Clear these directly so they will be truly deallocated for valgrind */
  free_nmbrString(g_lastConst);
  free_nmbrString(g_oneConst);

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

void verifyMarkup(vstring labelMatch,
    flag dateCheck, /* 1 = check date consistency */
    flag topDateCheck, /* 1 = check top date */
    flag fileCheck, /* 1 = check external files (gifs and bib) */
    flag underscoreCheck, /* 1 = check labels for "_" characters) */
    flag mathboxCheck, /* 1 = check mathbox cross-references) */
    flag verboseMode) /* 1 = more details */ {
  flag f;
  flag saveHtmlFlag, saveAltHtmlFlag;
  flag errFound = 0;
  long stmtNum, p1, p2, p3;
  long flen, lnum, lstart; /* For line length check */

  vstring_def(mmVersionDate); /* Version date at top of .mm file */
  vstring_def(mostRecentDate); /* For entire .mm file */
  long mostRecentStmt = 0; /* For error message */

  /* For getSectionHeadings() call */
  vstring_def(hugeHdr);
  vstring_def(bigHdr);
  vstring_def(smallHdr);
  vstring_def(tinyHdr);
  vstring_def(hugeHdrComment);
  vstring_def(bigHdrComment);
  vstring_def(smallHdrComment);
  vstring_def(tinyHdrComment);

  vstring_def(descr);
  vstring_def(str1);
  vstring_def(str2);

  /* For mathbox check */
  long mbox, pmbox, stmt, pstmt, plen, step;

  nmbrString_def(proof);
  vstring_def(dupCheck);

  saveHtmlFlag = g_htmlFlag;  saveAltHtmlFlag = g_altHtmlFlag;

  print2("Checking statement label conventions...\n");

  /* Check that labels can create acceptable file names for web pages */
  /* Detect Microsoft bugs reported by several users, when the
     HTML output files are named "con.html" etc. */
  /* If we want a standard error message underlining token, this could go
     in mmpars.c */
  /* From Microsoft's site:
     "The following reserved words cannot be used as the name of a file:
     CON, PRN, AUX, CLOCK$, NUL, COM1, COM2, COM3, COM4, COM5, COM6, COM7,
     COM8, COM9, LPT1, LPT2, LPT3, LPT4, LPT5, LPT6, LPT7, LPT8, and LPT9.
     Also, reserved words followed by an extension - for example,
     NUL.tx7 - are invalid file names." */
  /* Check for labels that will lead to illegal Microsoft file names for
     Windows users.  Don't bother checking CLOCK$ since $ is already
     illegal */
  let(&str1, cat(
     ",CON,PRN,AUX,NUL,COM1,COM2,COM3,COM4,COM5,COM6,COM7,",
     "COM8,COM9,LPT1,LPT2,LPT3,LPT4,LPT5,LPT6,LPT7,LPT8,LPT9,", NULL));
  for (stmtNum = 1; stmtNum <= g_statements; stmtNum++) {
    if (!matchesList(g_Statement[stmtNum].labelName, labelMatch, '*', '?')) {
      continue;
    }

    /* Check labels for "_" characters */
    /* See discussion in https://github.com/metamath/set.mm/pull/1691 */
    if (underscoreCheck
        && instr(1, g_Statement[stmtNum].labelName, "_") != 0) {
      assignStmtFileAndLineNum(stmtNum);
      printLongLine(cat("?Warning: In statement \"",
          g_Statement[stmtNum].labelName, "\" at line ",
          str((double)(g_Statement[stmtNum].lineNum)),
          " in file \"", g_Statement[stmtNum].fileName,
          "\".  Underscores in labels are not recommended per our conventions.  ",
          "Use the / UNDERSCORE_SKIP ",
          "qualifier to skip this check.",
          NULL),
          "    ", " ");
      errFound = 1;
    }

    /* Only $a and $p can produce web pages, so check only them */
    if (g_Statement[stmtNum].type != a_ && g_Statement[stmtNum].type != p_) {
      continue;
    }
    let(&str2, cat(",", edit(g_Statement[stmtNum].labelName, 32/*uppercase*/),
        ",", NULL));
    if (instr(1, str1, str2) ||
        /* mm*.html is reserved for mmtheorems.html, etc. */
        !strcmp(",MM", left(str2, 3))) {
      assignStmtFileAndLineNum(stmtNum);
      printLongLine(cat("?Warning: In statement \"",
          g_Statement[stmtNum].labelName, "\" at line ",
          str((double)(g_Statement[stmtNum].lineNum)),
          " in file \"", g_Statement[stmtNum].fileName,
          "\".  To workaround a Microsoft operating system limitation, the",
          " the following reserved words cannot be used for label names:",
          " CON, PRN, AUX, CLOCK$, NUL, COM1, COM2, COM3, COM4, COM5,",
          " COM6, COM7, COM8, COM9, LPT1, LPT2, LPT3, LPT4, LPT5, LPT6,",
          " LPT7, LPT8, and LPT9.  Also, \"mm*.html\" is reserved for",
          " Metamath file names.  Use another name for this label.", NULL),
          "    ", " ");
      errFound = 1;
    }

    /* Check that $a assertions start with "ax-" or "df-" */
    if (g_Statement[stmtNum].type == (char)a_) {
      if (!strcmp("|-", g_MathToken[
          (g_Statement[stmtNum].mathString)[0]].tokenName)) {
        let(&str1, left(g_Statement[stmtNum].labelName, 3));
        if (strcmp("ax-", str1) && strcmp("df-", str1)) {
          assignStmtFileAndLineNum(stmtNum);
          printLongLine(cat("?Warning: In the $a statement \"",
              g_Statement[stmtNum].labelName, "\" at line ",
              str((double)(g_Statement[stmtNum].lineNum)),
              " in file \"", g_Statement[stmtNum].fileName,
              "\", the label does not start with \"ax-\" or \"df-\"",
              " per our convention for axiomatic assertions (\"$a |- ...\").",
              NULL), "    ", " ");
          errFound = 1;
        }
      }
    }
  } /* next stmtNum */

  /* Check for math tokens containing "@" or "?" */
  /* Note:  g_MathToken[] is 0-based, not 1-based */
  for (p1 = 0; p1 < g_mathTokens; p1++) {
    if (strchr(g_MathToken[p1].tokenName, '@') != NULL) {
      stmtNum = g_MathToken[p1].statement;
      assignStmtFileAndLineNum(stmtNum);
      printLongLine(cat("?Warning: The token \"",
          g_MathToken[p1].tokenName,
          "\" declared at line ",
          str((double)(g_Statement[stmtNum].lineNum)),
          " in file \"", g_Statement[stmtNum].fileName,
          "\" has an \"@\" character, which is discouraged because ",
          "\"@\" is traditionally used to replace \"$\" in commented-out ",
          "database source code.",
          NULL),
          "    ", " ");
      errFound = 1;
    }
    if (strchr(g_MathToken[p1].tokenName, '?') != NULL) {
      stmtNum = g_MathToken[p1].statement;
      assignStmtFileAndLineNum(stmtNum);
      printLongLine(cat("?Warning: The token \"",
          g_MathToken[p1].tokenName,
          "\" declared at line ",
          str((double)(g_Statement[stmtNum].lineNum)),
          " in file \"", g_Statement[stmtNum].fileName,
          "\" has a \"?\" character, which is discouraged because ",
          "\"?\" is sometimes used as a math token search wildcard.",
          NULL),
          "    ", " ");
      errFound = 1;
    }
  }

  /* Check $a ax-* vs. $p ax* */
  for (stmtNum = 1; stmtNum <= g_statements; stmtNum++) {
    if (g_Statement[stmtNum].type != a_) {
      continue;
    }
    if (!matchesList(g_Statement[stmtNum].labelName, labelMatch, '*', '?')) {
      continue;
    }

    /* Look for "ax-*" axioms */
    if (strcmp("ax-", left(g_Statement[stmtNum].labelName, 3))) {
      freeTempAlloc(); /* Prevent string stack buildup/overflow in left() */
      continue;
    }

    let(&str1, g_Statement[stmtNum].labelName);
    /* Convert ax-XXX to axXXX */
    let(&str2, cat(left(str1, 2), right(str1, 4), NULL));

    p1 = lookupLabel(str2);
    if (p1 == -1) continue;  /* There is no corresponding axXXX */

    if (verboseMode == 1) {
      print2("Comparing \"%s\" to \"%s\"...\n", str2, str1);
    }

    /* Compare statements */
    if (nmbrEq(g_Statement[stmtNum].mathString,
        g_Statement[p1].mathString) != 1) {
      printLongLine(cat("?Warning: The assertions for statements \"",
          g_Statement[stmtNum].labelName, "\" and \"",
          g_Statement[p1].labelName, "\" are different.",
          NULL), "  ", " ");
      errFound = 1;
      continue;
    }

    /* Compare number of mandatory hypotheses */
    if (g_Statement[stmtNum].numReqHyp != g_Statement[p1].numReqHyp) {
      printLongLine(cat("?Warning: Statement \"",
          g_Statement[stmtNum].labelName, "\" has ",
          str((double)(g_Statement[stmtNum].numReqHyp)),
          " mandatory hypotheses but \"",
          g_Statement[p1].labelName, "\" has ",
          str((double)(g_Statement[p1].numReqHyp)), ".",
          NULL), "  ", " ");
      errFound = 1;
      continue;
    }

    /* Compare mandatory distinct variables */
    if (nmbrEq(g_Statement[stmtNum].reqDisjVarsA,
        g_Statement[p1].reqDisjVarsA) != 1) {
      printLongLine(cat(
          "?Warning: The mandatory distinct variable pairs for statements \"",
          g_Statement[stmtNum].labelName, "\" and \"",
          g_Statement[p1].labelName,
          "\" are different or have a different order.",
          NULL), "  ", " ");
      errFound = 1;
      continue;
    } else if (nmbrEq(g_Statement[stmtNum].reqDisjVarsB,
        g_Statement[p1].reqDisjVarsB) != 1) {
      printLongLine(cat(
          "?Warning: The mandatory distinct variable pairs for statements \"",
          g_Statement[stmtNum].labelName, "\" and \"",
          g_Statement[p1].labelName,
          "\" are different or have a different order.",
          NULL), "  ", " ");
      errFound = 1;
      continue;
    }

    /* Compare mandatory hypotheses */
    for (p2 = 0; p2 < g_Statement[stmtNum].numReqHyp; p2++) {
      if (nmbrEq(g_Statement[(g_Statement[stmtNum].reqHypList)[p2]].mathString,
          g_Statement[(g_Statement[p1].reqHypList)[p2]].mathString) != 1) {
        printLongLine(cat("?Warning: The mandatory hypotheses of statements \"",
            g_Statement[stmtNum].labelName, "\" and \"",
            g_Statement[p1].labelName, "\" are different.",
            NULL), "  ", " ");
        errFound = 1;
        break;
      }
    } /* next p2 */

    for (p2 = 0; p2 < nmbrLen(g_Statement[stmtNum].reqDisjVarsA); p2++) {
      if (nmbrEq(g_Statement[stmtNum].reqDisjVarsA,
          g_Statement[p1].reqDisjVarsA) != 1) {
        printLongLine(cat("?Warning: The mandatory hypotheses of statements \"",
            g_Statement[stmtNum].labelName, "\" and \"",
            g_Statement[p1].labelName, "\" are different.",
            NULL), "  ", " ");
        errFound = 1;
        break;
      }
    } /* next p2 */
  } /* next stmtNum */

  /* Check line lengths */
  free_vstring(str1); /* Prepare to use as pointer */
  free_vstring(str2); /* Prepare to use as pointer */
  if (g_statements >= 0) {
    /* TODO - handle $[...$] */
    /* g_includeCalls is always nonzero now - but check
        anyway; line numbers may be off if there are >1 files. */
    str1 = g_Statement[1].labelSectionPtr; /* Start of input file */
    str2 = g_Statement[g_statements + 1].labelSectionPtr
       + g_Statement[g_statements + 1].labelSectionLen; /* End of input file */
        /* g_statements + 1 is dummy statement to hold text after last statement */
    if (str2[0] != 0) bug(258); /* Should be end of (giant) string */
    if (str2[-1] != '\n') bug(259); /* End of last line */
    flen = str2 - str1;  /* Length of input file */
    str2 = ""; /* Restore pointer for use as vstring */
    lnum = 0; /* Line number */
    lstart = 0; /* Line start */
    for (p1 = 0; p1 < flen; p1++) {
      if (str1[p1] == 0) {
        bug(260); /* File shouldn't have nulls */
      }
      if (str1[p1] == '\n') {
        /* End of a line found */
        lnum++;

        if (p1 > 0) { /* Not 1st character in file */
          if (str1[p1 - 1] == ' ') {
            printLongLine(cat("?Warning: Line number ",
                str((double)lnum),
                " ends with a space character, which is discouraged.",
                NULL), "    ", " ");
            errFound = 1;
          }
        }

        if (p1 - lstart > g_screenWidth) { /* Normally 79; see mminou.c */
          /* Put line in str2 for error message */
          let(&str2, space(p1 - lstart));
          memcpy(str2, str1 + lstart,
            (size_t)(p1 - lstart));
          printLongLine(cat("?Warning: Line number ",
              str((double)lnum),
              " has ",
              str((double)(p1 - lstart)),
              " characters (should have ",
              str((double)g_screenWidth),
              " or less):",
              NULL), "    ", " ");
          print2("    %s...\n", left(str2, g_screenWidth - 7));
          errFound = 1;
          free_vstring(str2); /* Deallocate string memory */
        }
        lstart = p1 + 1;
      }

      /* Check for tabs */
      if (str1[p1] == '\t') {
        printLongLine(cat("?Warning: Line number ",
            str((double)lnum + 1),
            " contains a tab, which is discouraged.",
            NULL), "    ", " ");
        errFound = 1;
      }
    } /* next p1 */
    str1 = ""; /* Restore pointer for use as vstring */
  } /* end of line length check - if (g_statements >= 1... */

  /* Check $t comment content */

  eraseTexDefs(); /* Force a reread regardless of previous mode */
  /* Check latexdef statements */
  print2("Checking latexdef, htmldef, althtmldef...\n");
  g_htmlFlag = 0; /* 1 = HTML, not TeX */
  g_altHtmlFlag = 0; /* 1 = Unicode, not GIFs (when g_htmlFlag = 1) */
  f = readTexDefs(1/*errorsOnly*/,
          fileCheck /* 1 = GIF file existence check */  );
  if (f != 0) errFound = 1;
  if (f != 2) {   /* We continue if no severe errors (warnings are ok) */
    /* Check htmldef statements (reread since we've switched modes) */
    g_htmlFlag = 1; /* 1 = HTML, not TeX */
    g_altHtmlFlag = 0; /* 1 = Unicode, not GIFs (when g_htmlFlag = 1) */
    f = readTexDefs(1/*errorsOnly*/,
            fileCheck /* 1 = GIF file existence check */  );
  }
  if (f != 0) errFound = 1;
  if (f != 2) {  /* We continue if no severe errors (warnings are ok) */
    /* Check althtmldef statements (reread since we've switched modes) */
    g_htmlFlag = 1; /* 1 = HTML, not TeX */
    g_altHtmlFlag = 1; /* 1 = Unicode, not GIFs (when g_htmlFlag = 1) */
    f = readTexDefs(1/*errorsOnly*/,
            fileCheck /* 1 = GIF file existence check */  );
  }
  if (f != 0) errFound = 1;

  /* Check date consistency and comment markup in all statements */
  print2("Checking statement comments...\n");
  let(&mostRecentDate, "");
  for (stmtNum = 1; stmtNum <= g_statements; stmtNum++) {
    if (g_Statement[stmtNum].type != a_ && g_Statement[stmtNum].type != p_) {
      continue;
    }
    if (!matchesList(g_Statement[stmtNum].labelName, labelMatch, '*', '?')) {
      continue;
    }

    /* Check the contributor */
    free_vstring(str1);
    str1 = getContrib(stmtNum, CONTRIBUTOR);
    if (!strcmp(str1, DEFAULT_CONTRIBUTOR)) {
      printLongLine(cat(
          "?Warning: Contributor \"", DEFAULT_CONTRIBUTOR,
          "\" should be updated in statement \"",
          g_Statement[stmtNum].labelName, "\".", NULL), "    ", " ");
      errFound = 1;
    }
    free_vstring(str1);
    str1 = getContrib(stmtNum, REVISER);
    if (!strcmp(str1, DEFAULT_CONTRIBUTOR)) {
      printLongLine(cat(
          "?Warning: Reviser \"", DEFAULT_CONTRIBUTOR,
          "\" should be updated in statement \"",
          g_Statement[stmtNum].labelName, "\".", NULL), "    ", " ");
      errFound = 1;
    }

    if (dateCheck) {

      /* Check date consistency of the statement */
      /* Use the error-checking feature of getContrib() extractor */
      free_vstring(str1);
      str1 = getContrib(stmtNum, GC_ERROR_CHECK_PRINT); /* Returns P or F */
      if (str1[0] == 'F') errFound = 1;
      free_vstring(str1);
      str1 = getContrib(stmtNum, MOST_RECENT_DATE);

      /* Save most recent date in file - used to check Version date below */
      if (compareDates(mostRecentDate, str1) == -1) {
        let(&mostRecentDate, str1);
        mostRecentStmt = stmtNum;
      }
    }

    free_vstring(descr);
    descr = getDescription(stmtNum);

    /* Check comment markup of the statement */
    g_showStatement /* global */ = stmtNum; /* For printTexComment */
    g_texFilePtr /* global */  = NULL; /* Not used, but set to something */
    /* Use the errors-only (no output) feature of printTexComment() */
    f = printTexComment(descr,
        0, /* 1 = htmlCenterFlag (irrelevant for this call) */
        PROCESS_EVERYTHING + ERRORS_ONLY, /* actionBits */
        fileCheck);
    if (f == 1) errFound = 1;

    /* Check that $a has no "(Proof modification is discouraged.)" */
    if (g_Statement[stmtNum].type == a_) {
      if (getMarkupFlag(stmtNum, PROOF_DISCOURAGED) == 1) {
        printLongLine(cat(
            "?Warning: Statement \"", g_Statement[stmtNum].labelName,
            "\" is a $a but has a \"(Proof modification is discouraged.)\" tag.",
            NULL), "    ", " ");
        errFound = 1;
      }
    }
    /* Check that *OLD and *ALT have both discouragements */
    /* See discussion at
       https://groups.google.com/d/msg/metamath/NhPM9XNNh1E/otl0uskKBgAJ */
    p1 = (long)strlen(g_Statement[stmtNum].labelName);
    let(&str1, right(g_Statement[stmtNum].labelName, p1 - 2)); /* Last 3 chars. */
    if (!strcmp(str1, "OLD") || !strcmp(str1, "ALT")) {
      if (getMarkupFlag(stmtNum, PROOF_DISCOURAGED) != 1
          && g_Statement[stmtNum].type == p_ /* Ignore $a's */
          ) {
        printLongLine(cat(
            "?Warning: Statement \"", g_Statement[stmtNum].labelName,
            "\" has suffix \"", str1,
            "\" but has no \"(Proof modification is discouraged.)\" tag.",
            NULL), "    ", " ");
        errFound = 1;
      }
      if (getMarkupFlag(stmtNum, USAGE_DISCOURAGED) != 1) {
        printLongLine(cat(
            "?Warning: Statement \"", g_Statement[stmtNum].labelName,
            "\" has suffix \"", str1,
            "\" but has no \"(New usage is discouraged.)\" tag.",
            NULL), "    ", " ");
        errFound = 1;
      }
    }
  } /* next stmtNum */

  /* Check that the version date of the .mm file is g.e. all statement dates */
  /* This code expects a version date at the top of the file such as:
         $( set.mm - Version of 13-Dec-2016 $)
     If we later want a different format, this code should be modified. */
  if (topDateCheck) {
    /* Get the top of the .mm file */
    let(&str1, space(g_Statement[1].labelSectionLen));
    memcpy(str1, g_Statement[1].labelSectionPtr,
      (size_t)(g_Statement[1].labelSectionLen));
    /* Find the version date */
    p1 = instr(1, str1, "Version of ");
    if (p1 == 0) {
      printLongLine(cat(
          "?Warning: There is no \"Version of \" comment at the top of the",
          " file \"", g_input_fn, "\".", NULL), "    ", " ");
      errFound = 1;
    } else {
      p2 = instr(p1 + 11, str1, " ");
      let(&str2, seg(str1, p1 + 11, p2 - 1)); /* The date */
      f = parseDate(str2, &p1, &p2, &p3);
      if (f == 1) {
        printLongLine(cat(
            "?Warning: The Version date \"", str2, "\" at the top of file \"",
            g_input_fn, "\" is not a valid date.", NULL), "    ", " ");
        errFound = 1;
      } else if (dateCheck && compareDates(mostRecentDate, str2) == 1) {
        printLongLine(cat(
            "?Warning: The \"Version of\" date ", str2,
            " at the top of file \"",
            g_input_fn,
            "\" is less recent than the date ", mostRecentDate,
            " in the description of statement \"",
            g_Statement[mostRecentStmt].labelName, "\".", NULL), "    ", " ");
        errFound = 1;
      }
    }
  } /* if (topDateCheck) */

  print2("Checking section header comments...\n");
  for (stmtNum = 1; stmtNum <= g_statements; stmtNum++) {
    if (g_Statement[stmtNum].type != a_ && g_Statement[stmtNum].type != p_) {
      continue;
    }
    if (!matchesList(g_Statement[stmtNum].labelName, labelMatch, '*', '?')) {
      continue;
    }

    free_vstring(hugeHdr);
    free_vstring(bigHdr);
    free_vstring(smallHdr);
    free_vstring(tinyHdr);
    free_vstring(hugeHdrComment);
    free_vstring(bigHdrComment);
    free_vstring(smallHdrComment);
    free_vstring(tinyHdrComment);
    f = getSectionHeadings(stmtNum, &hugeHdr, &bigHdr, &smallHdr,
        &tinyHdr,
        &hugeHdrComment, &bigHdrComment, &smallHdrComment,
        &tinyHdrComment,
        0, /* fineResolution */
        0 /* fullComment */);
    if (f != 0) errFound = 1;

    g_showStatement /* global */ = stmtNum; /* For printTexComment() */
    g_texFilePtr /* global */  = NULL; /* Not used, but set to something */

    f = 0;
    if (hugeHdrComment[0] != 0)
      f = (char)(f + printTexComment(hugeHdrComment,
          0, /* 1 = htmlCenterFlag (irrelevant for this call) */
          PROCESS_EVERYTHING + ERRORS_ONLY, /* actionBits */
          fileCheck));
    if (bigHdrComment[0] != 0)
      f = (char)(f + printTexComment(bigHdrComment,
          0, /* 1 = htmlCenterFlag (irrelevant for this call) */
          PROCESS_EVERYTHING + ERRORS_ONLY, /* actionBits */
          fileCheck));
    if (smallHdrComment[0] != 0)
      f = (char)(f + printTexComment(smallHdrComment,
          0, /* 1 = htmlCenterFlag (irrelevant for this call) */
          PROCESS_EVERYTHING + ERRORS_ONLY, /* actionBits */
          fileCheck));
    if (tinyHdrComment[0] != 0)
      f = (char)(f + printTexComment(tinyHdrComment,
          0, /* 1 = htmlCenterFlag (irrelevant for this call) */
          PROCESS_EVERYTHING + ERRORS_ONLY, /* actionBits */
          fileCheck));

    if (f != 0) printf(
"    (The warning above refers to a header above the referenced statement.)\n");
    if (f != 0) errFound = 1;
  } /* next stmtNum */

  /* Use the errors-only (no output) feature of writeBibliography() */
  print2("Checking bibliographic references...\n");
  f = writeBibliography("mmbiblio.html",
          labelMatch,
          1,  /* 1 = no output, just warning msgs if any */
          fileCheck); /* 1 = check external files (gifs and bib) */
  if (f != 0) errFound = 1;

  /* Check mathboxes for cross-references */
  if (mathboxCheck) {
    print2("Checking mathbox independence...\n");
    assignMathboxInfo();  /* Populate global mathbox variables */
    /* Scan proofs in mathboxes to see if earlier mathbox is referenced */
    for (pmbox = 2; pmbox <= g_mathboxes; pmbox++) {
      /* Note g_mathboxStart, etc. are 0-based */
      for (pstmt = g_mathboxStart[pmbox - 1]; pstmt <= g_mathboxEnd[pmbox - 1];
          pstmt++) {
        if (g_Statement[pstmt].type != (char)p_)
          continue; /* Not a $p statement; skip it */
        /* Don't use bad proofs (incomplete proofs are ok) */
        if (parseProof(pstmt) > 1) {
          /* The proof has an error, so use the empty proof */
          nmbrLet(&proof, nmbrAddElement(NULL_NMBRSTRING, -(long)'?'));
        } else {
          nmbrLet(&proof, g_WrkProof.proofString);
        }
        plen = nmbrLen(proof);
        for (step = 0; step < plen; step++) {
          stmt = proof[step];
          if (stmt < 0) continue; /* Local step or '?' step */
          if (stmt == 0) bug(266);
          if (stmt > g_mathboxStmt && stmt < g_mathboxStart[pmbox - 1]) {
            /* A statement in another mathbox is referenced */

            /* Eliminate duplicate error messages: */
            let(&str1, cat(str((double)pstmt), "-", str((double)stmt), NULL));
            if (lookup(str1, dupCheck) != 0) {
              continue;
            } else {
              let(&dupCheck, cat(dupCheck,
                  (dupCheck[0] == 0) ? "" : ",", str1, NULL)); /* Add to list */
            }

            mbox = getMathboxNum(stmt);
            if (mbox == 0) bug(267);
            if (verboseMode == 0) {
              printLongLine(cat("?Warning: The proof of \"",
                  g_Statement[pstmt].labelName,
                  "\" in the mathbox for ", (vstring *)(g_mathboxUser[pmbox - 1]),
                  " references \"", g_Statement[stmt].labelName,
                  "\" in the mathbox for ", (vstring *)(g_mathboxUser[mbox - 1]),
                  ".",
                  NULL),
                  "    ", " ");
            } else {
              /* Verbose output experiment */
              assignStmtFileAndLineNum(stmt);
              assignStmtFileAndLineNum(pstmt);
              printLongLine(cat("?Warning: The proof of statement \"",
                  g_Statement[pstmt].labelName,
                  "\" in the mathbox for \"", (vstring *)(g_mathboxUser[pmbox - 1]),
                  "\" at line ", str((double)(g_Statement[pstmt].lineNum)),
                  " in file \"", g_Statement[pstmt].fileName,
                  "\" references statement \"", g_Statement[stmt].labelName,
                  "\" in the mathbox for \"", (vstring *)(g_mathboxUser[mbox - 1]),
                  "\" at line ", str((double)(g_Statement[stmt].lineNum)),
                  " in file \"", g_Statement[stmt].fileName,
                  "\".  ",
                  "(Use the / MATHBOX_SKIP qualifier to skip this check.)",
                  NULL),
                  "    ", " ");
            }
            /* g_errorCount++; */
            errFound = 1;
          } /* if stmt in another mathbox */
        } /* next step */
      } /* next pstmt */
    } /* next pmbox */
    /* Deallocate */
    free_vstring(dupCheck);
    free_nmbrString(proof);
  }

  if (errFound == 0) {
    print2("No errors were found.\n");
  }

  g_htmlFlag = saveHtmlFlag;  g_altHtmlFlag = saveAltHtmlFlag;
  /* Force reread to get current mode defaults for future user commands */
  eraseTexDefs();

  /* Deallocate string memory */
  free_vstring(mostRecentDate);
  free_vstring(mmVersionDate);
  free_vstring(descr);
  free_vstring(str1);
  free_vstring(str2);
  free_vstring(hugeHdr);
  free_vstring(bigHdr);
  free_vstring(smallHdr);
  free_vstring(tinyHdr);
  free_vstring(hugeHdrComment);
  free_vstring(bigHdrComment);
  free_vstring(smallHdrComment);
  free_vstring(tinyHdrComment);
  return;
} /* verifyMarkup */

/* Function to process markup in an arbitrary non-Metamath HTML file, treating
   the file as a giant comment. */
void processMarkup(vstring inputFileName, vstring outputFileName,
    flag processCss, long actionBits) {
  FILE *outputFilePtr;
  vstring_def(inputFileContent);
  long size;
  long p;

  /* Check that globals aren't in a weird state */
  if (g_outputToString == 1 || g_printString[0] != 0) {
    bug(265);
  }

  /* readTexDefs() rereads based on changed in g_htmlFlag, g_altHtmlFlag */
  if (2/*error*/ == readTexDefs(0 /* 1 = check errors only */,
      0 /* 1 = GIF file existence check */  )) {
    goto PROCESS_MARKUP_RETURN; /* An error occurred */
  }

  print2("Reading \"%s\"...\n", inputFileName);

  free_vstring(inputFileContent);
  inputFileContent = readFileToString(inputFileName, 1/*verbose*/, &size);
  if (inputFileContent == NULL) {
    /* Couldn't open the file; error msg provided by readFileToString */
    inputFileContent = ""; /* Restore to normal vstring to prevent seg fault */
    goto PROCESS_MARKUP_RETURN;
  }

  print2("Creating \"%s\"...\n", outputFileName);

  /* Insert CSS from .mm file before "</HEAD>" if it isn't already there */
  if (processCss != 0 && instr(1, inputFileContent, g_htmlCSS) == 0) {
    p = instr(1, edit(inputFileContent, 32/*uppercase*/), "</HEAD>");
    if (p != 0) {
      let(&inputFileContent, cat(left(inputFileContent, p - 1),
          g_htmlCSS, "\n", right(inputFileContent, p), NULL));
    }
  }

  /* fSafeOpen() renames existing files with ~1,~2,etc.  This way
     existing user files will not be accidentally destroyed. */
  outputFilePtr = fSafeOpen(outputFileName, "w", 0/*noVersioningFlag*/);
  if (outputFilePtr == NULL) {
    /* (Error msg already provided by fSafeOpen) */
    /* print2("?Couldn't open \"%s\"\n", outputFileName); */
    goto PROCESS_MARKUP_RETURN;
  }

  g_outputToString = 0;
  free_vstring(g_printString);
  g_showStatement = 0; /* For printTexComment */
  g_texFilePtr = outputFilePtr; /* For printTexComment */
  printTexComment(  /* Sends result to g_texFilePtr */
      inputFileContent,
      0, /* 1 = htmlCenterFlag */
      actionBits, /* bit-mapped list of actions */
      1 /* 1 = fileCheck */);
  fclose(g_texFilePtr);
  g_texFilePtr = NULL;

 PROCESS_MARKUP_RETURN:
  /* Deallocate */
  free_vstring(inputFileContent);
  free_vstring(g_printString);
  return;
}

/* List "discouraged" statements with "(Proof modification is discouraged."
   and "(New usage is discouraged.)" comment markup tags. */
/* This function is primarily intended for use with the "travis" system
   to identify versioning differences on GitHub. */
void showDiscouraged(void) {
  long stmt, s, usageCount;
  long lowStmt = 0, highStmt = 0; /* For a slight speedup */
  flag notQuitPrint = 1; /* Goes to 0 if user typed 'q' at scroll prompt */
  vstring_def(str1);
  for (stmt = 1; stmt <= g_statements; stmt++) {

    /* Since this command is slow, quit immediately if user typed 'q'
       at scrolling prompt */
    if (notQuitPrint == 0) break;

    if (g_Statement[stmt].type != p_ && g_Statement[stmt].type != a_) continue;
    if (getMarkupFlag(stmt, PROOF_DISCOURAGED) == 1
        && g_Statement[stmt].type == p_ /* Ignore $a's */
        ) {
      /* Restricted proof */
      /* Get number of steps */
      parseProof(stmt);
      notQuitPrint = print2(
"SHOW DISCOURAGED:  Proof modification of \"%s\" is discouraged (%ld steps).\n",
          g_Statement[stmt].labelName,
          nmbrLen(g_WrkProof.proofString));
    } /* if discouraged proof */
    if (getMarkupFlag(stmt, USAGE_DISCOURAGED) == 1) {
      /* Discouraged usage */
      usageCount = 0;
      free_vstring(str1);
      str1 = traceUsage(stmt,
          0, /* recursiveFlag */
          0 /* cutoffStmt */);
      if (str1[0] == 'Y') { /* Used by at least one */
        /* str1[i] will be 'Y' if used by stmt */
        lowStmt = g_statements;
        highStmt = 0;
        /* Scan all future statements in str1 Y/N list */
        for (s = stmt + 1; s <= g_statements; s++) {
          /* Scan the used-by map */
          if (str1[s] != 'Y') continue;
          usageCount++;
          if (lowStmt > s) lowStmt = s;
          if (highStmt < s) highStmt = s;
        } /* Next s */
      } /* if (str1[0] == 'Y') */
      notQuitPrint = print2(
"SHOW DISCOURAGED:  New usage of \"%s\" is discouraged (%ld uses).\n",
          g_Statement[stmt].labelName,
          usageCount);
      if (str1[0] == 'Y') { /* Used by at least one */
        /* str1[i] will be 'Y' if used by stmt */
        /* Scan all future statements in str1 Y/N list */
        for (s = lowStmt; s <= highStmt; s++) {
          /* Scan the used-by map */
          if (str1[s] != 'Y') continue;
          notQuitPrint = print2(
              "SHOW DISCOURAGED:  \"%s\" is used by \"%s\".\n",
              g_Statement[stmt].labelName,
              g_Statement[s].labelName);
        } /* Next s */
      } /* if (str1[0] == 'Y') */
    } /* if discouraged usage */
  } /* next stmt */
  free_vstring(str1); /* Deallocate */
} /* showDiscouraged */

/* Take a relative step FIRST, LAST, +nn, -nn (relative to the unknown
   essential steps) or ALL, and return the actual step for use by ASSIGN,
   IMPROVE, REPLACE, LET (or 0 in case of ALL, used by IMPROVE).  In case
   stepStr is an unsigned integer nn, it is assumed to already be an actual
   step and is returned as is.  If format is illegal, -1 is returned.  */
long getStepNum(vstring relStep, /* User's argument */
   nmbrString *pfInProgress, /* g_ProofInProgress.proof */
   flag allFlag /* 1 = "ALL" is permissible */)
{
  long pfLen, i, j, relStepVal, actualStepVal;
  flag negFlag = 0;
  nmbrString_def(essentialFlags);
  vstring_def(relStepCaps);

  let(&relStepCaps, edit(relStep, 32/*upper case*/));
  pfLen = nmbrLen(pfInProgress); /* Proof length */
  relStepVal = (long)(val(relStepCaps)); /* val() tolerates ill-formed numbers */

  if (relStepVal >= 0 && !strcmp(relStepCaps, str((double)relStepVal))) {
    /* User's argument is an unsigned positive integer */
    actualStepVal = relStepVal;
    if (actualStepVal > pfLen || actualStepVal < 1) {
      print2("?The step must be in the range from 1 to %ld.\n", pfLen);
      actualStepVal = -1;  /* Flag the error */
    }
    goto RETURN_POINT;  /* Already actual step; just return it */
  } else if (!strcmp(relStepCaps, left("FIRST", (long)(strlen(relStepCaps))))) {
    negFlag = 0; /* Scan forwards */
    relStepVal = 0;
  } else if (!strcmp(relStepCaps, left("LAST", (long)(strlen(relStepCaps))))) {
    negFlag = 1; /* Scan backwards */
    relStepVal = 0;
  } else if (relStepCaps[0] == '+') {
    negFlag = 0;
    if (strcmp(right(relStepCaps, 2), str((double)relStepVal))) {
      print2("?The characters after '+' are not a number.\n");
      actualStepVal = -1; /* Error - not a number after the '+' */
      goto RETURN_POINT;
    }
  } else if (relStepCaps[0] == '-') {
    negFlag = 1;
    if (strcmp(right(relStepCaps, 2), str((double)(- relStepVal)))) {
      print2("?The characters after '-' are not a number.\n");
      actualStepVal = -1; /* Error - not a number after the '-' */
      goto RETURN_POINT;
    }
    relStepVal = - relStepVal;
  } else if (!strcmp(relStepCaps, left("ALL", (long)(strlen(relStepCaps))))) {
    if (!allFlag) {
      /* ALL is illegal */
      print2("?You must specify FIRST, LAST, nn, +nn, or -nn.\n");
      actualStepVal = -1; /* Flag that there was an error */
      goto RETURN_POINT;
    }
    actualStepVal = 0; /* 0 is special, meaning "ALL" */
    goto RETURN_POINT;
  } else {
    if (allFlag) {
      print2("?You must specify FIRST, LAST, nn, +nn, -nn, or ALL.\n");
    } else {
      print2("?You must specify FIRST, LAST, nn, +nn, or -nn.\n");
    }
    actualStepVal = -1; /* Flag that there was an error */
    goto RETURN_POINT;
  }

  nmbrLet(&essentialFlags, nmbrGetEssential(pfInProgress));

  /* Get the essential step flags */
  actualStepVal = 0; /* Use zero as flag that step wasn't found */
  if (negFlag) {
    /* Scan proof backwards */
    /* Count back 'relStepVal' unknown steps */
    j = relStepVal + 1;
    for (i = pfLen; i >= 1; i--) {
      if (essentialFlags[i - 1]
          && pfInProgress[i - 1] == -(long)'?') {
        j--;
        if (j == 0) {
          /* Found it */
          actualStepVal = i;
          break;
        }
      }
    } /* Next i */
  } else {
    /* Scan proof forwards */
    /* Count forward 'relStepVal' unknown steps */
    j = relStepVal + 1;
    for (i = 1; i <= pfLen; i++) {
      if (essentialFlags[i - 1]
          && pfInProgress[i - 1] == -(long)'?') {
        j--;
        if (j == 0) {
          /* Found it */
          actualStepVal = i;
          break;
        }
      }
    } /* Next i */
  }
  if (actualStepVal == 0) {
    if (relStepVal == 0) {
      print2("?There are no unknown essential steps.\n");
    } else {
      print2("?There are not at least %ld unknown essential steps.\n",
        relStepVal + 1);
    }
    actualStepVal = -1; /* Flag that there was an error */
    goto RETURN_POINT;
  }

 RETURN_POINT:
  /* Deallocate memory */
  free_vstring(relStepCaps);
  free_nmbrString(essentialFlags);

  return actualStepVal;
} /* getStepNum */

/* Convert the actual step numbers of an unassigned step to the relative
   -1, -2, etc. offset for SHOW NEW_PROOF ...  /UNKNOWN, to make it easier
   for the user to ASSIGN the relative step number. A 0 is returned
   for the last unknown step.  The step numbers of known steps are
   unchanged.  */
/* The caller must deallocate the returned nmbrString. */
nmbrString *getRelStepNums(nmbrString *pfInProgress) {
  nmbrString_def(essentialFlags);
  nmbrString_def(relSteps);
  long i, j, pfLen;

  pfLen = nmbrLen(pfInProgress); /* Get proof length */
  nmbrLet(&relSteps, nmbrSpace(pfLen));  /* Initialize */
  nmbrLet(&essentialFlags, nmbrGetEssential(pfInProgress));
  j = 0;  /* Negative offset (or 0 for last unknown step) */
  for (i = pfLen; i >= 1; i--) {
    if (essentialFlags[i - 1]
        && pfInProgress[i - 1] == -(long)'?') {
      relSteps[i - 1] = j;
      j--; /* It's an essential unknown step; increment negative offset */
    } else {
      relSteps[i - 1] = i; /* Just keep the normal step number */
    }
  }

  /* Deallocate memory */
  free_nmbrString(essentialFlags);

  return relSteps;
} /* getRelStepNums */

/* This procedure finds the next statement number whose label matches
   stmtName.  Wildcards are allowed.  If uniqueFlag is 1,
   there must be exactly one match, otherwise an error message is printed
   and -1 is returned.  If uniqueFlag is 0, the next match is
   returned, or -1 if there are no more matches.  No error messages are
   printed when uniqueFlag is 0, except for the special case of
   startStmt=1.  For use by PROVE, REPLACE, ASSIGN. */
long getStatementNum(vstring stmtName, /* Possibly with wildcards */
    long startStmt, /* Starting statement number (1 for full scan) */
    long maxStmt, /* Matches must be LESS THAN this statement number */
    flag aAllowed, /* 1 means $a is allowed */
    flag pAllowed, /* 1 means $p is allowed */
    flag eAllowed, /* 1 means $e is allowed */
    flag fAllowed, /* 1 means $f is allowed */
    flag efOnlyForMaxStmt, /* If 1, $e and $f must belong to maxStmt */
    flag uniqueFlag) /* If 1, match must be unique */
{
  flag hasWildcard;
  long matchesFound, matchStmt, matchStmt2, stmt;
  char typ;
  flag laterMatchFound = 0; /* For better error message */

  hasWildcard = 0;
  /* (Note strpbrk warning in mmpars.c) */
  if (strpbrk(stmtName, "*?=~%#@,") != NULL) {
    /* (See matches() function for processing of these)
       "*" 0 or more char match
       "?" 1 char match
       "=" Most recent PROVE command statement
       "~" Statement range
       "%" List of modified statements
       "#" Internal statement number
       "@" Web page statement number
       "," Comma-separated fields */
    hasWildcard = 1; /* I.e. stmtName is not a simple label */
  }
  matchesFound = 0;
  matchStmt = 1; /* Set to a legal value in case of bug */
  matchStmt2 = 1; /* Set to a legal value in case of bug */

  for (stmt = startStmt; stmt <= g_statements; stmt++) {

    if (stmt >= maxStmt) {
      if (matchesFound > 0) break; /* Normal exit when a match was found */
      if (!uniqueFlag) break; /* We only want to scan up to maxStmt anyway */
      /* Otherwise, we continue to see if there is a later match, for
         error message purposes */
    }

    if (!g_Statement[stmt].labelName[0]) continue; /* No label */
    typ = g_Statement[stmt].type;

    if ((!aAllowed && typ == (char)a_)
        ||(!pAllowed && typ == (char)p_)
        ||(!eAllowed && typ == (char)e_)
        ||(!fAllowed && typ == (char)f_)) {
      continue; /* Statement type is not allowed */
    }

    if (hasWildcard) {
      if (!matchesList(g_Statement[stmt].labelName, stmtName, '*', '?')) {
        continue;
      }
    } else {
      /* When hasWildcard = 0, this code is very inefficient - all we need to
         do is call lookupLabel(stmtName) outside of the stmt loop and take
         actions based on whether the label exists and its statement number
         and type compared to what's expected.  However, from a user
         perspective, the current code has no noticeable delay, so there's no
         pressing need to improve it at this point. */
      if (strcmp(stmtName, g_Statement[stmt].labelName)) {
        continue;
      }
    }

    if (efOnlyForMaxStmt) {
      if (maxStmt > g_statements) bug(247); /* Don't set efOnlyForMaxStmt
                                             in case of PROVE call */
      /* If a $e or $f, it must be a hypothesis of the statement
         being proved */
      if (typ == (char)e_ || typ == (char)f_){
        if (!nmbrElementIn(1, g_Statement[maxStmt].reqHypList, stmt) &&
            !nmbrElementIn(1, g_Statement[maxStmt].optHypList, stmt))
            continue;
      }
    }

    if (stmt >= maxStmt) {
      /* For error messages:
         This signals that a later match (after the statement being
         proved, in case of ASSIGN) exists, so the user is trying to
         reference a future statement. */
      laterMatchFound = 1;
      break;
    }

    if (matchesFound == 0) {
      /* This is the first match found; save it */
      matchStmt = stmt;
      /* If uniqueFlag is not set, we're done (don't need to check for
         uniqueness) */
    }
    if (matchesFound == 1) {
      /* This is the 2nd match found; save it for error message */
      matchStmt2 = stmt;
    }
    matchesFound++;
    if (!uniqueFlag) break; /* We are just getting the next match, so done */
    if (!hasWildcard) break; /* Since there can only be 1 match, don't
                                bother to continue */
  }

  if (matchesFound == 0) {
    if (!uniqueFlag) {
      if (startStmt == 1) {
        /* For non-unique scan, print only if we started from beginning */
        print2("?No statement label matches \"%s\".\n", stmtName);
      }
    } else if (aAllowed && pAllowed && eAllowed && fAllowed
               && !efOnlyForMaxStmt) {
      print2("?No statement label matches \"%s\".\n", stmtName);
    } else if (!aAllowed && pAllowed && !eAllowed && !fAllowed) {
      /* This is normally the PROVE command */
      print2("?No $p statement label matches \"%s\".\n", stmtName);
    } else if (!eAllowed && !fAllowed) {
      /* This is normally for REPLACE */
      if (!laterMatchFound) {
        print2("?No $a or $p statement label matches \"%s\".\n",
          stmtName);
      } else {
        print2("?You must specify a statement "
          "that occurs earlier than the one being proved.\n");
      }
    } else {
      /* This is normally for ASSIGN */
      if (!laterMatchFound) {
        printLongLine(cat("?A statement label matching \"",
            stmtName,
            "\" was not found or is not a hypothesis of the statement ",
            "being proved.", NULL), "", " ");
      } else {
        print2("?You must specify a statement "
          "that occurs earlier than the one being proved.\n");
      }
    }
  } else if (matchesFound == 2) {
    printLongLine(cat("?This command requires a unique label, but there are ",
        " 2 matches for \"",
        stmtName, "\":  \"", g_Statement[matchStmt].labelName,
        "\" and \"", g_Statement[matchStmt2].labelName, "\".",
        NULL), "", " ");
  } else if (matchesFound > 2) {
    printLongLine(cat("?This command requires a unique label, but there are ",
        str((double)matchesFound), " (allowed) matches for \"",
        stmtName, "\".  The first 2 are \"", g_Statement[matchStmt].labelName,
        "\" and \"", g_Statement[matchStmt2].labelName, "\".",
        "  Use SHOW LABELS \"", stmtName, "\" to see all non-$e matches.",
        NULL), "", " ");
  }
  if (!uniqueFlag && matchesFound > 1) bug(248);
  if (matchesFound != 1) matchStmt = -1; /* Error - no (unique) match */
  return matchStmt;
} /* getStatementNum */

/* Called by help() - prints a help line */
void H(vstring helpLine)
{
    print2("%s\n", helpLine);
} /* H */

/******** The MIDI output algorithm is in this function, outputMidi(). ******/
/*** Warning:  If you want to experiment with the MIDI output, please
     confine changes to this function.  Changes to other code
     in this file is not recommended. ***/

void outputMidi(long plen, nmbrString *indentationLevels,
  nmbrString *logicalFlags, vstring g_midiParameter, vstring statementLabel) {

  /* The parameters have the following meanings.  You should treat them as
     read-only input parameters and should not modify the contents of the
     arrays or strings they point to.

       plen = length of proof
       indentationLevels[step] = indentation level in "show proof xxx /full"
           where step varies from 0 to plen-1
       logicalFlags[step] = 0 for formula-building step, 1 for logical step
       g_midiParameter = string passed by user in "midi xxx /parameter <g_midiParameter>"
       statementLabel = label of statement whose proof is being scanned */

  /* This function is called when the user types "midi xxx /parameter
     <g_midiParameter>".  The proof steps of theorem xxx are numbered successively
     from 0 to plen-1.  The arrays indentationLevels[] and logicalFlags[]
     have already been populated for you. */

  /* The purpose of this function is to create an ASCII file called xxx.txt
     that contains the ASCII format for a t2mf input file.  The mf2t package
     is available at http://www.hitsquad.com/smm/programs/mf2t/download.shtml.
     To convert xxx.txt to xxx.mid you type "t2mf xxx.txt xxx.mid". */

  /* To experiment with this function, you can add your own local variables and
     modify the algorithm as you see fit.  The algorithm is essentially
     contained in the loop "for (step = 0; step < plen; step++)" and in the
     initialization of the local variables that this loop uses.  No global
     variables are used inside this function; the only data used is
     that contained in the input parameters. */

/* Larger TEMPO means faster speed */
#define TEMPO 48
/* The minimum and maximum notes for the dynamic range we allow: */
/* (MIDI notes range from 1 to 127, but 28 to 103 seems reasonably pleasant) */
/* MIDI note number 60 is middle C. */
#define MIN_NOTE 28
#define MAX_NOTE 103

  /* Note: "flag" is just "char"; "vstring" is just "char *" - except
     that by this program's convention vstring allocation is controlled
     by string functions in mmvstr.c; and "nmbrString" is just "long *" */

  long step; /* Proof step from 0 to plen-1 */
  long midiKey; /* Current keyboard key to be output */
  long midiNote; /* Current midi note to be output, mapped from midiKey */
  long midiTime; /* Midi time stamp */
  long midiPreviousFormulaStep; /* Note saved from previous step */
  long midiPreviousLogicalStep; /* Note saved from previous step */
  vstring_def(midiFileName); /* All vstrings MUST be initialized to ""! */
  FILE *midiFilePtr; /* Output file pointer */
  long midiBaseline; /* Baseline note */
  long midiMaxIndent; /* Maximum indentation (to find dyn range of notes) */
  long midiMinKey; /* Smallest keyboard key in output */
  long midiMaxKey; /* Largest keyboard key in output */
  long midiKeyInc; /* Keyboard key increment per proof indentation level */
  flag midiSyncopate; /* 1 = syncopate the output */
  flag midiHesitate; /* 1 = silence all repeated notes */
  long midiTempo; /* larger = faster */
  vstring_def(midiLocalParam); /* To manipulate user's parameter string */
  vstring_def(tmpStr); /* Temporary string */
#define ALLKEYSFLAG 1
#define WHITEKEYSFLAG 2
#define BLACKKEYSFLAG 3
  flag keyboardType; /* ALLKEYSFLAG, WHITEKEYSFLAG, or BLACKKEYSFLAG */
  long absMinKey; /* The smallest note we ever want */
  long absMaxKey; /* The largest note we ever want */
  long key2MidiMap[128]; /* Maps keyboard (possibility with black or
                    white notes missing) to midi notes */
  long keyboardOctave; /* The number of keys spanning an octave */
  long i;

  /*** Define the keyboard to midi maps ***/
  /* The idea here is to map the proof step to pressing "keyboard" keys
     on keyboards that have all keys, or only the white keys, or only the
     black keys.   The default is all keys, the parameter b means black,
     and the parameter w means white. */
#define ALLKEYS 128
#define WHITEKEYS 75
#define BLACKKEYS 53
  long allKeys[ALLKEYS] =
      {  0,   1,   2,   3,   4,   5,   6,   7,   8,   9,  10,  11,
        12,  13,  14,  15,  16,  17,  18,  19,  20,  21,  22,  23,
        24,  25,  26,  27,  28,  29,  30,  31,  32,  33,  34,  35,
        36,  37,  38,  39,  40,  41,  42,  43,  44,  45,  46,  47,
        48,  49,  50,  51,  52,  53,  54,  55,  56,  57,  58,  59,
        60,  61,  62,  63,  64,  65,  66,  67,  68,  69,  70,  71,
        72,  73,  74,  75,  76,  77,  78,  79,  80,  81,  82,  83,
        84,  85,  86,  87,  88,  89,  90,  91,  92,  93,  94,  95,
        96,  97,  98,  99, 100, 101, 102, 103, 104, 105, 106, 107,
       108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119,
       120, 121, 122, 123, 124, 125, 126, 127};
  long whiteKeys[WHITEKEYS] =
      {  0,   2,   4,   5,   7,   9,  11,
        12,  14,  16,  17,  19,  21,  23,
        24,  26,  28,  29,  31,  33,  35,
        36,  38,  40,  41,  43,  45,  47,
        48,  50,  52,  53,  55,  57,  59,
        60,  62,  64,  65,  67,  69,  71,
        72,  74,  76,  77,  79,  81,  83,
        84,  86,  88,  89,  91,  93,  95,
        96,  98, 100, 101, 103, 105, 107,
       108, 110, 112, 113, 115, 117, 119,
       120, 122, 124, 125, 127};
  long blackKeys[BLACKKEYS] =
      {  1,   3,   6,   8,  10,
        13,  15,  18,  20,  22,
        25,  27,  30,  32,  34,
        37,  39,  42,  44,  46,
        49,  51,  54,  56,  58,
        61,  63,  66,  68,  70,
        73,  75,  78,  80,  82,
        85,  87,  90,  92,  94,
        97,  99, 102, 104, 106,
       109, 111, 114, 116, 118,
       121, 123, 126};

  /************* Initialization ***************/

  midiTime = 0; /* MIDI time stamp */
  midiPreviousFormulaStep = 0; /* Note in previous formula-building step */
  midiPreviousLogicalStep = 0; /* Note in previous logical step */
  midiFilePtr = NULL; /* Output file pointer */

  /* Parse the parameter string passed by the user */
  let(&midiLocalParam, edit(g_midiParameter, 32)); /* Convert to uppercase */

  /* Set syncopation */
  if (strchr(midiLocalParam, 'S') != NULL) {
    midiSyncopate = 1; /* Syncopation */
  } else {
    midiSyncopate = 0; /* No syncopation */
  }
  /* Set halting character of syncopation (only has effect if
     syncopation is on) */
  if (strchr(midiLocalParam, 'H') != NULL) {
    midiHesitate = 1; /* Silence all repeated fast notes */
  } else {
    midiHesitate = 0; /* Silence only every other one in a repeated sequence */
  }
  /* Set the tempo: 96=fast, 72=medium, 48=slow */
  if (strchr(midiLocalParam, 'F') != NULL) {
    midiTempo = 2 * TEMPO;  /* Fast */
  } else {
    if (strchr(midiLocalParam, 'M') != NULL) {
      midiTempo = 3 * TEMPO / 2;  /* Medium */
    } else {
      midiTempo = TEMPO; /* Slow */
    }
  }
  /* Get the keyboard type */
  if (strchr(midiLocalParam, 'W') != NULL) {
    keyboardType = WHITEKEYSFLAG;
  } else {
    if (strchr(midiLocalParam, 'B') != NULL) {
      keyboardType = BLACKKEYSFLAG;
    } else {
      keyboardType = ALLKEYSFLAG;
    }
  }
  /* Set the tempo: 96=fast, 48=slow */
  if (strchr(midiLocalParam, 'I') != NULL) {
    /* Do not skip any notes */
    midiKeyInc = 1 + 1;
  } else {
    /* Allow an increment of up to 4 */
    midiKeyInc = 4 + 1;
  }

  /* End of parsing user's parameter string */

  /* Map keyboard key numbers to MIDI notes */
  absMinKey = MIN_NOTE; /* Initialize for ALLKEYSFLAG case */
  absMaxKey = MAX_NOTE;
  keyboardOctave = 12; /* Keyboard keys per octave with no notes skipped */
  switch (keyboardType) {
    case ALLKEYSFLAG:
      for (i = 0; i < 128; i++) key2MidiMap[i] = allKeys[i];
     break;
    case WHITEKEYSFLAG:
      for (i = 0; i < WHITEKEYS; i++) key2MidiMap[i] = whiteKeys[i];
      keyboardOctave = 7;
      /* Get keyboard key for smallest midi note we want */
      for (i = 0; i < WHITEKEYS; i++) {
        if (key2MidiMap[i] >= absMinKey) {
          absMinKey = i;
          break;
        }
      }
      /* Get keyboard key for largest midi note we want */
      for (i = WHITEKEYS - 1; i >= 0; i--) {
        if (key2MidiMap[i] <= absMinKey) {
          absMinKey = i;
          break;
        }
      }
      /* Redundant array bound check for safety */
      if (absMaxKey >= WHITEKEYS) absMaxKey = WHITEKEYS - 1;
      if (absMinKey >= WHITEKEYS) absMinKey = WHITEKEYS - 1;
      break;
    case BLACKKEYSFLAG:
      for (i = 0; i < BLACKKEYS; i++) key2MidiMap[i] = blackKeys[i];
      keyboardOctave = 5;
      /* Get keyboard key for smallest midi note we want */
      for (i = 0; i < BLACKKEYS; i++) {
        if (key2MidiMap[i] >= absMinKey) {
          absMinKey = i;
          break;
        }
      }
      /* Get keyboard key for largest midi note we want */
      for (i = BLACKKEYS - 1; i >= 0; i--) {
        if (key2MidiMap[i] <= absMinKey) {
          absMinKey = i;
          break;
        }
      }
      /* Redundant array bound check for safety */
      if (absMaxKey >= BLACKKEYS) absMaxKey = BLACKKEYS - 1;
      if (absMinKey >= BLACKKEYS) absMinKey = BLACKKEYS - 1;
      break;
  }

  /* Get max indentation, so we can determine the scale factor
     to make midi output fit within dynamic range */
  midiMaxIndent = 0;
  for (step = 0; step < plen; step++) {
    if (indentationLevels[step] > midiMaxIndent)
      midiMaxIndent = indentationLevels[step];
  }

  /* We will use integral note increments multiplied by the indentation
     level.  We pick the largest possible, with a maximum of 4, so that the
     midi output stays within the desired dynamic range.  If the proof has
     *too* large a maximum indentation (not seen so far), the do loop below
     will decrease the note increment to 0, so the MIDI output will just be a
     flat sequence of repeating notes and therefore useless, but at least it
     won't crash the MIDI converter.  */

  /*midiKeyInc = 5;*/ /* Starting note increment, plus 1 */
        /* (This is now set with the I parameter; see above) */
  do { /* Decrement note incr until song will fit MIDI dyn range */
    midiKeyInc--;
    /* Compute the baseline note to which add the proof indentation
      times the midiKeyInc.  The "12" is to allow for the shift
      of one octave down of the sustained notes on "essential"
      (i.e. logical, not formula-building) steps. */
    midiBaseline = ((absMaxKey + absMinKey) / 2) -
      (((midiMaxIndent * midiKeyInc) - keyboardOctave/*12*/) / 2);
    midiMinKey = midiBaseline - keyboardOctave/*12*/;
    midiMaxKey = midiBaseline + (midiMaxIndent * midiKeyInc);
  } while ((midiMinKey < absMinKey || midiMaxKey > absMaxKey) &&
      midiKeyInc > 0);

  /* Open the output file */
  let(&midiFileName, cat(g_Statement[g_showStatement].labelName,
      ".txt", NULL)); /* Create file name from statement label */
  print2("Creating MIDI source file \"%s\"...", midiFileName);

  /* fSafeOpen() renames existing files with ~1,~2,etc.  This way
     existing user files will not be accidentally destroyed. */
  midiFilePtr = fSafeOpen(midiFileName, "w", 0/*noVersioningFlag*/);
  if (midiFilePtr == NULL) {
    print2("?Couldn't open %s\n", midiFileName);
    goto midi_return;
  }

  /* Output the MIDI header */
  fprintf(midiFilePtr, "MFile 0 1 %ld\n", midiTempo);
  fprintf(midiFilePtr, "MTrk\n");

  /* Create a string exactly 38 characters long for the Meta Text
     label (I'm not sure why, but they are in the t2mf examples) */
  let(&tmpStr, cat("Theorem ", statementLabel, " ", g_midiParameter,
      space(30), NULL));
  let(&tmpStr, left(tmpStr, 38));
  fprintf(midiFilePtr, "0 Meta Text \"%s\"\n", tmpStr);
  fprintf(midiFilePtr,
      "0 Meta Copyright \"Released to Public Domain by N. Megill\"\n");

  /************** Scan the proof ************************/

  for (step = 0; step < plen; step++) {
  /* Handle the processing that takes place at each proof step */
    if (!logicalFlags[step]) {

      /*** Process the higher fast notes for formula-building steps ***/
      /* Get the "keyboard" key number */
      midiKey = (midiKeyInc * indentationLevels[step]) + midiBaseline;
      /* Redundant prevention of array bound violation */
      if (midiKey < 0) midiKey = 0;
      if (midiKey > absMaxKey) midiKey = absMaxKey;
      /* Map "keyboard" key to MIDI note */
      midiNote = key2MidiMap[midiKey];
      if (midiPreviousFormulaStep != midiNote || !midiSyncopate) {
        /* Turn note on at the current MIDI time stamp */
        fprintf(midiFilePtr, "%ld On ch=2 n=%ld v=75\n", midiTime, midiNote);
        /* Turn note off at the time stamp + 18 */
        fprintf(midiFilePtr, "%ld On ch=2 n=%ld v=0\n", midiTime + 18,
            midiNote);
        midiPreviousFormulaStep = midiNote;
      } else {
        /* Skip turning on the note to give syncopation */
        /* To prevent skipping two notes in a row, set last note
           to 0 so next step it will not be skipped even if the
           note still doesn't change; this makes the syncopation
           more rhythmic */
        if (!midiHesitate) {
          midiPreviousFormulaStep = 0;
        }
      }
      midiTime += 24; /* Add 24 to the MIDI time stamp */
    } else {

      /*** Process the deeper sustained notes for logical steps ***/
      /* The idea here is to shift the note down 1 octave before
         outputting it, so it is distinguished from formula-
         building notes */
      /* Get the "keyboard" key number */
      midiKey = (midiKeyInc * indentationLevels[step]) + midiBaseline;
      /* Redundant prevention of array bound violation */
      if (midiKey < 0) midiKey = 0;
      if (midiKey > absMaxKey) midiKey = absMaxKey;
      /* Map "keyboard" key to MIDI note */
      midiNote = key2MidiMap[midiKey];
      midiNote = midiNote - 12; /* Down 1 octave */
      if (midiNote < 0) midiNote = 0; /* For safety but should be redundant */
      if (midiPreviousLogicalStep) { /* If 0, it's the first time */
        /* Turn off the previous sustained note */
        fprintf(midiFilePtr, "%ld On ch=1 n=%ld v=0\n", midiTime,
            midiPreviousLogicalStep);
      }
      /* Turn on the new sustained note */
      fprintf(midiFilePtr, "%ld On ch=1 n=%ld v=100\n", midiTime,
          midiNote);
      midiTime += 24; /* Add 24 to the MIDI time stamp */
      midiPreviousLogicalStep = midiNote; /* Save for next step */
    }
  } /* next step */

  /****************** Clean up and close output file ****************/

  /* After the last step, do the file closing stuff */
  /* Sustain the very last note a little longer - sounds better */
  midiTime += 72;
  fprintf(midiFilePtr, "%ld On ch=1 n=%ld v=0\n", midiTime,
      midiPreviousLogicalStep);
  /* Output the MIDI file trailer */
  fprintf(midiFilePtr, "%ld Meta TrkEnd\n", midiTime);
  fprintf(midiFilePtr, "TrkEnd\n");
  fclose(midiFilePtr);
  /* Inform the user the run time of the MIDI file */
  print2(" length = %ld sec\n", (long)(midiTime / (2 * midiTempo)));

 midi_return:
  /* Important: all local vstrings must be deallocated to prevent
     memory leakage */
  free_vstring(midiFileName);
  free_vstring(tmpStr);
  free_vstring(midiLocalParam);
} // outputMidi
