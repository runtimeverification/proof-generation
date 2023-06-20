$c \exists #Substitution \top "210" #Variable \imp \kore-dv \kore-is-sort |- \kore-valid ) \kore-equals \and \unit-sort \kore-sort-SortKResult #SetVariable #ElementVariable #Symbol \eq #Pattern \kore-exists \kore-inj \kore-sort-SortInt ( $.
$v z sg0 th2 th0 ph6 kore-sort-var-x0 th1 kore-element-var-Val ph8 ph3 ph1 th3 kore-sort-var-R ph0 ph2 xX x y ph7 ph4 ph5 $.
$d y z $.
$d kore-sort-var-R kore-element-var-Val $.
$d kore-sort-var-R kore-sort-var-x0 $.
$d z x $.
$d kore-element-var-Val kore-sort-var-x0 $.
$d z kore-sort-var-x0 $.
$d kore-element-var-Val x $.
$d z kore-element-var-Val $.
$d kore-sort-var-R x $.
$d y x $.
$d y kore-sort-var-x0 $.
$d y kore-element-var-Val $.
$d x kore-sort-var-x0 $.
$d kore-sort-var-R z $.
$d y kore-sort-var-R $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
ph4-is-pattern $f #Pattern ph4 $.
ph5-is-pattern $f #Pattern ph5 $.
ph6-is-pattern $f #Pattern ph6 $.
ph7-is-pattern $f #Pattern ph7 $.
ph8-is-pattern $f #Pattern ph8 $.
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
${ $d xX ph0 $.
   substitution-disjoint $a #Substitution ph0 ph0 ph1 xX $. $}
${ rule-weakening.0 $e |- ph1 $.
   rule-weakening $a |- ( \imp ph0 ph1 ) $. $}
kore-exists-is-pattern $a #Pattern ( \kore-exists ph0 ph1 x ph2 ) $.
kore-valid-is-pattern $a #Pattern ( \kore-valid ph0 ph1 ) $.
kore-equals-is-pattern $a #Pattern ( \kore-equals ph0 ph1 ph2 ph3 ) $.
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
${ $d xX y $.
   $d y ph6 $.
   substitution-kore-exists-alt.0 $e #Substitution ph0 ph3 ph6 xX $.
   substitution-kore-exists-alt.1 $e #Substitution ph1 ph4 ph6 xX $.
   substitution-kore-exists-alt.2 $e #Substitution ph2 ph5 ph6 xX $.
   substitution-kore-exists-alt $a #Substitution ( \kore-exists ph0 ph1 y ph2 ) ( \kore-exists ph3 ph4 y ph5 ) ph6 xX $. $}
${ substitution-kore-valid.0 $e #Substitution ph0 ph2 ph4 xX $.
   substitution-kore-valid.1 $e #Substitution ph1 ph3 ph4 xX $.
   substitution-kore-valid $a #Substitution ( \kore-valid ph0 ph1 ) ( \kore-valid ph2 ph3 ) ph4 xX $. $}
${ substitution-kore-equals.0 $e #Substitution ph0 ph4 ph8 xX $.
   substitution-kore-equals.1 $e #Substitution ph1 ph5 ph8 xX $.
   substitution-kore-equals.2 $e #Substitution ph2 ph6 ph8 xX $.
   substitution-kore-equals.3 $e #Substitution ph3 ph7 ph8 xX $.
   substitution-kore-equals $a #Substitution ( \kore-equals ph0 ph1 ph2 ph3 ) ( \kore-equals ph4 ph5 ph6 ph7 ) ph8 xX $. $}
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
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-sort-28-is-pattern $a #Pattern \kore-sort-SortKResult $.
kore-element-var-Val-elementvariable $f #ElementVariable kore-element-var-Val $.
kore-sort-var-x0-elementvariable $f #ElementVariable kore-sort-var-x0 $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-14 $a #Pattern kore-sort-var-x0 $.
typecode-cache-Pattern-22 $a #Pattern ( \eq x \unit-sort ) $.
sorting-cache-129 $a |- ( \imp \top ( \and ( \kore-is-sort \unit-sort ) \top ) ) $.
substitution-83 $a #Substitution ( \and ( \kore-is-sort \unit-sort ) \top ) ( \and ( \kore-is-sort kore-sort-var-R ) \top ) \unit-sort kore-sort-var-R $.
substitution-87 $a #Substitution ( \and ( \kore-is-sort kore-sort-var-x0 ) \top ) ( \and ( \kore-is-sort kore-sort-var-R ) \top ) kore-sort-var-x0 kore-sort-var-R $.
string-literal-20-is-pattern $a #Pattern "210" $.
typecode-cache-Pattern-31 $a #Pattern kore-element-var-Val $.
substitution-141 $a #Substitution kore-element-var-Val kore-element-var-Val \unit-sort kore-sort-var-R $.
substitution-145 $a #Substitution kore-element-var-Val kore-element-var-Val kore-sort-var-x0 kore-sort-var-R $.
substitution-945 $a #Substitution \kore-sort-SortKResult \kore-sort-SortKResult \unit-sort kore-sort-var-R $.
substitution-946 $a #Substitution \kore-sort-SortKResult \kore-sort-SortKResult kore-sort-var-x0 kore-sort-var-R $.
sorting-rearrange-1545 $a |- ( \imp ( \and \top ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortKResult kore-sort-var-R kore-element-var-Val ( \kore-equals \kore-sort-SortKResult kore-sort-var-R kore-element-var-Val ( \kore-inj \kore-sort-SortInt \kore-sort-SortKResult ( \kore-dv \kore-sort-SortInt "210" ) ) ) ) ) ) $.
${ sorting-rearrange-1546 $p |- ( \imp \top ( \kore-valid \unit-sort ( \kore-exists \kore-sort-SortKResult \unit-sort kore-element-var-Val ( \kore-equals \kore-sort-SortKResult \unit-sort kore-element-var-Val ( \kore-inj \kore-sort-SortInt \kore-sort-SortKResult ( \kore-dv \kore-sort-SortInt "210" ) ) ) ) ) ) $= ( IMP-sort-28-is-pattern kore-sort-var-R-elementvariable IMP-sort-23-is-pattern unit-sort-is-symbol symbol-is-pattern kore-sort-var-x0-elementvariable typecode-cache-Pattern-0 string-literal-20-is-pattern kore-dv-is-pattern kore-inj-is-pattern typecode-cache-Pattern-14 typecode-cache-Pattern-31 top-is-pattern kore-equals-is-pattern element-var-is-var kore-exists-is-pattern and-is-pattern kore-is-sort-is-pattern kore-valid-is-pattern substitution-var-same x-is-element-var rule-weakening substitution-945 substitution-disjoint substitution-kore-equals substitution-kore-exists-alt substitution-kore-valid substitution-imp substitution-946 top-intro sorting-cache-129 rule-and-intro-alt2-sugar typecode-cache-Pattern-22 exists-is-pattern unit-sort-is-functional sorting-rearrange-1545 substitution-83 substitution-141 substitution-87 substitution-145 functional-substitution-alt rule-imp-transitivity ) NNEFSNRREFBEFBEFAMDBDIJKOAQTNNEFSNRNNUKUCULUMEFCHBCHBCHAMDBDIJKOAQTEFBEFBEFAMDBDIJKOAQTGLBGLBGLAMDBDIJKOAQTNCHSNREFSNRGLSNRUBCGNUBUNUBUOUBUPUCCAUQEFEFSNREFBEFBEFAMDBDIJKOAQTCHSNRCHBCHBCHAMDBDIJKOAQTCPCUREFBEFBEFAMDBDIJKOAQCHBCHBCHAMDBDIJKOAQEFCPEFCPUABEFBEFAMDBDIJKOBCHBCHAMDBDIJKOEFACPCUDEFCPUABEFAMDBDIJKBCHAMDBDIJKEFCPCUDEFCPUACAUSDBDIJKEFCPUEUFUGUHUIGLGLSNRGLBGLBGLAMDBDIJKOAQTCHSNRCHBCHBCHAMDBDIJKOAQTCPCGUTGLBGLBGLAMDBDIJKOAQCHBCHBCHAMDBDIJKOAQGLCPGLCPUABGLBGLAMDBDIJKOBCHBCHAMDBDIJKOGLACPCGUJGLCPUABGLAMDBDIJKBCHAMDBDIJKGLCPCGUJGLCPUACAGVADBDIJKGLCPUEUFUGUHUIVBVC $. $}
