$c \exists #Substitution \top \kore-sort-SortAExp #Variable \imp \kore-is-sort |- \kore-valid ) \kore-equals \and #SetVariable #ElementVariable #Symbol \eq #Pattern \kore-sort-SortKItem \kore-inj \kore-sort-SortInt \in-sort ( $.
$v z th2 th0 ph6 kore-sort-var-x0 th1 ph8 ph3 ph1 th3 kore-sort-var-R ph0 ph2 xX x y ph7 kore-element-var-T ph4 ph5 kore-sort-var-S3 $.
$d kore-sort-var-S3 z $.
$d y z $.
$d kore-sort-var-R kore-sort-var-x0 $.
$d z x $.
$d kore-element-var-T kore-sort-var-x0 $.
$d kore-sort-var-R kore-sort-var-S3 $.
$d y kore-sort-var-S3 $.
$d kore-element-var-T x $.
$d z kore-sort-var-x0 $.
$d kore-sort-var-R kore-element-var-T $.
$d kore-sort-var-R x $.
$d y x $.
$d kore-sort-var-S3 x $.
$d kore-sort-var-S3 kore-sort-var-x0 $.
$d y kore-sort-var-x0 $.
$d kore-sort-var-S3 kore-element-var-T $.
$d x kore-sort-var-x0 $.
$d kore-sort-var-R z $.
$d y kore-element-var-T $.
$d z kore-element-var-T $.
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
element-var-is-var $a #Variable x $.
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
exists-is-pattern $a #Pattern ( \exists x ph0 ) $.
substitution-var-same $a #Substitution ph0 xX ph0 xX $.
${ substitution-imp.0 $e #Substitution ph1 ph3 ph0 xX $.
   substitution-imp.1 $e #Substitution ph2 ph4 ph0 xX $.
   substitution-imp $a #Substitution ( \imp ph1 ph2 ) ( \imp ph3 ph4 ) ph0 xX $. $}
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
proof-rule-prop-1 $a |- ( \imp ph0 ( \imp ph1 ph0 ) ) $.
${ proof-rule-mp.0 $e |- ( \imp ph0 ph1 ) $.
   proof-rule-mp.1 $e |- ph0 $.
   proof-rule-mp $a |- ph1 $. $}
top-is-pattern $a #Pattern \top $.
eq-is-pattern $a #Pattern ( \eq ph0 ph1 ) $.
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
kore-valid-is-pattern $a #Pattern ( \kore-valid ph0 ph1 ) $.
kore-equals-is-pattern $a #Pattern ( \kore-equals ph0 ph1 ph2 ph3 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
${ substitution-kore-valid.0 $e #Substitution ph0 ph2 ph4 xX $.
   substitution-kore-valid.1 $e #Substitution ph1 ph3 ph4 xX $.
   substitution-kore-valid $a #Substitution ( \kore-valid ph0 ph1 ) ( \kore-valid ph2 ph3 ) ph4 xX $. $}
${ substitution-kore-equals.0 $e #Substitution ph0 ph4 ph8 xX $.
   substitution-kore-equals.1 $e #Substitution ph1 ph5 ph8 xX $.
   substitution-kore-equals.2 $e #Substitution ph2 ph6 ph8 xX $.
   substitution-kore-equals.3 $e #Substitution ph3 ph7 ph8 xX $.
   substitution-kore-equals $a #Substitution ( \kore-equals ph0 ph1 ph2 ph3 ) ( \kore-equals ph4 ph5 ph6 ph7 ) ph8 xX $. $}
${ substitution-kore-inj.0 $e #Substitution ph0 ph3 ph6 xX $.
   substitution-kore-inj.1 $e #Substitution ph1 ph4 ph6 xX $.
   substitution-kore-inj.2 $e #Substitution ph2 ph5 ph6 xX $.
   substitution-kore-inj $a #Substitution ( \kore-inj ph0 ph1 ph2 ) ( \kore-inj ph3 ph4 ph5 ) ph6 xX $. $}
${ $d x ph0 $.
   kore-sort-functional.0 $e |- ( \imp th0 ( \kore-is-sort ph0 ) ) $.
   kore-sort-functional $a |- ( \imp th0 ( \exists x ( \eq x ph0 ) ) ) $. $}
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
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
BASIC-K-sort-1-sort $a |- ( \kore-is-sort \kore-sort-SortKItem ) $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
kore-sort-var-x0-elementvariable $f #ElementVariable kore-sort-var-x0 $.
kore-sort-var-S3-elementvariable $f #ElementVariable kore-sort-var-S3 $.
kore-element-var-T-elementvariable $f #ElementVariable kore-element-var-T $.
sorting-cache-2 $a |- ( \imp \top ( \kore-is-sort \kore-sort-SortKItem ) ) $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-2 $a #Pattern kore-sort-var-S3 $.
typecode-cache-Pattern-4 $a #Pattern x $.
typecode-cache-Pattern-6 $a #Pattern kore-element-var-T $.
typecode-cache-Pattern-14 $a #Pattern kore-sort-var-x0 $.
substitution-45 $a #Substitution ( \and ( \kore-is-sort \kore-sort-SortKItem ) \top ) ( \and ( \kore-is-sort kore-sort-var-S3 ) \top ) \kore-sort-SortKItem kore-sort-var-S3 $.
substitution-46 $a #Substitution kore-sort-var-R kore-sort-var-R \kore-sort-SortKItem kore-sort-var-S3 $.
substitution-51 $a #Substitution ( \and ( \kore-is-sort kore-sort-var-x0 ) \top ) ( \and ( \kore-is-sort kore-sort-var-S3 ) \top ) kore-sort-var-x0 kore-sort-var-S3 $.
substitution-52 $a #Substitution kore-sort-var-R kore-sort-var-R kore-sort-var-x0 kore-sort-var-S3 $.
typecode-cache-Pattern-27 $a #Pattern ( \kore-inj \kore-sort-SortInt kore-sort-var-S3 kore-element-var-T ) $.
typecode-cache-Pattern-29 $a #Pattern ( \kore-inj \kore-sort-SortInt kore-sort-var-x0 kore-element-var-T ) $.
typecode-cache-Pattern-30 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortInt ) \top ) ) $.
sorting-rearrange-23 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortInt ) \top ) ) ( \and ( \kore-is-sort kore-sort-var-S3 ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-equals kore-sort-var-S3 kore-sort-var-R ( \kore-inj \kore-sort-SortAExp kore-sort-var-S3 ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp kore-element-var-T ) ) ( \kore-inj \kore-sort-SortInt kore-sort-var-S3 kore-element-var-T ) ) ) ) $.
substitution-112 $a #Substitution ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem kore-element-var-T ) ( \kore-inj \kore-sort-SortInt kore-sort-var-S3 kore-element-var-T ) \kore-sort-SortKItem kore-sort-var-S3 $.
substitution-115 $a #Substitution ( \kore-equals kore-sort-var-x0 kore-sort-var-R ( \kore-inj \kore-sort-SortAExp kore-sort-var-x0 ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp kore-element-var-T ) ) ( \kore-inj \kore-sort-SortInt kore-sort-var-x0 kore-element-var-T ) ) ( \kore-equals kore-sort-var-S3 kore-sort-var-R ( \kore-inj \kore-sort-SortAExp kore-sort-var-S3 ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp kore-element-var-T ) ) ( \kore-inj \kore-sort-SortInt kore-sort-var-S3 kore-element-var-T ) ) kore-sort-var-x0 kore-sort-var-S3 $.
sorting-cache-165 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortInt ) \top ) ) ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortInt ) \top ) ) ) $.
${ sorting-rearrange-24 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortInt ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-equals \kore-sort-SortKItem kore-sort-var-R ( \kore-inj \kore-sort-SortAExp \kore-sort-SortKItem ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp kore-element-var-T ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem kore-element-var-T ) ) ) ) $= ( kore-sort-var-S3-elementvariable kore-inj-is-pattern BASIC-K-sort-1-is-pattern IMP-sort-13-is-pattern typecode-cache-Pattern-0 IMP-sort-23-is-pattern typecode-cache-Pattern-6 kore-sort-var-x0-elementvariable typecode-cache-Pattern-2 top-is-pattern kore-is-sort-is-pattern kore-equals-is-pattern typecode-cache-Pattern-30 and-is-pattern typecode-cache-Pattern-14 element-var-is-var kore-valid-is-pattern typecode-cache-Pattern-27 x-is-element-var typecode-cache-Pattern-29 top-intro rule-weakening rule-and-intro-alt2-sugar rule-imp-transitivity substitution-46 substitution-var-same substitution-disjoint substitution-kore-valid substitution-imp sorting-cache-165 imp-is-pattern proof-rule-prop-1 BASIC-K-sort-1-sort proof-rule-mp typecode-cache-Pattern-4 eq-is-pattern exists-is-pattern sorting-cache-2 kore-sort-functional sorting-rearrange-23 substitution-45 substitution-kore-inj substitution-112 substitution-kore-equals substitution-51 substitution-52 substitution-115 functional-substitution-alt ) ABOABOEMLPPAGEAGFEHFBIDDHEBIDNSABOABOEMLPABULABOEMLEMABOEMUMEMABOUNUOUPABOLUCUDUEUEEAGCKAGFCKHFBIDDCBTNSAGEAGFEHFBIDDHEBIDNSAGJQAGFJQHFBIDDJBUBNSABOCKMLPEMLPJQMLPUACJABOLUAUQEURUAUSABOLUCUDELUAUTVAUFACBVBEEMLPAGEAGFEHFBIDDHEBIDNSCKMLPAGCKAGFCKHFBIDDCBTNSCRCVCAGEAGFEHFBIDDHEBIDNAGCKAGFCKHFBIDDCBTNECRACUGEAGFEHFBIDDHEBIDCKAGFCKHFBIDDCBTECRECRUHACUGFEHFBIDFCKHFBIDECRFECRUIECRUHHFBIDECRUIVDCBVEVFUJUKJQJQMLPAGJQAGFJQHFBIDDJBUBNSCKMLPAGCKAGFCKHFBIDDCBTNSCRJCVGAGJQAGFJQHFBIDDJBUBNAGCKAGFCKHFBIDDCBTNJQCRAJCVHAJCBVIUJUKVJUF $. $}
