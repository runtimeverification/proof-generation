$c "amount" \top #SetVariable \kore-sort-SortAExp #ElementVariable #Symbol \kore-sort-SortStmt #Variable #Pattern "10" \and \imp \kore-dv |- \kore-sort-SortId ) \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp \kore-inj \kore-sort-SortInt \in-sort ( $.
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
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-sort-31-is-pattern $a #Pattern \kore-sort-SortStmt $.
IMP-symbol-185-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-185-sorting $a |- ( \imp ( \and ( \in-sort ptn0 \kore-sort-SortId ) ( \in-sort ptn1 \kore-sort-SortAExp ) ) ( \in-sort ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ptn0 ptn1 ) \kore-sort-SortStmt ) ) $.
string-literal-13-is-pattern $a #Pattern "10" $.
string-literal-14-is-pattern $a #Pattern "amount" $.
sorting-cache-3 $a |- ( \imp \top ( \in-sort ( \kore-dv \kore-sort-SortId "amount" ) \kore-sort-SortId ) ) $.
sorting-cache-19 $a |- ( \imp \top ( \in-sort ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "10" ) ) \kore-sort-SortAExp ) ) $.
${ sorting-cache-20 $p |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "amount" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "10" ) ) ) \kore-sort-SortStmt ) ) $= ( kore-dv-is-pattern IMP-sort-23-is-pattern IMP-sort-17-is-pattern IMP-sort-13-is-pattern in-sort-is-pattern string-literal-14-is-pattern string-literal-13-is-pattern kore-inj-is-pattern top-is-pattern and-is-pattern IMP-symbol-185-is-pattern IMP-sort-31-is-pattern sorting-cache-3 sorting-cache-19 rule-and-intro-alt2-sugar IMP-symbol-185-sorting rule-imp-transitivity ) ICFACEBDBGAHDEJCFABDBGAHKLEICFACEBDBGAHDEMNOCFABDBGAHPQ $. $}
