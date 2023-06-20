$c \unit-sort \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \imp \kore-is-sort |- ) ( $.
$v ph0 sg0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
sg0-is-symbol $f #Symbol sg0 $.
symbol-is-pattern $a #Pattern sg0 $.
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
proof-rule-prop-1 $a |- ( \imp ph0 ( \imp ph1 ph0 ) ) $.
${ proof-rule-mp.0 $e |- ( \imp ph0 ph1 ) $.
   proof-rule-mp.1 $e |- ph0 $.
   proof-rule-mp $a |- ph1 $. $}
top-is-pattern $a #Pattern \top $.
unit-sort-is-symbol $a #Symbol \unit-sort $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
unit-sort-is-kore-sort $a |- ( \kore-is-sort \unit-sort ) $.
${ sorting-cache-128 $p |- ( \imp \top ( \kore-is-sort \unit-sort ) ) $= ( unit-sort-is-symbol symbol-is-pattern kore-is-sort-is-pattern top-is-pattern imp-is-pattern proof-rule-prop-1 unit-sort-is-kore-sort proof-rule-mp ) ABCDABCEABCDFGH $. $}
