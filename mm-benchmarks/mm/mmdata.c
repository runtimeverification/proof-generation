/*****************************************************************************/
/*        Copyright (C) 2020  NORMAN MEGILL                                  */
/*            License terms:  GNU General Public License                     */
/*****************************************************************************/
/*34567890123456 (79-character line to adjust editor window) 2345678901234567*/

/*
mmdata.c
*/

/*!
 * \file
 * Defines global data structures and manipulates arrays with functions similar
 * to BASIC string functions; memory management; converts between proof formats
*/
#include <stdarg.h>
#include <stdlib.h>
#include <string.h>
#include "mmvstr.h"
#include "mmdata.h"
#include "mminou.h"
#include "mmpars.h"
#include "mmcmdl.h" /* Needed for g_logFileName */

/*E*/long db=0,db0=0,db2=0,db3=0,db4=0,db5=0,db6=0,db7=0,db8=0,db9=0;
flag g_listMode = 0; /* 0 = metamath, 1 = list utility */
flag g_toolsMode = 0; /* In metamath: 0 = metamath, 1 = text tools utility */

/* For use by getMarkupFlag() */
vstring_def(g_proofDiscouragedMarkup);
vstring_def(g_usageDiscouragedMarkup);
flag g_globalDiscouragement = 1; /* SET DISCOURAGEMENT ON */

vstring_def(g_contributorName);

/* Global variables related to current statement */
int g_currentScope = 0;

long g_MAX_STATEMENTS = 1;
long g_MAX_MATHTOKENS = 1;
long g_MAX_INCLUDECALLS = 2; /* Must be at least 2 (the single-file case) !!!
                         (A dummy extra top entry is used by parseKeywords().) */
struct statement_struct *g_Statement = NULL;
long *g_labelKey = NULL;
struct mathToken_struct *g_MathToken;
long *g_mathKey = NULL;
long g_statements = 0, labels = 0, g_mathTokens = 0;

struct includeCall_struct *g_IncludeCall = NULL;
long g_includeCalls = -1;  /* For eraseSource() in mmcmds.c */

char *g_sourcePtr = NULL;
long g_sourceLen;

/* Null nmbrString */
struct nullNmbrStruct g_NmbrNull = {-1, sizeof(long), sizeof(long), -1};

/* Null pntrString */
struct nullPntrStruct g_PntrNull = {-1, sizeof(long), sizeof(long), NULL};

temp_nmbrString *nmbrTempAlloc(long size);
        /* nmbrString memory allocation/deallocation */
void nmbrCpy(nmbrString *sout, const nmbrString *sin);
void nmbrNCpy(nmbrString *s, const nmbrString *t, long n);

temp_pntrString *pntrTempAlloc(long size);
        /* pntrString memory allocation/deallocation */
void pntrCpy(pntrString *sout, const pntrString *sin);
void pntrNCpy(pntrString *s, const pntrString *t, long n);

/*!
 * \page pgSuballocator Suballocator
 *
 * Metamath does not free memory by returning it to the operating system again.
 * To reduce frequent system de/allocation calls, it instead implements a
 * suballocator.  Each chunk of memory allocated from the system (we call them
 * \ref pgBlock "block" in this documentation) is equipped with a hidden header
 * containing administrative information private to the suballocator.
 *
 * During execution chunks of memory, either complete \ref pgBlock "blocks" or
 * \ref pgFragmentation "fragments" thereof, become free again.  The
 * suballocator adds them then to internal **pools** for reuse, one dedicated
 * to totally free blocks (\ref memFreePool), the other to fragmented ones
 * (\ref memUsedPool).  We call these pools **free block array** and
 * **used block array** in this documentation.  Fully occupied blocks are not
 * tracked by the suballocator.
 *
 * Although the suballocator tries to avoid returning memory to the system, it
 * can do so under extreme memory constraints, or when built-in limits are
 * surpassed.
 *
 * The suballocator was designed with stack-like memory usage in mind, where
 * data of the same type is pushed at, or popped off the end all the time.
 * Each \ref pgBlock block supports this kind of usage out of the box (see
 * \ref pgFragmentation).
 */

/*!
 * \page pgFragmentation Fragmented blocks
 *
 * Memory fragmentation is kept simple in Metamath.  If a \ref pgBlock "block"
 * contains both consumed and free space, all the free space is at the end.
 * This scheme supports the idea of stack-like memory usage, where free space
 * grows and shrinks behind a stack in a fixed size memory area, depending on
 * its usage.
 *
 * Other types of fragmentation is not directly supported by the
 * \ref pgSuballocator "suballocator".
 */

 /*! \page pgBlock Block of memory
 *
 * Each block used by the \ref pgSuballocator "suballocator" is formally´
 * treated as an array of pointer (void*).  It is divided into an
 * administrative header, followed by elements reserved for application data.
 * The header is assigned elements -3 to -1 in the formal array, so that
 * application data starts with element 0.  A **pointer to the block** always
 * refers to element 0, so the header appears somewhat hidden.  Its **size**
 * is given by the bytes reserved for application data, not including the
 * administrative header.
 *
 * The header elements are formally void*, but reinterpreted as long integer.
 * The values support a stack, where data is pushed at and popped off the end
 * during the course of execution.  The semantics of the header elements are:
 *
 * offset -1:\n
 *   is the current size of the stack (in bytes, not elements!),
 *   without header data. When interpreted as an offset into the stack, it
 *   references the first element past the top of the stack.  (See
 *   \ref pgFragmentation)
 *
 * offset -2:\n
 *   the allocated size of the array, in bytes, not counting the
 *   header.  When used as a stack, it marks the limit where the stack
 *   overflows.
 *
 * offset -3:\n
 *   If this block has free space at the end (is \ref pgFragmentation
 *   "fragmented"), then this value contains its index in the used blocks
 *   array, see \ref memUsedPool.  A value of -1 indicates it is either fully
 *   occupied or totally free.  It is not kept in the used blocks array then.
 *   If this block becomes full in the course of events, it is not
 *   automatically removed from \ref memUsedPool, though.
 */

/*! \page pgPool Pool
 * A pool is an array of pointers pointing to \ref pgBlock "blocks".  It may
 * only be partially filled, so it is usually accompanied by two variables
 * giving its current fill state and its capacity.
 *
 * In Metamath a pool has no gaps in between.
 *
 * The \ref pgSuballocator "suballocator" uses two pools:
 * - the **free block array** pointed to by \ref memFreePool;
 * - the **used block array** pointed to by \ref memUsedPool.
 */

/*! \page pgStack Temporary Allocated Memory
 * Very often a routine needs some memory, that must live only as long as the
 * routine is active.  Such memory is called **temporary**, or short **local**.
 * Once a routine finishes, on return to its caller, it deallocates all its
 * __local__ memory again.  Since routines frequently call subroutines, the
 * same may hold for nested code, and so on.  In fact, this concept is so
 * ubiquitous and frequent, that the processor, and all relevant program
 * languages provide simple mechanisms for de/allocation of such __local__
 * data.  Metamath is no exception to this.
 *
 * While the C compiler silently cares about __local__ variables, it must not
 * interfere with data managed by a \ref pgSuballocator "Suballocator". Instead
 * of tracking all __locally__ created memory individually for later
 * deallocation, a stack like \ref pgPool "pool" is used to automate this
 * handling.
 *
 * Stacks of temporary data only contain pointers to dynamically allocated
 * memory from the heap or the \ref pgSuballocator.  This stack functions like
 * an operand stack.  A final result depends on fragments, temporary results
 * and similar, all pushed onto this stack.  When the final operation is
 * executed, and its result is persisted in some variable, the dependency on
 * its temporary operands ceases.  Consequently, they should be freed again.
 * To automate this operation,  such a stack maintains a `start` index.  A
 * client saves this value and sets it to the current stack top, then starts
 * pushing dynamically allocated operands on the stack.  After the result is
 * persisted, all entries beginning with the element at index  `start` are
 * deallocated again, and the stack top is reset to the `start` value, while
 * the `start` value is reset to the saved value, to accommodate nesting of
 * this procedure.
 *
 * This scheme needs a few conditions to be met:
 * - No operand is used in more than one evaluation context;
 * - Operations are executed strictly sequential, or in a nested manner. No two
 *   operations interleave pushing operands.
 */

/* Memory pools are used to reduce the number of malloc and alloc calls that
   allocate arrays (strings or nmbr/pntrStrings typically).   The "free" pool
   contains previously allocated arrays that are no longer used but that we
   have not freed yet.  A call to allocate a new array fetches one from here
   first.   The "used"
   pool contains arrays that are partially used; each array has some free space
   at the end that can be deallocated if memory gets low.   Any array that is
   totally used (no free space) is not in any pool. */
/* Each pool array has 3 "hidden" long elements before it, used by these
   procedures.
     Element -1:  actual size (bytes) of array, excluding the 3 "hidden"
       long elements.
     Element -2:  allocated size.  If all elements are used, allocated = actual.
     Element -3:  location of array in memUsedPool.  If -1, it means that
       actual = allocated and storage in memUsedPool is therefore not necessary.
   The pointer to an array always points to element 0 (recast to right size).
*/

/*!
 * \page doc-todo Improvements in documentation
 *
 * - Revisit the \ref pgBlock "block", \ref pgStack "stack" references to check
 *   the inserted wording.
 * - The formatting of __p__ tags seem insufficient.  Figure out whether and
 *   how doxygen allows assigning formats to a semantic tag.  Do not replace
 *   a tag with direct formattings like \p aParam vs `aParam`, as some editors
 *   recognize and highlight semantic tags.
 *     The parameters are included in <code>aParam</code> tags.  You can change
 *     the appearance by using your customized CSS file and let doxygen use it
 *     with HTML-EXTRA-STYLESHEET in your own Doxyfile.
 * - Regularly check the warning in \ref pntrString to see whether it still
 *   holds, or can be made more precise.
 */

