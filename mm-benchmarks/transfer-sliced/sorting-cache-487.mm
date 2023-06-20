$c \kore-symbol-Lbl'Stop'List'LBraQuotUndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids'QuotRBraUnds'Ids \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \kore-sort-SortIds \and \imp \kore-dv \kore-is-sort "ret" |- \kore-sort-SortId ) \in-sort ( $.
$v kore-sort-var-R ph0 ph2 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-0-is-pattern $a #Pattern \kore-sort-SortIds $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-symbol-123-is-pattern $a #Pattern \kore-symbol-Lbl'Stop'List'LBraQuotUndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids'QuotRBraUnds'Ids $.
string-literal-11-is-pattern $a #Pattern "ret" $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
sorting-cache-485 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) \top ) ( \in-sort ( \kore-dv \kore-sort-SortId "ret" ) \kore-sort-SortId ) ) $.
sorting-cache-486 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) \top ) ( \in-sort \kore-symbol-Lbl'Stop'List'LBraQuotUndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids'QuotRBraUnds'Ids \kore-sort-SortIds ) ) $.
${ sorting-cache-487 $p |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) \top ) ( \and ( \in-sort ( \kore-dv \kore-sort-SortId "ret" ) \kore-sort-SortId ) ( \in-sort \kore-symbol-Lbl'Stop'List'LBraQuotUndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids'QuotRBraUnds'Ids \kore-sort-SortIds ) ) ) $= ( top-is-pattern and-is-pattern IMP-sort-17-is-pattern in-sort-is-pattern typecode-cache-Pattern-0 kore-is-sort-is-pattern string-literal-11-is-pattern kore-dv-is-pattern IMP-symbol-123-is-pattern IMP-sort-0-is-pattern sorting-cache-485 sorting-cache-486 rule-and-intro-alt2-sugar ) AFGBCBCDHIDEJKEALAMN $. $}
