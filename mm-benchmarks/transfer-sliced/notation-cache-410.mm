$c #Notation #SetVariable #ElementVariable #Symbol #Variable #Pattern \kore-symbol-Lbl'Unds'xorInt'Unds' \app ) \kore-symbol-Lbl'Unds'xorInt'Unds'-symbol ( $.
$v ph0 ph2 sg0 ptn1 ph3 ptn0 ph1 $.
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
IMP-symbol-217-is-symbol $a #Symbol \kore-symbol-Lbl'Unds'xorInt'Unds'-symbol $.
IMP-symbol-217-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds'xorInt'Unds' ptn0 ptn1 ) $.
IMP-symbol-217-is-sugar $a #Notation ( \kore-symbol-Lbl'Unds'xorInt'Unds' ptn0 ptn1 ) ( \app ( \app \kore-symbol-Lbl'Unds'xorInt'Unds'-symbol ptn0 ) ptn1 ) $.
${ notation-cache-410 $p #Notation ( \kore-symbol-Lbl'Unds'xorInt'Unds' ptn0 ptn1 ) ( \app ( \app \kore-symbol-Lbl'Unds'xorInt'Unds'-symbol ptn0 ) ptn1 ) $= ( IMP-symbol-217-is-symbol symbol-is-pattern app-is-pattern notation-reflexivity notation-app IMP-symbol-217-is-pattern IMP-symbol-217-is-sugar notation-transitivity ) ABHCDAEBECDAEBEABICDAEBCDAEBCDACDACDFAFGBFGJ $. $}
