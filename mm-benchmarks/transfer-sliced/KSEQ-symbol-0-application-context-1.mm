$c #Notation #SetVariable #ElementVariable #Symbol \kore-symbol-kseq #Variable #Pattern #ApplicationContext \app \kore-symbol-kseq-symbol ) ( $.
$v ph0 xX xX0 sg0 ptn1 ptn0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
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
xX0-variable $f #Variable xX0 $.
ptn0-pattern $f #Pattern ptn0 $.
ptn1-pattern $f #Pattern ptn1 $.
KSEQ-symbol-0-is-symbol $a #Symbol \kore-symbol-kseq-symbol $.
KSEQ-symbol-0-is-pattern $a #Pattern ( \kore-symbol-kseq ptn0 ptn1 ) $.
notation-cache-2 $a #Notation ( \kore-symbol-kseq ptn0 ptn1 ) ( \app ( \app \kore-symbol-kseq-symbol ptn0 ) ptn1 ) $.
${ $d xX0 ptn0 $.
   KSEQ-symbol-0-application-context-1.0 $e #ApplicationContext xX0 ptn1 $.
   KSEQ-symbol-0-application-context-1 $p #ApplicationContext xX0 ( \kore-symbol-kseq ptn0 ptn1 ) $= ( app-is-pattern KSEQ-symbol-0-is-symbol symbol-is-pattern KSEQ-symbol-0-is-pattern application-context-app-right notation-cache-2 notation-application-context ) FGBECEBCHAFGBECADIBCJK $. $}
