$c \iff \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \imp ( |- ) \and $.
$v ph0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
${ proof-rule-mp.0 $e |- ( \imp ph0 ph1 ) $.
   proof-rule-mp.1 $e |- ph0 $.
   proof-rule-mp $a |- ph1 $. $}
top-is-pattern $a #Pattern \top $.
top-intro $a |- \top $.
and-elim-right-sugar $a |- ( \imp ( \and ph0 ph1 ) ph1 ) $.
and-intro-sugar $a |- ( \imp ph0 ( \imp ph1 ( \and ph0 ph1 ) ) ) $.
${ rule-iff-intro.0 $e |- ( \imp ph0 ph1 ) $.
   rule-iff-intro.1 $e |- ( \imp ph1 ph0 ) $.
   rule-iff-intro $a |- ( \iff ph0 ph1 ) $. $}
${ and-top $p |- ( \iff ( \and \top ph0 ) ph0 ) $= ( top-is-pattern and-is-pattern and-elim-right-sugar imp-is-pattern and-intro-sugar top-intro proof-rule-mp rule-iff-intro ) BACABADBABACEBAFGHI $. $}
