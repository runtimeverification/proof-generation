$c \iff #SetVariable #ElementVariable #Symbol #Variable #Pattern \imp |- ) ( $.
$v ph0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
${ rule-iff-intro.0 $e |- ( \imp ph0 ph1 ) $.
   rule-iff-intro.1 $e |- ( \imp ph1 ph0 ) $.
   rule-iff-intro $a |- ( \iff ph0 ph1 ) $. $}
${ rule-iff-elim-left.0 $e |- ( \iff ph0 ph1 ) $.
   rule-iff-elim-left $a |- ( \imp ph0 ph1 ) $. $}
${ rule-iff-elim-right.0 $e |- ( \iff ph0 ph1 ) $.
   rule-iff-elim-right $a |- ( \imp ph1 ph0 ) $. $}
${ rule-iff-symmetry.0 $e |- ( \iff ph0 ph1 ) $.
   rule-iff-symmetry $p |- ( \iff ph1 ph0 ) $= ( rule-iff-elim-right rule-iff-elim-left rule-iff-intro ) BAABCDABCEF $. $}
