$c "12345" \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \kore-exists \and \imp \kore-dv \kore-is-sort |- \kore-valid ) \kore-sort-SortInt \kore-equals ( $.
$v ph0 ph2 x kore-sort-var-x0 kore-element-var-x1 ph3 ph1 $.
$d kore-element-var-x1 x $.
$d x kore-sort-var-x0 $.
$d kore-element-var-x1 kore-sort-var-x0 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
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
kore-equals-is-pattern $a #Pattern ( \kore-equals ph0 ph1 ph2 ph3 ) $.
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
kore-sort-var-x0-elementvariable $f #ElementVariable kore-sort-var-x0 $.
kore-element-var-x1-elementvariable $f #ElementVariable kore-element-var-x1 $.
string-literal-12-is-pattern $a #Pattern "12345" $.
domain-value-14-functional $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-x0 ) \top ) ( \kore-valid kore-sort-var-x0 ( \kore-exists \kore-sort-SortInt kore-sort-var-x0 kore-element-var-x1 ( \kore-equals \kore-sort-SortInt kore-sort-var-x0 kore-element-var-x1 ( \kore-dv \kore-sort-SortInt "12345" ) ) ) ) ) $.
typecode-cache-Pattern-14 $a #Pattern kore-sort-var-x0 $.
sorting-cache-127 $a |- ( \imp ( \and \top ( \and ( \kore-is-sort kore-sort-var-x0 ) \top ) ) ( \kore-is-sort kore-sort-var-x0 ) ) $.
typecode-cache-Pattern-23 $a #Pattern kore-element-var-x1 $.
${ sorting-rearrange-111 $p |- ( \imp ( \and \top ( \and ( \kore-is-sort kore-sort-var-x0 ) \top ) ) ( \kore-valid kore-sort-var-x0 ( \kore-exists \kore-sort-SortInt kore-sort-var-x0 kore-element-var-x1 ( \kore-equals \kore-sort-SortInt kore-sort-var-x0 kore-element-var-x1 ( \kore-dv \kore-sort-SortInt "12345" ) ) ) ) ) $= ( top-is-pattern typecode-cache-Pattern-14 and-is-pattern kore-is-sort-is-pattern IMP-sort-23-is-pattern typecode-cache-Pattern-23 string-literal-12-is-pattern kore-dv-is-pattern kore-equals-is-pattern kore-exists-is-pattern kore-valid-is-pattern sorting-cache-127 top-intro rule-weakening rule-and-intro-alt2-sugar domain-value-14-functional rule-imp-transitivity ) CADFCEEADFCEADGADGADBHGIJKBLMCADFCEEADFCANCADFCEECOPQABRS $. $}
