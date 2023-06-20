$c \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \and \kore-sort-SortK \imp \kore-sort-SortKItem \kore-is-sort |- ) \in-sort ( $.
$v kore-sort-var-R kore-element-var-V2 ph0 ph2 kore-element-var-V1 ph1 $.
$d kore-element-var-V2 kore-element-var-V1 $.
$d kore-sort-var-R kore-element-var-V2 $.
$d kore-sort-var-R kore-element-var-V1 $.
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
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
kore-element-var-V1-elementvariable $f #ElementVariable kore-element-var-V1 $.
kore-element-var-V2-elementvariable $f #ElementVariable kore-element-var-V2 $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-35 $a #Pattern kore-element-var-V2 $.
typecode-cache-Pattern-37 $a #Pattern kore-element-var-V1 $.
typecode-cache-Pattern-156 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) ) $.
sorting-cache-533 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) ) ( \kore-is-sort kore-sort-var-R ) ) $.
sorting-cache-535 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) ) ( \and ( \in-sort kore-element-var-V1 \kore-sort-SortKItem ) \top ) ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) ) $.
typecode-cache-Pattern-157 $a #Pattern ( \and ( \in-sort kore-element-var-V1 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) ) $.
${ sorting-cache-536 $p |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) ) ( \and ( \in-sort kore-element-var-V1 \kore-sort-SortKItem ) \top ) ) ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V1 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) ) ) ) $= ( in-sort-is-pattern typecode-cache-Pattern-37 BASIC-K-sort-1-is-pattern and-is-pattern top-is-pattern typecode-cache-Pattern-156 rule-imp-transitivity typecode-cache-Pattern-0 kore-is-sort-is-pattern and-elim-left-sugar rule-and-intro-alt2-sugar typecode-cache-Pattern-157 sorting-cache-533 typecode-cache-Pattern-35 BASIC-K-sort-0-is-pattern and-elim-right-sugar imp-reflexivity sorting-cache-535 ) ACIBEFDHGGAKLBCOACIBEFDHGGACIAKLACIBEFDHGMACPJACIBEFDHGGBEFDCQRDHGACIBEFDHGGBEFDHGBEFDACIBEFDHGSBEFDHGBEFDBEFDBEFDHMBEFDTJJABCUANN $. $}
