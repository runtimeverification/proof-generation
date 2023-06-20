$c \top #SetVariable \kore-symbol-Lbl'Stop'Map #ElementVariable #Symbol #Variable #Pattern \kore-exists \and \imp \kore-is-sort |- \kore-valid ) \kore-equals \kore-sort-SortMap ( $.
$v kore-sort-var-R ph0 ph2 x kore-element-var-Val ph1 $.
$d kore-sort-var-R kore-element-var-Val $.
$d kore-element-var-Val x $.
$d kore-sort-var-R x $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
x-is-element-var $f #ElementVariable x $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
top-intro $a |- \top $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
${ rule-weakening.0 $e |- ph1 $.
   rule-weakening $a |- ( \imp ph0 ph1 ) $. $}
kore-exists-is-pattern $a #Pattern ( \kore-exists ph0 ph1 x ph2 ) $.
kore-valid-is-pattern $a #Pattern ( \kore-valid ph0 ph1 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-14-is-pattern $a #Pattern \kore-sort-SortMap $.
kore-element-var-Val-elementvariable $f #ElementVariable kore-element-var-Val $.
IMP-axiom-2911 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortMap kore-sort-var-R kore-element-var-Val ( \kore-equals \kore-sort-SortMap kore-sort-var-R kore-element-var-Val \kore-symbol-Lbl'Stop'Map ) ) ) ) $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
sorting-cache-136 $a |- ( \imp ( \and \top ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ) ( \kore-is-sort kore-sort-var-R ) ) $.
typecode-cache-Pattern-32 $a #Pattern ( \kore-equals \kore-sort-SortMap kore-sort-var-R kore-element-var-Val \kore-symbol-Lbl'Stop'Map ) $.
${ sorting-rearrange-51 $p |- ( \imp ( \and \top ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortMap kore-sort-var-R kore-element-var-Val ( \kore-equals \kore-sort-SortMap kore-sort-var-R kore-element-var-Val \kore-symbol-Lbl'Stop'Map ) ) ) ) $= ( top-is-pattern typecode-cache-Pattern-0 and-is-pattern kore-is-sort-is-pattern IMP-sort-14-is-pattern typecode-cache-Pattern-32 kore-exists-is-pattern kore-valid-is-pattern sorting-cache-136 top-intro rule-weakening rule-and-intro-alt2-sugar IMP-axiom-2911 rule-imp-transitivity ) CADFCEEADFCEADGADABHBIJCADFCEEADFCAKCADFCEECLMNABOP $. $}
