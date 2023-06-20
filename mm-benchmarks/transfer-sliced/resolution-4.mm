$c \iff #SetVariable #ElementVariable #Symbol \or #Variable #Pattern \and \imp |- \not ) ( $.
$v ph0 ph2 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
not-is-pattern $a #Pattern ( \not ph0 ) $.
or-is-pattern $a #Pattern ( \or ph0 ph1 ) $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
and-elim-left-sugar $a |- ( \imp ( \and ph0 ph1 ) ph0 ) $.
or-intro-left-sugar $a |- ( \imp ph0 ( \or ph0 ph1 ) ) $.
or-intro-right-sugar $a |- ( \imp ph0 ( \or ph1 ph0 ) ) $.
${ rule-or-elim-sugar.0 $e |- ( \imp ph0 ph2 ) $.
   rule-or-elim-sugar.1 $e |- ( \imp ph1 ph2 ) $.
   rule-or-elim-sugar $a |- ( \imp ( \or ph0 ph1 ) ph2 ) $. $}
${ rule-iff-elim-left.0 $e |- ( \iff ph0 ph1 ) $.
   rule-iff-elim-left $a |- ( \imp ph0 ph1 ) $. $}
and-left-distributivity $a |- ( \iff ( \and ( \or ph0 ph1 ) ph2 ) ( \or ( \and ph0 ph2 ) ( \and ph1 ph2 ) ) ) $.
resolution-3 $a |- ( \imp ( \and ( \not ph0 ) ( \or ph0 ph1 ) ) ph1 ) $.
${ resolution-4 $p |- ( \imp ( \and ( \or ( \not ph0 ) ph1 ) ( \or ph0 ph2 ) ) ( \or ph1 ph2 ) ) $= ( or-is-pattern and-is-pattern not-is-pattern rule-imp-transitivity and-left-distributivity rule-iff-elim-left resolution-3 or-intro-right-sugar and-elim-left-sugar or-intro-left-sugar rule-or-elim-sugar ) AFBDACDEAFACDEBACDEDBCDAFBDACDEAFACDEBACDEDAFBACDHIAFACDEBACDEBCDAFACDECBCDACJCBKGBACDEBBCDBACDLBCMGNG $. $}
