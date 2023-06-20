$c \kore-sort-SortKResult \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \kore-sort-SortBool \imp ( \kore-is-sort |- ) \and $.
$v kore-sort-var-R ph0 ph2 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-28-is-pattern $a #Pattern \kore-sort-SortKResult $.
IMP-sort-32-is-pattern $a #Pattern \kore-sort-SortBool $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
sorting-cache-1565 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-is-sort \kore-sort-SortKResult ) ) $.
sorting-cache-1791 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-is-sort \kore-sort-SortBool ) ) $.
${ sorting-cache-1792 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \kore-is-sort \kore-sort-SortBool ) ( \kore-is-sort \kore-sort-SortKResult ) ) ) $= ( kore-is-sort-is-pattern typecode-cache-Pattern-0 top-is-pattern and-is-pattern IMP-sort-32-is-pattern IMP-sort-28-is-pattern sorting-cache-1791 sorting-cache-1565 rule-and-intro-alt2-sugar ) ACBDEFBGBAHAIJ $. $}
