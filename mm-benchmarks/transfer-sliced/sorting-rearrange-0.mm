$c \exists \top #SetVariable #ElementVariable #Symbol \eq #Variable #Pattern \and \imp \kore-is-sort |- \kore-sort-SortId ) ( $.
$v kore-sort-var-R ph0 ph2 kore-sort-var-S2 x kore-sort-var-S3 th0 ph1 $.
$d kore-sort-var-S2 x $.
$d kore-sort-var-R kore-sort-var-S2 $.
$d kore-sort-var-R kore-sort-var-S3 $.
$d kore-sort-var-S3 kore-sort-var-S2 $.
$d kore-sort-var-R x $.
$d kore-sort-var-S3 x $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
th0-is-pattern $f #Pattern th0 $.
x-is-element-var $f #ElementVariable x $.
exists-is-pattern $a #Pattern ( \exists x ph0 ) $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
eq-is-pattern $a #Pattern ( \eq ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
top-intro $a |- \top $.
${ rule-weakening.0 $e |- ph1 $.
   rule-weakening $a |- ( \imp ph0 ph1 ) $. $}
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
${ $d x ph0 $.
   kore-sort-functional.0 $e |- ( \imp th0 ( \kore-is-sort ph0 ) ) $.
   kore-sort-functional $a |- ( \imp th0 ( \exists x ( \eq x ph0 ) ) ) $. $}
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
kore-sort-var-S3-elementvariable $f #ElementVariable kore-sort-var-S3 $.
kore-sort-var-S2-elementvariable $f #ElementVariable kore-sort-var-S2 $.
sorting-cache-28 $a |- ( \imp \top ( \kore-is-sort \kore-sort-SortId ) ) $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-3 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-S2 ) ( \and ( \kore-is-sort kore-sort-var-S3 ) \top ) ) $.
typecode-cache-Pattern-4 $a #Pattern x $.
${ sorting-rearrange-0 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \kore-is-sort kore-sort-var-S2 ) ( \and ( \kore-is-sort kore-sort-var-S3 ) \top ) ) ) ( \exists x ( \eq x \kore-sort-SortId ) ) ) $= ( top-is-pattern typecode-cache-Pattern-0 kore-is-sort-is-pattern typecode-cache-Pattern-3 and-is-pattern IMP-sort-17-is-pattern typecode-cache-Pattern-4 eq-is-pattern exists-is-pattern top-intro rule-weakening sorting-cache-28 kore-sort-functional rule-imp-transitivity ) BFGCDHIEAKJLAMBFGCDHIENOJEAPQR $. $}
