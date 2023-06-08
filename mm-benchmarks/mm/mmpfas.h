/*****************************************************************************/
/*        Copyright (C) 2020  NORMAN MEGILL                                  */
/*            License terms:  GNU General Public License                     */
/*****************************************************************************/
/*34567890123456 (79-character line to adjust editor window) 2345678901234567*/

#ifndef METAMATH_MMPFAS_H_
#define METAMATH_MMPFAS_H_

/*! \file */

#include "mmvstr.h"
#include "mmdata.h"

extern long g_proveStatement; /*!< The statement to be proved */

extern long g_dummyVars; /*!< The number of dummy variables currently declared */
extern long g_pipDummyVars; /*!< Number of dummy vars used by proof in progress */

/*!< Structure for holding a proof in progress.
  \note This structure should be deallocated after use. */
struct pip_struct {
  nmbrString *proof; /*!< The proof itself */
  pntrString *target; /*!< Left hand side of = in display */
  pntrString *source; /*!< Right hand side of = in display */
  pntrString *user; /*!< User-specified math string assignments to step */
};
extern struct pip_struct g_ProofInProgress;

/*! Get subproof length of a proof, starting at endStep and going backwards */
long subproofLen(const nmbrString *proof, long endStep);

/*! Adds a dummy variable to end of mathToken array
  \note it now grows forever, but purging it might worsen fragmentation */
void declareDummyVars(long numNewVars);

#endif // METAMATH_MMPFAS_H_
