$c \exists #Substitution "amount" \kore-sort-SortBExp \top \kore-sort-SortAExp \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp #Variable \imp \kore-dv \kore-is-sort |- \kore-sort-SortId \kore-valid ) \kore-equals \and #SetVariable #ElementVariable #Symbol \eq #Pattern \kore-exists \kore-inj \in-sort ( $.
$v z th2 th0 kore-element-var-x0 th1 kore-element-var-Val ph3 ph1 th3 kore-sort-var-R ph0 ph2 xX x kore-element-var-K0 y ph4 kore-element-var-K1 $.
$d y z $.
$d kore-element-var-x0 kore-element-var-Val $.
$d kore-element-var-K1 kore-element-var-Val $.
$d kore-sort-var-R kore-element-var-Val $.
$d kore-element-var-x0 kore-element-var-K0 $.
$d z x $.
$d kore-element-var-K1 x $.
$d kore-element-var-K1 kore-element-var-K0 $.
$d kore-element-var-K0 x $.
$d kore-sort-var-R kore-element-var-K1 $.
$d kore-sort-var-R kore-element-var-K0 $.
$d kore-element-var-Val x $.
$d z kore-element-var-Val $.
$d kore-element-var-x0 kore-element-var-K1 $.
$d kore-sort-var-R x $.
$d y x $.
$d kore-element-var-x0 x $.
$d kore-element-var-x0 y $.
$d y kore-element-var-K0 $.
$d kore-element-var-x0 kore-sort-var-R $.
$d y kore-element-var-Val $.
$d kore-element-var-x0 z $.
$d kore-element-var-K1 z $.
$d y kore-element-var-K1 $.
$d kore-element-var-Val kore-element-var-K0 $.
$d kore-sort-var-R z $.
$d z kore-element-var-K0 $.
$d y kore-sort-var-R $.
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
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-22-is-pattern $a #Pattern \kore-sort-SortBExp $.
kore-element-var-Val-elementvariable $f #ElementVariable kore-element-var-Val $.
kore-element-var-K0-elementvariable $f #ElementVariable kore-element-var-K0 $.
kore-element-var-K1-elementvariable $f #ElementVariable kore-element-var-K1 $.
kore-element-var-x0-elementvariable $f #ElementVariable kore-element-var-x0 $.
string-literal-14-is-pattern $a #Pattern "amount" $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-25 $a #Pattern kore-element-var-x0 $.
typecode-cache-Pattern-51 $a #Pattern kore-element-var-K0 $.
typecode-cache-Pattern-86 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortAExp ) \top ) ) $.
sorting-cache-307 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortAExp ) \top ) ) ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortAExp ) \top ) ) ) $.
sorting-rearrange-174 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortAExp ) \top ) ) ( \exists kore-element-var-Val ( \eq kore-element-var-Val ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ) $.
typecode-cache-Pattern-115 $a #Pattern ( \kore-equals \kore-sort-SortBExp kore-sort-var-R kore-element-var-Val ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp kore-element-var-K0 kore-element-var-K1 ) ) $.
sorting-rearrange-175 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortAExp ) \top ) ) ( \and ( \in-sort kore-element-var-K0 \kore-sort-SortAExp ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortBExp kore-sort-var-R kore-element-var-Val ( \kore-equals \kore-sort-SortBExp kore-sort-var-R kore-element-var-Val ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp kore-element-var-K0 kore-element-var-K1 ) ) ) ) ) $.
typecode-cache-Pattern-116 $a #Pattern ( \kore-equals \kore-sort-SortBExp kore-sort-var-R kore-element-var-Val ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) kore-element-var-K1 ) ) $.
typecode-cache-Pattern-118 $a #Pattern ( \kore-equals \kore-sort-SortBExp kore-sort-var-R kore-element-var-Val ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp kore-element-var-x0 kore-element-var-K1 ) ) $.
substitution-335 $a #Substitution ( \kore-exists \kore-sort-SortBExp kore-sort-var-R kore-element-var-Val ( \kore-equals \kore-sort-SortBExp kore-sort-var-R kore-element-var-Val ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) kore-element-var-K1 ) ) ) ( \kore-exists \kore-sort-SortBExp kore-sort-var-R kore-element-var-Val ( \kore-equals \kore-sort-SortBExp kore-sort-var-R kore-element-var-Val ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp kore-element-var-K0 kore-element-var-K1 ) ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) kore-element-var-K0 $.
substitution-338 $a #Substitution ( \and ( \in-sort kore-element-var-x0 \kore-sort-SortAExp ) \top ) ( \and ( \in-sort kore-element-var-K0 \kore-sort-SortAExp ) \top ) kore-element-var-x0 kore-element-var-K0 $.
substitution-343 $a #Substitution ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortBExp kore-sort-var-R kore-element-var-Val ( \kore-equals \kore-sort-SortBExp kore-sort-var-R kore-element-var-Val ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp kore-element-var-x0 kore-element-var-K1 ) ) ) ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortBExp kore-sort-var-R kore-element-var-Val ( \kore-equals \kore-sort-SortBExp kore-sort-var-R kore-element-var-Val ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp kore-element-var-K0 kore-element-var-K1 ) ) ) ) kore-element-var-x0 kore-element-var-K0 $.
sorting-cache-353 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortAExp ) \top ) ) ( \in-sort ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) \kore-sort-SortAExp ) ) $.
${ sorting-rearrange-176 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortAExp ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortBExp kore-sort-var-R kore-element-var-Val ( \kore-equals \kore-sort-SortBExp kore-sort-var-R kore-element-var-Val ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) kore-element-var-K1 ) ) ) ) ) $= ( IMP-sort-17-is-pattern IMP-sort-13-is-pattern kore-element-var-K0-elementvariable typecode-cache-Pattern-0 string-literal-14-is-pattern kore-dv-is-pattern kore-inj-is-pattern top-is-pattern in-sort-is-pattern and-is-pattern IMP-sort-22-is-pattern kore-exists-is-pattern element-var-is-var kore-valid-is-pattern kore-element-var-x0-elementvariable typecode-cache-Pattern-86 typecode-cache-Pattern-51 typecode-cache-Pattern-116 typecode-cache-Pattern-115 typecode-cache-Pattern-25 substitution-disjoint rule-and-intro-alt2-sugar typecode-cache-Pattern-118 substitution-imp sorting-cache-307 sorting-cache-353 top-intro rule-weakening sorting-rearrange-174 sorting-rearrange-175 substitution-var-same substitution-in-sort substitution-and substitution-335 substitution-kore-valid substitution-338 substitution-343 functional-substitution-alt rule-imp-transitivity ) ACSACSDEDHIJELKMMAGNAGABCUABOQACSACSDEDHIJELKMACUHACSDEDHIJELKACUIACSKUJUKUEUEDEDHIJAGNAGABFCUBBOQAGNAGABCUABOQAGNAGABCRUFBOQACSFTELKMDEDHIJELKMRUCELKMBFRABCULABFCUMDEDHIJDEDHIJELKMAGNAGABCUABOQFTELKMAGNAGABFCUBBOQFPDEDHIJDEDHIJELKFTELKFPDEDHIJDEDHIJEFTEFPDEDHIJFPUNEDEDHIJFPUDUOKDEDHIJFPUDUPAGNAGABCUABOAGNAGABFCUBBODEDHIJFPAGDEDHIJFPUDABFCUQURUGRUCRUCELKMAGNAGABCRUFBOQFTELKMAGNAGABFCUBBOQFPFRUSABFCRUTUGVAVB $. $}
