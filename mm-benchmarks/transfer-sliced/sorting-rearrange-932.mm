$c \top #Variable \imp \kore-is-sort |- \kore-valid ) \kore-equals \and \kore-sort-SortKResult #SetVariable #ElementVariable #Symbol #Pattern \kore-exists \kore-inj \kore-sort-SortInt \in-sort ( $.
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
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-sort-28-is-pattern $a #Pattern \kore-sort-SortKResult $.
kore-element-var-Val-elementvariable $f #ElementVariable kore-element-var-Val $.
kore-element-var-From-elementvariable $f #ElementVariable kore-element-var-From $.
IMP-axiom-2 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-From \kore-sort-SortInt ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortKResult kore-sort-var-R kore-element-var-Val ( \kore-equals \kore-sort-SortKResult kore-sort-var-R kore-element-var-Val ( \kore-inj \kore-sort-SortInt \kore-sort-SortKResult kore-element-var-From ) ) ) ) ) $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-45 $a #Pattern kore-element-var-From $.
sorting-cache-310 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \in-sort kore-element-var-From \kore-sort-SortInt ) \top ) ) ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-From \kore-sort-SortInt ) \top ) ) ) $.
typecode-cache-Pattern-93 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-From \kore-sort-SortInt ) \top ) ) $.
typecode-cache-Pattern-331 $a #Pattern ( \kore-equals \kore-sort-SortKResult kore-sort-var-R kore-element-var-Val ( \kore-inj \kore-sort-SortInt \kore-sort-SortKResult kore-element-var-From ) ) $.
${ sorting-rearrange-932 $p |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \in-sort kore-element-var-From \kore-sort-SortInt ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortKResult kore-sort-var-R kore-element-var-Val ( \kore-equals \kore-sort-SortKResult kore-sort-var-R kore-element-var-Val ( \kore-inj \kore-sort-SortInt \kore-sort-SortKResult kore-element-var-From ) ) ) ) ) $= ( typecode-cache-Pattern-0 and-is-pattern top-is-pattern kore-is-sort-is-pattern typecode-cache-Pattern-45 IMP-sort-23-is-pattern in-sort-is-pattern typecode-cache-Pattern-93 IMP-sort-28-is-pattern typecode-cache-Pattern-331 kore-exists-is-pattern kore-valid-is-pattern sorting-cache-310 IMP-axiom-2 rule-imp-transitivity ) ADGFECHIJFEEACKADLADABCMBNOACPABCQR $. $}
