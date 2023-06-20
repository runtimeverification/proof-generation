$c \top #Variable \imp \kore-is-sort |- \kore-valid ) \kore-equals \and #SetVariable #ElementVariable #Symbol #Pattern \kore-sort-SortBlock \kore-exists \kore-sort-SortKItem \kore-inj \in-sort ( $.
$v kore-sort-var-R ph0 ph2 x kore-element-var-Val kore-element-var-From ph1 $.
$d kore-sort-var-R kore-element-var-Val $.
$d kore-sort-var-R kore-element-var-From $.
$d kore-element-var-Val x $.
$d kore-element-var-From x $.
$d kore-sort-var-R x $.
$d kore-element-var-From kore-element-var-Val $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
x-is-element-var $f #ElementVariable x $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
kore-exists-is-pattern $a #Pattern ( \kore-exists ph0 ph1 x ph2 ) $.
kore-valid-is-pattern $a #Pattern ( \kore-valid ph0 ph1 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-18-is-pattern $a #Pattern \kore-sort-SortBlock $.
kore-element-var-Val-elementvariable $f #ElementVariable kore-element-var-Val $.
kore-element-var-From-elementvariable $f #ElementVariable kore-element-var-From $.
IMP-axiom-19 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-From \kore-sort-SortBlock ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortKItem kore-sort-var-R kore-element-var-Val ( \kore-equals \kore-sort-SortKItem kore-sort-var-R kore-element-var-Val ( \kore-inj \kore-sort-SortBlock \kore-sort-SortKItem kore-element-var-From ) ) ) ) ) $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-45 $a #Pattern kore-element-var-From $.
sorting-cache-1261 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \in-sort kore-element-var-From \kore-sort-SortBlock ) \top ) ) ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-From \kore-sort-SortBlock ) \top ) ) ) $.
typecode-cache-Pattern-294 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-From \kore-sort-SortBlock ) \top ) ) $.
typecode-cache-Pattern-295 $a #Pattern ( \kore-equals \kore-sort-SortKItem kore-sort-var-R kore-element-var-Val ( \kore-inj \kore-sort-SortBlock \kore-sort-SortKItem kore-element-var-From ) ) $.
${ sorting-rearrange-823 $p |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \in-sort kore-element-var-From \kore-sort-SortBlock ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortKItem kore-sort-var-R kore-element-var-Val ( \kore-equals \kore-sort-SortKItem kore-sort-var-R kore-element-var-Val ( \kore-inj \kore-sort-SortBlock \kore-sort-SortKItem kore-element-var-From ) ) ) ) ) $= ( typecode-cache-Pattern-0 and-is-pattern top-is-pattern kore-is-sort-is-pattern typecode-cache-Pattern-45 IMP-sort-18-is-pattern in-sort-is-pattern typecode-cache-Pattern-294 BASIC-K-sort-1-is-pattern typecode-cache-Pattern-295 kore-exists-is-pattern kore-valid-is-pattern sorting-cache-1261 IMP-axiom-19 rule-imp-transitivity ) ADGFECHIJFEEACKADLADABCMBNOACPABCQR $. $}
