$c \iff #SetVariable #ElementVariable #Symbol \or #Variable #Pattern \imp ( |- \not ) \and $.
$v ph0 ph2 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
not-is-pattern $a #Pattern ( \not ph0 ) $.
or-is-pattern $a #Pattern ( \or ph0 ph1 ) $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
${ proof-rule-mp.0 $e |- ( \imp ph0 ph1 ) $.
   proof-rule-mp.1 $e |- ph0 $.
   proof-rule-mp $a |- ph1 $. $}
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
${ rule-and-intro-sugar.0 $e |- ph0 $.
   rule-and-intro-sugar.1 $e |- ph1 $.
   rule-and-intro-sugar $a |- ( \and ph0 ph1 ) $. $}
${ rule-contrapositive-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-contrapositive-sugar $a |- ( \imp ( \not ph1 ) ( \not ph0 ) ) $. $}
${ rule-iff-elim-left.0 $e |- ( \iff ph0 ph1 ) $.
   rule-iff-elim-left $a |- ( \imp ph0 ph1 ) $. $}
${ rule-iff-elim-right.0 $e |- ( \iff ph0 ph1 ) $.
   rule-iff-elim-right $a |- ( \imp ph1 ph0 ) $. $}
and-commutativity $a |- ( \iff ( \and ph0 ph1 ) ( \and ph1 ph0 ) ) $.
de-morgan-or $a |- ( \iff ( \not ( \or ph0 ph1 ) ) ( \and ( \not ph0 ) ( \not ph1 ) ) ) $.
and-left-distributivity $a |- ( \iff ( \and ( \or ph0 ph1 ) ph2 ) ( \or ( \and ph0 ph2 ) ( \and ph1 ph2 ) ) ) $.
${ disjointness-symmetry.0 $e |- ( \not ( \and ph0 ph1 ) ) $.
   disjointness-symmetry $a |- ( \not ( \and ph1 ph0 ) ) $. $}
${ disjointness-case.0 $e |- ( \not ( \and ph0 ph1 ) ) $.
   disjointness-case.1 $e |- ( \not ( \and ph0 ph2 ) ) $.
   disjointness-case $p |- ( \not ( \and ph0 ( \or ph1 ph2 ) ) ) $= ( and-is-pattern or-is-pattern not-is-pattern rule-iff-elim-left disjointness-symmetry proof-rule-mp and-commutativity and-left-distributivity rule-imp-transitivity rule-contrapositive-sugar de-morgan-or rule-iff-elim-right rule-and-intro-sugar ) BAFCAFGHABCGFHABCGFBAFCAFGABCGFBCGAFBAFCAFGABCGFBCGAFABCGLIBCGAFBAFCAFGBCAMINOBAFHCAFHFBAFCAFGHBAFCAFGHBAFHCAFHFBAFCAFPQBAFHCAFHABDJACEJRKK $. $}
