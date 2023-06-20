$c \unit-sort \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \and \imp \kore-is-sort |- ) ( $.
$v ph0 ph2 sg0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
sg0-is-symbol $f #Symbol sg0 $.
symbol-is-pattern $a #Pattern sg0 $.
top-is-pattern $a #Pattern \top $.
unit-sort-is-symbol $a #Symbol \unit-sort $.
top-intro $a |- \top $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
${ rule-weakening.0 $e |- ph1 $.
   rule-weakening $a |- ( \imp ph0 ph1 ) $. $}
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
sorting-cache-128 $a |- ( \imp \top ( \kore-is-sort \unit-sort ) ) $.
${ sorting-cache-129 $p |- ( \imp \top ( \and ( \kore-is-sort \unit-sort ) \top ) ) $= ( top-is-pattern unit-sort-is-symbol symbol-is-pattern kore-is-sort-is-pattern sorting-cache-128 top-intro rule-weakening rule-and-intro-alt2-sugar ) ABCDAEAAFGH $. $}
