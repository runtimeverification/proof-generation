$c #Substitution #Notation #SetVariable #ElementVariable #Symbol #Variable #Pattern \app \kore-symbol-Lbl'Hash'if'UndsHash'then'UndsHash'else'UndsHash'fi'Unds'K-EQUAL-SYNTAX'Unds'Sort'Unds'Bool'Unds'Sort'Unds'Sort-symbol ) \kore-symbol-Lbl'Hash'if'UndsHash'then'UndsHash'else'UndsHash'fi'Unds'K-EQUAL-SYNTAX'Unds'Sort'Unds'Bool'Unds'Sort'Unds'Sort ( $.
$v xX0 sg0 ptn7 ptn3 ptn2 ptn5 ph3 ptn0 ph1 ph0 xX ph2 ptn4 ptn6 ptn1 ptn8 ph4 ph5 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
ph4-is-pattern $f #Pattern ph4 $.
ph5-is-pattern $f #Pattern ph5 $.
xX-is-var $f #Variable xX $.
sg0-is-symbol $f #Symbol sg0 $.
symbol-is-pattern $a #Pattern sg0 $.
app-is-pattern $a #Pattern ( \app ph0 ph1 ) $.
${ substitution-app.0 $e #Substitution ph1 ph3 ph0 xX $.
   substitution-app.1 $e #Substitution ph2 ph4 ph0 xX $.
   substitution-app $a #Substitution ( \app ph1 ph2 ) ( \app ph3 ph4 ) ph0 xX $. $}
notation-reflexivity $a #Notation ph0 ph0 $.
${ notation-transitivity.0 $e #Notation ph0 ph1 $.
   notation-transitivity.1 $e #Notation ph1 ph2 $.
   notation-transitivity $a #Notation ph0 ph2 $. $}
${ notation-substitution.0 $e #Substitution ph0 ph1 ph2 xX $.
   notation-substitution.1 $e #Notation ph3 ph0 $.
   notation-substitution.2 $e #Notation ph4 ph1 $.
   notation-substitution.3 $e #Notation ph5 ph2 $.
   notation-substitution $a #Substitution ph3 ph4 ph5 xX $. $}
${ $d xX ph0 $.
   substitution-disjoint $a #Substitution ph0 ph0 ph1 xX $. $}
xX0-variable $f #Variable xX0 $.
ptn0-pattern $f #Pattern ptn0 $.
ptn1-pattern $f #Pattern ptn1 $.
ptn2-pattern $f #Pattern ptn2 $.
ptn3-pattern $f #Pattern ptn3 $.
ptn4-pattern $f #Pattern ptn4 $.
IMP-symbol-98-is-symbol $a #Symbol \kore-symbol-Lbl'Hash'if'UndsHash'then'UndsHash'else'UndsHash'fi'Unds'K-EQUAL-SYNTAX'Unds'Sort'Unds'Bool'Unds'Sort'Unds'Sort-symbol $.
IMP-symbol-98-is-pattern $a #Pattern ( \kore-symbol-Lbl'Hash'if'UndsHash'then'UndsHash'else'UndsHash'fi'Unds'K-EQUAL-SYNTAX'Unds'Sort'Unds'Bool'Unds'Sort'Unds'Sort ptn0 ptn1 ptn2 ptn3 ) $.
IMP-symbol-98-is-sugar $a #Notation ( \kore-symbol-Lbl'Hash'if'UndsHash'then'UndsHash'else'UndsHash'fi'Unds'K-EQUAL-SYNTAX'Unds'Sort'Unds'Bool'Unds'Sort'Unds'Sort ptn0 ptn1 ptn2 ptn3 ) ( \app ( \app ( \app ( \app \kore-symbol-Lbl'Hash'if'UndsHash'then'UndsHash'else'UndsHash'fi'Unds'K-EQUAL-SYNTAX'Unds'Sort'Unds'Bool'Unds'Sort'Unds'Sort-symbol ptn0 ) ptn1 ) ptn2 ) ptn3 ) $.
ptn5-pattern $f #Pattern ptn5 $.
ptn6-pattern $f #Pattern ptn6 $.
ptn7-pattern $f #Pattern ptn7 $.
ptn8-pattern $f #Pattern ptn8 $.
${ IMP-symbol-98-substitution.0 $e #Substitution ptn1 ptn5 ptn0 xX0 $.
   IMP-symbol-98-substitution.1 $e #Substitution ptn2 ptn6 ptn0 xX0 $.
   IMP-symbol-98-substitution.2 $e #Substitution ptn3 ptn7 ptn0 xX0 $.
   IMP-symbol-98-substitution.3 $e #Substitution ptn4 ptn8 ptn0 xX0 $.
   IMP-symbol-98-substitution $p #Substitution ( \kore-symbol-Lbl'Hash'if'UndsHash'then'UndsHash'else'UndsHash'fi'Unds'K-EQUAL-SYNTAX'Unds'Sort'Unds'Bool'Unds'Sort'Unds'Sort ptn1 ptn2 ptn3 ptn4 ) ( \kore-symbol-Lbl'Hash'if'UndsHash'then'UndsHash'else'UndsHash'fi'Unds'K-EQUAL-SYNTAX'Unds'Sort'Unds'Bool'Unds'Sort'Unds'Sort ptn5 ptn6 ptn7 ptn8 ) ptn0 xX0 $= ( app-is-pattern IMP-symbol-98-is-symbol symbol-is-pattern IMP-symbol-98-is-pattern substitution-app notation-reflexivity IMP-symbol-98-is-sugar notation-transitivity substitution-disjoint notation-substitution ) PQCODOEOFOPQGOHOIOJOBCDEFRGHIJRBABPQCODOEOFPQGOHOIOJABPQCODOEPQGOHOIABPQCODPQGOHABPQCPQGAPQBAUCKSLSMSNSCDEFRPQCODOEOFOPQCODOEOFOCDEFUAPQCODOEOFOTUBGHIJRPQGOHOIOJOPQGOHOIOJOGHIJUAPQGOHOIOJOTUBBTUD $. $}
