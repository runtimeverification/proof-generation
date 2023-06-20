$c #Substitution \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \kore-sort-SortBool ( ) \in-sort \and $.
$v ph0 xX ph2 x kore-element-var-x0 kore-element-var-T ph3 ph4 ph1 $.
$d kore-element-var-T x $.
$d kore-element-var-x0 x $.
$d kore-element-var-x0 kore-element-var-T $.
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
${ substitution-and.0 $e #Substitution ph1 ph3 ph0 xX $.
   substitution-and.1 $e #Substitution ph2 ph4 ph0 xX $.
   substitution-and $a #Substitution ( \and ph1 ph2 ) ( \and ph3 ph4 ) ph0 xX $. $}
IMP-sort-32-is-pattern $a #Pattern \kore-sort-SortBool $.
kore-element-var-T-elementvariable $f #ElementVariable kore-element-var-T $.
kore-element-var-x0-elementvariable $f #ElementVariable kore-element-var-x0 $.
typecode-cache-Pattern-6 $a #Pattern kore-element-var-T $.
typecode-cache-Pattern-25 $a #Pattern kore-element-var-x0 $.
substitution-73 $a #Substitution \top \top kore-element-var-x0 kore-element-var-T $.
substitution-1077 $a #Substitution ( \in-sort kore-element-var-x0 \kore-sort-SortBool ) ( \in-sort kore-element-var-T \kore-sort-SortBool ) kore-element-var-x0 kore-element-var-T $.
${ substitution-1078 $p #Substitution ( \and ( \in-sort kore-element-var-x0 \kore-sort-SortBool ) \top ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortBool ) \top ) kore-element-var-x0 kore-element-var-T $= ( typecode-cache-Pattern-25 IMP-sort-32-is-pattern in-sort-is-pattern top-is-pattern typecode-cache-Pattern-6 element-var-is-var substitution-1077 substitution-73 substitution-and ) BCBCDEFAGDEFAHABIABJK $. $}
