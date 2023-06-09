/*****************************************************************************/
/*        Copyright (C) 2021  NORMAN MEGILL                                  */
/*            License terms:  GNU General Public License                     */
/*****************************************************************************/
/*34567890123456 (79-character line to adjust editor window) 2345678901234567*/

// This module processes LaTeX and HTML output.

#include "mmwtex.h"
#include "mmcmdl.h" // For g_texFileName
#include "mmdata.h"
#include "mminou.h"
#include "mmpars.h" // For rawSourceError and mathSrchCmp and lookupLabel
#include "mmvstr.h"
#include <ctype.h>
#include <stdlib.h>
#include <string.h>

// All LaTeX and HTML definitions are taken from the source
// file (read in the by READ... command).  In the source file, there should
// be a single comment $( ... $) containing the keyword $t.  The definitions
// start after the $t and end at the $).  Between $t and $), the definition
// source should exist.  See the file set.mm for an example.

flag g_oldTexFlag = 0; // Use TeX macros in output (obsolete)

flag g_htmlFlag = 0; // HTML flag: 0 = TeX, 1 = HTML
// Use "althtmldef" instead of "htmldef".  This is intended to allow the
// generation of pages with the Unicode font instead of the individual GIF
// files.
flag g_altHtmlFlag = 0;
// Output statement lists only, for statement display in other HTML pages,
// such as the Proof Explorer home page.
flag g_briefHtmlFlag = 0;
// At this statement and above, use the exthtmlxxx
// variables for title, links, etc.  This was put in to allow proper
// generation of the Hilbert Space Explorer extension to the set.mm
// database.
long g_extHtmlStmt = 0;

// Globals to hold mathbox information.  They should be re-initialized
// by the ERASE command (eraseSource()).  g_mathboxStmt = 0 indicates
// it and the other variables haven't been initialized.
// At this statement and above, use SANDBOX_COLOR background for theorem,
// mmrecent, & mmbiblio lists.
// 0 means it hasn't been looked up yet; g_statements + 1 means there is
// no mathbox.
long g_mathboxStmt = 0;
long g_mathboxes = 0; // # of mathboxes
// The following 3 strings are 0-based e.g. g_mathboxStart[0] is for
// mathbox #1.
nmbrString_def(g_mathboxStart); // Start stmt vs. mathbox #
nmbrString_def(g_mathboxEnd);   // End stmt vs. mathbox #
pntrString_def(g_mathboxUser);  // User name vs. mathbox #

// This is the list of characters causing the space before the opening "`"
// in a math string in a comment to be removed for HTML output.
#define OPENING_PUNCTUATION "(['\""
// This is the list of characters causing the space after the closing "`"
// in a math string in a comment to be removed for HTML output.
#define CLOSING_PUNCTUATION ".,;)?!:]'\"_-"

// Tex output file
FILE *g_texFilePtr = NULL;
flag g_texFileOpenFlag = 0;

// Global variables
flag g_texDefsRead = 0;
struct texDef_struct *g_TexDefs;

// Variables local to this module (except some $t variables)
long numSymbs;
// Substitute character for $ in converting to obsolete $l,$m,$n
// comments - Use '$' instead of non-printable ASCII 2 for debugging.
#define DOLLAR_SUBST 2

// Variables set by the language in the set.mm etc. $t statement
// Some of these are global; see mmwtex.h
vstring_def(g_htmlCSS);      // Set by g_htmlCSS commands
vstring_def(g_htmlFont);     // Set by htmlfont commands
vstring_def(g_htmlVarColor); // Set by htmlvarcolor commands
vstring_def(htmlExtUrl);     // Set by htmlexturl command
vstring_def(htmlTitle);      // Set by htmltitle command
vstring_def(htmlTitleAbbr);  // Extracted from htmlTitle
vstring_def(g_htmlHome);     // Set by htmlhome command
// Future - assign these in the $t set.mm comment instead of g_htmlHome
vstring_def(g_htmlHomeHREF);     // Extracted from g_htmlHome
vstring_def(g_htmlHomeIMG);      // Extracted from g_htmlHome
vstring_def(g_htmlBibliography); // Optional; set by htmlbibliography command
vstring_def(extHtmlLabel); // Set by exthtmllabel command - where extHtml starts
vstring_def(g_extHtmlTitle);     // Set by exthtmltitle command (global!)
vstring_def(g_extHtmlTitleAbbr); // Extracted from htmlTitle
vstring_def(extHtmlHome);        // Set by exthtmlhome command
// Future - assign these in the $t set.mm comment instead of g_htmlHome
vstring_def(extHtmlHomeHREF); // Extracted from extHtmlHome
vstring_def(extHtmlHomeIMG);  // Extracted from extHtmlHome
vstring_def(
    extHtmlBibliography); // Optional; set by exthtmlbibliography command
