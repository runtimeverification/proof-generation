$c \kore-symbol-LblinitStateCell \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \imp |- ) \in-sort \kore-sort-SortStateCell ( $.
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
IMP-sort-9-is-pattern $a #Pattern \kore-sort-SortStateCell $.
IMP-symbol-245-is-pattern $a #Pattern \kore-symbol-LblinitStateCell $.
IMP-symbol-245-sorting $a |- ( \in-sort \kore-symbol-LblinitStateCell \kore-sort-SortStateCell ) $.
${ sorting-cache-531 $p |- ( \imp \top ( \in-sort \kore-symbol-LblinitStateCell \kore-sort-SortStateCell ) ) $= ( IMP-symbol-245-is-pattern IMP-sort-9-is-pattern in-sort-is-pattern top-is-pattern imp-is-pattern proof-rule-prop-1 IMP-symbol-245-sorting proof-rule-mp ) ABCDABCEABCDFGH $. $}
