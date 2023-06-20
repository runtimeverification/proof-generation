$c #Substitution \kore-sort-SortBool #SetVariable #ElementVariable #Symbol ) #Variable #Pattern ( $.
$v ph0 xX kore-element-var-T x kore-sort-var-S1 ph1 $.
$d kore-sort-var-S1 kore-element-var-T $.
$d kore-element-var-T x $.
$d kore-sort-var-S1 x $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
x-is-element-var $f #ElementVariable x $.
xX-is-var $f #Variable xX $.
element-var-is-var $a #Variable x $.
${ $d xX ph0 $.
   substitution-disjoint $a #Substitution ph0 ph0 ph1 xX $. $}
IMP-sort-32-is-pattern $a #Pattern \kore-sort-SortBool $.
kore-sort-var-S1-elementvariable $f #ElementVariable kore-sort-var-S1 $.
kore-element-var-T-elementvariable $f #ElementVariable kore-element-var-T $.
typecode-cache-Pattern-6 $a #Pattern kore-element-var-T $.
${ substitution-1051 $p #Substitution kore-element-var-T kore-element-var-T \kore-sort-SortBool kore-sort-var-S1 $= ( typecode-cache-Pattern-6 IMP-sort-32-is-pattern element-var-is-var substitution-disjoint ) BCDAEF $. $}
