$c \iff #SetVariable #ElementVariable #Symbol \or #Variable #Pattern \imp ( |- ) \and $.
$v ph0 ph2 ph3 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
or-is-pattern $a #Pattern ( \or ph0 ph1 ) $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
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
or-commutativity $a |- ( \iff ( \or ph0 ph1 ) ( \or ph1 ph0 ) ) $.
or-left-distributivity $a |- ( \iff ( \or ( \and ph0 ph1 ) ph2 ) ( \and ( \or ph0 ph2 ) ( \or ph1 ph2 ) ) ) $.
${ or-right-distributivity $p |- ( \iff ( \or ph0 ( \and ph1 ph2 ) ) ( \and ( \or ph0 ph1 ) ( \or ph0 ph2 ) ) ) $= ( or-is-pattern and-is-pattern rule-iff-elim-left or-commutativity rule-imp-transitivity or-left-distributivity rule-imp-compat-in-and rule-iff-elim-right rule-iff-intro ) ABCEDABDACDEABCEDBCEADABDACDEABCEDBCEADABCEGFBCEADBADCADEABDACDEBCEADBADCADEBCAIFBADABDCADACDBADABDBAGFCADACDCAGFJHHABDACDEBCEADABCEDABDACDEBADCADEBCEADABDBADACDCADABDBADABGFACDCADACGFJBCEADBADCADEBCAIKHBCEADABCEDBCEAGFHL $. $}
