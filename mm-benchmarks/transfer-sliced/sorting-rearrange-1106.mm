$c \kore-sort-SortKResult \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \kore-sort-SortBool \and \imp \kore-is-sort |- \kore-valid ) \kore-equals \kore-inj \in-sort ( $.
$v kore-sort-var-R ph0 ph2 kore-sort-var-S3 kore-element-var-T ph3 ph1 $.
$d kore-sort-var-R kore-sort-var-S3 $.
$d kore-sort-var-R kore-element-var-T $.
$d kore-sort-var-S3 kore-element-var-T $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
and-elim-left-sugar $a |- ( \imp ( \and ph0 ph1 ) ph0 ) $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
kore-valid-is-pattern $a #Pattern ( \kore-valid ph0 ph1 ) $.
kore-equals-is-pattern $a #Pattern ( \kore-equals ph0 ph1 ph2 ph3 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-28-is-pattern $a #Pattern \kore-sort-SortKResult $.
IMP-sort-32-is-pattern $a #Pattern \kore-sort-SortBool $.
kore-sort-var-S3-elementvariable $f #ElementVariable kore-sort-var-S3 $.
kore-element-var-T-elementvariable $f #ElementVariable kore-element-var-T $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-2 $a #Pattern kore-sort-var-S3 $.
typecode-cache-Pattern-6 $a #Pattern kore-element-var-T $.
typecode-cache-Pattern-378 $a #Pattern ( \kore-inj \kore-sort-SortBool kore-sort-var-S3 kore-element-var-T ) $.
typecode-cache-Pattern-379 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-S3 ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortBool ) \top ) ) $.
sorting-rearrange-1105 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \kore-is-sort kore-sort-var-S3 ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortBool ) \top ) ) ) ( \kore-valid kore-sort-var-R ( \kore-equals kore-sort-var-S3 kore-sort-var-R ( \kore-inj \kore-sort-SortKResult kore-sort-var-S3 ( \kore-inj \kore-sort-SortBool \kore-sort-SortKResult kore-element-var-T ) ) ( \kore-inj \kore-sort-SortBool kore-sort-var-S3 kore-element-var-T ) ) ) ) $.
typecode-cache-Pattern-381 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortBool ) \top ) ) $.
sorting-cache-1810 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortBool ) \top ) ) ( \kore-is-sort kore-sort-var-R ) ) $.
sorting-cache-1813 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortBool ) \top ) ) ( \and ( \kore-is-sort kore-sort-var-S3 ) \top ) ) ( \and ( \kore-is-sort kore-sort-var-S3 ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortBool ) \top ) ) ) $.
${ sorting-rearrange-1106 $p |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortBool ) \top ) ) ( \and ( \kore-is-sort kore-sort-var-S3 ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-equals kore-sort-var-S3 kore-sort-var-R ( \kore-inj \kore-sort-SortKResult kore-sort-var-S3 ( \kore-inj \kore-sort-SortBool \kore-sort-SortKResult kore-element-var-T ) ) ( \kore-inj \kore-sort-SortBool kore-sort-var-S3 kore-element-var-T ) ) ) ) $= ( and-is-pattern kore-is-sort-is-pattern typecode-cache-Pattern-2 typecode-cache-Pattern-381 typecode-cache-Pattern-0 top-is-pattern typecode-cache-Pattern-379 IMP-sort-28-is-pattern kore-inj-is-pattern rule-imp-transitivity IMP-sort-32-is-pattern typecode-cache-Pattern-6 typecode-cache-Pattern-378 kore-equals-is-pattern kore-valid-is-pattern and-elim-left-sugar sorting-cache-1810 sorting-cache-1813 rule-and-intro-alt2-sugar sorting-rearrange-1105 ) ACGBFEIDDAHEBCJDAHBFAHKBFNKCOLLBCPQRACGBFEIDDAHEBCJACGBFEIDDACGAHEACGBFEIDSACTMABCUAUBABCUCM $. $}
