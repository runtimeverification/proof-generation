$c \exists "12345" \top \kore-sort-SortAExp \kore-sort-SortStmt #Variable \imp \kore-dv \kore-is-sort |- \kore-sort-SortId \kore-valid ) \kore-equals \and \unit-sort #SetVariable #ElementVariable #Symbol \eq #Pattern \kore-exists \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp \kore-inj \kore-sort-SortInt "addressTo" \in-sort ( $.
$v kore-sort-var-R ph0 ph2 x th0 ptn1 kore-element-var-Val ptn0 kore-element-var-K1 ph1 $.
$d kore-element-var-K1 kore-element-var-Val $.
$d kore-sort-var-R kore-element-var-Val $.
$d kore-element-var-K1 x $.
$d kore-sort-var-R kore-element-var-K1 $.
$d kore-element-var-Val x $.
$d kore-sort-var-R x $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
th0-is-pattern $f #Pattern th0 $.
x-is-element-var $f #ElementVariable x $.
exists-is-pattern $a #Pattern ( \exists x ph0 ) $.
top-is-pattern $a #Pattern \top $.
eq-is-pattern $a #Pattern ( \eq ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
top-intro $a |- \top $.
${ rule-weakening.0 $e |- ph1 $.
   rule-weakening $a |- ( \imp ph0 ph1 ) $. $}
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
${ $d x ph0 $.
   $d x ph1 $.
   kore-functional.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
   kore-functional.1 $e |- ( \imp th0 ( \kore-valid \unit-sort ( \kore-exists ph0 \unit-sort x ( \kore-equals ph0 \unit-sort x ph1 ) ) ) ) $.
   kore-functional $a |- ( \imp th0 ( \exists x ( \eq x ph1 ) ) ) $. $}
ptn0-pattern $f #Pattern ptn0 $.
ptn1-pattern $f #Pattern ptn1 $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-sort-31-is-pattern $a #Pattern \kore-sort-SortStmt $.
IMP-symbol-185-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ptn0 ptn1 ) $.
kore-element-var-Val-elementvariable $f #ElementVariable kore-element-var-Val $.
kore-element-var-K1-elementvariable $f #ElementVariable kore-element-var-K1 $.
string-literal-12-is-pattern $a #Pattern "12345" $.
string-literal-18-is-pattern $a #Pattern "addressTo" $.
sorting-cache-17 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "addressTo" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "12345" ) ) ) \kore-sort-SortStmt ) ) $.
typecode-cache-Pattern-31 $a #Pattern kore-element-var-Val $.
typecode-cache-Pattern-80 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortStmt ) \top ) ) $.
sorting-rearrange-122 $a |- ( \imp \top ( \kore-valid \unit-sort ( \kore-exists \kore-sort-SortStmt \unit-sort kore-element-var-Val ( \kore-equals \kore-sort-SortStmt \unit-sort kore-element-var-Val ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "addressTo" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "12345" ) ) ) ) ) ) ) $.
${ sorting-rearrange-123 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortStmt ) \top ) ) ( \exists kore-element-var-Val ( \eq kore-element-var-Val ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "addressTo" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "12345" ) ) ) ) ) ) $= ( kore-dv-is-pattern IMP-sort-23-is-pattern top-is-pattern typecode-cache-Pattern-80 IMP-sort-17-is-pattern string-literal-18-is-pattern IMP-sort-13-is-pattern string-literal-12-is-pattern kore-inj-is-pattern IMP-symbol-185-is-pattern typecode-cache-Pattern-31 eq-is-pattern exists-is-pattern top-intro rule-weakening IMP-sort-31-is-pattern sorting-cache-17 sorting-rearrange-122 kore-functional rule-imp-transitivity ) ACGFBNHIDEJEKDLMOBPACGFQRSHIDEJEKDLMFBTBUAUBUC $. $}
