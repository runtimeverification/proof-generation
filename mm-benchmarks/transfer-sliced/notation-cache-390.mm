$c #Notation #SetVariable #ElementVariable #Symbol #Variable #Pattern \kore-symbol-Lbl'Unds'in'Unds'keys'LParUndsRParUnds'ARRAY-SYNTAX'Unds'Bool'Unds'Int'Unds'Array \kore-symbol-Lbl'Unds'in'Unds'keys'LParUndsRParUnds'ARRAY-SYNTAX'Unds'Bool'Unds'Int'Unds'Array-symbol \app ) ( $.
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
IMP-symbol-211-is-symbol $a #Symbol \kore-symbol-Lbl'Unds'in'Unds'keys'LParUndsRParUnds'ARRAY-SYNTAX'Unds'Bool'Unds'Int'Unds'Array-symbol $.
IMP-symbol-211-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds'in'Unds'keys'LParUndsRParUnds'ARRAY-SYNTAX'Unds'Bool'Unds'Int'Unds'Array ptn0 ptn1 ) $.
IMP-symbol-211-is-sugar $a #Notation ( \kore-symbol-Lbl'Unds'in'Unds'keys'LParUndsRParUnds'ARRAY-SYNTAX'Unds'Bool'Unds'Int'Unds'Array ptn0 ptn1 ) ( \app ( \app \kore-symbol-Lbl'Unds'in'Unds'keys'LParUndsRParUnds'ARRAY-SYNTAX'Unds'Bool'Unds'Int'Unds'Array-symbol ptn0 ) ptn1 ) $.
${ notation-cache-390 $p #Notation ( \kore-symbol-Lbl'Unds'in'Unds'keys'LParUndsRParUnds'ARRAY-SYNTAX'Unds'Bool'Unds'Int'Unds'Array ptn1 ptn2 ) ( \app ( \app \kore-symbol-Lbl'Unds'in'Unds'keys'LParUndsRParUnds'ARRAY-SYNTAX'Unds'Bool'Unds'Int'Unds'Array-symbol ptn1 ) ptn2 ) $= ( app-is-pattern IMP-symbol-211-is-symbol symbol-is-pattern IMP-symbol-211-is-pattern IMP-symbol-211-is-sugar notation-reflexivity notation-transitivity ) ABFDEACBCDEACBCABGDEACBCHI $. $}
