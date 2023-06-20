$c \exists \top \kore-sort-SortStmt #Variable \kore-sort-SortIds \imp \kore-dv "0" |- \kore-sort-SortId \kore-valid ) \kore-equals \and \unit-sort #SetVariable #ElementVariable #Symbol \eq #Pattern \kore-exists \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' \kore-sort-SortInt \kore-sort-SortGeneratedCounterCell \in-sort \kore-sort-SortMap ( $.
$v ph0 ph2 kore-element-var-VE1 x kore-element-var-VE3 th0 kore-element-var-VE2 kore-element-var-VE4 kore-element-var-Val ptn0 ph1 $.
$d kore-element-var-VE3 kore-element-var-VE1 $.
$d kore-element-var-VE3 kore-element-var-VE4 $.
$d kore-element-var-VE3 kore-element-var-Val $.
$d kore-element-var-VE4 kore-element-var-VE2 $.
$d kore-element-var-Val kore-element-var-VE2 $.
$d kore-element-var-VE3 x $.
$d x kore-element-var-VE1 $.
$d kore-element-var-Val x $.
$d kore-element-var-VE4 kore-element-var-Val $.
$d kore-element-var-VE2 kore-element-var-VE1 $.
$d kore-element-var-VE4 x $.
$d kore-element-var-VE4 kore-element-var-VE1 $.
$d kore-element-var-VE3 kore-element-var-VE2 $.
$d kore-element-var-Val kore-element-var-VE1 $.
$d kore-element-var-VE2 x $.
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
ptn0-pattern $f #Pattern ptn0 $.
kore-element-var-VE2-elementvariable $f #ElementVariable kore-element-var-VE2 $.
kore-element-var-VE1-elementvariable $f #ElementVariable kore-element-var-VE1 $.
kore-element-var-VE3-elementvariable $f #ElementVariable kore-element-var-VE3 $.
kore-element-var-VE4-elementvariable $f #ElementVariable kore-element-var-VE4 $.
IMP-sort-10-is-pattern $a #Pattern \kore-sort-SortGeneratedCounterCell $.
IMP-sort-14-is-pattern $a #Pattern \kore-sort-SortMap $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-symbol-128-is-pattern $a #Pattern ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ptn0 ) $.
kore-element-var-Val-elementvariable $f #ElementVariable kore-element-var-Val $.
string-literal-1-is-pattern $a #Pattern "0" $.
sorting-cache-50 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) \kore-sort-SortGeneratedCounterCell ) ) $.
typecode-cache-Pattern-31 $a #Pattern kore-element-var-Val $.
typecode-cache-Pattern-146 $a #Pattern kore-element-var-VE1 $.
sorting-rearrange-295 $a |- ( \imp \top ( \kore-valid \unit-sort ( \kore-exists \kore-sort-SortGeneratedCounterCell \unit-sort kore-element-var-Val ( \kore-equals \kore-sort-SortGeneratedCounterCell \unit-sort kore-element-var-Val ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) ) $.
typecode-cache-Pattern-177 $a #Pattern kore-element-var-VE2 $.
typecode-cache-Pattern-180 $a #Pattern ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStmt ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortIds ) \top ) ) $.
${ sorting-rearrange-296 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortMap ) ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortId ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStmt ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortIds ) \top ) ) ) ) ( \exists kore-element-var-Val ( \eq kore-element-var-Val ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) $= ( in-sort-is-pattern and-is-pattern top-is-pattern typecode-cache-Pattern-146 IMP-sort-14-is-pattern typecode-cache-Pattern-177 IMP-sort-17-is-pattern typecode-cache-Pattern-180 IMP-sort-23-is-pattern string-literal-1-is-pattern kore-dv-is-pattern IMP-symbol-128-is-pattern typecode-cache-Pattern-31 eq-is-pattern exists-is-pattern top-intro rule-weakening IMP-sort-10-is-pattern sorting-cache-50 sorting-rearrange-295 kore-functional rule-imp-transitivity ) BIJFAKLFCDMGGHERNOPQSETBIJFAKLFCDMGGHUAUBUCNOPQHEUDEUEUFUG $. $}
