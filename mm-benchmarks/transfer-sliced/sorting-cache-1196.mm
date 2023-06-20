$c \kore-sort-SortKResult #SetVariable #ElementVariable #Symbol #Variable #Pattern \imp \kore-is-sort |- \kore-sort-SortId ) \in-sort ( $.
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
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-17-sort $a |- ( \kore-is-sort \kore-sort-SortId ) $.
IMP-sort-28-is-pattern $a #Pattern \kore-sort-SortKResult $.
typecode-cache-Pattern-177 $a #Pattern kore-element-var-VE2 $.
${ sorting-cache-1196 $p |- ( \imp ( \in-sort kore-element-var-VE2 \kore-sort-SortKResult ) ( \kore-is-sort \kore-sort-SortId ) ) $= ( IMP-sort-17-is-pattern kore-is-sort-is-pattern typecode-cache-Pattern-177 IMP-sort-28-is-pattern in-sort-is-pattern imp-is-pattern proof-rule-prop-1 IMP-sort-17-sort proof-rule-mp ) BCADEFBCGBCADEFHIJ $. $}
