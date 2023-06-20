$c \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \kore-sort-SortBlock \and \imp \kore-is-sort |- ) \in-sort ( $.
$v kore-sort-var-R ph0 ph2 kore-element-var-K1 ph1 kore-element-var-K2 $.
$d kore-element-var-K1 kore-element-var-K2 $.
$d kore-sort-var-R kore-element-var-K2 $.
$d kore-sort-var-R kore-element-var-K1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
and-elim-right-sugar $a |- ( \imp ( \and ph0 ph1 ) ph1 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-18-is-pattern $a #Pattern \kore-sort-SortBlock $.
kore-element-var-K1-elementvariable $f #ElementVariable kore-element-var-K1 $.
kore-element-var-K2-elementvariable $f #ElementVariable kore-element-var-K2 $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-49 $a #Pattern kore-element-var-K1 $.
typecode-cache-Pattern-120 $a #Pattern kore-element-var-K2 $.
typecode-cache-Pattern-121 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortBlock ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortBlock ) \top ) ) ) $.
sorting-cache-360 $a |- ( \imp ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortBlock ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortBlock ) \top ) ) ( \in-sort kore-element-var-K2 \kore-sort-SortBlock ) ) $.
${ sorting-cache-361 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortBlock ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortBlock ) \top ) ) ) ( \in-sort kore-element-var-K2 \kore-sort-SortBlock ) ) $= ( IMP-sort-18-is-pattern in-sort-is-pattern and-is-pattern typecode-cache-Pattern-120 typecode-cache-Pattern-49 top-is-pattern typecode-cache-Pattern-121 typecode-cache-Pattern-0 kore-is-sort-is-pattern and-elim-right-sugar sorting-cache-360 rule-imp-transitivity ) ABCJBHDECGDEIFFCGDEAKLBHDECGDEIFFMBCNO $. $}
