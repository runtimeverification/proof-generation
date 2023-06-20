$c \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \imp \kore-dv |- "100" ) \kore-sort-SortInt \in-sort ( $.
$v ph0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
proof-rule-prop-1 $a |- ( \imp ph0 ( \imp ph1 ph0 ) ) $.
${ proof-rule-mp.0 $e |- ( \imp ph0 ph1 ) $.
   proof-rule-mp.1 $e |- ph0 $.
   proof-rule-mp $a |- ph1 $. $}
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-dv-sorting $a |- ( \in-sort ( \kore-dv ph0 ph1 ) ph0 ) $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
string-literal-16-is-pattern $a #Pattern "100" $.
${ sorting-cache-22 $p |- ( \imp \top ( \in-sort ( \kore-dv \kore-sort-SortInt "100" ) \kore-sort-SortInt ) ) $= ( IMP-sort-23-is-pattern string-literal-16-is-pattern kore-dv-is-pattern in-sort-is-pattern top-is-pattern imp-is-pattern proof-rule-prop-1 kore-dv-sorting proof-rule-mp ) ABCADEABCADFABCADEGABHI $. $}
