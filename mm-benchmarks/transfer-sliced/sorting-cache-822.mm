$c \top "balanceSender" \kore-sort-SortAExp \kore-sort-SortStmt #Variable \imp \kore-dv |- \kore-sort-SortId ) \and #SetVariable #ElementVariable #Symbol #Pattern "100" \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp \kore-inj \kore-sort-SortInt \in-sort \kore-sort-SortStateCell ( $.
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
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-sort-31-is-pattern $a #Pattern \kore-sort-SortStmt $.
IMP-symbol-185-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-185-sorting $a |- ( \imp ( \and ( \in-sort ptn0 \kore-sort-SortId ) ( \in-sort ptn1 \kore-sort-SortAExp ) ) ( \in-sort ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ptn0 ptn1 ) \kore-sort-SortStmt ) ) $.
string-literal-10-is-pattern $a #Pattern "balanceSender" $.
string-literal-16-is-pattern $a #Pattern "100" $.
typecode-cache-Pattern-178 $a #Pattern kore-element-var-VE3 $.
sorting-cache-818 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) \top ) ( \in-sort ( \kore-dv \kore-sort-SortId "balanceSender" ) \kore-sort-SortId ) ) $.
sorting-cache-821 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) \top ) ( \in-sort ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "100" ) ) \kore-sort-SortAExp ) ) $.
${ sorting-cache-822 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) \top ) ( \in-sort ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "100" ) ) ) \kore-sort-SortStmt ) ) $= ( kore-dv-is-pattern IMP-sort-23-is-pattern in-sort-is-pattern IMP-sort-17-is-pattern IMP-sort-13-is-pattern string-literal-10-is-pattern string-literal-16-is-pattern kore-inj-is-pattern and-is-pattern typecode-cache-Pattern-178 IMP-sort-9-is-pattern top-is-pattern IMP-symbol-185-is-pattern IMP-sort-31-is-pattern sorting-cache-818 sorting-cache-821 rule-and-intro-alt2-sugar IMP-symbol-185-sorting rule-imp-transitivity ) AKLDMJEGBEDCFCHBIFDJEGBCFCHBINODAKLDMJEGBEDCFCHBIFDAPAQREGBCFCHBIST $. $}
