$c \exists #Substitution \top \kore-symbol-kseq #Variable \kore-sort-SortBool \kore-sort-SortK \imp \kore-dv \kore-is-sort |- \kore-valid ) \kore-equals "false" \and #SetVariable #ElementVariable #Symbol \eq #Pattern \kore-exists \kore-sort-SortKItem \kore-inj \in-sort ( $.
$v kore-element-var-V0 z th2 th0 kore-element-var-x0 th1 kore-element-var-Val kore-element-var-V1 ph3 ph1 th3 kore-sort-var-R kore-element-var-V2 ph0 ph2 xX x y ph4 $.
$d kore-element-var-V0 z $.
$d y z $.
$d kore-element-var-x0 kore-element-var-Val $.
$d kore-element-var-V0 x $.
$d kore-element-var-V0 kore-element-var-V1 $.
$d kore-element-var-V2 kore-element-var-V1 $.
$d kore-sort-var-R kore-element-var-V2 $.
$d kore-sort-var-R kore-element-var-Val $.
$d kore-sort-var-R kore-element-var-V0 $.
$d z x $.
$d kore-element-var-x0 kore-element-var-V0 $.
$d kore-element-var-Val x $.
$d z kore-element-var-Val $.
$d kore-element-var-Val kore-element-var-V1 $.
$d kore-element-var-V2 kore-element-var-Val $.
$d y kore-element-var-V1 $.
$d kore-element-var-V2 x $.
$d kore-sort-var-R x $.
$d y x $.
$d kore-sort-var-R kore-element-var-V1 $.
$d kore-element-var-x0 x $.
$d kore-element-var-x0 y $.
$d z kore-element-var-V1 $.
$d kore-element-var-x0 kore-element-var-V1 $.
$d kore-element-var-x0 kore-sort-var-R $.
$d y kore-element-var-Val $.
$d y kore-element-var-V2 $.
$d kore-element-var-V1 x $.
$d kore-element-var-x0 z $.
$d kore-element-var-V2 kore-element-var-V0 $.
$d kore-sort-var-R z $.
$d kore-element-var-x0 kore-element-var-V2 $.
$d kore-element-var-V2 z $.
$d kore-element-var-V0 kore-element-var-Val $.
$d y kore-sort-var-R $.
$d y kore-element-var-V0 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
ph4-is-pattern $f #Pattern ph4 $.
th0-is-pattern $f #Pattern th0 $.
th1-is-pattern $f #Pattern th1 $.
th2-is-pattern $f #Pattern th2 $.
th3-is-pattern $f #Pattern th3 $.
x-is-element-var $f #ElementVariable x $.
y-is-element-var $f #ElementVariable y $.
z-is-element-var $f #ElementVariable z $.
xX-is-var $f #Variable xX $.
element-var-is-var $a #Variable x $.
substitution-var-same $a #Substitution ph0 xX ph0 xX $.
${ substitution-imp.0 $e #Substitution ph1 ph3 ph0 xX $.
   substitution-imp.1 $e #Substitution ph2 ph4 ph0 xX $.
   substitution-imp $a #Substitution ( \imp ph1 ph2 ) ( \imp ph3 ph4 ) ph0 xX $. $}
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
top-intro $a |- \top $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
${ $d xX ph0 $.
   substitution-disjoint $a #Substitution ph0 ph0 ph1 xX $. $}
${ substitution-and.0 $e #Substitution ph1 ph3 ph0 xX $.
   substitution-and.1 $e #Substitution ph2 ph4 ph0 xX $.
   substitution-and $a #Substitution ( \and ph1 ph2 ) ( \and ph3 ph4 ) ph0 xX $. $}
${ substitution-in-sort.0 $e #Substitution ph1 ph3 ph0 xX $.
   substitution-in-sort.1 $e #Substitution ph2 ph4 ph0 xX $.
   substitution-in-sort $a #Substitution ( \in-sort ph1 ph2 ) ( \in-sort ph3 ph4 ) ph0 xX $. $}
${ rule-weakening.0 $e |- ph1 $.
   rule-weakening $a |- ( \imp ph0 ph1 ) $. $}
kore-exists-is-pattern $a #Pattern ( \kore-exists ph0 ph1 x ph2 ) $.
kore-valid-is-pattern $a #Pattern ( \kore-valid ph0 ph1 ) $.
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
${ substitution-kore-valid.0 $e #Substitution ph0 ph2 ph4 xX $.
   substitution-kore-valid.1 $e #Substitution ph1 ph3 ph4 xX $.
   substitution-kore-valid $a #Substitution ( \kore-valid ph0 ph1 ) ( \kore-valid ph2 ph3 ) ph4 xX $. $}
${ $d z ph0 $.
   $d z ph1 $.
   $d z ph2 $.
   $d z y $.
   $d z x $.
   $d z th1 $.
   $d z th2 $.
   $d x ph0 $.
   $d y th0 $.
   functional-substitution-alt.0 $e |- ( \imp th0 ( \exists x ( \eq x ph0 ) ) ) $.
   functional-substitution-alt.1 $e |- ( \imp ( \and th0 th1 ) ph1 ) $.
   functional-substitution-alt.2 $e #Substitution ( \imp th2 ph2 ) ( \imp th1 ph1 ) ph0 y $.
   functional-substitution-alt.3 $e #Substitution ( \imp th3 ph3 ) ( \imp th1 ph1 ) z y $.
   functional-substitution-alt $a |- ( \imp ( \and th0 th2 ) ph2 ) $. $}
BASIC-K-sort-0-is-pattern $a #Pattern \kore-sort-SortK $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
kore-element-var-V0-elementvariable $f #ElementVariable kore-element-var-V0 $.
kore-element-var-V1-elementvariable $f #ElementVariable kore-element-var-V1 $.
kore-element-var-V2-elementvariable $f #ElementVariable kore-element-var-V2 $.
IMP-sort-32-is-pattern $a #Pattern \kore-sort-SortBool $.
kore-element-var-Val-elementvariable $f #ElementVariable kore-element-var-Val $.
string-literal-5-is-pattern $a #Pattern "false" $.
kore-element-var-x0-elementvariable $f #ElementVariable kore-element-var-x0 $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-25 $a #Pattern kore-element-var-x0 $.
typecode-cache-Pattern-37 $a #Pattern kore-element-var-V1 $.
typecode-cache-Pattern-156 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) ) $.
typecode-cache-Pattern-159 $a #Pattern ( \kore-equals \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-symbol-kseq kore-element-var-V1 kore-element-var-V2 ) ) $.
sorting-rearrange-273 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) ) ( \and ( \in-sort kore-element-var-V1 \kore-sort-SortKItem ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-equals \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-symbol-kseq kore-element-var-V1 kore-element-var-V2 ) ) ) ) ) $.
typecode-cache-Pattern-161 $a #Pattern ( \kore-equals \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-symbol-kseq kore-element-var-x0 kore-element-var-V2 ) ) $.
substitution-474 $a #Substitution ( \and ( \in-sort kore-element-var-x0 \kore-sort-SortKItem ) \top ) ( \and ( \in-sort kore-element-var-V1 \kore-sort-SortKItem ) \top ) kore-element-var-x0 kore-element-var-V1 $.
substitution-479 $a #Substitution ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-equals \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-symbol-kseq kore-element-var-x0 kore-element-var-V2 ) ) ) ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-equals \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-symbol-kseq kore-element-var-V1 kore-element-var-V2 ) ) ) ) kore-element-var-x0 kore-element-var-V1 $.
sorting-cache-537 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) ) ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) ) ) $.
sorting-rearrange-1088 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) ) ( \exists kore-element-var-Val ( \eq kore-element-var-Val ( \kore-inj \kore-sort-SortBool \kore-sort-SortKItem ( \kore-dv \kore-sort-SortBool "false" ) ) ) ) ) $.
typecode-cache-Pattern-373 $a #Pattern ( \kore-equals \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBool \kore-sort-SortKItem ( \kore-dv \kore-sort-SortBool "false" ) ) kore-element-var-V2 ) ) $.
substitution-1044 $a #Substitution ( \kore-exists \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-equals \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBool \kore-sort-SortKItem ( \kore-dv \kore-sort-SortBool "false" ) ) kore-element-var-V2 ) ) ) ( \kore-exists \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-equals \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-symbol-kseq kore-element-var-V1 kore-element-var-V2 ) ) ) ( \kore-inj \kore-sort-SortBool \kore-sort-SortKItem ( \kore-dv \kore-sort-SortBool "false" ) ) kore-element-var-V1 $.
sorting-cache-1785 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) ) ( \in-sort ( \kore-inj \kore-sort-SortBool \kore-sort-SortKItem ( \kore-dv \kore-sort-SortBool "false" ) ) \kore-sort-SortKItem ) ) $.
${ sorting-rearrange-1089 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-equals \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBool \kore-sort-SortKItem ( \kore-dv \kore-sort-SortBool "false" ) ) kore-element-var-V2 ) ) ) ) ) $= ( IMP-sort-32-is-pattern BASIC-K-sort-1-is-pattern kore-element-var-V1-elementvariable typecode-cache-Pattern-0 string-literal-5-is-pattern kore-dv-is-pattern kore-inj-is-pattern top-is-pattern in-sort-is-pattern and-is-pattern BASIC-K-sort-0-is-pattern kore-exists-is-pattern element-var-is-var kore-valid-is-pattern kore-element-var-x0-elementvariable typecode-cache-Pattern-156 typecode-cache-Pattern-37 typecode-cache-Pattern-373 typecode-cache-Pattern-159 typecode-cache-Pattern-25 substitution-disjoint rule-and-intro-alt2-sugar typecode-cache-Pattern-161 kore-element-var-Val-elementvariable substitution-imp sorting-cache-537 sorting-cache-1785 top-intro rule-weakening sorting-rearrange-1088 sorting-rearrange-273 substitution-var-same substitution-in-sort substitution-and substitution-1044 substitution-kore-valid substitution-474 substitution-479 functional-substitution-alt rule-imp-transitivity ) ACSACSDEDHIJELKMMAGNAGABCUABOQACSACSDEDHIJELKMACUIACSDEDHIJELKACUJACSKUKULUEUEDEDHIJAGNAGABFCUBBOQAGNAGABCUABOQAGNAGABCRUFBOQACSFTELKMDEDHIJELKMRUCELKMUGFRACUGUMABFCUNDEDHIJDEDHIJELKMAGNAGABCUABOQFTELKMAGNAGABFCUBBOQFPDEDHIJDEDHIJELKFTELKFPDEDHIJDEDHIJEFTEFPDEDHIJFPUOEDEDHIJFPUDUPKDEDHIJFPUDUQAGNAGABCUABOAGNAGABFCUBBODEDHIJFPAGDEDHIJFPUDABFCURUSUHRUCRUCELKMAGNAGABCRUFBOQFTELKMAGNAGABFCUBBOQFPFRUTABFCRVAUHVBVC $. $}
