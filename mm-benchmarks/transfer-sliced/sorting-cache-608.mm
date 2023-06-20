$c \top #SetVariable \kore-symbol-Lbl'Stop'Map \kore-symbol-Lbl'-LT-'state'-GT-' #ElementVariable #Symbol #Variable #Pattern \imp |- ) \in-sort \kore-sort-SortMap \kore-sort-SortStateCell ( $.
$v ph0 ph2 ptn0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
ptn0-pattern $f #Pattern ptn0 $.
IMP-sort-9-is-pattern $a #Pattern \kore-sort-SortStateCell $.
IMP-sort-14-is-pattern $a #Pattern \kore-sort-SortMap $.
IMP-symbol-124-is-pattern $a #Pattern \kore-symbol-Lbl'Stop'Map $.
IMP-symbol-132-is-pattern $a #Pattern ( \kore-symbol-Lbl'-LT-'state'-GT-' ptn0 ) $.
IMP-symbol-132-sorting $a |- ( \imp ( \in-sort ptn0 \kore-sort-SortMap ) ( \in-sort ( \kore-symbol-Lbl'-LT-'state'-GT-' ptn0 ) \kore-sort-SortStateCell ) ) $.
sorting-cache-44 $a |- ( \imp \top ( \in-sort \kore-symbol-Lbl'Stop'Map \kore-sort-SortMap ) ) $.
${ sorting-cache-608 $p |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'-LT-'state'-GT-' \kore-symbol-Lbl'Stop'Map ) \kore-sort-SortStateCell ) ) $= ( IMP-symbol-124-is-pattern in-sort-is-pattern top-is-pattern IMP-sort-14-is-pattern IMP-symbol-132-is-pattern IMP-sort-9-is-pattern sorting-cache-44 IMP-symbol-132-sorting rule-imp-transitivity ) CADBAEFBGAHI $. $}
