$c \exists #Substitution \top #Variable "200" \imp \kore-dv \kore-is-sort |- \kore-valid ) \kore-equals \and \unit-sort #SetVariable #ElementVariable #Symbol \eq #Pattern \kore-exists \kore-sort-SortInt ( $.
$v z sg0 th2 th0 ph6 kore-sort-var-x0 th1 kore-element-var-x1 ph3 ph1 th3 ph0 ph2 xX x y ph4 kore-sort-var-x1 ph5 $.
$d kore-sort-var-x1 kore-sort-var-x0 $.
$d y z $.
$d kore-element-var-x1 x $.
$d y kore-sort-var-x1 $.
$d y kore-element-var-x1 $.
$d z x $.
$d kore-sort-var-x1 z $.
$d z kore-sort-var-x0 $.
$d y x $.
$d z kore-element-var-x1 $.
$d y kore-sort-var-x0 $.
$d kore-sort-var-x1 kore-element-var-x1 $.
$d x kore-sort-var-x0 $.
$d kore-element-var-x1 kore-sort-var-x0 $.
$d kore-sort-var-x1 x $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
ph4-is-pattern $f #Pattern ph4 $.
ph5-is-pattern $f #Pattern ph5 $.
ph6-is-pattern $f #Pattern ph6 $.
th0-is-pattern $f #Pattern th0 $.
th1-is-pattern $f #Pattern th1 $.
th2-is-pattern $f #Pattern th2 $.
th3-is-pattern $f #Pattern th3 $.
x-is-element-var $f #ElementVariable x $.
y-is-element-var $f #ElementVariable y $.
z-is-element-var $f #ElementVariable z $.
xX-is-var $f #Variable xX $.
sg0-is-symbol $f #Symbol sg0 $.
element-var-is-var $a #Variable x $.
symbol-is-pattern $a #Pattern sg0 $.
exists-is-pattern $a #Pattern ( \exists x ph0 ) $.
substitution-var-same $a #Substitution ph0 xX ph0 xX $.
${ substitution-imp.0 $e #Substitution ph1 ph3 ph0 xX $.
   substitution-imp.1 $e #Substitution ph2 ph4 ph0 xX $.
   substitution-imp $a #Substitution ( \imp ph1 ph2 ) ( \imp ph3 ph4 ) ph0 xX $. $}
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
unit-sort-is-symbol $a #Symbol \unit-sort $.
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
${ $d xX y $.
   $d y ph6 $.
   substitution-kore-exists-alt.0 $e #Substitution ph0 ph3 ph6 xX $.
   substitution-kore-exists-alt.1 $e #Substitution ph1 ph4 ph6 xX $.
   substitution-kore-exists-alt.2 $e #Substitution ph2 ph5 ph6 xX $.
   substitution-kore-exists-alt $a #Substitution ( \kore-exists ph0 ph1 y ph2 ) ( \kore-exists ph3 ph4 y ph5 ) ph6 xX $. $}
${ substitution-kore-valid.0 $e #Substitution ph0 ph2 ph4 xX $.
   substitution-kore-valid.1 $e #Substitution ph1 ph3 ph4 xX $.
   substitution-kore-valid $a #Substitution ( \kore-valid ph0 ph1 ) ( \kore-valid ph2 ph3 ) ph4 xX $. $}
unit-sort-is-functional $a |- ( \exists x ( \eq x \unit-sort ) ) $.
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
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
kore-sort-var-x0-elementvariable $f #ElementVariable kore-sort-var-x0 $.
kore-element-var-x1-elementvariable $f #ElementVariable kore-element-var-x1 $.
string-literal-15-is-pattern $a #Pattern "200" $.
typecode-cache-Pattern-14 $a #Pattern kore-sort-var-x0 $.
kore-sort-var-x1-elementvariable $f #ElementVariable kore-sort-var-x1 $.
typecode-cache-Pattern-22 $a #Pattern ( \eq x \unit-sort ) $.
typecode-cache-Pattern-23 $a #Pattern kore-element-var-x1 $.
typecode-cache-Pattern-24 $a #Pattern kore-sort-var-x1 $.
substitution-60 $a #Substitution ( \and ( \kore-is-sort \unit-sort ) \top ) ( \and ( \kore-is-sort kore-sort-var-x0 ) \top ) \unit-sort kore-sort-var-x0 $.
substitution-66 $a #Substitution ( \and ( \kore-is-sort kore-sort-var-x1 ) \top ) ( \and ( \kore-is-sort kore-sort-var-x0 ) \top ) kore-sort-var-x1 kore-sort-var-x0 $.
sorting-cache-129 $a |- ( \imp \top ( \and ( \kore-is-sort \unit-sort ) \top ) ) $.
substitution-116 $a #Substitution \kore-sort-SortInt \kore-sort-SortInt \unit-sort kore-sort-var-x0 $.
substitution-118 $a #Substitution \kore-sort-SortInt \kore-sort-SortInt kore-sort-var-x1 kore-sort-var-x0 $.
sorting-rearrange-44 $a |- ( \imp ( \and \top ( \and ( \kore-is-sort kore-sort-var-x0 ) \top ) ) ( \kore-valid kore-sort-var-x0 ( \kore-exists \kore-sort-SortInt kore-sort-var-x0 kore-element-var-x1 ( \kore-equals \kore-sort-SortInt kore-sort-var-x0 kore-element-var-x1 ( \kore-dv \kore-sort-SortInt "200" ) ) ) ) ) $.
substitution-137 $a #Substitution ( \kore-equals \kore-sort-SortInt \unit-sort kore-element-var-x1 ( \kore-dv \kore-sort-SortInt "200" ) ) ( \kore-equals \kore-sort-SortInt kore-sort-var-x0 kore-element-var-x1 ( \kore-dv \kore-sort-SortInt "200" ) ) \unit-sort kore-sort-var-x0 $.
substitution-138 $a #Substitution ( \kore-equals \kore-sort-SortInt kore-sort-var-x1 kore-element-var-x1 ( \kore-dv \kore-sort-SortInt "200" ) ) ( \kore-equals \kore-sort-SortInt kore-sort-var-x0 kore-element-var-x1 ( \kore-dv \kore-sort-SortInt "200" ) ) kore-sort-var-x1 kore-sort-var-x0 $.
${ sorting-rearrange-45 $p |- ( \imp \top ( \kore-valid \unit-sort ( \kore-exists \kore-sort-SortInt \unit-sort kore-element-var-x1 ( \kore-equals \kore-sort-SortInt \unit-sort kore-element-var-x1 ( \kore-dv \kore-sort-SortInt "200" ) ) ) ) ) $= ( IMP-sort-23-is-pattern kore-sort-var-x0-elementvariable unit-sort-is-symbol symbol-is-pattern typecode-cache-Pattern-14 kore-sort-var-x1-elementvariable typecode-cache-Pattern-24 top-is-pattern typecode-cache-Pattern-23 string-literal-15-is-pattern kore-dv-is-pattern kore-equals-is-pattern kore-exists-is-pattern and-is-pattern element-var-is-var kore-is-sort-is-pattern kore-valid-is-pattern x-is-element-var substitution-var-same rule-weakening substitution-kore-exists-alt substitution-kore-valid substitution-imp top-intro sorting-cache-129 rule-and-intro-alt2-sugar typecode-cache-Pattern-22 exists-is-pattern unit-sort-is-functional sorting-rearrange-44 substitution-60 substitution-116 substitution-137 substitution-66 substitution-118 substitution-138 functional-substitution-alt rule-imp-transitivity ) IIDEQIOODEBDEBDEAJBKLMANRIIDEQIOIIUEUAUFUGDECFBCFBCFAJBKLMANRDEBDEBDEAJBKLMANRGHBGHBGHAJBKLMANRICFQIODEQIOGHQIOSCGISUHSUISUJUACAUKDEDEQIODEBDEBDEAJBKLMANRCFQIOCFBCFBCFAJBKLMANRCPCULDEBDEBDEAJBKLMANCFBCFBCFAJBKLMANDECPDECPTBDEBDEAJBKLMBCFBCFAJBKLMDEACPCUMDECPTCAUNUBUCUDGHGHQIOGHBGHBGHAJBKLMANRCFQIOCFBCFBCFAJBKLMANRCPCGUOGHBGHBGHAJBKLMANCFBCFBCFAJBKLMANGHCPGHCPTBGHBGHAJBKLMBCFBCFAJBKLMGHACPCGUPGHCPTCAGUQUBUCUDURUS $. $}
