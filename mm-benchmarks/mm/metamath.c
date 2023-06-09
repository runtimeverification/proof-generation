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

    if (cmdMatches("VERIFY PROOF")) {
      if (switchPos("SYNTAX_ONLY")) {
        verifyProofs(g_fullArg[2],0); /* Parse only */
      } else {
        verifyProofs(g_fullArg[2],1); /* Parse and verify */
      }
      continue;
    }

    print2("?This command has not been implemented.\n");
    continue;
  }
} // command
