$c \top \kore-symbol-kseq #Variable \kore-sort-SortK \imp \kore-is-sort |- \kore-valid ) \kore-equals \and #SetVariable #ElementVariable #Symbol #Pattern \kore-exists \kore-sort-SortKItem \in-sort ( $.
$v kore-sort-var-R kore-element-var-V2 kore-element-var-V0 ph0 ph2 x kore-element-var-V1 ph1 $.
$d kore-element-var-V0 x $.
$d kore-element-var-V0 kore-element-var-V1 $.
$d kore-element-var-V2 kore-element-var-V1 $.
$d kore-sort-var-R kore-element-var-V2 $.
$d kore-sort-var-R kore-element-var-V0 $.
$d kore-element-var-V2 x $.
$d kore-sort-var-R x $.
$d kore-sort-var-R kore-element-var-V1 $.
$d kore-element-var-V1 x $.
$d kore-element-var-V2 kore-element-var-V0 $.
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
BASIC-K-sort-0-is-pattern $a #Pattern \kore-sort-SortK $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
kore-element-var-V0-elementvariable $f #ElementVariable kore-element-var-V0 $.
kore-element-var-V1-elementvariable $f #ElementVariable kore-element-var-V1 $.
kore-element-var-V2-elementvariable $f #ElementVariable kore-element-var-V2 $.
KSEQ-axiom-2 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V1 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) ) ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-equals \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-symbol-kseq kore-element-var-V1 kore-element-var-V2 ) ) ) ) ) $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-37 $a #Pattern kore-element-var-V1 $.
typecode-cache-Pattern-156 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) ) $.
typecode-cache-Pattern-157 $a #Pattern ( \and ( \in-sort kore-element-var-V1 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) ) $.
sorting-cache-536 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) ) ( \and ( \in-sort kore-element-var-V1 \kore-sort-SortKItem ) \top ) ) ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V1 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) ) ) ) $.
typecode-cache-Pattern-159 $a #Pattern ( \kore-equals \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-symbol-kseq kore-element-var-V1 kore-element-var-V2 ) ) $.
${ sorting-rearrange-273 $p |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) ) ( \and ( \in-sort kore-element-var-V1 \kore-sort-SortKItem ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-equals \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-symbol-kseq kore-element-var-V1 kore-element-var-V2 ) ) ) ) ) $= ( and-is-pattern typecode-cache-Pattern-0 typecode-cache-Pattern-156 typecode-cache-Pattern-37 BASIC-K-sort-1-is-pattern in-sort-is-pattern top-is-pattern kore-is-sort-is-pattern typecode-cache-Pattern-157 BASIC-K-sort-0-is-pattern typecode-cache-Pattern-159 kore-exists-is-pattern kore-valid-is-pattern sorting-cache-536 KSEQ-axiom-2 rule-imp-transitivity ) ADGCHIJKEEAFLCDMEAFNAFABCDOBPQACDRABCDST $. $}
