$c \iff #SetVariable #ElementVariable #Symbol #Variable #Pattern \imp ( |- ) \and $.
$v ph0 ph2 ph3 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
${ rule-iff-intro.0 $e |- ( \imp ph0 ph1 ) $.
   rule-iff-intro.1 $e |- ( \imp ph1 ph0 ) $.
   rule-iff-intro $a |- ( \iff ph0 ph1 ) $. $}
${ rule-imp-compat-in-and.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-compat-in-and.1 $e |- ( \imp ph2 ph3 ) $.
   rule-imp-compat-in-and $a |- ( \imp ( \and ph0 ph2 ) ( \and ph1 ph3 ) ) $. $}
${ rule-iff-elim-left.0 $e |- ( \iff ph0 ph1 ) $.
   rule-iff-elim-left $a |- ( \imp ph0 ph1 ) $. $}
${ rule-iff-elim-right.0 $e |- ( \iff ph0 ph1 ) $.
   rule-iff-elim-right $a |- ( \imp ph1 ph0 ) $. $}
${ rule-iff-compat-in-and.0 $e |- ( \iff ph0 ph1 ) $.
   rule-iff-compat-in-and.1 $e |- ( \iff ph2 ph3 ) $.
   rule-iff-compat-in-and $p |- ( \iff ( \and ph0 ph2 ) ( \and ph1 ph3 ) ) $= ( and-is-pattern rule-iff-elim-left rule-imp-compat-in-and rule-iff-elim-right rule-iff-intro ) ACGBDGABCDABEHCDFHIBADCABEJCDFJIK $. $}
