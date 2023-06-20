$c #Substitution \top #SetVariable #ElementVariable #Symbol \kore-sort-SortStmt #Variable #Pattern ( ) \in-sort \and $.
$v ph0 xX ph2 x kore-element-var-x0 ph3 ph4 kore-element-var-K1 ph1 $.
$d kore-element-var-K1 x $.
$d kore-element-var-x0 kore-element-var-K1 $.
$d kore-element-var-x0 x $.
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
IMP-sort-31-is-pattern $a #Pattern \kore-sort-SortStmt $.
kore-element-var-K1-elementvariable $f #ElementVariable kore-element-var-K1 $.
kore-element-var-x0-elementvariable $f #ElementVariable kore-element-var-x0 $.
typecode-cache-Pattern-25 $a #Pattern kore-element-var-x0 $.
typecode-cache-Pattern-49 $a #Pattern kore-element-var-K1 $.
substitution-247 $a #Substitution \top \top kore-element-var-x0 kore-element-var-K1 $.
substitution-309 $a #Substitution ( \in-sort kore-element-var-x0 \kore-sort-SortStmt ) ( \in-sort kore-element-var-K1 \kore-sort-SortStmt ) kore-element-var-x0 kore-element-var-K1 $.
${ substitution-310 $p #Substitution ( \and ( \in-sort kore-element-var-x0 \kore-sort-SortStmt ) \top ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortStmt ) \top ) kore-element-var-x0 kore-element-var-K1 $= ( typecode-cache-Pattern-25 IMP-sort-31-is-pattern in-sort-is-pattern top-is-pattern typecode-cache-Pattern-49 element-var-is-var substitution-309 substitution-247 substitution-and ) BCBCDEFAGDEFAHABIABJK $. $}
