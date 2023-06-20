$c \iff #SetVariable #ElementVariable #Symbol \or #Variable #Pattern \imp |- ) ( $.
$v ph0 ph2 ph3 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
or-is-pattern $a #Pattern ( \or ph0 ph1 ) $.
${ rule-iff-intro.0 $e |- ( \imp ph0 ph1 ) $.
   rule-iff-intro.1 $e |- ( \imp ph1 ph0 ) $.
   rule-iff-intro $a |- ( \iff ph0 ph1 ) $. $}
${ rule-imp-compat-in-or.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-compat-in-or.1 $e |- ( \imp ph2 ph3 ) $.
   rule-imp-compat-in-or $a |- ( \imp ( \or ph0 ph2 ) ( \or ph1 ph3 ) ) $. $}
${ rule-iff-elim-left.0 $e |- ( \iff ph0 ph1 ) $.
   rule-iff-elim-left $a |- ( \imp ph0 ph1 ) $. $}
${ rule-iff-elim-right.0 $e |- ( \iff ph0 ph1 ) $.
   rule-iff-elim-right $a |- ( \imp ph1 ph0 ) $. $}
${ rule-iff-compat-in-or.0 $e |- ( \iff ph0 ph1 ) $.
   rule-iff-compat-in-or.1 $e |- ( \iff ph2 ph3 ) $.
   rule-iff-compat-in-or $p |- ( \iff ( \or ph0 ph2 ) ( \or ph1 ph3 ) ) $= ( or-is-pattern rule-iff-elim-left rule-imp-compat-in-or rule-iff-elim-right rule-iff-intro ) ACGBDGABCDABEHCDFHIBADCABEJCDFJIK $. $}
