$c \top #SetVariable \kore-sort-SortAExp #ElementVariable #Symbol #Variable #Pattern \and \kore-sort-SortK \imp \kore-sort-SortKItem |- ) \in-sort \kore-sort-SortStateCell ( $.
$v ph0 ph2 kore-element-var-VE1 kore-element-var-VE3 kore-element-var-VE2 kore-element-var-VE5 kore-element-var-VE4 ph1 $.
$d kore-element-var-VE3 kore-element-var-VE1 $.
$d kore-element-var-VE3 kore-element-var-VE4 $.
$d kore-element-var-VE5 kore-element-var-VE2 $.
$d kore-element-var-VE4 kore-element-var-VE2 $.
$d kore-element-var-VE5 kore-element-var-VE4 $.
$d kore-element-var-VE2 kore-element-var-VE1 $.
$d kore-element-var-VE4 kore-element-var-VE1 $.
$d kore-element-var-VE5 kore-element-var-VE3 $.
$d kore-element-var-VE3 kore-element-var-VE2 $.
$d kore-element-var-VE5 kore-element-var-VE1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
and-elim-right-sugar $a |- ( \imp ( \and ph0 ph1 ) ph1 ) $.
BASIC-K-sort-0-is-pattern $a #Pattern \kore-sort-SortK $.
kore-element-var-VE2-elementvariable $f #ElementVariable kore-element-var-VE2 $.
kore-element-var-VE1-elementvariable $f #ElementVariable kore-element-var-VE1 $.
kore-element-var-VE3-elementvariable $f #ElementVariable kore-element-var-VE3 $.
kore-element-var-VE4-elementvariable $f #ElementVariable kore-element-var-VE4 $.
IMP-sort-9-is-pattern $a #Pattern \kore-sort-SortStateCell $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
kore-element-var-VE5-elementvariable $f #ElementVariable kore-element-var-VE5 $.
typecode-cache-Pattern-146 $a #Pattern kore-element-var-VE1 $.
typecode-cache-Pattern-177 $a #Pattern kore-element-var-VE2 $.
typecode-cache-Pattern-178 $a #Pattern kore-element-var-VE3 $.
typecode-cache-Pattern-179 $a #Pattern kore-element-var-VE4 $.
typecode-cache-Pattern-324 $a #Pattern ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortAExp ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) \top ) ) $.
sorting-cache-1475 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortK ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortAExp ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) \top ) ) ) ) ( \in-sort kore-element-var-VE4 \kore-sort-SortAExp ) ) $.
${ sorting-cache-1476 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortAExp ) ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortK ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortAExp ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) \top ) ) ) ) ) ( \in-sort kore-element-var-VE4 \kore-sort-SortAExp ) ) $= ( in-sort-is-pattern and-is-pattern IMP-sort-13-is-pattern typecode-cache-Pattern-177 BASIC-K-sort-0-is-pattern typecode-cache-Pattern-178 IMP-sort-9-is-pattern typecode-cache-Pattern-324 typecode-cache-Pattern-146 typecode-cache-Pattern-179 and-elim-right-sugar sorting-cache-1475 rule-imp-transitivity ) BNHFAIJFCKLFDEMGGGAIJFCKLFDEMGGDOHFBNHFAIJFCKLFDEMGGPACDEQR $. $}
