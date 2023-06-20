$c #Substitution #SetVariable #ElementVariable #Symbol ) \kore-sort-SortInt #Variable #Pattern ( $.
$v ph0 xX kore-sort-var-S2 x kore-sort-var-S1 ph1 $.
$d kore-sort-var-S2 x $.
$d kore-sort-var-S1 kore-sort-var-S2 $.
$d kore-sort-var-S1 x $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
x-is-element-var $f #ElementVariable x $.
xX-is-var $f #Variable xX $.
element-var-is-var $a #Variable x $.
${ $d xX ph0 $.
   substitution-disjoint $a #Substitution ph0 ph0 ph1 xX $. $}
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
kore-sort-var-S2-elementvariable $f #ElementVariable kore-sort-var-S2 $.
kore-sort-var-S1-elementvariable $f #ElementVariable kore-sort-var-S1 $.
typecode-cache-Pattern-1 $a #Pattern kore-sort-var-S2 $.
${ substitution-98 $p #Substitution kore-sort-var-S2 kore-sort-var-S2 \kore-sort-SortInt kore-sort-var-S1 $= ( typecode-cache-Pattern-1 IMP-sort-23-is-pattern element-var-is-var substitution-disjoint ) ACDBEF $. $}
