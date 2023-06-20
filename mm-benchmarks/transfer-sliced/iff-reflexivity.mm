$c \iff #SetVariable #ElementVariable #Symbol #Variable #Pattern \imp |- ) ( $.
$v ph0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
imp-reflexivity $a |- ( \imp ph0 ph0 ) $.
${ rule-iff-intro.0 $e |- ( \imp ph0 ph1 ) $.
   rule-iff-intro.1 $e |- ( \imp ph1 ph0 ) $.
   rule-iff-intro $a |- ( \iff ph0 ph1 ) $. $}
${ iff-reflexivity $p |- ( \iff ph0 ph0 ) $= ( imp-reflexivity rule-iff-intro ) AAABABC $. $}
