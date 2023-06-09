/*****************************************************************************/
/*        Copyright (C) 2020  NORMAN MEGILL                                  */
/*            License terms:  GNU General Public License                     */
/*****************************************************************************/
/*34567890123456 (79-character line to adjust editor window) 2345678901234567*/

#ifndef METAMATH_MMUNIF_H_
#define METAMATH_MMUNIF_H_

/*! \file */

#include "mmdata.h"
/*!< User-settable value - 0 or 1 */
extern long g_minSubstLen;
/*!< User-defined upper limit (# backtracks) for unification trials */
extern long g_userMaxUnifTrials;
/*!< 0 means don't time out; 1 means start counting trials */
extern long g_unifTrialCount;
/*!< Number of timeouts so far for this command */
extern long g_unifTimeouts;
/*!< Turns Henty filter on or off */
extern flag g_hentyFilter;

// Global so eraseSource() (mmcmds.c) can clear them
extern flag g_bracketMatchInit;
extern nmbrString *g_firstConst;
extern nmbrString *g_lastConst;
extern nmbrString *g_oneConst;

#endif // METAMATH_MMUNIF_H_
