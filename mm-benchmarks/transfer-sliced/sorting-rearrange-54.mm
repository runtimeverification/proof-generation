$c \top #SetVariable #ElementVariable \kore-symbol-Lbl'Unds'Map'Unds' #Symbol #Variable #Pattern \kore-exists \and \imp \kore-is-sort |- \kore-valid ) \kore-equals \in-sort \kore-sort-SortMap ( $.
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
and-elim-left-sugar $a |- ( \imp ( \and ph0 ph1 ) ph0 ) $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
kore-exists-is-pattern $a #Pattern ( \kore-exists ph0 ph1 x ph2 ) $.
kore-valid-is-pattern $a #Pattern ( \kore-valid ph0 ph1 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
kore-element-var-V0-elementvariable $f #ElementVariable kore-element-var-V0 $.
kore-element-var-V1-elementvariable $f #ElementVariable kore-element-var-V1 $.
kore-element-var-V2-elementvariable $f #ElementVariable kore-element-var-V2 $.
IMP-sort-14-is-pattern $a #Pattern \kore-sort-SortMap $.
IMP-axiom-3415 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V1 \kore-sort-SortMap ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortMap ) \top ) ) ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortMap kore-sort-var-R kore-element-var-V0 ( \kore-equals \kore-sort-SortMap kore-sort-var-R kore-element-var-V0 ( \kore-symbol-Lbl'Unds'Map'Unds' kore-element-var-V1 kore-element-var-V2 ) ) ) ) ) $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-35 $a #Pattern kore-element-var-V2 $.
typecode-cache-Pattern-36 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortMap ) \top ) ) $.
typecode-cache-Pattern-37 $a #Pattern kore-element-var-V1 $.
sorting-cache-259 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortMap ) \top ) ) ( \kore-is-sort kore-sort-var-R ) ) $.
sorting-cache-261 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortMap ) \top ) ) ( \and ( \in-sort kore-element-var-V1 \kore-sort-SortMap ) \top ) ) ( \and ( \in-sort kore-element-var-V1 \kore-sort-SortMap ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortMap ) \top ) ) ) $.
typecode-cache-Pattern-38 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V1 \kore-sort-SortMap ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortMap ) \top ) ) ) $.
typecode-cache-Pattern-41 $a #Pattern ( \kore-equals \kore-sort-SortMap kore-sort-var-R kore-element-var-V0 ( \kore-symbol-Lbl'Unds'Map'Unds' kore-element-var-V1 kore-element-var-V2 ) ) $.
${ sorting-rearrange-54 $p |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortMap ) \top ) ) ( \and ( \in-sort kore-element-var-V1 \kore-sort-SortMap ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortMap kore-sort-var-R kore-element-var-V0 ( \kore-equals \kore-sort-SortMap kore-sort-var-R kore-element-var-V0 ( \kore-symbol-Lbl'Unds'Map'Unds' kore-element-var-V1 kore-element-var-V2 ) ) ) ) ) $= ( and-is-pattern IMP-sort-14-is-pattern in-sort-is-pattern typecode-cache-Pattern-36 typecode-cache-Pattern-37 top-is-pattern typecode-cache-Pattern-0 kore-is-sort-is-pattern rule-imp-transitivity typecode-cache-Pattern-38 typecode-cache-Pattern-41 kore-exists-is-pattern kore-valid-is-pattern typecode-cache-Pattern-35 and-elim-left-sugar sorting-cache-259 sorting-cache-261 rule-and-intro-alt2-sugar IMP-axiom-3415 ) ADHCIFGJEEACDNAKFAKABCDOBPQADHCIFGJEEAKLCIFGDRFGJEEADHCIFGJEEADHAKLADHCIFGJESADTMACDUAUBABCDUCM $. $}
