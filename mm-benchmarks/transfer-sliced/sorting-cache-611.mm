$c \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \and \imp \kore-is-sort |- ) \kore-sort-SortInt \in-sort ( $.
$v kore-sort-var-R ph0 ph2 ph1 kore-element-var-K0 $.
$d kore-sort-var-R kore-element-var-K0 $.
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
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
kore-element-var-K0-elementvariable $f #ElementVariable kore-element-var-K0 $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-51 $a #Pattern kore-element-var-K0 $.
sorting-cache-609 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \in-sort kore-element-var-K0 \kore-sort-SortInt ) \top ) ) ( \kore-is-sort kore-sort-var-R ) ) $.
sorting-cache-610 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \in-sort kore-element-var-K0 \kore-sort-SortInt ) \top ) ) ( \in-sort kore-element-var-K0 \kore-sort-SortInt ) ) $.
${ sorting-cache-611 $p |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \in-sort kore-element-var-K0 \kore-sort-SortInt ) \top ) ) ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K0 \kore-sort-SortInt ) \top ) ) ) $= ( and-is-pattern top-is-pattern typecode-cache-Pattern-51 IMP-sort-23-is-pattern in-sort-is-pattern typecode-cache-Pattern-0 kore-is-sort-is-pattern rule-and-intro-alt2-sugar sorting-cache-609 sorting-cache-610 top-intro rule-weakening ) AHIDCBEFGDCCAHIBEFGDCABKAHIDCBEFGDCCBEFGDABLAHIDCBEFGDCCDMNJJ $. $}
