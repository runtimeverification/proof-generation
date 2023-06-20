$c #Notation #SetVariable \kore-symbol-LblinitTCell #ElementVariable #Symbol #Variable #Pattern \app \kore-symbol-LblinitTCell-symbol ) ( $.
$v ph0 ptn2 ph2 sg0 ptn0 ph1 $.
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
ptn2-pattern $f #Pattern ptn2 $.
IMP-symbol-246-is-symbol $a #Symbol \kore-symbol-LblinitTCell-symbol $.
IMP-symbol-246-is-pattern $a #Pattern ( \kore-symbol-LblinitTCell ptn0 ) $.
IMP-symbol-246-is-sugar $a #Notation ( \kore-symbol-LblinitTCell ptn0 ) ( \app \kore-symbol-LblinitTCell-symbol ptn0 ) $.
${ notation-cache-474 $p #Notation ( \kore-symbol-LblinitTCell ptn2 ) ( \app \kore-symbol-LblinitTCell-symbol ptn2 ) $= ( IMP-symbol-246-is-symbol symbol-is-pattern app-is-pattern IMP-symbol-246-is-pattern IMP-symbol-246-is-sugar notation-reflexivity notation-transitivity ) AEBCADBCADAFBCADGH $. $}
