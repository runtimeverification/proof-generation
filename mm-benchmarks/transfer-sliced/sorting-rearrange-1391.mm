$c \exists \top #Variable \imp \kore-dv |- \kore-sort-SortId \kore-valid ) \kore-equals \and \unit-sort #SetVariable #ElementVariable #Symbol \eq #Pattern \kore-exists \in-sort \kore-sort-SortMap "balanceTo" ( $.
$v ph0 ph2 x th0 kore-element-var-VE5 kore-element-var-x1 ph1 $.
$d kore-element-var-x1 x $.
$d kore-element-var-VE5 kore-element-var-x1 $.
$d kore-element-var-VE5 x $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
th0-is-pattern $f #Pattern th0 $.
x-is-element-var $f #ElementVariable x $.
exists-is-pattern $a #Pattern ( \exists x ph0 ) $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
eq-is-pattern $a #Pattern ( \eq ph0 ph1 ) $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
top-intro $a |- \top $.
${ rule-weakening.0 $e |- ph1 $.
   rule-weakening $a |- ( \imp ph0 ph1 ) $. $}
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
${ $d x ph0 $.
   $d x ph1 $.
   kore-functional.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
   kore-functional.1 $e |- ( \imp th0 ( \kore-valid \unit-sort ( \kore-exists ph0 \unit-sort x ( \kore-equals ph0 \unit-sort x ph1 ) ) ) ) $.
   kore-functional $a |- ( \imp th0 ( \exists x ( \eq x ph1 ) ) ) $. $}
IMP-sort-14-is-pattern $a #Pattern \kore-sort-SortMap $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
kore-element-var-x1-elementvariable $f #ElementVariable kore-element-var-x1 $.
kore-element-var-VE5-elementvariable $f #ElementVariable kore-element-var-VE5 $.
string-literal-17-is-pattern $a #Pattern "balanceTo" $.
sorting-cache-5 $a |- ( \imp \top ( \in-sort ( \kore-dv \kore-sort-SortId "balanceTo" ) \kore-sort-SortId ) ) $.
typecode-cache-Pattern-23 $a #Pattern kore-element-var-x1 $.
sorting-rearrange-40 $a |- ( \imp \top ( \kore-valid \unit-sort ( \kore-exists \kore-sort-SortId \unit-sort kore-element-var-x1 ( \kore-equals \kore-sort-SortId \unit-sort kore-element-var-x1 ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ) ) ) $.
typecode-cache-Pattern-253 $a #Pattern kore-element-var-VE5 $.
${ sorting-rearrange-1391 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortMap ) \top ) ( \exists kore-element-var-x1 ( \eq kore-element-var-x1 ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ) ) $= ( top-is-pattern IMP-sort-17-is-pattern typecode-cache-Pattern-253 IMP-sort-14-is-pattern in-sort-is-pattern and-is-pattern string-literal-17-is-pattern kore-dv-is-pattern typecode-cache-Pattern-23 eq-is-pattern exists-is-pattern top-intro rule-weakening sorting-cache-5 sorting-rearrange-40 kore-functional rule-imp-transitivity ) BEFGCHCAKDIJLAMBEFGCHCNODDIJCAPAQRS $. $}
