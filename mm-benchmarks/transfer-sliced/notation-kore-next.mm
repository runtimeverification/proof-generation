$c #Notation #SetVariable #ElementVariable #Symbol #Variable #Pattern \kore-next-symbol \app ) \kore-next ( $.
$v ph0 ph2 sg0 ph3 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
sg0-is-symbol $f #Symbol sg0 $.
symbol-is-pattern $a #Pattern sg0 $.
app-is-pattern $a #Pattern ( \app ph0 ph1 ) $.
notation-reflexivity $a #Notation ph0 ph0 $.
${ notation-symmetry.0 $e #Notation ph0 ph1 $.
   notation-symmetry $a #Notation ph1 ph0 $. $}
${ notation-transitivity.0 $e #Notation ph0 ph1 $.
   notation-transitivity.1 $e #Notation ph1 ph2 $.
   notation-transitivity $a #Notation ph0 ph2 $. $}
${ notation-app.0 $e #Notation ph0 ph2 $.
   notation-app.1 $e #Notation ph1 ph3 $.
   notation-app $a #Notation ( \app ph0 ph1 ) ( \app ph2 ph3 ) $. $}
kore-next-is-symbol $a #Symbol \kore-next-symbol $.
kore-next-is-pattern $a #Pattern ( \kore-next ph0 ph1 ) $.
kore-next-is-sugar $a #Notation ( \kore-next ph0 ph1 ) ( \app \kore-next-symbol ph1 ) $.
${ notation-kore-next.0 $e #Notation ph0 ph2 $.
   notation-kore-next.1 $e #Notation ph1 ph3 $.
   notation-kore-next $p #Notation ( \kore-next ph0 ph1 ) ( \kore-next ph2 ph3 ) $= ( kore-next-is-symbol symbol-is-pattern app-is-pattern kore-next-is-pattern kore-next-is-sugar notation-symmetry notation-transitivity notation-reflexivity notation-app ) ABJGHBICDJABKCDJGHBICDJGHDIGHBICDKGHBIGHDIGHBGHDGHNFOLMLM $. $}
