$c #Notation #SetVariable #ElementVariable #Symbol #Variable #Pattern \kore-symbol-LblList'Coln'range \kore-symbol-LblList'Coln'range-symbol \app ) ( $.
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
ptn0-pattern $f #Pattern ptn0 $.
ptn1-pattern $f #Pattern ptn1 $.
ptn2-pattern $f #Pattern ptn2 $.
IMP-symbol-140-is-symbol $a #Symbol \kore-symbol-LblList'Coln'range-symbol $.
IMP-symbol-140-is-pattern $a #Pattern ( \kore-symbol-LblList'Coln'range ptn0 ptn1 ptn2 ) $.
IMP-symbol-140-is-sugar $a #Notation ( \kore-symbol-LblList'Coln'range ptn0 ptn1 ptn2 ) ( \app ( \app ( \app \kore-symbol-LblList'Coln'range-symbol ptn0 ) ptn1 ) ptn2 ) $.
${ notation-cache-189 $p #Notation ( \kore-symbol-LblList'Coln'range ptn0 ptn1 ptn2 ) ( \app ( \app ( \app \kore-symbol-LblList'Coln'range-symbol ptn0 ) ptn1 ) ptn2 ) $= ( app-is-pattern IMP-symbol-140-is-symbol symbol-is-pattern notation-reflexivity notation-app IMP-symbol-140-is-pattern IMP-symbol-140-is-sugar notation-transitivity ) ABCIEFADBDCDEFADBDCDABCJEFADBDCEFADBDCEFADBEFADBEFAEFAEFGAGHBGHCGHK $. $}
