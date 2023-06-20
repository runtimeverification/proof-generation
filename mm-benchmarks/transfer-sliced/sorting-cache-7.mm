$c \kore-symbol-Lbl'Stop'List'LBraQuotUndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids'QuotRBraUnds'Ids \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \kore-sort-SortIds \imp |- ) \in-sort ( $.
$v ph0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
proof-rule-prop-1 $a |- ( \imp ph0 ( \imp ph1 ph0 ) ) $.
${ proof-rule-mp.0 $e |- ( \imp ph0 ph1 ) $.
   proof-rule-mp.1 $e |- ph0 $.
   proof-rule-mp $a |- ph1 $. $}
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
IMP-sort-0-is-pattern $a #Pattern \kore-sort-SortIds $.
IMP-symbol-123-is-pattern $a #Pattern \kore-symbol-Lbl'Stop'List'LBraQuotUndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids'QuotRBraUnds'Ids $.
IMP-symbol-123-sorting $a |- ( \in-sort \kore-symbol-Lbl'Stop'List'LBraQuotUndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids'QuotRBraUnds'Ids \kore-sort-SortIds ) $.
${ sorting-cache-7 $p |- ( \imp \top ( \in-sort \kore-symbol-Lbl'Stop'List'LBraQuotUndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids'QuotRBraUnds'Ids \kore-sort-SortIds ) ) $= ( IMP-symbol-123-is-pattern IMP-sort-0-is-pattern in-sort-is-pattern top-is-pattern imp-is-pattern proof-rule-prop-1 IMP-symbol-123-sorting proof-rule-mp ) ABCDABCEABCDFGH $. $}
