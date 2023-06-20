$c \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \and \kore-sort-SortK \imp \kore-sort-SortPgm \kore-is-sort |- ) \in-sort ( $.
$v kore-sort-var-R ph0 ph2 kore-element-var-VE1 kore-element-var-VE0 ph1 $.
$d kore-sort-var-R kore-element-var-VE1 $.
$d kore-sort-var-R kore-element-var-VE0 $.
$d kore-element-var-VE0 kore-element-var-VE1 $.
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
BASIC-K-sort-0-is-pattern $a #Pattern \kore-sort-SortK $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
kore-element-var-VE0-elementvariable $f #ElementVariable kore-element-var-VE0 $.
kore-element-var-VE1-elementvariable $f #ElementVariable kore-element-var-VE1 $.
IMP-sort-27-is-pattern $a #Pattern \kore-sort-SortPgm $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-146 $a #Pattern kore-element-var-VE1 $.
typecode-cache-Pattern-148 $a #Pattern kore-element-var-VE0 $.
typecode-cache-Pattern-165 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortPgm ) \top ) ) $.
sorting-cache-571 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortPgm ) \top ) ) ( \kore-is-sort kore-sort-var-R ) ) $.
sorting-cache-573 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortPgm ) \top ) ) ( \and ( \in-sort kore-element-var-VE0 \kore-sort-SortK ) \top ) ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortPgm ) \top ) ) $.
typecode-cache-Pattern-166 $a #Pattern ( \and ( \in-sort kore-element-var-VE0 \kore-sort-SortK ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortPgm ) \top ) ) $.
${ sorting-cache-574 $p |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortPgm ) \top ) ) ( \and ( \in-sort kore-element-var-VE0 \kore-sort-SortK ) \top ) ) ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE0 \kore-sort-SortK ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortPgm ) \top ) ) ) ) $= ( in-sort-is-pattern typecode-cache-Pattern-148 BASIC-K-sort-0-is-pattern and-is-pattern top-is-pattern typecode-cache-Pattern-165 rule-imp-transitivity typecode-cache-Pattern-0 kore-is-sort-is-pattern and-elim-left-sugar rule-and-intro-alt2-sugar typecode-cache-Pattern-166 sorting-cache-571 typecode-cache-Pattern-146 IMP-sort-27-is-pattern and-elim-right-sugar imp-reflexivity sorting-cache-573 ) ACIBEFDHGGAKLBCOACIBEFDHGGACIAKLACIBEFDHGMACPJACIBEFDHGGBEFDCQRDHGACIBEFDHGGBEFDHGBEFDACIBEFDHGSBEFDHGBEFDBEFDBEFDHMBEFDTJJABCUANN $. $}
