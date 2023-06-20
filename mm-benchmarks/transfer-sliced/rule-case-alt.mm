$c #SetVariable #ElementVariable #Symbol \or #Variable #Pattern \imp |- ) ( $.
$v ph2 ph0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
or-is-pattern $a #Pattern ( \or ph0 ph1 ) $.
${ proof-rule-mp.0 $e |- ( \imp ph0 ph1 ) $.
   proof-rule-mp.1 $e |- ph0 $.
   proof-rule-mp $a |- ph1 $. $}
${ rule-or-elim-sugar.0 $e |- ( \imp ph0 ph2 ) $.
   rule-or-elim-sugar.1 $e |- ( \imp ph1 ph2 ) $.
   rule-or-elim-sugar $a |- ( \imp ( \or ph0 ph1 ) ph2 ) $. $}
${ rule-case-alt.0 $e |- ( \or ph0 ph1 ) $.
   rule-case-alt.1 $e |- ( \imp ph0 ph2 ) $.
   rule-case-alt.2 $e |- ( \imp ph1 ph2 ) $.
   rule-case-alt $p |- ph2 $= ( or-is-pattern rule-or-elim-sugar proof-rule-mp ) ABGCABCEFHDI $. $}
