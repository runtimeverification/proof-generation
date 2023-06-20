$c \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \kore-sort-SortBlock \kore-sort-SortBool \imp ( \kore-is-sort |- ) \in-sort \and $.
$v kore-element-var-VE6 ph0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
proof-rule-prop-1 $a |- ( \imp ph0 ( \imp ph1 ph0 ) ) $.
${ proof-rule-mp.0 $e |- ( \imp ph0 ph1 ) $.
   proof-rule-mp.1 $e |- ph0 $.
   proof-rule-mp $a |- ph1 $. $}
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
IMP-sort-18-is-pattern $a #Pattern \kore-sort-SortBlock $.
IMP-sort-32-is-pattern $a #Pattern \kore-sort-SortBool $.
IMP-sort-32-sort $a |- ( \kore-is-sort \kore-sort-SortBool ) $.
kore-element-var-VE6-elementvariable $f #ElementVariable kore-element-var-VE6 $.
typecode-cache-Pattern-356 $a #Pattern kore-element-var-VE6 $.
${ sorting-cache-1777 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE6 \kore-sort-SortBlock ) \top ) ( \kore-is-sort \kore-sort-SortBool ) ) $= ( IMP-sort-32-is-pattern kore-is-sort-is-pattern typecode-cache-Pattern-356 IMP-sort-18-is-pattern in-sort-is-pattern top-is-pattern and-is-pattern imp-is-pattern proof-rule-prop-1 IMP-sort-32-sort proof-rule-mp ) BCADEFGHBCIBCADEFGHJKL $. $}
