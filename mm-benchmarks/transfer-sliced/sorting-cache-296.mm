$c \top #SetVariable #ElementVariable #Symbol \kore-sort-SortStmt #Variable #Pattern \kore-sort-SortIds \and \imp \kore-is-sort |- ) \in-sort ( $.
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
imp-reflexivity $a |- ( \imp ph0 ph0 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
and-elim-left-sugar $a |- ( \imp ( \and ph0 ph1 ) ph0 ) $.
and-elim-right-sugar $a |- ( \imp ( \and ph0 ph1 ) ph1 ) $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-0-is-pattern $a #Pattern \kore-sort-SortIds $.
IMP-sort-31-is-pattern $a #Pattern \kore-sort-SortStmt $.
kore-element-var-K0-elementvariable $f #ElementVariable kore-element-var-K0 $.
kore-element-var-K1-elementvariable $f #ElementVariable kore-element-var-K1 $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-49 $a #Pattern kore-element-var-K1 $.
typecode-cache-Pattern-51 $a #Pattern kore-element-var-K0 $.
typecode-cache-Pattern-80 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortStmt ) \top ) ) $.
sorting-cache-293 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortStmt ) \top ) ) ( \kore-is-sort kore-sort-var-R ) ) $.
sorting-cache-295 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortStmt ) \top ) ) ( \and ( \in-sort kore-element-var-K0 \kore-sort-SortIds ) \top ) ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortStmt ) \top ) ) $.
typecode-cache-Pattern-81 $a #Pattern ( \and ( \in-sort kore-element-var-K0 \kore-sort-SortIds ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortStmt ) \top ) ) $.
${ sorting-cache-296 $p |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortStmt ) \top ) ) ( \and ( \in-sort kore-element-var-K0 \kore-sort-SortIds ) \top ) ) ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K0 \kore-sort-SortIds ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortStmt ) \top ) ) ) ) $= ( in-sort-is-pattern typecode-cache-Pattern-51 IMP-sort-0-is-pattern and-is-pattern top-is-pattern typecode-cache-Pattern-80 rule-imp-transitivity typecode-cache-Pattern-0 kore-is-sort-is-pattern and-elim-left-sugar rule-and-intro-alt2-sugar typecode-cache-Pattern-81 sorting-cache-293 typecode-cache-Pattern-49 IMP-sort-31-is-pattern and-elim-right-sugar imp-reflexivity sorting-cache-295 ) ACIBEFDHGGAKLBCOACIBEFDHGGACIAKLACIBEFDHGMACPJACIBEFDHGGBEFDCQRDHGACIBEFDHGGBEFDHGBEFDACIBEFDHGSBEFDHGBEFDBEFDBEFDHMBEFDTJJABCUANN $. $}
