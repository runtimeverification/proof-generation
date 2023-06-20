$c \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \and \imp \kore-sort-SortPgm \kore-is-sort |- ) \in-sort ( $.
$v kore-sort-var-R ph0 ph2 kore-element-var-VE1 ph1 $.
$d kore-sort-var-R kore-element-var-VE1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
top-intro $a |- \top $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
${ rule-weakening.0 $e |- ph1 $.
   rule-weakening $a |- ( \imp ph0 ph1 ) $. $}
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
kore-element-var-VE1-elementvariable $f #ElementVariable kore-element-var-VE1 $.
IMP-sort-27-is-pattern $a #Pattern \kore-sort-SortPgm $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-146 $a #Pattern kore-element-var-VE1 $.
sorting-cache-604 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortPgm ) \top ) ) ( \kore-is-sort kore-sort-var-R ) ) $.
sorting-cache-605 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortPgm ) \top ) ) ( \in-sort kore-element-var-VE1 \kore-sort-SortPgm ) ) $.
${ sorting-cache-606 $p |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortPgm ) \top ) ) ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortPgm ) \top ) ) ) $= ( and-is-pattern top-is-pattern typecode-cache-Pattern-146 IMP-sort-27-is-pattern in-sort-is-pattern typecode-cache-Pattern-0 kore-is-sort-is-pattern rule-and-intro-alt2-sugar sorting-cache-604 sorting-cache-605 top-intro rule-weakening ) AHIDCBEFGDCCAHIBEFGDCABKAHIDCBEFGDCCBEFGDABLAHIDCBEFGDCCDMNJJ $. $}
