$c \iff #SetVariable #ElementVariable #Symbol #Variable #Pattern \imp ( |- \not ) \and $.
$v ph0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
not-is-pattern $a #Pattern ( \not ph0 ) $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
${ proof-rule-mp.0 $e |- ( \imp ph0 ph1 ) $.
   proof-rule-mp.1 $e |- ph0 $.
   proof-rule-mp $a |- ph1 $. $}
${ rule-contrapositive-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-contrapositive-sugar $a |- ( \imp ( \not ph1 ) ( \not ph0 ) ) $. $}
${ rule-iff-elim-left.0 $e |- ( \iff ph0 ph1 ) $.
   rule-iff-elim-left $a |- ( \imp ph0 ph1 ) $. $}
and-commutativity $a |- ( \iff ( \and ph0 ph1 ) ( \and ph1 ph0 ) ) $.
${ disjointness-symmetry.0 $e |- ( \not ( \and ph0 ph1 ) ) $.
   disjointness-symmetry $p |- ( \not ( \and ph1 ph0 ) ) $= ( and-is-pattern not-is-pattern and-commutativity rule-iff-elim-left rule-contrapositive-sugar proof-rule-mp ) ABDEBADEBADABDBADABDBAFGHCI $. $}
