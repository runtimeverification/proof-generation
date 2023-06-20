$c #Substitution \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \kore-sort-SortKItem ( \kore-is-sort ) \and $.
$v ph1 ph0 xX ph2 x ph3 ph4 kore-sort-var-S3 $.
$d kore-sort-var-S3 x $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
ph4-is-pattern $f #Pattern ph4 $.
x-is-element-var $f #ElementVariable x $.
xX-is-var $f #Variable xX $.
element-var-is-var $a #Variable x $.
substitution-var-same $a #Substitution ph0 xX ph0 xX $.
top-is-pattern $a #Pattern \top $.
${ $d xX ph0 $.
   substitution-disjoint $a #Substitution ph0 ph0 ph1 xX $. $}
${ substitution-and.0 $e #Substitution ph1 ph3 ph0 xX $.
   substitution-and.1 $e #Substitution ph2 ph4 ph0 xX $.
   substitution-and $a #Substitution ( \and ph1 ph2 ) ( \and ph3 ph4 ) ph0 xX $. $}
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
${ $d x ph0 $.
   $d x ph1 $.
   $d x ph2 $.
   $d x xX $.
   substitution-kore-is-sort.0 $e #Substitution ph0 ph1 ph2 xX $.
   substitution-kore-is-sort $a #Substitution ( \kore-is-sort ph0 ) ( \kore-is-sort ph1 ) ph2 xX $. $}
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
kore-sort-var-S3-elementvariable $f #ElementVariable kore-sort-var-S3 $.
typecode-cache-Pattern-2 $a #Pattern kore-sort-var-S3 $.
${ substitution-45 $p #Substitution ( \and ( \kore-is-sort \kore-sort-SortKItem ) \top ) ( \and ( \kore-is-sort kore-sort-var-S3 ) \top ) \kore-sort-SortKItem kore-sort-var-S3 $= ( BASIC-K-sort-1-is-pattern element-var-is-var top-is-pattern kore-is-sort-is-pattern typecode-cache-Pattern-2 substitution-var-same substitution-kore-is-sort substitution-disjoint substitution-and ) BBEDAFEDACBAFBACBACGHDBACIJ $. $}
