$c \top \kore-sort-SortAExp \kore-sort-SortStmt #Variable \kore-sort-SortK \imp \kore-dv "0" \kore-is-sort |- \kore-sort-SortId ) \and #SetVariable #ElementVariable #Symbol #Pattern \kore-sort-SortBlock \kore-sort-SortKItem \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt "ret" \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp \kore-inj \kore-sort-SortInt \in-sort ( $.
$v kore-sort-var-R ph0 ph2 ptn1 ptn0 kore-element-var-K1 ph1 $.
$d kore-sort-var-R kore-element-var-K1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
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
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
ptn1-pattern $f #Pattern ptn1 $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-18-is-pattern $a #Pattern \kore-sort-SortBlock $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-sort-31-is-pattern $a #Pattern \kore-sort-SortStmt $.
IMP-symbol-185-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-354-is-pattern $a #Pattern ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ptn0 ) $.
IMP-symbol-354-sorting $a |- ( \imp ( \in-sort ptn0 \kore-sort-SortStmt ) ( \in-sort ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ptn0 ) \kore-sort-SortBlock ) ) $.
kore-element-var-K1-elementvariable $f #ElementVariable kore-element-var-K1 $.
string-literal-1-is-pattern $a #Pattern "0" $.
string-literal-11-is-pattern $a #Pattern "ret" $.
typecode-cache-Pattern-299 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortK ) \top ) ) $.
sorting-cache-1270 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortK ) \top ) ) ( \and ( \kore-is-sort \kore-sort-SortBlock ) ( \kore-is-sort \kore-sort-SortKItem ) ) ) $.
sorting-cache-1273 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortK ) \top ) ) ( \in-sort ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "0" ) ) ) \kore-sort-SortStmt ) ) $.
${ sorting-cache-1274 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortK ) \top ) ) ( \and ( \and ( \kore-is-sort \kore-sort-SortBlock ) ( \kore-is-sort \kore-sort-SortKItem ) ) ( \in-sort ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) \kore-sort-SortBlock ) ) ) $= ( kore-dv-is-pattern IMP-sort-23-is-pattern IMP-sort-17-is-pattern string-literal-11-is-pattern IMP-sort-13-is-pattern string-literal-1-is-pattern kore-inj-is-pattern IMP-symbol-185-is-pattern IMP-sort-18-is-pattern in-sort-is-pattern typecode-cache-Pattern-299 kore-is-sort-is-pattern IMP-symbol-354-is-pattern BASIC-K-sort-1-is-pattern and-is-pattern sorting-cache-1270 IMP-sort-31-is-pattern sorting-cache-1273 IMP-symbol-354-sorting rule-imp-transitivity rule-and-intro-alt2-sugar ) ABMKNPNQEFCDGDHCIJOKLABRABMEFCDGDHCIJSLEFCDGDHCIJOKLABTEFCDGDHCIJUAUBUC $. $}
