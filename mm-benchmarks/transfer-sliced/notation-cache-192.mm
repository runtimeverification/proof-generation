$c #Notation #SetVariable #ElementVariable #Symbol #Variable #Pattern \app ) \kore-symbol-LblListItem \kore-symbol-LblListItem-symbol ( $.
$v ph0 ph2 sg0 ph3 ptn0 ph1 $.
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
IMP-symbol-141-is-symbol $a #Symbol \kore-symbol-LblListItem-symbol $.
IMP-symbol-141-is-pattern $a #Pattern ( \kore-symbol-LblListItem ptn0 ) $.
IMP-symbol-141-is-sugar $a #Notation ( \kore-symbol-LblListItem ptn0 ) ( \app \kore-symbol-LblListItem-symbol ptn0 ) $.
${ notation-cache-192 $p #Notation ( \kore-symbol-LblListItem ptn0 ) ( \app \kore-symbol-LblListItem-symbol ptn0 ) $= ( IMP-symbol-141-is-symbol symbol-is-pattern app-is-pattern notation-reflexivity IMP-symbol-141-is-pattern IMP-symbol-141-is-sugar notation-app notation-transitivity ) AFBCADBCADAGBCABCABCEAEHI $. $}
