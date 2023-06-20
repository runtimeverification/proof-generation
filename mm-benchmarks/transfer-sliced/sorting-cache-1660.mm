$c \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \and \kore-sort-SortKItem \imp \kore-is-sort |- ) \kore-sort-SortInt \in-sort ( $.
$v kore-element-var-VE4 ph0 ph1 $.
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
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
BASIC-K-sort-1-sort $a |- ( \kore-is-sort \kore-sort-SortKItem ) $.
kore-element-var-VE4-elementvariable $f #ElementVariable kore-element-var-VE4 $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
typecode-cache-Pattern-179 $a #Pattern kore-element-var-VE4 $.
${ sorting-cache-1660 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortInt ) \top ) ( \kore-is-sort \kore-sort-SortKItem ) ) $= ( BASIC-K-sort-1-is-pattern kore-is-sort-is-pattern typecode-cache-Pattern-179 IMP-sort-23-is-pattern in-sort-is-pattern top-is-pattern and-is-pattern imp-is-pattern proof-rule-prop-1 BASIC-K-sort-1-sort proof-rule-mp ) BCADEFGHBCIBCADEFGHJKL $. $}
