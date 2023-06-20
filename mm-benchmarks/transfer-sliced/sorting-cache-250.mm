$c \kore-sort-SortKCell \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \kore-sort-SortK \imp |- ) \kore-symbol-Lbl'-LT-'k'-GT-' \in-sort \kore-symbol-dotk ( $.
$v ph0 ph2 ptn0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
BASIC-K-sort-0-is-pattern $a #Pattern \kore-sort-SortK $.
ptn0-pattern $f #Pattern ptn0 $.
KSEQ-symbol-1-is-pattern $a #Pattern \kore-symbol-dotk $.
IMP-sort-7-is-pattern $a #Pattern \kore-sort-SortKCell $.
IMP-symbol-131-is-pattern $a #Pattern ( \kore-symbol-Lbl'-LT-'k'-GT-' ptn0 ) $.
IMP-symbol-131-sorting $a |- ( \imp ( \in-sort ptn0 \kore-sort-SortK ) ( \in-sort ( \kore-symbol-Lbl'-LT-'k'-GT-' ptn0 ) \kore-sort-SortKCell ) ) $.
sorting-cache-43 $a |- ( \imp \top ( \in-sort \kore-symbol-dotk \kore-sort-SortK ) ) $.
${ sorting-cache-250 $p |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'-LT-'k'-GT-' \kore-symbol-dotk ) \kore-sort-SortKCell ) ) $= ( KSEQ-symbol-1-is-pattern in-sort-is-pattern top-is-pattern BASIC-K-sort-0-is-pattern IMP-symbol-131-is-pattern IMP-sort-7-is-pattern sorting-cache-43 IMP-symbol-131-sorting rule-imp-transitivity ) CADBAEFBGAHI $. $}
