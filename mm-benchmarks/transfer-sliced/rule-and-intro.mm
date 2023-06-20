$c #SetVariable #ElementVariable #Symbol #Variable #Pattern \imp |- \bot ) ( $.
$v ph0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
bot-is-pattern $a #Pattern \bot $.
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
${ proof-rule-mp.0 $e |- ( \imp ph0 ph1 ) $.
   proof-rule-mp.1 $e |- ph0 $.
   proof-rule-mp $a |- ph1 $. $}
and-intro $a |- ( \imp ph0 ( \imp ph1 ( \imp ( \imp ( \imp ( \imp ph0 \bot ) \bot ) ( \imp ph1 \bot ) ) \bot ) ) ) $.
${ rule-and-intro.0 $e |- ph0 $.
   rule-and-intro.1 $e |- ph1 $.
   rule-and-intro $p |- ( \imp ( \imp ( \imp ( \imp ph0 \bot ) \bot ) ( \imp ph1 \bot ) ) \bot ) $= ( imp-is-pattern bot-is-pattern proof-rule-mp and-intro ) BAFEFEBFEEFEABAFEFEBFEEFEEABHCGDG $. $}
