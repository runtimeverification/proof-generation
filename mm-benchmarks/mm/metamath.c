/*****************************************************************************/
/* Program name:  metamath                                                   */
/* Copyright (C) 2021 NORMAN MEGILL                      http://metamath.org */
/* License terms:  GNU General Public License Version 2 or any later version */
/*****************************************************************************/
/*34567890123456 (79-character line to adjust editor window) 2345678901234567*/

/* Copyright notice:  All code in this program that was written by Norman
   Megill is public domain.  However, the project includes code contributions
   from other people which may be GPL licensed.  For more details see:
   https://github.com/metamath/metamath-exe/issues/7#issuecomment-675555069 */

/*! \file
 * Contains main(), the starting point of metamath; executes or calls commands
 */

/* The overall functionality of the modules is as follows:
    metamath.c - Contains main(); executes or calls commands
    mmcmdl.c - Command line interpreter
    mmcmds.c - Extends metamath.c command() to execute SHOW and other
               commands; added after command() became too bloated (still is:)
    mmdata.c - Defines global data structures and manipulates arrays
               with functions similar to BASIC string functions;
               memory management; converts between proof formats
    mmfatl.c - Fatal error handler
    mmhlpa.c - The help file, part 1.
    mmhlpb.c - The help file, part 2.
    mminou.c - Basic input and output interface
    mmpars.c - Parses the source file
    mmpfas.c - Proof Assistant
    mmunif.c - Unification algorithm for Proof Assistant
    mmveri.c - Proof verifier for source file
    mmvstr.c - BASIC-like string functions
    mmwtex.c - LaTeX/HTML source generation
    mmword.c - File revision utility (for TOOLS> UPDATE) (not generally useful)
*/

/* Compilation instructions (gcc on Unix/Linus/Cygwin, lcc on Windows):
   1. Make sure each .c file above is present in the compilation directory and
      that each .c file (except metamath.c) has its corresponding .h file
      present.
   2. In the directory where these files are present, type:
         gcc m*.c -o metamath
   3. For full error checking, use:
         gcc m*.c -o metamath -O2 -Wall -Wextra -Wmissing-prototypes \
             -Wmissing-declarations -Wshadow -Wpointer-arith -Wcast-align \
             -Wredundant-decls -Wnested-externs -Winline -Wno-long-long \
             -Wconversion -Wstrict-prototypes -std=c99 -pedantic -Wunused-result
      Note: gcc 4.9.2 (on Debian) fails with "unknown type name `ssize_t'" if
      -std=c99 is used, so omit -std=c99 to work around this problem.
   4. For faster runtime, use these gcc options:
         gcc m*.c -o metamath -O3 -funroll-loops -finline-functions \
             -fomit-frame-pointer -Wall -std=c99 -pedantic -fno-strict-overflow
   5. The Windows version in the download was compiled with lcc-win32 version 3.8:
         lc -O m*.c -o metamath.exe
   6. On Linux, if you have autoconf, automake, and a C compiler, you
      can compile with the command "autoreconf -i && ./configure && make".
      See the README.TXT file for more information.
*/

/*! \def MVERSION
 * The current version of metamath.  It is incremented each time the software
 * is modified.  When main versions are released, the version consists of a
 * major version, followed by a dot and a three-digit minor version.
 * Pre-release versions are further followed by a free style suffix that
 * should allow ordering.
 * The version string is extracted and then processed by shell and perl
 * scripts.  To avoid problems during replacements:
 * - use only printable characters from the ASCII range;
 * - avoid characters from the following set, eligible for escaping in text, regular
 *     expressions and so on like -begin of list ][`*+^$'?"{/}\ end of list-;
 * - use no space character other than simple space (U+0020);
 * - never use space characters at the beginning or at the end;
 * - the length is limited to 26 characters.
 */
#define MVERSION "0.199.pre 29-Jan-2022"
/* 0.199.pre
   30-Dec-2021 mc metamath.c mmdata.c mminou.c mmmaci.c -
     Remove mmmaci and everything related to THINK_C compiler
   4-Jan-2022 mc - change VERIFY MARKUP /TOP_DATE_SKIP and /FILE_SKIP to
     /TOP_DATE_CHECK and /FILE_CHECK (with opposite meaning), and make the
     skip behavior the default.
   7-Sep-2022 bj mmwtex.c, mmhlpa.c Added CRITERIA CRITERION to [bib]
     keywords */
/* 0.198 nm 7-Aug-2021 mmpars.c - Fix cosmetic bug in WRITE SOURCE ... /REWRAP
   that prevented end of sentence (e.g. period) from appearing in column 79,
   thus causing some lines to be shorter than necessary. */
/* 0.197 nm 2-Aug-2021 mmpars.c - put two spaces between $c,v on same line
   in /rewrap; mmwtex.c mmhlpa.c mminou.c - minor edits */
/* 0.196 nm 31-Dec-2020 metamath.c mmpars.c - fix bug that deleted comments
   that were followed by ${, $}, $c, $v, $d on the same line */
/* 0.195 nm 30-Dec-2020 metamath.c - temporarily disable /REWRAP until bug fixed
   27-Sep-2020 nm mmwtex.c - prevent "htmlexturl" links from wrapping */
/* 0.194 26-Dec-2020 nm mmwtex.c - add keyword "htmlexturl" to $t
   statement in .mm file */
/* 0.193 12-Sep-2020 nm mmcmds.c mmdata.c,h mmwtex.c,h mmhlpa.c - make the
   output of /EXTRACT stable in the sense that, with the same <label-list>
   parameter, extract(extract(file)) = extract(file) except that the date
   stamp at the top will be updated.  (The first extraction even if "*" will
   usually be different because it discards non-relevant content.  Note that
   the include file directives "$( $[ Begin..." etc. and comments with "$j" are
   currently discarded.) */
/* 0.192 4-Sep-2020 nm metamath.c - fix bug */
/* 0.191 4-Sep-2020 nm metamath.c - add comment close */
/* 0.190 4-Sep-2020 nm mmcmds.c - fix bug in writeExtractedSource() */
/* 0.189 4-Sep-2020 nm mmhlpa.c - add help for WRITE SOURCE .. /EXTRACT ...
   24-Aug-2020 nm metamath.c mmcmdl.c mmcmds.c,h mmdata.c,h mmhlpa.c
     mmpars.c mmpfas.c mmunif.c mmwtex.c,h - Added
     WRITE SOURCE ... /EXTRACT ... */
/* 0.188 23-Aug-2020 nm mmwtex.c, mmhlpa.c Added CONCLUSION FACT INTRODUCTION
     PARAGRAPH SCOLIA SCOLION SUBSECTION TABLE to [bib] keywords */
/* 0.187 15-Aug-2020 nm All m*.c, m*.h - put "g_" in front of all global
     variable names e.g. "statements" becomes "g_statements"; also capitalized
     1st letter of original name in case of global structs e.g. "statement"
     becomes "g_Statement".
   9-Aug-2020 nm mmcmdl.c, mmhlpa.c - add HELP BIBLIOGRAPHY */
/* 0.186 8-Aug-2020 nm mmwtex.c, mmhlpa.c - add CONJECTURE, RESULT to [bib]
     keywords
   8-Aug-2020 nm mmpfas.c, metamath.c - print message when IMPROVE or
     MINIMIZE_WITH uses another mathbox */
/* 0.185 5-Aug-2020 nm metamath.c mmcmdl.c mmhlpb.c mmpfas.c,h mmcmds.c
     mmwtex.c,h - add /INCLUDE_MATHBOXES to to IMPROVE; notify user upon ASSIGN
     from another mathbox.
   18-Jul-2020 nm mmcmds.c, mmdata.c, mmhlpb.c, metamath.c - "PROVE =" will now
     resume the previous MM-PA session if there was one; allow "~" to start/end
     with blank (meaning first/last statement); add "@1234" */
/* 0.184 17-Jul-2020 nm metamath.c mmcmdl.c mmcmds.c,h mmhlpb.c mmwtex.c,h -
     add checking for mathbox independence to VERIFY MARKUP; add /MATHBOX_SKIP
   4-Jul-2020 nm mmwtex.c - correct error msg for missing althtmldef
   3-Jul-2020 nm metamath.c, mmhlpa.c - allow space in TOOLS> BREAK */
/* 0.183 30-Jun-2020 30-Jun-2020 nm mmpars.c - refine prevention of
     WRITE SOURCE.../REWRAP from modifying comments containing "<HTML>"
     (specifically, remove indentation alignment).
   25-Jun-2020 nm metamath.c, mmcmds.c,h mmcmdl.c mmhlpb.c - add underscore
     checking in VERIFY MARKUP and add /UNDERSCORE_SKIP qualifier; also check
     for trailing space on lines.
   20-Jun-2020 nm mmcmds.c - check for discouragement tags in *ALT, *OLD
     labels in VERIFY MARKUP.
   19-Jun-2020 nm mminou.c,h, metamath.c, mmwtex.c - dynamically allocate
     buffer in print2() using vsnprintf() to calculate size needed
   18-Jun-2020 nm mmpars.c - remove error check for $e <- $f assignments.  See
     https://groups.google.com/d/msg/metamath/Cx_d84uorf8/0FrNYTM9BAAJ */
/* 0.182 12-Apr-2020 nm mmwtex.c, mmphlpa.c - add "Claim" to bib ref types */
/* 0.181 12-Feb-2020 nm (reported by David Starner) metamath.c - fix bug causing
     new axioms to be used by MINIMIZE_WITH */
/* 0.180 10-Dec-2019 nm (bj 13-Sep-2019) mmpars.c - fix "line 0" in error msg
     when label clashes with math symbol
   8-Dec-2019 nm (bj 13-Oct-2019) mmhlpa.c - improve TOOLS> HELP INSERT, DELETE
   8-Dec-2019 nm (bj 19-Sep-2019) mminou.c - change bug 1511 to error message
   30-Nov-2019 nm (bj 12-Oct-2019) mmwtex.c - trigger Most Recent link on
     mmtheorems.html when there is a mathbox statement (currently set.mm and
     iset.mm).
   30-Nov-2019 nm (bj 13-Sep-2019) mmhlpa.c - improve help for TOOLS> DELETE and
     SUBSTITUTE.
   30-Nov-2019 nm (bj 13-Sep-2019) mmwtex.c - change "g_htmlHome" in warnings to
     "htmlhome". */
/* 0.179 29-Nov-2019 nm (bj 22-Sep-2019) metamath.c - MINIMIZE_WITH axiom trace
     now starts from current NEW_PROOF instead of SAVEd proof.
   23-Nov-2019 nm (bj 4-Oct-2019) metamath.c - make sure traceback flags are
     cleared after MINIMIZE_WITH
   20-Nov-2019 nm mmhlpa.c - add url pointer to HELP WRITE SOURCE /SPLIT
   18-Nov-2019 nm mmhlpa.c - clarify HELP WRITE SOURCE /REWRAP
   15-Oct-2019 nm mmdata.c - add bug check info for user
   14-Oct-2019 nm mmcmds.c - use '|->' (not 'e.') as syntax hint for maps-to
   14-Oct-2019 nm mmwtex.c - remove extraneous </TD> */
/* 0.178 10-Aug-2019 nm mminou.c - eliminate redundant fopen in fSafeOpen
   6-Aug-2019 nm mmwtex.c,h, mmcmds.c - Add error check for >1 line
     section name or missing closing decoration line in getSectionHeadings()
   4-Aug-2019 nm mmhlpb.c, mmcmdl.c, metamath.c - Add /ALLOW_NEW_AXIOMS,
     renamed /ALLOW_GROWTH to /MAY_GROW
   17-Jul-2019 nm mmcmdl.c, mmhlpa.c, metamath.c - Add /NO_VERSIONING to
     WRITE THEOREM_LIST
   17-Jul-2019 nm metamath.c - Change line of dashes between SHOW STATEMENT
     output from hardcoded 79 to current g_screenWidth */
/* 0.177 27-Apr-2019 nm mmcmds.c -"set" -> "setvar" in htmlAllowedSubst.
   mmhlpb.c - fix typos in HELP IMPROVE. */
/* 0.176 25-Mar-2019 nm metamath.c mmcmds.h mmcmds.c mmcmdl.c mmhlpb.c -
   add /TOP_DATE_SKIP to VERIFY MARKUP */
/* 0.175 8-Mar-2019 nm mmvstr.c - eliminate warning in gcc 8.3 (patch
   provided by David Starner) */
/* 0.174 22-Feb-2019 nm mmwtex.c - fix erroneous warning when using "[["
   bracket escape in comment */
/* 0.173 3-Feb-2019 nm mmwtex.c - fix infinite loop when "[" was the first
   character in a comment */
/* 0.172 25-Jan-2019 nm mmwtex.c - comment out bug 2343 trap (not a bug) */
/* 0.171 13-Dec-2018 nm metamath.c, mmcmdl.c, mmhlpa.c, mmcmds.c,h, mmwtex.c,h
   - add fine-grained qualifiers to MARKUP command */
/* 0.170 12-Dec-2018 nm mmwtex.c - restore line accidentally deleted in 0.169 */
/* 0.169 10-Dec-2018 nm metamath.c, mmcmds.c,h, mmcmdl.c, mmpars.c, mmhlpa.c,
   mmwtex.c - Add MARKUP command.
   9-Dec-2018 nm mmwtex.c - escape literal "[" with "[[" in comments. */
/* 0.168 8-Dec-2018 nm metamath.c - validate that /NO_REPEATED_STEPS is used
   only with /LEMMON.
   8-Dec-2018 nm mmcmds.c - fix bug #256 reported by Jim Kingdon
   (https://github.com/metamath/set.mm/issues/497). */
/* 0.167 13-Nov-2018 nm mmcmds.c - SHOW TRACE_BACK .../COUNT now uses proof
   the way it's stored (previously, it always uncompressed the proof).  The
   new step count (for compressed proofs) corresponds to the step count the
   user would see on the web pages.
   12-Nov-2018 nm mmcmds.c - added unlimited precision arithmetic
   for SHOW TRACE_BACK .../COUNT/ESSENTIAL */
/* 0.166 31-Oct-2018 nm mmwtex.c - workaround Chrome anchor bug
   30-Oct-2018 nm mmcmds.c - put "This theorem is referenced by" after
   axioms and definitions used in HTML; use "(None)" instead of suppressing
   line if nothing is referenced */
/* 0.165 20-Oct-2018 nm mmwtex.c - added ~ mmtheorems#abc type anchor
   in TOC details.  mmwtex.c - fix bug (reported by Benoit Jubin) that
   changes "_" in labels to subscript.  mmcmdl.c - remove unused COMPLETE
   qualifier from SHOW PROOF.  mmwtex.c - enhance special cases of web page
   spacing identified by Benoit Jubin */
/* 0.164 5-Sep-2018 nm mmwtex.c, mmhlpb.c - added NOTE to bib keywords
   14-Aug-2018 nm metamath.c - added defaultScrollMode to prevent
   SET SCROLL CONTINUOUS from reverting to PROMPTED after a SUBMIT command */
/* 0.163 4-Aug-2018 nm mmwtex.c - removed 2nd "sandbox:bighdr" anchor
   in mmtheorems.html; removed Firefox and IE references; changed breadcrumb
   font to be consistent with other pages; put asterisk next to TOC entries
   that have associated comments */
/* FOR FUTURE REFERENCE: search for "Thierry" in mmwtex.c to modify the link
   to tirix.org structured proof site */
/* 0.162-thierry 3-Jun-2018 nm mmwtex.c - add link to tirix.org structured
   proofs */
/* 0.162 3-Jun-2018 nm mmpars.c - re-enabled error check for $c not in
   outermost scope.  mmhlpa.c mmhlpb.c- improve some help messages.
   mmwtex.c - added "OBSERVATION", "PROOF", AND "STATEMENT" keywords for
   WRITE BIBLIOGRAPHY */
/* 0.161 2-Feb-2018 nm mmpars.c,h mmcmds.c mmwtex.c - fix wrong file name
   and line number in error messages */
/* 0.160 24-Jan-2018 nm mmpars.c - fix bug introduced in version 0.158 */
/* 0.159 23-Jan-2018 nm mmpars.c - fix crash due to missing include file */
/* 0.158 22-Jan-2018 nm mminou.c - strip CRs from Windows SUBMIT files
   run on Linux */
/* 0.157 15-Jan-2018 nm Major rewrite of READ-related functions.
     Added HELP MARKUP.
   9-Jan-2018 nm Track line numbers for error messages in included files
   1-Jan-2018 nm Changed HOME_DIRECTORY to ROOT_DIRECTORY
   31-Dec-2017 nm metamath.c mmcmdl.c,h mmpars.c,h mmcmds.c,h mminou.c,h
     mmwtex.c mmhlpb.c mmdata.h - add virtual includes "$( Begin $[...$] $)",
     $( End $[...$] $)", "$( Skip $[...$] $)" */
/* 0.156 8-Dec-2017 nm mmwtex.c - fix bug that incorrectly gave "verify markup"
   errors when there was a mathbox statement without an "extended" section */
/* 0.155 8-Oct-2017 nm mmcmdl.c - restore accidentally removed HELP HTML;
   mmhlpb.c mmwtex.c mmwtex.h,c mmcmds.c metamath.c - improve HELP and make
   other cosmetic changes per Benoit Jubin's suggestions */
/* 0.154 2-Oct-2017 nm mmunif.h,c mmcmds.c - add 2 more variables to ERASE;
   metamath.c mmcmdl.c - remove obsolete OPEN/CLOSE HTML; mmhlpa.c mmhlpb.c -
   fix typos reported by Benoit Jubin */
/* 0.153 1-Oct-2017 nm mmunif.c,h mmcmds.c - Re-initialize internal nmbrStrings
   in unify() after 'erase' command reported by Benoit Jubin */
/* 0.152 26-Sep-2017 nm mmcmds.c - change default links from mpegif to mpeuni;
   metamath.c - enforce minimum screen width = 3 to prevent crash reported
   by Benoit Jubin */
/* 0.151 20-Sep-2017 nm mmwtex.c - better matching to insert space between
   A and y in "E. x e. ran A y R x" to prevent spurious spaces in thms rncoeq,
   dfiun3g as reported by Benoit Jubin */
/* 0.150 26-Aug-2017 nm mmcmds.c,mmwtex.h - fix hyperlink for Distinct variable
   etc. lists so that it will point to mmset.html on other Explorers like NF.
   Move the "Dummy variables..." to print after the "Proof of Theorem..."
   line. */
/* 0.149 21-Aug-2017 nm mmwtex.c,h mmcmds.c mmhlpb.c - add a subsubsection
     "tiny" header with separator "-.-." to table of contents and theorem list;
     see HELP WRITE THEOREM_LIST
   21-Aug-2017 nm mmcmds.c - remove bug check 255
   19-Aug-2017 nm mmcmds.c - change mmset.html links to
     ../mpeuni/mmset.html so they will work in NF Explorer etc. */
/* 0.148 14-Aug-2017 nm mmcmds.c - hyperlink "Dummy variable(s)" */
/* 0.147 13-Aug-2017 nm mmcmds.c,h - add "Dummy variable x is distinct from all
   other variables." to proof web page */
/* 0.146 26-Jun-2017 nm mmwtex.c - fix handling of local labels in
     'show proof.../tex' (bug 2341 reported by Eric Parfitt) */
/* 0.145 16-Jun-2017 nm metamath.c mmpars.c - fix bug 1741 during
     MINIMIZE_WITH; mmpfas.c - make duplicate bug numbers unique; mmhlpa.c
     mmhlpb.c - adjust to prevent lcc compiler "Function too big for the
     optimizer"
   29-May-2017 nm mmwtex.c mmhlpa.c - take out extraneous  <HTML>...</HTML>
     markup tags in HTML output so w3c validator will pass */
/* 0.144 15-May-2017 nm metamath.c mmcmds.c - add "(Revised by..." tag for
     conversion of legacy .mm's if there is a 2nd date under the proof */
/* 0.143 14-May-2017 nm metamath.c mmdata.c,h mmcmdl.c mmcmds.c mmhlpb.c -
     added SET CONTRIBUTOR; for missing "(Contributed by..." use date
     below proof if it exists, otherwise use today's date, in order to update
     old .mm files.
   14-May-2017 Ari Ferrera - mmcmds.c - fix memory leaks in ERASE */
/* 0.142 12-May-2017 nm metamath.c mmdata.c,h mmcmds.c - added
     "#define DATE_BELOW_PROOF" in mmdata.h that if uncommented, will enable
     use of the (soon-to-be obsolete) date below the proof
   4-May-2017 Ari Ferrera - mmcmds.c metamath.c mmdata.c mmcmdl.c
     mminou.c mminou.h mmcmdl.h mmdata.h - fixed memory leaks and warnings
     found by valgrind.
   3-May-2017 nm - metamath.c mmdata.c,h mmcmds.c,h mmpars.c,h mmhlpb.c
     mmcmdl.c mmwtex.c - added xxChanged flags to statement structure so
     that any part of the source can be changed;  removed /CLEAN qualifier
     of WRITE SOURCE; automatically put "(Contributed by ?who?..." during
     SAVE NEW_PROOF or SAVE PROOF when it is missing; more VERIFY MARKUP
     checking. */
/* 0.141 2-May-2017 nm mmdata.c, metamath.c, mmcmds.c, mmhlpb.c - use
   getContrib() date for WRITE RECENT instead of date below proof.  This lets
   us list recent $a's as well as $p's.  Also, add caching to getContrib() for
   speedup. */
/* 0.140 1-May-2017 nm mmwtex.c, mmcmds.c, metamath.c - fix some LaTeX issues
   reported by Ari Ferrera */
/* 0.139 2-Jan-2017 nm metamath.c - print only one line for
     'save proof * /compressed/fast' */
/* 0.138 26-Dec-2016 nm mmwtex.c - remove extraneous </TD> causing w3c
   validation failure; put space after 1st x in "F/ x x = x";
   mmcmds.c - added checking for lines > 79 chars in VERIFY MARKUP;
   mmcmds.c, mmcmdl.c, metamath.c, mmhlpb.c, mmcmds.h - added /VERBOSE to
   VERIFY MARKUP */
