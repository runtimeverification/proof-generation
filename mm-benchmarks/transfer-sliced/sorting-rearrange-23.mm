$c \top #SetVariable \kore-sort-SortAExp #ElementVariable #Symbol #Variable #Pattern \and \imp \kore-is-sort |- \kore-valid ) \kore-sort-SortInt \kore-equals \kore-inj \in-sort ( $.
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
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
kore-sort-var-S3-elementvariable $f #ElementVariable kore-sort-var-S3 $.
kore-element-var-T-elementvariable $f #ElementVariable kore-element-var-T $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-2 $a #Pattern kore-sort-var-S3 $.
typecode-cache-Pattern-6 $a #Pattern kore-element-var-T $.
typecode-cache-Pattern-27 $a #Pattern ( \kore-inj \kore-sort-SortInt kore-sort-var-S3 kore-element-var-T ) $.
typecode-cache-Pattern-28 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-S3 ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortInt ) \top ) ) $.
sorting-rearrange-22 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \kore-is-sort kore-sort-var-S3 ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortInt ) \top ) ) ) ( \kore-valid kore-sort-var-R ( \kore-equals kore-sort-var-S3 kore-sort-var-R ( \kore-inj \kore-sort-SortAExp kore-sort-var-S3 ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp kore-element-var-T ) ) ( \kore-inj \kore-sort-SortInt kore-sort-var-S3 kore-element-var-T ) ) ) ) $.
typecode-cache-Pattern-30 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortInt ) \top ) ) $.
sorting-cache-161 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortInt ) \top ) ) ( \kore-is-sort kore-sort-var-R ) ) $.
sorting-cache-164 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortInt ) \top ) ) ( \and ( \kore-is-sort kore-sort-var-S3 ) \top ) ) ( \and ( \kore-is-sort kore-sort-var-S3 ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortInt ) \top ) ) ) $.
${ sorting-rearrange-23 $p |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortInt ) \top ) ) ( \and ( \kore-is-sort kore-sort-var-S3 ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-equals kore-sort-var-S3 kore-sort-var-R ( \kore-inj \kore-sort-SortAExp kore-sort-var-S3 ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp kore-element-var-T ) ) ( \kore-inj \kore-sort-SortInt kore-sort-var-S3 kore-element-var-T ) ) ) ) $= ( and-is-pattern kore-is-sort-is-pattern typecode-cache-Pattern-2 typecode-cache-Pattern-30 typecode-cache-Pattern-0 top-is-pattern typecode-cache-Pattern-28 IMP-sort-13-is-pattern kore-inj-is-pattern rule-imp-transitivity IMP-sort-23-is-pattern typecode-cache-Pattern-6 typecode-cache-Pattern-27 kore-equals-is-pattern kore-valid-is-pattern and-elim-left-sugar sorting-cache-161 sorting-cache-164 rule-and-intro-alt2-sugar sorting-rearrange-22 ) ACGBFEIDDAHEBCJDAHBFAHKBFNKCOLLBCPQRACGBFEIDDAHEBCJACGBFEIDDACGAHEACGBFEIDSACTMABCUAUBABCUCM $. $}
