$c #Notation #SetVariable #ElementVariable #Symbol \kore-symbol-Lbl'UndsEqlsEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String \kore-symbol-Lbl'UndsEqlsEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String-symbol #Variable #Pattern #ApplicationContext \app ) ( $.
$v ph0 xX xX0 sg0 ptn1 ptn0 ph1 $.
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
IMP-symbol-183-is-symbol $a #Symbol \kore-symbol-Lbl'UndsEqlsEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String-symbol $.
IMP-symbol-183-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsEqlsEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String ptn0 ptn1 ) $.
notation-cache-316 $a #Notation ( \kore-symbol-Lbl'UndsEqlsEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String ptn0 ptn1 ) ( \app ( \app \kore-symbol-Lbl'UndsEqlsEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String-symbol ptn0 ) ptn1 ) $.
${ $d xX0 ptn1 $.
   IMP-symbol-183-application-context-0.0 $e #ApplicationContext xX0 ptn0 $.
   IMP-symbol-183-application-context-0 $p #ApplicationContext xX0 ( \kore-symbol-Lbl'UndsEqlsEqls'String'UndsUnds'STRING-COMMON'Unds'Bool'Unds'String'Unds'String ptn0 ptn1 ) $= ( IMP-symbol-183-is-symbol symbol-is-pattern app-is-pattern IMP-symbol-183-is-pattern application-context-app-right application-context-app-left notation-cache-316 notation-application-context ) EFBGCGBCHAEFBGCAEFBADIJBCKL $. $}