/*!
 * \def MEM_POOL_GROW
 * Amount that \ref memUsedPool and \ref memFreePool grows when it overflows.
 */
#define MEM_POOL_GROW 1000
/*??? Let user set this from menu. */

/*!
 * \var long poolAbsoluteMax
 * The value is a memory amount in bytes.
 *
 * The \ref pgSuballocator scheme must not hold more memory than is short term
 * useful.  To the operating system all memory in \ref memFreePool appears as
 * allocated, although it is not really in use.  To prevent the system from
 * taking unnecessary action such as saving RAM to disk, a limit to the amount
 * of free memory managed by the suballocator can be set up.  This limit is
 * checked in frequent operations, and an automatic purge process is initiated
 * in \ref memFreePoolPurge should \ref poolTotalFree exceed this value.
 */
long poolAbsoluteMax = 1000000; /* Pools will be purged when this is reached */

/*!
 * \var long poolTotalFree
 * contains the number of free space available in bytes, in both pools
 * \ref memFreePool and \ref memUsedPool, never counting the hidden headers at
 * the beginning of each block, see \ref pgBlock.  Exceeding
 * \ref poolAbsoluteMax may trigger an automatic purge process by
 * \ref memFreePoolPurge.
 */
long poolTotalFree = 0; /* Total amount of free space allocated in pool */
/*E*/long i1,j1_,k1; /* 'j1' is a built-in function */

/*!
 * \var void** memUsedPool
 * \brief pointer to the pool of fragmented memory blocks
 *
 * If a \ref pgBlock "block" contains both consumed and free space, it is
 * \ref pgFragmentation "fragmented".  All fragmented blocks are kept in the
 * **used block array**, that memUsedPool points to.  See \ref pgSuballocator
 * "suballocator".  Since free space appears at the end of a \ref pgBlock
 * "block", this scheme supports in particular stack like memory, where data is
 * pushed at and popped off the end.
 *
 * The used blocks array does initially not exist.  This is indicated by a
 * null value.  Once this array is needed, space for it is allocated from the
 * system.
 *
 * The used block array may only be partially occupied, in which case elements
 * at the end of the array are unused.  Its current usage is given by
 * \ref memUsedPoolSize.  Its capacity is given by \ref memUsedPoolMax.
 *
 * \attention The pool may contain full \ref pgBlock "blocks".
 *
 * \invariant Each block in the used blocks array has its index noted in its
 * hidden header, for backward reference.
 *
 * \attention Despite the name of this variable, fully occupied blocks are never
 * kept in the used block array.
 */
void **memUsedPool = NULL;

/*!
 * \var long memUsedPoolSize
 * \attention this is the number of individual blocks, not the accumulated
 * (unused) bytes contained.
 *
 * The Metamath suballocator holds fragmented blocks in a used block array.
 * The number of occupied entries is kept in this variable.  Elements at the
 * end of the used block array may be unused.  The fill size is given by this
 * variable.  For further information see \ref memUsedPool.
 *
 * \invariant memUsedPoolSize <= \ref memUsedPoolMax.
 */
long memUsedPoolSize = 0; /* Current # of partially filled arrays in use */

/*!
 * \var long memUsedPoolMax
 * \attention this is the number of individual free blocks, not the accumulated
 * bytes contained.
 *
 * The Metamath suballocator holds fragmented blocks in the used block
 * array.  This array may only partially be occupied.  Its total capacity is
 * kept in this variable.  For further information see \ref memUsedPool.
 *
 * This variable may grow during a reallocation process.
 *
 * \invariant (memUsedPoolMax > 0) == (\ref memUsedPool != 0)
 */
long memUsedPoolMax = 0; /* Maximum # of entries in 'in use' table (grows
                               as necessary) */

/*!
 * \var void** memFreePool
 * \brief pointer to the pool of completely free memory blocks
 *
 * The \ref pgSuballocator "suballocator" is initially not equipped with a
 * **free block array**, pointed to by memFreePool, indicated by a null value.
 *
 * Once a \ref pgBlock "memory block" is returned to the \ref pgSuballocator
 * again, it allocates some space for the now needed array.
 *
 * The **free block array** contains only totally free \ref pgBlock "blocks".
 * This array may only be partially occupied, in which case the elements at the
 * end are the unused ones.  Its current fill size is given by
 * \ref memFreePoolSize.  Its capacity is given by \ref memFreePoolMax.
 *
 * Fragmented blocks are kept in a separate \ref memUsedPool.  The suballocator
 * never tracks fully used blocks.
 */
void **memFreePool = NULL;

/*!
 * \var long memFreePoolSize
 * \attention this is the number of individual free blocks, not the accumulated
 * bytes contained.
 *
 * The Metamath suballocator holds free blocks in a free block array.  The
 * number of occupied entries is kept in this variable.  Elements at the end of
 * the free block array may not be used.  The fill size is given by this
 * variable.  For further information see \ref memFreePool.
 *
 * \invariant memFreePoolSize <= \ref memFreePoolMax.
 */
long memFreePoolSize = 0; /* Current # of available, allocated arrays */

/*!
 * \var long memFreePoolMax
 * \attention this is the number of individual free blocks, not the accumulated
 * bytes contained.
 *
 * The Metamath suballocator holds free blocks in a **free block array**.  It
 * may only be partially occupied.  Its total capacity is kept in this variable.  For
 * further information see \ref memFreePool.
 *
 * This variable may grow during a reallocation process.
 *
 * \invariant (memFreePoolMax > 0) == (\ref memFreePool != 0)
 */
long memFreePoolMax = 0; /* Maximum # of entries in 'free' table (grows
                               as necessary) */

/* poolFixedMalloc should be called when the allocated array will rarely be
   changed; a malloc or realloc with no unused array bytes will be done. */
void *poolFixedMalloc(long size /* bytes */) {
  void *ptr;
  void *ptr2;
/*E*/ /* Don't call print2() if db9 is set, since it will */
/*E*/ /* recursively call the pool stuff causing a crash. */
/*E*/if(db9)getPoolStats(&i1,&j1_,&k1); if(db9)printf("a0: pool %ld stat %ld\n",poolTotalFree,i1+j1_);
  if (!memFreePoolSize) { /* The pool is empty; we must allocate memory */
    ptr = malloc( 3 * sizeof(long) + (size_t)size);
    if (!ptr) outOfMemory(
        cat("#25 (poolFixedMalloc ", str((double)size), ")", NULL));

    ptr = (long *)ptr + 3;
    ((long *)ptr)[-1] = size; /* Actual size */
    ((long *)ptr)[-2] = size; /* Allocated size */
    ((long *)ptr)[-3] = -1;  /* Location in memUsedPool (-1 = none) */
    return (ptr);
  } else {
    memFreePoolSize--;
    ptr = memFreePool[memFreePoolSize];
    poolTotalFree = poolTotalFree - ((long *)ptr)[-2];
/*E*/if(db9)getPoolStats(&i1,&j1_,&k1); if(db9)printf("a: pool %ld stat %ld\n",poolTotalFree,i1+j1_);
    if (size <= ((long *)ptr)[-2]) { /* We have enough space already */
      ptr2 = realloc( (long *)ptr - 3, 3 * sizeof(long) + (size_t)size);
      /* Reallocation cannot fail, since we are shrinking space */
      if (!ptr2) bug(1382);
      ptr = ptr2;
    } else { /* The pool's last entry is too small; free and allocate new */
      free((long *)ptr - 3);
      ptr = malloc( 3 * sizeof(long) + (size_t)size);
    }
    if (!ptr) {
      /* Try freeing space */
      print2("Memory is low.  Deallocating storage pool...\n");
      memFreePoolPurge(0);
      ptr = malloc( 3 * sizeof(long) + (size_t)size);
      if (!ptr) outOfMemory(
          cat("#26 (poolMalloc ", str((double)size), ")", NULL));
                                            /* Nothing more can be done */
    }
    ptr = (long *)ptr + 3;
    ((long *)ptr)[-1] = size; /* Actual size */
    ((long *)ptr)[-2] = size; /* Allocated size */
    ((long *)ptr)[-3] = -1;  /* Location in memUsedPool (-1 = none) */
    return ptr;
  }
}

/* poolMalloc tries first to use an array in the memFreePool before actually
   malloc'ing */
