$c #Substitution #SetVariable \kore-symbol-Lbl'Hash'ENAMETOOLONG #ElementVariable #Symbol ) #Variable #Pattern ( $.
$v ph0 xX xX0 ptn0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
xX-is-var $f #Variable xX $.
${ $d xX ph0 $.
   substitution-disjoint $a #Substitution ph0 ph0 ph1 xX $. $}
xX0-variable $f #Variable xX0 $.
ptn0-pattern $f #Pattern ptn0 $.
IMP-symbol-32-is-pattern $a #Pattern \kore-symbol-Lbl'Hash'ENAMETOOLONG $.
${ IMP-symbol-32-substitution $p #Substitution \kore-symbol-Lbl'Hash'ENAMETOOLONG \kore-symbol-Lbl'Hash'ENAMETOOLONG ptn0 xX0 $= ( IMP-symbol-32-is-pattern substitution-disjoint ) CBAD $. $}
