$c #Notation #SetVariable #ElementVariable #Symbol #Variable #Pattern #ApplicationContext \kore-inj-symbol \app ) \kore-inj ( $.
$v ph0 ph2 xX0 xX sg0 ptn1 ptn2 ptn0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
xX-is-var $f #Variable xX $.
sg0-is-symbol $f #Symbol sg0 $.
symbol-is-pattern $a #Pattern sg0 $.
app-is-pattern $a #Pattern ( \app ph0 ph1 ) $.
${ $d xX ph0 $.
   application-context-app-right.0 $e #ApplicationContext xX ph1 $.
   application-context-app-right $a #ApplicationContext xX ( \app ph0 ph1 ) $. $}
${ notation-application-context.0 $e #ApplicationContext xX ph0 $.
   notation-application-context.1 $e #Notation ph1 ph0 $.
   notation-application-context $a #ApplicationContext xX ph1 $. $}
kore-inj-is-symbol $a #Symbol \kore-inj-symbol $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
xX0-variable $f #Variable xX0 $.
ptn0-pattern $f #Pattern ptn0 $.
ptn1-pattern $f #Pattern ptn1 $.
ptn2-pattern $f #Pattern ptn2 $.
notation-cache-6 $a #Notation ( \kore-inj ptn0 ptn1 ptn2 ) ( \app ( \app ( \app \kore-inj-symbol ptn0 ) ptn1 ) ptn2 ) $.
${ $d xX0 ptn0 $.
   $d xX0 ptn1 $.
   kore-inj-application-context-2.0 $e #ApplicationContext xX0 ptn2 $.
   kore-inj-application-context-2 $p #ApplicationContext xX0 ( \kore-inj ptn0 ptn1 ptn2 ) $= ( app-is-pattern kore-inj-is-symbol symbol-is-pattern kore-inj-is-pattern application-context-app-right notation-cache-6 notation-application-context ) GHBFCFDFBCDIAGHBFCFDAEJBCDKL $. $}