/* 0.137 20-Dec-2016 nm mmcmds.c - check ax-XXX $a vs axXXX $p label convention
     in 'verify markup'
   18-Dec-2016 nm mmwtex.c, mmpars.c, mmdata.h - use true "header area"
     between successive $a/$p for getSectionHeadings()  mmcmds.c - add
     header comment checking
   13-Dec-2016 nm mmdata.c,h - enhanced compareDates() to treat empty string as
     older date.
   13-Dec-2016 nm metamath.c, mmcmds.c - moved mm* and Microsoft illegal file
     name label check to verifyMarkup() (the VERIFY MARKUP command) instead of
     checking on READ; added check of set.mm Version date to verifyMarkup().
   13-Dec-2016 nm mmwtex.c,h - don't treat bracketed description text with
     space as a bib label; add labelMatch parameter to writeBibliography() */
/* 0.136 10-Oct-2016 mminou.c - fix resource leak bug reported by David
   Binderman */
/* 0.135 11-Sep-2016, 14-Sep-2016 metamath.c, mmpfas.c,h, mmdata.c,h,
   mmpars.c,h mmcmds.c, mmcmdl.c, mmhlpb.c - added EXPAND command */
/* 0.134 16-Aug-2016 mmwtex.c - added breadcrumbs to theorem pages;
   metamath.c, mmcmdl.c, mmhlpb.c, mminou.c,.h - added /TIME to SAVE PROOF,
   SHOW STATEMENT.../[ALT}HTML, MINIMIZE_WITH */
/* 0.133 13-Aug-2016 mmwtex.c - improve mobile display with <head> tag
   mmpars.c - use updated Macintosh information */
/* 0.132 10-Jul-2016 metamath.c, mmcmdl.c, mmcmds.c,.h, mmdata.c,.h, mmhlpb.c,
   mmpfas.c - change "restricted" to "discouraged" to match set.mm markup
   tags; add SET DISCOURAGEMENT OFF|ON (default ON) to turn off blocking for
   convenience of advanced users
   6-Jul-2016 metamath.c - add "(void)" in front of "system(...)" to
   suppress -Wunused-result warning */
/* 0.131 10-Jun-2016 mminou.c - reverted change of 22-May-2016 because
   'minimize_with' depends on error message in string to prevent DV violations.
   Todo:  write a DV-checking routine for 'minimize_with', then revert
   the 22-May-2016 fix for bug 126 (which only occurs when writing web
   pages for .mm file with errors).
   9-Jun-2016 mmcmdl.c, metamath.c - added _EXIT_PA for use with
   scripts that will give an error message outside of MM-PA> rather
   than exiting metamath */
/* 0.130 25-May-2016 mmpars.c - workaround clang warning about j = j;
      mmvstr.c - workaround gcc -Wstrict-overflow warning */
/* 0.129 24-May-2016 mmdata.c - fix bug 1393 */
/* 0.128 22-May-2016 mminou.c - fixed error message going to html page
      instead of to screen, triggering bug 126. */
/* 0.127 10-May-2016 metamath.c, mmcmdl.c, mmhlpb.c - added /OVERRIDE to
      PROVE */
/* 0.126 3-May-2016 metamath.c, mmdata.h, mmdata.c, mmcmds.h, mmcmds.c,
      mmcmdl.c, mmhlpb.c, mmpars.c - added getMarkupFlag() in mmdata.c;
      Added /OVERRIDE added to ASSIGN, REPLACE, IMPROVE, MINIMIZE_WITH,
      SAVE NEW_PROOF;  PROVE gives warning about SAVE NEW_PROOF for locked
      proof.  Added SHOW RESTRICTED command.
   3-May-2016 m*.c - fix numerous conversion warnings provided by gcc 5.3.0 */
/* 0.125 10-Mar-2016 mmpars.c - fixed bug parsing /EXPLICIT/PACKED format
   8-Mar-2016 nm mmdata.c - added "#nnn" to SHOW STATEMENT etc. to reference
      statement number e.g. SHOW STATEMENT #58 shows a1i in set.mm.
   7-Mar-2016 nm mmwtex.c - added space between } and { in HTML output
   6-Mar-2016 nm mmpars.c - disabled wrapping of formula lines in
       WRITE SOURCE.../REWRAP
   2-Mar-2016 nm metamath.c, mmcmdl.c, mmhlpb.c - added /FAST to
       SAVE PROOF, SHOW PROOF */
/* 0.123 25-Jan-2016 nm mmpars.c, mmdata.h, mmdata.c, mmpfas.c, mmcmds.,
   metamath.c, mmcmdl.c, mmwtex.c - unlocked SHOW PROOF.../PACKED,
   added SHOW PROOF.../EXPLICIT */
/* 0.122 14-Jan-2016 nm metamath.c, mmcmds.c, mmwtex.c, mmwtex.h - surrounded
      math HTML output with "<SPAN [g_htmlFont]>...</SPAN>; added htmlcss and
      htmlfont $t commands
   10-Jan-2016 nm mmwtex.c - delete duplicate -4px style; metamath.c -
     add &nbsp; after char on mmascii.html
   3-Jan-2016 nm mmwtex.c - fix bug when doing SHOW STATEMENT * /ALT_HTML after
   VERIFY MARKUP */
/* 0.121 17-Nov-2015 nm metamath.c, mmcmdl.h, mmcmdl.c, mmcmds.h, mmcmds.c,
       mmwtex.h, mmwtex.c, mmdata.h, mmdata.c -
   1. Moved WRITE BIBLIOGRAPHY code from metamath.c to its own function in
      mmwtex.c; moved qsortStringCmp() from metamath.c to mmdata.c
   2. Added $t, comment markup, and bibliography checking to VERIFY MARKUP
   3. Added options to bug() bug-check interception to select aborting,
      stepping to next bug, or ignoring subsequent bugs
   4. SHOW STATEMENT can now use both /HTML and /ALT_HTML in same session
   5. Added /HTML, /ALT_HTML to WRITE THEOREM_LIST and
      WRITE RECENT_ADDITIONS */
/* 0.120 7-Nov-2015 nm metamath.c, mmcmdl.c, mmpars.c - add VERIFY MARKUP
   4-Nov-2015 nm metamath.c, mmcmds.c/h, mmdata.c/h - move getDescription,
       getSourceIndentation from mmcmds.c to mmdata.c.
       metamath.c, mmdata.c - add and call parseDate() instead of in-line
       code; add getContrib(), getProofDate(), buildDate(), compareDates(). */
/* 0.119 18-Oct-2015 nm mmwtex.c - add summary TOC to Theorem List; improve
       math symbol GIF image alignment
   2-Oct-2015 nm metamath.c, mmpfas.c, mmwtex.c - fix miscellaneous small
       bugs or quirks */
/* 0.118 18-Jul-2015 nm metamath.c, mmcmds.h, mmcmds.c, mmcmdl.c, mmhlpb.h,
   mmhlpb.c - added /TO qualifier to SHOW TRACE_BACK.  See
   HELP SHOW TRACE_BACK. */
/* 0.117 30-May-2015
   1. nm mmwtex.c - move <A NAME... tag to math symbol cell in proof pages so
      hyperlink will jump to top of cell (reported by Alan Sare)
   2. daw mmpfas.c - add INLINE speedup if compiler permits
   3. nm metamath.c, mminou.c, mmwtex.c, mmpfas.c - fix clang -Wall warnings
      (reported by David A. Wheeler) */
/* 0.116 9-May-2015 nm mmwtex.c - adjust paragraph break in 'write th';
   Statement List renamed Theorem List;  prevent space in after paragraph
   in Theorem List; remove stray "(";  put header and header comment
   in same table cell; fix <TITLE> of Theorem List pages */
/* 0.115 8-May-2015 nm mmwtex.c - added section header comments to
       WRITE THEOREM_LIST and broke out Table of Contents page
   24-Apr-2015 nm metamath.c - add # bytes to end of "---Clip out the proof";
       reverted to no blank lines there (see 0.113 item 3) */
/* 0.114 22-Apr-2015 nm mmcmds.c - put [-1], [-2],... offsets on 'show
   new_proof/unknown' */
/* 0.113 19-Apr-2015 so, nm metamath.c, mmdata.c
   1. SHOW LABEL % will show statements with changed proofs
   2. SHOW LABEL = will show the statement being proved in MM-PA
   3. Added blank lines before, after "---------Clip out the proof" proof
   4. Generate date only if the proof is complete */
/* 0.112 15-Apr-2015 nm metamath.c - fix bug 1121 (reported by S. O'Rear);
   mmwtex.c - add "img { margin-bottom: -4px }" to CSS to align symbol GIFs;
   mmwtex.c - remove some hard coding for set.mm, for use with new nf.mm;
   metamath.c - fix comment parsing in WRITE BIBLIOGRAPHY to ignore
   math symbols  */
/* 0.111 22-Nov-2014 nm metamath.c, mmcmds.c, mmcmdl.c, mmhlpb.c - added
   /NO_NEW_AXIOMS_FROM qualifier to MINIMIZE_WITH; see HELP MINIMIZE_WITH.
   21-Nov-2014 Stefan O'Rear mmdata.c, mmhlpb.c - added ~ label range specifier
   to wildcards; see HELP SEARCH */
/* 0.110 2-Nov-2014 nm mmcmds.c - fixed bug 1114 (reported by Stefan O'Rear);
   metamath.c, mmhlpb.c - added "SHOW STATEMENT =" to show the statement
   being proved in MM-PA (based on patch submitted by Stefan O'Rear) */
/* 0.109 20-Aug-2014 nm mmwtex.c - fix corrupted HTML caused by misinterpreting
   math symbols as comment markup (math symbols with _ [ ] or ~).  Also,
   allow https:// as well as http:// in ~ label markup.
   11-Jul-2014 wl mmdata.c - fix obscure crash in debugging mode db9 */
/* 0.108 25-Jun-2014 nm
   (1) metamath.c, mmcmdl.c, mmhlpb.c - MINIMIZE_WITH now checks the size
   of the compressed proof, prevents $d violations, and tries forward and
   reverse statement scanning order; /NO_DISTINCT, /BRIEF, /REVERSE
   qualifiers were removed.
   (2) mminou.c - prevent hard breaks (in the middle of a word) in too-long
   lines (e.g. long URLs) in WRITE SOURCE .../REWRAP; just overflow the
   screen width instead.
   (3) mmpfas.c - fixed memory leak in replaceStatement()
   (4) mmpfas.c - suppress inf. growth with MINIMIZE_WITH idi/ALLOW_GROWTH */
/* 0.107 21-Jun-2014 nm metamath.c, mmcmdl.c, mmhlpb.c - added /SIZE qualifier
   to SHOW PROOF; added SHOW ELAPSED_TIME; mmwtex.c - reformatted WRITE
   THEOREM_LIST output; now "$(", newline, "######" starts a "part" */
/* 0.106 30-Mar-2014 nm mmwtex.c - fix bug introduced by 0.105 that disabled
   hyperlinks on literature refs in HTML comment.  metamath.c - improve
   messages */
/* 0.105 15-Feb-2014 nm mmwtex.c - prevented illegal LaTeX output for certain
   special characters in comments. */
/* 0.104 14-Feb-2014 nm mmwtex.c - fixed bug 2312, mmcmds.c - enhanced ASSIGN
   error message. */
/* 0.103 4-Jan-2014 nm mmcmds.c,h - added "Allowed substitution hints" below
   the "Distinct variable groups" list on generated web pages
   mmwtex.c - added "*" to indicate DV's occur in Statement List entries. */
/* 0.102 2-Jan-2014 nm mminou.c - made compressed proof line wrapping more
   uniform at start of compressed part of proof */
/* 0.101 27-Dec-2013 nm mmdata.h,c, mminou.c, mmcmdl.c, mmhlpb.c, mmvstr.c -
   Improved storage efficiency of /COMPRESSED proofs (but with 20% slower run
   time); added /OLD_COMPRESSION to specify old algorithm; removed end-of-line
   space after label list in old algorithm; fixed linput() bug */
/* 0.100 30-Nov-2013 nm mmpfas.c - reversed statement scan order in
   proveFloating(), to speed up SHOW STATEMENT df-* /HTML; metamath.c - remove
   the unknown date place holder in SAVE NEW_PROOF; Wolf Lammen mmvstr.c -
   some cleanup */
/* 0.07.99 1-Nov-2013 nm metamath.c, mmpfas.h,c, mmcmdl.h,c, mmhlpa.c,
   mmhlpb.c - added UNDO, REDO, SET UNDO commands (see HELP UNDO) */
/* 0.07.98 30-Oct-2013 Wolf Lammen mmvstr.c,h, mminou.c, mmpars.c,
   mmdata.c  - improve code style and program structure */
/* 0.07.97 20-Oct-2013 Wolf Lammen mmvstr.c,h, metamath.c - improved linput();
   nm mmcmds.c, mmdata.c - tolerate bad proofs in SHOW TRACE_BACK etc. */
/* 0.07.96 20-Sep-2013 Wolf Lammen mmvstr.c - revised cat();
   nm mmwtex.c, mminou.c - change a print2 to printLongLine to fix bug 1150 */
/* 0.07.95 18-Sep-2013 Wolf Lammen mmvstr.c - optimized cat();
   nm metamath.c, mmcmds.c, mmdata.c, mmpars.c, mmpfas.c, mmvstr.c,
   mmwtex.c - suppress some clang warnings */
/* 0.07.94 28-Aug-2013 Alexey Merkulov mmcmds.c, mmpars.c - fixed several
   memory leaks found by valgrind --leak-check=full --show-possibly-lost=no */
/* 0.07.93 8-Jul-2013 Wolf Lammen mmvstr.c - simplified let() function;
   also many minor changes in m*.c and m*.h to assist future refactoring */
/* 0.07.92 28-Jun-2013 nm metamath.c mmcmds.c,h mmcmdl.c mmhlpb.c- added
   /NO_REPEATED_STEPS for /LEMMON mode of SHOW PROOF, SHOW NEW_PROOF.
   This reverts the /LEMMON mode default display change of 31-Jan-2010
   and invokes it when desired via /NO_REPEATED_STEPS. */
/* 0.07.91 20-May-2013 nm metamath.c mmpfas.c,h mmcmds.c,h mmcmdl.c
   mmhlpb.c- added /FORBID qualifier to MINIMIZE_WITH */
/* 0.07.90 19-May-2013 nm metamath.c mmcmds.c mmcmdl.c mmhlpb.c - added /MATCH
   qualifier to SHOW TRACE_BACK */
/* 0.07.88 18-Nov-2012 nm mmcmds.c - fixed bug 243 */
/* 0.07.87 17-Nov-2012 nm mmwtex.c - fixed formatting problem when label
   markup ends a comment in SHOW PROOF ... /HTML */
/* 0.07.86 27-Oct-2012 nm mmcmds.c, mmwtex.c, mmwtex.h - fixed ERASE bug
   caused by imperfect re-initialization; reported by Wolf Lammen */
/* 0.07.85 10-Oct-2012 nm metamath.c, mmcmdl.c, mmwtex.c, mmwtex.h, mmhlpb.c -
   added /SHOW_LEMMAS to WRITE THEOREM_LIST to bypass lemma math suppression */
/* 0.07.84 9-Oct-2012 nm mmcmds.c - fixed bug in getStatementNum() */
/* 0.07.83 19-Sep-2012 nm mmwtex.c - fixed bug reported by Wolf Lammen */
/* 0.07.82 16-Sep-2012 nm metamath.c, mmpfas.c - fixed REPLACE infinite loop;
   improved REPLACE message for shared dummy variables */
/* 0.07.81 14-Sep-2012 nm metamath.c, mmcmds.c, mmcmds.h, mmcmdl.c, mmhlpb.c
   - added FIRST, LAST, +nn, -nn where missing from ASSIGN, REPLACE,
   IMPROVE, LET STEP.  Wildcards are allowed for PROVE, ASSIGN, REPLACE
   labels provided there is a unique match. */
/* 0.07.80 4-Sep-2012 nm metamath.c, mmpfas.c, mmpfas.h, mmcmdl.c, mmhlpb.c
   - added / 1, / 2, / 3, / SUBPROOFS to IMPROVE to specify search level */
/* 0.07.79 31-Aug-2012 nm m*.c - clean up some gcc warnings */
/* 0.07.78 28-Aug-2012 nm mmpfas.c - fix bug in 0.07.77. */
/* 0.07.77 25-Aug-2012 nm metamath.c, mmpfas.c - Enhanced IMPROVE algorithm to
   allow non-shared dummy variables in unknown steps */
/* 0.07.76 22-Aug-2012 nm metamath.c, mmpfas.c, mmcmdl.c, mmhlpb.c -
   Enhanced IMPROVE algorithm to also try REPLACE algorithm */
/* 0.07.75 14-Aug-2012 nm metamath.c - MINIMIZE_WITH now checks current
   mathbox (but not other mathboxes) even if /INCLUDE_MATHBOXES is omitted */
/* 0.07.74 18-Mar-2012 nm mmwtex.c, mmcmds.c, metamath.c - improved texToken()
   error message */
/* 0.07.73 26-Dec-2011 nm mmwtex.c, mmpars.c - added <HTML>...</HTML> in
   comments for passing through raw HTML code into HTML files generated with
   SHOw STATEMENT xxx / HTML */
/* 0.07.72 25-Dec-2011 nm (obsolete) */
/* 0.07.71 10-Nov-2011 nm metamath.c, mmcmdl.c - added /REV to MINIMIZE_WITH */
/* 0.07.70 6-Aug-2011 nm mmwtex.c - fix handling of double quotes inside
   of htmldef strings to match spec in Metamath book Appendix A p. 156 */
/* 0.07.69 9-Jul-2011 nm mmpars.c, mmvstr.c - Untab file in WRITE SOURCE
   ... /REWRAP */
/* 0.07.68 3-Jul-2011 nm metamath.c, mminou.h, mminou.c - Nested SUBMIT calls
   (SUBMIT calls inside of a SUBMIT command file) are now allowed.
   Also, mmdata.c - fix memory leak. */
/* 0.07.67 2-Jul-2011 nm metamath.c, mmcmdl.c, mmhlpa.c - Added TAG command
   to TOOLS.  See HELP TAG under TOOLS.  (The old special-purpose TAG command
   was renamed to UPDATE.) */
/* 0.07.66 1-Jul-2011 nm metamath.c, mmcmds.c, mmpars.c, mmpars.h - Added code
   to strip spurious "$( [?] $)" in WRITE SOURCE ... /CLEAN output */
/* 0.07.65 30-Jun-2011 nm mmwtex.c - Prevent processing [...] bibliography
   brackets inside of `...` math strings in comments. */
/* 0.07.64 28-Jun-2011 nm metamath.c, mmcmdl.c - Added /INCLUDE_MATHBOXES
   qualifier to MINIMIZE_WITH; without it, MINIMIZE_WITH * will skip
   checking user mathboxes. */
/* 0.07.63 26-Jun-2011 nm mmwtex.c - check that .gifs exist for htmldefs */
/* 0.07.62 18-Jun-2011 nm mmpars.c - fixed bug where redeclaration of active
   $v was not detected */
/* 0.07.61 12-Jun-2011 nm mmpfas.c, mmcmds.c, metamath.c, mmhlpb.c - added
   /FORMAT and /REWRAP qualifiers to WRITE SOURCE to format according to set.mm
   conventions - set HELP WRITE SOURCE */
/* 0.07.60 7-Jun-2011 nm mmpfas.c - fixed bug 1805 which occurred when doing
   MINIMIZE_WITH weq/ALLOW_GROWTH after DELETE DELETE FLOATING_HYPOTHESES */
/* 0.07.59 11-Dec-2010 nm mmpfas.c - increased default SET SEARCH_LIMIT from
   10000 to 25000 to accommodate df-plig web page in set.mm */
/* 0.07.58 9-Dec-2010 nm mmpars.c - detect if same symbol is used with both
   $c and $v, in order to conform with Metamath spec */
/* 0.07.57 19-Oct-2010 nm mmpars.c - fix bug causing incorrect line count
   for error messages when non-ASCII character was found; mminou.h -
   increase SET WIDTH maximum from 999 to 9999 */
/* 0.07.56 27-Sep-2010 nm mmpars.c, mmpfas.c - check for $a's with
   one token e.g. "$a wff $."; if found, turn SET EMPTY_SUBSTITUTION ON
   automatically.  (Suggested by Mel O'Cat; patent pending.) */
/* 0.07.55 26-Sep-2010 nm mmunif.c, mmcmds.c, mmunif.h - check for mismatched
   brackets in all $a's, so that if there are any, the bracket matching
   algorithm (for fewer ambiguous unifications) in mmunif.c will be turned
   off. */
/* 0.07.54 25-Sep-2010 nm mmpars.c - added $f checking to conform to the
   current Metamath spec, so footnote 2 on p. 92 of Metamath book is
   no longer applicable. */
/* 0.07.53 24-Sep-2010 nm mmveri.c - fixed bug(2106), reported by Michal
   Burger */
/* 0.07.52 14-Sep-2010 nm metamath.c, mmwtex.h, mmwtex.c, mmcmds.c,
   mmcmdl.c, mmhlpb.c - rewrote the LaTeX output for easier hand-editing
   and embedding in LaTeX documents.  The old LaTeX output is still
   available with /OLD_TEX on OPEN TEX, SHOW STATEMENT, and SHOW PROOF,
   but it is obsolete and will be deleted eventually if no one objects.  The
   new /TEX output also replaces the old /SIMPLE_TEX, which was removed. */
/* 0.07.51 9-Sep-2010 Stefan Allen mmwtex.c - put hyperlinks on hypothesis
   label references in SHOW STATEMENT * /HTML, ALT_HTML output */
/* 0.07.50 21-Feb-2010 nm mminou.c - "./metamath < empty", where "empty" is a
   0-byte file, now exits metamath instead of producing an infinite loop.
   Also, ^D now exits metamath.  Reported by Cai Yufei */
