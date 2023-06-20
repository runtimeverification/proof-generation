$c \iff #SetVariable #ElementVariable #Symbol \eq #Variable #Pattern \imp ( |- \not ) \and $.
$v ph0 ph2 ph3 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
not-is-pattern $a #Pattern ( \not ph0 ) $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
${ proof-rule-mp.0 $e |- ( \imp ph0 ph1 ) $.
   proof-rule-mp.1 $e |- ph0 $.
   proof-rule-mp $a |- ph1 $. $}
${ rule-contrapositive-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-contrapositive-sugar $a |- ( \imp ( \not ph1 ) ( \not ph0 ) ) $. $}
${ rule-iff-elim-left.0 $e |- ( \iff ph0 ph1 ) $.
   rule-iff-elim-left $a |- ( \imp ph0 ph1 ) $. $}
${ rule-iff-compat-in-and.0 $e |- ( \iff ph0 ph1 ) $.
   rule-iff-compat-in-and.1 $e |- ( \iff ph2 ph3 ) $.
   rule-iff-compat-in-and $a |- ( \iff ( \and ph0 ph2 ) ( \and ph1 ph3 ) ) $. $}
${ rule-eq-to-iff.0 $e |- ( \eq ph0 ph1 ) $.
   rule-eq-to-iff $a |- ( \iff ph0 ph1 ) $. $}
${ disjointness-eq.0 $e |- ( \eq ph0 ph2 ) $.
   disjointness-eq.1 $e |- ( \eq ph1 ph3 ) $.
   disjointness-eq.2 $e |- ( \not ( \and ph2 ph3 ) ) $.
   disjointness-eq $p |- ( \not ( \and ph0 ph1 ) ) $= ( and-is-pattern not-is-pattern rule-eq-to-iff rule-iff-compat-in-and rule-iff-elim-left rule-contrapositive-sugar proof-rule-mp ) CDHIABHIABHCDHABHCDHACBDACEJBDFJKLMGN $. $}
