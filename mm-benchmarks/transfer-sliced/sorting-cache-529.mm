$c \top #SetVariable #ElementVariable \kore-symbol-LblinitGeneratedCounterCell #Symbol #Variable #Pattern \imp |- ) \kore-sort-SortGeneratedCounterCell \in-sort ( $.
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
IMP-sort-10-is-pattern $a #Pattern \kore-sort-SortGeneratedCounterCell $.
IMP-symbol-242-is-pattern $a #Pattern \kore-symbol-LblinitGeneratedCounterCell $.
IMP-symbol-242-sorting $a |- ( \in-sort \kore-symbol-LblinitGeneratedCounterCell \kore-sort-SortGeneratedCounterCell ) $.
${ sorting-cache-529 $p |- ( \imp \top ( \in-sort \kore-symbol-LblinitGeneratedCounterCell \kore-sort-SortGeneratedCounterCell ) ) $= ( IMP-symbol-242-is-pattern IMP-sort-10-is-pattern in-sort-is-pattern top-is-pattern imp-is-pattern proof-rule-prop-1 IMP-symbol-242-sorting proof-rule-mp ) ABCDABCEABCDFGH $. $}
