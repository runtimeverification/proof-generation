$c #Substitution #Notation #SetVariable \kore-symbol-Lblwhile'LParUndsRParUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block #ElementVariable #Symbol \kore-symbol-Lblwhile'LParUndsRParUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block-symbol #Variable #Pattern \app ) ( $.
$v xX0 sg0 ptn3 ptn2 ph3 ptn0 ph1 ph0 xX ph2 ptn4 ptn1 ph4 ph5 $.
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
IMP-symbol-353-is-symbol $a #Symbol \kore-symbol-Lblwhile'LParUndsRParUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block-symbol $.
IMP-symbol-353-is-pattern $a #Pattern ( \kore-symbol-Lblwhile'LParUndsRParUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block ptn0 ptn1 ) $.
notation-cache-761 $a #Notation ( \kore-symbol-Lblwhile'LParUndsRParUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block ptn1 ptn2 ) ( \app ( \app \kore-symbol-Lblwhile'LParUndsRParUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block-symbol ptn1 ) ptn2 ) $.
notation-cache-762 $a #Notation ( \kore-symbol-Lblwhile'LParUndsRParUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block ptn3 ptn4 ) ( \app ( \app \kore-symbol-Lblwhile'LParUndsRParUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block-symbol ptn3 ) ptn4 ) $.
${ IMP-symbol-353-substitution.0 $e #Substitution ptn1 ptn3 ptn0 xX0 $.
   IMP-symbol-353-substitution.1 $e #Substitution ptn2 ptn4 ptn0 xX0 $.
   IMP-symbol-353-substitution $p #Substitution ( \kore-symbol-Lblwhile'LParUndsRParUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block ptn1 ptn2 ) ( \kore-symbol-Lblwhile'LParUndsRParUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block ptn3 ptn4 ) ptn0 xX0 $= ( IMP-symbol-353-is-symbol symbol-is-pattern app-is-pattern IMP-symbol-353-is-pattern substitution-app substitution-disjoint notation-cache-761 notation-cache-762 notation-reflexivity notation-substitution ) IJCKDKIJEKFKBCDLEFLBABIJCKDIJEKFABIJCIJEAIJBANGMHMCDOEFPBQR $. $}
