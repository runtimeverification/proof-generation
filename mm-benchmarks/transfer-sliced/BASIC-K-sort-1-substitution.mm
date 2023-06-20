$c #Substitution \kore-sort-SortKItem #SetVariable #ElementVariable #Symbol ) #Variable #Pattern ( $.
$v ph0 xX xX0 ptn0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
xX-is-var $f #Variable xX $.
${ $d xX ph0 $.
   substitution-disjoint $a #Substitution ph0 ph0 ph1 xX $. $}
xX0-variable $f #Variable xX0 $.
ptn0-pattern $f #Pattern ptn0 $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
${ BASIC-K-sort-1-substitution $p #Substitution \kore-sort-SortKItem \kore-sort-SortKItem ptn0 xX0 $= ( BASIC-K-sort-1-is-pattern substitution-disjoint ) CBAD $. $}
