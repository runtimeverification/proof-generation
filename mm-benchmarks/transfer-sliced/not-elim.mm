$c #SetVariable #ElementVariable #Symbol #Variable #Pattern \imp |- \bot ) ( $.
$v ph0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
bot-is-pattern $a #Pattern \bot $.
mp $a |- ( \imp ph0 ( \imp ( \imp ph0 ph1 ) ph1 ) ) $.
${ not-elim $p |- ( \imp ph0 ( \imp ( \imp ph0 \bot ) \bot ) ) $= ( bot-is-pattern mp ) ABC $. $}
