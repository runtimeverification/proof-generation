$c \top \kore-sort-SortStmt #Variable \kore-symbol-Lblint'UndsSClnUndsUnds'IMP-SYNTAX'Unds'Pgm'Unds'Ids'Unds'Stmt \kore-sort-SortIds \imp \kore-sort-SortPgm \kore-is-sort |- \kore-valid ) \kore-equals \and #SetVariable #ElementVariable #Symbol #Pattern \kore-exists \in-sort ( $.
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
kore-exists-is-pattern $a #Pattern ( \kore-exists ph0 ph1 x ph2 ) $.
kore-valid-is-pattern $a #Pattern ( \kore-valid ph0 ph1 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-0-is-pattern $a #Pattern \kore-sort-SortIds $.
IMP-sort-27-is-pattern $a #Pattern \kore-sort-SortPgm $.
kore-element-var-Val-elementvariable $f #ElementVariable kore-element-var-Val $.
kore-element-var-K0-elementvariable $f #ElementVariable kore-element-var-K0 $.
kore-element-var-K1-elementvariable $f #ElementVariable kore-element-var-K1 $.
IMP-axiom-3066 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K0 \kore-sort-SortIds ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortStmt ) \top ) ) ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortPgm kore-sort-var-R kore-element-var-Val ( \kore-equals \kore-sort-SortPgm kore-sort-var-R kore-element-var-Val ( \kore-symbol-Lblint'UndsSClnUndsUnds'IMP-SYNTAX'Unds'Pgm'Unds'Ids'Unds'Stmt kore-element-var-K0 kore-element-var-K1 ) ) ) ) ) $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-51 $a #Pattern kore-element-var-K0 $.
typecode-cache-Pattern-80 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortStmt ) \top ) ) $.
typecode-cache-Pattern-81 $a #Pattern ( \and ( \in-sort kore-element-var-K0 \kore-sort-SortIds ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortStmt ) \top ) ) $.
sorting-cache-296 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortStmt ) \top ) ) ( \and ( \in-sort kore-element-var-K0 \kore-sort-SortIds ) \top ) ) ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K0 \kore-sort-SortIds ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortStmt ) \top ) ) ) ) $.
typecode-cache-Pattern-83 $a #Pattern ( \kore-equals \kore-sort-SortPgm kore-sort-var-R kore-element-var-Val ( \kore-symbol-Lblint'UndsSClnUndsUnds'IMP-SYNTAX'Unds'Pgm'Unds'Ids'Unds'Stmt kore-element-var-K0 kore-element-var-K1 ) ) $.
${ sorting-rearrange-106 $p |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortStmt ) \top ) ) ( \and ( \in-sort kore-element-var-K0 \kore-sort-SortIds ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortPgm kore-sort-var-R kore-element-var-Val ( \kore-equals \kore-sort-SortPgm kore-sort-var-R kore-element-var-Val ( \kore-symbol-Lblint'UndsSClnUndsUnds'IMP-SYNTAX'Unds'Pgm'Unds'Ids'Unds'Stmt kore-element-var-K0 kore-element-var-K1 ) ) ) ) ) $= ( and-is-pattern typecode-cache-Pattern-0 typecode-cache-Pattern-80 typecode-cache-Pattern-51 IMP-sort-0-is-pattern in-sort-is-pattern top-is-pattern kore-is-sort-is-pattern typecode-cache-Pattern-81 IMP-sort-27-is-pattern typecode-cache-Pattern-83 kore-exists-is-pattern kore-valid-is-pattern sorting-cache-296 IMP-axiom-3066 rule-imp-transitivity ) ADGCHIJKEEAFLCDMEAFNAFABCDOBPQACDRABCDST $. $}
