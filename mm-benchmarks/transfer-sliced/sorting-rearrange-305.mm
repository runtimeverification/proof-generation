$c \top #SetVariable \kore-symbol-Lbl'Stop'Map #ElementVariable \kore-symbol-Lbl'Unds'Map'Unds' #Symbol #Variable #Pattern \and \imp \kore-is-sort |- \kore-valid ) \kore-equals \in-sort \kore-sort-SortMap ( $.
$v kore-sort-var-R ph0 ph2 ptn1 ph3 ptn0 ph1 kore-element-var-K $.
$d kore-sort-var-R kore-element-var-K $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
kore-valid-is-pattern $a #Pattern ( \kore-valid ph0 ph1 ) $.
kore-equals-is-pattern $a #Pattern ( \kore-equals ph0 ph1 ph2 ph3 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
ptn0-pattern $f #Pattern ptn0 $.
ptn1-pattern $f #Pattern ptn1 $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-14-is-pattern $a #Pattern \kore-sort-SortMap $.
IMP-symbol-124-is-pattern $a #Pattern \kore-symbol-Lbl'Stop'Map $.
IMP-symbol-194-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds'Map'Unds' ptn0 ptn1 ) $.
kore-element-var-K-elementvariable $f #ElementVariable kore-element-var-K $.
IMP-axiom-3026 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K \kore-sort-SortMap ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-equals \kore-sort-SortMap kore-sort-var-R ( \kore-symbol-Lbl'Unds'Map'Unds' kore-element-var-K \kore-symbol-Lbl'Stop'Map ) kore-element-var-K ) ) ) $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-189 $a #Pattern kore-element-var-K $.
sorting-cache-686 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \in-sort kore-element-var-K \kore-sort-SortMap ) \top ) ) ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K \kore-sort-SortMap ) \top ) ) ) $.
typecode-cache-Pattern-190 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K \kore-sort-SortMap ) \top ) ) $.
${ sorting-rearrange-305 $p |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \in-sort kore-element-var-K \kore-sort-SortMap ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-equals \kore-sort-SortMap kore-sort-var-R ( \kore-symbol-Lbl'Unds'Map'Unds' kore-element-var-K \kore-symbol-Lbl'Stop'Map ) kore-element-var-K ) ) ) $= ( typecode-cache-Pattern-0 and-is-pattern typecode-cache-Pattern-189 top-is-pattern IMP-sort-14-is-pattern kore-is-sort-is-pattern in-sort-is-pattern typecode-cache-Pattern-190 IMP-symbol-124-is-pattern IMP-symbol-194-is-pattern kore-equals-is-pattern kore-valid-is-pattern sorting-cache-686 IMP-axiom-3026 rule-imp-transitivity ) ACHFDBEGIFDDABJACGACBEKLBEMNABOABPQ $. $}
