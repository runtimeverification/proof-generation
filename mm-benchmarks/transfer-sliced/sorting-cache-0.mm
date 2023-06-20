$c \top #SetVariable \kore-sort-SortGeneratedTopCell #ElementVariable #Symbol #Variable #Pattern \imp |- ) \in-sort \kore-top ( $.
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
kore-top-is-pattern $a #Pattern ( \kore-top ph0 ) $.
kore-top-sorting $a |- ( \in-sort ( \kore-top ph0 ) ph0 ) $.
IMP-sort-8-is-pattern $a #Pattern \kore-sort-SortGeneratedTopCell $.
${ sorting-cache-0 $p |- ( \imp \top ( \in-sort ( \kore-top \kore-sort-SortGeneratedTopCell ) \kore-sort-SortGeneratedTopCell ) ) $= ( IMP-sort-8-is-pattern kore-top-is-pattern in-sort-is-pattern top-is-pattern imp-is-pattern proof-rule-prop-1 kore-top-sorting proof-rule-mp ) ABACDABACEABACDFAGH $. $}
