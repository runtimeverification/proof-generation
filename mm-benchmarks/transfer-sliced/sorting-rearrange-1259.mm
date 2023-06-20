$c \exists \top \kore-sort-SortAExp #Variable "90" \imp \kore-dv |- \kore-valid ) \kore-equals \and \unit-sort #SetVariable #ElementVariable #Symbol \eq #Pattern \kore-exists \kore-sort-SortKItem \kore-inj \kore-sort-SortInt \in-sort ( $.
$v ph0 ph2 x th0 kore-element-var-VE5 kore-element-var-Val ph1 $.
$d kore-element-var-Val x $.
$d kore-element-var-VE5 x $.
$d kore-element-var-VE5 kore-element-var-Val $.
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
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
kore-element-var-Val-elementvariable $f #ElementVariable kore-element-var-Val $.
kore-element-var-VE5-elementvariable $f #ElementVariable kore-element-var-VE5 $.
string-literal-19-is-pattern $a #Pattern "90" $.
sorting-cache-207 $a |- ( \imp \top ( \in-sort ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "90" ) ) \kore-sort-SortAExp ) ) $.
typecode-cache-Pattern-31 $a #Pattern kore-element-var-Val $.
typecode-cache-Pattern-253 $a #Pattern kore-element-var-VE5 $.
sorting-rearrange-1258 $a |- ( \imp \top ( \kore-valid \unit-sort ( \kore-exists \kore-sort-SortAExp \unit-sort kore-element-var-Val ( \kore-equals \kore-sort-SortAExp \unit-sort kore-element-var-Val ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "90" ) ) ) ) ) ) $.
${ sorting-rearrange-1259 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) \top ) ( \exists kore-element-var-Val ( \eq kore-element-var-Val ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "90" ) ) ) ) ) $= ( top-is-pattern IMP-sort-23-is-pattern IMP-sort-13-is-pattern typecode-cache-Pattern-253 BASIC-K-sort-1-is-pattern in-sort-is-pattern and-is-pattern string-literal-19-is-pattern kore-dv-is-pattern kore-inj-is-pattern typecode-cache-Pattern-31 eq-is-pattern exists-is-pattern top-intro rule-weakening sorting-cache-207 sorting-rearrange-1258 kore-functional rule-imp-transitivity ) BFGHCICAMDEDJKLNAOBFGHCICPQEDEDJKLCARASTUA $. $}
