$c #SetVariable #ElementVariable #Symbol #Variable #Pattern \imp |- \bot \not ) ( $.
$v ph0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
bot-is-pattern $a #Pattern \bot $.
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
not-is-pattern $a #Pattern ( \not ph0 ) $.
${ proof-rule-mp.0 $e |- ( \imp ph0 ph1 ) $.
   proof-rule-mp.1 $e |- ph0 $.
   proof-rule-mp $a |- ph1 $. $}
contradiction $a |- ( \imp ( \imp ( \not ph0 ) \bot ) ph0 ) $.
${ rule-contradiction.0 $e |- ( \imp ( \not ph0 ) \bot ) $.
   rule-contradiction $p |- ph0 $= ( not-is-pattern bot-is-pattern imp-is-pattern contradiction proof-rule-mp ) ACDEAAFBG $. $}
