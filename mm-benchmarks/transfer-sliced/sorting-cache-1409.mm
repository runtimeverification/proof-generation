$c \top \kore-sort-SortAExp #Variable \imp \kore-dv "0" \kore-is-sort |- \kore-sort-SortId ) \and #SetVariable #ElementVariable #Symbol #Pattern \kore-sort-SortBlock \kore-sort-SortKItem \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt "ret" \kore-inj \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp \kore-sort-SortInt \in-sort \kore-sort-SortMap \kore-sort-SortStateCell ( $.
$v ph0 ph2 kore-element-var-VE3 kore-element-var-VE2 ptn1 kore-element-var-VE5 kore-element-var-VE4 ptn2 ptn0 ph1 $.
$d kore-element-var-VE3 kore-element-var-VE4 $.
$d kore-element-var-VE5 kore-element-var-VE2 $.
$d kore-element-var-VE4 kore-element-var-VE2 $.
$d kore-element-var-VE5 kore-element-var-VE4 $.
$d kore-element-var-VE5 kore-element-var-VE3 $.
$d kore-element-var-VE3 kore-element-var-VE2 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
ptn0-pattern $f #Pattern ptn0 $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
ptn1-pattern $f #Pattern ptn1 $.
ptn2-pattern $f #Pattern ptn2 $.
kore-element-var-VE2-elementvariable $f #ElementVariable kore-element-var-VE2 $.
kore-element-var-VE3-elementvariable $f #ElementVariable kore-element-var-VE3 $.
kore-element-var-VE4-elementvariable $f #ElementVariable kore-element-var-VE4 $.
INJ-symbol-0-sorting $a |- ( \imp ( \and ( \and ( \kore-is-sort ptn0 ) ( \kore-is-sort ptn1 ) ) ( \in-sort ptn2 ptn0 ) ) ( \in-sort ( \kore-inj ptn0 ptn1 ptn2 ) ptn1 ) ) $.
IMP-sort-9-is-pattern $a #Pattern \kore-sort-SortStateCell $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-18-is-pattern $a #Pattern \kore-sort-SortBlock $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-symbol-185-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-354-is-pattern $a #Pattern ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ptn0 ) $.
string-literal-1-is-pattern $a #Pattern "0" $.
kore-element-var-VE5-elementvariable $f #ElementVariable kore-element-var-VE5 $.
string-literal-11-is-pattern $a #Pattern "ret" $.
typecode-cache-Pattern-177 $a #Pattern kore-element-var-VE2 $.
typecode-cache-Pattern-178 $a #Pattern kore-element-var-VE3 $.
typecode-cache-Pattern-308 $a #Pattern ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortId ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortMap ) \top ) ) $.
sorting-cache-1408 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortId ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortMap ) \top ) ) ) ) ( \and ( \and ( \kore-is-sort \kore-sort-SortBlock ) ( \kore-is-sort \kore-sort-SortKItem ) ) ( \in-sort ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) \kore-sort-SortBlock ) ) ) $.
${ sorting-cache-1409 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortId ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortMap ) \top ) ) ) ) ( \in-sort ( \kore-inj \kore-sort-SortBlock \kore-sort-SortKItem ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) \kore-sort-SortKItem ) ) $= ( kore-dv-is-pattern IMP-sort-23-is-pattern BASIC-K-sort-1-is-pattern in-sort-is-pattern and-is-pattern IMP-sort-18-is-pattern kore-inj-is-pattern IMP-sort-17-is-pattern string-literal-11-is-pattern IMP-sort-13-is-pattern string-literal-1-is-pattern IMP-symbol-185-is-pattern IMP-symbol-354-is-pattern kore-is-sort-is-pattern typecode-cache-Pattern-177 IMP-sort-9-is-pattern typecode-cache-Pattern-178 typecode-cache-Pattern-308 sorting-cache-1408 INJ-symbol-0-sorting rule-imp-transitivity ) ASTHBUAGHCDUBIIJRGRILMEFNFOEKPQJHIJGLMEFNFOEKPQKGHABCDUCJGLMEFNFOEKPQUDUE $. $}
