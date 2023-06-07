/*****************************************************************************/
/*        Copyright (C) 2020  NORMAN MEGILL                                  */
/*            License terms:  GNU General Public License                     */
/*****************************************************************************/
/*34567890123456 (79-character line to adjust editor window) 2345678901234567*/

/* Command line syntax specification for Metamath */

#include <string.h>
#include "mmvstr.h"
#include "mmdata.h"
#include "mmcmdl.h"
#include "mminou.h"

/* Global variables */
pntrString_def(g_rawArgPntr);
nmbrString_def(g_rawArgNmbr);
long g_rawArgs = 0;
pntrString_def(g_fullArg);
vstring_def(g_fullArgString); /* g_fullArg as one string */
vstring_def(g_commandPrompt);
vstring_def(g_commandLine);
long g_showStatement = 0;
vstring_def(g_logFileName);
vstring_def(g_texFileName);
flag g_PFASmode = 0; /* Proof assistant mode, invoked by PROVE command */
flag g_queryMode = 0; /* If 1, explicit questions will be asked even if
    a field in the input command line is optional */
flag g_sourceChanged = 0; /* Flag that user made some change to the source file*/
flag g_proofChanged = 0; /* Flag that user made some change to proof in progress*/
flag g_commandEcho = 0; /* Echo full command */
flag g_memoryStatus = 0; /* Always show memory */
flag g_sourceHasBeenRead = 0; /* 1 if a source file has been read in */
vstring_def(g_rootDirectory); /* Directory prefix to use for included files */

static flag getFullArg(long arg, const char *cmdList);

flag processCommandLine(void) {
  vstring_def(defaultArg);
  vstring_def(tmpStr);
  long i;
  g_queryMode = 0; /* If 1, explicit questions will be asked even if
    a field is optional */
  free_pntrString(g_fullArg);

  if (!g_toolsMode) {

    if (!g_PFASmode) {
      /* Normal mode */
      let(&tmpStr, cat("DBG|",
          "HELP|READ|WRITE|PROVE|SHOW|SEARCH|SAVE|SUBMIT|OPEN|CLOSE|",
          "SET|FILE|BEEP|EXIT|QUIT|ERASE|VERIFY|MARKUP|MORE|TOOLS|",
          "MIDI|<HELP>",
          NULL));
    }

    if (!getFullArg(0, tmpStr)) {
      goto pclbad;
    }

    if (cmdMatches("READ")) {
      if (!getFullArg(1, "& What is the name of the source input file? "))
          goto pclbad;
      /* Get any switches */
      i = 1;
      while (1) {
        i++;
        if (!getFullArg(i, "/|$|<$>")) goto pclbad;
        if (lastArgMatches("/")) {
          i++;
          if (!getFullArg(i, "VERIFY|<VERIFY>")) goto pclbad;
        } else {
          break;
        }
        break; /* Break if only 1 switch is allowed */
      } /* End while for switch loop */
      goto pclgood;
    }

    if (cmdMatches("VERIFY")) {
      if (!getFullArg(1,
          "PROOF|MARKUP|<PROOF>"))
        goto pclbad;
      if (cmdMatches("VERIFY PROOF")) {
        if (g_sourceHasBeenRead == 0) {
          print2("?No source file has been read in.  Use READ first.\n");
          goto pclbad;
        }
        if (!getFullArg(2,
            "* What are the labels to match (* = wildcard) <*>?"))
          goto pclbad;

        /* Get any switches */
        i = 2;
        while (1) {
          i++;
          if (!getFullArg(i, "/|$|<$>")) goto pclbad;
          if (lastArgMatches("/")) {
            i++;
            if (!getFullArg(i, cat(
                "SYNTAX_ONLY",
                "|<SYNTAX_ONLY>", NULL)))
              goto pclbad;
          } else {
            break;
          }
          break;  /* Break if only 1 switch is allowed */
        }

        goto pclgood;
      }

      if (cmdMatches("VERIFY MARKUP")) {
        if (g_sourceHasBeenRead == 0) {
          print2("?No source file has been read in.  Use READ first.\n");
          goto pclbad;
        }
        if (!getFullArg(2,
            "* What are the labels to match (* = wildcard) <*>?"))
          goto pclbad;

        /* Get any switches */
        i = 2;
        while (1) {
          i++;
          if (!getFullArg(i, "/|$|<$>")) goto pclbad;
          if (lastArgMatches("/")) {
            i++;
            if (!getFullArg(i, cat(
                "DATE_SKIP|FILE_SKIP|TOP_DATE_SKIP|VERBOSE",
                "|FILE_CHECK|TOP_DATE_CHECK",
                "|UNDERSCORE_SKIP|MATHBOX_SKIP|<DATE_SKIP>", NULL)))
              goto pclbad;
          } else {
            break;
          }
          /* break; */  /* Break if only 1 switch is allowed */
        }

        goto pclgood;
      }
    }

    if (cmdMatches("EXIT") || cmdMatches("QUIT") || cmdMatches("_EXIT_PA")) {

      /* Get any switches */
      i = 0;
      while (1) {
        i++;
        if (!getFullArg(i, "/|$|<$>")) goto pclbad;
        if (lastArgMatches("/")) {
          i++;
          if (!getFullArg(i, cat(
              "FORCE|<FORCE>", NULL)))
            goto pclbad;
        } else {
          break;
        }
        break; /* Break if only 1 switch is allowed */
      } /* End while for switch loop */

      goto pclgood;
    }
  }

  /* Command in master list but not intercepted -- really a bug */
  print2("?This command has not been implemented yet.\n");
  print2("(This is really a bug--please report it.)\n");
  goto pclbad;

  /* Should never get here */

 pclgood:
  /* Strip off the last g_fullArg if a null argument was added by getFullArg
     in the case when "$" (nothing) is allowed */
  if (!strcmp(g_fullArg[pntrLen(g_fullArg) - 1], chr(3))) {
    free_vstring(*(vstring *)(&g_fullArg[pntrLen(g_fullArg) - 1])); /* Deallocate */
    pntrLet(&g_fullArg, pntrLeft(g_fullArg, pntrLen(g_fullArg) - 1));
  }

  if (pntrLen(g_fullArg) > g_rawArgs) bug(1102);
  if (pntrLen(g_fullArg) < g_rawArgs) {
    let(&tmpStr, cat("?Too many arguments.  Use quotes around arguments with special",
        " characters and around Unix file names with \"/\"s.", NULL));
    goto pclbad;
  }

  /* Create a single string containing the g_fullArg tokens */
  let(&g_fullArgString, "");
  for (i = 0; i < pntrLen(g_fullArg); i++) {
    let(&g_fullArgString, cat(g_fullArgString, " ", g_fullArg[i], NULL));
  }
  let(&g_fullArgString, right(g_fullArgString, 2)); /* Strip leading space */

  /* Deallocate memory */
  free_vstring(defaultArg);
  free_vstring(tmpStr);
  return 1;

 pclbad:
  /* Deallocate memory */
  free_vstring(defaultArg);
  free_vstring(tmpStr);
  return 0;
} /* processCommandLine */