/* 0.07.49 31-Jan-2010 nm mmcmds.c - Lemmon-style proofs (SHOW PROOF xxx
   /LEMON/RENUMBER) no longer have steps with dummy labels; instead, steps
   are now the same as in HTML page proofs.  (There is a line to comment
   out if you want to revert to old behavior.) */
/* 0.07.48 11-Sep-2009 nm mmpars.c, mm, mmvstr.c, mmdata.c - Added detection of
   non-whitespace around keywords (mmpars.c); small changes to eliminate
   warnings in gcc 3.4.4 (mmvstr.c, mmdata.c) */
/* 0.07.47 2-Aug-2009 nm mmwtex.c, mmwtex.h - added user name to mathbox
   pages */
/* 0.07.46 24-Jul-2009 nm metamath.c, mmwtex.c - changed name of sandbox
   to "mathbox" */
/* 0.07.45 15-Jun-2009 nm metamath.c, mmhlpb.c - put "!" before each line of
   SET ECHO ON output to make them easy to identity for creating scripts */
/* 0.07.44 12-May-2009 Stefan Allan, nm metamath.c, mmcmdl.c, mmwtex.c -
   added SHOW STATEMENT / MNEMONICS - see HELP SHOW STATEMENT */
/* 0.07.43 29-Aug-2008 nm mmwtex.c - workaround for Unicode huge font bug in
   FireFox 3 */
/* 0.07.42 8-Aug-2008 nm metamath.c - added sandbox, Hilbert Space colors to
   Definition List */
/* 0.07.41 29-Jul-2008 nm metamath.c, mmwtex.h, mmwtex.c - Added handling of
   sandbox section of Metamath Proof Explorer web pages */
/* 0.07.40 6-Jul-2008 nm metamath.c, mmcmdl.c, mmhlpa.c, mmhlpb.c - Added
   / NO_VERSIONING qualifier for SHOW STATEMENT, so website can be regenerated
   in place with less temporary space required.  Also, the wildcard trigger
   for mmdefinitions.html, etc. is more flexible (see HELP HTML). */
/* 0.07.39 21-May-2008 nm metamath.c, mmhlpb.c - Added wildcard handling to
   statement label in SHOW TRACE_BACK.  All wildcards now allow
   comma-separated lists [i.e. matchesList() instead of matches()] */
/* 0.07.38 26-Apr-2008 nm metamath.c, mmdata.h, mmdata.c, mmvstr.c, mmhlpb.c -
   Enhanced / EXCEPT qualifier for MINIMIZE_WITH to handle comma-separated
   wildcard list. */
/* 0.07.37 14-Apr-2008 nm metamath.c, mmcmdl.c, mmhlpb.c - Added / JOIN
   qualifier to SEARCH. */
/* 0.07.36 7-Jan-2008 nm metamath.c, mmcmdl.c, mmhlpb.c - Added wildcard
   handling for labels in SHOW USAGE. */
/* 0.07.35 2-Jan-2008 nm mmcmdl.c, metamath.c, mmhlpb.c - Changed keywords
   COMPACT to PACKED and COLUMN to START_COLUMN so that SAVE/SHOW proof can use
   C to abbreviate COMPRESSED.  (PACKED format is supported but "unofficial,"
   used mainly for debugging purposes, and is not listed in HELP SAVE
   PROOF.) */
/* 0.07.34 19-Nov-2007 nm mmwtex.c, mminou.c - Added tooltips to proof step
   hyperlinks in SHOW STATEMENT.../HTML,ALT_HTML output (suggested by Reinder
   Verlinde) */
/* 0.07.33 19-Jul-2007 nm mminou.c, mmvstr.c, mmdata.c, mmword.c - added fflush
   after each printf() call for proper behavior inside emacs (suggested by
   Frederic Line) */
/* 0.07.32 29-Apr-2007 nm mminou.c - fSafeOpen now stops at gap; e.g. if ~2
   doesn't exist, ~1 will be renamed to ~2, but any ~3, etc. are not touched */
/* 0.07.31 5-Apr-2007 nm mmwtex.c - Don't make "_" in hyperlink a subscript */
/* 0.07.30 8-Feb-2007 nm mmcmds.c, mmwtex.c Added HTML statement number info to
   SHOW STATEMENT.../FULL; friendlier "Contents+1" link in mmtheorems*.html */
/* 0.07.29 6-Feb-2007 Jason Orendorff mmpfas.c - Patch to eliminate the
   duplicate "Exceeded trial limit at step n" messages */
/* 0.07.28 22-Dec-2006 nm mmhlpb.c - Added info on quotes to HELP LET */
/* 0.07.27 23-Oct-2006 nm metamath.c, mminou.c, mmhlpa.c, mmhlpb.c - Added
   / SILENT qualifier to SUBMIT command */
/* 0.07.26 12-Oct-2006 nm mminou.c - Fixed bug when SUBMIT file was missing
   a new-line at end of file (reported by Marnix Klooster) */
/* 0.07.25 10-Oct-2006 nm metamath.c - Fixed bug invoking TOOLS as a ./metamath
   command-line argument */
/* 0.07.24 25-Sep-2006 nm mmcmdl.c Fixed bug in
   SHOW NEW_PROOF/START_COLUMN nn/LEM */
/* 0.07.23 31-Aug-2006 nm mmwtex.c - Added Home and Contents links to bottom of
   WRITE THEOREM_LIST pages */
/* 0.07.22 26-Aug-2006 nm metamath.c, mmcmdl.c, mmhlpb.c - Changed 'IMPROVE
   STEP <step>' to 'IMPROVE <step>' for user convenience and to be consistent
   with ASSIGN <step> */
/* 0.07.21 20-Aug-2006 nm mmwtex.c - Revised small colored numbers so that all
   colors have the same grayscale brightness.. */
/* 0.07.20 19-Aug-2006 nm mmpars.c - Made the error "Required hypotheses may
   not be explicitly declared" in a compressed proof non-severe, so that we
   can still SAVE the proof to reformat and recover it. */
/* 0.07.19 11-Aug-06 nm mmcmds.c - "Distinct variable group(s)" is now
   "group" or "groups" as appropriate. */
/* 0.07.18 31-Jul-06 nm mmwtex.c - added table to contents to p.1 of output of
   WRITE THEOREM_LIST command. */
/* 0.07.17 4-Jun-06 nm mmpars.c - do not allow labels to match math symbols
   (new spec proposed by O'Cat).   mmwtex.c - made theorem name 1st in title,
   for readability in Firefox tabs. */
/* 0.07.16 16-Apr-06 nm metamath.c, mmcmdl.c, mmpfas.c, mmhlpb.c - allow step
   to be negative (relative to end of proof) for ASSIGN, UNIFY, and LET STEP
   (see their HELPs).  Added INITIALIZE USER to delete LET STEP assignments
   (see HELP INITIALIZE).  Fixed bug in LET STEP (mmpfas.c). */
/* 0.07.15 10-Apr-06 nm metamath.c, mmvstr.c - change dates from 2-digit to
   4-digit year; make compatible with older 2-digit year. */
/* 0.07.14 21-Mar-06 nm mmpars.c - fix bug 1722 when compressed proof has
   "Z" at beginning of proof instead of after a proof step. */
/* 0.07.13 3-Feb-06 nm mmpfas.c - minor improvement to MINIMIZE_WITH */
/* 0.07.12 30-Jan-06 nm metamath.c, mmcmds.c, mmdata.c, mmdata.h, mmhlpa.c,
   mmhlpb.c - added "?" wildcard to match single character. See HELP SEARCH. */
/* 0.07.11 7-Jan-06 nm metamath.c, mmcmdl.c, mmhlpb.c - added EXCEPT qualifier
   to MINIMIZE_WITH */
/* 0.07.10 28-Dec-05 nm metamath.c, mmcmds.c - cosmetic tweaks */
/* 0.07.10 11-Dec-05 nm metamath.c, mmcmdl.c, mmhlpb.c - added ASSIGN FIRST
   and IMPROVE FIRST commands.  Also enhanced READ error message */
/* 0.07.9 1-Dec-05 nm mmvstr.c - added comment on how to make portable */
/* 0.07.9 18-Nov-05 nm metamath.c, mminou.c, mminou.h, mmcmdl.c, mmhlpb.c -
   added SET HEIGHT command; changed SET SCREEN_WIDTH to SET WIDTH; changed
   SET HENTY_FILTER to SET JEREMY_HENTY_FILTER (to make H for HEIGHT
   unambiguous); added HELP for SET JEREMY_HENTY_FILTER */
/* 0.07.8 15-Nov-05 nm mmunif.c - now detects wrong order in bracket matching
   heuristic to further reduce ambiguous unifications in Proof Assistant */
/* 0.07.7 12-Nov-05 nm mmunif.c - add "[","]" and "[_","]_" bracket matching
   heuristic to reduce ambiguous unifications in Proof Assistant.
   mmwtex.c - added heuristic for HTML spacing after "sum_" token. */
/* 0.07.6 15-Oct-05 nm mmcmds.c,mmpars.c - fixed compressed proof algorithm
   to match spec in book (with new algorithm due to Marnix Klooster).
   Users are warned to convert proofs when the old compression is found. */
/* 0.07.5 6-Oct-05 nm mmpars.c - fixed bug that reset "severe error in
   proof" flag when a proof with severe error also had unknown steps */
/* 0.07.4 1-Oct-05 nm mmcmds.c - ignored bug 235, which could happen for
   non-standard logics */
/* 0.07.3 17-Sep-05 nm mmpars.c - reinstated duplicate local label checking to
   conform to strict spec */
/* 0.07.2 19-Aug-05 nm mmwtex.c - suppressed math content for lemmas in
   WRITE THEOREMS output */
/* 0.07.1 28-Jul-05 nm Added SIMPLE_TEX qualifier to SHOW STATEMENT */
/* 0.07:  Official 0.07 22-Jun-05 corresponding to Metamath book */
/* 0.07x:  Fixed to work with AMD64 with 64-bit longs by
   Waldek Hebisch; deleted unused stuff in mmdata.c */
/* 0.07w:  .mm date format like "$( [7-Sep-04] $)" is now
   generated and permitted (old one is tolerated too for compatibility) */
/* Metamath Proof Verifier - main program */
/* See the book "Metamath" for description of Metamath and run instructions */

/*****************************************************************************/

/*----------------------------------------------------------------------*/

#include <string.h>
#include <stdlib.h>
#include "mmvstr.h"
#include "mmdata.h"
#include "mmcmdl.h"
#include "mmcmds.h"
#include "mminou.h"
#include "mmpars.h"
#include "mmveri.h"
#include "mmpfas.h"
#include "mmwtex.h"
#include "mmfatl.h"
#include "mmtest.h"

void command(int argc, char *argv[]);

/*! \fn int main(int argc, char *argv[])
 * \brief entry point of the metamath program
 * \param argc int number of command line parameters
 * \param argv (char*)[] array of \p argc command line parameters, followed by NULL
 * \return success 0 else failure
 *
 * Running metamath
 *   ./metamath 'read set.mm' 'verify proof *'
 * will start main with \p argc set to 2, argv[0] to "read set.mm", argv[1]
 * to "verify proof *" (both without quotes) and argv[2] to NULL.
 * Returning 0 indicates successful completion, anything else some kind of
 * failure.
 * For details see https://en.cppreference.com/w/cpp/language/main_function.
 */
int main(int argc, char *argv[]) {

/* argc is the number of arguments; argv points to an array containing them */

#ifdef TEST_ENABLE // enable this in mmtest.h or via './build.sh -t'
  RUN_TESTS();
  // you never get here
#endif

  /****** If g_listMode is set to 1 here, the startup will be Text Tools
          utilities, and Metamath will be disabled ***************************/
  /* (Historically, this mode was used for the creation of a stand-alone
     "TOOLS>" utility for people not interested in Metamath.  This utility
     was named "LIST.EXE", "tools.exe", and "tools" on VMS, DOS, and Unix
     platforms respectively.  The UPDATE command of TOOLS (mmword.c) was
     custom-written in accordance with the version control requirements of a
     company that used it; it documents the differences between two versions
     of a program as C-style comments embedded in the newer version.) */
  g_listMode = 0; /* Force Metamath mode as startup */

  g_toolsMode = g_listMode;

  if (!g_listMode) {
    /*print2("Metamath - Version %s\n", MVERSION);*/
    print2("Metamath - Version %s%s", MVERSION, space(27 - (long)strlen(MVERSION)));
  }
  print2("Type HELP for help, EXIT to exit.\n");

  /* Allocate big arrays */
  initBigArrays();

  /* Set the default contributor */
  let(&g_contributorName, DEFAULT_CONTRIBUTOR);

  /* Process a command line until EXIT */
  command(argc, argv);

  /* Close logging command file */
  if (g_listMode && g_listFile_fp != NULL) {
    fclose(g_listFile_fp);
  }

  return 0;
}

