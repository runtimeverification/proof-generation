$c \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \kore-sort-SortBool \imp ( \kore-is-sort |- ) \in-sort \and $.
$v kore-sort-var-R ph0 ph2 kore-sort-var-S2 kore-sort-var-S3 kore-element-var-T ph1 $.
$d kore-sort-var-R kore-sort-var-S2 $.
$d kore-sort-var-R kore-sort-var-S3 $.
$d kore-sort-var-R kore-element-var-T $.
$d kore-sort-var-S2 kore-element-var-T $.
$d kore-sort-var-S3 kore-sort-var-S2 $.
$d kore-sort-var-S3 kore-element-var-T $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-32-is-pattern $a #Pattern \kore-sort-SortBool $.
kore-sort-var-S3-elementvariable $f #ElementVariable kore-sort-var-S3 $.
kore-sort-var-S2-elementvariable $f #ElementVariable kore-sort-var-S2 $.
kore-element-var-T-elementvariable $f #ElementVariable kore-element-var-T $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-1 $a #Pattern kore-sort-var-S2 $.
typecode-cache-Pattern-2 $a #Pattern kore-sort-var-S3 $.
typecode-cache-Pattern-6 $a #Pattern kore-element-var-T $.
typecode-cache-Pattern-379 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-S3 ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortBool ) \top ) ) $.
sorting-cache-1804 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \kore-is-sort kore-sort-var-S3 ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortBool ) \top ) ) ) ( \and ( \kore-is-sort kore-sort-var-S2 ) \top ) ) ( \kore-is-sort kore-sort-var-S3 ) ) $.
sorting-cache-1806 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \kore-is-sort kore-sort-var-S3 ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortBool ) \top ) ) ) ( \and ( \kore-is-sort kore-sort-var-S2 ) \top ) ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortBool ) \top ) ) $.
${ sorting-cache-1807 $p |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \kore-is-sort kore-sort-var-S3 ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortBool ) \top ) ) ) ( \and ( \kore-is-sort kore-sort-var-S2 ) \top ) ) ( \and ( \kore-is-sort kore-sort-var-S3 ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortBool ) \top ) ) ) $= ( and-is-pattern kore-is-sort-is-pattern top-is-pattern typecode-cache-Pattern-0 typecode-cache-Pattern-379 typecode-cache-Pattern-1 typecode-cache-Pattern-2 typecode-cache-Pattern-6 IMP-sort-32-is-pattern in-sort-is-pattern sorting-cache-1804 sorting-cache-1806 rule-and-intro-alt2-sugar ) AHFBDIECJFGEEBKFDLMNGEABCDOABCDPQ $. $}
