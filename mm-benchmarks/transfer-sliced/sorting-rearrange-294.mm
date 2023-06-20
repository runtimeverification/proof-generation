$c \exists #Substitution \top #Variable \imp \kore-dv "0" \kore-is-sort |- \kore-valid ) \kore-equals \and #SetVariable #ElementVariable #Symbol \eq #Pattern \kore-exists \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' \kore-sort-SortGeneratedCounterCell \kore-sort-SortInt \in-sort ( $.
$v z th2 th0 ph6 kore-element-var-x0 th1 kore-element-var-x1 kore-element-var-Val ph3 ph1 th3 kore-sort-var-R ph0 ph2 xX x kore-element-var-K0 y ph4 ph5 $.
$d y z $.
$d kore-element-var-x0 kore-element-var-Val $.
$d kore-element-var-x1 x $.
$d kore-sort-var-R kore-element-var-Val $.
$d kore-sort-var-R kore-element-var-x1 $.
$d y kore-element-var-x1 $.
$d kore-element-var-x0 kore-element-var-K0 $.
$d z x $.
$d kore-element-var-x0 kore-element-var-x1 $.
$d kore-element-var-K0 x $.
$d kore-sort-var-R kore-element-var-K0 $.
$d kore-element-var-Val x $.
$d z kore-element-var-Val $.
$d kore-sort-var-R x $.
$d kore-element-var-x1 kore-element-var-Val $.
$d y x $.
$d kore-element-var-x0 x $.
$d kore-element-var-x0 y $.
$d y kore-element-var-K0 $.
$d z kore-element-var-x1 $.
$d kore-element-var-x0 kore-sort-var-R $.
$d y kore-element-var-Val $.
$d kore-element-var-x1 kore-element-var-K0 $.
$d kore-element-var-x0 z $.
$d kore-element-var-Val kore-element-var-K0 $.
$d kore-sort-var-R z $.
$d z kore-element-var-K0 $.
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
IMP-sort-10-is-pattern $a #Pattern \kore-sort-SortGeneratedCounterCell $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
kore-element-var-Val-elementvariable $f #ElementVariable kore-element-var-Val $.
kore-element-var-K0-elementvariable $f #ElementVariable kore-element-var-K0 $.
kore-element-var-x1-elementvariable $f #ElementVariable kore-element-var-x1 $.
string-literal-1-is-pattern $a #Pattern "0" $.
kore-element-var-x0-elementvariable $f #ElementVariable kore-element-var-x0 $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-25 $a #Pattern kore-element-var-x0 $.
sorting-cache-133 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ) $.
typecode-cache-Pattern-51 $a #Pattern kore-element-var-K0 $.
sorting-rearrange-189 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \exists kore-element-var-x1 ( \eq kore-element-var-x1 ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) $.
sorting-cache-370 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \in-sort ( \kore-dv \kore-sort-SortInt "0" ) \kore-sort-SortInt ) \top ) ) $.
typecode-cache-Pattern-172 $a #Pattern ( \kore-equals \kore-sort-SortGeneratedCounterCell kore-sort-var-R kore-element-var-Val ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' kore-element-var-K0 ) ) $.
sorting-rearrange-293 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \in-sort kore-element-var-K0 \kore-sort-SortInt ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortGeneratedCounterCell kore-sort-var-R kore-element-var-Val ( \kore-equals \kore-sort-SortGeneratedCounterCell kore-sort-var-R kore-element-var-Val ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' kore-element-var-K0 ) ) ) ) ) $.
typecode-cache-Pattern-173 $a #Pattern ( \kore-equals \kore-sort-SortGeneratedCounterCell kore-sort-var-R kore-element-var-Val ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) $.
typecode-cache-Pattern-174 $a #Pattern ( \kore-equals \kore-sort-SortGeneratedCounterCell kore-sort-var-R kore-element-var-Val ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' kore-element-var-x0 ) ) $.
substitution-517 $a #Substitution kore-sort-var-R kore-sort-var-R ( \kore-dv \kore-sort-SortInt "0" ) kore-element-var-K0 $.
substitution-519 $a #Substitution ( \kore-equals \kore-sort-SortGeneratedCounterCell kore-sort-var-R kore-element-var-Val ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ( \kore-equals \kore-sort-SortGeneratedCounterCell kore-sort-var-R kore-element-var-Val ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' kore-element-var-K0 ) ) ( \kore-dv \kore-sort-SortInt "0" ) kore-element-var-K0 $.
substitution-522 $a #Substitution ( \and ( \in-sort kore-element-var-x0 \kore-sort-SortInt ) \top ) ( \and ( \in-sort kore-element-var-K0 \kore-sort-SortInt ) \top ) kore-element-var-x0 kore-element-var-K0 $.
substitution-527 $a #Substitution ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortGeneratedCounterCell kore-sort-var-R kore-element-var-Val ( \kore-equals \kore-sort-SortGeneratedCounterCell kore-sort-var-R kore-element-var-Val ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' kore-element-var-x0 ) ) ) ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortGeneratedCounterCell kore-sort-var-R kore-element-var-Val ( \kore-equals \kore-sort-SortGeneratedCounterCell kore-sort-var-R kore-element-var-Val ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' kore-element-var-K0 ) ) ) ) kore-element-var-x0 kore-element-var-K0 $.
${ sorting-rearrange-294 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortGeneratedCounterCell kore-sort-var-R kore-element-var-Val ( \kore-equals \kore-sort-SortGeneratedCounterCell kore-sort-var-R kore-element-var-Val ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) ) $= ( IMP-sort-23-is-pattern typecode-cache-Pattern-0 kore-element-var-K0-elementvariable top-is-pattern string-literal-1-is-pattern kore-dv-is-pattern and-is-pattern IMP-sort-10-is-pattern in-sort-is-pattern kore-exists-is-pattern element-var-is-var kore-valid-is-pattern kore-element-var-x0-elementvariable kore-is-sort-is-pattern typecode-cache-Pattern-173 typecode-cache-Pattern-172 typecode-cache-Pattern-51 typecode-cache-Pattern-25 substitution-disjoint typecode-cache-Pattern-174 kore-element-var-x1-elementvariable substitution-517 substitution-imp sorting-cache-133 sorting-cache-370 rule-and-intro-alt2-sugar sorting-rearrange-189 sorting-rearrange-293 substitution-var-same substitution-in-sort substitution-and substitution-519 substitution-kore-exists-alt substitution-kore-valid substitution-522 substitution-527 functional-substitution-alt rule-imp-transitivity ) ADPFIADPFICGHCKFIIADJADABQBLNADPFIADPFICGHCKFIAUFAUGUHCGHADJADABERBLNADJADABQBLNADJADABOUBBLNADPFIESCKFICGHCKFIOTCKFIUCEOAUCUIABEUJCGHCGHCKFIADJADABQBLNESCKFIADJADABERBLNEMCGHCGHCKFESCKFEMCGHCGHCESCEMCGHEMUKCCGHEMUAULFCGHEMUAUMADJADABQBLADJADABERBLCGHEMAEUDJADABQJADABERCGHBEMJCGHEMUAAEUDABEUNUOUPUEOTOTCKFIADJADABOUBBLNESCKFIADJADABERBLNEMEOUQABEOURUEUSUT $. $}
