$c "amount" \top "balanceSender" \kore-sort-SortAExp #Variable \kore-sort-SortIds \imp \kore-dv |- \kore-sort-SortId ) \and #SetVariable #ElementVariable #Symbol #Pattern \kore-inj \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp \in-sort ( $.
$v ph0 ph2 ptn1 kore-element-var-VE4 ptn0 ph1 $.
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
kore-element-var-VE4-elementvariable $f #ElementVariable kore-element-var-VE4 $.
IMP-sort-0-is-pattern $a #Pattern \kore-sort-SortIds $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-symbol-164-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-164-sorting $a |- ( \imp ( \and ( \in-sort ptn0 \kore-sort-SortAExp ) ( \in-sort ptn1 \kore-sort-SortAExp ) ) ( \in-sort ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ptn0 ptn1 ) \kore-sort-SortAExp ) ) $.
string-literal-10-is-pattern $a #Pattern "balanceSender" $.
string-literal-14-is-pattern $a #Pattern "amount" $.
typecode-cache-Pattern-179 $a #Pattern kore-element-var-VE4 $.
sorting-cache-662 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortIds ) \top ) ( \in-sort ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) \kore-sort-SortAExp ) ) $.
sorting-cache-664 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortIds ) \top ) ( \in-sort ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) \kore-sort-SortAExp ) ) $.
${ sorting-cache-672 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortIds ) \top ) ( \in-sort ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) \kore-sort-SortAExp ) ) $= ( IMP-sort-17-is-pattern IMP-sort-13-is-pattern kore-dv-is-pattern kore-inj-is-pattern in-sort-is-pattern string-literal-10-is-pattern string-literal-14-is-pattern and-is-pattern typecode-cache-Pattern-179 IMP-sort-0-is-pattern top-is-pattern IMP-symbol-164-is-pattern sorting-cache-664 sorting-cache-662 rule-and-intro-alt2-sugar IMP-symbol-164-sorting rule-imp-transitivity ) AJKFLIBCBGDECFBCBHDECFIBCBGDEBCBHDEMCFAJKFLIBCBGDECFBCBHDECFANAOPBCBGDEBCBHDEQR $. $}
