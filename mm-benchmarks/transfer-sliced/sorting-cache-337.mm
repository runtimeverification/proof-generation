$c \top "balanceSender" \kore-sort-SortAExp \kore-sort-SortStmt #Variable \imp \kore-dv \kore-is-sort |- \kore-sort-SortId ) \and #SetVariable #ElementVariable #Symbol #Pattern "100" \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp \kore-inj \kore-sort-SortInt \in-sort ( $.
$v kore-sort-var-R ph0 ph2 ptn1 ptn0 ph1 $.
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
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
ptn0-pattern $f #Pattern ptn0 $.
ptn1-pattern $f #Pattern ptn1 $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-sort-31-is-pattern $a #Pattern \kore-sort-SortStmt $.
IMP-symbol-185-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-185-sorting $a |- ( \imp ( \and ( \in-sort ptn0 \kore-sort-SortId ) ( \in-sort ptn1 \kore-sort-SortAExp ) ) ( \in-sort ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ptn0 ptn1 ) \kore-sort-SortStmt ) ) $.
string-literal-10-is-pattern $a #Pattern "balanceSender" $.
string-literal-16-is-pattern $a #Pattern "100" $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
sorting-cache-137 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \in-sort ( \kore-dv \kore-sort-SortId "balanceSender" ) \kore-sort-SortId ) ) $.
sorting-cache-336 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \in-sort ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "100" ) ) \kore-sort-SortAExp ) ) $.
${ sorting-cache-337 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \in-sort ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "100" ) ) ) \kore-sort-SortStmt ) ) $= ( kore-dv-is-pattern IMP-sort-23-is-pattern IMP-sort-17-is-pattern IMP-sort-13-is-pattern in-sort-is-pattern string-literal-10-is-pattern string-literal-16-is-pattern kore-inj-is-pattern and-is-pattern typecode-cache-Pattern-0 kore-is-sort-is-pattern top-is-pattern IMP-symbol-185-is-pattern IMP-sort-31-is-pattern sorting-cache-137 sorting-cache-336 rule-and-intro-alt2-sugar IMP-symbol-185-sorting rule-imp-transitivity ) AKLMJDGBDFCECHBIEFJDGBCECHBINOFAKLMJDGBDFCECHBIEFAPAQRDGBCECHBIST $. $}
