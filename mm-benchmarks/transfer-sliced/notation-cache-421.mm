$c #Notation #SetVariable #ElementVariable #Symbol \kore-symbol-Lbl'UndsPipeUndsPipeUnds'IMP-SYNTAX'Unds'AExp'Unds'Id'Unds'Id-symbol #Variable #Pattern \kore-symbol-Lbl'UndsPipeUndsPipeUnds'IMP-SYNTAX'Unds'AExp'Unds'Id'Unds'Id \app ) ( $.
$v ph0 ph2 ptn4 sg0 ptn1 ptn3 ptn0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
sg0-is-symbol $f #Symbol sg0 $.
symbol-is-pattern $a #Pattern sg0 $.
app-is-pattern $a #Pattern ( \app ph0 ph1 ) $.
notation-reflexivity $a #Notation ph0 ph0 $.
${ notation-transitivity.0 $e #Notation ph0 ph1 $.
   notation-transitivity.1 $e #Notation ph1 ph2 $.
   notation-transitivity $a #Notation ph0 ph2 $. $}
ptn0-pattern $f #Pattern ptn0 $.
ptn1-pattern $f #Pattern ptn1 $.
ptn3-pattern $f #Pattern ptn3 $.
ptn4-pattern $f #Pattern ptn4 $.
IMP-symbol-221-is-symbol $a #Symbol \kore-symbol-Lbl'UndsPipeUndsPipeUnds'IMP-SYNTAX'Unds'AExp'Unds'Id'Unds'Id-symbol $.
IMP-symbol-221-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsPipeUndsPipeUnds'IMP-SYNTAX'Unds'AExp'Unds'Id'Unds'Id ptn0 ptn1 ) $.
IMP-symbol-221-is-sugar $a #Notation ( \kore-symbol-Lbl'UndsPipeUndsPipeUnds'IMP-SYNTAX'Unds'AExp'Unds'Id'Unds'Id ptn0 ptn1 ) ( \app ( \app \kore-symbol-Lbl'UndsPipeUndsPipeUnds'IMP-SYNTAX'Unds'AExp'Unds'Id'Unds'Id-symbol ptn0 ) ptn1 ) $.
${ notation-cache-421 $p #Notation ( \kore-symbol-Lbl'UndsPipeUndsPipeUnds'IMP-SYNTAX'Unds'AExp'Unds'Id'Unds'Id ptn3 ptn4 ) ( \app ( \app \kore-symbol-Lbl'UndsPipeUndsPipeUnds'IMP-SYNTAX'Unds'AExp'Unds'Id'Unds'Id-symbol ptn3 ) ptn4 ) $= ( app-is-pattern IMP-symbol-221-is-symbol symbol-is-pattern IMP-symbol-221-is-pattern IMP-symbol-221-is-sugar notation-reflexivity notation-transitivity ) ABFDEACBCDEACBCABGDEACBCHI $. $}
