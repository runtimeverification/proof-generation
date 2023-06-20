$c #Notation #SetVariable #ElementVariable #Symbol \kore-symbol-Lbl'UndsEqlsSlshEqls'Int'Unds'-symbol #Variable #Pattern \kore-symbol-Lbl'UndsEqlsSlshEqls'Int'Unds' \app ) ( $.
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
IMP-symbol-177-is-symbol $a #Symbol \kore-symbol-Lbl'UndsEqlsSlshEqls'Int'Unds'-symbol $.
IMP-symbol-177-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsEqlsSlshEqls'Int'Unds' ptn0 ptn1 ) $.
IMP-symbol-177-is-sugar $a #Notation ( \kore-symbol-Lbl'UndsEqlsSlshEqls'Int'Unds' ptn0 ptn1 ) ( \app ( \app \kore-symbol-Lbl'UndsEqlsSlshEqls'Int'Unds'-symbol ptn0 ) ptn1 ) $.
${ notation-cache-297 $p #Notation ( \kore-symbol-Lbl'UndsEqlsSlshEqls'Int'Unds' ptn3 ptn4 ) ( \app ( \app \kore-symbol-Lbl'UndsEqlsSlshEqls'Int'Unds'-symbol ptn3 ) ptn4 ) $= ( app-is-pattern IMP-symbol-177-is-symbol symbol-is-pattern IMP-symbol-177-is-pattern IMP-symbol-177-is-sugar notation-reflexivity notation-transitivity ) ABFDEACBCDEACBCABGDEACBCHI $. $}
