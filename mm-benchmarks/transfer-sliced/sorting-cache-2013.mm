$c \top #SetVariable \kore-sort-SortAExp #ElementVariable #Symbol #Variable #Pattern \and \imp \kore-is-sort |- ) \in-sort ( $.
$v kore-sort-var-R ph0 ph2 kore-element-var-From ph1 $.
$d kore-sort-var-R kore-element-var-From $.
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
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
kore-element-var-From-elementvariable $f #ElementVariable kore-element-var-From $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-45 $a #Pattern kore-element-var-From $.
sorting-cache-2011 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \in-sort kore-element-var-From \kore-sort-SortAExp ) \top ) ) ( \kore-is-sort kore-sort-var-R ) ) $.
sorting-cache-2012 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \in-sort kore-element-var-From \kore-sort-SortAExp ) \top ) ) ( \in-sort kore-element-var-From \kore-sort-SortAExp ) ) $.
${ sorting-cache-2013 $p |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \in-sort kore-element-var-From \kore-sort-SortAExp ) \top ) ) ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-From \kore-sort-SortAExp ) \top ) ) ) $= ( and-is-pattern top-is-pattern typecode-cache-Pattern-45 IMP-sort-13-is-pattern in-sort-is-pattern typecode-cache-Pattern-0 kore-is-sort-is-pattern rule-and-intro-alt2-sugar sorting-cache-2011 sorting-cache-2012 top-intro rule-weakening ) AHIDCBEFGDCCAHIBEFGDCABKAHIDCBEFGDCCBEFGDABLAHIDCBEFGDCCDMNJJ $. $}
