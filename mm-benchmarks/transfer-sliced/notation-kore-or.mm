$c #Notation #SetVariable #ElementVariable #Symbol \or #Variable #Pattern \kore-or ) ( $.
$v ph0 ph2 ph3 ph4 ph5 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
ph4-is-pattern $f #Pattern ph4 $.
ph5-is-pattern $f #Pattern ph5 $.
${ notation-symmetry.0 $e #Notation ph0 ph1 $.
   notation-symmetry $a #Notation ph1 ph0 $. $}
${ notation-transitivity.0 $e #Notation ph0 ph1 $.
   notation-transitivity.1 $e #Notation ph1 ph2 $.
   notation-transitivity $a #Notation ph0 ph2 $. $}
or-is-pattern $a #Pattern ( \or ph0 ph1 ) $.
${ notation-or.0 $e #Notation ph0 ph2 $.
   notation-or.1 $e #Notation ph1 ph3 $.
   notation-or $a #Notation ( \or ph0 ph1 ) ( \or ph2 ph3 ) $. $}
kore-or-is-pattern $a #Pattern ( \kore-or ph0 ph1 ph2 ) $.
kore-or-is-sugar $a #Notation ( \kore-or ph0 ph1 ph2 ) ( \or ph1 ph2 ) $.
${ notation-kore-or.0 $e #Notation ph0 ph3 $.
   notation-kore-or.1 $e #Notation ph1 ph4 $.
   notation-kore-or.2 $e #Notation ph2 ph5 $.
   notation-kore-or $p #Notation ( \kore-or ph0 ph1 ph2 ) ( \kore-or ph3 ph4 ph5 ) $= ( or-is-pattern kore-or-is-pattern kore-or-is-sugar notation-symmetry notation-transitivity notation-or ) ABCKBCJDEFKABCLDEFKBCJDEFKEFJBCJDEFLBCJEFJBCEFHIOMNMN $. $}
