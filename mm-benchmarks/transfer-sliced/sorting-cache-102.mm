$c \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \and \imp \kore-is-sort |- ) \in-sort ( $.
$v kore-sort-var-R ph0 ph2 kore-sort-var-S2 kore-sort-var-S3 kore-element-var-T kore-sort-var-S1 ph1 $.
$d kore-sort-var-R kore-sort-var-S2 $.
$d kore-sort-var-R kore-sort-var-S3 $.
$d kore-sort-var-S1 kore-element-var-T $.
$d kore-sort-var-R kore-element-var-T $.
$d kore-sort-var-S1 kore-sort-var-S2 $.
$d kore-sort-var-S2 kore-element-var-T $.
$d kore-sort-var-S3 kore-sort-var-S2 $.
$d kore-sort-var-R kore-sort-var-S1 $.
$d kore-sort-var-S1 kore-sort-var-S3 $.
$d kore-sort-var-S3 kore-element-var-T $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
and-elim-left-sugar $a |- ( \imp ( \and ph0 ph1 ) ph0 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
kore-sort-var-S3-elementvariable $f #ElementVariable kore-sort-var-S3 $.
kore-sort-var-S2-elementvariable $f #ElementVariable kore-sort-var-S2 $.
kore-sort-var-S1-elementvariable $f #ElementVariable kore-sort-var-S1 $.
kore-element-var-T-elementvariable $f #ElementVariable kore-element-var-T $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-2 $a #Pattern kore-sort-var-S3 $.
typecode-cache-Pattern-3 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-S2 ) ( \and ( \kore-is-sort kore-sort-var-S3 ) \top ) ) $.
typecode-cache-Pattern-5 $a #Pattern kore-sort-var-S1 $.
typecode-cache-Pattern-7 $a #Pattern ( \in-sort kore-element-var-T kore-sort-var-S1 ) $.
sorting-cache-101 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \kore-is-sort kore-sort-var-S2 ) ( \and ( \kore-is-sort kore-sort-var-S3 ) \top ) ) ) ( \kore-is-sort kore-sort-var-S3 ) ) $.
${ sorting-cache-102 $p |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \kore-is-sort kore-sort-var-S2 ) ( \and ( \kore-is-sort kore-sort-var-S3 ) \top ) ) ) ( \and ( \kore-is-sort kore-sort-var-S1 ) ( \and ( \in-sort kore-element-var-T kore-sort-var-S1 ) \top ) ) ) ( \kore-is-sort kore-sort-var-S3 ) ) $= ( and-is-pattern kore-is-sort-is-pattern typecode-cache-Pattern-0 typecode-cache-Pattern-3 typecode-cache-Pattern-5 typecode-cache-Pattern-7 top-is-pattern typecode-cache-Pattern-2 and-elim-left-sugar sorting-cache-101 rule-imp-transitivity ) AHGBCIFDJGDEKLFFFAHGBCIFBMGAHGBCIFDJGDEKLFFNABCOP $. $}
