$c \kore-symbol-Lbl'Hash'freezer'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp0'Unds' "amount" \top \kore-symbol-kseq #Variable \kore-sort-SortK \imp \kore-dv |- \kore-sort-SortId ) #SetVariable #ElementVariable #Symbol #Pattern \kore-sort-SortKItem \kore-inj \in-sort \kore-symbol-dotk ( $.
$v ph0 ph2 ptn0 ph1 ptn1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
BASIC-K-sort-0-is-pattern $a #Pattern \kore-sort-SortK $.
ptn0-pattern $f #Pattern ptn0 $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
ptn1-pattern $f #Pattern ptn1 $.
KSEQ-symbol-0-is-pattern $a #Pattern ( \kore-symbol-kseq ptn0 ptn1 ) $.
KSEQ-symbol-1-is-pattern $a #Pattern \kore-symbol-dotk $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-symbol-81-is-pattern $a #Pattern ( \kore-symbol-Lbl'Hash'freezer'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp0'Unds' ptn0 ) $.
IMP-symbol-81-sorting $a |- ( \imp ( \in-sort ptn0 \kore-sort-SortK ) ( \in-sort ( \kore-symbol-Lbl'Hash'freezer'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp0'Unds' ptn0 ) \kore-sort-SortKItem ) ) $.
string-literal-14-is-pattern $a #Pattern "amount" $.
sorting-cache-191 $a |- ( \imp \top ( \in-sort ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) \kore-symbol-dotk ) \kore-sort-SortK ) ) $.
${ sorting-cache-192 $p |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'Hash'freezer'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp0'Unds' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) \kore-symbol-dotk ) ) \kore-sort-SortKItem ) ) $= ( IMP-sort-17-is-pattern BASIC-K-sort-1-is-pattern string-literal-14-is-pattern kore-dv-is-pattern kore-inj-is-pattern KSEQ-symbol-1-is-pattern KSEQ-symbol-0-is-pattern in-sort-is-pattern top-is-pattern BASIC-K-sort-0-is-pattern IMP-symbol-81-is-pattern sorting-cache-191 IMP-symbol-81-sorting rule-imp-transitivity ) IABACDEFGJHABACDEFGKBHLABACDEFGMN $. $}