vstring_def(htmlDir);     // Directory for GIF version, set by htmldir command
// Directory for Unicode Font version, set by althtmldir command
vstring_def(altHtmlDir);

// Sandbox stuff
vstring_def(sandboxHome);
vstring_def(sandboxHomeHREF); // Extracted from extHtmlHome
vstring_def(sandboxHomeIMG);  // Extracted from extHtmlHome
vstring_def(sandboxTitle);
vstring_def(sandboxTitleAbbr);

// Variables holding all HTML <a name..> tags from bibliography pages
vstring_def(g_htmlBibliographyTags);
vstring_def(extHtmlBibliographyTags);

void eraseTexDefs(void) {
  // Deallocate the texdef/htmldef storage
  free_vstring(htmlTitle);
  free_vstring(g_htmlHome);
  free_vstring(g_htmlCSS);
  free_vstring(g_htmlFont);
  free_vstring(g_htmlVarColor);
  free_vstring(htmlExtUrl);
  free_vstring(htmlTitle);
  free_vstring(htmlTitleAbbr);
  free_vstring(g_htmlHome);
  free_vstring(g_htmlHomeHREF);
  free_vstring(g_htmlHomeIMG);
  free_vstring(g_htmlBibliography);
  free_vstring(extHtmlLabel);
  free_vstring(g_extHtmlTitle);
  free_vstring(g_extHtmlTitleAbbr);
  free_vstring(extHtmlHome);
  free_vstring(extHtmlHomeHREF);
  free_vstring(extHtmlHomeIMG);
  free_vstring(extHtmlBibliography);
  free_vstring(htmlDir);
  free_vstring(altHtmlDir);
  free_vstring(sandboxHome);
  free_vstring(sandboxHomeHREF);
  free_vstring(sandboxHomeIMG);
  free_vstring(sandboxTitle);
  free_vstring(sandboxTitleAbbr);
  free_vstring(g_htmlBibliographyTags);
  free_vstring(extHtmlBibliographyTags);
  return;
} // eraseTexDefs

flag printTexComment(vstring commentPtr, flag htmlCenterFlag, long actionBits,

                     flag fileCheck) {
  return htmlCenterFlag;
} // 1 = check external files (gifs and bib)

void printTexLongMath(nmbrString *mathString, vstring startPrefix,

                      vstring contPrefix,

                      long hypStmt, long indentationLevel) {}

// Return 1 if error found, 0 otherwise
flag getSectionHeadings(long stmt, vstring *hugeHdrTitle, vstring *bigHdrTitle,
                        vstring *smallHdrTitle, vstring *tinyHdrTitle,
                        vstring *hugeHdrComment, vstring *bigHdrComment,
                        vstring *smallHdrComment, vstring *tinyHdrComment,
                        flag fineResolution, flag fullComment) {
  return fullComment;
}

vstring asciiToTt(vstring s) {
  vstring_def(ttstr);
  return ttstr;
}

flag readTexDefs(flag errorsOnly, // 1 = suppress non-error messages
                 flag gifCheck)   // 1 = check for missing GIFs
{
  return errorsOnly;
}

long getMathboxNum(long stmt) { return 0;}
/*! Populates mathbox information */
void assignMathboxInfo(void) {}

temp_vstring asciiToTt_temp(vstring s) {
  return makeTempAlloc(asciiToTt(s));
}


flag writeBibliography(
    vstring bibFile,
    vstring labelMatch, // Normally "*" except when called by verifyMarkup()
    flag errorsOnly,    // 1 = no output, just warning msgs if any
    flag fileCheck)     // 1 = check external files (gifs and bib)
{
  flag errFlag;
  return errFlag;
}