void *poolMalloc(long size /* bytes */)
{
  void *ptr;
  long memUsedPoolTmpMax;
  void *memUsedPoolTmpPtr;

  /* Check to see if the pool total exceeds max. */
  if (poolTotalFree > poolAbsoluteMax) {
    memFreePoolPurge(1);
  }

/*E*/if(db9)getPoolStats(&i1,&j1_,&k1); if(db9)printf("b0: pool %ld stat %ld\n",poolTotalFree,i1+j1_);
  if (!memFreePoolSize) { /* The pool is empty; we must allocate memory */
    ptr = malloc( 3 * sizeof(long) + (size_t)size);
    if (!ptr) {
      outOfMemory(cat("#27 (poolMalloc ", str((double)size), ")", NULL));
    }
    ptr = (long *)ptr + 3;
    ((long *)ptr)[-1] = size; /* Actual size */
    ((long *)ptr)[-2] = size; /* Allocated size */
    ((long *)ptr)[-3] = -1;  /* Location in memUsedPool (-1 = none) */
    return (ptr);
  } else {
    memFreePoolSize--;
    ptr = memFreePool[memFreePoolSize];
    poolTotalFree = poolTotalFree - ((long *)ptr)[-2];
/*E*/if(db9)getPoolStats(&i1,&j1_,&k1); if(db9)printf("b: pool %ld stat %ld\n",poolTotalFree,i1+j1_);
    if (size <= ((long *)ptr)[-2]) { /* We have enough space already */
      ((long *)ptr)[-1] = size; /* Actual size */
      ((long *)ptr)[-3] = -1; /* Not in storage pool yet */
    } else { /* We must reallocate */
      free((long *)ptr - 3);
      ptr = malloc( 3 * sizeof(long) + (size_t)size);
      if (!ptr) {
        /* Try freeing space */
        print2("Memory is low.  Deallocating storage pool...\n");
        memFreePoolPurge(0);
        ptr = malloc( 3 * sizeof(long) + (size_t)size);
        if (!ptr) outOfMemory(
            cat("#28 (poolMalloc ", str((double)size), ")", NULL));
                                              /* Nothing more can be done */
      }
      ptr = (long *)ptr + 3;
      ((long *)ptr)[-1] = size; /* Actual size */
      ((long *)ptr)[-2] = size; /* Allocated size */
      ((long *)ptr)[-3] = -1;  /* Location in memUsedPool (-1 = none) */
/*E*/if(db9)getPoolStats(&i1,&j1_,&k1); if(db9)printf("bb: pool %ld stat %ld\n",poolTotalFree,i1+j1_);
      return (ptr);
    }
  }
/*E*/if(db9)getPoolStats(&i1,&j1_,&k1); if(db9)printf("bc: pool %ld stat %ld\n",poolTotalFree,i1+j1_);
  if (((long *)ptr)[-1] == ((long *)ptr)[-2]) return (ptr);
  /* Allocated and actual sizes are different, so add this array to used pool */
  poolTotalFree = poolTotalFree + ((long *)ptr)[-2] - ((long *)ptr)[-1];
  if (memUsedPoolSize >= memUsedPoolMax) { /* Increase size of used pool */
    memUsedPoolTmpMax = memUsedPoolMax + MEM_POOL_GROW;
/*E*/if(db9)printf("Growing used pool to %ld\n",memUsedPoolTmpMax);
    if (!memUsedPoolMax) {
      /* The program has just started; initialize */
      memUsedPoolTmpPtr = malloc((size_t)memUsedPoolTmpMax
          * sizeof(void *));
      if (!memUsedPoolTmpPtr) bug(1303); /* Shouldn't have allocation problems
                                                    when program first starts */
    } else {
      /* Normal reallocation */
      memUsedPoolTmpPtr = realloc(memUsedPool,
          (size_t)memUsedPoolTmpMax * sizeof(void *));
    }
    if (!memUsedPoolTmpPtr) {
      outOfMemory(cat("#29 (poolMalloc ", str((double)memUsedPoolTmpMax), ")", NULL));
    } else {
      /* Reallocation successful */
      memUsedPool = memUsedPoolTmpPtr;
      memUsedPoolMax = memUsedPoolTmpMax;
    }
  }
  memUsedPool[memUsedPoolSize] = ptr;
  ((long *)ptr)[-3] = memUsedPoolSize;
  memUsedPoolSize++;
/*E*/if(db9)getPoolStats(&i1,&j1_,&k1); if(db9)printf("c: pool %ld stat %ld\n",poolTotalFree,i1+j1_);
  return ptr;
}

/* poolFree puts freed up space in memFreePool. */
void poolFree(void *ptr) {
  void *ptr1;
  long usedLoc;
  long memFreePoolTmpMax;
  void *memFreePoolTmpPtr;

/*E*/if(db9)getPoolStats(&i1,&j1_,&k1); if(db9)printf("c0: pool %ld stat %ld\n",poolTotalFree,i1+j1_);
  /* First, see if the array is in memUsedPool; if so, remove it. */
  usedLoc = ((long *)ptr)[-3];
  if (usedLoc >= 0) { /* It is */
    poolTotalFree = poolTotalFree - ((long *)ptr)[-2] + ((long *)ptr)[-1];
    memUsedPoolSize--;

    if (usedLoc < memUsedPoolSize) {
      memUsedPool[usedLoc] = memUsedPool[memUsedPoolSize];
      ptr1 = memUsedPool[usedLoc];
      ((long *)ptr1)[-3] = usedLoc;
/*E*/if(db9)getPoolStats(&i1,&j1_,&k1); if(db9)printf("d: pool %ld stat %ld\n",poolTotalFree,i1+j1_);
    }
  }

  /* Next, add the array to the memFreePool */
  /* First, allocate more memFreePool pointer space if needed */
  if (memFreePoolSize >= memFreePoolMax) { /* Increase size of free pool */
    memFreePoolTmpMax = memFreePoolMax + MEM_POOL_GROW;
/*E*/if(db9)printf("Growing free pool to %ld\n",memFreePoolTmpMax);
    if (!memFreePoolMax) {
      /* The program has just started; initialize */
      memFreePoolTmpPtr = malloc((size_t)memFreePoolTmpMax
          * sizeof(void *));
      if (!memFreePoolTmpPtr) bug(1304); /* Shouldn't have allocation problems
                                                    when program first starts */
    } else {
      /* Normal reallocation */
      memFreePoolTmpPtr = realloc(memFreePool,
          (size_t)memFreePoolTmpMax * sizeof(void *));
    }
    if (!memFreePoolTmpPtr) {
/*E*/if(db9)printf("Realloc failed\n");
      outOfMemory(cat("#30 (poolFree ", str((double)memFreePoolTmpMax), ")", NULL));
    } else {
      /* Reallocation successful */
      memFreePool = memFreePoolTmpPtr;
      memFreePoolMax = memFreePoolTmpMax;
    }
  }
  /* Add the free array to the free pool */
  memFreePool[memFreePoolSize] = ptr;
  /* In theory, [-3] should never get referenced for an entry in the
     memFreePool. However, here we make it a definite (illegal) value in
     case it is referenced by code with a bug. */
  ((long *)ptr)[-3] = -2;
  memFreePoolSize++;
  poolTotalFree = poolTotalFree + ((long *)ptr)[-2];
/*E*/if(db9)getPoolStats(&i1,&j1_,&k1); if(db9)printf("e: pool %ld stat %ld\n",poolTotalFree,i1+j1_);
  return;
}

/* addToUsedPool adds a (partially used) array to the memUsedPool */
void addToUsedPool(void *ptr)
{
  long memUsedPoolTmpMax;
  void *memUsedPoolTmpPtr;
/*E*/if(db9)getPoolStats(&i1,&j1_,&k1); if(db9)printf("d0: pool %ld stat %ld\n",poolTotalFree,i1+j1_);
  if (((long *)ptr)[-1] == ((long *)ptr)[-2]) bug(1305); /* No need to add it
                                 when it's not partially used */
  if (((long *)ptr)[-1] == ((long *)ptr)[-2]) return;
  /* Allocated and actual sizes are different, so add this array to used pool */
  if (memUsedPoolSize >= memUsedPoolMax) { /* Increase size of used pool */
    memUsedPoolTmpMax = memUsedPoolMax + MEM_POOL_GROW;
/*E*/if(db9)printf("1Growing used pool to %ld\n",memUsedPoolTmpMax);
    if (!memUsedPoolMax) {
      /* The program has just started; initialize */
      memUsedPoolTmpPtr = malloc((size_t)memUsedPoolTmpMax
          * sizeof(void *));
      if (!memUsedPoolTmpPtr) bug(1362); /* Shouldn't have allocation problems
                                                    when program first starts */
    } else {
      /* Normal reallocation */
      memUsedPoolTmpPtr = realloc(memUsedPool, (size_t)memUsedPoolTmpMax
          * sizeof(void *));
    }
    if (!memUsedPoolTmpPtr) {
      outOfMemory("#31 (addToUsedPool)");
    } else {
      /* Reallocation successful */
      memUsedPool = memUsedPoolTmpPtr;
      memUsedPoolMax = memUsedPoolTmpMax;
    }
  }
  memUsedPool[memUsedPoolSize] = ptr;
  ((long *)ptr)[-3] = memUsedPoolSize;
  memUsedPoolSize++;
  poolTotalFree = poolTotalFree + ((long *)ptr)[-2] - ((long *)ptr)[-1];
/*E*/if(db9)getPoolStats(&i1,&j1_,&k1); if(db9)printf("f: pool %ld stat %ld\n",poolTotalFree,i1+j1_);
  return;
}

/* Free all arrays in the free pool. */

/*!
 * \fn void memFreePoolPurge(flag untilOK)
 * \brief returns memory held in \ref memFreePool
 * Starting with the last entry in \ref memFreePool, memory held in that pool
 * is returned to the system until all, or at least a sufficient amount is
 * freed again (see \p untilOK).
 * \param[in] untilOK
 *   - if 1 freeing \ref pgBlock "blocks" stops the moment \ref poolTotalFree
 *     gets within the range of \ref poolAbsoluteMax again.  Note that it is
 *     not guaranteed that the limit \ref poolAbsoluteMax is undercut because
 *     still too much free memory might be held in the \ref memUsedPool.
 *   - If 0, all \ref memFreePool entries are freed, and the pool itself is
 *     shrunk back to \ref MEM_POOL_GROW size.
 */
void memFreePoolPurge(flag untilOK) {
/*E*/if(db9)getPoolStats(&i1,&j1_,&k1); if(db9)printf("e0: pool %ld stat %ld\n",poolTotalFree,i1+j1_);
  while (memFreePoolSize) {
    memFreePoolSize--;
    /* Free an array */
    poolTotalFree = poolTotalFree -
        ((long *)(memFreePool[memFreePoolSize]))[-2];
    free((long *)(memFreePool[memFreePoolSize]) - 3);
    if (untilOK) {
      /* If pool size is OK, return. */
      if (poolTotalFree <= poolAbsoluteMax) return;
    }
  }
  /* memFreePoolSize = 0 now. */
  if (memFreePoolMax != MEM_POOL_GROW) {
    /* Reduce size of pool pointer array to minimum growth increment. */
    if (memFreePool) free(memFreePool); /* Only when starting program */
    memFreePool = malloc(MEM_POOL_GROW
        * sizeof(void *)); /* Allocate starting increment */
    memFreePoolMax = MEM_POOL_GROW;
  }
/*E*/if(db9)getPoolStats(&i1,&j1_,&k1); if(db9)printf("g: pool %ld stat %ld\n",poolTotalFree,i1+j1_);
  return;
}

