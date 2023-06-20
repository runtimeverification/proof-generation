$c \iff #SetVariable #ElementVariable #Symbol #Variable #Pattern \and \imp |- \bot \not ) ( $.
$v ph0 ph2 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
bot-is-pattern $a #Pattern \bot $.
not-is-pattern $a #Pattern ( \not ph0 ) $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
${ rule-iff-elim-left.0 $e |- ( \iff ph0 ph1 ) $.
   rule-iff-elim-left $a |- ( \imp ph0 ph1 ) $. $}
${ rule-iff-elim-right.0 $e |- ( \iff ph0 ph1 ) $.
   rule-iff-elim-right $a |- ( \imp ph1 ph0 ) $. $}
bot-to-and $a |- ( \iff \bot ( \and ph0 ( \not ph0 ) ) ) $.
and-commutativity $a |- ( \iff ( \and ph0 ph1 ) ( \and ph1 ph0 ) ) $.
${ resolution-1 $p |- ( \imp ( \and ( \not ph0 ) ph0 ) \bot ) $= ( not-is-pattern and-is-pattern bot-is-pattern and-commutativity rule-iff-elim-left bot-to-and rule-iff-elim-right rule-imp-transitivity ) ABACAABCDABACAABCABAEFDAABCAGHI $. $}
