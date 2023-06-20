$c \kore-sort-SortBExp \top #SetVariable \kore-sort-SortAExp #ElementVariable #Symbol \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp #Variable #Pattern "10" \and \imp \kore-dv |- "100" ) \kore-inj \kore-sort-SortInt \in-sort ( $.
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
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
ptn0-pattern $f #Pattern ptn0 $.
ptn1-pattern $f #Pattern ptn1 $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-22-is-pattern $a #Pattern \kore-sort-SortBExp $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-symbol-192-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-192-sorting $a |- ( \imp ( \and ( \in-sort ptn0 \kore-sort-SortAExp ) ( \in-sort ptn1 \kore-sort-SortAExp ) ) ( \in-sort ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ptn0 ptn1 ) \kore-sort-SortBExp ) ) $.
string-literal-13-is-pattern $a #Pattern "10" $.
string-literal-16-is-pattern $a #Pattern "100" $.
sorting-cache-19 $a |- ( \imp \top ( \in-sort ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "10" ) ) \kore-sort-SortAExp ) ) $.
sorting-cache-23 $a |- ( \imp \top ( \in-sort ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "100" ) ) \kore-sort-SortAExp ) ) $.
${ sorting-cache-174 $p |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "10" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "100" ) ) ) \kore-sort-SortBExp ) ) $= ( IMP-sort-23-is-pattern IMP-sort-13-is-pattern kore-dv-is-pattern kore-inj-is-pattern in-sort-is-pattern string-literal-13-is-pattern string-literal-16-is-pattern top-is-pattern and-is-pattern IMP-symbol-192-is-pattern IMP-sort-22-is-pattern sorting-cache-19 sorting-cache-23 rule-and-intro-alt2-sugar IMP-symbol-192-sorting rule-imp-transitivity ) HABAFCDBEABAGCDBEIABAFCDABAGCDJKEHABAFCDBEABAGCDBELMNABAFCDABAGCDOP $. $}
