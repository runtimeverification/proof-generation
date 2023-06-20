$c #Notation #SetVariable #ElementVariable #Symbol #Variable #Pattern \imp |- \bot \not ) ( $.
$v ph0 ph2 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
bot-is-pattern $a #Pattern \bot $.
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
notation-reflexivity $a #Notation ph0 ph0 $.
${ notation-symmetry.0 $e #Notation ph0 ph1 $.
   notation-symmetry $a #Notation ph1 ph0 $. $}
${ notation-transitivity.0 $e #Notation ph0 ph1 $.
   notation-transitivity.1 $e #Notation ph1 ph2 $.
   notation-transitivity $a #Notation ph0 ph2 $. $}
${ notation-proof.0 $e |- ph0 $.
   notation-proof.1 $e #Notation ph1 ph0 $.
   notation-proof $a |- ph1 $. $}
not-is-pattern $a #Pattern ( \not ph0 ) $.
not-is-sugar $a #Notation ( \not ph0 ) ( \imp ph0 \bot ) $.
${ desugar-not-to-imp.0 $e |- ( \not ph0 ) $.
   desugar-not-to-imp $p |- ( \imp ph0 \bot ) $= ( bot-is-pattern imp-is-pattern not-is-pattern notation-symmetry not-is-sugar notation-reflexivity notation-transitivity notation-proof ) AEACDBAEACDAEACDACDAGACDACDACDHFIFJ $. $}
