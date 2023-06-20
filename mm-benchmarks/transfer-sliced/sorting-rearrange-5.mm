$c \exists #Substitution \top \kore-sort-SortAExp #Variable \imp \kore-is-sort |- \kore-sort-SortId \kore-valid ) \kore-equals \and #SetVariable #ElementVariable #Symbol \eq #Pattern \kore-inj \in-sort ( $.
$v z th2 th0 kore-sort-var-x0 th1 ph3 ph1 th3 kore-sort-var-R ph0 ph2 kore-sort-var-S2 xX x y kore-element-var-T ph4 kore-sort-var-S3 $.
$d kore-sort-var-S3 z $.
$d y z $.
$d kore-sort-var-S2 x $.
$d kore-sort-var-R kore-sort-var-x0 $.
$d kore-sort-var-R kore-sort-var-S2 $.
$d y kore-sort-var-S2 $.
$d z x $.
$d kore-element-var-T kore-sort-var-x0 $.
$d kore-sort-var-R kore-sort-var-S3 $.
$d y kore-sort-var-S3 $.
$d kore-element-var-T x $.
$d z kore-sort-var-x0 $.
$d kore-sort-var-S2 kore-sort-var-x0 $.
$d kore-sort-var-R kore-element-var-T $.
$d z kore-sort-var-S2 $.
$d kore-sort-var-S2 kore-element-var-T $.
$d kore-sort-var-S3 kore-sort-var-S2 $.
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
imp-reflexivity $a |- ( \imp ph0 ph0 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
top-intro $a |- \top $.
and-elim-left-sugar $a |- ( \imp ( \and ph0 ph1 ) ph0 ) $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
${ rule-weakening.0 $e |- ph1 $.
   rule-weakening $a |- ( \imp ph0 ph1 ) $. $}
kore-valid-is-pattern $a #Pattern ( \kore-valid ph0 ph1 ) $.
kore-equals-is-pattern $a #Pattern ( \kore-equals ph0 ph1 ph2 ph3 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
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
IMP-sort-13-sort $a |- ( \kore-is-sort \kore-sort-SortAExp ) $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
kore-sort-var-x0-elementvariable $f #ElementVariable kore-sort-var-x0 $.
kore-sort-var-S3-elementvariable $f #ElementVariable kore-sort-var-S3 $.
kore-sort-var-S2-elementvariable $f #ElementVariable kore-sort-var-S2 $.
kore-element-var-T-elementvariable $f #ElementVariable kore-element-var-T $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-1 $a #Pattern kore-sort-var-S2 $.
typecode-cache-Pattern-2 $a #Pattern kore-sort-var-S3 $.
typecode-cache-Pattern-6 $a #Pattern kore-element-var-T $.
typecode-cache-Pattern-12 $a #Pattern ( \kore-inj \kore-sort-SortId kore-sort-var-S2 kore-element-var-T ) $.
typecode-cache-Pattern-13 $a #Pattern ( \kore-inj \kore-sort-SortId kore-sort-var-S3 kore-element-var-T ) $.
typecode-cache-Pattern-14 $a #Pattern kore-sort-var-x0 $.
typecode-cache-Pattern-19 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-S3 ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortId ) \top ) ) $.
sorting-rearrange-3 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \kore-is-sort kore-sort-var-S3 ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortId ) \top ) ) ) ( \exists x ( \eq x \kore-sort-SortAExp ) ) ) $.
sorting-rearrange-4 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \kore-is-sort kore-sort-var-S3 ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortId ) \top ) ) ) ( \and ( \kore-is-sort kore-sort-var-S2 ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-equals kore-sort-var-S3 kore-sort-var-R ( \kore-inj kore-sort-var-S2 kore-sort-var-S3 ( \kore-inj \kore-sort-SortId kore-sort-var-S2 kore-element-var-T ) ) ( \kore-inj \kore-sort-SortId kore-sort-var-S3 kore-element-var-T ) ) ) ) $.
typecode-cache-Pattern-20 $a #Pattern ( \kore-inj \kore-sort-SortId kore-sort-var-x0 kore-element-var-T ) $.
substitution-28 $a #Substitution ( \and ( \kore-is-sort \kore-sort-SortAExp ) \top ) ( \and ( \kore-is-sort kore-sort-var-S2 ) \top ) \kore-sort-SortAExp kore-sort-var-S2 $.
substitution-29 $a #Substitution kore-sort-var-R kore-sort-var-R \kore-sort-SortAExp kore-sort-var-S2 $.
substitution-34 $a #Substitution ( \kore-equals kore-sort-var-S3 kore-sort-var-R ( \kore-inj \kore-sort-SortAExp kore-sort-var-S3 ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp kore-element-var-T ) ) ( \kore-inj \kore-sort-SortId kore-sort-var-S3 kore-element-var-T ) ) ( \kore-equals kore-sort-var-S3 kore-sort-var-R ( \kore-inj kore-sort-var-S2 kore-sort-var-S3 ( \kore-inj \kore-sort-SortId kore-sort-var-S2 kore-element-var-T ) ) ( \kore-inj \kore-sort-SortId kore-sort-var-S3 kore-element-var-T ) ) \kore-sort-SortAExp kore-sort-var-S2 $.
substitution-37 $a #Substitution ( \and ( \kore-is-sort kore-sort-var-x0 ) \top ) ( \and ( \kore-is-sort kore-sort-var-S2 ) \top ) kore-sort-var-x0 kore-sort-var-S2 $.
substitution-38 $a #Substitution kore-sort-var-R kore-sort-var-R kore-sort-var-x0 kore-sort-var-S2 $.
substitution-44 $a #Substitution ( \kore-equals kore-sort-var-S3 kore-sort-var-R ( \kore-inj kore-sort-var-x0 kore-sort-var-S3 ( \kore-inj \kore-sort-SortId kore-sort-var-x0 kore-element-var-T ) ) ( \kore-inj \kore-sort-SortId kore-sort-var-S3 kore-element-var-T ) ) ( \kore-equals kore-sort-var-S3 kore-sort-var-R ( \kore-inj kore-sort-var-S2 kore-sort-var-S3 ( \kore-inj \kore-sort-SortId kore-sort-var-S2 kore-element-var-T ) ) ( \kore-inj \kore-sort-SortId kore-sort-var-S3 kore-element-var-T ) ) kore-sort-var-x0 kore-sort-var-S2 $.
sorting-cache-121 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \kore-is-sort kore-sort-var-S3 ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortId ) \top ) ) ) ( \and ( \kore-is-sort kore-sort-var-S3 ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortId ) \top ) ) ) $.
${ sorting-rearrange-5 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \kore-is-sort kore-sort-var-S3 ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortId ) \top ) ) ) ( \kore-valid kore-sort-var-R ( \kore-equals kore-sort-var-S3 kore-sort-var-R ( \kore-inj \kore-sort-SortAExp kore-sort-var-S3 ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp kore-element-var-T ) ) ( \kore-inj \kore-sort-SortId kore-sort-var-S3 kore-element-var-T ) ) ) ) $= ( typecode-cache-Pattern-0 kore-is-sort-is-pattern kore-sort-var-S2-elementvariable typecode-cache-Pattern-2 and-is-pattern IMP-sort-13-is-pattern kore-inj-is-pattern kore-sort-var-x0-elementvariable typecode-cache-Pattern-19 typecode-cache-Pattern-13 kore-equals-is-pattern top-is-pattern kore-valid-is-pattern typecode-cache-Pattern-1 typecode-cache-Pattern-14 typecode-cache-Pattern-12 IMP-sort-17-is-pattern typecode-cache-Pattern-6 element-var-is-var rule-and-intro-alt2-sugar typecode-cache-Pattern-20 rule-imp-transitivity x-is-element-var substitution-kore-valid substitution-imp and-elim-left-sugar imp-reflexivity sorting-cache-121 imp-is-pattern proof-rule-prop-1 IMP-sort-13-sort proof-rule-mp top-intro rule-weakening sorting-rearrange-3 sorting-rearrange-4 substitution-28 substitution-29 substitution-34 substitution-37 substitution-38 substitution-44 functional-substitution-alt ) ADEBCLHADEBCLHIEOHHADBGADIBGTICUAJJBCMNPADEBCLHADEBCLHIEOHADEBCLHADEBCLADEBCLHADEADEADEBCLUIADEUJUEABCUKUCADEBCLHIEOIEADEBCLHIEULIEADEBCLHUMUNUOADEBCLHOUPUQUCUCIADBGADFQBGFCSJBCMNPADBGADIBGTICUAJJBCMNPADBGADKRBGKCUDJBCMNPADEBCLHFQEOHIEOHKREOHUFFKUFABCURABFCUSIIEOHADBGADIBGTICUAJJBCMNPFQEOHADBGADFQBGFCSJBCMNPFUBFUTADBGADIBGTICUAJJBCMNADBGADFQBGFCSJBCMNIFUBAFVAABFCVBUGUHKRKREOHADBGADKRBGKCUDJBCMNPFQEOHADBGADFQBGFCSJBCMNPFUBKFVCADBGADKRBGKCUDJBCMNADBGADFQBGFCSJBCMNKRFUBAKFVDAKBFCVEUGUHVFUE $. $}
