$c \exists \top \kore-symbol-kseq #Variable "10" \kore-sort-SortK \imp \kore-dv \kore-is-sort |- \kore-valid ) \kore-equals \and \unit-sort \kore-symbol-Lbl'Hash'freezer'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp1'Unds' #SetVariable #ElementVariable #Symbol \eq #Pattern \kore-exists \kore-sort-SortKItem \kore-inj \kore-sort-SortInt \in-sort \kore-symbol-dotk ( $.
$v kore-sort-var-R kore-element-var-V2 ph0 ph2 x th0 ptn1 kore-element-var-Val ptn0 ph1 $.
$d kore-sort-var-R kore-element-var-V2 $.
$d kore-sort-var-R kore-element-var-Val $.
$d kore-element-var-Val x $.
$d kore-element-var-V2 kore-element-var-Val $.
$d kore-element-var-V2 x $.
$d kore-sort-var-R x $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
th0-is-pattern $f #Pattern th0 $.
x-is-element-var $f #ElementVariable x $.
exists-is-pattern $a #Pattern ( \exists x ph0 ) $.
top-is-pattern $a #Pattern \top $.
eq-is-pattern $a #Pattern ( \eq ph0 ph1 ) $.
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
ptn0-pattern $f #Pattern ptn0 $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
ptn1-pattern $f #Pattern ptn1 $.
KSEQ-symbol-0-is-pattern $a #Pattern ( \kore-symbol-kseq ptn0 ptn1 ) $.
KSEQ-symbol-1-is-pattern $a #Pattern \kore-symbol-dotk $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
kore-element-var-V2-elementvariable $f #ElementVariable kore-element-var-V2 $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-symbol-95-is-pattern $a #Pattern ( \kore-symbol-Lbl'Hash'freezer'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp1'Unds' ptn0 ) $.
kore-element-var-Val-elementvariable $f #ElementVariable kore-element-var-Val $.
string-literal-13-is-pattern $a #Pattern "10" $.
sorting-cache-172 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'Hash'freezer'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp1'Unds' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "10" ) ) \kore-symbol-dotk ) ) \kore-sort-SortKItem ) ) $.
typecode-cache-Pattern-31 $a #Pattern kore-element-var-Val $.
typecode-cache-Pattern-156 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) ) $.
sorting-rearrange-1007 $a |- ( \imp \top ( \kore-valid \unit-sort ( \kore-exists \kore-sort-SortKItem \unit-sort kore-element-var-Val ( \kore-equals \kore-sort-SortKItem \unit-sort kore-element-var-Val ( \kore-symbol-Lbl'Hash'freezer'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp1'Unds' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "10" ) ) \kore-symbol-dotk ) ) ) ) ) ) $.
${ sorting-rearrange-1008 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) ) ( \exists kore-element-var-Val ( \eq kore-element-var-Val ( \kore-symbol-Lbl'Hash'freezer'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp1'Unds' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "10" ) ) \kore-symbol-dotk ) ) ) ) ) $= ( IMP-sort-23-is-pattern top-is-pattern BASIC-K-sort-1-is-pattern typecode-cache-Pattern-156 string-literal-13-is-pattern kore-dv-is-pattern kore-inj-is-pattern KSEQ-symbol-1-is-pattern KSEQ-symbol-0-is-pattern IMP-symbol-95-is-pattern typecode-cache-Pattern-31 eq-is-pattern exists-is-pattern top-intro rule-weakening sorting-cache-172 sorting-rearrange-1007 kore-functional rule-imp-transitivity ) ABGECNDFDHIJKLMOCPABGEQRFDFDHIJKLMECSCTUAUB $. $}