void command(int argc, char *argv[]) {
  /* Command line user interface -- this is an infinite loop; it fetches and
     processes a command; returns only if the command is 'EXIT' or 'QUIT' and
     never returns otherwise. */
  long argsProcessed = 0;  /* Number of argv initial command-line
                                     arguments processed so far */

  long /*c,*/ i, j, k, m, l, n, p, q, r, s /*,tokenNum*/;
  long stmt;
  int subType = 0;
#define SYNTAX 4
  vstring_def(str1);
  vstring_def(str2);
  vstring_def(str3);
  vstring_def(str4);
  vstring_def(str5);
  nmbrString_def(nmbrTmp);
  nmbrString_def(nmbrSaveProof);
  /*pntrString *pntrTmpPtr;*/ /* Pointer only; not allocated directly */
  pntrString_def(pntrTmp);
  pntrString_def(expandedProof);
  flag tmpFlag;

  /* proofSavedFlag tells us there was at least one
     SAVE NEW_PROOF during the MM-PA session while the UNDO stack wasn't
     empty, meaning that "UNDO stack empty" is no longer a reliable indication
     that the proof wasn't changed.  It is cleared upon entering MM-PA, and
     set by SAVE NEW_PROOF. */
  flag proofSavedFlag = 0;

  /* long startIndent; */
  long endIndent; /* Also for SHOW TRACE_BACK */
  flag essentialFlag; /* Also for SHOW TRACE_BACK */
  flag texFlag; /* Flag for TeX */
  vstring_def(labelMatch); /* SHOW PROOF <label> argument */

  flag axiomFlag; /* For SHOW TRACE_BACK */
  flag treeFlag; /* For SHOW TRACE_BACK */
  flag countStepsFlag; /* For SHOW TRACE_BACK */
  flag matchFlag; /* For SHOW TRACE_BACK */
  vstring_def(matchList);  /* For SHOW TRACE_BACK */
  vstring_def(traceToList); /* For SHOW TRACE_BACK */
  flag recursiveFlag; /* For SHOW USAGE */
  long fromLine, toLine; /* For TYPE, SEARCH */
  flag joinFlag; /* For SEARCH */
  long searchWindow; /* For SEARCH */
  FILE *type_fp; /* For TYPE, SEARCH */
  nmbrString_def(essentialFlags);

  flag texHeaderFlag; /* For OPEN TEX, CLOSE TEX */
  flag commentOnlyFlag; /* For SHOW STATEMENT */
  flag briefFlag; /* For SHOW STATEMENT */
  flag linearFlag; /* For SHOW LABELS */
  vstring_def(bgcolor); /* For SHOW STATEMENT definition list */

  flag showLemmas; /* For WRITE THEOREM_LIST */
  flag noVersioning; /* For WRITE THEOREM_LIST & others */
  long theoremsPerPage; /* For WRITE THEOREM_LIST */

  /* g_toolsMode-specific variables */
  flag commandProcessedFlag = 0; /* Set when the first command line processed;
                                    used to exit shell command line mode */
  FILE *list1_fp;
  FILE *list2_fp;
  FILE *list3_fp;
  vstring_def(list2_fname);
  vstring_def(list2_ftmpname);
  vstring_def(list3_ftmpname);
  vstring_def(oldstr);
  vstring_def(newstr);
  long lines, changedLines, oldChangedLines, twoMatches, p1, p2;
  long firstChangedLine;
  flag cmdMode, changedFlag, outMsgFlag;
  double sum;
  vstring_def(bufferedLine);
  vstring_def(tagStartMatch);  /* For TAG command */
  long tagStartCount = 0;      /* For TAG command */
  vstring_def(tagEndMatch);    /* For TAG command */
  long tagEndCount = 0;        /* For TAG command */
  long tagStartCounter = 0;    /* For TAG command */
  long tagEndCounter = 0;      /* For TAG command */

  double timeTotal = 0;
  double timeIncr = 0;
  flag printTime;  /* Set by "/ TIME" in SAVE PROOF and others */

  flag defaultScrollMode = 1; /* Default to prompted mode */

  /* Initialization to avoid compiler warning (should not be theoretically
     necessary) */
  p = 0;
  q = 0;
  s = 0;
  texHeaderFlag = 0;
  firstChangedLine = 0;
  tagStartCount = 0;           /* For TAG command */
  tagEndCount = 0;             /* For TAG command */
  tagStartCounter = 0;         /* For TAG command */
  tagEndCounter = 0;           /* For TAG command */

  while (1) {

    if (g_listMode) {
      /* If called from the OS shell with arguments, do one command
         then exit program. */
      /* (However, let a SUBMIT job complete) */
      if (argc > 1 && commandProcessedFlag &&
             g_commandFileNestingLevel == 0) return;
    }

    g_errorCount = 0; /* Reset error count before each read or proof parse. */

    /* Deallocate stuff that may have been used in previous pass */
    free_vstring(str1);
    free_vstring(str2);
    free_vstring(str3);
    free_vstring(str4);
    free_vstring(str5);
    free_nmbrString(nmbrTmp);
    free_pntrString(pntrTmp);
    free_nmbrString(nmbrSaveProof);
    free_nmbrString(essentialFlags);
    j = nmbrLen(g_rawArgNmbr);
    if (j != g_rawArgs) bug(1110);
    j = pntrLen(g_rawArgPntr);
    if (j != g_rawArgs) bug(1111);
    g_rawArgs = 0;
    for (i = 0; i < j; i++) let((vstring *)(&g_rawArgPntr[i]), "");
    free_pntrString(g_rawArgPntr);
    free_nmbrString(g_rawArgNmbr);
    j = pntrLen(g_fullArg);
    for (i = 0; i < j; i++) let((vstring *)(&g_fullArg[i]),"");
    free_pntrString(g_fullArg);
    j = pntrLen(expandedProof);
    if (j) {
      for (i = 0; i < j; i++) {
        let((vstring *)(&expandedProof[i]),"");
      }
     free_pntrString(expandedProof);
    }

    free_vstring(list2_fname);
    free_vstring(list2_ftmpname);
    free_vstring(list3_ftmpname);
    free_vstring(oldstr);
    free_vstring(newstr);
    free_vstring(labelMatch);
    /* (End of space deallocation) */

    g_midiFlag = 0; /* Initialize here in case SHOW PROOF exits early */

    if (g_memoryStatus) {
      /*??? Change to user-friendly message */
      print2("Memory:  string %ld xxxString %ld\n",db,db3);
      getPoolStats(&i, &j, &k);
      print2("Pool:  free alloc %ld  used alloc %ld  used actual %ld\n",i,j,k);
    }

    if (!g_toolsMode) {
      if (g_PFASmode) {
        let(&g_commandPrompt,"MM-PA> ");
      } else {
        let(&g_commandPrompt,"MM> ");
      }
    } else {
      if (g_listMode) {
        let(&g_commandPrompt,"Tools> ");
      } else {
        let(&g_commandPrompt,"TOOLS> ");
      }
    }

    free_vstring(g_commandLine); /* Deallocate previous contents */

    if (!commandProcessedFlag && argc > 1 && argsProcessed < argc - 1
        && g_commandFileNestingLevel == 0) {
      if (g_listMode) {
        /* If program was compiled in TOOLS mode, the command-line argument
           is assumed to be a single TOOLS command; build the equivalent
           TOOLS command */
        for (i = 1; i < argc; i++) {
          argsProcessed++;
          /* Put quotes around an argument with spaces or tabs or quotes
             or empty string */
          if (instr(1, argv[i], " ") || instr(1, argv[i], "\t")
              || instr(1, argv[i], "\"") || instr(1, argv[i], "'")
              || (argv[i])[0] == 0) {
            /* If it contains a double quote, use a single quote */
            if (instr(1, argv[i], "\"")) {
              let(&str1, cat("'", argv[i], "'", NULL));
            } else {
              /* (??? (TODO)Case of both ' and " is not handled) */
              let(&str1, cat("\"", argv[i], "\"", NULL));
            }
          } else {
            let(&str1, argv[i]);
          }
          let(&g_commandLine, cat(g_commandLine, (i == 1) ? "" : " ", str1, NULL));
        }
      } else {
        /* If program was compiled in default (Metamath) mode, each command-line
           argument is considered a full Metamath command.  User is responsible
           for ensuring necessary quotes around arguments are passed in. */
        argsProcessed++;
        g_scrollMode = 0; /* Set continuous scrolling until completed */
        let(&g_commandLine, cat(g_commandLine, argv[argsProcessed], NULL));
        if (argc == 2 && instr(1, argv[1], " ") == 0) {
          /* Assume the user intended a READ command.  This special mode allows
             invocation via "metamath xxx.mm". */
          if (instr(1, g_commandLine, "\"") || instr(1, g_commandLine, "'")) {
            /* If it already has quotes don't put quotes */
            let(&g_commandLine, cat("READ ", g_commandLine, NULL));
          } else {
            /* Put quotes so / won't be interpreted as qualifier separator */
            let(&g_commandLine, cat("READ \"", g_commandLine, "\"", NULL));
          }
        }
      }
      print2("%s\n", cat(g_commandPrompt, g_commandLine, NULL));
    } else {
      /* Get command from user input or SUBMIT script file */
      g_commandLine = cmdInput1(g_commandPrompt);
    }
    if (argsProcessed == argc && !commandProcessedFlag) {
      commandProcessedFlag = 1;
      g_scrollMode = defaultScrollMode; /* Set prompted (default) scroll mode */
    }
    if (argsProcessed == argc - 1) {
      argsProcessed++; /* Indicates restore scroll mode next time around */
      if (g_toolsMode) {
        /* If program was compiled in TOOLS mode, we're only going to execute
           one command; set flag to exit next time around */
        commandProcessedFlag = 1;
      }
    }

    /* See if it's an operating system command */
    /* (This is a command line that begins with a quote) */
    if (g_commandLine[0] == '\'' || g_commandLine[0] == '\"') {
      /* See if this computer has this feature */
      if (!system(NULL)) {
        print2("?This computer does not accept an operating system command.\n");
        continue;
      } else {
        /* Strip off quote and trailing quote if any */
        let(&str1, right(g_commandLine, 2));
        if (g_commandLine[0]) { /* (Prevent stray pointer if empty string) */
          if (g_commandLine[0] == g_commandLine[strlen(g_commandLine) - 1]) {
            let(&str1, left(str1, (long)(strlen(str1)) - 1));
          }
        }
        /* Do the operating system command */
        /* The use of (void)!f() is to ignore the value on both
          clang (which takes (void) as an ignore indicator)
          and gcc (which doesn't but is fooled by the ! operator). */
        (void)!system(str1);
        continue;
      }
    }

    parseCommandLine(g_commandLine);
    if (g_rawArgs == 0) {
      continue; /* Empty or comment line */
    }
    if (!processCommandLine()) {
      continue;
    }

    if (g_commandEcho || (g_toolsMode && g_listFile_fp != NULL)) {
      /* Build the complete command and print it for the user */
      k = pntrLen(g_fullArg);
      let(&str1,"");
      for (i = 0; i < k; i++) {
        if (instr(1, g_fullArg[i], " ") || instr(1, g_fullArg[i], "\t")
            || instr(1, g_fullArg[i], "\"") || instr(1, g_fullArg[i], "'")
            || ((char *)(g_fullArg[i]))[0] == 0) {
          /* If the argument has spaces or tabs or quotes
             or is empty string, put quotes around it */
          if (instr(1, g_fullArg[i], "\"")) {
            let(&str1, cat(str1, "'", g_fullArg[i], "' ", NULL));
          } else {
            /* (???Case of both ' and " is not handled) */
            let(&str1, cat(str1, "\"", g_fullArg[i], "\" ", NULL));
          }
        } else {
          let(&str1, cat(str1, g_fullArg[i], " ", NULL));
        }
      }
      let(&str1, left(str1, (long)(strlen(str1)) - 1)); /* Trim trailing space */
      if (g_toolsMode && g_listFile_fp != NULL) {
        /* Put line in list.tmp as command */
        fprintf(g_listFile_fp, "%s\n", str1);  /* Print to list command file */
      }
      if (g_commandEcho) {
        /* Put special character "!" before line for easier extraction to
           build SUBMIT files; see also SET ECHO ON output below */
        let(&str1, cat("!", str1, NULL));
        /* The tilde is a special flag for printLongLine to print a
           tilde before the carriage return in a split line, not after */
        printLongLine(str1, "~", " ");
      }
    }

    if (cmdMatches("BEEP") || cmdMatches("B")) {
      /* Print a bell (if user types ahead "B", the bell lets him know when
         his command is finished - useful for long-running commands */
      print2("%c",7);
      continue;
    }

    if (cmdMatches("HELP")) {
      /* Build the complete command */
      k = pntrLen(g_fullArg);
      let(&str1,"");
      for (i = 0; i < k; i++) {
        let(&str1, cat(str1, g_fullArg[i], " ", NULL));
      }
      let(&str1, left(str1, (long)(strlen(str1)) - 1));
      continue;
    }

    if (cmdMatches("SET SCROLL")) {
      if (cmdMatches("SET SCROLL CONTINUOUS")) {
        defaultScrollMode = 0;
        g_scrollMode = 0;
        print2("Continuous scrolling is now in effect.\n");
      } else {
        defaultScrollMode = 1;
        g_scrollMode = 1;
        print2("Prompted scrolling is now in effect.\n");
      }
      continue;
    }

    if (cmdMatches("EXIT") || cmdMatches("QUIT") || cmdMatches("_EXIT_PA")) {
      /* for MM-PA> exit in scripts, so it will error out in MM> (if for some reason
        MM-PA wasn't entered) instead of exiting metamath */
      if (cmdMatches("_EXIT_PA")) {
        if (!g_PFASmode || (g_toolsMode && !g_listMode)) bug(1127);
                 /* mmcmdl.c should have caught this */
      }

      if (g_toolsMode && !g_listMode) {
        /* Quitting tools command from within Metamath */
        if (!g_PFASmode) {
          print2(
 "Exiting the Text Tools.  Type EXIT again to exit Metamath.\n");
        } else {
          print2(
 "Exiting the Text Tools.  Type EXIT again to exit the Proof Assistant.\n");
        }
        g_toolsMode = 0;
        continue;
      }

      if (g_PFASmode) {

        if (g_proofChanged &&
              /* If g_proofChanged, but the UNDO stack is empty (and
                 there were no other conditions such as stack overflow),
                 the proof didn't really change, so it is safe to
                 exit MM-PA without warning */
              (0
                 /* However, if the proof was saved earlier, UNDO stack
                    empty no longer indicates proof didn't change */
                 || proofSavedFlag)) {
          print2(
              "Warning:  You have not saved changes to the proof of \"%s\".\n",
              g_Statement[g_proveStatement].labelName);
          if (switchPos("FORCE") == 0) {
            str1 = cmdInput1("Do you want to EXIT anyway (Y, N) <N>? ");
            if (str1[0] != 'y' && str1[0] != 'Y') {
              print2("Use SAVE NEW_PROOF to save the proof.\n");
              continue;
            }
          } else {
            /* User specified / FORCE, so answer question automatically */
            print2("Do you want to EXIT anyway (Y, N) <N>? Y\n");
          }
        }

        g_proofChanged = 0;
        proofSavedFlag = 0; /* Will become 1 if proof is ever saved */

        print2("Exiting the Proof Assistant.  Type EXIT again to exit Metamath.\n");

        g_PFASmode = 0;
        continue;
      } else {
        if (g_sourceChanged) {
          print2("Warning:  You have not saved changes to the source.\n");
          if (switchPos("FORCE") == 0) {
            str1 = cmdInput1("Do you want to EXIT anyway (Y, N) <N>? ");
            if (str1[0] != 'y' && str1[0] != 'Y') {
              print2("Use WRITE SOURCE to save the changes.\n");
              continue;
            }
          } else {
            /* User specified / FORCE, so answer question automatically */
            print2("Do you want to EXIT anyway (Y, N) <N>? Y\n");
          }
          g_sourceChanged = 0;
        }

        if (g_texFileOpenFlag) {
          print2("The %s file \"%s\" was closed.\n",
              g_htmlFlag ? "HTML" : "LaTeX", g_texFileName);
          printTexTrailer(texHeaderFlag);
          fclose(g_texFilePtr);
          g_texFileOpenFlag = 0;
        }
        if (g_logFileOpenFlag) {
          print2("The log file \"%s\" was closed %s %s.\n",g_logFileName,
              date(),time_());
          fclose(g_logFilePtr);
          g_logFileOpenFlag = 0;
        }

        /* Free remaining allocations before exiting */
        freeCommandLine();
        freeInOu();
        eraseSource();
        eraseTexDefs();
        freeData(); /* Call AFTER eraseSource()(->initBigArrays->malloc) */
        free_vstring(g_commandPrompt);
        free_vstring(g_commandLine);
        free_vstring(g_input_fn);
        free_vstring(g_contributorName);

        return; /* Exit from program */
      }
    }

    if (cmdMatches("SUBMIT")) {
      if (g_commandFileNestingLevel == MAX_COMMAND_FILE_NESTING) {
        printf("?The SUBMIT nesting level has been exceeded.\n");
        continue;
      }
      g_commandFilePtr[g_commandFileNestingLevel + 1] = fSafeOpen(g_fullArg[1], "r",
          0/*noVersioningFlag*/);
      if (!g_commandFilePtr[g_commandFileNestingLevel + 1]) continue;
                                      /* Couldn't open (err msg was provided) */
      g_commandFileNestingLevel++;
      g_commandFileName[g_commandFileNestingLevel] = ""; /* Initialize if necessary */
      let(&g_commandFileName[g_commandFileNestingLevel], g_fullArg[1]);

      g_commandFileSilent[g_commandFileNestingLevel] = 0;
      if (switchPos("SILENT")
          || g_commandFileSilentFlag /* Propagate silence from outer level */) {
        g_commandFileSilent[g_commandFileNestingLevel] = 1;
      } else {
        g_commandFileSilent[g_commandFileNestingLevel] = 0;
      }
      g_commandFileSilentFlag = g_commandFileSilent[g_commandFileNestingLevel];
      if (!g_commandFileSilentFlag)
        print2("Taking command lines from file \"%s\"...\n",
            g_commandFileName[g_commandFileNestingLevel]);

      continue;
    }

    if (g_toolsMode) {
      /* Start of g_toolsMode-specific commands */
#define ADD_MODE 1
#define DELETE_MODE 2
#define CLEAN_MODE 3
#define SUBSTITUTE_MODE 4
#define SWAP_MODE 5
#define INSERT_MODE 6
#define BREAK_MODE 7
#define BUILD_MODE 8
#define MATCH_MODE 9
#define RIGHT_MODE 10
#define TAG_MODE 11  /* Added TAG command */
      cmdMode = 0;
      if (cmdMatches("ADD")) cmdMode = ADD_MODE;
      else if (cmdMatches("DELETE")) cmdMode = DELETE_MODE;
      else if (cmdMatches("CLEAN")) cmdMode = CLEAN_MODE;
      else if (cmdMatches("SUBSTITUTE") || cmdMatches("S"))
        cmdMode = SUBSTITUTE_MODE;
      else if (cmdMatches("SWAP")) cmdMode = SWAP_MODE;
      else if (cmdMatches("INSERT")) cmdMode = INSERT_MODE;
      else if (cmdMatches("BREAK")) cmdMode = BREAK_MODE;
      else if (cmdMatches("BUILD")) cmdMode = BUILD_MODE;
      else if (cmdMatches("MATCH")) cmdMode = MATCH_MODE;
      else if (cmdMatches("RIGHT")) cmdMode = RIGHT_MODE;
      else if (cmdMatches("TAG")) cmdMode = TAG_MODE;
      if (cmdMode) {
        list1_fp = fSafeOpen(g_fullArg[1], "r", 0/*noVersioningFlag*/);
        if (!list1_fp) continue; /* Couldn't open it (error msg was provided) */
        if (cmdMode == RIGHT_MODE) {
          /* Find the longest line */
          p = 0;
          while (linput(list1_fp, NULL, &str1)) {
            if (p < (signed)(strlen(str1))) p = (long)(strlen(str1));
          }
          rewind(list1_fp);
        }
        let(&list2_fname, g_fullArg[1]);
        if (list2_fname[strlen(list2_fname) - 2] == '~') {
          let(&list2_fname, left(list2_fname, (long)(strlen(list2_fname)) - 2));
          print2("The output file will be called %s.\n", list2_fname);
        }
        free_vstring(list2_ftmpname);
        list2_ftmpname = fGetTmpName("zz~tools");
        list2_fp = fSafeOpen(list2_ftmpname, "w", 0/*noVersioningFlag*/);
        if (!list2_fp) continue; /* Couldn't open it (error msg was provided) */
        lines = 0;
        changedLines = 0;
        twoMatches = 0;
        changedFlag = 0;
        outMsgFlag = 0;
        switch (cmdMode) {
          case ADD_MODE:
            break;
          case TAG_MODE:
            let(&tagStartMatch, g_fullArg[4]);
            tagStartCount = (long)val(g_fullArg[5]);
            if (tagStartCount == 0) tagStartCount = 1; /* Default */
            let(&tagEndMatch, g_fullArg[6]);
            tagEndCount = (long)val(g_fullArg[7]);
            if (tagEndCount == 0) tagEndCount = 1; /* Default */
            tagStartCounter = 0;
            tagEndCounter = 0;
            break;
          case DELETE_MODE:
            break;
          case CLEAN_MODE:
            let(&str4, edit(g_fullArg[2], 32));
            q = 0;
            if (instr(1, str4, "P") > 0) q = q + 1;
            if (instr(1, str4, "D") > 0) q = q + 2;
            if (instr(1, str4, "G") > 0) q = q + 4;
            if (instr(1, str4, "B") > 0) q = q + 8;
            if (instr(1, str4, "R") > 0) q = q + 16;
            if (instr(1, str4, "C") > 0) q = q + 32;
            if (instr(1, str4, "E") > 0) q = q + 128;
            if (instr(1, str4, "Q") > 0) q = q + 256;
            if (instr(1, str4, "L") > 0) q = q + 512;
            if (instr(1, str4, "T") > 0) q = q + 1024;
            if (instr(1, str4, "U") > 0) q = q + 2048;
            if (instr(1, str4, "V") > 0) q = q + 4096;
            break;
          case SUBSTITUTE_MODE:
            let(&newstr, g_fullArg[3]); /* The replacement string */
            if (((vstring)(g_fullArg[4]))[0] == 'A' ||
                ((vstring)(g_fullArg[4]))[0] == 'a') { /* ALL */
              q = -1;
            } else {
              q = (long)val(g_fullArg[4]);
              if (q == 0) q = 1;    /* The occurrence # of string to subst */
            }
            s = instr(1, g_fullArg[2], "\\n");
            if (s) {
              /*s = 1;*/ /* Replace lf flag */
              q = 1; /* Only 1st occurrence makes sense in this mode */
            }
            if (!strcmp(g_fullArg[3], "\\n")) {
              let(&newstr, "\n"); /* Replace with lf */
            }
            break;
          case SWAP_MODE:
            break;
          case INSERT_MODE:
            p = (long)val(g_fullArg[3]);
            break;
          case BREAK_MODE:
            outMsgFlag = 1;
            break;
          case BUILD_MODE:
            free_vstring(str4);
            outMsgFlag = 1;
            break;
          case MATCH_MODE:
            outMsgFlag = 1;
        } /* End switch */
        free_vstring(bufferedLine);
        /*
        while (linput(list1_fp, NULL, &str1)) {
        */
        while (1) {
          if (bufferedLine[0]) {
            /* Get input from buffered line (from rejected \n replacement) */
            let(&str1, bufferedLine);
            free_vstring(bufferedLine);
          } else {
            if (!linput(list1_fp, NULL, &str1)) break;
          }
          lines++;
          oldChangedLines = changedLines;
          let(&str2, str1);
          switch (cmdMode) {
            case ADD_MODE:
              let(&str2, cat(g_fullArg[2], str1, g_fullArg[3], NULL));
              if (strcmp(str1, str2)) changedLines++;
              break;
            case TAG_MODE:
              if (tagStartCounter < tagStartCount) {
                if (instr(1, str1, tagStartMatch)) tagStartCounter++;
              }
              if (tagStartCounter == tagStartCount &&
                  tagEndCounter < tagEndCount) { /* We're in tagging range */
                let(&str2, cat(g_fullArg[2], str1, g_fullArg[3], NULL));
                if (strcmp(str1, str2)) changedLines++;
                if (instr(1, str1, tagEndMatch)) tagEndCounter++;
              }
              break;
            case DELETE_MODE:
              p1 = instr(1, str1, g_fullArg[2]);
              if (strlen(g_fullArg[2]) == 0) p1 = 1;
              p2 = instr(p1, str1, g_fullArg[3]);
              if (strlen(g_fullArg[3]) == 0) p2 = (long)strlen(str1) + 1;
              if (p1 != 0 && p2 != 0) {
                let(&str2, cat(left(str1, p1 - 1), right(str1, p2
                    + (long)strlen(g_fullArg[3])), NULL));
                changedLines++;
              }
              break;
            case CLEAN_MODE:
              if (q) {
                let(&str2, edit(str1, q));
                if (strcmp(str1, str2)) changedLines++;
              }
              break;
            case SUBSTITUTE_MODE:
              let(&str2, str1);
              p = 0;
              p1 = 0;

              k = 1;
              /* See if an additional match on line is required */
              if (((vstring)(g_fullArg[5]))[0] != 0) {
                if (!instr(1, str2, g_fullArg[5])) {
                  /* No match on line; prevent any substitution */
                  k = 0;
                }
              }

              if (s && k) { /* We're asked to replace a newline char */
                /* Read in the next line */
                /*
                if (linput(list1_fp, NULL, &str4)) {
                  let(&str2, cat(str1, "\\n", str4, NULL));
                */
                if (linput(list1_fp, NULL, &bufferedLine)) {
                  /* Join the next line and see if the string matches */
                  if (instr(1, cat(str1, "\\n", bufferedLine, NULL),
                      g_fullArg[2])) {
                    let(&str2, cat(str1, "\\n", bufferedLine, NULL));
                    free_vstring(bufferedLine);
                  } else {
                    k = 0; /* No match - leave bufferedLine for next pass */
                  }
                } else { /* EOF reached */
                  print2("Warning: file %s has an odd number of lines\n",
                      g_fullArg[1]);
                }
              }

              while (k) {
                p1 = instr(p1 + 1, str2, g_fullArg[2]);
                if (!p1) break;
                p++;
                if (p == q || q == -1) {
                  let(&str2, cat(left(str2, p1 - 1), newstr,
                      right(str2, p1 + (long)strlen(g_fullArg[2])), NULL));
                  if (newstr[0] == '\n') {
                    /* Replacement string is an lf */
                    lines++;
                    changedLines++;
                  }
                  /* Continue the search after the replacement
                     string, so that "SUBST 1.tmp abbb ab a ''" will change
                     "abbbab" to "abba" rather than "aa" */
                  p1 = p1 + (long)strlen(newstr) - 1;
                  /* p1 = p1 - (long)strlen(g_fullArg[2]) + (long)strlen(newstr); */ /* bad */
                  if (q != -1) break;
                }
              }
              if (strcmp(str1, str2)) changedLines++;
              break;
            case SWAP_MODE:
              p1 = instr(1, str1, g_fullArg[2]);
              if (p1) {
                p2 = instr(p1 + 1, str1, g_fullArg[2]);
                if (p2) twoMatches++;
                let(&str2, cat(right(str1, p1) + (long)strlen(g_fullArg[2]),
                    g_fullArg[2], left(str1, p1 - 1), NULL));
                if (strcmp(str1, str2)) changedLines++;
              }
              break;
            case INSERT_MODE:
              if ((signed)(strlen(str2)) < p - 1)
                let(&str2, cat(str2, space(p - 1 - (long)strlen(str2)), NULL));
              let(&str2, cat(left(str2, p - 1), g_fullArg[2],
                  right(str2, p), NULL));
              if (strcmp(str1, str2)) changedLines++;
              break;
            case BREAK_MODE:
              let(&str2, str1);
              changedLines++;
              for (i = 0; i < (signed)(strlen(g_fullArg[2])); i++) {
                p = 0;
                while (1) {
                  p = instr(p + 1, str2, chr(((vstring)(g_fullArg[2]))[i]));
                  if (!p) break;
                  /* Put spaces around special one-char tokens */
                  let(&str2, cat(left(str2, p - 1), " ",
                      mid(str2, p, 1),
                      " ", right(str2, p + 1), NULL));
                  /*p++;*/
                  /* Even though space is always a separator, it can be used
                     to suppress all default tokens.  Go past 2nd space to prevent
                     infinite loop in that case. */
                  p += 2;
                }
              }
              let(&str2, edit(str2, 8 + 16 + 128)); /* Reduce & trim spaces */
              for (p = (long)strlen(str2) - 1; p >= 0; p--) {
                if (str2[p] == ' ') {
                  str2[p] = '\n';
                  changedLines++;
                }
              }
              if (!str2[0]) changedLines--; /* Don't output blank line */
              break;
            case BUILD_MODE:
              if (str2[0] != 0) { /* Ignore blank lines */
                if (str4[0] == 0) {
                  let(&str4, str2);
                } else {
                  if ((long)strlen(str4) + (long)strlen(str2) > 72) {
                    let(&str4, cat(str4, "\n", str2, NULL));
                    changedLines++;
                  } else {
                    let(&str4, cat(str4, " ", str2, NULL));
                  }
                }
                p = instr(1, str4, "\n");
                if (p) {
                  let(&str2, left(str4, p - 1));
                  let(&str4, right(str4, p + 1));
                } else {
                  let(&str2, "");
                }
              }
              break;
            case MATCH_MODE:
              if (((vstring)(g_fullArg[2]))[0] == 0) {
                /* Match any non-blank line */
                p = str1[0];
              } else {
                p = instr(1, str1, g_fullArg[2]);
              }
              if (((vstring)(g_fullArg[3]))[0] == 'n' ||
                  ((vstring)(g_fullArg[3]))[0] == 'N') {
                p = !p;
              }
              if (p) changedLines++;
              break;
            case RIGHT_MODE:
              let(&str2, cat(space(p - (long)strlen(str2)), str2, NULL));
              if (strcmp(str1, str2)) changedLines++;
              break;
          } /* End switch(cmdMode) */
          if (lines == 1) let(&str3, left(str2, 79)); /* For msg */
          if (oldChangedLines != changedLines && !changedFlag) {
            changedFlag = 1;
            let(&str3, left(str2, 79)); /* For msg */
            firstChangedLine = lines;
            if ((cmdMode == SUBSTITUTE_MODE && newstr[0] == '\n')
                || cmdMode == BUILD_MODE) /* Joining lines */ {
              firstChangedLine = 1; /* Better message */
            }
          }
          if (((cmdMode != BUILD_MODE && cmdMode != BREAK_MODE)
              || str2[0] != 0)
              && (cmdMode != MATCH_MODE || p))
            fprintf(list2_fp, "%s\n", str2);
        } /* Next input line */
        if (cmdMode == BUILD_MODE) {
          if (str4[0]) {
            /* Output last partial line */
            fprintf(list2_fp, "%s\n", str4);
            changedLines++;
            if (!str3[0]) {
              let(&str3, str4); /* For msg */
            }
          }
        }
        /* Remove any lines after lf for readability of msg */
        p = instr(1, str3, "\n");
        if (p) let(&str3, left(str3, p - 1));
        if (!outMsgFlag) {
          /* Make message depend on line counts */
          if (!changedFlag) {
            if (!lines) {
              print2("The file %s has no lines.\n", g_fullArg[1]);
            } else {
              print2(
"The file %s has %ld line%s; none were changed.  First line:\n",
                list2_fname, lines, (lines == 1) ? "" : "s");
              print2("%s\n", str3);
            }
          } else {
            print2(
"The file %s has %ld line%s; %ld w%s changed.  First changed line is %ld:\n",
                list2_fname,
                lines,  (lines == 1) ? "" : "s",
                changedLines,  (changedLines == 1) ? "as" : "ere",
                firstChangedLine);
            print2("%s\n", str3);
          }
          if (twoMatches > 0) {
            /* For SWAP command */
            print2(
"Warning:  %ld line%s more than one \"%s\".  The first one was used.\n",
                twoMatches, (twoMatches == 1) ? " has" : "s have", g_fullArg[2]);
          }
        } else {
          /* if (changedLines == 0) let(&str3, ""); */
          print2(
"The input had %ld line%s, the output has %ld line%s.%s\n",
              lines, (lines == 1) ? "" : "s",
              changedLines, (changedLines == 1) ? "" : "s",
              (changedLines == 0) ? "" : " First output line:");
          if (changedLines != 0) print2("%s\n", str3);
        }
        fclose(list1_fp);
        fclose(list2_fp);
        fSafeRename(list2_ftmpname, list2_fname);
        /* Deallocate string memory */
        free_vstring(tagStartMatch);
        free_vstring(tagEndMatch);
        continue;
      } /* end if cmdMode for ADD, etc. */

#define SORT_MODE 1
#define UNDUPLICATE_MODE 2
#define DUPLICATE_MODE 3
#define UNIQUE_MODE 4
#define REVERSE_MODE 5
      cmdMode = 0;
      if (cmdMatches("SORT")) cmdMode = SORT_MODE;
      else if (cmdMatches("UNDUPLICATE")) cmdMode = UNDUPLICATE_MODE;
      else if (cmdMatches("DUPLICATE")) cmdMode = DUPLICATE_MODE;
      else if (cmdMatches("UNIQUE")) cmdMode = UNIQUE_MODE;
      else if (cmdMatches("REVERSE")) cmdMode = REVERSE_MODE;
      if (cmdMode) {
        list1_fp = fSafeOpen(g_fullArg[1], "r", 0/*noVersioningFlag*/);
        if (!list1_fp) continue; /* Couldn't open it (error msg was provided) */
        let(&list2_fname, g_fullArg[1]);
        if (list2_fname[strlen(list2_fname) - 2] == '~') {
          let(&list2_fname, left(list2_fname, (long)strlen(list2_fname) - 2));
          print2("The output file will be called %s.\n", list2_fname);
        }
        free_vstring(list2_ftmpname);
        list2_ftmpname = fGetTmpName("zz~tools");
        list2_fp = fSafeOpen(list2_ftmpname, "w", 0/*noVersioningFlag*/);
        if (!list2_fp) continue; /* Couldn't open it (error msg was provided) */

        /* Count the lines */
        lines = 0;
        while (linput(list1_fp, NULL, &str1)) lines++;
        if (cmdMode != SORT_MODE  && cmdMode != REVERSE_MODE) {
          print2("The input file has %ld lines.\n", lines);
        }

        /* Close and reopen the input file */
        fclose(list1_fp);
        list1_fp = fSafeOpen(g_fullArg[1], "r", 0/*noVersioningFlag*/);
        /* Allocate memory */
        pntrLet(&pntrTmp, pntrSpace(lines));
        /* Assign the lines to string array */
        for (i = 0; i < lines; i++) linput(list1_fp, NULL,
            (vstring *)(&pntrTmp[i]));

        /* Sort */
        if (cmdMode != REVERSE_MODE) {
          if (cmdMode == SORT_MODE) {
            g_qsortKey = g_fullArg[2]; /* Do not deallocate! */
          } else {
            g_qsortKey = "";
          }
          qsort(pntrTmp, (size_t)lines, sizeof(void *), qsortStringCmp);
        } else { /* Reverse the lines */
          for (i = lines / 2; i < lines; i++) {
            g_qsortKey = pntrTmp[i]; /* Use g_qsortKey as handy tmp var here */
            pntrTmp[i] = pntrTmp[lines - 1 - i];
            pntrTmp[lines - 1 - i] = g_qsortKey;
          }
        }

        /* Output sorted lines */
        changedLines = 0;
        let(&str3, "");
        for (i = 0; i < lines; i++) {
          j = 0; /* Flag that line should be printed */
          switch (cmdMode) {
            case SORT_MODE:
            case REVERSE_MODE:
              j = 1;
              break;
            case UNDUPLICATE_MODE:
              if (i == 0) {
                j = 1;
              } else {
                if (strcmp((vstring)(pntrTmp[i - 1]), (vstring)(pntrTmp[i]))) {
                  j = 1;
                }
              }
              break;
            case DUPLICATE_MODE:
              if (i > 0) {
                if (!strcmp((vstring)(pntrTmp[i - 1]), (vstring)(pntrTmp[i]))) {
                  if (i == lines - 1) {
                    j = 1;
                  } else {
                    if (strcmp((vstring)(pntrTmp[i]),
                        (vstring)(pntrTmp[i + 1]))) {
                      j = 1;
                    }
                  }
                }
              }
              break;
            case UNIQUE_MODE:
              if (i < lines - 1) {
                if (strcmp((vstring)(pntrTmp[i]), (vstring)(pntrTmp[i + 1]))) {
                  if (i == 0) {
                    j = 1;
                  } else {
                    if (strcmp((vstring)(pntrTmp[i - 1]),
                        (vstring)(pntrTmp[i]))) {
                      j = 1;
                    }
                  }
                }
              } else {
                if (i == 0) {
                  j = 1;
                } else {
                  if (strcmp((vstring)(pntrTmp[i - 1]),
                        (vstring)(pntrTmp[i]))) {
                      j = 1;
                  }
                }
              }
              break;
          } /* end switch (cmdMode) */
          if (j) {
            fprintf(list2_fp, "%s\n", (vstring)(pntrTmp[i]));
            changedLines++;
            if (changedLines == 1)
              let(&str3, left((vstring)(pntrTmp[i]), 79));
          }
        } /* next i */
        print2("The output file has %ld lines.  The first line is:\n",
            changedLines);
        print2("%s\n", str3);

        /* Deallocate memory */
        for (i = 0; i < lines; i++) let((vstring *)(&pntrTmp[i]), "");
        free_pntrString(pntrTmp);

        fclose(list1_fp);
        fclose(list2_fp);
        fSafeRename(list2_ftmpname, list2_fname);
        continue;
      } /* end if cmdMode for SORT, etc. */

      if (cmdMatches("PARALLEL")) {
        list1_fp = fSafeOpen(g_fullArg[1], "r", 0/*noVersioningFlag*/);
        list2_fp = fSafeOpen(g_fullArg[2], "r", 0/*noVersioningFlag*/);
        if (!list1_fp) continue; /* Couldn't open it (error msg was provided) */
        if (!list2_fp) continue; /* Couldn't open it (error msg was provided) */
        free_vstring(list3_ftmpname);
        list3_ftmpname = fGetTmpName("zz~tools");
        list3_fp = fSafeOpen(list3_ftmpname, "w", 0/*noVersioningFlag*/);
        if (!list3_fp) continue; /* Couldn't open it (error msg was provided) */

        p1 = 1; p2 = 1; /* not eof */
        p = 0; q = 0; /* lines */
        j = 0; /* 1st line flag */
        let(&str3, "");
        while (1) {
          free_vstring(str1);
          if (p1) {
            p1 = linput(list1_fp, NULL, &str1);
            if (p1) p++;
            else let(&str1, "");
          }
          free_vstring(str2);
          if (p2) {
            p2 = linput(list2_fp, NULL, &str2);
            if (p2) q++;
            else let(&str2, "");
          }
          if (!p1 && !p2) break;
          let(&str4, cat(str1, g_fullArg[4], str2, NULL));
          fprintf(list3_fp, "%s\n", str4);
          if (!j) {
            let(&str3, str4); /* Save 1st line for msg */
            j = 1;
          }
        }
        if (p == q) {
          print2(
"The input files each had %ld lines.  The first output line is:\n", p);
        } else {
          print2(
"Warning: file \"%s\" had %ld lines while file \"%s\" had %ld lines.\n",
              g_fullArg[1], p, g_fullArg[2], q);
          if (p < q) p = q;
          print2("The output file \"%s\" has %ld lines.  The first line is:\n",
              g_fullArg[3], p);
        }
        print2("%s\n", str3);

        fclose(list1_fp);
        fclose(list2_fp);
        fclose(list3_fp);
        fSafeRename(list3_ftmpname, g_fullArg[3]);
        continue;
      }

      if (cmdMatches("NUMBER")) {
        list1_fp = fSafeOpen(g_fullArg[1], "w", 0/*noVersioningFlag*/);
        if (!list1_fp) continue; /* Couldn't open it (error msg was provided) */
        j = (long)strlen(str(val(g_fullArg[2])));
        k = (long)strlen(str(val(g_fullArg[3])));
        if (k > j) j = k;
        for (i = (long)val(g_fullArg[2]); i <= val(g_fullArg[3]);
            i = i + (long)val(g_fullArg[4])) {
          let(&str1, str((double)i));
          fprintf(list1_fp, "%s\n", str1);
        }
        fclose(list1_fp);
        continue;
      }

      if (cmdMatches("COUNT")) {
        list1_fp = fSafeOpen(g_fullArg[1], "r", 0/*noVersioningFlag*/);
        if (!list1_fp) continue; /* Couldn't open it (error msg was provided) */
        p1 = 0;
        p2 = 0;
        lines = 0;
        q = 0; /* Longest line length */
        i = 0; /* First longest line */
        j = 0; /* Number of longest lines */
        sum = 0.0; /* Sum of numeric content of lines */
        firstChangedLine = 0;
        while (linput(list1_fp, NULL, &str1)) {
          lines++;

          /* Longest line */
          if (q < (signed)(strlen(str1))) {
            q = (long)strlen(str1);
            let(&str4, str1);
            i = lines;
            j = 0;
          }

          if (q == (signed)(strlen(str1))) {
            j++;
          }

          if (instr(1, str1, g_fullArg[2])) {
            if (!firstChangedLine) {
              firstChangedLine = lines;
              let(&str3, str1);
            }
            p1++;
            p = 0;
            while (1) {
              p = instr(p + 1, str1, g_fullArg[2]);
              if (!p) break;
              p2++;
            }
          }
          sum = sum + val(str1);
        }
        print2(
"The file has %ld lines.  The string \"%s\" occurs %ld times on %ld lines.\n",
            lines, g_fullArg[2], p2, p1);
        if (firstChangedLine) {
          print2("The first occurrence is on line %ld:\n", firstChangedLine);
          print2("%s\n", str3);
        }
        print2(
"The first longest line (out of %ld) is line %ld and has %ld characters:\n",
            j, i, q);
        printLongLine(str4, "    "/*startNextLine*/, ""/*breakMatch*/);
            /* breakMatch empty means break line anywhere */
        printLongLine(cat(
            "Stripping all but digits, \".\", and \"-\", the sum of lines is ",
            str((double)sum), NULL), "    ", " ");
        fclose(list1_fp);
        continue;
      }

      if (cmdMatches("TYPE") || cmdMatches("T")) {
        list1_fp = fSafeOpen(g_fullArg[1], "r", 0/*noVersioningFlag*/);
        if (!list1_fp) continue; /* Couldn't open it (error msg was provided) */
        if (g_rawArgs == 2) {
          n = 10;
        } else {
          if (((vstring)(g_fullArg[2]))[0] == 'A' ||
              ((vstring)(g_fullArg[2]))[0] == 'a') { /* ALL */
            n = -1;
          } else {
            n = (long)val(g_fullArg[2]);
          }
        }
        for (i = 0; i < n || n == -1; i++) {
          if (!linput(list1_fp, NULL, &str1)) break;
          if (!print2("%s\n", str1)) break;
        }
        fclose(list1_fp);
        continue;
      } /* end TYPE */

      if (cmdMatches("COPY") || cmdMatches("C")) {
        free_vstring(list2_ftmpname);
        list2_ftmpname = fGetTmpName("zz~tools");
        list2_fp = fSafeOpen(list2_ftmpname, "w", 0/*noVersioningFlag*/);
        if (!list2_fp) continue; /* Couldn't open it (error msg was provided) */
        let(&str4, cat(g_fullArg[1], ",", NULL));
        lines = 0;
        j = 0; /* Error flag */
        while (1) {
          if (!str4[0]) break; /* Done scanning list */
          p = instr(1, str4, ",");
          let(&str3, left(str4, p - 1));
          let(&str4, right(str4, p + 1));
          list1_fp = fSafeOpen((str3), "r", 0/*noVersioningFlag*/);
          if (!list1_fp) { /* Couldn't open it (error msg was provided) */
            j = 1; /* Error flag */
            break;
          }
          n = 0;
          while (linput(list1_fp, NULL, &str1)) {
            lines++; n++;
            fprintf(list2_fp, "%s\n", str1);
          }
          if (instr(1, g_fullArg[1], ",")) { /* More than 1 input file */
            print2("The input file \"%s\" has %ld lines.\n", str3, n);
          }
          fclose(list1_fp);
        }
        if (j) continue; /* One of the input files couldn't be opened */
        fclose(list2_fp);
        print2("The output file \"%s\" has %ld lines.\n", g_fullArg[2], lines);
        fSafeRename(list2_ftmpname, g_fullArg[2]);
        continue;
      }

      print2("?This command has not been implemented yet.\n");
      continue;
    } /* End of g_toolsMode-specific commands */

    if (cmdMatches("TOOLS")) {
      print2(
"Entering the Text Tools utilities.  Type HELP for help, EXIT to exit.\n");
      g_toolsMode = 1;
      continue;
    }

    if (cmdMatches("READ")) {
      /* We can't use 'statements > 0' for the test since the source
         could be just a comment */
      if (g_sourceHasBeenRead == 1) {
        printLongLine(cat(
            "?Sorry, reading of more than one source file is not allowed.  ",
            "The file \"", g_input_fn, "\" has already been READ in.  ",
            "You may type ERASE to start over.  Note that additional source ",
            "files may be included in the source file with \"$[ <filename> $]\".",
            NULL),"  "," ");
        continue;
      }

      let(&g_input_fn, g_fullArg[1]);

      let(&str1, cat(g_rootDirectory, g_input_fn, NULL));
      g_input_fp = fSafeOpen(str1, "r", 0/*noVersioningFlag*/);
      if (!g_input_fp) continue; /* Couldn't open it (error msg was provided
                                     by fSafeOpen) */
      fclose(g_input_fp);

      readInput();

      if (switchPos("VERIFY")) {
        verifyProofs("*",1); /* Parse and verify */
      } else {
        /* verifyProofs("*",0); */ /* Parse only (for gross error checking) */
      }

      if (g_sourceHasBeenRead == 1) {
        if (!g_errorCount) {
          let(&str1, "No errors were found.");
          if (!switchPos("VERIFY")) {
              let(&str1, cat(str1,
         "  However, proofs were not checked.  Type VERIFY PROOF *",
         " if you want to check them.",
              NULL));
          }
          printLongLine(str1, "", " ");
        } else {
          print2("\n");
          if (g_errorCount == 1) {
            print2("One error was found.\n");
          } else {
            print2("%ld errors were found.\n", (long)g_errorCount);
          }
        }
      } /* g_sourceHasBeenRead == 1 */

      continue;
    }

    if (cmdMatches("WRITE SOURCE")) {
      let(&g_output_fn, g_fullArg[2]);

      if (switchPos("REWRAP") > 0) {
        r = 2; /* Re-wrap then format (more aggressive than / FORMAT) */
      } else if (switchPos("FORMAT") > 0) {
        r = 1; /* Format output according to set.mm standard */
      } else {
        r = 0; /* Keep formatting as-is */
      }

      i = switchPos("EXTRACT");
      if (i > 0) {
        let(&str1, g_fullArg[i + 1]); /* List of labels */
        if (r > 0
            || switchPos("SPLIT") > 0
            || switchPos("KEEP_INCLUDES") > 0) {
          print2(
"?You may not use / SPLIT, / REWRAP, or / KEEP_INCLUDES with / EXTRACT.\n");
          continue;
        }
      } else {
        let(&str1, ""); /* Empty string means full db */
      }

      writeSource((char)r, /* Rewrap type */
        ((switchPos("SPLIT") > 0) ? 1 : 0),
        ((switchPos("NO_VERSIONING") > 0) ? 1 : 0),
        ((switchPos("KEEP_INCLUDES") > 0) ? 1 : 0),
        str1 /* Label list to extract */
          );
      g_sourceChanged = 0;

      free_vstring(str1); /* Deallocate */
      continue;
    } /* End of WRITE SOURCE */

    if (cmdMatches("WRITE THEOREM_LIST")) {
      /* Write out an HTML summary of the theorems to
         mmtheorems.html, mmtheorems1.html,... */
      /* THEOREMS_PER_PAGE is the default number of proof descriptions to output. */
#define THEOREMS_PER_PAGE 100
      /* theoremsPerPage is the actual number of proof descriptions to output. */
      /* See if the user overrode the default. */
      i = switchPos("THEOREMS_PER_PAGE");
      if (i != 0) {
        theoremsPerPage = (long)val(g_fullArg[i + 1]); /* Use user's value */
      } else {
        theoremsPerPage = THEOREMS_PER_PAGE; /* Use the default value */
      }
      showLemmas = (switchPos("SHOW_LEMMAS") != 0);
      noVersioning = (switchPos("NO_VERSIONING") != 0);

      g_htmlFlag = 1;
      /* If not specified, for backwards compatibility in scripts
         leave g_altHtmlFlag at current value */
      if (switchPos("HTML") != 0) {
        if (switchPos("ALT_HTML") != 0) {
          print2("?Please specify only one of / HTML and / ALT_HTML.\n");
          continue;
        }
        g_altHtmlFlag = 0;
      } else {
        if (switchPos("ALT_HTML") != 0) g_altHtmlFlag = 1;
      }

      if (2/*error*/ == readTexDefs(0 /* 1 = check errors only */,
          1 /* 1 = GIF file existence check */ )) {
        continue; /* An error occurred */
      }

      /* Output the theorem list */
      writeTheoremList(theoremsPerPage, showLemmas, noVersioning);
      continue;
    }  /* End of "WRITE THEOREM_LIST" */

    if (cmdMatches("WRITE BIBLIOGRAPHY")) {
      /* This command builds the bibliographical cross-references to various
         textbooks and updates the user-specified file normally called
         mmbiblio.html. */

      writeBibliography(g_fullArg[2],
          "*", /* labelMatch - all labels */
          0,  /* 1 = no output, just warning msgs if any */
          1); /* 1 = check external files (gifs and bib) */
      continue;
    }  /* End of "WRITE BIBLIOGRAPHY" */

    if (cmdMatches("WRITE RECENT_ADDITIONS")) {
      /* This utility creates a list of recent proof descriptions and updates
         the user-specified file normally called mmrecent.html.
       */

      /* RECENT_COUNT is the default number of proof descriptions to output. */
#define RECENT_COUNT 100
      /* i is the actual number of proof descriptions to output. */
      /* See if the user overrode the default. */
      i = switchPos("LIMIT");
      if (i) {
        i = (long)val(g_fullArg[i + 1]); /* Use user's value */
      } else {
        i = RECENT_COUNT; /* Use the default value */
      }

      g_htmlFlag = 1;
      /* If not specified, for backwards compatibility in scripts
         leave g_altHtmlFlag at current value */
      if (switchPos("HTML") != 0) {
        if (switchPos("ALT_HTML") != 0) {
          print2("?Please specify only one of / HTML and / ALT_HTML.\n");
          continue;
        }
        g_altHtmlFlag = 0;
      } else {
        if (switchPos("ALT_HTML") != 0) g_altHtmlFlag = 1;
      }

      /* readTexDefs() rereads based on changed in g_htmlFlag, g_altHtmlFlag */
      if (2/*error*/ == readTexDefs(0 /* 1 = check errors only */,
          1 /* 1 = GIF file existence check */  )) {
        continue; /* An error occurred */
      }

      tmpFlag = 0; /* Error flag to recover input file */
      list1_fp = fSafeOpen(g_fullArg[2], "r", 0/*noVersioningFlag*/);
      if (list1_fp == NULL) {
        /* Couldn't open it (error msg was provided)*/
        continue;
      }
      fclose(list1_fp);
      /* This will rename the input mmrecent.html as mmrecent.html~1 */
      list2_fp = fSafeOpen(g_fullArg[2], "w", 0/*noVersioningFlag*/);
      if (list2_fp == NULL) {
          /* Couldn't open it (error msg was provided)*/
        continue;
      }
      /* Note: in older versions the "~1" string was OS-dependent, but we
         do not support VAX or THINK C anymore...  Anyway we reopen it
         here with the renamed file in case the OS won't let us rename
         an opened file during the fSafeOpen for write above. */
      list1_fp = fSafeOpen(cat(g_fullArg[2], "~1", NULL), "r",
          0/*noVersioningFlag*/);
      if (list1_fp == NULL) bug(1117);

      /* Transfer the input file up to the special "<!-- #START# -->" comment */
      while (1) {
        if (!linput(list1_fp, NULL, &str1)) {
          print2(
"?Error: Could not find \"<!-- #START# -->\" line in input file \"%s\".\n",
              g_fullArg[2]);
          tmpFlag = 1; /* Error flag to recover input file */
          break;
        }
        if (!strcmp(left(str1, 21), "<!-- last updated -->")) {
          let(&str1, cat(left(str1, 21), " <I>Last updated on ", date(),
          /* ??Future: use timezones properly */
          /* Just make it "ET" for "Eastern Time" */
            " at ", time_(), " ET.</I>", NULL));
        }
        fprintf(list2_fp, "%s\n", str1);
        if (!strcmp(str1, "<!-- #START# -->")) break;
      }
      if (tmpFlag) goto wrrecent_error;

      /* Get and parse today's date */
      parseDate(date(), &k /*dd*/, &l /*mmm*/, &m /*yyyy*/);

#define START_YEAR 93 /* Earliest 19xx year in set.mm database */
      n = 0; /* Count of how many output so far */
      while (n < i /*RECENT_COUNT*/ && m > START_YEAR + 1900 - 1) {

        /* Build date string to match */
        buildDate(k, l, m, &str1);

        for (stmt = g_statements; stmt >= 1; stmt--) {

          if (g_Statement[stmt].type != (char)p_
                && g_Statement[stmt].type != (char)a_) {
            continue;
          }

          free_vstring(str2);
          str2 = getContrib(stmt, MOST_RECENT_DATE);

          /* See if the date comment matches */
          if (!strcmp(str2, str1)) {
            /* We have a match, so increment the match count */
            n++;
            free_vstring(str3);
            str3 = getDescription(stmt);
            free_vstring(str4);
            str4 = pinkHTML(stmt); /* Get little pink number */
            /* Output the description comment */
            /* Break up long lines for text editors with printLongLine */
            free_vstring(g_printString);
            g_outputToString = 1;
            print2("\n"); /* Blank line for HTML human readability */
            printLongLine(cat(
                /*
                (stmt < g_extHtmlStmt) ?
                     "<TR>" :
                     cat("<TR BGCOLOR=", PURPLISH_BIBLIO_COLOR, ">", NULL),
                */

                (stmt < g_extHtmlStmt)
                   ? "<TR>"
                   : (stmt < g_mathboxStmt)
                       ? cat("<TR BGCOLOR=", PURPLISH_BIBLIO_COLOR, ">",
                           NULL)
                       : cat("<TR BGCOLOR=", SANDBOX_COLOR, ">", NULL),

                "<TD NOWRAP>",  /* IE breaks up the date */
                str2, /* Date */
                "</TD><TD ALIGN=CENTER><A HREF=\"",
                g_Statement[stmt].labelName, ".html\">",
                g_Statement[stmt].labelName, "</A>",
                str4, "</TD><TD ALIGN=LEFT>", NULL),  /* Description */
              " ",  /* Start continuation line with space */
              "\""); /* Don't break inside quotes e.g. "Arial Narrow" */

            g_showStatement = stmt; /* For printTexComment */
            g_outputToString = 0; /* For printTexComment */
            g_texFilePtr = list2_fp;
            printTexComment(str3,              /* Sends result to g_texFilePtr */
                0, /* 1 = htmlCenterFlag */
                PROCESS_EVERYTHING, /* actionBits */
                1  /* 1 = fileCheck */ );
            g_texFilePtr = NULL;
            g_outputToString = 1; /* Restore after printTexComment */

            /* Get HTML hypotheses => assertion */
            free_vstring(str4);
            str4 = getTexOrHtmlHypAndAssertion(stmt);
            printLongLine(cat("</TD></TR><TR",

                  /*
                  (s < g_extHtmlStmt) ?
                       ">" :
                       cat(" BGCOLOR=", PURPLISH_BIBLIO_COLOR, ">", NULL),
                  */

                  (stmt < g_extHtmlStmt)
                     ? ">"
                     : (stmt < g_mathboxStmt)
                         ? cat(" BGCOLOR=", PURPLISH_BIBLIO_COLOR, ">",
                             NULL)
                         : cat(" BGCOLOR=", SANDBOX_COLOR, ">", NULL),

                "<TD COLSPAN=3 ALIGN=CENTER>",
                str4, "</TD></TR>", NULL),

                " ",  /* Start continuation line with space */
                "\""); /* Don't break inside quotes e.g. "Arial Narrow" */

            g_outputToString = 0;
            fprintf(list2_fp, "%s", g_printString);
            free_vstring(g_printString);

            if (n >= i /*RECENT_COUNT*/) break; /* We're done */

            /* Put separator row if not last theorem */
            g_outputToString = 1;
            printLongLine(cat("<TR BGCOLOR=white><TD COLSPAN=3>",
                "<FONT SIZE=-3>&nbsp;</FONT></TD></TR>", NULL),
                " ",  /* Start continuation line with space */
                "\""); /* Don't break inside quotes e.g. "Arial Narrow" */

            /* Put the previous, current, and next statement
               labels in HTML comments so a script can use them to update
               web site incrementally.  This would be done by searching
               for "For script" and gather label between = and --> then
               regenerate just those statements.  Previous and next labels
               are included to prevent dead links if they don't exist yet. */
            /* This section can be deleted without side effects */
            /* Find the previous statement with a web page */
            j = 0;
            for (q = stmt - 1; q >= 1; q--) {
              if (g_Statement[q].type == (char)p_ ||
                  g_Statement[q].type == (char)a_ ) {
                j = q;
                break;
              }
            }
            /* 13-Dec-2018 nm This isn't used anywhere yet.  But fix error
               in current label and also identify previous, current, next */
            if (j) print2("<!-- For script: previous = %s -->\n",
                g_Statement[j].labelName);
            /* Current statement */
            print2("<!-- For script: current = %s -->\n",
                g_Statement[stmt].labelName);
            /* Find the next statement with a web page */
            j = 0;
            for (q = stmt + 1; q <= g_statements; q++) {
              if (g_Statement[q].type == (char)p_ ||
                  g_Statement[q].type == (char)a_ ) {
                j = q;
                break;
              }
            }
            if (j) print2("<!-- For script: next = %s -->\n",
                g_Statement[j].labelName);

            g_outputToString = 0;
            fprintf(list2_fp, "%s", g_printString);
            free_vstring(g_printString);
          }
        } /* Next stmt - statement number */
        /* Decrement date */
        if (k > 1) {
          k--; /* Decrement day */
        } else {
          k = 31; /* Non-existent day 31's will never match, which is OK */
          if (l > 1) {
            l--; /* Decrement month */
          } else {
            l = 12; /* Dec */
            m --; /* Decrement year */
          }
        }
      } /* next while - Scan next date */

      /* Discard the input file up to the special "<!-- #END# -->" comment */
      while (1) {
        if (!linput(list1_fp, NULL, &str1)) {
          print2(
"?Error: Could not find \"<!-- #END# -->\" line in input file \"%s\".\n",
              g_fullArg[2]);
          tmpFlag = 1; /* Error flag to recover input file */
          break;
        }
        if (!strcmp(str1, "<!-- #END# -->")) {
          fprintf(list2_fp, "%s\n", str1);
          break;
        }
      }
      if (tmpFlag) goto wrrecent_error;

      /* Transfer the rest of the input file */
      while (1) {
        if (!linput(list1_fp, NULL, &str1)) {
          break;
        }

        /* Update the date stamp at the bottom of the HTML page. */
        /* This is just a nicety; no error check is done. */
        if (!strcmp("This page was last updated on ", left(str1, 30))) {
          let(&str1, cat(left(str1, 30), date(), ".", NULL));
        }

        fprintf(list2_fp, "%s\n", str1);
      }

      print2("The %ld most recent theorem(s) were written.\n", n);

     wrrecent_error:
      fclose(list1_fp);
      fclose(list2_fp);
      if (tmpFlag) {
        /* Recover input files in case of error */
        remove(g_fullArg[2]);  /* Delete output file */
        rename(cat(g_fullArg[2], "~1", NULL), g_fullArg[2]);
            /* Restore input file name */
        print2("?The file \"%s\" was not modified.\n", g_fullArg[2]);
      }
      continue;
    }  /* End of "WRITE RECENT_ADDITIONS" */

    if (cmdMatches("SHOW LABELS")) {
      linearFlag = 0;
      if (switchPos("LINEAR")) linearFlag = 1;
      if (switchPos("ALL")) {
        m = 1;  /* Include $e, $f statements */
        print2(
"The labels that match are shown with statement number, label, and type.\n");
      } else {
        m = 0;  /* Show $a, $p only */
        print2(
"The assertions that match are shown with statement number, label, and type.\n");
      }
      j = 0;
      k = 0;
      let(&str2, ""); /* Line so far */
#define COL 20 /* Column width */
#define MIN_SPACE 2 /* At least this many spaces between columns */
      for (i = 1; i <= g_statements; i++) {
        if (!g_Statement[i].labelName[0]) continue; /* No label */
        if (!m && g_Statement[i].type != (char)p_ &&
            g_Statement[i].type != (char)a_) continue; /* No /ALL switch */
        if (!matchesList(g_Statement[i].labelName, g_fullArg[2], '*', '?')) {
          continue;
        }

        let(&str1, cat(str((double)i), " ",
            g_Statement[i].labelName, " $", chr(g_Statement[i].type),
            NULL));
        if (!str2[0]) {
          j = 0; /* # of fields on line so far */
        }
        k = ((long)strlen(str2) + MIN_SPACE > j * COL)
            ? (long)strlen(str2) + MIN_SPACE : j * COL;
                /* Position before new str1 starts */
        if (k + (long)strlen(str1) > g_screenWidth || linearFlag) {
          if (j == 0) {
            /* In case of huge label, force it out anyway */
            printLongLine(str1, "", " ");
          } else {
            /* Line width exceeded, postpone adding str1 */
            print2("%s\n", str2);
            let(&str2, str1);
            j = 1;
          }
        } else {
          /* Add new field to line */
          if (j == 0) {
            let(&str2, str1); /* Don't put space before 1st label on line */
          } else {
            let(&str2, cat(str2, space(k - (long)strlen(str2)), str1, NULL));
          }
          j++;
        }
      } /* next i */
      if (str2[0]) {
        print2("%s\n", str2);
        free_vstring(str2);
      }
      free_vstring(str1);
      continue;
    }

    if (cmdMatches("SHOW DISCOURAGED")) {
      showDiscouraged();
      continue;
    }

    if (cmdMatches("SHOW SOURCE")) {
      /* Currently, SHOW SOURCE only handles one statement at a time,
         so use getStatementNum().  Eventually, SHOW SOURCE may become
         obsolete; I don't think anyone uses it. */
      s = getStatementNum(g_fullArg[2],
          1/*startStmt*/,
          g_statements + 1  /*maxStmt*/,
          1/*aAllowed*/,
          1/*pAllowed*/,
          1/*eAllowed*/,
          1/*fAllowed*/,
          0/*efOnlyForMaxStmt*/,
          1/*uniqueFlag*/);
      if (s == -1) {
        continue; /* Error msg was provided */
      }
      g_showStatement = s; /* Update for future defaults */

      free_vstring(str1);
      str1 = outputStatement(g_showStatement, /* cleanFlag */
          0 /* reformatFlag */);
      let(&str1,edit(str1,128)); /* Trim trailing spaces */
      if (str1[strlen(str1)-1] == '\n') let(&str1, left(str1,
          (long)strlen(str1) - 1));
      printLongLine(str1, "", "");
      free_vstring(str1); /* Deallocate vstring */
      continue;
    } /* if (cmdMatches("SHOW SOURCE")) */

    if (cmdMatches("SHOW STATEMENT") && (
        switchPos("HTML")
        || switchPos("BRIEF_HTML")
        || switchPos("ALT_HTML")
        || switchPos("BRIEF_ALT_HTML"))) {
      /* Special processing for the / HTML qualifiers - for each matching
         statement, a .html file is opened, the statement is output,
         and depending on statement type a proof or other information
         is output. */

      noVersioning = (switchPos("NO_VERSIONING") != 0);
      i = 5;  /* # arguments with only / HTML or / ALT_HTML */
      if (noVersioning) i = i + 2;
      if (switchPos("TIME")) i = i + 2;
      if (g_rawArgs != i) {
        printLongLine(cat("?The HTML qualifiers may not be combined with",
            " others except / NO_VERSIONING and / TIME.\n", NULL), "  ", " ");
        continue;
      }

      printTime = 0;
      if (switchPos("TIME") != 0) {
        printTime = 1;
      }

      g_htmlFlag = 1;

      if (switchPos("BRIEF_HTML") || switchPos("BRIEF_ALT_HTML")) {
        if (strcmp(g_fullArg[2], "*")) {
          print2(
              "?For BRIEF_HTML or BRIEF_ALT_HTML, the label must be \"*\"\n");
          goto htmlDone;
        }
        g_briefHtmlFlag = 1;
      } else {
        g_briefHtmlFlag = 0;
      }

      if (switchPos("ALT_HTML") || switchPos("BRIEF_ALT_HTML")) {
        g_altHtmlFlag = 1;
      } else {
        g_altHtmlFlag = 0;
      }

      q = 0;

      /* Special feature:  if the match statement starts with "*", we
         will also output mmascii.html, mmtheoremsall.html, and
         mmdefinitions.html.  So, with
                 SHOW STATEMENT * / HTML
         these will be output plus all statements; with
                 SHOW STATEMENT *! / HTML
         these will be output with no statements (since ! is illegal in a
         statement label); with
                 SHOW STATEMENT ?* / HTML
         all statements will be output, but without mmascii.html etc. */
      if (((char *)(g_fullArg[2]))[0] == '*' || g_briefHtmlFlag) {
        s = -2; /* -2 is for ASCII table; -1 is for theorems;
                    0 is for definitions */
      } else {
        s = 1;
      }

      for (s = s + 0; s <= g_statements; s++) {

        if (s > 0 && g_briefHtmlFlag) break; /* Only do summaries */

        /*
           s = -2:  mmascii.html
           s = -1:  mmtheoremsall.html (used to be mmtheorems.html)
           s = 0:   mmdefinitions.html
           s > 0:   normal statement
        */

        if (s > 0) {
          if (!g_Statement[s].labelName[0]) continue; /* No label */
          if (!matchesList(g_Statement[s].labelName, g_fullArg[2], '*', '?'))
            continue;
          if (g_Statement[s].type != (char)a_
              && g_Statement[s].type != (char)p_) continue;
        }

        q = 1; /* Flag that at least one matching statement was found */

        if (s > 0) {
          g_showStatement = s;
        } else {
          /* We set it to 1 here so we will output the Metamath Proof
             Explorer and not the Hilbert Space Explorer header for
             definitions and theorems lists, when g_showStatement is
             compared to g_extHtmlStmt in printTexHeader in mmwtex.c */
          g_showStatement = 1;
        }

        /*** Open the html file ***/
        g_htmlFlag = 1;
        /* Open the html output file */
        switch (s) {
          case -2:
            let(&g_texFileName, "mmascii.html");
            break;
          case -1:
            let(&g_texFileName, "mmtheoremsall.html");
            break;
          case 0:
            let(&g_texFileName, "mmdefinitions.html");
            break;
          default:
            let(&g_texFileName, cat(g_Statement[g_showStatement].labelName, ".html",
                NULL));
        }
        print2("Creating HTML file \"%s\"...\n", g_texFileName);
        g_texFilePtr = fSafeOpen(g_texFileName, "w", noVersioning);
        if (!g_texFilePtr) goto htmlDone; /* Couldn't open it (err msg was
            provided) */
        g_texFileOpenFlag = 1;
        printTexHeader((s > 0) ? 1 : 0 /*texHeaderFlag*/);
        if (!g_texDefsRead) {
          /* If there was an error reading the $t xx.mm statement,
             g_texDefsRead won't be set, and we should close out file and skip
             further processing.  Otherwise we will be attempting to process
             uninitialized htmldef arrays and such. */
          print2("?HTML generation was aborted due to the error above.\n");
          s = g_statements + 1; /* To force loop to exit */
          goto ABORT_S; /* Go to end of loop where file is closed out */
        }

        if (s <= 0) {
          g_outputToString = 1;
          if (s == -2) {
            printLongLine(cat("<CENTER><FONT COLOR=", GREEN_TITLE_COLOR,
                "><B>",
                "Symbol to ASCII Correspondence for Text-Only Browsers",
                " (in order of appearance in $c and $v statements",
                     " in the database)",
                "</B></FONT></CENTER><P>", NULL), "", "\"");
          }
          /* 13-Oct-2006 nm todo - </CENTER> still appears - where is it? */
          if (!g_briefHtmlFlag) print2("<CENTER>\n");
          print2("<TABLE BORDER CELLSPACING=0 BGCOLOR=%s\n",
              MINT_BACKGROUND_COLOR);
          /* For bobby.cast.org approval */
          switch (s) {
            case -2:
              print2("SUMMARY=\"Symbol to ASCII correspondences\">\n");
              break;
            case -1:
              print2("SUMMARY=\"List of theorems\">\n");
              break;
            case 0:
              print2("SUMMARY=\"List of syntax, axioms and definitions\">\n");
              break;
          }
          switch (s) {
            case -2:
              print2("<TR ALIGN=LEFT><TD><B>\n");
              break;
            case -1:
              print2(
         "<CAPTION><B>List of Theorems</B></CAPTION><TR ALIGN=LEFT><TD><B>\n");
              break;
            case 0:
              printLongLine(cat(
                  /* (in case |- suppressed) */
                  "<CAPTION><B>List of Syntax, ",
                  "Axioms (<FONT COLOR=", GREEN_TITLE_COLOR, ">ax-</FONT>) and",
                  " Definitions (<FONT COLOR=", GREEN_TITLE_COLOR,
                  ">df-</FONT>)", "</B></CAPTION><TR ALIGN=LEFT><TD><B>",
                  NULL), "", "\"");
              break;
          }
          switch (s) {
            case -2:
              print2("Symbol</B></TD><TD><B>ASCII\n");
              break;
            case -1:
              print2(
                  "Ref</B></TD><TD><B>Description\n");
              break;
            case 0:
              printLongLine(cat(
                  "Ref</B></TD><TD><B>",
                "Expression (see link for any distinct variable requirements)",
                NULL), "", "\"");
              break;
          }
          print2("</B></TD></TR>\n");
          m = 0; /* Statement number map */
          let(&str3, ""); /* For storing ASCII token list in s=-2 mode */
          let(&bgcolor, MINT_BACKGROUND_COLOR);
          for (i = 1; i <= g_statements; i++) {
            if (s != -2 && (i == g_extHtmlStmt || i == g_mathboxStmt)) {
              /* Print a row that identifies the start of the extended
                 database (e.g. Hilbert Space Explorer) or the user
                 sandboxes */
              if (i == g_extHtmlStmt) {
                let(&bgcolor, PURPLISH_BIBLIO_COLOR);
              } else {
                let(&bgcolor, SANDBOX_COLOR);
              }
              printLongLine(cat("<TR BGCOLOR=", bgcolor,
                  "><TD COLSPAN=2 ALIGN=CENTER><A NAME=\"startext\"></A>",
                  "The list of syntax, axioms (ax-) and definitions (df-) for",
                  " the <B><FONT COLOR=", GREEN_TITLE_COLOR, ">",
                  (i == g_extHtmlStmt) ?
                    g_extHtmlTitle :
                    "User Mathboxes",
                  "</FONT></B> starts here</TD></TR>", NULL), "", "\"");
            }

            if (g_Statement[i].type == (char)p_ ||
                g_Statement[i].type == (char)a_ ) m++;
            if ((s == -1 && g_Statement[i].type != (char)p_)
                || (s == 0 && g_Statement[i].type != (char)a_)
                || (s == -2 && g_Statement[i].type != (char)c_
                    && g_Statement[i].type != (char)v_)
                ) continue;
            switch (s) {
              case -2:
                /* Print symbol to ASCII table entry */
                /* It's a $c or $v statement, so each token generates a
                   table row */
                for (j = 0; j < g_Statement[i].mathStringLen; j++) {
                  let(&str1, g_MathToken[(g_Statement[i].mathString)[j]].tokenName);
                  /* Output each token only once in case of multiple decl. */
                  if (!instr(1, str3, cat(" ", str1, " ", NULL))) {
                    let(&str3, cat(str3, " ", str1, " ", NULL));
                    free_vstring(str2);
                    str2 = tokenToTex(g_MathToken[(g_Statement[i].mathString)[j]
                        ].tokenName, i/*stmt# for error msgs*/);
                    /* Skip any tokens (such as |- in QL Explorer) that may be suppressed */
                    if (!str2[0]) continue;
                    /* Convert special characters to HTML entities */
                    for (k = 0; k < (signed)(strlen(str1)); k++) {
                      if (str1[k] == '&') {
                        let(&str1, cat(left(str1, k), "&amp;",
                            right(str1, k + 2), NULL));
                        k = k + 4;
                      }
                      if (str1[k] == '<') {
                        let(&str1, cat(left(str1, k), "&lt;",
                            right(str1, k + 2), NULL));
                        k = k + 3;
                      }
                      if (str1[k] == '>') {
                        let(&str1, cat(left(str1, k), "&gt;",
                            right(str1, k + 2), NULL));
                        k = k + 3;
                      }
                    } /* next k */
                    printLongLine(cat("<TR ALIGN=LEFT><TD>",
                        (g_altHtmlFlag ? cat("<SPAN ", g_htmlFont, ">", NULL) : ""),
                        str2,
                        (g_altHtmlFlag ? "</SPAN>" : ""),
                        "&nbsp;", /* This will prevent a
                                     -4px shifted image from overlapping the
                                     lower border of the table cell */
                        "</TD><TD><TT>",
                        str1,
                        "</TT></TD></TR>", NULL), "", "\"");
                  }
                } /* next j */
                /* Close out the string now to prevent memory overflow */
                fprintf(g_texFilePtr, "%s", g_printString);
                free_vstring(g_printString);
                break;
              case -1: /* Falls through to next case */
              case 0:
                free_vstring(str1);
                if (s == 0 || g_briefHtmlFlag) {
                  free_vstring(str1);
                  /* Get HTML hypotheses => assertion */
                  str1 = getTexOrHtmlHypAndAssertion(i);
                  let(&str1, cat(str1, "</TD></TR>", NULL));
                }

                if (g_briefHtmlFlag) {
                  /* Get page number in mmtheorems*.html of WRITE THEOREMS */
                  k = ((g_Statement[i].pinkNumber - 1) /
                      THEOREMS_PER_PAGE) + 1; /* Page # */
                  let(&str2, cat("<TR ALIGN=LEFT><TD ALIGN=LEFT>",
                      /*"<FONT COLOR=\"#FA8072\">",*/
                      "<FONT COLOR=ORANGE>",
                      str((double)(g_Statement[i].pinkNumber)), "</FONT> ",
                      "<FONT COLOR=GREEN><A HREF=\"",
                      "mmtheorems", (k == 1) ? "" : str((double)k), ".html#",
                      g_Statement[i].labelName,
                      "\">", g_Statement[i].labelName,
                      "</A></FONT>", NULL));
                  let(&str1, cat(str2, " ", str1, NULL));
                } else {
                  /* Get little pink (or rainbow-colored) number */
                  free_vstring(str4);
                  str4 = pinkHTML(i);
                  let(&str2, cat("<TR BGCOLOR=", bgcolor,
                      " ALIGN=LEFT><TD><A HREF=\"",
                      g_Statement[i].labelName,
                      ".html\">", g_Statement[i].labelName,
                      "</A>", str4, NULL));
                  let(&str1, cat(str2, "</TD><TD>", str1, NULL));
                }

                print2("\n");  /* New line for HTML source readability */
                printLongLine(str1, "", "\"");

                if (s == 0 || g_briefHtmlFlag) {
                              /* Set s == 0 here for Web site version,
                                 s == s for symbol version of theorem list */
                  /* The below has been replaced by
                     getTexOrHtmlHypAndAssertion(i) above. */
                  /*printTexLongMath(g_Statement[i].mathString, "", "", 0, 0);*/
                  /*g_outputToString = 1;*/ /* Is reset by printTexLongMath */
                } else {
                  /* Theorems are listed w/ description; otherwise file is too
                     big for convenience */
                  free_vstring(str1);
                  str1 = getDescription(i);
                  if (strlen(str1) > 29)
                    let(&str1, cat(left(str1, 26), "...", NULL));
                  let(&str1, cat(str1, "</TD></TR>", NULL));
                  printLongLine(str1, "", "\"");
                }
                /* Close out the string now to prevent overflow */
                fprintf(g_texFilePtr, "%s", g_printString);
                free_vstring(g_printString);
                break;
            } /* end switch */
          } /* next i (statement number) */
          g_outputToString = 0;  /* closing will write out the string */
          free_vstring(bgcolor); /* Deallocate (to improve fragmentation) */
        } else { /* s > 0 */

          if (printTime == 1) {
            getRunTime(&timeIncr);  /* This call just resets the time */
          }

//          /*** Output the html statement body ***/
//          typeStatement(g_showStatement,
//              0 /*briefFlag*/,
//              0 /*commentOnlyFlag*/,
//              1 /*texFlag*/,   /* means latex or html */
//              1 /*g_htmlFlag*/);

          if (printTime == 1) {
            getRunTime(&timeIncr);
            print2("SHOW STATEMENT run time = %6.2f sec for \"%s\"\n",
                timeIncr,
                g_texFileName);
          }
        } /* if s <= 0 */

       ABORT_S:
        /*** Close the html file ***/
        printTexTrailer(1 /*texHeaderFlag*/);
        fclose(g_texFilePtr);
        g_texFileOpenFlag = 0;
        free_vstring(g_texFileName);
      } /* next s */

      if (!q) {
        /* No matching statement was found */
        printLongLine(cat("?There is no statement whose label matches \"",
            g_fullArg[2], "\".  ",
            "Use SHOW LABELS for a list of valid labels.", NULL), "", " ");
        continue;
      }

      /* Complete the command processing to bypass normal SHOW STATEMENT
         (non-html) below. */
     htmlDone:
      continue;
    } /* if (cmdMatches("SHOW STATEMENT") && switchPos("HTML")...) */

    /* Write mnemosyne.txt */
    if (cmdMatches("SHOW STATEMENT") && switchPos("MNEMONICS")) {
      g_htmlFlag = 1;     /* Use HTML, not TeX section */
      g_altHtmlFlag = 1;  /* Use Unicode, not GIF */
      /* readTexDefs() rereads based on changes to g_htmlFlag, g_altHtmlFlag */
      if (2/*error*/ == readTexDefs(0 /* 1 = check errors only */,
          1 /* 1 = GIF file existence check */  )) {
        continue; /* An error occurred */
      }

      let(&g_texFileName, "mnemosyne.txt");
      g_texFilePtr = fSafeOpen(g_texFileName, "w", 0/*noVersioningFlag*/);
      if (!g_texFilePtr) {
        /* Couldn't open file; error message was provided by fSafeOpen */
        continue;
      }
      print2("Creating Mnemosyne file \"%s\"...\n", g_texFileName);

      for (s = 1; s <= g_statements; s++) {
        g_showStatement = s;

        if (!g_Statement[s].labelName[0]) continue; /* No label */
        if (!matchesList(g_Statement[s].labelName, g_fullArg[2], '*', '?'))
          continue;
        if (g_Statement[s].type != (char)a_
            && g_Statement[s].type != (char)p_)
          continue;

        let(&str1, cat("<CENTER><B><FONT SIZE=\"+1\">",
            " <FONT COLOR=", GREEN_TITLE_COLOR,
            " SIZE = \"+3\">", g_Statement[g_showStatement].labelName,
            "</FONT></FONT></B>", "</CENTER>", NULL));
        fprintf(g_texFilePtr, "%s", str1);

        let(&str1, cat("<TABLE>",NULL));
        fprintf(g_texFilePtr, "%s", str1);

        j = nmbrLen(g_Statement[g_showStatement].reqHypList);
        for (i = 0; i < j; i++) {
          k = g_Statement[g_showStatement].reqHypList[i];
          if (g_Statement[k].type != (char)e_
              && !(subType == SYNTAX
              && g_Statement[k].type == (char)f_))
            continue;

          let(&str1, cat("<TR ALIGN=LEFT><TD><FONT SIZE=\"+2\">",
              g_Statement[k].labelName, "</FONT></TD><TD><FONT SIZE=\"+2\">",
              NULL));
          fprintf(g_texFilePtr, "%s", str1);

          /* Print hypothesis */
          free_vstring(str1); /* Free any previous allocation to str1 */
          /* getTexLongMath does not return a temporary allocation; must
             assign str1 directly, not with let().  It will be deallocated
             with the next let(&str1,...). */
          str1 = getTexLongMath(g_Statement[k].mathString,
              k/*stmt# for err msgs*/);
          fprintf(g_texFilePtr, "%s</FONT></TD>", str1);
        }

        let(&str1, "</TABLE>");
        fprintf(g_texFilePtr, "%s", str1);

        let(&str1, "<BR><FONT SIZE=\"+2\">What is the conclusion?</FONT>");
        fprintf(g_texFilePtr, "%s\n", str1);

        let(&str1, "<FONT SIZE=\"+3\">");
        fprintf(g_texFilePtr, "%s", str1);

        free_vstring(str1); /* Free any previous allocation to str1 */
        /* getTexLongMath does not return a temporary allocation */
        str1 = getTexLongMath(g_Statement[s].mathString, s);
        fprintf(g_texFilePtr, "%s", str1);

        let(&str1, "</FONT>");
        fprintf(g_texFilePtr, "%s\n",str1);
      } /*  for(s=1;s<g_statements;++s) */

      fclose(g_texFilePtr);
      g_texFileOpenFlag = 0;
      free_vstring(g_texFileName);
      free_vstring(str1);
      free_vstring(str2);

      continue;
    } /* if (cmdMatches("SHOW STATEMENT") && switchPos("MNEMONICS")) */

    /* If we get here, the user did not specify one of the qualifiers /HTML,
       /BRIEF_HTML, /ALT_HTML, or /BRIEF_ALT_HTML */
    if (cmdMatches("SHOW STATEMENT") && !switchPos("HTML")) {

      texFlag = 0;
      if (switchPos("TEX") || switchPos("OLD_TEX")
          || switchPos("HTML"))
        texFlag = 1;

      briefFlag = 1;
      g_oldTexFlag = 0;
      if (switchPos("TEX")) briefFlag = 0;
      if (switchPos("OLD_TEX")) briefFlag = 0;
      if (switchPos("OLD_TEX")) g_oldTexFlag = 1;
      if (switchPos("FULL")) briefFlag = 0;

      commentOnlyFlag = 0;
      if (switchPos("COMMENT")) {
        commentOnlyFlag = 1;
        briefFlag = 1;
      }

      if (switchPos("FULL")) {
        briefFlag = 0;
        commentOnlyFlag = 0;
      }

      if (texFlag) {
        if (!g_texFileOpenFlag) {
          print2(
      "?You have not opened a %s file.  Use the OPEN TEX command first.\n",
              g_htmlFlag ? "HTML" : "LaTeX");
          continue;
        }

        if (!g_texDefsRead) {
          print2(
      "?Error: Cannot output %s because the $t command could not be read.\n",
              g_htmlFlag ? "HTML" : "LaTeX");
          continue;
        }
      }

      if (texFlag && (commentOnlyFlag || briefFlag)) {
        print2("?TEX qualifier should be used alone\n");
        continue;
      }

      q = 0;

      for (s = 1; s <= g_statements; s++) {
        if (!g_Statement[s].labelName[0]) continue; /* No label */
        /* We are not in MM-PA mode, or the statement isn't "=" */
        if (!matchesList(g_Statement[s].labelName, g_fullArg[2], '*', '?'))
          continue;

        if (briefFlag || commentOnlyFlag || texFlag) {
          /* For brief or comment qualifier, if label has wildcards,
             show only $p and $a's */
          if (g_Statement[s].type != (char)p_
              && g_Statement[s].type != (char)a_ && (instr(1, g_fullArg[2], "*")
                  || instr(1, g_fullArg[2], "?")))
            continue;
        }

        if (q && !texFlag) {
          if (!print2("%s\n", string(g_screenWidth, '-'))) /* Put line between
                                                   statements */
            break; /* Break for speedup if user quit */
        }
        if (texFlag) print2("Outputting statement \"%s\"...\n",
            g_Statement[s].labelName);

        q = 1; /* Flag that at least one matching statement was found */

        g_showStatement = s;

//        typeStatement(g_showStatement,
//            briefFlag,
//            commentOnlyFlag,
//            texFlag,
//            g_htmlFlag);
      } /* Next s */

      if (!q) {
        /* No matching statement was found */
        printLongLine(cat("?There is no statement whose label matches \"",
            g_fullArg[2], "\".  ",
            "Use SHOW LABELS for a list of valid labels.", NULL), "", " ");
        continue;
      }

      if (texFlag && !g_htmlFlag) {
        print2("The LaTeX source was written to \"%s\".\n", g_texFileName);
        g_oldTexFlag = 0;
      }
      continue;
    } /* (cmdMatches("SHOW STATEMENT") && !switchPos("HTML")) */

    if (cmdMatches("SHOW SETTINGS")) {
      print2("Metamath settings on %s at %s:\n",date(),time_());
      if (g_commandEcho) {
        print2("(SET ECHO...) Command ECHO is ON.\n");
      } else {
        print2("(SET ECHO...) Command ECHO is OFF.\n");
      }
      if (defaultScrollMode == 1) {
        print2("(SET SCROLL...) SCROLLing mode is PROMPTED.\n");
      } else {
        print2("(SET SCROLL...) SCROLLing mode is CONTINUOUS.\n");
      }
      print2("(SET WIDTH...) Screen display WIDTH is %ld.\n", g_screenWidth);
      print2("(SET HEIGHT...) Screen display HEIGHT is %ld.\n",
          g_screenHeight + 1);
      if (g_sourceHasBeenRead == 1) {
        print2("(READ...) %ld statements have been read from \"%s\".\n",
            g_statements, g_input_fn);
      } else {
        print2("(READ...) No source file has been read in yet.\n");
      }
      print2("(SET ROOT_DIRECTORY...) Root directory is \"%s\".\n",
          g_rootDirectory);
      print2(
     "(SET DISCOURAGEMENT...) Blocking based on \"discouraged\" tags is %s.\n",
          (g_globalDiscouragement ? "ON" : "OFF"));
      print2(
     "(SET CONTRIBUTOR...) The current contributor is \"%s\".\n",
          g_contributorName);
      if (g_PFASmode) {
        print2("(PROVE...) The statement you are proving is \"%s\".\n",
            g_Statement[g_proveStatement].labelName);
      }
      print2(
    "(SET UNIFICATION_TIMEOUT...) The unification timeout parameter is %ld.\n",
          0);
      if (0) {
        print2(
     "(SET EMPTY_SUBSTITUTION...) EMPTY_SUBSTITUTION is not allowed (OFF).\n");
      } else {
        print2(
          "(SET EMPTY_SUBSTITUTION...) EMPTY_SUBSTITUTION is allowed (ON).\n");
      }
      if (0) {
        print2(
              "(SET JEREMY_HENTY_FILTER...) The Henty filter is turned ON.\n");
      } else {
        print2(
             "(SET JEREMY_HENTY_FILTER...) The Henty filter is turned OFF.\n");
      }
      if (g_showStatement) {
        print2("(SHOW...) The default statement for SHOW commands is \"%s\".\n",
            g_Statement[g_showStatement].labelName);
      }
      if (g_logFileOpenFlag) {
        print2("(OPEN LOG...) The log file \"%s\" is open.\n", g_logFileName);
      } else {
        print2("(OPEN LOG...) No log file is currently open.\n");
      }
      if (g_texFileOpenFlag) {
        print2("The %s file \"%s\" is open.\n", g_htmlFlag ? "HTML" : "LaTeX",
            g_texFileName);
      }
      print2(
  "(SHOW STATEMENT.../[TEX,HTML,ALT_HTML]) Current output mode is %s.\n",
          g_htmlFlag
             ? (g_altHtmlFlag ? "ALT_HTML" : "HTML")
             : "TEX (LaTeX)");
      print2("The program is compiled for a %ld-bit CPU.\n",
          (long)(8 * sizeof(long)));
      print2(
 "sizeof(short)=%ld, sizeof(int)=%ld, sizeof(long)=%ld, sizeof(size_t)=%ld.\n",
        (long)(sizeof(short)),
        (long)(sizeof(int)), (long)(sizeof(long)), (long)(sizeof(size_t)));
      continue;
    }

    if (cmdMatches("SHOW MEMORY")) {
      j = 32000000; /* The largest we'd ever look for */
      i = getFreeSpace(j);
      if (i > j-3) {
        print2("At least %ld bytes of memory are free.\n",j);
      } else {
        print2("%ld bytes of memory are free.\n",i);
      }
      continue;
    }

    if (cmdMatches("SHOW ELAPSED_TIME")) {
      timeTotal = getRunTime(&timeIncr);
      print2(
      "Time since last SHOW ELAPSED_TIME command = %6.2f s; total = %6.2f s\n",
          timeIncr, timeTotal);
      continue;
    } /* if (cmdMatches("SHOW ELAPSED_TIME")) */

    if (cmdMatches("SHOW TRACE_BACK")) {
      essentialFlag = 0;
      axiomFlag = 0;
      endIndent = 0;
      i = switchPos("ESSENTIAL");
      if (i) essentialFlag = 1; /* Limit trace to essential steps only */
      i = switchPos("ALL");
      if (i) essentialFlag = 0;
      i = switchPos("AXIOMS");
      if (i) axiomFlag = 1; /* Limit trace printout to axioms */
      i = switchPos("DEPTH"); /* Limit depth of printout */
      if (i) endIndent = (long)val(g_fullArg[i + 1]);

      i = switchPos("COUNT_STEPS");
      countStepsFlag = (i != 0 ? 1 : 0);
      i = switchPos("TREE");
      treeFlag = (i != 0 ? 1 : 0);
      i = switchPos("MATCH");
      matchFlag = (i != 0 ? 1 : 0);
      if (matchFlag) {
        let(&matchList, g_fullArg[i + 1]);
      } else {
        let(&matchList, "");
      }
      i = switchPos("TO");
      if (i != 0) {
        let(&traceToList, g_fullArg[i + 1]);
      } else {
        let(&traceToList, "");
      }
      if (treeFlag) {
        if (axiomFlag) {
          print2(
              "(Note:  The AXIOMS switch is ignored in TREE mode.)\n");
        }
        if (countStepsFlag) {
          print2(
              "(Note:  The COUNT_STEPS switch is ignored in TREE mode.)\n");
        }
        if (matchFlag) {
          print2(
  "(Note: The MATCH list is ignored in TREE mode.)\n");
        }
      } else {
        if (endIndent != 0) {
          print2(
  "(Note:  The DEPTH is ignored if the TREE switch is not used.)\n");
        }
        if (countStepsFlag) {
          if (matchFlag) {
            print2(
  "(Note: The MATCH list is ignored in COUNT_STEPS mode.)\n");
          }
        }
      }

      g_showStatement = 0;
      for (i = 1; i <= g_statements; i++) {
        if (g_Statement[i].type != (char)p_)
          continue; /* Not a $p statement; skip it */
        /* Wildcard matching */
        if (!matchesList(g_Statement[i].labelName, g_fullArg[2], '*', '?'))
          continue;

        g_showStatement = i;

        if (treeFlag) {
          traceProofTree(g_showStatement, essentialFlag, endIndent);
        } else {
          if (countStepsFlag) {
            countSteps(g_showStatement, essentialFlag);
          } else {
            if (traceProof(g_showStatement,
                essentialFlag,
                axiomFlag,
                matchList,
                traceToList,
                0 /* testOnlyFlag */,
                1 /* allow early exit */) == -1)
              break; // the user aborted
          }
        }
      } /* next i */
      if (g_showStatement == 0) {
        printLongLine(cat("?There are no $p labels matching \"",
            g_fullArg[2], "\".  ",
            "See HELP SHOW TRACE_BACK for matching rules.", NULL), "", " ");
      }

      free_vstring(matchList); /* Deallocate memory */
      free_vstring(traceToList); /* Deallocate memory */
      continue;
    } /* if (cmdMatches("SHOW TRACE_BACK")) */

    if (cmdMatches("SHOW USAGE")) {

      if (switchPos("ALL")) {
        m = 1;  /* Always include $e, $f statements */
      } else {
        m = 0;  /* If wildcards are used, show $a, $p only */
      }

      g_showStatement = 0;
      for (i = 1; i <= g_statements; i++) {
        if (!g_Statement[i].labelName[0]) continue; /* No label */
        if (!m && g_Statement[i].type != (char)p_ &&
            g_Statement[i].type != (char)a_
            /* A wildcard-free user-specified statement is always matched even
               if it's a $e, i.e. it overrides omission of / ALL */
            && (instr(1, g_fullArg[2], "*")
              || instr(1, g_fullArg[2], "?")))
          continue; /* No /ALL switch and wildcard and not $p, $a */
        /* Wildcard matching */
        if (!matchesList(g_Statement[i].labelName, g_fullArg[2], '*', '?'))
          continue;

        g_showStatement = i;
        recursiveFlag = 0;
        j = switchPos("RECURSIVE");
        if (j) recursiveFlag = 1; /* Recursive (indirect) usage */
        j = switchPos("DIRECT");
        if (j) recursiveFlag = 0; /* Direct references only */

        free_vstring(str1);
        str1 = traceUsage(g_showStatement,
            recursiveFlag,
            0 /* cutoffStmt */);

        /* str1[0] will be 'Y' or 'N' depending on whether there are any
           statements.  str1[i] will be 'Y' or 'N' depending on whether
           g_Statement[i] uses g_showStatement. */
        /* Count the number of statements k = # of 'Y' */
        k = 0;
        if (str1[0] == 'Y') {
          /* There is at least one statement using g_showStatement */
          for (j = g_showStatement + 1; j <= g_statements; j++) {
            if (str1[j] == 'Y') {
              k++;
            } else {
              if (str1[j] != 'N') bug(1124); /* Must be 'Y' or 'N' */
            }
          }
        } else {
          if (str1[0] != 'N') bug(1125); /* Must be 'Y' or 'N' */
        }

        if (k == 0) {
          printLongLine(cat("Statement \"",
              g_Statement[g_showStatement].labelName,
              "\" is not referenced in the proof of any statement.", NULL),
              "", " ");
        } else {
          if (recursiveFlag) {
            let(&str2, "\" directly or indirectly affects");
          } else {
            let(&str2, "\" is directly referenced in");
          }
          if (k == 1) {
            printLongLine(cat("Statement \"",
                g_Statement[g_showStatement].labelName,
                str2, " the proof of ",
                str((double)k), " statement:", NULL), "", " ");
          } else {
            printLongLine(cat("Statement \"",
                g_Statement[g_showStatement].labelName,
                str2, " the proofs of ",
                str((double)k), " statements:", NULL), "", " ");
          }
        }

        if (k != 0) {
          let(&str3, " "); /* Line buffer */
          for (j = g_showStatement + 1; j <= g_statements; j++) {
            if (str1[j] == 'Y') {
              /* Since the output list could be huge, don't build giant
                 string (very slow) but output it line by line */
              if ((long)strlen(str3) + 1 +
                  (long)strlen(g_Statement[j].labelName) > g_screenWidth) {
                /* Output and reset the line buffer */
                print2("%s\n", str3);
                let(&str3, " ");
              }
              let(&str3, cat(str3, " ", g_Statement[j].labelName, NULL));
            }
          }
          if (strlen(str3) > 1) print2("%s\n", str3);
          free_vstring(str3);
        } else {
          print2("  (None)\n");
        } /* if (k != 0) */
      } /* next i (statement matching wildcard list) */

      if (g_showStatement == 0) {
        printLongLine(cat("?There are no labels matching \"",
            g_fullArg[2], "\".  ",
            "See HELP SHOW USAGE for matching rules.", NULL), "", " ");
      }
      continue;
    } /* if cmdMatches("SHOW USAGE") */

    if (cmdMatches("SEARCH")) {
      if (switchPos("ALL")) {
        m = 1;  /* Include $e, $f statements */
      } else {
        m = 0;  /* Show $a, $p only */
      }

      if (switchPos("JOIN")) {
        joinFlag = 1;  /* Join $e's to $a,$p for matching */
      } else {
        joinFlag = 0;  /* Search $a,$p by themselves */
      }

      if (switchPos("COMMENTS")) {
        n = 1;  /* Search comments */
      } else {
        n = 0;  /* Search statement math symbols */
      }

      let(&str1, g_fullArg[2]); /* String to match */

      if (n) { /* COMMENTS switch */
        /* Trim leading, trailing spaces; reduce white space to space;
           convert to upper case */
        let(&str1, edit(str1, 8 + 16 + 128 + 32));
      } else { /* No COMMENTS switch */
        /* Trim leading, trailing spaces; reduce white space to space */
        let(&str1, edit(str1, 8 + 16 + 128));

        /* Change all spaces to double spaces */
        q = (long)strlen(str1);
        let(&str3, space(q + q));
        s = 0;
        for (p = 0; p < q; p++) {
          str3[p + s] = str1[p];
          if (str1[p] == ' ') {
            s++;
            str3[p + s] = str1[p];
          }
        }
        let(&str1, left(str3, q + s));

        /* Find single-character-match wildcard argument "$?"
           (or "?" for convenience).  Use ASCII 3 for the exactly-1-char
           wildcard character.  This is a single-character
           match, not a single-token match:  we need "??" to match "ph". */
        while (1) {
          p = instr(1, str1, "$?");
          if (!p) break;
          let(&str1, cat(left(str1, p - 1), chr(3), right(str1, p + 2), NULL));
        }
        /* Allow just "?" for convenience. */
        while (1) {
          p = instr(1, str1, "?");
          if (!p) break;
          let(&str1, cat(left(str1, p - 1), chr(3), right(str1, p + 1), NULL));
        }

        /* Change wildcard to ASCII 2 (to be different from printable chars) */
        /* 1-Mar-02 nm - (Why are we matching with and without space? I'm not sure.) */
        /* 30-Jan-06 nm Answer:  We need the double-spacing, and the removal
           of space in the "with spaces" case, so that "ph $ ph" will match
           "ph  ph" (0-token case) - "ph  $  ph" won't match this in the
           (character-based, not token-based) matches().  The "with spaces"
           case is for matching whole tokens, whereas the "without spaces"
           case is for matching part of a token. */
        while (1) {
          p = instr(1, str1, " $* ");
          if (!p) break;
          /* This removes the space before and after the $* */
          let(&str1, cat(left(str1, p - 1), chr(2), right(str1, p + 4), NULL));
        }
        while (1) {
          p = instr(1, str1, "$*");
          if (!p) break;
          /* This simply replaces $* with chr(2) */
          let(&str1, cat(left(str1, p - 1), chr(2), right(str1, p + 2), NULL));
        }
        /* Also allow a plain $ as a wildcard, for convenience. */
        while (1) {
          p = instr(1, str1, " $ ");
          if (!p) break;
          let(&str1, cat(left(str1, p - 1), chr(2), right(str1, p + 3), NULL));
        }
        while (1) {
          /* Note: the "$" shortcut must be done last to avoid picking up
             "$*" and "$?". */
          p = instr(1, str1, "$");
          if (!p) break;
          let(&str1, cat(left(str1, p - 1), chr(2), right(str1, p + 1), NULL));
        }

        /* Add wildcards to beginning and end to match middle of any string */
        let(&str1, cat(chr(2), " ", str1, " ", chr(2), NULL));
      } /* End no COMMENTS switch */

      for (i = 1; i <= g_statements; i++) {
        if (!g_Statement[i].labelName[0]) continue; /* No label */
        if (!m && g_Statement[i].type != (char)p_ &&
            g_Statement[i].type != (char)a_) {
          continue; /* No /ALL switch */
        }
        if (!matchesList(g_Statement[i].labelName, g_fullArg[1], '*', '?'))
          continue;
        if (n) { /* COMMENTS switch */
          free_vstring(str2);
          str2 = getDescription(i); /* str2 must be deallocated here */
          /* Strip linefeeds and reduce spaces; cvt to uppercase */
          j = instr(1, edit(str2, 4 + 8 + 16 + 128 + 32), str1);
          if (!j) { /* No match */
            free_vstring(str2);
            continue;
          }
          /* Strip linefeeds and reduce spaces */
          let(&str2, edit(str2, 4 + 8 + 16 + 128));
          j = j + ((long)strlen(str1) / 2); /* Center of match location */
          p = g_screenWidth - 7 - (long)strlen(str((double)i)) -
            (long)strlen(g_Statement[i].labelName);
                        /* Longest comment portion that will fit in one line */
          q = (long)strlen(str2); /* Length of comment */
          if (q <= p) { /* Use entire comment */
            let(&str3, str2);
          } else {
            if (q - j <= p / 2) { /* Use right part of comment */
              let(&str3, cat("...", right(str2, q - p + 4), NULL));
            } else {
              if (j <= p / 2) { /* Use left part of comment */
                let(&str3, cat(left(str2, p - 3), "...", NULL));
              } else { /* Use middle part of comment */
                let(&str3, cat("...", mid(str2, j - p / 2, p - 6), "...",
                    NULL));
              }
            }
          }
          print2("%s\n", cat(str((double)i), " ", g_Statement[i].labelName, " $",
              chr(g_Statement[i].type), " \"", str3, "\"", NULL));
          free_vstring(str2);
        } else { /* No COMMENTS switch */
          let(&str2,nmbrCvtMToVString(g_Statement[i].mathString));

          tmpFlag = 0; /* Flag that $p or $a is already in string */
          if (joinFlag && (g_Statement[i].type == (char)p_ ||
              g_Statement[i].type == (char)a_)) {
            /* If $a or $p, prepend $e's to string to match */
            k = nmbrLen(g_Statement[i].reqHypList);
            for (j = k - 1; j >= 0; j--) {
              p = g_Statement[i].reqHypList[j];
              if (g_Statement[p].type == (char)e_) {
                let(&str2, cat("$e ",
                    nmbrCvtMToVString(g_Statement[p].mathString),
                    tmpFlag ? "" : cat(" $", chr(g_Statement[i].type), NULL),
                    " ", str2, NULL));
                tmpFlag = 1; /* Flag that a $p or $a was added */
              }
            }
          }

          /* Change all spaces to double spaces */
          q = (long)strlen(str2);
          let(&str3, space(q + q));
          s = 0;
          for (p = 0; p < q; p++) {
            str3[p + s] = str2[p];
            if (str2[p] == ' ') {
              s++;
              str3[p + s] = str2[p];
            }
          }
          let(&str2, left(str3, q + s));

          let(&str2, cat(" ", str2, " ", NULL));
          /* We should use matches() and not matchesList() here, because
             commas can be legal token characters in math symbols */
          if (!matches(str2, str1, 2/* ascii 2 0-or-more-token match char*/,
              3/* ascii 3 single-token-match char*/))
            continue;
          let(&str2, edit(str2, 8 + 16 + 128)); /* Trim leading, trailing
              spaces; reduce white space to space */
          printLongLine(cat(str((double)i)," ",
              g_Statement[i].labelName,
              tmpFlag ? "" : cat(" $", chr(g_Statement[i].type), NULL),
              " ", str2,
              NULL), "    ", " ");
        } /* End no COMMENTS switch */
      } /* Next i */
      continue;
    }

    if (cmdMatches("SET ECHO")) {
      if (cmdMatches("SET ECHO ON")) {
        g_commandEcho = 1;
        print2("!SET ECHO ON\n");
        print2("Command line echoing is now turned on.\n");
      } else {
        g_commandEcho = 0;
        print2("Command line echoing is now turned off.\n");
      }
      continue;
    }

    if (cmdMatches("SET MEMORY_STATUS")) {
      if (cmdMatches("SET MEMORY_STATUS ON")) {
        print2("Memory status display has been turned on.\n");
        print2("This command is intended for debugging purposes only.\n");
        g_memoryStatus = 1;
      } else {
        g_memoryStatus = 0;
        print2("Memory status display has been turned off.\n");
      }
      continue;
    }

    if (cmdMatches("SET JEREMY_HENTY_FILTER")) {
      if (cmdMatches("SET JEREMY_HENTY_FILTER ON")) {
        print2("The unification equivalence filter has been turned on.\n");
        print2("This command is intended for debugging purposes only.\n");
      } else {
        print2("This command is intended for debugging purposes only.\n");
        print2("The unification equivalence filter has been turned off.\n");
      }
      continue;
    }

    if (cmdMatches("SET EMPTY_SUBSTITUTION")) {
      if (cmdMatches("SET EMPTY_SUBSTITUTION ON")) {
        print2("Substitutions with empty symbol sequences is now allowed.\n");
        continue;
      }
      if (cmdMatches("SET EMPTY_SUBSTITUTION OFF")) {
        printLongLine(cat("The ability to substitute empty expressions",
            " for variables  has been turned off.  Note that this may",
            " make the Proof Assistant too restrictive in some cases.",
            NULL),
            "", " ");
        continue;
      }
    }

    if (cmdMatches("SET WIDTH")) {
      s = (long)val(g_fullArg[2]); /* Screen width value */

      /* TODO: figure out why s=2 crashes program! */
      if (s < 3) s = 3; /* Less than 3 may cause a segmentation fault */
      i = g_screenWidth;
      g_screenWidth = s;
      print2("Screen width has been changed from %ld to %ld.\n",
          i, s);
      continue;
    }

    if (cmdMatches("SET HEIGHT")) {
      s = (long)val(g_fullArg[2]); /* Screen height value */
      if (s < 2) s = 2;  /* Less than 2 makes no sense */
      i = g_screenHeight;
      g_screenHeight = s - 1;
      print2("Screen height has been changed from %ld to %ld.\n",
          i + 1, s);
      /* g_screenHeight is one less than the physical screen to account for the
         prompt line after pausing. */
      continue;
    }

    if (cmdMatches("SET DISCOURAGEMENT")) {
      if (!strcmp(g_fullArg[2], "ON")) {
        g_globalDiscouragement = 1;
        print2("\"(...is discouraged.)\" markup tags are now honored.\n");
      } else if (!strcmp(g_fullArg[2], "OFF")) {
        print2(
    "\"(...is discouraged.)\" markup tags are no longer honored.\n");
        /* print2("\n"); */ /* Enable for more emphasis */
        print2(
">>> ?Warning: This setting is intended for advanced users only.  Please turn\n");
        print2(
">>> it back ON if you are not intimately familiar with this database.\n");
        /* print2("\n"); */ /* Enable for more emphasis */
        g_globalDiscouragement = 0;
      } else {
        bug(1129);
      }
      continue;
    }

    if (cmdMatches("SET CONTRIBUTOR")) {
      print2("\"Contributed by...\" name was changed from \"%s\" to \"%s\"\n",
          g_contributorName, g_fullArg[2]);
      let(&g_contributorName, g_fullArg[2]);
      continue;
    }

    if (cmdMatches("SET ROOT_DIRECTORY")) {
      let(&str1, g_rootDirectory); /* Save previous one */
      let(&g_rootDirectory, edit(g_fullArg[2], 2/*discard spaces,tabs*/));
      if (g_rootDirectory[0] != 0) {  /* Not an empty directory path */
        /* Add trailing "/" to g_rootDirectory if missing */
        if (instr(1, g_rootDirectory, "\\") != 0
            || instr(1, g_input_fn, "\\") != 0
            || instr(1, g_output_fn, "\\") != 0 ) {
          /* Using Windows-style path (not really supported, but at least
             make full path consistent) */
          if (g_rootDirectory[strlen(g_rootDirectory) - 1] != '\\') {
            let(&g_rootDirectory, cat(g_rootDirectory, "\\", NULL));
          }
        } else {
          if (g_rootDirectory[strlen(g_rootDirectory) - 1] != '/') {
            let(&g_rootDirectory, cat(g_rootDirectory, "/", NULL));
          }
        }
      }
      if (strcmp(str1, g_rootDirectory)) {
        print2("Root directory was changed from \"%s\" to \"%s\"\n",
            str1, g_rootDirectory);
      }
      free_vstring(str1);
      continue;
    }

    if (cmdMatches("SET UNIFICATION_TIMEOUT")) {
      s = (long)val(g_fullArg[2]); /* Timeout value */
      print2("Unification timeout has been changed from %ld to %ld\n", 0,s);
      continue;
    }

    if (cmdMatches("OPEN LOG")) {
        /* Open a log file */
        let(&g_logFileName, g_fullArg[2]);
        g_logFilePtr = fSafeOpen(g_logFileName, "w", 0/*noVersioningFlag*/);
        if (!g_logFilePtr) continue; /* Couldn't open it (err msg was provided) */
        g_logFileOpenFlag = 1;
        print2("The log file \"%s\" was opened %s %s.\n",g_logFileName,
            date(),time_());
        continue;
    }

    if (cmdMatches("CLOSE LOG")) {
        /* Close the log file */
        if (!g_logFileOpenFlag) {
          print2("?Sorry, there is no log file currently open.\n");
        } else {
          print2("The log file \"%s\" was closed %s %s.\n",g_logFileName,
              date(),time_());
          fclose(g_logFilePtr);
          g_logFileOpenFlag = 0;
        }
        free_vstring(g_logFileName);
        continue;
    }

    if (cmdMatches("OPEN TEX")) {
      if (g_texDefsRead) {
        if (g_htmlFlag) {
          /* Actually it isn't clear to me this is still the case, but
             to be safe I left it in */
          print2("?You cannot use both LaTeX and HTML in the same session.\n");
          print2(
              "?You must EXIT and restart Metamath to switch to the other.\n");
          continue;
        }
      }

      /* Open a TeX file */
      let(&g_texFileName,g_fullArg[2]);
      if (switchPos("NO_HEADER")) {
        texHeaderFlag = 0;
      } else {
        texHeaderFlag = 1;
      }

      if (switchPos("OLD_TEX")) {
        g_oldTexFlag = 1;
      } else {
        g_oldTexFlag = 0;
      }
      g_texFilePtr = fSafeOpen(g_texFileName, "w", 0/*noVersioningFlag*/);
      if (!g_texFilePtr) continue; /* Couldn't open it (err msg was provided) */
      g_texFileOpenFlag = 1;
      print2("Created %s output file \"%s\".\n",
          g_htmlFlag ? "HTML" : "LaTeX", g_texFileName);
      printTexHeader(texHeaderFlag);
      g_oldTexFlag = 0;
      continue;
    }

    if (cmdMatches("CLOSE TEX")) {
      /* Close the TeX file */
      if (!g_texFileOpenFlag) {
        print2("?Sorry, there is no LaTeX file currently open.\n");
      } else {
        print2("The LaTeX output file \"%s\" has been closed.\n",
            g_texFileName);
        printTexTrailer(texHeaderFlag);
        fclose(g_texFilePtr);
        g_texFileOpenFlag = 0;
      }
      free_vstring(g_texFileName);
      continue;
    }

    /* Similar to Unix 'more' */
    if (cmdMatches("MORE")) {
      list1_fp = fSafeOpen(g_fullArg[1], "r", 0/*noVersioningFlag*/);
      if (!list1_fp) continue; /* Couldn't open it (error msg was provided) */
      while (1) {
        if (!linput(list1_fp, NULL, &str1)) break; /* End of file */
        /* Print a line on the screen */
        if (!print2("%s\n", str1)) break; /* User typed Q */
      }
      fclose(list1_fp);
      continue;
    } /* end MORE */

    if (cmdMatches("FILE SEARCH")) {
      /* Search the contents of a file and type on the screen */

      type_fp = fSafeOpen(g_fullArg[2], "r", 0/*noVersioningFlag*/);
      if (!type_fp) continue; /* Couldn't open it (error msg was provided) */
      fromLine = 0;
      toLine = 0;
      searchWindow = 0;
      i = switchPos("FROM_LINE");
      if (i) fromLine = (long)val(g_fullArg[i + 1]);
      i = switchPos("TO_LINE");
      if (i) toLine = (long)val(g_fullArg[i + 1]);
      i = switchPos("WINDOW");
      if (i) searchWindow = (long)val(g_fullArg[i + 1]);
      /*??? Implement SEARCH /WINDOW */
      if (i) print2("Sorry, WINDOW has not been implemented yet.\n");

      let(&str2, g_fullArg[3]); /* Search string */
      let(&str2, edit(str2, 32)); /* Convert to upper case */

      tmpFlag = 0;

      /* Search window buffer */
      pntrLet(&pntrTmp, pntrSpace(searchWindow));

      j = 0; /* Line # */
      m = 0; /* # matches */
      while (linput(type_fp, NULL, &str1)) {
        j++;
        if (j > toLine && toLine != 0) break;
        if (j >= fromLine || fromLine == 0) {
          let(&str3, edit(str1, 32)); /* Convert to upper case */
          if (instr(1, str3, str2)) { /* Match occurred */
            if (!tmpFlag) {
              tmpFlag = 1;
              print2(
                    "The line number in the file is shown before each line.\n");
            }
            m++;
            if (!print2("%ld:  %s\n", j, left(str1,
                MAX_LEN - (long)strlen(str((double)j)) - 3))) break;
          }
        }
        for (k = 1; k < searchWindow; k++) {
          let((vstring *)(&pntrTmp[k - 1]), pntrTmp[k]);
        }
        if (searchWindow > 0)
            let((vstring *)(&pntrTmp[searchWindow - 1]), str1);
      }
      if (!tmpFlag) {
        print2("There were no matches.\n");
      } else {
        if (m == 1) {
          print2("There was %ld matching line in the file %s.\n", m,
              g_fullArg[2]);
        } else {
          print2("There were %ld matching lines in the file %s.\n", m,
              g_fullArg[2]);
        }
      }

      fclose(type_fp);

      /* Deallocate search window buffer */
      for (i = 0; i < searchWindow; i++) {
        let((vstring *)(&pntrTmp[i]), "");
      }
      free_pntrString(pntrTmp);

      continue;
    }

    if (cmdMatches("SET UNIVERSE") || cmdMatches("ADD UNIVERSE") ||
        cmdMatches("DELETE UNIVERSE")) {

      /*continue;*/ /* ???Not implemented */
    } /* end if xxx UNIVERSE */

    if (cmdMatches("SET DEBUG FLAG")) {
      print2("Notice:  The DEBUG mode is intended for development use only.\n");
      print2("The printout will not be meaningful to the user.\n");
      i = (long)val(g_fullArg[3]);
      if (i == 4) db4 = 1;  /* Not used */
      if (i == 5) db5 = 1;  /* mmpars.c statistics; mmunif.c overview */
      if (i == 6) db6 = 1;  /* mmunif.c details */
      if (i == 7) db7 = 1;  /* mmunif.c more details; mmveri.c */
      if (i == 8) db8 = 1;  /* mmpfas.c unification calls */
      if (i == 9) db9 = 1;  /* memory */ /* use SET MEMORY_STATUS ON instead */
      continue;
    }
    if (cmdMatches("SET DEBUG OFF")) {
      db4 = 0;
      db5 = 0;
      db6 = 0;
      db7 = 0;
      db8 = 0;
      db9 = 0;
      print2("The DEBUG mode has been turned off.\n");
      continue;
    }

    if (cmdMatches("ERASE")) {
      if (g_sourceChanged) {
        print2("Warning:  You have not saved changes to the source.\n");
        str1 = cmdInput1("Do you want to ERASE anyway (Y, N) <N>? ");
        if (str1[0] != 'y' && str1[0] != 'Y') {
          print2("Use WRITE SOURCE to save the changes.\n");
          continue;
        }
        g_sourceChanged = 0;
      }
      eraseSource();
      g_sourceHasBeenRead = 0; /* Global variable */
      g_showStatement = 0;
      g_proveStatement = 0;
      print2("Metamath has been reset to the starting state.\n");
      continue;
    }

    if (cmdMatches("VERIFY PROOF")) {
      if (switchPos("SYNTAX_ONLY")) {
        verifyProofs(g_fullArg[2],0); /* Parse only */
      } else {
        verifyProofs(g_fullArg[2],1); /* Parse and verify */
      }
      continue;
    }

    if (cmdMatches("VERIFY MARKUP")) {
      i = switchPos("DATE_SKIP") == 0;
      j = switchPos("TOP_DATE_CHECK") != 0;
      k = switchPos("FILE_CHECK") != 0;
      l = switchPos("UNDERSCORE_SKIP") == 0;
      m = switchPos("MATHBOX_SKIP") == 0;
      n = switchPos("VERBOSE") != 0;
      verifyMarkup(g_fullArg[2],
          (flag)i, /* 1 = check date consistency */
          (flag)j, /* 1 = check top date */
          (flag)k, /* 1 = check external files (gifs and bib) */
          (flag)l, /* 1 = check labels for underscores */
          (flag)m, /* 1 = check mathbox cross-references */
          (flag)n); /* 1 = verbose mode */
      continue;
    }

    if (cmdMatches("MARKUP")) {
      g_htmlFlag = 1;
      g_altHtmlFlag = (switchPos("ALT_HTML") != 0);
      if ((switchPos("HTML") != 0) == (switchPos("ALT_HTML") != 0)) {
        print2("?Please specify exactly one of / HTML and / ALT_HTML.\n");
        continue;
      }
      i = 0;
      i = ((switchPos("SYMBOLS") != 0) ? PROCESS_SYMBOLS : 0)
          + ((switchPos("LABELS") != 0) ? PROCESS_LABELS : 0)
          + ((switchPos("NUMBER_AFTER_LABEL") != 0) ? ADD_COLORED_LABEL_NUMBER : 0)
          + ((switchPos("BIB_REFS") != 0) ? PROCESS_BIBREFS : 0)
          + ((switchPos("UNDERSCORES") != 0) ? PROCESS_UNDERSCORES : 0);
      processMarkup(g_fullArg[1], /* Input file */
          g_fullArg[2],  /* Output file */
          (switchPos("CSS") != 0),
          i); /* Action bits */
      continue;
    }

    print2("?This command has not been implemented.\n");
    continue;
  }
} // command