/* Get statistics for SHOW MEMORY command */
void getPoolStats(long *freeAlloc, long *usedAlloc, long *usedActual)
{
  long i;
  *freeAlloc = 0;
  *usedAlloc = 0;
  *usedActual = 0;
  for (i = 0; i < memFreePoolSize; i++) {
    *freeAlloc = *freeAlloc + /*12 +*/ ((long *)(memFreePool[i]))[-2];
  }
  for (i = 0; i < memUsedPoolSize; i++) {
    *usedActual = *usedActual + 12 + ((long *)(memUsedPool[i]))[-1];
    *usedAlloc = *usedAlloc + ((long *)(memUsedPool[i]))[-2] -
        ((long *)(memUsedPool[i]))[-1];
  }
/*E*/ if (!db9)print2("poolTotalFree %ld  alloc %ld\n", poolTotalFree, *freeAlloc +
/*E*/   *usedAlloc);
}

void initBigArrays(void)
{

/*??? This should all become obsolete. */
  g_Statement = malloc((size_t)g_MAX_STATEMENTS * sizeof(struct statement_struct));
/*E*//*db=db+g_MAX_STATEMENTS * sizeof(struct statement_struct);*/
  if (!g_Statement) {
    print2("*** FATAL ***  Could not allocate g_Statement space\n");
    bug(1363);
    }
  g_MathToken = malloc((size_t)g_MAX_MATHTOKENS * sizeof(struct mathToken_struct));
/*E*//*db=db+g_MAX_MATHTOKENS * sizeof(struct mathToken_struct);*/
  if (!g_MathToken) {
    print2("*** FATAL ***  Could not allocate g_MathToken space\n");
    bug(1364);
    }
  g_IncludeCall = malloc((size_t)g_MAX_INCLUDECALLS * sizeof(struct includeCall_struct));
/*E*//*db=db+g_MAX_INCLUDECALLS * sizeof(struct includeCall_struct);*/
  if (!g_IncludeCall) {
    print2("*** FATAL ***  Could not allocate g_IncludeCall space\n");
    bug(1365);
    }
}

/* Find the number of free memory bytes */
long getFreeSpace(long max)
{
  long i , j, k;
  char *s;
  i = 0;
  j = max + 2;
  while (i < j - 2) {
    k = (i + j) / 2;
    s = malloc((size_t)k);
    if (s) {
      free(s);
      i = k;
    } else {
      j = k;
    }
  }
  return (i);
}

/* Fatal memory allocation error */
void outOfMemory(const char *msg) {
  /* Close the log to make sure error log is saved */
  if (g_logFileOpenFlag) {
    fclose(g_logFilePtr);
    g_logFileOpenFlag = 0;
  }
  char const* format =
        "*** FATAL ERROR:  Out of memory.\n"
        "Internal identifier (for technical support):  %s\n"
        "To solve this problem, remove some unnecessary statements or file\n"
        "inclusions to reduce the size of your input source.\n"
        "Monitor memory periodically with SHOW MEMORY.\n";
  printf(format, msg);
}

/* Bug check */
void bug(int bugNum)
{
  vstring_def(tmpStr);
  flag oldMode;
  long wrongAnswerCount = 0;
  static flag mode = 0; /* 1 = run to next bug, 2 = continue and ignore bugs */

  flag saveOutputToString = g_outputToString;
  g_outputToString = 0; /* Make sure we print to screen and not to string */

  if (mode == 2) {
    /* If user chose to ignore bugs, print brief info and return */
    print2("?BUG CHECK:  *** DETECTED BUG %ld, IGNORING IT...\n", (long)bugNum);
    return;
  }

  print2("?BUG CHECK:  *** DETECTED BUG %ld\n", (long)bugNum);
  if (mode == 0) { /* Print detailed info for first bug */
    print2("\n");
    print2("To get technical support, please open an issue \n");
    print2("(https://github.com/metamath/metamath-exe/issues) with the\n");
    print2("detailed command sequence or a command file that reproduces this bug,\n");
    print2("along with the source file that was used.  See HELP OPEN LOG for help on\n");
    print2("recording a session.  See HELP SUBMIT for help on command files.  Search\n");
    print2("for \"bug(%ld)\" in the m*.c source code to find its origin.\n", bugNum);
    print2("If earlier errors were reported, try fixing them first, because they\n");
    print2("may occasionally lead to false bug detection\n");
    print2("\n");
  }

  let(&tmpStr, "?");
  while (strcmp(tmpStr, "A") && strcmp(tmpStr, "a")
      && strcmp(tmpStr, "S") && strcmp(tmpStr, "s")
      && strcmp(tmpStr, "I") && strcmp(tmpStr, "i")
      /* The above is actually useless because of break below, but we'll leave
         it in case we want to re-ask after wrong answers in the future */
      ) {
    if (wrongAnswerCount > 6) {
      print2("Too many wrong answers; program will be aborted to exit scripting loops.\n");
      break;
    }
    if (wrongAnswerCount > 0) {
      free_vstring(tmpStr);
      tmpStr = cmdInput1("Please answer I, S, or A:  ");
    } else {
      print2("Press S <return> to step to next bug, I <return> to ignore further bugs,\n");
      free_vstring(tmpStr);
      tmpStr = cmdInput1("or A <return> to abort program:  ");
    }
    wrongAnswerCount++;
  }
  oldMode = mode;
  mode = 0;
  if (!strcmp(tmpStr, "S") || !strcmp(tmpStr, "s")) mode = 1; /* Skip to next bug */
  if (!strcmp(tmpStr, "I") || !strcmp(tmpStr, "i")) mode = 2; /* Ignore bugs */
  if (oldMode == 0 && mode > 0) {
    /* Print dire warning after the first bug only */
    print2("\n");
    print2("Warning!!!  A bug was detected, but you are continuing anyway.\n");
    print2("The program may be corrupted, so you are proceeding at your own risk.\n");
    print2("\n");
    free_vstring(tmpStr);
  }
  if (mode > 0) {
    g_outputToString = saveOutputToString; /* Restore for continuation */
    return;
  }
  free_vstring(tmpStr);

  print2("\n");
  /* Close the log to make sure error log is saved */
  if (g_logFileOpenFlag) {
    print2("The log file \"%s\" was closed %s %s.\n", g_logFileName,
        date(), time_());
    fclose(g_logFilePtr);
    g_logFileOpenFlag = 0;
  }
  print2("The program was aborted.\n");
  exit(1); /* Use 1 instead of 0 to flag abnormal termination to scripts */
}

/*!
 * \def M_MAX_ALLOC_STACK
 *
 * The number of pointers in a \ref pgStack "stack" available for data reference.
 * Since a stack has a terminal null element, the usable count is one less than
 * the number given here.
 */
#define M_MAX_ALLOC_STACK 100

/* This function returns a 1 if any entry in a comma-separated list
   matches using the matches() function. */
flag matchesList(const char *testString, const char *pattern, char wildCard,
    char oneCharWildCard) {
  long entries, i;
  flag matchVal = 0;
  vstring_def(entryPattern);

  /* Done so we can use string functions like left() in call arguments */
  long saveTempAllocStack;
  saveTempAllocStack = g_startTempAllocStack; /* For let() stack cleanup */
  g_startTempAllocStack = g_tempAllocStackTop;

  entries = numEntries(pattern);
  for (i = 1; i <= entries; i++) {
    let(&entryPattern, entry(i, pattern)); /* If we didn't modify
          g_startTempAllocStack above, this let() would corrupt string
          functions in the matchesList() call arguments */
    matchVal = matches(testString, entryPattern, wildCard, oneCharWildCard);
    if (matchVal) break;
  }

  free_vstring(entryPattern); /* Deallocate */
  g_startTempAllocStack = saveTempAllocStack;
  return matchVal;
}

/* This function returns a 1 if the first argument matches the pattern of
   the second argument.  The second argument may have wildcard characters.
   wildCard matches 0 or more characters; oneCharWildCard matches any
   single character. */
