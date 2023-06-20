$c \exists #Substitution \top \kore-sort-SortAExp "210" #Variable \imp \kore-dv \kore-is-sort |- \kore-valid ) \kore-equals \and #SetVariable #ElementVariable #Symbol \eq #Pattern \kore-sort-SortKItem \kore-inj \kore-sort-SortInt \in-sort ( $.
$v z th2 th0 ph6 kore-element-var-x0 th1 kore-element-var-x1 ph8 ph3 ph1 th3 kore-sort-var-R ph0 ph2 xX x y ph7 kore-element-var-T ph4 ph5 $.
$d y z $.
$d kore-element-var-x1 x $.
$d kore-sort-var-R kore-element-var-x1 $.
$d y kore-element-var-x1 $.
$d z x $.
$d kore-element-var-x0 kore-element-var-x1 $.
$d kore-element-var-T x $.
$d kore-sort-var-R kore-element-var-T $.
$d kore-element-var-x1 kore-element-var-T $.
$d kore-sort-var-R x $.
$d y x $.
$d kore-element-var-x0 x $.
$d kore-element-var-x0 y $.
$d z kore-element-var-x1 $.
$d kore-element-var-x0 kore-sort-var-R $.
$d kore-element-var-x0 z $.
$d kore-element-var-x0 kore-element-var-T $.
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
kore-valid-is-pattern $a #Pattern ( \kore-valid ph0 ph1 ) $.
kore-equals-is-pattern $a #Pattern ( \kore-equals ph0 ph1 ph2 ph3 ) $.
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
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
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
kore-element-var-x1-elementvariable $f #ElementVariable kore-element-var-x1 $.
kore-element-var-T-elementvariable $f #ElementVariable kore-element-var-T $.
kore-element-var-x0-elementvariable $f #ElementVariable kore-element-var-x0 $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-6 $a #Pattern kore-element-var-T $.
typecode-cache-Pattern-25 $a #Pattern kore-element-var-x0 $.
substitution-75 $a #Substitution kore-sort-var-R kore-sort-var-R kore-element-var-x0 kore-element-var-T $.
substitution-76 $a #Substitution \kore-sort-SortKItem \kore-sort-SortKItem kore-element-var-x0 kore-element-var-T $.
sorting-cache-133 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ) $.
typecode-cache-Pattern-30 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortInt ) \top ) ) $.
sorting-rearrange-24 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortInt ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-equals \kore-sort-SortKItem kore-sort-var-R ( \kore-inj \kore-sort-SortAExp \kore-sort-SortKItem ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp kore-element-var-T ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem kore-element-var-T ) ) ) ) $.
sorting-cache-168 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortInt ) \top ) ) ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortInt ) \top ) ) ) $.
substitution-123 $a #Substitution ( \and ( \in-sort kore-element-var-x0 \kore-sort-SortInt ) \top ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortInt ) \top ) kore-element-var-x0 kore-element-var-T $.
substitution-125 $a #Substitution ( \kore-inj \kore-sort-SortAExp \kore-sort-SortKItem ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp kore-element-var-x0 ) ) ( \kore-inj \kore-sort-SortAExp \kore-sort-SortKItem ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp kore-element-var-T ) ) kore-element-var-x0 kore-element-var-T $.
substitution-126 $a #Substitution ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem kore-element-var-x0 ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem kore-element-var-T ) kore-element-var-x0 kore-element-var-T $.
string-literal-20-is-pattern $a #Pattern "210" $.
sorting-rearrange-1528 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \exists kore-element-var-x1 ( \eq kore-element-var-x1 ( \kore-dv \kore-sort-SortInt "210" ) ) ) ) $.
sorting-cache-2244 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \in-sort ( \kore-dv \kore-sort-SortInt "210" ) \kore-sort-SortInt ) \top ) ) $.
substitution-1278 $a #Substitution kore-sort-var-R kore-sort-var-R ( \kore-dv \kore-sort-SortInt "210" ) kore-element-var-T $.
${ sorting-rearrange-1561 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-valid kore-sort-var-R ( \kore-equals \kore-sort-SortKItem kore-sort-var-R ( \kore-inj \kore-sort-SortAExp \kore-sort-SortKItem ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "210" ) ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "210" ) ) ) ) ) $= ( IMP-sort-23-is-pattern kore-element-var-T-elementvariable BASIC-K-sort-1-is-pattern kore-inj-is-pattern IMP-sort-13-is-pattern string-literal-20-is-pattern kore-dv-is-pattern typecode-cache-Pattern-0 typecode-cache-Pattern-6 element-var-is-var kore-element-var-x0-elementvariable top-is-pattern and-is-pattern kore-equals-is-pattern typecode-cache-Pattern-25 in-sort-is-pattern kore-valid-is-pattern substitution-disjoint kore-is-sort-is-pattern substitution-var-same substitution-kore-inj kore-element-var-x1-elementvariable rule-imp-transitivity substitution-1278 substitution-kore-equals substitution-kore-valid substitution-imp substitution-75 sorting-cache-133 sorting-cache-2244 rule-and-intro-alt2-sugar sorting-rearrange-1528 typecode-cache-Pattern-30 sorting-cache-168 sorting-rearrange-24 substitution-in-sort substitution-and substitution-123 substitution-76 substitution-125 substitution-126 functional-substitution-alt ) AITMNAITMNBGHBQMNNAIDAIFDBFBGHEEBDBGHEORAITMNAITMNBGHBQMNAUJAUKULBGHAIDAIFDBFCJEEBDCJEORAIDAIFDBFBGHEEBDBGHEORAIDAIFDBFLPEEBDLPEORAITMNCJBQMNBGHBQMNLPBQMNUCCLAUCUMAITMNCJBQMNNACUNAIDAIFDBFCJEEBDCJEORACUOACUPUDBGHBGHBQMNAIDAIFDBFBGHEEBDBGHEORCJBQMNAIDAIFDBFCJEEBDCJEORCKBGHBGHBQMCJBQMCKBGHBGHBCJBCKBGHCKUABBGHCKSUQMBGHCKSURAIDAIFDBFBGHEEBDBGHEOAIDAIFDBFCJEEBDCJEOBGHCKACUEDAIFDBFBGHEEBDBGHEDAIFDBFCJEEBDCJEBGHCKDBGHCKSACUEFDBFBGHEFDBFCJEBGHCKFBGHCKSDBGHCKSBFBGHBFCJBGHCKBBGHCKSFBGHCKSBGHCKUAUBUBBDBGHBDCJBGHCKBBGHCKSDBGHCKSBGHCKUAUBUFUGUHLPLPBQMNAIDAIFDBFLPEEBDLPEORCJBQMNAIDAIFDBFCJEEBDCJEORCKCLUSAIDAIFDBFLPEEBDLPEOAIDAIFDBFCJEEBDCJEOLPCKACLUIDAIFDBFLPEEBDLPEDAIFDBFCJEEBDCJELPCKCLUTACLUICLVACLVBUFUGUHVCUD $. $}