/* This function converts the user's abbreviated keyword in
   g_rawArgPntr[arg] to a full, upper-case keyword,
   in g_fullArg[arg], matching
   the available choices in cmdList. */
/* Special cases:  cmdList = "# xxx <yyy>?" - get an integer */
/*                 cmdList = "* xxx <yyy>?" - get any string;
                     don't convert to upper case
                   cmdList = "& xxx <yyy>?" - same as * except
                     verify it is a file that exists */
/* "$" means a null argument is acceptable; put it in as
   special character chr(3) so it can be recognized */
static flag getFullArg(long arg, const char *cmdList1) {
  pntrString_def(possCmd);
  flag ret = 1;
  vstring_def(defaultCmd);
  vstring_def(infoStr);
  vstring_def(errorLine);
  vstring_def(keyword);

  vstring_def(cmdList);
  let(&cmdList, cmdList1); /* In case cmdList1 gets deallocated when it comes
                             directly from a vstring function such as cat() */

  let(&errorLine, cat(g_commandPrompt, g_commandLine, NULL));

  /* Handle special case - integer expected */
  if (cmdList[0] == '#') {
    let(&defaultCmd, seg(cmdList, instr(1, cmdList, "<"), instr(1, cmdList, ">")));
    goto getFullArg_ret;
  }

  /* Handle special case - any arbitrary string is OK */
  /* '*' means any string, '&' means a file */
  /* However, "|$<$>" also allows null string (no argument) */
  if (cmdList[0] == '*' || cmdList[0] == '&') {
    let(&defaultCmd, seg(cmdList,instr(1, cmdList, "<"), instr(1, cmdList, ">")));

    let(&keyword, g_rawArgPntr[arg]);

    /* Convert abbreviations of FIRST, LAST, ALL to
       full keywords.  The rest of the program works fine without doing this,
       but it provides better cosmetic appearance when the command is echoed
       such as in during the UNDO command. */
    if (cmdList[0] == '*') {
      if ((keyword[0] == 'f' || keyword[0] == 'F')
          && instr(1, cmdList, " FIRST") != 0)
        let(&keyword, "FIRST");
      if ((keyword[0] == 'l' || keyword[0] == 'L')
          && instr(1, cmdList, " LAST") != 0)
        let(&keyword, "LAST");
      if ((keyword[0] == 'a' || keyword[0] == 'A')
          && instr(1, cmdList, " ALL") != 0)
        let(&keyword, "ALL");
    }

    if (keyword[0] == 0) { /* Use default argument */
      /* This case handles blank arguments on completely input command line */
      let(&keyword, seg(defaultCmd,2,len(defaultCmd) - 1));
    }
    if (cmdList[0] == '&') {
      /* See if file exists */
      vstring_def(tmpStr);
      let(&tmpStr, cat(g_rootDirectory, keyword, NULL));
      FILE *tmpFp = fopen(tmpStr, "r");
      if (!tmpFp) {
        let(&tmpStr, cat("?Sorry, couldn't open the file \"", tmpStr, "\".", NULL));
        ret = 0;
      } else {
        fclose(tmpFp);
      }
      free_vstring(tmpStr);
    }
    goto getFullArg_ret;
  }

  /* Parse the choices available */
  long possCmds = 0;
  long p = 0;
  long q = 0;
  while (1) {
    p = instr(p + 1, cat(cmdList, "|", NULL), "|");
    if (!p) break;
    pntrLet(&possCmd, pntrAddElement(possCmd));
    let((vstring *)(&possCmd[possCmds]), seg(cmdList, q+1, p-1));
    possCmds++;
    q = p;
  }
  if (!strcmp(left(possCmd[possCmds - 1],1), "<")) {
    // free_vstring(defaultCmd); // Not needed because defaultCmd is already empty
    /* Get default argument, if any */
    defaultCmd = possCmd[possCmds - 1]; /* re-use old allocation */

    if (!strcmp(defaultCmd, "<$>")) {
      let(&defaultCmd, "<nothing>");
    }
    pntrLet(&possCmd, pntrLeft(possCmd, possCmds - 1));
    possCmds--;
  }
  if (!strcmp(possCmd[possCmds - 1], "$")) {
    /* Change "$" to "nothing" for printouts */
    let((vstring *)(&possCmd[possCmds - 1]), "nothing");
  }

  /* Create a string used for queries and error messages */
  if (possCmds < 1) {
    bug(1105);
    ret = 0;
    goto getFullArg_ret;
  }
  if (possCmds == 1) {
    let(&infoStr,possCmd[0]);
  } else if (possCmds == 2) {
    let(&infoStr, cat(possCmd[0], " or ",
        possCmd[1], NULL));
  } else /* possCmds > 2 */ {
    let(&infoStr, "");
    for (long i = 0; i < possCmds - 1; i++) {
      let(&infoStr, cat(infoStr, possCmd[i], ", ", NULL));
    }
    let(&infoStr, cat(infoStr, "or ", possCmd[possCmds - 1], NULL));
  }


  if (g_rawArgs <= arg) {
    /* No argument was specified, and "nothing" is a valid argument */
    let(&keyword, chr(3));
    goto getFullArg_ret;
  }

  vstring_def(tmpArg);
  let(&tmpArg, edit(g_rawArgPntr[arg], 32)); /* Convert to upper case */
  long j = 0;
  long k = 0;
  long m = len(tmpArg);
  vstring_def(tmpStr);
  /* Scan the possible arguments for a match */
  for (long i = 0; i < possCmds; i++) {
    if (!strcmp(possCmd[i], tmpArg)) {
      /* An exact match was found, so ignore any other matches
         and use this one */
      k = 1;
      j = i;
      break;
    }
    if (!strcmp(left(possCmd[i], m), tmpArg)) {
      if (!k) {
        let(&tmpStr, possCmd[i]);
      } else {
        let(&tmpStr, cat(tmpStr, ", ", possCmd[i], NULL));
      }
      j = i; /* Save match position */
      k++; /* Number of matches */
    }
  }
  free_vstring(tmpArg);
  if (k < 1 || k > 1) {
    if (k < 1) {
      let(&tmpStr, cat("?Expected ", infoStr, ".", NULL));
    } else {
      if (k == 2) {
        p = instr(1, tmpStr, ", ");
        let(&tmpStr, cat(left(tmpStr, p-1), " or", right(tmpStr, p+1), NULL));
      } else {
        p = len(tmpStr) - 1;
        while (tmpStr[p] != ',') p--;
        let(&tmpStr, cat(left(tmpStr, p+1), " or", right(tmpStr, p+2), NULL));
      }
      let(&tmpStr, cat("?Ambiguous keyword - please specify ", tmpStr, ".", NULL));
    }
    free_vstring(tmpStr);
    ret = 0;
    goto getFullArg_ret;
  }
  free_vstring(tmpStr);

  let(&keyword, possCmd[j]);

getFullArg_ret:
  if (ret) {
    if (keyword[0] == 0) {
      if (g_rawArgs > arg && strcmp(defaultCmd, "<>")) {
        /* otherwise, "nothing" was specified */
        ret = 0;
        goto getFullArg_ret;
      }
    }
    /* Add new field to g_fullArg */
    pntrLet(&g_fullArg, pntrAddElement(g_fullArg));
    if (pntrLen(g_fullArg) != arg + 1) bug(1107);
    else let((vstring *)(&g_fullArg[arg]), keyword);
  }

  /* Deallocate memory */
  long len = pntrLen(possCmd);
  for (long i = 0; i < len; i++) free_vstring(*(vstring *)(&possCmd[i]));
  free_pntrString(possCmd);
  free_vstring(defaultCmd);
  free_vstring(infoStr);
  free_vstring(errorLine);
  free_vstring(keyword);
  free_vstring(cmdList);
  return ret;
} /* getFullArg */