flag matches(const char *testString, const char *pattern, char wildCard,
    char oneCharWildCard) {
  long i, ppos, pctr, tpos, s1, s2, s3;
  vstring_def(tmpStr);

  if (wildCard == '*') {
    /* Checking for wildCard = * meaning this is only for labels, not
       math tokens */

    /* The following special chars are handled in this block:
       "~" Statement range
       "=" Most recent PROVE command statement
       "%" List of modified statements
       "#" Internal statement number
       "@" Web page statement number */

    i = instr(1, pattern, "~");
    if (i != 0) {
      if (i == 1) {
        s1 = 1; /* empty string before "~" */
      } else {
      }
      if (i == (long)strlen(pattern)) {
        s3 = g_statements; /* empty string after "~" */
      } else {
      }
      free_vstring(tmpStr); /* Clean up temporary allocations of left and right */
      return ((s1 >= 1 && s2 >= 1 && s3 >= 1 && s1 <= s2 && s2 <= s3)
          ? 1 : 0);
    }

    /* "#12345" matches internal statement number */
    if (pattern[0] == '#') {
      s1 = (long)val(right(pattern, 2));
      if (s1 < 1 || s1 > g_statements)
        return 0; /* # arg is out of range */
      if (!strcmp(g_Statement[s1].labelName, testString)) {
        return 1;
      } else {
        return 0;
      }
    }

    /* "@12345" matches web statement number */
    if (pattern[0] == '@') {
      if (s1 < 1) return 0;
      s2 = (long)val(right(pattern, 2));
      if (g_Statement[s1].pinkNumber == s2) {
        return 1;
      } else {
        return 0;
      }
    }

    /* "=" matches statement being proved */
    if (!strcmp(pattern,"=")) {
      /* We might as well use g_proveStatement outside of MM-PA, so =
         can be argument to PROVE command */
      return (s1);
    }

    /* "%" matches changed proofs */
    if (!strcmp(pattern,"%")) {
    /* Returns -1 if not found or (not $a and not $p) */
      if (s1 > 0) { /* It's a $a or $p statement */
        /* (If it's not $p, we don't want to peek at proofSectionPtr[-1]
           to prevent bad pointer. */
        if (g_Statement[s1].type == (char)p_) { /* $p so it has a proof */
          /* The proof is not from the original source file */
          if (g_Statement[s1].proofSectionChanged == 1) {
            return 1;
          }
        }
      }
      return 0;
    } /* if (!strcmp(pattern,"%")) */
  } /* if (wildCard == '*') */

  /* Get to first wild card character */
  ppos = 0;
  while ((pattern[ppos] == testString[ppos] ||
          (pattern[ppos] == oneCharWildCard && testString[ppos] != 0))
      && pattern[ppos] != 0) ppos++;
  if (pattern[ppos] == 0) {
    if (testString[ppos] != 0) {
      return (0); /* No wildcards; mismatched */
    } else {
      return (1); /* No wildcards; matched */
    }
  }
  if (pattern[ppos] != wildCard) {
    return (0); /* Mismatched */
  }
  tpos = ppos;

  /* Scan remainder of pattern */
  pctr = 0;
  i = 0;
  while (1) {
    if (pattern[ppos + 1 + i] == wildCard) { /* Next wildcard found */
      tpos = tpos + pctr + i;
      ppos = ppos + 1 + i;
      i = 0;
      pctr = 0;
      continue;
    }
    if (pattern[ppos + 1 + i] != testString[tpos + pctr + i]
          && (pattern[ppos + 1 + i] != oneCharWildCard
              || testString[tpos + pctr + i] == 0)) {
      if (testString[tpos + pctr + i] == 0) {
        return (0);
      }
      pctr++;
      i = 0;
      continue;
    }
    if (pattern[ppos + 1 + i] == 0) {
      return(1); /* Matched */
    }
    i++;
  }
  bug(1375);
  return (0); /* Dummy return - never used */
}

/*******************************************************************/
/*********** Number string functions *******************************/
/*******************************************************************/

long g_nmbrTempAllocStackTop = 0;     /* Top of stack for nmbrTempAlloc function */
long g_nmbrStartTempAllocStack = 0;   /* Where to start freeing temporary allocation
                                    when nmbrLet() is called (normally 0, except in
                                    special nested vstring functions) */
temp_nmbrString *nmbrTempAllocStack[M_MAX_ALLOC_STACK];

temp_nmbrString *nmbrTempAlloc(long size)
                                /* nmbrString memory allocation/deallocation */
{
  /* When "size" is >0, "size" instances of nmbrString are allocated. */
  /* When "size" is 0, all memory previously allocated with this */
  /* function is deallocated, down to g_nmbrStartTempAllocStack. */
  if (size) {
    if (g_nmbrTempAllocStackTop>=(M_MAX_ALLOC_STACK-1)) {
      /*??? Fix to allocate more */
      outOfMemory("#105 (nmbrString stack array)");
    }
    if (!(nmbrTempAllocStack[g_nmbrTempAllocStackTop++]=poolMalloc(size
        *(long)(sizeof(nmbrString)))))
/*E*/db2=db2+size*(long)(sizeof(nmbrString));
    return (nmbrTempAllocStack[g_nmbrTempAllocStackTop-1]);
  } else {
    while(g_nmbrTempAllocStackTop != g_nmbrStartTempAllocStack) {
/*E*/db2=db2-(nmbrLen(nmbrTempAllocStack[g_nmbrTempAllocStackTop-1])+1)
/*E*/                                              *(long)(sizeof(nmbrString));
      poolFree(nmbrTempAllocStack[--g_nmbrTempAllocStackTop]);
    }
    g_nmbrTempAllocStackTop=g_nmbrStartTempAllocStack;
    return (0);
  }
}

/* Make string have temporary allocation to be released by next nmbrLet() */
/* Warning:  after nmbrMakeTempAlloc() is called, the nmbrString may NOT be
   assigned again with nmbrLet() */
temp_nmbrString *nmbrMakeTempAlloc(nmbrString *s)
{
  if (g_nmbrTempAllocStackTop>=(M_MAX_ALLOC_STACK-1)) {
    printf("*** FATAL ERROR ***  Temporary nmbrString stack overflow in nmbrMakeTempAlloc()\n");
#if __STDC__
    fflush(stdout);
#endif
    bug(1368);
  }
  if (s[0] != -1) { /* End of string */
    /* Do it only if nmbrString is not empty */
    nmbrTempAllocStack[g_nmbrTempAllocStackTop++] = s;
  }
/*E*/db2=db2+(nmbrLen(s)+1)*(long)(sizeof(nmbrString));
/*E*/db3=db3-(nmbrLen(s)+1)*(long)(sizeof(nmbrString));
  return s;
}

/* nmbrString assignment */
/* This function must ALWAYS be called to make assignment to */
/* a nmbrString in order for the memory cleanup routines, etc. */
/* to work properly.  If a nmbrString has never been assigned before, */
/* it is the user's responsibility to initialize it to NULL_NMBRSTRING (the */
/* null string). */
void nmbrLet(nmbrString **target, const nmbrString *source) {
  long targetLength,sourceLength;
  long targetAllocLen;
  long poolDiff;
/*E*/if(db9)getPoolStats(&i1,&j1_,&k1); if(db9)printf("k0: pool %ld stat %ld\n",poolTotalFree,i1+j1_);
  sourceLength=nmbrLen(source);  /* Save its actual length */
  targetLength=nmbrLen(*target);  /* Save its actual length */
  targetAllocLen=nmbrAllocLen(*target); /* Save target's allocated length */
/*E*/if (targetLength) {
/*E*/  db3 = db3 - (targetLength+1)*(long)(sizeof(nmbrString));
/*E*/}
/*E*/if (sourceLength) {
/*E*/  db3 = db3 + (sourceLength+1)*(long)(sizeof(nmbrString));
/*E*/}
  if (targetAllocLen) {
    if (sourceLength) { /* source and target are both nonzero length */

      if (targetAllocLen >= sourceLength) { /* Old string has room for new one */
        nmbrCpy(*target,source); /* Re-use the old space to save CPU time */

        /* Memory pool handling */
        /* Assign actual size of target string */
        poolDiff = ((long *)(*target))[-1] - ((long *)source)[-1];
        ((long *)(*target))[-1] = ((long *)source)[-1];
        /* If actual size of target string is less than allocated size, we
           may have to add it to the used pool */
        if (((long *)(*target))[-1] != ((long *)(*target))[-2]) {
          if (((long *)(*target))[-1] > ((long *)(*target))[-2]) bug(1325);
          if (((long *)(*target))[-3] == -1) {
            /* It's not already in the used pool, so add it */
            addToUsedPool(*target);
/*E*/if(db9)getPoolStats(&i1,&j1_,&k1); if(db9)printf("k0aa: pool %ld stat %ld\n",poolTotalFree,i1+j1_);
          } else {
            /* Adjust free space independently */
            poolTotalFree = poolTotalFree + poolDiff;
/*E*/if(db9)getPoolStats(&i1,&j1_,&k1); if(db9)printf("k0ab: pool %ld stat %ld\n",poolTotalFree,i1+j1_);
          }
        } else {
          if (((long *)(*target))[-3] != -1) {
            /* It's in the pool (but all allocated space coincidentally used) */
            /* Adjust free space independently */
            poolTotalFree = poolTotalFree + poolDiff;
          }
        }

/*E*/if(db9)getPoolStats(&i1,&j1_,&k1); if(db9)printf("k0a: pool %ld stat %ld\n",poolTotalFree,i1+j1_);
      } else {
        /* Free old string space and allocate new space */
        poolFree(*target);  /* Free old space */
        /* *target=poolMalloc((sourceLength + 1) * sizeof(nmbrString)); */
        *target=poolMalloc((sourceLength + 1) * (long)(sizeof(nmbrString)) * 2);
                        /* Allocate new space --
                            We are replacing a smaller string with a larger one;
                            assume it is growing, and allocate twice as much as
                            needed. */
        nmbrCpy(*target,source);

        /* Memory pool handling */
        /* Assign actual size of target string */
        poolDiff = ((long *)(*target))[-1] - ((long *)source)[-1];
        ((long *)(*target))[-1] = ((long *)source)[-1];
        /* If actual size of target string is less than allocated size, we
           may have to add it to the used pool */
        /* (The 1st 'if' is redundant with target doubling above) */
        if (((long *)(*target))[-1] != ((long *)(*target))[-2]) {
          if (((long *)(*target))[-1] > ((long *)(*target))[-2]) bug(1326);
          if (((long *)(*target))[-3] == -1) {
            /* It's not already in the used pool, so add it */
            addToUsedPool(*target);
          } else {
            /* Adjust free space independently */
            poolTotalFree = poolTotalFree + poolDiff;
          }
        } else {
          if (((long *)(*target))[-3] != -1) {
            /* It's in the pool (but all allocated space coincidentally used) */
            /* Adjust free space independently */
            poolTotalFree = poolTotalFree + poolDiff;
          }
        }
/*E*/if(db9)getPoolStats(&i1,&j1_,&k1); if(db9)printf("k0b: pool %ld stat %ld\n",poolTotalFree,i1+j1_);
      }
    } else {    /* source is 0 length, target is not */
      poolFree(*target);
      *target= NULL_NMBRSTRING;
/*E*/if(db9)getPoolStats(&i1,&j1_,&k1); if(db9)printf("k0c: pool %ld stat %ld\n",poolTotalFree,i1+j1_);
    }
  } else {
    if (sourceLength) { /* target is 0 length, source is not */
      *target=poolMalloc((sourceLength + 1) * (long)(sizeof(nmbrString)));
                        /* Allocate new space */
      nmbrCpy(*target,source);
/*E*/if(db9)getPoolStats(&i1,&j1_,&k1); if(db9)printf("k0d: pool %ld stat %ld\n",poolTotalFree,i1+j1_);
    } else {    /* source and target are both 0 length */
/*E*/if(db9)getPoolStats(&i1,&j1_,&k1); if(db9)printf("k0e: pool %ld stat %ld\n",poolTotalFree,i1+j1_);
    }
  }

/*E*/if(db9)getPoolStats(&i1,&j1_,&k1); if(db9)printf("k1: pool %ld stat %ld\n",poolTotalFree,i1+j1_);
  nmbrTempAlloc(0); /* Free up temporary strings used in expression computation*/
}

