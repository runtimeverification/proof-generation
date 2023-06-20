$c \iff #SetVariable #ElementVariable #Symbol \or #Variable #Pattern \imp ( |- ) \and $.
$v ph0 ph2 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
or-is-pattern $a #Pattern ( \or ph0 ph1 ) $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
and-elim-left-sugar $a |- ( \imp ( \and ph0 ph1 ) ph0 ) $.
and-elim-right-sugar $a |- ( \imp ( \and ph0 ph1 ) ph1 ) $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
or-intro-left-sugar $a |- ( \imp ph0 ( \or ph0 ph1 ) ) $.
or-intro-right-sugar $a |- ( \imp ph0 ( \or ph1 ph0 ) ) $.
${ rule-or-elim-sugar.0 $e |- ( \imp ph0 ph2 ) $.
   rule-or-elim-sugar.1 $e |- ( \imp ph1 ph2 ) $.
   rule-or-elim-sugar $a |- ( \imp ( \or ph0 ph1 ) ph2 ) $. $}
${ rule-iff-intro.0 $e |- ( \imp ph0 ph1 ) $.
   rule-iff-intro.1 $e |- ( \imp ph1 ph0 ) $.
   rule-iff-intro $a |- ( \iff ph0 ph1 ) $. $}
or-left-distributivity-right $a |- ( \imp ( \and ( \or ph0 ph2 ) ( \or ph1 ph2 ) ) ( \or ( \and ph0 ph1 ) ph2 ) ) $.
${ or-left-distributivity $p |- ( \iff ( \or ( \and ph0 ph1 ) ph2 ) ( \and ( \or ph0 ph2 ) ( \or ph1 ph2 ) ) ) $= ( or-is-pattern and-is-pattern or-intro-left-sugar rule-imp-transitivity rule-and-intro-alt2-sugar or-intro-right-sugar and-elim-left-sugar and-elim-right-sugar rule-or-elim-sugar or-left-distributivity-right rule-iff-intro ) ABECDACDBCDEABECACDBCDEABEACDBCDABEAACDABJACFGABEBBCDABKBCFGHCACDBCDCAICBIHLABCMN $. $}
