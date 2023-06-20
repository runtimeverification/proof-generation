$c \top #SetVariable \kore-sort-SortAExp #ElementVariable #Symbol #Variable #Pattern \and \imp \kore-is-sort |- \kore-sort-SortId ) \in-sort ( $.
$v kore-sort-var-R ph0 ph2 kore-element-var-K0 kore-element-var-K1 ph1 $.
$d kore-element-var-K1 kore-element-var-K0 $.
$d kore-sort-var-R kore-element-var-K1 $.
$d kore-sort-var-R kore-element-var-K0 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
top-intro $a |- \top $.
and-elim-left-sugar $a |- ( \imp ( \and ph0 ph1 ) ph0 ) $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
${ rule-weakening.0 $e |- ph1 $.
   rule-weakening $a |- ( \imp ph0 ph1 ) $. $}
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
kore-element-var-K0-elementvariable $f #ElementVariable kore-element-var-K0 $.
kore-element-var-K1-elementvariable $f #ElementVariable kore-element-var-K1 $.
typecode-cache-Pattern-49 $a #Pattern kore-element-var-K1 $.
typecode-cache-Pattern-51 $a #Pattern kore-element-var-K0 $.
typecode-cache-Pattern-86 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortAExp ) \top ) ) $.
sorting-cache-304 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortAExp ) \top ) ) ( \in-sort kore-element-var-K1 \kore-sort-SortAExp ) ) $.
${ sorting-cache-305 $p |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortAExp ) \top ) ) ( \and ( \in-sort kore-element-var-K0 \kore-sort-SortId ) \top ) ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortAExp ) \top ) ) $= ( and-is-pattern in-sort-is-pattern top-is-pattern typecode-cache-Pattern-86 typecode-cache-Pattern-51 IMP-sort-17-is-pattern typecode-cache-Pattern-49 IMP-sort-13-is-pattern and-elim-left-sugar sorting-cache-304 rule-imp-transitivity top-intro rule-weakening rule-and-intro-alt2-sugar ) ACGBHIEFDDCJKEFACGBHIEFDDACGCJKEACGBHIEFDLACMNACGBHIEFDDFOPQ $. $}
