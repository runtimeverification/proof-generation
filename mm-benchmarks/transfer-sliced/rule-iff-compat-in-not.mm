$c \iff #SetVariable #ElementVariable #Symbol #Variable #Pattern \imp |- \not ) ( $.
$v ph0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
not-is-pattern $a #Pattern ( \not ph0 ) $.
${ rule-iff-intro.0 $e |- ( \imp ph0 ph1 ) $.
   rule-iff-intro.1 $e |- ( \imp ph1 ph0 ) $.
   rule-iff-intro $a |- ( \iff ph0 ph1 ) $. $}
${ rule-contrapositive-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-contrapositive-sugar $a |- ( \imp ( \not ph1 ) ( \not ph0 ) ) $. $}
${ rule-iff-elim-left.0 $e |- ( \iff ph0 ph1 ) $.
   rule-iff-elim-left $a |- ( \imp ph0 ph1 ) $. $}
${ rule-iff-elim-right.0 $e |- ( \iff ph0 ph1 ) $.
   rule-iff-elim-right $a |- ( \imp ph1 ph0 ) $. $}
${ rule-iff-compat-in-not.0 $e |- ( \iff ph0 ph1 ) $.
   rule-iff-compat-in-not $p |- ( \iff ( \not ph0 ) ( \not ph1 ) ) $= ( not-is-pattern rule-contrapositive-sugar rule-iff-elim-right rule-iff-elim-left rule-iff-intro ) ADBDBAABCFEABABCGEH $. $}
