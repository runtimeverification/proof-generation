$c \exists \top \kore-sort-SortAExp #Variable "10" \kore-sort-SortK \imp \kore-dv |- \kore-valid ) \kore-equals \and \unit-sort #SetVariable #ElementVariable #Symbol \eq #Pattern \kore-exists \kore-inj \kore-sort-SortInt \in-sort \kore-sort-SortStateCell ( $.
$v ph0 ph2 x kore-element-var-VE3 th0 kore-element-var-VE2 kore-element-var-VE4 kore-element-var-Val ph1 $.
$d kore-element-var-VE3 kore-element-var-VE4 $.
$d kore-element-var-VE3 kore-element-var-Val $.
$d kore-element-var-VE4 kore-element-var-VE2 $.
$d kore-element-var-Val kore-element-var-VE2 $.
$d kore-element-var-VE3 x $.
$d kore-element-var-Val x $.
$d kore-element-var-VE4 kore-element-var-Val $.
$d kore-element-var-VE4 x $.
$d kore-element-var-VE3 kore-element-var-VE2 $.
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
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
${ $d x ph0 $.
   $d x ph1 $.
   kore-functional.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
   kore-functional.1 $e |- ( \imp th0 ( \kore-valid \unit-sort ( \kore-exists ph0 \unit-sort x ( \kore-equals ph0 \unit-sort x ph1 ) ) ) ) $.
   kore-functional $a |- ( \imp th0 ( \exists x ( \eq x ph1 ) ) ) $. $}
BASIC-K-sort-0-is-pattern $a #Pattern \kore-sort-SortK $.
kore-element-var-VE2-elementvariable $f #ElementVariable kore-element-var-VE2 $.
kore-element-var-VE3-elementvariable $f #ElementVariable kore-element-var-VE3 $.
kore-element-var-VE4-elementvariable $f #ElementVariable kore-element-var-VE4 $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
kore-element-var-Val-elementvariable $f #ElementVariable kore-element-var-Val $.
string-literal-13-is-pattern $a #Pattern "10" $.
sorting-cache-19 $a |- ( \imp \top ( \in-sort ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "10" ) ) \kore-sort-SortAExp ) ) $.
typecode-cache-Pattern-31 $a #Pattern kore-element-var-Val $.
sorting-rearrange-130 $a |- ( \imp \top ( \kore-valid \unit-sort ( \kore-exists \kore-sort-SortAExp \unit-sort kore-element-var-Val ( \kore-equals \kore-sort-SortAExp \unit-sort kore-element-var-Val ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "10" ) ) ) ) ) ) $.
typecode-cache-Pattern-177 $a #Pattern kore-element-var-VE2 $.
typecode-cache-Pattern-286 $a #Pattern ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortAExp ) \top ) ) $.
${ sorting-rearrange-980 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortK ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortAExp ) \top ) ) ) ( \exists kore-element-var-Val ( \eq kore-element-var-Val ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "10" ) ) ) ) ) $= ( IMP-sort-23-is-pattern top-is-pattern IMP-sort-13-is-pattern typecode-cache-Pattern-177 BASIC-K-sort-0-is-pattern in-sort-is-pattern typecode-cache-Pattern-286 and-is-pattern string-literal-13-is-pattern kore-dv-is-pattern kore-inj-is-pattern typecode-cache-Pattern-31 eq-is-pattern exists-is-pattern top-intro rule-weakening sorting-cache-19 sorting-rearrange-130 kore-functional rule-imp-transitivity ) AHIJBCKLFDPEGEMNOQDRAHIJBCKLFSTGEGEMNOFDUADUBUCUD $. $}
