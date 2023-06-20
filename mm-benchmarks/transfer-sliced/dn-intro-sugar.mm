$c \iff #SetVariable #ElementVariable #Symbol #Variable #Pattern \imp |- \not ) ( $.
$v ph0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
not-is-pattern $a #Pattern ( \not ph0 ) $.
${ rule-iff-elim-right.0 $e |- ( \iff ph0 ph1 ) $.
   rule-iff-elim-right $a |- ( \imp ph1 ph0 ) $. $}
double-negation $a |- ( \iff ( \not ( \not ph0 ) ) ph0 ) $.
${ dn-intro-sugar $p |- ( \imp ph0 ( \not ( \not ph0 ) ) ) $= ( not-is-pattern double-negation rule-iff-elim-right ) ABBAACD $. $}
