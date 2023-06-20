$c \kore-sort-SortBExp \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \kore-sort-SortBlock \and \imp |- ) \in-sort ( $.
$v kore-element-var-VE5 kore-element-var-VE4 ph0 ph2 ph1 $.
$d kore-element-var-VE5 kore-element-var-VE4 $.
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
kore-element-var-VE4-elementvariable $f #ElementVariable kore-element-var-VE4 $.
IMP-sort-18-is-pattern $a #Pattern \kore-sort-SortBlock $.
IMP-sort-22-is-pattern $a #Pattern \kore-sort-SortBExp $.
kore-element-var-VE5-elementvariable $f #ElementVariable kore-element-var-VE5 $.
typecode-cache-Pattern-179 $a #Pattern kore-element-var-VE4 $.
typecode-cache-Pattern-253 $a #Pattern kore-element-var-VE5 $.
typecode-cache-Pattern-263 $a #Pattern ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortBExp ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortBlock ) \top ) ) $.
sorting-cache-1096 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortBExp ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortBlock ) \top ) ) ( \in-sort kore-element-var-VE4 \kore-sort-SortBExp ) ) $.
sorting-cache-1100 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortBExp ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortBlock ) \top ) ) ( \in-sort kore-element-var-VE5 \kore-sort-SortBlock ) ) $.
${ sorting-cache-1137 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortBExp ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortBlock ) \top ) ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortBExp ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortBlock ) \top ) ) ) $= ( typecode-cache-Pattern-263 in-sort-is-pattern top-is-pattern typecode-cache-Pattern-253 IMP-sort-18-is-pattern rule-and-intro-alt2-sugar typecode-cache-Pattern-179 IMP-sort-22-is-pattern and-is-pattern sorting-cache-1096 sorting-cache-1100 top-intro rule-weakening ) ABCAIJDBFGDEKABLABCBFGDEABMABCENOHH $. $}
