$c "amount" \top \kore-sort-SortAExp #Variable \imp \kore-dv |- \kore-sort-SortId ) \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp \and #SetVariable #ElementVariable #Symbol #Pattern \kore-inj \in-sort \kore-sort-SortStateCell "balanceTo" ( $.
$v ph0 ph2 kore-element-var-VE3 ptn1 ptn0 ph1 $.
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
kore-element-var-VE3-elementvariable $f #ElementVariable kore-element-var-VE3 $.
IMP-sort-9-is-pattern $a #Pattern \kore-sort-SortStateCell $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-symbol-160-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-160-sorting $a |- ( \imp ( \and ( \in-sort ptn0 \kore-sort-SortAExp ) ( \in-sort ptn1 \kore-sort-SortAExp ) ) ( \in-sort ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ptn0 ptn1 ) \kore-sort-SortAExp ) ) $.
string-literal-14-is-pattern $a #Pattern "amount" $.
string-literal-17-is-pattern $a #Pattern "balanceTo" $.
typecode-cache-Pattern-178 $a #Pattern kore-element-var-VE3 $.
sorting-cache-832 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) \top ) ( \in-sort ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) \kore-sort-SortAExp ) ) $.
sorting-cache-845 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) \top ) ( \in-sort ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) \kore-sort-SortAExp ) ) $.
${ sorting-cache-846 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) \top ) ( \in-sort ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) \kore-sort-SortAExp ) ) $= ( IMP-sort-17-is-pattern IMP-sort-13-is-pattern kore-dv-is-pattern kore-inj-is-pattern in-sort-is-pattern string-literal-17-is-pattern string-literal-14-is-pattern and-is-pattern typecode-cache-Pattern-178 IMP-sort-9-is-pattern top-is-pattern IMP-symbol-160-is-pattern sorting-cache-845 sorting-cache-832 rule-and-intro-alt2-sugar IMP-symbol-160-sorting rule-imp-transitivity ) AJKFLIBCBGDECFBCBHDECFIBCBGDEBCBHDEMCFAJKFLIBCBGDECFBCBHDECFANAOPBCBGDEBCBHDEQR $. $}