/* This function breaks up line into individual tokens
   and puts them into g_rawArgPntr[].  g_rawArgs is the number of tokens.
   g_rawArgPntr[] is the starting position of each token on the line;
   the first character on the line has position 1, not 0.

   Spaces, tabs, and newlines are considered white space.  Special
   one-character
   tokens don't have to be surrounded by white space.  Characters
   inside quotes are considered to be one token, and the quotes are
   removed.
*/
void parseCommandLine(vstring line) {
  /*const char *specialOneCharTokens = "()/,=:";*/
  const char *tokenWhiteSpace = " \t\n";
  const char *tokenComment = "!";

  /* Initialization to avoid compiler warning (should not be theoretically
     necessary) */
  long tokenStart = 0;

  /* List of special one-char tokens */
  const char* specialOneCharTokens = g_toolsMode ? "" : "/=";

  long lineLen = len(line);
  /* only "!" at beginning of line acts as comment.
     This is done because sometimes ! might be legal as part of a command */
  enum mode_t {
    MODE_START, // look for start of token
    MODE_END, // look for end of token
    MODE_SQUOTE, // look for trailing single quote
    MODE_DQUOTE, // look for trailing double quote
  } mode = MODE_START;
  long p = 0;
  for (; p < lineLen; p++) {
    freeTempAlloc(); /* Clean up temp alloc stack to prevent overflow */
    switch (mode) {
      case MODE_START: {
        /* If character is white space, ignore it */
        if (instr(1, tokenWhiteSpace, chr(line[p]))) continue;
        /* If character is comment, we're done */
        if (p == 0 && instr(1, tokenComment, chr(line[p]))) goto parseCommandLine_ret;

        /* If character is a special token, get it but don't change mode */
        if (instr(1, specialOneCharTokens, chr(line[p]))) {
          pntrLet(&g_rawArgPntr, pntrAddElement(g_rawArgPntr));
          nmbrLet(&g_rawArgNmbr, nmbrAddElement(g_rawArgNmbr, p+1));
                                                            /* Save token start */
          let((vstring *)(&g_rawArgPntr[g_rawArgs]), chr(line[p]));
          g_rawArgs++;
          continue;
        }
        /* If character is a quote, set start and change mode */
        if (line[p] == '\'') {
          mode = MODE_SQUOTE;
          tokenStart = p + 2;
          continue;
        }
        if (line[p] == '\"') {
          mode = MODE_DQUOTE;
          tokenStart = p + 2;
          continue;
        }
        /* Character must be start of a token */
        mode = MODE_END;
        tokenStart = p + 1;
      } break;

      case MODE_END: {
        /* If character is white space, end token and change mode */
        if (instr(1, tokenWhiteSpace, chr(line[p]))) {
          pntrLet(&g_rawArgPntr, pntrAddElement(g_rawArgPntr));
          nmbrLet(&g_rawArgNmbr, nmbrAddElement(g_rawArgNmbr, tokenStart));
                                                            /* Save token start */
          let((vstring *)(&g_rawArgPntr[g_rawArgs]), seg(line, tokenStart, p));
          g_rawArgs++;
          mode = MODE_START;
          continue;
        }

        /* Character must be continuation of the token */
      } break;

      case MODE_SQUOTE:
      case MODE_DQUOTE: {
        /* If character is a quote, end quote and change mode */
        if (line[p] == (mode == MODE_SQUOTE ? '\'' : '\"')) {
          mode = MODE_START;
          pntrLet(&g_rawArgPntr, pntrAddElement(g_rawArgPntr));
          nmbrLet(&g_rawArgNmbr, nmbrAddElement(g_rawArgNmbr, tokenStart));
                                                            /* Save token start */
          let((vstring *)(&g_rawArgPntr[g_rawArgs]),seg(line, tokenStart, p));
          g_rawArgs++;
          continue;
        }
        /* Character must be continuation of quoted token */
      } break;
    }
  }

  /* Finished scanning the line.  Finish processing last token. */
  if (mode != MODE_START) {
    pntrLet(&g_rawArgPntr, pntrAddElement(g_rawArgPntr));
    nmbrLet(&g_rawArgNmbr, nmbrAddElement(g_rawArgNmbr, tokenStart));
                                                          /* Save token start */
    let((vstring *)(&g_rawArgPntr[g_rawArgs]),seg(line, tokenStart, p));
    g_rawArgs++;
  }

parseCommandLine_ret:
  /* Add length of command line prompt to each argument, to
     align the error message pointer */
  for (long i = 0; i < g_rawArgs; i++) {
    g_rawArgNmbr[i] = g_rawArgNmbr[i] + len(g_commandPrompt);
  }
} /* parseCommandLine */

