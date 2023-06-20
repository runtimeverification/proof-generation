$c #Notation #SetVariable #Positive #ElementVariable #Symbol #Variable #Pattern \kore-next-symbol \app ) \kore-next ( $.
$v ph0 xX ph2 sg0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
xX-is-var $f #Variable xX $.
sg0-is-symbol $f #Symbol sg0 $.
symbol-is-pattern $a #Pattern sg0 $.
app-is-pattern $a #Pattern ( \app ph0 ph1 ) $.
${ positive-in-app.0 $e #Positive xX ph0 $.
   positive-in-app.1 $e #Positive xX ph1 $.
   positive-in-app $a #Positive xX ( \app ph0 ph1 ) $. $}
${ $d xX ph0 $.
   positive-disjoint $a #Positive xX ph0 $. $}
notation-reflexivity $a #Notation ph0 ph0 $.
${ notation-transitivity.0 $e #Notation ph0 ph1 $.
   notation-transitivity.1 $e #Notation ph1 ph2 $.
   notation-transitivity $a #Notation ph0 ph2 $. $}
${ notation-positive.0 $e #Positive xX ph0 $.
   notation-positive.1 $e #Notation ph1 ph0 $.
   notation-positive $a #Positive xX ph1 $. $}
kore-next-is-symbol $a #Symbol \kore-next-symbol $.
kore-next-is-pattern $a #Pattern ( \kore-next ph0 ph1 ) $.
kore-next-is-sugar $a #Notation ( \kore-next ph0 ph1 ) ( \app \kore-next-symbol ph1 ) $.
${ positive-in-kore-next.0 $e #Positive xX ph0 $.
   positive-in-kore-next.1 $e #Positive xX ph1 $.
   positive-in-kore-next $p #Positive xX ( \kore-next ph0 ph1 ) $= ( kore-next-is-symbol symbol-is-pattern app-is-pattern kore-next-is-pattern positive-disjoint positive-in-app kore-next-is-sugar notation-reflexivity notation-transitivity notation-positive ) FGBHABICFGBCFGCJEKABIFGBHFGBHABLFGBHMNO $. $}