temp_nmbrString *nmbrCat(const nmbrString *string1,...) /* String concatenation */
#define M_MAX_CAT_ARGS 30
{
  va_list ap;   /* Declare list incrementer */
  const nmbrString *arg[M_MAX_CAT_ARGS];        /* Array to store arguments */
  long argLength[M_MAX_CAT_ARGS];       /* Array to store argument lengths */
  int numArgs = 1;        /* Define "last argument" */
  arg[0] = string1;       /* First argument */

  va_start(ap,string1); /* Begin the session */
  while ((arg[numArgs++]=va_arg(ap,nmbrString *)))
        /* User-provided argument list must terminate with NULL */
    if (numArgs>=M_MAX_CAT_ARGS-1) {
      printf("*** FATAL ERROR ***  Too many cat() arguments\n");
#if __STDC__
      fflush(stdout);
#endif
      bug(1369);
    }
  va_end(ap);           /* End varargs session */

  numArgs--;    /* The last argument (0) is not a string */

  /* Find out the total string length needed */
  long j = 0;
  for (int i = 0; i < numArgs; i++) {
    argLength[i]=nmbrLen(arg[i]);
    j += argLength[i];
  }
  /* Allocate the memory for it */
  temp_nmbrString *ptr = nmbrTempAlloc(j+1);
  /* Move the strings into the newly allocated area */
  j = 0;
  for (int i = 0; i < numArgs; i++) {
    nmbrCpy(ptr + j, arg[i]);
    j += argLength[i];
  }
  return ptr;
}

/* Find out the length of a nmbrString */
long nmbrLen(const nmbrString *s)
{
  /* Assume it's been allocated with poolMalloc. */
  return (((long)(((const long *)s)[-1] - (long)(sizeof(nmbrString))))
              / (long)(sizeof(nmbrString)));
}

/* Find out the allocated length of a nmbrString */
long nmbrAllocLen(const nmbrString *s)
{
  /* Assume it's been allocated with poolMalloc. */
  return (((long)(((const long *)s)[-2] - (long)(sizeof(nmbrString))))
              / (long)(sizeof(nmbrString)));
}

/* Set the actual size field in a nmbrString allocated with poolFixedMalloc() */
/* Use this if "zapping" a nmbrString element with -1 to reduce its length. */
/* Note that the nmbrString will not be moved to the "used pool", even if
   zapping its length results in free space; thus the free space will never
   get recovered unless done by the caller or poolFree is called.  (This is
   done on purpose so the caller can know what free space is left.) */
/* ???Note that nmbrZapLen's not moving string to used pool wastes potential
   space when called by the routines in this module.  Effect should be minor. */
void nmbrZapLen(nmbrString *s, long length) {
  if (((long *)s)[-3] != -1) {
    /* It's already in the used pool, so adjust free space tally */
    poolTotalFree = poolTotalFree + ((long *)s)[-1]
        - (length + 1) * (long)(sizeof(nmbrString));
  }
  ((long *)s)[-1] = (length + 1) * (long)(sizeof(nmbrString));
/*E*/if(db9)getPoolStats(&i1,&j1_,&k1); if(db9)printf("l: pool %ld stat %ld\n",poolTotalFree,i1+j1_);
}

/* Copy a string to another (pre-allocated) string */
/* Dangerous for general purpose use */
void nmbrCpy(nmbrString *s, const nmbrString *t) {
  long i;
  i = 0;
  while (t[i] != -1) { /* End of string -- nmbrRight depends on it!! */
    s[i] = t[i];
    i++;
  }
  s[i] = t[i]; /* End of string */
}

/* Copy a string to another (pre-allocated) string */
/* Like strncpy, only the 1st n characters are copied. */
/* Dangerous for general purpose use */
void nmbrNCpy(nmbrString *s, const nmbrString *t, long n) {
  long i;
  i = 0;
  while (t[i] != -1) { /* End of string -- nmbrSeg, nmbrMid depend on it!! */
    if (i >= n) break;
    s[i] = t[i];
    i++;
  }
  s[i] = t[i]; /* End of string */
}

/* Compare two strings */
/* Unlike strcmp, this returns a 1 if the strings are equal
   and 0 otherwise. */
/* Only the token is compared.  The whiteSpace string is
   ignored. */
flag nmbrEq(const nmbrString *s, const nmbrString *t) {
  long i;
  if (nmbrLen(s) != nmbrLen(t)) return 0; /* Speedup */
  for (i = 0; s[i] == t[i]; i++)
    if (s[i] == -1) /* End of string */
      return 1;
  return 0;
}

/* Extract sin from character position start for length len */
temp_nmbrString *nmbrMid(const nmbrString *sin, long start, long length) {
  if (start < 1) start = 1;
  if (length < 0) length = 0;
  temp_nmbrString *sout = nmbrTempAlloc(length + 1);
  nmbrNCpy(sout, sin + start - 1, length);
  sout[length] = *NULL_NMBRSTRING;
  return sout;
}

/* Allocate and return an "empty" string n "characters" long */
temp_nmbrString *nmbrSpace(long n) {
  long j = 0;
  if (n < 0) bug(1327);
  temp_nmbrString *sout = nmbrTempAlloc(n + 1);
  while (j < n) {
    /* Initialize all fields */
    sout[j] = 0;
    j++;
  }
  sout[j] = *NULL_NMBRSTRING; /* End of string */
  return sout;
}

/* Converts nmbrString to a vstring with one space between tokens */
temp_vstring nmbrCvtMToVString(const nmbrString *s) {
  long i, j, outputLen, mstrLen;
  vstring_def(tmpStr);
  vstring ptr;
  vstring ptr2;

  long saveTempAllocStack;
  saveTempAllocStack = g_startTempAllocStack; /* For let() stack cleanup */
  g_startTempAllocStack = g_tempAllocStackTop;

  mstrLen = nmbrLen(s);
  /* Precalculate output length */
  outputLen = -1;
  for (i = 0; i < mstrLen; i++) {
    outputLen = outputLen + (long)strlen(g_MathToken[s[i]].tokenName) + 1;
  }
  let(&tmpStr, space(outputLen)); /* Preallocate output string */
  /* Assign output string */
  ptr = tmpStr;
  for (i = 0; i < mstrLen; i++) {
    ptr2 = g_MathToken[s[i]].tokenName;
    j = (long)strlen(ptr2);
    memcpy(ptr, ptr2, (size_t)j);
    ptr = ptr + j + 1;
  }

  g_startTempAllocStack = saveTempAllocStack;
  return makeTempAlloc(tmpStr); /* Flag it for deallocation */
}

/* Extract variables from a math token string */
temp_nmbrString *nmbrExtractVars(const nmbrString *m) {
  long i, j, length;
  length = nmbrLen(m);
  temp_nmbrString *v = nmbrTempAlloc(length + 1); /* Pre-allocate maximum possible space */
  v[0] = *NULL_NMBRSTRING;
  j = 0; /* Length of output string */
  for (i = 0; i < length; i++) {
    /* Use > because tokenNum=g_mathTokens is used by mmveri.c for
       dummy token */
    if (m[i] < 0 || m[i] > g_mathTokens) bug(1328);
    if (g_MathToken[m[i]].tokenType == (char)var_) {
      if (!nmbrElementIn(1, v, m[i])) { /* Don't duplicate variable */
        v[j] = m[i];
        j++;
        v[j] = *NULL_NMBRSTRING; /* Add temp. end-of-string for getElementOf() */
      }
    }
  }
  nmbrZapLen(v, j); /* Zap mem pool fields */
/*E*/db2=db2-(length-nmbrLen(v))*(long)(sizeof(nmbrString));
  return v;
}

/* Determine if an element (after start) is in a nmbrString; return position
   if it is.  Like nmbrInstr(), but faster.  Warning:  start must NOT
   be greater than length, otherwise results are unpredictable!!  This
   is not checked in order to speed up search. */
long nmbrElementIn(long start, const nmbrString *g, long element) {
  long i = start - 1;
  while (g[i] != -1) { /* End of string */
    if (g[i] == element) return i + 1;
    i++;
  }
  return 0;
}