flag lastArgMatches(vstring argString) {
  /* This functions checks to see if the last field was argString */
  if (!strcmp(argString, g_fullArg[pntrLen(g_fullArg)-1])) {
    return (1);
  } else {
    return (0);
  }
} /* lastArgMatches */

flag cmdMatches(vstring cmdString) {
  /* This function checks that fields 0 through n of g_fullArg match
     cmdString (separated by spaces). */
  long i, j, k;
  /* Count the number of spaces */
  k = len(cmdString);
  j = 0;
  for (i = 0; i < k; i++) {
    if (cmdString[i] == ' ') j++;
  }
  k = pntrLen(g_fullArg);
  vstring_def(tmpStr);
  for (i = 0; i <= j; i++) {
    if (j >= k) {
      /* Command to match is longer than the user's command; assume no match */
      free_vstring(tmpStr);
      return 0;
    }
    let(&tmpStr, cat(tmpStr, " ", g_fullArg[i], NULL));
  }
  if (!strcmp(cat(" ", cmdString, NULL), tmpStr)) {
    free_vstring(tmpStr);
    return 1;
  } else {
    free_vstring(tmpStr);
    return 0;
  }
} /* cmdMatches */

// This function checks that field i of g_fullArg matches "/", and
// field i+1 matches swString (which must not contain spaces).
// The position of the "/" in g_fullArg is returned if swString is there,
// otherwise 0 is returned (the first position in g_fullArg is considered 1, not 0).
//
// Example:  if g_fullArg (combined into one string) is
// "DISPLAY PROOF / UNKNOWN / START_STEP = 10 / ESSENTIAL"
// and swString is "START_STEP", switchPos will return 5.
long switchPos(const char *swString) {
  if (instr(1, swString, " ")) bug(1108);

  long k = pntrLen(g_fullArg);
  for (long i = 0; i < k; i++) {
    if (strcmp(g_fullArg[i], "/") == 0) {
      if (i+1 < k && strcmp(g_fullArg[i+1], swString) == 0) {
        return i + 1;
      }
    }
  }
  return 0;
} /* switchPos */

void freeCommandLine(void) {
  long i, j;
  j = pntrLen(g_rawArgPntr);
  for (i = 0; i < j; i++) free_vstring(*(vstring *)(&g_rawArgPntr[i]));
  j = pntrLen(g_fullArg);
  for (i = 0; i < j; i++) free_vstring(*(vstring *)(&g_fullArg[i]));
  free_pntrString(g_fullArg);
  free_pntrString(g_rawArgPntr);
  free_nmbrString(g_rawArgNmbr);
  free_vstring(g_fullArgString);
}
