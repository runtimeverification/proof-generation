$c \exists \unit-sort \top #SetVariable #ElementVariable #Symbol \eq #Variable #Pattern \kore-exists \and \kore-sort-SortK \imp \kore-is-sort |- \kore-valid ) \kore-equals \in-sort \kore-symbol-dotk ( $.
$v kore-sort-var-R ph0 kore-element-var-V0 ph2 x th0 ph1 $.
$d kore-element-var-V0 x $.
$d kore-sort-var-R kore-element-var-V0 $.
$d kore-sort-var-R x $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
th0-is-pattern $f #Pattern th0 $.
x-is-element-var $f #ElementVariable x $.
exists-is-pattern $a #Pattern ( \exists x ph0 ) $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
eq-is-pattern $a #Pattern ( \eq ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
top-intro $a |- \top $.
${ rule-weakening.0 $e |- ph1 $.
   rule-weakening $a |- ( \imp ph0 ph1 ) $. $}
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
${ $d x ph0 $.
   $d x ph1 $.
   kore-functional.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
   kore-functional.1 $e |- ( \imp th0 ( \kore-valid \unit-sort ( \kore-exists ph0 \unit-sort x ( \kore-equals ph0 \unit-sort x ph1 ) ) ) ) $.
   kore-functional $a |- ( \imp th0 ( \exists x ( \eq x ph1 ) ) ) $. $}
BASIC-K-sort-0-is-pattern $a #Pattern \kore-sort-SortK $.
KSEQ-symbol-1-is-pattern $a #Pattern \kore-symbol-dotk $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
kore-element-var-V0-elementvariable $f #ElementVariable kore-element-var-V0 $.
sorting-cache-43 $a |- ( \imp \top ( \in-sort \kore-symbol-dotk \kore-sort-SortK ) ) $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-39 $a #Pattern kore-element-var-V0 $.
sorting-rearrange-275 $a |- ( \imp \top ( \kore-valid \unit-sort ( \kore-exists \kore-sort-SortK \unit-sort kore-element-var-V0 ( \kore-equals \kore-sort-SortK \unit-sort kore-element-var-V0 \kore-symbol-dotk ) ) ) ) $.
${ sorting-rearrange-276 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \exists kore-element-var-V0 ( \eq kore-element-var-V0 \kore-symbol-dotk ) ) ) $= ( top-is-pattern typecode-cache-Pattern-0 kore-is-sort-is-pattern and-is-pattern KSEQ-symbol-1-is-pattern typecode-cache-Pattern-39 eq-is-pattern exists-is-pattern top-intro rule-weakening BASIC-K-sort-0-is-pattern sorting-cache-43 sorting-rearrange-275 kore-functional rule-imp-transitivity ) ADECFCBHGIBJADECFCKLMGCBNBOPQ $. $}
