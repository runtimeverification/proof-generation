$c \kore-sort-SortKResult #SetVariable #ElementVariable #Symbol #Variable #Pattern \imp \kore-is-sort |- ) \in-sort ( $.
$v ph0 ph1 kore-element-var-VE2 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
proof-rule-prop-1 $a |- ( \imp ph0 ( \imp ph1 ph0 ) ) $.
${ proof-rule-mp.0 $e |- ( \imp ph0 ph1 ) $.
   proof-rule-mp.1 $e |- ph0 $.
   proof-rule-mp $a |- ph1 $. $}
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-element-var-VE2-elementvariable $f #ElementVariable kore-element-var-VE2 $.
IMP-sort-28-is-pattern $a #Pattern \kore-sort-SortKResult $.
IMP-sort-28-sort $a |- ( \kore-is-sort \kore-sort-SortKResult ) $.
typecode-cache-Pattern-177 $a #Pattern kore-element-var-VE2 $.
${ sorting-cache-1209 $p |- ( \imp ( \in-sort kore-element-var-VE2 \kore-sort-SortKResult ) ( \kore-is-sort \kore-sort-SortKResult ) ) $= ( IMP-sort-28-is-pattern kore-is-sort-is-pattern typecode-cache-Pattern-177 in-sort-is-pattern imp-is-pattern proof-rule-prop-1 IMP-sort-28-sort proof-rule-mp ) BCADBEBCFBCADBEGHI $. $}
