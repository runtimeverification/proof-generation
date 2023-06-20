$c #Substitution \kore-sort-SortKResult #SetVariable #ElementVariable #Symbol #Variable #Pattern ) \kore-inj \kore-sort-SortInt ( $.
$v ph0 xX kore-sort-var-S2 ph2 x ph6 kore-element-var-T ph3 ph4 ph5 ph1 $.
$d kore-sort-var-S2 x $.
$d kore-element-var-T x $.
$d kore-sort-var-S2 kore-element-var-T $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
ph4-is-pattern $f #Pattern ph4 $.
ph5-is-pattern $f #Pattern ph5 $.
ph6-is-pattern $f #Pattern ph6 $.
x-is-element-var $f #ElementVariable x $.
xX-is-var $f #Variable xX $.
element-var-is-var $a #Variable x $.
substitution-var-same $a #Substitution ph0 xX ph0 xX $.
${ $d xX ph0 $.
   substitution-disjoint $a #Substitution ph0 ph0 ph1 xX $. $}
${ substitution-kore-inj.0 $e #Substitution ph0 ph3 ph6 xX $.
   substitution-kore-inj.1 $e #Substitution ph1 ph4 ph6 xX $.
   substitution-kore-inj.2 $e #Substitution ph2 ph5 ph6 xX $.
   substitution-kore-inj $a #Substitution ( \kore-inj ph0 ph1 ph2 ) ( \kore-inj ph3 ph4 ph5 ) ph6 xX $. $}
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-sort-28-is-pattern $a #Pattern \kore-sort-SortKResult $.
kore-sort-var-S2-elementvariable $f #ElementVariable kore-sort-var-S2 $.
kore-element-var-T-elementvariable $f #ElementVariable kore-element-var-T $.
typecode-cache-Pattern-1 $a #Pattern kore-sort-var-S2 $.
typecode-cache-Pattern-6 $a #Pattern kore-element-var-T $.
substitution-955 $a #Substitution kore-element-var-T kore-element-var-T \kore-sort-SortKResult kore-sort-var-S2 $.
${ substitution-956 $p #Substitution ( \kore-inj \kore-sort-SortInt \kore-sort-SortKResult kore-element-var-T ) ( \kore-inj \kore-sort-SortInt kore-sort-var-S2 kore-element-var-T ) \kore-sort-SortKResult kore-sort-var-S2 $= ( IMP-sort-28-is-pattern IMP-sort-23-is-pattern element-var-is-var typecode-cache-Pattern-6 typecode-cache-Pattern-1 substitution-disjoint substitution-var-same substitution-955 substitution-kore-inj ) DCBFDAGBFCAEDCAEHCAEIABJK $. $}
