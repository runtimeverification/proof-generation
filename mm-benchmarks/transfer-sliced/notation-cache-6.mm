$c #Notation #SetVariable #ElementVariable #Symbol #Variable #Pattern \kore-inj-symbol \app ) \kore-inj ( $.
$v ph0 ph2 sg0 ptn1 ptn2 ph3 ptn0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
sg0-is-symbol $f #Symbol sg0 $.
symbol-is-pattern $a #Pattern sg0 $.
app-is-pattern $a #Pattern ( \app ph0 ph1 ) $.
notation-reflexivity $a #Notation ph0 ph0 $.
${ notation-transitivity.0 $e #Notation ph0 ph1 $.
   notation-transitivity.1 $e #Notation ph1 ph2 $.
   notation-transitivity $a #Notation ph0 ph2 $. $}
${ notation-app.0 $e #Notation ph0 ph2 $.
   notation-app.1 $e #Notation ph1 ph3 $.
   notation-app $a #Notation ( \app ph0 ph1 ) ( \app ph2 ph3 ) $. $}
kore-inj-is-symbol $a #Symbol \kore-inj-symbol $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
kore-inj-is-sugar $a #Notation ( \kore-inj ph0 ph1 ph2 ) ( \app ( \app ( \app \kore-inj-symbol ph0 ) ph1 ) ph2 ) $.
ptn0-pattern $f #Pattern ptn0 $.
ptn1-pattern $f #Pattern ptn1 $.
ptn2-pattern $f #Pattern ptn2 $.
${ notation-cache-6 $p #Notation ( \kore-inj ptn0 ptn1 ptn2 ) ( \app ( \app ( \app \kore-inj-symbol ptn0 ) ptn1 ) ptn2 ) $= ( app-is-pattern kore-inj-is-symbol symbol-is-pattern notation-reflexivity notation-app kore-inj-is-pattern kore-inj-is-sugar notation-transitivity ) ABCIEFADBDCDEFADBDCDABCJEFADBDCEFADBDCEFADBEFADBEFAEFAEFGAGHBGHCGHK $. $}
