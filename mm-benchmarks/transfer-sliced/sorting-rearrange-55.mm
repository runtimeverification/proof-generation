$c \exists #Substitution \top #Variable \imp \kore-is-sort |- \kore-valid ) \kore-equals \and \kore-symbol-Lbl'Stop'Map #SetVariable #ElementVariable \kore-symbol-Lbl'Unds'Map'Unds' #Symbol \eq #Pattern \kore-exists \in-sort \kore-sort-SortMap ( $.
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
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
${ substitution-imp.0 $e #Substitution ph1 ph3 ph0 xX $.
   substitution-imp.1 $e #Substitution ph2 ph4 ph0 xX $.
   substitution-imp $a #Substitution ( \imp ph1 ph2 ) ( \imp ph3 ph4 ) ph0 xX $. $}
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
proof-rule-prop-1 $a |- ( \imp ph0 ( \imp ph1 ph0 ) ) $.
${ proof-rule-mp.0 $e |- ( \imp ph0 ph1 ) $.
   proof-rule-mp.1 $e |- ph0 $.
   proof-rule-mp $a |- ph1 $. $}
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
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
kore-element-var-V0-elementvariable $f #ElementVariable kore-element-var-V0 $.
kore-element-var-V1-elementvariable $f #ElementVariable kore-element-var-V1 $.
kore-element-var-V2-elementvariable $f #ElementVariable kore-element-var-V2 $.
IMP-sort-14-is-pattern $a #Pattern \kore-sort-SortMap $.
IMP-symbol-124-is-pattern $a #Pattern \kore-symbol-Lbl'Stop'Map $.
IMP-symbol-124-sorting $a |- ( \in-sort \kore-symbol-Lbl'Stop'Map \kore-sort-SortMap ) $.
kore-element-var-Val-elementvariable $f #ElementVariable kore-element-var-Val $.
kore-element-var-x0-elementvariable $f #ElementVariable kore-element-var-x0 $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-25 $a #Pattern kore-element-var-x0 $.
typecode-cache-Pattern-36 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortMap ) \top ) ) $.
sorting-rearrange-53 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortMap ) \top ) ) ( \exists kore-element-var-Val ( \eq kore-element-var-Val \kore-symbol-Lbl'Stop'Map ) ) ) $.
typecode-cache-Pattern-37 $a #Pattern kore-element-var-V1 $.
typecode-cache-Pattern-41 $a #Pattern ( \kore-equals \kore-sort-SortMap kore-sort-var-R kore-element-var-V0 ( \kore-symbol-Lbl'Unds'Map'Unds' kore-element-var-V1 kore-element-var-V2 ) ) $.
sorting-rearrange-54 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortMap ) \top ) ) ( \and ( \in-sort kore-element-var-V1 \kore-sort-SortMap ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortMap kore-sort-var-R kore-element-var-V0 ( \kore-equals \kore-sort-SortMap kore-sort-var-R kore-element-var-V0 ( \kore-symbol-Lbl'Unds'Map'Unds' kore-element-var-V1 kore-element-var-V2 ) ) ) ) ) $.
typecode-cache-Pattern-42 $a #Pattern ( \kore-equals \kore-sort-SortMap kore-sort-var-R kore-element-var-V0 ( \kore-symbol-Lbl'Unds'Map'Unds' \kore-symbol-Lbl'Stop'Map kore-element-var-V2 ) ) $.
typecode-cache-Pattern-44 $a #Pattern ( \kore-equals \kore-sort-SortMap kore-sort-var-R kore-element-var-V0 ( \kore-symbol-Lbl'Unds'Map'Unds' kore-element-var-x0 kore-element-var-V2 ) ) $.
substitution-149 $a #Substitution ( \and ( \in-sort \kore-symbol-Lbl'Stop'Map \kore-sort-SortMap ) \top ) ( \and ( \in-sort kore-element-var-V1 \kore-sort-SortMap ) \top ) \kore-symbol-Lbl'Stop'Map kore-element-var-V1 $.
substitution-150 $a #Substitution kore-sort-var-R kore-sort-var-R \kore-symbol-Lbl'Stop'Map kore-element-var-V1 $.
substitution-155 $a #Substitution ( \kore-exists \kore-sort-SortMap kore-sort-var-R kore-element-var-V0 ( \kore-equals \kore-sort-SortMap kore-sort-var-R kore-element-var-V0 ( \kore-symbol-Lbl'Unds'Map'Unds' \kore-symbol-Lbl'Stop'Map kore-element-var-V2 ) ) ) ( \kore-exists \kore-sort-SortMap kore-sort-var-R kore-element-var-V0 ( \kore-equals \kore-sort-SortMap kore-sort-var-R kore-element-var-V0 ( \kore-symbol-Lbl'Unds'Map'Unds' kore-element-var-V1 kore-element-var-V2 ) ) ) \kore-symbol-Lbl'Stop'Map kore-element-var-V1 $.
substitution-159 $a #Substitution ( \and ( \in-sort kore-element-var-x0 \kore-sort-SortMap ) \top ) ( \and ( \in-sort kore-element-var-V1 \kore-sort-SortMap ) \top ) kore-element-var-x0 kore-element-var-V1 $.
substitution-166 $a #Substitution ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortMap kore-sort-var-R kore-element-var-V0 ( \kore-equals \kore-sort-SortMap kore-sort-var-R kore-element-var-V0 ( \kore-symbol-Lbl'Unds'Map'Unds' kore-element-var-x0 kore-element-var-V2 ) ) ) ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortMap kore-sort-var-R kore-element-var-V0 ( \kore-equals \kore-sort-SortMap kore-sort-var-R kore-element-var-V0 ( \kore-symbol-Lbl'Unds'Map'Unds' kore-element-var-V1 kore-element-var-V2 ) ) ) ) kore-element-var-x0 kore-element-var-V1 $.
sorting-cache-262 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortMap ) \top ) ) ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortMap ) \top ) ) ) $.
${ sorting-rearrange-55 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortMap ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortMap kore-sort-var-R kore-element-var-V0 ( \kore-equals \kore-sort-SortMap kore-sort-var-R kore-element-var-V0 ( \kore-symbol-Lbl'Unds'Map'Unds' \kore-symbol-Lbl'Stop'Map kore-element-var-V2 ) ) ) ) ) $= ( IMP-sort-14-is-pattern typecode-cache-Pattern-0 kore-element-var-V1-elementvariable in-sort-is-pattern IMP-symbol-124-is-pattern top-is-pattern and-is-pattern kore-exists-is-pattern typecode-cache-Pattern-36 kore-valid-is-pattern kore-element-var-x0-elementvariable typecode-cache-Pattern-42 typecode-cache-Pattern-41 typecode-cache-Pattern-37 typecode-cache-Pattern-25 element-var-is-var rule-and-intro-alt2-sugar typecode-cache-Pattern-44 kore-element-var-Val-elementvariable substitution-imp sorting-cache-262 imp-is-pattern proof-rule-prop-1 IMP-symbol-124-sorting proof-rule-mp top-intro rule-weakening sorting-rearrange-53 sorting-rearrange-54 substitution-149 substitution-150 substitution-155 substitution-kore-valid substitution-159 substitution-166 functional-substitution-alt rule-imp-transitivity ) ACLACLHDGIJJAEDAEABCOBKMACLACLHDGIJACUDACLHDGIHDGACLHDGUEHDGACLUFUGUHACLIUIUJTTHAEDAEABFCPBKMAEDAEABCOBKMAEDAEABCNUABKMACLFQDGIJHDGIJNRDGIJUBFNACUBUKABFCULHHDGIJAEDAEABCOBKMFQDGIJAEDAEABFCPBKMFSFUMAEDAEABCOBKAEDAEABFCPBKHFSAFUNABFCUOUPUCNRNRDGIJAEDAEABCNUABKMFQDGIJAEDAEABFCPBKMFSFNUQABFCNURUCUSUT $. $}
