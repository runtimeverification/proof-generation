$c #Substitution \kore-sort-SortBool #SetVariable #ElementVariable #Symbol ) #Variable #Pattern ( $.
$v ph0 xX xX0 ptn0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
xX-is-var $f #Variable xX $.
${ $d xX ph0 $.
   substitution-disjoint $a #Substitution ph0 ph0 ph1 xX $. $}
xX0-variable $f #Variable xX0 $.
ptn0-pattern $f #Pattern ptn0 $.
IMP-sort-32-is-pattern $a #Pattern \kore-sort-SortBool $.
${ IMP-sort-32-substitution $p #Substitution \kore-sort-SortBool \kore-sort-SortBool ptn0 xX0 $= ( IMP-sort-32-is-pattern substitution-disjoint ) CBAD $. $}
