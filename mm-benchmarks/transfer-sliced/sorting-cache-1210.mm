$c \kore-sort-SortKResult #SetVariable #ElementVariable #Symbol #Variable #Pattern \and \kore-sort-SortKItem \imp \kore-is-sort |- ) \in-sort ( $.
$v ph0 ph2 ph1 kore-element-var-VE2 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
kore-element-var-VE2-elementvariable $f #ElementVariable kore-element-var-VE2 $.
IMP-sort-28-is-pattern $a #Pattern \kore-sort-SortKResult $.
typecode-cache-Pattern-177 $a #Pattern kore-element-var-VE2 $.
sorting-cache-1194 $a |- ( \imp ( \in-sort kore-element-var-VE2 \kore-sort-SortKResult ) ( \kore-is-sort \kore-sort-SortKItem ) ) $.
sorting-cache-1209 $a |- ( \imp ( \in-sort kore-element-var-VE2 \kore-sort-SortKResult ) ( \kore-is-sort \kore-sort-SortKResult ) ) $.
${ sorting-cache-1210 $p |- ( \imp ( \in-sort kore-element-var-VE2 \kore-sort-SortKResult ) ( \and ( \kore-is-sort \kore-sort-SortKResult ) ( \kore-is-sort \kore-sort-SortKItem ) ) ) $= ( IMP-sort-28-is-pattern kore-is-sort-is-pattern typecode-cache-Pattern-177 in-sort-is-pattern BASIC-K-sort-1-is-pattern sorting-cache-1209 sorting-cache-1194 rule-and-intro-alt2-sugar ) ADBEBCFCAGAHI $. $}