/* Add a single number to end of a nmbrString - faster than nmbrCat */
temp_nmbrString *nmbrAddElement(const nmbrString *g, long element) {
  long length;
  length = nmbrLen(g);
  temp_nmbrString *v = nmbrTempAlloc(length + 2); /* Allow for end of string */
  nmbrCpy(v, g);
  v[length] = element;
  v[length + 1] = *NULL_NMBRSTRING; /* End of string */
/*E*/if(db9)getPoolStats(&i1,&j1_,&k1); if(db9)printf("bbg2: pool %ld stat %ld\n",poolTotalFree,i1+j1_);
  return v;
}

/*******************************************************************/
/*********** Pointer string functions ******************************/
/*******************************************************************/

long g_pntrTempAllocStackTop = 0;     /* Top of stack for pntrTempAlloc function */
long g_pntrStartTempAllocStack = 0;   /* Where to start freeing temporary allocation
                                    when pntrLet() is called (normally 0, except in
                                    special nested vstring functions) */

/*!
 * \var pntrString *pntrTempAllocStack[]
 * \brief a \ref pgStack "stack" of \ref temp_pntrString.
 *
 * Holds pointers to temporarily allocated data of type \ref temp_pntrString.  Such
 * a \ref pgStack "stack" is primarily designed to operate like one for
 * temporary allocated ad hoc operands, as described in \ref pgStack.  The
 * stack top index is \ref g_pntrTempAllocStackTop, always refering to the next
 * push position.
 * The \ref g_pntrStartTempAllocStack supports nested operations by indicating
 * where the operands for the upcoming operation start from.
 * \attention A \ref pntrString consists of an array of pointers.  These
 *   pointers may themself refer data that needs a clean up, when the last
 *   reference  to it disappears (such as deallocating memory for example).
 *   There is no automatic procedure handling such cases when pointers are
 *   popped off the stack to be freed.
 * \bug The element type should be temp_pntrString, because a NULL_PNTRSTRING
 *   must not be pushed on the stack.
 */
pntrString *pntrTempAllocStack[M_MAX_ALLOC_STACK];

/*!
 * \fn temp_pntrString *pntrTempAlloc(long size)
 * \par size > 0
 * allocates a \ref pgBlock capable of holding \p size \ref pntrString entries
 * and pushes it onto the \ref pntrTempAllocStack.
 * \par size == 0
 * pops off all entries from index \ref g_pntrStartTempAllocStack on from
 * \ref pntrTempAllocStack and adds them to the \ref memFreePool.
 * \param[in] size count of \ref pntrString entries.  This value must include
 *   a terminal NULL pointer if needed.
 * \return a pointer to the allocated \ref pgBlock, or NULL if deallocation
 *   requested
 * \pre
 *   \p size ==0: all entries in from \ref pntrTempAllocStack from
 *   \ref g_pntrStartTempAllocStack do not contain relevant data any more.
 * \post
 *   - \p size > 0: memory for \p size entries is reserved in the \ref pgBlock
 *     "block's" header, but the data is still random.
 *   - updates \ref db2
 *   - Exits on out-of-memory
 * \bug it is unfortunate that the same function is used for opposite
 *   operations like de-/allocation.
 */
temp_pntrString *pntrTempAlloc(long size) {
                                /* pntrString memory allocation/deallocation */
  /* When "size" is >0, "size" instances of pntrString are allocated. */
  /* When "size" is 0, all memory previously allocated with this */
  /* function is deallocated, down to g_pntrStartTempAllocStack. */
  if (size) {
    if (g_pntrTempAllocStackTop>=(M_MAX_ALLOC_STACK-1))
      /*??? Fix to allocate more */
      outOfMemory("#109 (pntrString stack array)");
    if (!(pntrTempAllocStack[g_pntrTempAllocStackTop++]=poolMalloc(size
        *(long)(sizeof(pntrString)))))
/*E*/db2=db2+(size)*(long)(sizeof(pntrString));
    return pntrTempAllocStack[g_pntrTempAllocStackTop-1];
  } else {
    while(g_pntrTempAllocStackTop != g_pntrStartTempAllocStack) {
/*E*/db2=db2-(pntrLen(pntrTempAllocStack[g_pntrTempAllocStackTop-1])+1)
/*E*/                                              *(long)(sizeof(pntrString));
      poolFree(pntrTempAllocStack[--g_pntrTempAllocStackTop]);
    }
    g_pntrTempAllocStackTop=g_pntrStartTempAllocStack;
    return 0;
  }
}

void pntrLet(pntrString **target, const pntrString *source) {
  long targetLength,sourceLength;
  long targetAllocLen;
  long poolDiff;
/*E*/if(db9)getPoolStats(&i1,&j1_,&k1); if(db9)printf("k0: pool %ld stat %ld\n",poolTotalFree,i1+j1_);
  sourceLength=pntrLen(source);  /* Save its actual length */
  targetLength=pntrLen(*target);  /* Save its actual length */
  targetAllocLen=pntrAllocLen(*target); /* Save target's allocated length */
/*E*/if (targetLength) {
/*E*/  /* printf("Deleting %s\n",cvtMToVString(*target,0)); */
/*E*/  db3 = db3 - (targetLength+1)*(long)(sizeof(pntrString));
/*E*/}
/*E*/if (sourceLength) {
/*E*/  /* printf("Adding %s\n",cvtMToVString(source,0)); */
/*E*/  db3 = db3 + (sourceLength+1)*(long)(sizeof(pntrString));
/*E*/}
  if (targetAllocLen) {
    if (sourceLength) { /* source and target are both nonzero length */

      if (targetAllocLen >= sourceLength) { /* Old string has room for new one */
        pntrCpy(*target,source); /* Re-use the old space to save CPU time */

        /* Memory pool handling */
        /* Assign actual size of target string */
        poolDiff = ((long *)(*target))[-1] - ((long *)source)[-1];
        ((long *)(*target))[-1] = ((long *)source)[-1];
        /* If actual size of target string is less than allocated size, we
           may have to add it to the used pool */
        if (((long *)(*target))[-1] != ((long *)(*target))[-2]) {
          if (((long *)(*target))[-1] > ((long *)(*target))[-2]) bug(1359);
          if (((long *)(*target))[-3] == -1) {
            /* It's not already in the used pool, so add it */
            addToUsedPool(*target);
/*E*/if(db9)getPoolStats(&i1,&j1_,&k1); if(db9)printf("k0aa: pool %ld stat %ld\n",poolTotalFree,i1+j1_);
          } else {
            /* Adjust free space independently */
            poolTotalFree = poolTotalFree + poolDiff;
/*E*/if(db9)getPoolStats(&i1,&j1_,&k1); if(db9)printf("k0ab: pool %ld stat %ld\n",poolTotalFree,i1+j1_);
          }
        } else {
          if (((long *)(*target))[-3] != -1) {
            /* It's in the pool (but all allocated space coincidentally used) */
            /* Adjust free space independently */
            poolTotalFree = poolTotalFree + poolDiff;
          }
        }

/*E*/if(db9)getPoolStats(&i1,&j1_,&k1); if(db9)printf("k0a: pool %ld stat %ld\n",poolTotalFree,i1+j1_);
      } else {
        /* Free old string space and allocate new space */
        poolFree(*target);  /* Free old space */
        /* *target=poolMalloc((sourceLength + 1) * sizeof(pntrString)); */
        *target=poolMalloc((sourceLength + 1) * (long)(sizeof(pntrString)) * 2);
                        /* Allocate new space --
                            We are replacing a smaller string with a larger one;
                            assume it is growing, and allocate twice as much as
                            needed. */
        pntrCpy(*target,source);

        /* Memory pool handling */
        /* Assign actual size of target string */
        poolDiff = ((long *)(*target))[-1] - ((long *)source)[-1];
        ((long *)(*target))[-1] = ((long *)source)[-1];
        /* If actual size of target string is less than allocated size, we
           may have to add it to the used pool */
        /* (The 1st 'if' is redundant with target doubling above) */
        if (((long *)(*target))[-1] != ((long *)(*target))[-2]) {
          if (((long *)(*target))[-1] > ((long *)(*target))[-2]) bug(1360);
          if (((long *)(*target))[-3] == -1) {
            /* It's not already in the used pool, so add it */
            addToUsedPool(*target);
          } else {
            /* Adjust free space independently */
            poolTotalFree = poolTotalFree + poolDiff;
          }
        } else {
          if (((long *)(*target))[-3] != -1) {
            /* It's in the pool (but all allocated space coincidentally used) */
            /* Adjust free space independently */
            poolTotalFree = poolTotalFree + poolDiff;
          }
        }
/*E*/if(db9)getPoolStats(&i1,&j1_,&k1); if(db9)printf("k0b: pool %ld stat %ld\n",poolTotalFree,i1+j1_);
      }
    } else {    /* source is 0 length, target is not */
      poolFree(*target);
      *target= NULL_PNTRSTRING;
/*E*/if(db9)getPoolStats(&i1,&j1_,&k1); if(db9)printf("k0c: pool %ld stat %ld\n",poolTotalFree,i1+j1_);
    }
  } else {
    if (sourceLength) { /* target is 0 length, source is not */
      *target=poolMalloc((sourceLength + 1) * (long)(sizeof(pntrString)));
                        /* Allocate new space */
      pntrCpy(*target,source);
/*E*/if(db9)getPoolStats(&i1,&j1_,&k1); if(db9)printf("k0d: pool %ld stat %ld\n",poolTotalFree,i1+j1_);
    } else {    /* source and target are both 0 length */
/*E*/if(db9)getPoolStats(&i1,&j1_,&k1); if(db9)printf("k0e: pool %ld stat %ld\n",poolTotalFree,i1+j1_);
    }
  }

/*E*/if(db9)getPoolStats(&i1,&j1_,&k1); if(db9)printf("k1: pool %ld stat %ld\n",poolTotalFree,i1+j1_);
  pntrTempAlloc(0); /* Free up temporary strings used in expression computation*/
}

