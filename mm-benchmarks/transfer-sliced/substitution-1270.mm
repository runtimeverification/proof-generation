$c #Substitution #SetVariable #ElementVariable #Symbol "210" #Variable #Pattern \kore-dv ) \kore-sort-SortInt ( $.
$v ph0 xX kore-element-var-Val x kore-element-var-From ph1 $.
$d kore-element-var-Val x $.
$d kore-element-var-From x $.
$d kore-element-var-From kore-element-var-Val $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
x-is-element-var $f #ElementVariable x $.
xX-is-var $f #Variable xX $.
element-var-is-var $a #Variable x $.
${ $d xX ph0 $.
   substitution-disjoint $a #Substitution ph0 ph0 ph1 xX $. $}
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
kore-element-var-Val-elementvariable $f #ElementVariable kore-element-var-Val $.
kore-element-var-From-elementvariable $f #ElementVariable kore-element-var-From $.
string-literal-20-is-pattern $a #Pattern "210" $.
typecode-cache-Pattern-31 $a #Pattern kore-element-var-Val $.
${ substitution-1270 $p #Substitution kore-element-var-Val kore-element-var-Val ( \kore-dv \kore-sort-SortInt "210" ) kore-element-var-From $= ( typecode-cache-Pattern-31 IMP-sort-23-is-pattern string-literal-20-is-pattern kore-dv-is-pattern element-var-is-var substitution-disjoint ) ACDEFBGH $. $}
