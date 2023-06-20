$c "amount" \top "balanceSender" #Variable \kore-sort-SortIds \imp \kore-dv \kore-is-sort |- \kore-sort-SortId ) \and \kore-symbol-Lbl'Stop'List'LBraQuotUndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids'QuotRBraUnds'Ids #SetVariable #ElementVariable #Symbol #Pattern \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids "ret" "addressTo" \in-sort \kore-sort-SortMap "balanceTo" ( $.
$v kore-sort-var-R ph0 ph2 kore-element-var-VE1 ptn1 ptn0 ph1 $.
$d kore-sort-var-R kore-element-var-VE1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
proof-rule-prop-1 $a |- ( \imp ph0 ( \imp ph1 ph0 ) ) $.
${ proof-rule-mp.0 $e |- ( \imp ph0 ph1 ) $.
   proof-rule-mp.1 $e |- ph0 $.
   proof-rule-mp $a |- ph1 $. $}
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-dv-sorting $a |- ( \in-sort ( \kore-dv ph0 ph1 ) ph0 ) $.
ptn0-pattern $f #Pattern ptn0 $.
ptn1-pattern $f #Pattern ptn1 $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
kore-element-var-VE1-elementvariable $f #ElementVariable kore-element-var-VE1 $.
IMP-sort-0-is-pattern $a #Pattern \kore-sort-SortIds $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-symbol-123-is-pattern $a #Pattern \kore-symbol-Lbl'Stop'List'LBraQuotUndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids'QuotRBraUnds'Ids $.
IMP-symbol-161-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids ptn0 ptn1 ) $.
IMP-symbol-161-sorting $a |- ( \imp ( \and ( \in-sort ptn0 \kore-sort-SortId ) ( \in-sort ptn1 \kore-sort-SortIds ) ) ( \in-sort ( \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids ptn0 ptn1 ) \kore-sort-SortIds ) ) $.
string-literal-10-is-pattern $a #Pattern "balanceSender" $.
string-literal-11-is-pattern $a #Pattern "ret" $.
string-literal-14-is-pattern $a #Pattern "amount" $.
string-literal-17-is-pattern $a #Pattern "balanceTo" $.
string-literal-18-is-pattern $a #Pattern "addressTo" $.
typecode-cache-Pattern-147 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortMap ) \top ) ) $.
sorting-cache-444 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortMap ) \top ) ) ( \in-sort ( \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids ( \kore-dv \kore-sort-SortId "amount" ) ( \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids ( \kore-dv \kore-sort-SortId "ret" ) \kore-symbol-Lbl'Stop'List'LBraQuotUndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids'QuotRBraUnds'Ids ) ) ) ) \kore-sort-SortIds ) ) $.
${ sorting-cache-445 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortMap ) \top ) ) ( \in-sort ( \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids ( \kore-dv \kore-sort-SortId "addressTo" ) ( \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids ( \kore-dv \kore-sort-SortId "amount" ) ( \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids ( \kore-dv \kore-sort-SortId "ret" ) \kore-symbol-Lbl'Stop'List'LBraQuotUndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids'QuotRBraUnds'Ids ) ) ) ) ) \kore-sort-SortIds ) ) $= ( IMP-sort-17-is-pattern kore-dv-is-pattern IMP-symbol-161-is-pattern string-literal-18-is-pattern in-sort-is-pattern typecode-cache-Pattern-147 string-literal-14-is-pattern string-literal-10-is-pattern string-literal-17-is-pattern string-literal-11-is-pattern IMP-symbol-123-is-pattern IMP-sort-0-is-pattern and-is-pattern imp-is-pattern proof-rule-prop-1 kore-dv-sorting proof-rule-mp sorting-cache-444 rule-and-intro-alt2-sugar IMP-symbol-161-sorting rule-imp-transitivity ) ABHCFDCGCIDCJDCKDCLDMEEEENGOCFDCIDCJDCKDCLDMEEEEENGABHCFDCGCIDCJDCKDCLDMEEEENGCFDCGABHCFDCGPCFDCGABHQCFRSABTUACFDCIDCJDCKDCLDMEEEEUBUC $. $}
