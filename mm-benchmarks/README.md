# Metamath benchmark files

The following is a list of the Metamath benchmark files in the order of their
complexity:


1.  `wff.mm`: an 8-line proof that a formula is well-defined;
2.  `reflexivity.mm`: the proof of `ph -> ph`;
3.  `simple.mm`: the proof of `t = t`;
4.  `matching-logic-200-loc.mm`: the definition of matching logic in Metamath;
5.  `peano.mm`: Peano arithmetics;
6.  `sum.mm`: an example proof object generated from K.
7.  `transfer.mm`: a proof of execution for a ERC20 like transfer function
    implemented in IMP.
8.  `transfer-sliced/*.mm`: a "sliced" version of the same transfer program.
    `transfer-sliced/goal.mm` contains the main goal.
9.  `transfer-indexed/*.mm`: Identical to above, except each lemma and constant
    is assigned an index, and then renamed to an identifier based on that index.
10.  `transfer-compressed/*.mm`: Identical to above, compressed.
