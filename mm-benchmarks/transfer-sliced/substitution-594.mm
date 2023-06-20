$c #Substitution \kore-symbol-Lbl'Stop'Map #SetVariable \top #ElementVariable #Symbol #Variable #Pattern ( ) \in-sort \kore-sort-SortMap \and $.
$v ph0 xX ph2 x ph3 ph4 kore-element-var-K1 ph1 $.
$d kore-element-var-K1 x $.
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
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ $d xX ph0 $.
   substitution-disjoint $a #Substitution ph0 ph0 ph1 xX $. $}
${ substitution-and.0 $e #Substitution ph1 ph3 ph0 xX $.
   substitution-and.1 $e #Substitution ph2 ph4 ph0 xX $.
   substitution-and $a #Substitution ( \and ph1 ph2 ) ( \and ph3 ph4 ) ph0 xX $. $}
${ substitution-in-sort.0 $e #Substitution ph1 ph3 ph0 xX $.
   substitution-in-sort.1 $e #Substitution ph2 ph4 ph0 xX $.
   substitution-in-sort $a #Substitution ( \in-sort ph1 ph2 ) ( \in-sort ph3 ph4 ) ph0 xX $. $}
IMP-sort-14-is-pattern $a #Pattern \kore-sort-SortMap $.
IMP-symbol-124-is-pattern $a #Pattern \kore-symbol-Lbl'Stop'Map $.
kore-element-var-K1-elementvariable $f #ElementVariable kore-element-var-K1 $.
typecode-cache-Pattern-49 $a #Pattern kore-element-var-K1 $.
${ substitution-594 $p #Substitution ( \and ( \in-sort \kore-symbol-Lbl'Stop'Map \kore-sort-SortMap ) \top ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortMap ) \top ) \kore-symbol-Lbl'Stop'Map kore-element-var-K1 $= ( IMP-symbol-124-is-pattern IMP-sort-14-is-pattern element-var-is-var top-is-pattern in-sort-is-pattern typecode-cache-Pattern-49 substitution-disjoint substitution-var-same substitution-in-sort substitution-and ) BBCFEAGCFEADBBCAGCADBADICBADHJEBADHK $. $}
