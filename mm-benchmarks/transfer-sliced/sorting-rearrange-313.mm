$c \top #SetVariable #ElementVariable \kore-symbol-Lbl'Unds'Map'Unds' #Symbol #Variable #Pattern \and \imp \kore-is-sort |- \kore-valid ) \kore-equals \in-sort \kore-sort-SortMap ( $.
$v kore-sort-var-R ph0 ph2 ph3 kore-element-var-K1 ph1 kore-element-var-K2 $.
$d kore-element-var-K1 kore-element-var-K2 $.
$d kore-sort-var-R kore-element-var-K2 $.
$d kore-sort-var-R kore-element-var-K1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
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
kore-valid-is-pattern $a #Pattern ( \kore-valid ph0 ph1 ) $.
kore-equals-is-pattern $a #Pattern ( \kore-equals ph0 ph1 ph2 ph3 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-14-is-pattern $a #Pattern \kore-sort-SortMap $.
kore-element-var-K1-elementvariable $f #ElementVariable kore-element-var-K1 $.
kore-element-var-K2-elementvariable $f #ElementVariable kore-element-var-K2 $.
IMP-axiom-3025 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortMap ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortMap ) \top ) ) ) ( \kore-valid kore-sort-var-R ( \kore-equals \kore-sort-SortMap kore-sort-var-R ( \kore-symbol-Lbl'Unds'Map'Unds' kore-element-var-K1 kore-element-var-K2 ) ( \kore-symbol-Lbl'Unds'Map'Unds' kore-element-var-K2 kore-element-var-K1 ) ) ) ) $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-49 $a #Pattern kore-element-var-K1 $.
typecode-cache-Pattern-120 $a #Pattern kore-element-var-K2 $.
typecode-cache-Pattern-191 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortMap ) \top ) ) $.
sorting-cache-689 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortMap ) \top ) ) ( \kore-is-sort kore-sort-var-R ) ) $.
sorting-cache-691 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortMap ) \top ) ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortMap ) \top ) ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortMap ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortMap ) \top ) ) ) $.
typecode-cache-Pattern-192 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortMap ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortMap ) \top ) ) ) $.
typecode-cache-Pattern-193 $a #Pattern ( \kore-symbol-Lbl'Unds'Map'Unds' kore-element-var-K1 kore-element-var-K2 ) $.
typecode-cache-Pattern-194 $a #Pattern ( \kore-symbol-Lbl'Unds'Map'Unds' kore-element-var-K2 kore-element-var-K1 ) $.
${ sorting-rearrange-313 $p |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortMap ) \top ) ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortMap ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-equals \kore-sort-SortMap kore-sort-var-R ( \kore-symbol-Lbl'Unds'Map'Unds' kore-element-var-K1 kore-element-var-K2 ) ( \kore-symbol-Lbl'Unds'Map'Unds' kore-element-var-K2 kore-element-var-K1 ) ) ) ) $= ( and-is-pattern IMP-sort-14-is-pattern in-sort-is-pattern typecode-cache-Pattern-191 typecode-cache-Pattern-49 top-is-pattern typecode-cache-Pattern-0 kore-is-sort-is-pattern rule-imp-transitivity typecode-cache-Pattern-192 typecode-cache-Pattern-193 typecode-cache-Pattern-194 kore-equals-is-pattern kore-valid-is-pattern typecode-cache-Pattern-120 and-elim-left-sugar sorting-cache-689 sorting-cache-691 rule-and-intro-alt2-sugar IMP-axiom-3025 ) ACGBHEFIDDABCMAJEAJBCNBCOPQACGBHEFIDDAJKBHEFCREFIDDACGBHEFIDDACGAJKACGBHEFIDSACTLABCUAUBABCUCL $. $}
