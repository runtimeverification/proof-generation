$c \exists #Substitution \top #Variable \imp \kore-dv \kore-is-sort |- \kore-sort-SortId \kore-valid ) \kore-equals \and #SetVariable #ElementVariable #Symbol \eq #Pattern \kore-exists \kore-sort-SortKItem \kore-inj "addressTo" \in-sort ( $.
$v ph5 z th2 th0 ph6 kore-element-var-x0 th1 kore-element-var-x1 kore-element-var-Val ph3 ph1 th3 kore-sort-var-R ph0 ph2 xX x y ph4 kore-element-var-From $.
$d y z $.
$d kore-element-var-x0 kore-element-var-Val $.
$d kore-element-var-x1 x $.
$d kore-sort-var-R kore-element-var-Val $.
$d kore-sort-var-R kore-element-var-From $.
$d kore-sort-var-R kore-element-var-x1 $.
$d y kore-element-var-x1 $.
$d z x $.
$d kore-element-var-x0 kore-element-var-From $.
$d kore-element-var-x0 kore-element-var-x1 $.
$d kore-element-var-From z $.
$d y kore-element-var-From $.
$d kore-element-var-Val x $.
$d kore-element-var-From x $.
$d z kore-element-var-Val $.
$d kore-sort-var-R x $.
$d kore-element-var-x1 kore-element-var-Val $.
$d y x $.
$d kore-element-var-From kore-element-var-Val $.
$d kore-element-var-x0 x $.
$d kore-element-var-x0 y $.
$d z kore-element-var-x1 $.
$d kore-element-var-From kore-element-var-x1 $.
$d kore-element-var-x0 kore-sort-var-R $.
$d y kore-element-var-Val $.
$d kore-element-var-x0 z $.
$d kore-sort-var-R z $.
$d y kore-sort-var-R $.
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
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
kore-element-var-Val-elementvariable $f #ElementVariable kore-element-var-Val $.
kore-element-var-From-elementvariable $f #ElementVariable kore-element-var-From $.
kore-element-var-x1-elementvariable $f #ElementVariable kore-element-var-x1 $.
kore-element-var-x0-elementvariable $f #ElementVariable kore-element-var-x0 $.
string-literal-18-is-pattern $a #Pattern "addressTo" $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-25 $a #Pattern kore-element-var-x0 $.
sorting-cache-133 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ) $.
typecode-cache-Pattern-31 $a #Pattern kore-element-var-Val $.
typecode-cache-Pattern-45 $a #Pattern kore-element-var-From $.
substitution-178 $a #Substitution kore-sort-var-R kore-sort-var-R kore-element-var-x0 kore-element-var-From $.
substitution-331 $a #Substitution ( \and ( \in-sort kore-element-var-x0 \kore-sort-SortId ) \top ) ( \and ( \in-sort kore-element-var-From \kore-sort-SortId ) \top ) kore-element-var-x0 kore-element-var-From $.
sorting-rearrange-317 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \exists kore-element-var-x1 ( \eq kore-element-var-x1 ( \kore-dv \kore-sort-SortId "addressTo" ) ) ) ) $.
typecode-cache-Pattern-197 $a #Pattern ( \kore-equals \kore-sort-SortKItem kore-sort-var-R kore-element-var-Val ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem kore-element-var-From ) ) $.
sorting-rearrange-318 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \in-sort kore-element-var-From \kore-sort-SortId ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortKItem kore-sort-var-R kore-element-var-Val ( \kore-equals \kore-sort-SortKItem kore-sort-var-R kore-element-var-Val ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem kore-element-var-From ) ) ) ) ) $.
typecode-cache-Pattern-198 $a #Pattern ( \kore-equals \kore-sort-SortKItem kore-sort-var-R kore-element-var-Val ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem kore-element-var-x0 ) ) $.
substitution-617 $a #Substitution kore-sort-var-R kore-sort-var-R ( \kore-dv \kore-sort-SortId "addressTo" ) kore-element-var-From $.
substitution-619 $a #Substitution ( \kore-equals \kore-sort-SortKItem kore-sort-var-R kore-element-var-Val ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ) ( \kore-equals \kore-sort-SortKItem kore-sort-var-R kore-element-var-Val ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem kore-element-var-From ) ) ( \kore-dv \kore-sort-SortId "addressTo" ) kore-element-var-From $.
substitution-622 $a #Substitution ( \kore-exists \kore-sort-SortKItem kore-sort-var-R kore-element-var-Val ( \kore-equals \kore-sort-SortKItem kore-sort-var-R kore-element-var-Val ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem kore-element-var-x0 ) ) ) ( \kore-exists \kore-sort-SortKItem kore-sort-var-R kore-element-var-Val ( \kore-equals \kore-sort-SortKItem kore-sort-var-R kore-element-var-Val ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem kore-element-var-From ) ) ) kore-element-var-x0 kore-element-var-From $.
sorting-cache-698 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \in-sort ( \kore-dv \kore-sort-SortId "addressTo" ) \kore-sort-SortId ) \top ) ) $.
${ sorting-rearrange-319 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortKItem kore-sort-var-R kore-element-var-Val ( \kore-equals \kore-sort-SortKItem kore-sort-var-R kore-element-var-Val ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ) ) ) ) $= ( IMP-sort-17-is-pattern typecode-cache-Pattern-0 kore-element-var-From-elementvariable BASIC-K-sort-1-is-pattern string-literal-18-is-pattern kore-dv-is-pattern top-is-pattern and-is-pattern kore-exists-is-pattern in-sort-is-pattern kore-element-var-x0-elementvariable element-var-is-var kore-valid-is-pattern typecode-cache-Pattern-197 kore-is-sort-is-pattern typecode-cache-Pattern-31 kore-inj-is-pattern kore-equals-is-pattern typecode-cache-Pattern-45 typecode-cache-Pattern-25 typecode-cache-Pattern-198 substitution-disjoint kore-element-var-x1-elementvariable substitution-617 substitution-kore-valid substitution-imp sorting-cache-133 sorting-cache-698 rule-and-intro-alt2-sugar sorting-rearrange-317 sorting-rearrange-318 substitution-var-same substitution-in-sort substitution-and substitution-619 substitution-kore-exists-alt substitution-331 substitution-178 substitution-622 functional-substitution-alt rule-imp-transitivity ) ADQIJADQIJCGHCLIJJADFADFADBRCFCGHSTBKOADQIJADQIJCGHCLIJAUIAUJUKCGHADFADABEPBKOADFADFADBRCFCGHSTBKOADFADABMUCBKOADQIJEUACLIJCGHCLIJMUBCLIJUEEMAUEULABEUMCGHCGHCLIJADFADFADBRCFCGHSTBKOEUACLIJADFADABEPBKOENCGHCGHCLIEUACLIENCGHCGHCEUACENCGHENUNCCGHENUDUOICGHENUDUPADFADFADBRCFCGHSTBKADFADABEPBKCGHENAEUFFADFADBRCFCGHSTFADABEPCGHBENFCGHENUDAEUFABEUQURUGUHMUBMUBCLIJADFADABMUCBKOEUACLIJADFADABEPBKOENEMUSADFADABMUCBKADFADABEPBKMUBENAEMUTABEMVAUGUHVBVC $. $}
