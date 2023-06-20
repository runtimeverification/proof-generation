$c #Notation #SetVariable \kore-symbol-append #ElementVariable #Symbol #Variable #Pattern \app ) \kore-symbol-append-symbol ( $.
$v ph0 ph2 sg0 ptn1 ptn2 ptn0 ph1 $.
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
ptn2-pattern $f #Pattern ptn2 $.
KSEQ-symbol-2-is-symbol $a #Symbol \kore-symbol-append-symbol $.
KSEQ-symbol-2-is-pattern $a #Pattern ( \kore-symbol-append ptn0 ptn1 ) $.
KSEQ-symbol-2-is-sugar $a #Notation ( \kore-symbol-append ptn0 ptn1 ) ( \app ( \app \kore-symbol-append-symbol ptn0 ) ptn1 ) $.
${ notation-cache-3 $p #Notation ( \kore-symbol-append ptn1 ptn2 ) ( \app ( \app \kore-symbol-append-symbol ptn1 ) ptn2 ) $= ( app-is-pattern KSEQ-symbol-2-is-symbol symbol-is-pattern KSEQ-symbol-2-is-pattern KSEQ-symbol-2-is-sugar notation-reflexivity notation-transitivity ) ABFDEACBCDEACBCABGDEACBCHI $. $}
