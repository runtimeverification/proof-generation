$c \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \kore-sort-SortBlock \and \kore-sort-SortKItem \imp |- ) \in-sort ( $.
$v kore-element-var-VE6 kore-element-var-VE5 ph0 ph2 ph1 $.
$d kore-element-var-VE6 kore-element-var-VE5 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
top-intro $a |- \top $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
${ rule-weakening.0 $e |- ph1 $.
   rule-weakening $a |- ( \imp ph0 ph1 ) $. $}
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
IMP-sort-18-is-pattern $a #Pattern \kore-sort-SortBlock $.
kore-element-var-VE5-elementvariable $f #ElementVariable kore-element-var-VE5 $.
kore-element-var-VE6-elementvariable $f #ElementVariable kore-element-var-VE6 $.
typecode-cache-Pattern-253 $a #Pattern kore-element-var-VE5 $.
typecode-cache-Pattern-356 $a #Pattern kore-element-var-VE6 $.
typecode-cache-Pattern-357 $a #Pattern ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE6 \kore-sort-SortBlock ) \top ) ) $.
sorting-cache-1701 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE6 \kore-sort-SortBlock ) \top ) ) ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) ) $.
sorting-cache-1706 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE6 \kore-sort-SortBlock ) \top ) ) ( \in-sort kore-element-var-VE6 \kore-sort-SortBlock ) ) $.
${ sorting-cache-1772 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE6 \kore-sort-SortBlock ) \top ) ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE6 \kore-sort-SortBlock ) \top ) ) ) $= ( typecode-cache-Pattern-357 in-sort-is-pattern top-is-pattern typecode-cache-Pattern-356 IMP-sort-18-is-pattern rule-and-intro-alt2-sugar typecode-cache-Pattern-253 BASIC-K-sort-1-is-pattern and-is-pattern sorting-cache-1701 sorting-cache-1706 top-intro rule-weakening ) ABCAIJDBFGDEKABLABCBFGDEABMABCENOHH $. $}
