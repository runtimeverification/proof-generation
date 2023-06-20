$c \iff #SetVariable #ElementVariable #Symbol #Variable #Pattern \imp |- \not ) ( $.
$v ph0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
not-is-pattern $a #Pattern ( \not ph0 ) $.
${ rule-iff-elim-left.0 $e |- ( \iff ph0 ph1 ) $.
   rule-iff-elim-left $a |- ( \imp ph0 ph1 ) $. $}
double-negation $a |- ( \iff ( \not ( \not ph0 ) ) ph0 ) $.
${ dn-elim-sugar $p |- ( \imp ( \not ( \not ph0 ) ) ph0 ) $= ( not-is-pattern double-negation rule-iff-elim-left ) ABBAACD $. $}
