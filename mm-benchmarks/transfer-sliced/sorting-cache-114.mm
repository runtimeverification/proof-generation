$c \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \and \imp \kore-is-sort |- \kore-sort-SortId ) \in-sort ( $.
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
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
proof-rule-prop-1 $a |- ( \imp ph0 ( \imp ph1 ph0 ) ) $.
${ proof-rule-mp.0 $e |- ( \imp ph0 ph1 ) $.
   proof-rule-mp.1 $e |- ph0 $.
   proof-rule-mp $a |- ph1 $. $}
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-17-sort $a |- ( \kore-is-sort \kore-sort-SortId ) $.
kore-sort-var-S3-elementvariable $f #ElementVariable kore-sort-var-S3 $.
kore-sort-var-S2-elementvariable $f #ElementVariable kore-sort-var-S2 $.
kore-element-var-T-elementvariable $f #ElementVariable kore-element-var-T $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-1 $a #Pattern kore-sort-var-S2 $.
typecode-cache-Pattern-6 $a #Pattern kore-element-var-T $.
typecode-cache-Pattern-19 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-S3 ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortId ) \top ) ) $.
sorting-cache-113 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \kore-is-sort kore-sort-var-S2 ) ( \and ( \kore-is-sort kore-sort-var-S3 ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortId ) \top ) ) ) ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortId ) \top ) ) $.
${ sorting-cache-114 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \kore-is-sort kore-sort-var-S2 ) ( \and ( \kore-is-sort kore-sort-var-S3 ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortId ) \top ) ) ) ) ( \and ( \kore-is-sort \kore-sort-SortId ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortId ) \top ) ) ) $= ( kore-is-sort-is-pattern and-is-pattern IMP-sort-17-is-pattern typecode-cache-Pattern-0 typecode-cache-Pattern-1 typecode-cache-Pattern-19 typecode-cache-Pattern-6 in-sort-is-pattern top-is-pattern imp-is-pattern proof-rule-prop-1 IMP-sort-17-sort proof-rule-mp sorting-cache-113 rule-and-intro-alt2-sugar ) AHECIEBDJFFGEDKGLMFGEAHECIEBDJFFGENGEAHECIEBDJFFOPQABCDRS $. $}
