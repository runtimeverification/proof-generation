# Metamath benchmark files

The following is a list of the Metamath benchmark files in the order of their complexity:

1.  `wff.mm`: an 8-line proof that a formula is well-defined;
2.  `reflexivity.mm`: the proof of `ph -> ph`;
3.  `simple.mm`: the proof of `t = t`;
4.  `matching-logic-200-loc.mm`: the definition of matching logic in Metamath;
5.  `peano.mm`: Peano arithmetics;
6.  `sum.mm`: an example proof object generated from K.
7.  `transfer.mm`: a proof of the execution goal for a ERC20 like transfer function implemented in IMP.
8.  `transfer-sliced.tar.gz`: a "sliced" version of the same transfer program. `goal.mm` contains the main goal.
9.  `transfer-compressed.tar.gz`: Identical to above, additionally, lemma and constant names are compressed, proofs compressed using official Metamath.
10. `transfer-goal.mm`: uncompressed version of the main goal in `transfer-compressed.tar.gz`.
11. `transfer-largest-slice.mm`: uncompressed version of the largest goal in `transfer-compressed.tar.gz`.
12. `transfer5000.mm`: a proof of the execution goal for a batch of 50000 ERC20 like transfer functions implemented in IMP.
12. `svm5.mm`: a proof of the execution goal for a support vector machine over 5 fixed inputs implemented in IMP.
13. `perceptron.mm`: a proof of the execution goal for a perceptron over 5 fixed inputs implemented in IMP.
14. `impreflex.mm`: a proof of phi -> phi in MM formalization of matching logic
