$c \iff #SetVariable #ElementVariable #Symbol \or #Variable #Pattern \imp |- ) ( $.
$v ph0 ph2 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
or-is-pattern $a #Pattern ( \or ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
or-intro-left-sugar $a |- ( \imp ph0 ( \or ph0 ph1 ) ) $.
or-intro-right-sugar $a |- ( \imp ph0 ( \or ph1 ph0 ) ) $.
${ rule-or-elim-sugar.0 $e |- ( \imp ph0 ph2 ) $.
   rule-or-elim-sugar.1 $e |- ( \imp ph1 ph2 ) $.
   rule-or-elim-sugar $a |- ( \imp ( \or ph0 ph1 ) ph2 ) $. $}
${ rule-iff-intro.0 $e |- ( \imp ph0 ph1 ) $.
   rule-iff-intro.1 $e |- ( \imp ph1 ph0 ) $.
   rule-iff-intro $a |- ( \iff ph0 ph1 ) $. $}
${ or-associativity $p |- ( \iff ( \or ( \or ph0 ph1 ) ph2 ) ( \or ph0 ( \or ph1 ph2 ) ) ) $= ( or-is-pattern or-intro-left-sugar or-intro-right-sugar rule-imp-transitivity rule-or-elim-sugar rule-iff-intro ) ABDCDABCDDABDCABCDDABABCDDABCDEBBCDABCDDBCEBCDAFGHCBCDABCDDCBFBCDAFGHABCDABDCDAABDABDCDABEABDCEGBCABDCDBABDABDCDBAFABDCEGCABDFHHI $. $}
