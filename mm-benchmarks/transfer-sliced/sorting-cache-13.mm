$c \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \imp \kore-is-sort |- ) \kore-sort-SortInt ( $.
$v ph0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
proof-rule-prop-1 $a |- ( \imp ph0 ( \imp ph1 ph0 ) ) $.
${ proof-rule-mp.0 $e |- ( \imp ph0 ph1 ) $.
   proof-rule-mp.1 $e |- ph0 $.
   proof-rule-mp $a |- ph1 $. $}
top-is-pattern $a #Pattern \top $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-sort-23-sort $a |- ( \kore-is-sort \kore-sort-SortInt ) $.
${ sorting-cache-13 $p |- ( \imp \top ( \kore-is-sort \kore-sort-SortInt ) ) $= ( IMP-sort-23-is-pattern kore-is-sort-is-pattern top-is-pattern imp-is-pattern proof-rule-prop-1 IMP-sort-23-sort proof-rule-mp ) ABCABDABCEFG $. $}
