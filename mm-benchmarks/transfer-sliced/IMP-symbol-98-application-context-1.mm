$c #Notation #SetVariable #ElementVariable #Symbol #Variable #Pattern #ApplicationContext \app \kore-symbol-Lbl'Hash'if'UndsHash'then'UndsHash'else'UndsHash'fi'Unds'K-EQUAL-SYNTAX'Unds'Sort'Unds'Bool'Unds'Sort'Unds'Sort-symbol ) \kore-symbol-Lbl'Hash'if'UndsHash'then'UndsHash'else'UndsHash'fi'Unds'K-EQUAL-SYNTAX'Unds'Sort'Unds'Bool'Unds'Sort'Unds'Sort ( $.
$v ph0 xX xX0 sg0 ptn1 ptn3 ptn2 ptn0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
xX-is-var $f #Variable xX $.
sg0-is-symbol $f #Symbol sg0 $.
symbol-is-pattern $a #Pattern sg0 $.
app-is-pattern $a #Pattern ( \app ph0 ph1 ) $.
${ $d xX ph1 $.
   application-context-app-left.0 $e #ApplicationContext xX ph0 $.
   application-context-app-left $a #ApplicationContext xX ( \app ph0 ph1 ) $. $}
${ $d xX ph0 $.
   application-context-app-right.0 $e #ApplicationContext xX ph1 $.
   application-context-app-right $a #ApplicationContext xX ( \app ph0 ph1 ) $. $}
${ notation-application-context.0 $e #ApplicationContext xX ph0 $.
   notation-application-context.1 $e #Notation ph1 ph0 $.
   notation-application-context $a #ApplicationContext xX ph1 $. $}
xX0-variable $f #Variable xX0 $.
ptn0-pattern $f #Pattern ptn0 $.
ptn1-pattern $f #Pattern ptn1 $.
ptn2-pattern $f #Pattern ptn2 $.
ptn3-pattern $f #Pattern ptn3 $.
IMP-symbol-98-is-symbol $a #Symbol \kore-symbol-Lbl'Hash'if'UndsHash'then'UndsHash'else'UndsHash'fi'Unds'K-EQUAL-SYNTAX'Unds'Sort'Unds'Bool'Unds'Sort'Unds'Sort-symbol $.
IMP-symbol-98-is-pattern $a #Pattern ( \kore-symbol-Lbl'Hash'if'UndsHash'then'UndsHash'else'UndsHash'fi'Unds'K-EQUAL-SYNTAX'Unds'Sort'Unds'Bool'Unds'Sort'Unds'Sort ptn0 ptn1 ptn2 ptn3 ) $.
notation-cache-91 $a #Notation ( \kore-symbol-Lbl'Hash'if'UndsHash'then'UndsHash'else'UndsHash'fi'Unds'K-EQUAL-SYNTAX'Unds'Sort'Unds'Bool'Unds'Sort'Unds'Sort ptn0 ptn1 ptn2 ptn3 ) ( \app ( \app ( \app ( \app \kore-symbol-Lbl'Hash'if'UndsHash'then'UndsHash'else'UndsHash'fi'Unds'K-EQUAL-SYNTAX'Unds'Sort'Unds'Bool'Unds'Sort'Unds'Sort-symbol ptn0 ) ptn1 ) ptn2 ) ptn3 ) $.
${ $d xX0 ptn0 $.
   $d xX0 ptn2 $.
   $d xX0 ptn3 $.
   IMP-symbol-98-application-context-1.0 $e #ApplicationContext xX0 ptn1 $.
   IMP-symbol-98-application-context-1 $p #ApplicationContext xX0 ( \kore-symbol-Lbl'Hash'if'UndsHash'then'UndsHash'else'UndsHash'fi'Unds'K-EQUAL-SYNTAX'Unds'Sort'Unds'Bool'Unds'Sort'Unds'Sort ptn0 ptn1 ptn2 ptn3 ) $= ( app-is-pattern IMP-symbol-98-is-symbol symbol-is-pattern application-context-app-left IMP-symbol-98-is-pattern application-context-app-right notation-cache-91 notation-application-context ) HIBGCGDGEGBCDEKAHIBGCGDGEAHIBGCGDAHIBGCAFLJJBCDEMN $. $}
