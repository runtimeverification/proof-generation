$c #SetVariable #ElementVariable #Symbol #Variable #Pattern \imp |- \bot ) ( $.
$v ph0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
bot-is-pattern $a #Pattern \bot $.
${ proof-rule-mp.0 $e |- ( \imp ph0 ph1 ) $.
   proof-rule-mp.1 $e |- ph0 $.
   proof-rule-mp $a |- ph1 $. $}
bot-elim $a |- ( \imp \bot ph0 ) $.
${ rule-bot-elim.0 $e |- \bot $.
   rule-bot-elim $p |- ph0 $= ( bot-is-pattern bot-elim proof-rule-mp ) CAADBE $. $}
