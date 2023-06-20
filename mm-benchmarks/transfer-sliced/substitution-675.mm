$c #Substitution \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \kore-sort-SortK ( ) \in-sort \kore-symbol-dotk \and $.
$v ph0 xX ph2 x kore-element-var-VE1 ph3 ph4 ph1 $.
$d x kore-element-var-VE1 $.
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
BASIC-K-sort-0-is-pattern $a #Pattern \kore-sort-SortK $.
KSEQ-symbol-1-is-pattern $a #Pattern \kore-symbol-dotk $.
kore-element-var-VE1-elementvariable $f #ElementVariable kore-element-var-VE1 $.
typecode-cache-Pattern-146 $a #Pattern kore-element-var-VE1 $.
${ substitution-675 $p #Substitution ( \and ( \in-sort \kore-symbol-dotk \kore-sort-SortK ) \top ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortK ) \top ) \kore-symbol-dotk kore-element-var-VE1 $= ( KSEQ-symbol-1-is-pattern BASIC-K-sort-0-is-pattern element-var-is-var top-is-pattern in-sort-is-pattern typecode-cache-Pattern-146 substitution-disjoint substitution-var-same substitution-in-sort substitution-and ) BBCFEAGCFEADBBCAGCADBADICBADHJEBADHK $. $}
