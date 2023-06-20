$c #Notation #SetVariable #ElementVariable #Symbol ) #Variable #Pattern ( $.
$v ph2 ph0 ph3 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
${ notation-symmetry.0 $e #Notation ph0 ph1 $.
   notation-symmetry $a #Notation ph1 ph0 $. $}
${ notation-transitivity.0 $e #Notation ph0 ph1 $.
   notation-transitivity.1 $e #Notation ph1 ph2 $.
   notation-transitivity $a #Notation ph0 ph2 $. $}
${ notation-notation.0 $e #Notation ph0 ph1 $.
   notation-notation.1 $e #Notation ph2 ph0 $.
   notation-notation.2 $e #Notation ph3 ph1 $.
   notation-notation $p #Notation ph2 ph3 $= ( notation-transitivity notation-symmetry ) CADFABDEDBGIHH $. $}
