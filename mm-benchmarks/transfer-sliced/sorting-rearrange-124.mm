$c \top #SetVariable #ElementVariable #Symbol \kore-sort-SortStmt #Variable #Pattern \kore-exists \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt \and \imp \kore-is-sort |- \kore-valid ) \kore-equals \in-sort ( $.
$v kore-sort-var-R ph0 ph2 x kore-element-var-K0 kore-element-var-Val kore-element-var-K1 ph1 $.
$d kore-element-var-K1 kore-element-var-Val $.
$d kore-sort-var-R kore-element-var-Val $.
$d kore-element-var-K1 x $.
$d kore-element-var-K1 kore-element-var-K0 $.
$d kore-element-var-K0 x $.
$d kore-sort-var-R kore-element-var-K1 $.
$d kore-sort-var-R kore-element-var-K0 $.
$d kore-element-var-Val x $.
$d kore-sort-var-R x $.
$d kore-element-var-Val kore-element-var-K0 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
x-is-element-var $f #ElementVariable x $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
and-elim-left-sugar $a |- ( \imp ( \and ph0 ph1 ) ph0 ) $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
kore-exists-is-pattern $a #Pattern ( \kore-exists ph0 ph1 x ph2 ) $.
kore-valid-is-pattern $a #Pattern ( \kore-valid ph0 ph1 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-31-is-pattern $a #Pattern \kore-sort-SortStmt $.
kore-element-var-Val-elementvariable $f #ElementVariable kore-element-var-Val $.
kore-element-var-K0-elementvariable $f #ElementVariable kore-element-var-K0 $.
kore-element-var-K1-elementvariable $f #ElementVariable kore-element-var-K1 $.
IMP-axiom-3036 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K0 \kore-sort-SortStmt ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortStmt ) \top ) ) ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortStmt kore-sort-var-R kore-element-var-Val ( \kore-equals \kore-sort-SortStmt kore-sort-var-R kore-element-var-Val ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt kore-element-var-K0 kore-element-var-K1 ) ) ) ) ) $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-49 $a #Pattern kore-element-var-K1 $.
typecode-cache-Pattern-51 $a #Pattern kore-element-var-K0 $.
typecode-cache-Pattern-80 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortStmt ) \top ) ) $.
sorting-cache-293 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortStmt ) \top ) ) ( \kore-is-sort kore-sort-var-R ) ) $.
sorting-cache-321 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortStmt ) \top ) ) ( \and ( \in-sort kore-element-var-K0 \kore-sort-SortStmt ) \top ) ) ( \and ( \in-sort kore-element-var-K0 \kore-sort-SortStmt ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortStmt ) \top ) ) ) $.
typecode-cache-Pattern-97 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K0 \kore-sort-SortStmt ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortStmt ) \top ) ) ) $.
typecode-cache-Pattern-99 $a #Pattern ( \kore-equals \kore-sort-SortStmt kore-sort-var-R kore-element-var-Val ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt kore-element-var-K0 kore-element-var-K1 ) ) $.
${ sorting-rearrange-124 $p |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortStmt ) \top ) ) ( \and ( \in-sort kore-element-var-K0 \kore-sort-SortStmt ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortStmt kore-sort-var-R kore-element-var-Val ( \kore-equals \kore-sort-SortStmt kore-sort-var-R kore-element-var-Val ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt kore-element-var-K0 kore-element-var-K1 ) ) ) ) ) $= ( and-is-pattern IMP-sort-31-is-pattern in-sort-is-pattern typecode-cache-Pattern-80 typecode-cache-Pattern-51 top-is-pattern typecode-cache-Pattern-0 kore-is-sort-is-pattern rule-imp-transitivity typecode-cache-Pattern-97 typecode-cache-Pattern-99 kore-exists-is-pattern kore-valid-is-pattern typecode-cache-Pattern-49 and-elim-left-sugar sorting-cache-293 sorting-cache-321 rule-and-intro-alt2-sugar IMP-axiom-3036 ) ADHCIFGJEEACDNAKFAKABCDOBPQADHCIFGJEEAKLCIFGDRFGJEEADHCIFGJEEADHAKLADHCIFGJESADTMACDUAUBABCDUCM $. $}
