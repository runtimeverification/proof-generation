$c \top #SetVariable \kore-symbol-Lbl'Stop'Map #ElementVariable \kore-symbol-Lbl'Unds'Map'Unds' #Symbol #Variable #Pattern \and \imp |- ) \in-sort \kore-sort-SortMap ( $.
$v ph0 ph2 ptn0 ph1 ptn1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
ptn0-pattern $f #Pattern ptn0 $.
ptn1-pattern $f #Pattern ptn1 $.
IMP-sort-14-is-pattern $a #Pattern \kore-sort-SortMap $.
IMP-symbol-124-is-pattern $a #Pattern \kore-symbol-Lbl'Stop'Map $.
IMP-symbol-194-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds'Map'Unds' ptn0 ptn1 ) $.
IMP-symbol-194-sorting $a |- ( \imp ( \and ( \in-sort ptn0 \kore-sort-SortMap ) ( \in-sort ptn1 \kore-sort-SortMap ) ) ( \in-sort ( \kore-symbol-Lbl'Unds'Map'Unds' ptn0 ptn1 ) \kore-sort-SortMap ) ) $.
sorting-cache-44 $a |- ( \imp \top ( \in-sort \kore-symbol-Lbl'Stop'Map \kore-sort-SortMap ) ) $.
${ sorting-cache-688 $p |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'Unds'Map'Unds' \kore-symbol-Lbl'Stop'Map \kore-symbol-Lbl'Stop'Map ) \kore-sort-SortMap ) ) $= ( IMP-symbol-124-is-pattern IMP-sort-14-is-pattern in-sort-is-pattern top-is-pattern sorting-cache-44 and-is-pattern IMP-symbol-194-is-pattern rule-and-intro-alt2-sugar IMP-symbol-194-sorting rule-imp-transitivity ) DABCABCFAAGBCDABCABCEEHAAIJ $. $}
