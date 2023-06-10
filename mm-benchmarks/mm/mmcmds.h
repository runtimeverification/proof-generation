/*****************************************************************************/
/*        Copyright (C) 2020  NORMAN MEGILL                                  */
/*            License terms:  GNU General Public License                     */
/*****************************************************************************/
/*34567890123456 (79-character line to adjust editor window) 2345678901234567*/

#ifndef METAMATH_MMCMDS_H_
#define METAMATH_MMCMDS_H_

/*! \file */

#include "mmvstr.h"
#include "mmdata.h"

void readInput(void);

void eraseSource(void);
void verifyProofs(vstring labelMatch, flag verifyFlag);

#endif // METAMATH_MMCMDS_H_
