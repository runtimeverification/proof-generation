$c #Substitution #SetVariable #ElementVariable #Symbol #Variable #Pattern "10" \kore-dv ) \kore-sort-SortInt ( $.
$v ph0 xX kore-element-var-VE1 x ph1 kore-element-var-VE2 $.
$d x kore-element-var-VE1 $.
$d kore-element-var-VE2 kore-element-var-VE1 $.
$d kore-element-var-VE2 x $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
x-is-element-var $f #ElementVariable x $.
xX-is-var $f #Variable xX $.
element-var-is-var $a #Variable x $.
${ $d xX ph0 $.
   substitution-disjoint $a #Substitution ph0 ph0 ph1 xX $. $}
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-element-var-VE2-elementvariable $f #ElementVariable kore-element-var-VE2 $.
kore-element-var-VE1-elementvariable $f #ElementVariable kore-element-var-VE1 $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
string-literal-13-is-pattern $a #Pattern "10" $.
typecode-cache-Pattern-177 $a #Pattern kore-element-var-VE2 $.
${ substitution-1162 $p #Substitution kore-element-var-VE2 kore-element-var-VE2 ( \kore-dv \kore-sort-SortInt "10" ) kore-element-var-VE1 $= ( typecode-cache-Pattern-177 IMP-sort-23-is-pattern string-literal-13-is-pattern kore-dv-is-pattern element-var-is-var substitution-disjoint ) ACDEFBGH $. $}