/* Find out the length of a pntrString */
long pntrLen(const pntrString *s) {
  /* Assume it's been allocated with poolMalloc. */
  return ((((const long *)s)[-1] - (long)(sizeof(pntrString)))
      / (long)(sizeof(pntrString)));
}

/* Find out the allocated length of a pntrString */
long pntrAllocLen(const pntrString *s) {
  return ((((long *)s)[-2] - (long)(sizeof(pntrString)))
    / (long)(sizeof(pntrString)));
}

/* Copy a string to another (pre-allocated) string */
/* Dangerous for general purpose use */

/*!
 * \brief copies a null pointer terminated \ref pntrString to a destination
 * \ref pntrString.
 *
 * This function determines the length of the source \p t by scanning for a
 * terminal null pointer element.  The destination \p s must have enough space
 * for receiving this amount of pointers, including the terminal null pointer.
 * Then the source pointers are copied beginning with that at the
 * lowest address to the destination area \p t, including the terminal null
 * pointer.
 *
 * \attention make sure the destination area pointed to by \p s has enough
 * space for the copied pointers.
 *
 * \param [out] s (not null) pointer to the target array receiving the copied
 *   pointers.  This need not necessarily be the first element of the array.
 * \param [in] t (not null) pointer to the start of the source array terminated
 *   by a null pointer.
 *
 * \pre
 *   - \p t is terminated by the first null pointer element.
 *   - the target array \p s must have enough free space to hold the source array
 *     \p t including the terminal null pointer.
 *   - \p s and \p t can overlap if \p t points to a later or same element than
 *     \p s (move left semantics).
 * \invariant
 *   If \p s is contained in a \ref pgBlock "block", its administrative header
 *   is NOT updated.
 * \warning The thoughtless use of this function has the potential to create
 *   risks mentioned in the warning of \ref pntrString.
 */
void pntrCpy(pntrString *s, const pntrString *t) {
  long i;
  i = 0;
  while (t[i] != NULL) { /* End of string -- pntrRight depends on it!! */
    s[i] = t[i];
    i++;
  }
  s[i] = t[i]; /* End of string */
}

/* Copy a string to another (pre-allocated) string */
/* Like strncpy, only the 1st n characters are copied. */
/* Dangerous for general purpose use */
void pntrNCpy(pntrString *s, const pntrString *t, long n) {
  long i;
  i = 0;
  while (t[i] != NULL) { /* End of string -- pntrSeg, pntrMid depend on it!! */
    if (i >= n) break;
    s[i] = t[i];
    i++;
  }
  s[i] = t[i]; /* End of string */
}

/* Extract leftmost n characters */
temp_pntrString *pntrLeft(const pntrString *sin, long n) {
  if (n < 0) n = 0;
  temp_pntrString *sout = pntrTempAlloc(n+1);
  pntrNCpy(sout,sin,n);
  sout[n] = *NULL_PNTRSTRING;
  return sout;
}

/* Allocate and return an "empty" string n "characters" long
   initialized to nmbrStrings instead of vStrings */
temp_pntrString *pntrNSpace(long n) {
  long j = 0;
  if (n<0) bug(1361);
  temp_pntrString *sout = pntrTempAlloc(n+1);
  while (j<n) {
    /* Initialize all fields */
    sout[j] = NULL_NMBRSTRING;
    j++;
  }
  sout[j] = *NULL_PNTRSTRING; /* Flags end of string */
  return sout;
}

/* Add a single null string element to a pntrString - faster than pntrCat */
temp_pntrString *pntrAddElement(const pntrString *g)
{
  long length = pntrLen(g);
  temp_pntrString *v = pntrTempAlloc(length + 2);
  pntrCpy(v, g);
  v[length] = "";
  v[length + 1] = *NULL_PNTRSTRING;
/*E*/if(db9)getPoolStats(&i1,&j1_,&k1); if(db9)printf("bbg3: pool %ld stat %ld\n",poolTotalFree,i1+j1_);
  return v;
}


/*******************************************************************/
/*********** Miscellaneous utility functions ***********************/
/*******************************************************************/

/* Returns 0 or 1 to indicate absence or presence of an indicator in
   the comment of the statement. */
/* mode = 1 = PROOF_DISCOURAGED means get any proof modification discouraged
                indicator
   mode = 2 = USAGE_DISCOURAGED means get any new usage discouraged indicator
   mode = 0 = RESET  means to reset everything (statemNum is ignored) */
/* TODO: add a mode to reset a single statement if in the future we add
   the ability to change the markup within the program. */
flag getMarkupFlag(long statemNum, flag mode) {
  /* For speedup, the algorithm searches a statement's comment for markup
     matches only the first time, then saves the result for subsequent calls
     for that statement. */
  static char init = 0;
  static vstring_def(commentSearchedFlags); /* Y if comment was searched */
  static vstring_def(proofFlags);  /* Y if proof discouragement, else N */
  static vstring_def(usageFlags);  /* Y if usage discouragement, else N */
  vstring_def(str1);

  if (mode == RESET) { /* Deallocate */ /* Should be called by ERASE command */
    free_vstring(commentSearchedFlags);
    free_vstring(proofFlags);
    free_vstring(usageFlags);
    init = 0;
    return 0;
  }

} /* getMarkupFlag */

/* Extract contributor or date from statement description per the
   following mode argument:

       CONTRIBUTOR 1
       CONTRIB_DATE 2
       REVISER 3
       REVISE_DATE 4
       SHORTENER 5
       SHORTEN_DATE 6
       MOST_RECENT_DATE 7

   When an item above is missing, the empty string is returned for that item.
   The following utility modes are available:

       GC_ERROR_CHECK_SILENT 8
       GC_ERROR_CHECK_PRINT 9
       GC_RESET 0
       GC_RESET_STMT 10

   For GC_ERROR_CHECK_SILENT and GC_ERROR_CHECK_PRINT, a "F" is returned if
   error-checking fails, otherwise "P" is returned.  GC_ERROR_CHECK_PRINT also
   prints the errors found.

   GC_RESET clears the cache and returns the empty string.  It is normally
   used by the ERASE command.  The stmtNum argument should be 0.  The
   empty string is returned.

   GC_RESET_STMT re-initializes the cache for the specified statement only.
   It should be called whenever the labelSection is changed e.g. by
   SAVE PROOF.  The empty string is returned.
*/
/* The caller must deallocate the returned string. */
vstring getContrib(long stmtNum, char mode) {
  /* For speedup, the algorithm searches a statement's comment for markup
     matches only the first time, then saves the result for subsequent calls
     for that statement. */
  static char init = 0;

  vstring_def(contributor);
  vstring_def(contribDate);
  vstring_def(reviser);
  vstring_def(reviseDate);
  vstring_def(shortener);
  vstring_def(shortenDate);
  vstring_def(mostRecentDate);   /* The most recent of all 3 dates */

  static vstring_def(commentSearchedFlags); /* Y if comment was searched */
  static pntrString_def(contributorList);
  static pntrString_def(contribDateList);
  static pntrString_def(reviserList);
  static pntrString_def(reviseDateList);
  static pntrString_def(shortenerList);
  static pntrString_def(shortenDateList);
  static pntrString_def(mostRecentDateList);

  long cStart = 0, cMid = 0, cEnd = 0;
  long rStart = 0, rMid = 0, rEnd = 0;
  long sStart = 0, sMid = 0, sEnd = 0;
  long firstR = 0, firstS = 0;
  vstring_def(description);
  vstring_def(tmpDate0);
  vstring_def(tmpDate1);
  vstring_def(tmpDate2);
  long stmt, p, dd, mmm, yyyy;
  flag errorCheckFlag = 0;
  flag err = 0;
  vstring_def(returnStr); /* Return value */
#define CONTRIB_MATCH " (Contributed by "
#define REVISE_MATCH " (Revised by "
#define SHORTEN_MATCH " (Proof shortened by "
#define END_MATCH ".) "

  if (mode == GC_RESET) {
    /* This is normally called by the ERASE command only */
    if (init != 0) {
      if ((long)strlen(commentSearchedFlags) != g_statements + 1) {
        bug(1395);
      }
      if (stmtNum != 0) {
        bug(1400);
      }
      for (stmt = 1; stmt <= g_statements; stmt++) {
        if (commentSearchedFlags[stmt] == 'Y') {
          /* Deallocate cached strings */
          free_vstring(*(vstring *)(&contributorList[stmt]));
          free_vstring(*(vstring *)(&contribDateList[stmt]));
          free_vstring(*(vstring *)(&reviserList[stmt]));
          free_vstring(*(vstring *)(&reviseDateList[stmt]));
          free_vstring(*(vstring *)(&shortenerList[stmt]));
          free_vstring(*(vstring *)(&shortenDateList[stmt]));
          free_vstring(*(vstring *)(&mostRecentDateList[stmt]));
        }
      }
      /* Deallocate the lists of pointers to cached strings */
      free_pntrString(contributorList);
      free_pntrString(contribDateList);
      free_pntrString(reviserList);
      free_pntrString(reviseDateList);
      free_pntrString(shortenerList);
      free_pntrString(shortenDateList);
      free_pntrString(mostRecentDateList);
      free_vstring(commentSearchedFlags);
      init = 0;
    } /* if (init != 0) */
    return "";
  }

} /* getContrib */

void freeData(void) {
  /* 15-Aug-2020 nm TODO: are some of these called twice? (in eraseSource) */
  free_vstring(g_proofDiscouragedMarkup);
  free_vstring(g_usageDiscouragedMarkup);
  free_vstring(g_contributorName);
  memFreePoolPurge(0);
  free(g_IncludeCall);
  free(g_Statement);
  free(g_MathToken);
  free(memFreePool);
  free(memUsedPool);
}
