$c #Notation #SetVariable \kore-symbol-Lblint'UndsSClnUndsUnds'IMP-SYNTAX'Unds'Pgm'Unds'Ids'Unds'Stmt-symbol #ElementVariable #Symbol #Variable #Pattern \kore-symbol-Lblint'UndsSClnUndsUnds'IMP-SYNTAX'Unds'Pgm'Unds'Ids'Unds'Stmt \app ) ( $.
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
IMP-symbol-247-is-symbol $a #Symbol \kore-symbol-Lblint'UndsSClnUndsUnds'IMP-SYNTAX'Unds'Pgm'Unds'Ids'Unds'Stmt-symbol $.
IMP-symbol-247-is-pattern $a #Pattern ( \kore-symbol-Lblint'UndsSClnUndsUnds'IMP-SYNTAX'Unds'Pgm'Unds'Ids'Unds'Stmt ptn0 ptn1 ) $.
IMP-symbol-247-is-sugar $a #Notation ( \kore-symbol-Lblint'UndsSClnUndsUnds'IMP-SYNTAX'Unds'Pgm'Unds'Ids'Unds'Stmt ptn0 ptn1 ) ( \app ( \app \kore-symbol-Lblint'UndsSClnUndsUnds'IMP-SYNTAX'Unds'Pgm'Unds'Ids'Unds'Stmt-symbol ptn0 ) ptn1 ) $.
${ notation-cache-478 $p #Notation ( \kore-symbol-Lblint'UndsSClnUndsUnds'IMP-SYNTAX'Unds'Pgm'Unds'Ids'Unds'Stmt ptn0 ptn1 ) ( \app ( \app \kore-symbol-Lblint'UndsSClnUndsUnds'IMP-SYNTAX'Unds'Pgm'Unds'Ids'Unds'Stmt-symbol ptn0 ) ptn1 ) $= ( IMP-symbol-247-is-symbol symbol-is-pattern app-is-pattern notation-reflexivity notation-app IMP-symbol-247-is-pattern IMP-symbol-247-is-sugar notation-transitivity ) ABHCDAEBECDAEBEABICDAEBCDAEBCDACDACDFAFGBFGJ $. $}
