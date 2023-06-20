$c #Substitution \top #SetVariable #ElementVariable #Symbol #Variable #Pattern ( \kore-sort-SortId ) \in-sort \and $.
$v ph0 xX ph2 x kore-element-var-T ph3 ph4 kore-sort-var-S1 ph1 $.
$d kore-sort-var-S1 kore-element-var-T $.
$d kore-element-var-T x $.
$d kore-sort-var-S1 x $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
ph4-is-pattern $f #Pattern ph4 $.
x-is-element-var $f #ElementVariable x $.
xX-is-var $f #Variable xX $.
element-var-is-var $a #Variable x $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ $d xX ph0 $.
   substitution-disjoint $a #Substitution ph0 ph0 ph1 xX $. $}
${ substitution-and.0 $e #Substitution ph1 ph3 ph0 xX $.
   substitution-and.1 $e #Substitution ph2 ph4 ph0 xX $.
   substitution-and $a #Substitution ( \and ph1 ph2 ) ( \and ph3 ph4 ) ph0 xX $. $}
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
kore-sort-var-S1-elementvariable $f #ElementVariable kore-sort-var-S1 $.
kore-element-var-T-elementvariable $f #ElementVariable kore-element-var-T $.
typecode-cache-Pattern-6 $a #Pattern kore-element-var-T $.
typecode-cache-Pattern-7 $a #Pattern ( \in-sort kore-element-var-T kore-sort-var-S1 ) $.
substitution-1 $a #Substitution ( \in-sort kore-element-var-T \kore-sort-SortId ) ( \in-sort kore-element-var-T kore-sort-var-S1 ) \kore-sort-SortId kore-sort-var-S1 $.
${ substitution-2 $p #Substitution ( \and ( \in-sort kore-element-var-T \kore-sort-SortId ) \top ) ( \and ( \in-sort kore-element-var-T kore-sort-var-S1 ) \top ) \kore-sort-SortId kore-sort-var-S1 $= ( IMP-sort-17-is-pattern top-is-pattern element-var-is-var typecode-cache-Pattern-6 in-sort-is-pattern typecode-cache-Pattern-7 substitution-1 substitution-disjoint substitution-and ) CBFCGDABHDAEABIDCAEJK $. $}
