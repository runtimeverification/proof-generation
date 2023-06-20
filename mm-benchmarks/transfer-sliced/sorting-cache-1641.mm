$c \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \and \imp |- ) \kore-sort-SortInt \in-sort \kore-sort-SortStateCell ( $.
$v kore-element-var-VE4 ph0 ph2 kore-element-var-VE3 ph1 $.
$d kore-element-var-VE3 kore-element-var-VE4 $.
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
kore-element-var-VE3-elementvariable $f #ElementVariable kore-element-var-VE3 $.
kore-element-var-VE4-elementvariable $f #ElementVariable kore-element-var-VE4 $.
IMP-sort-9-is-pattern $a #Pattern \kore-sort-SortStateCell $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
typecode-cache-Pattern-178 $a #Pattern kore-element-var-VE3 $.
typecode-cache-Pattern-179 $a #Pattern kore-element-var-VE4 $.
typecode-cache-Pattern-347 $a #Pattern ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortInt ) \top ) ) $.
sorting-cache-1624 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortInt ) \top ) ) ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ) $.
sorting-cache-1627 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortInt ) \top ) ) ( \in-sort kore-element-var-VE4 \kore-sort-SortInt ) ) $.
${ sorting-cache-1641 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortInt ) \top ) ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortInt ) \top ) ) ) $= ( typecode-cache-Pattern-347 in-sort-is-pattern top-is-pattern typecode-cache-Pattern-179 IMP-sort-23-is-pattern rule-and-intro-alt2-sugar typecode-cache-Pattern-178 IMP-sort-9-is-pattern and-is-pattern sorting-cache-1624 sorting-cache-1627 top-intro rule-weakening ) ABCAIJDBFGDEKABLABCBFGDEABMABCENOHH $. $}
