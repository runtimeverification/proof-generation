$c \exists #Substitution \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' "12345" \top "amount" #Variable "10" "200" \imp \kore-dv \kore-is-sort |- \kore-sort-SortId \kore-valid ) \kore-equals \and #SetVariable #ElementVariable \kore-symbol-Lbl'Unds'Map'Unds' #Symbol \eq #Pattern \kore-sort-SortKItem \kore-inj \kore-sort-SortInt "addressTo" \in-sort \kore-sort-SortMap "balanceTo" ( $.
$v ph5 kore-element-var-V0 xX0 z th2 th0 ph6 kore-element-var-x0 th1 ptn3 ptn2 ph8 ph3 ptn0 ph1 th3 kore-sort-var-R ph0 ph2 xX x ptn4 ptn1 y ph7 ph4 kore-element-var-K1 kore-element-var-K2 $.
$d kore-element-var-V0 z $.
$d y z $.
$d kore-element-var-K1 kore-element-var-V0 $.
$d kore-element-var-V0 x $.
$d kore-element-var-K1 kore-element-var-K2 $.
$d kore-sort-var-R kore-element-var-V0 $.
$d z x $.
$d kore-element-var-x0 kore-element-var-V0 $.
$d kore-element-var-K1 x $.
$d z kore-element-var-K2 $.
$d kore-element-var-V0 kore-element-var-K2 $.
$d kore-sort-var-R kore-element-var-K2 $.
$d x kore-element-var-K2 $.
$d kore-sort-var-R kore-element-var-K1 $.
$d kore-element-var-x0 kore-element-var-K1 $.
$d kore-sort-var-R x $.
$d y x $.
$d kore-element-var-x0 x $.
$d kore-element-var-x0 y $.
$d kore-element-var-x0 kore-element-var-K2 $.
$d kore-element-var-x0 kore-sort-var-R $.
$d kore-element-var-x0 z $.
$d kore-element-var-K1 z $.
$d y kore-element-var-K1 $.
$d y kore-element-var-K2 $.
$d kore-sort-var-R z $.
$d y kore-sort-var-R $.
$d y kore-element-var-V0 $.
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
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
${ substitution-kore-valid.0 $e #Substitution ph0 ph2 ph4 xX $.
   substitution-kore-valid.1 $e #Substitution ph1 ph3 ph4 xX $.
   substitution-kore-valid $a #Substitution ( \kore-valid ph0 ph1 ) ( \kore-valid ph2 ph3 ) ph4 xX $. $}
${ substitution-kore-equals.0 $e #Substitution ph0 ph4 ph8 xX $.
   substitution-kore-equals.1 $e #Substitution ph1 ph5 ph8 xX $.
   substitution-kore-equals.2 $e #Substitution ph2 ph6 ph8 xX $.
   substitution-kore-equals.3 $e #Substitution ph3 ph7 ph8 xX $.
   substitution-kore-equals $a #Substitution ( \kore-equals ph0 ph1 ph2 ph3 ) ( \kore-equals ph4 ph5 ph6 ph7 ) ph8 xX $. $}
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
xX0-variable $f #Variable xX0 $.
ptn0-pattern $f #Pattern ptn0 $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
ptn1-pattern $f #Pattern ptn1 $.
ptn2-pattern $f #Pattern ptn2 $.
ptn3-pattern $f #Pattern ptn3 $.
ptn4-pattern $f #Pattern ptn4 $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
kore-element-var-V0-elementvariable $f #ElementVariable kore-element-var-V0 $.
IMP-sort-14-is-pattern $a #Pattern \kore-sort-SortMap $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-symbol-194-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds'Map'Unds' ptn0 ptn1 ) $.
${ IMP-symbol-194-substitution.0 $e #Substitution ptn1 ptn3 ptn0 xX0 $.
   IMP-symbol-194-substitution.1 $e #Substitution ptn2 ptn4 ptn0 xX0 $.
   IMP-symbol-194-substitution $a #Substitution ( \kore-symbol-Lbl'Unds'Map'Unds' ptn1 ptn2 ) ( \kore-symbol-Lbl'Unds'Map'Unds' ptn3 ptn4 ) ptn0 xX0 $. $}
IMP-symbol-218-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ptn0 ptn1 ) $.
kore-element-var-K1-elementvariable $f #ElementVariable kore-element-var-K1 $.
kore-element-var-K2-elementvariable $f #ElementVariable kore-element-var-K2 $.
kore-element-var-x0-elementvariable $f #ElementVariable kore-element-var-x0 $.
string-literal-12-is-pattern $a #Pattern "12345" $.
string-literal-13-is-pattern $a #Pattern "10" $.
string-literal-14-is-pattern $a #Pattern "amount" $.
string-literal-15-is-pattern $a #Pattern "200" $.
string-literal-17-is-pattern $a #Pattern "balanceTo" $.
string-literal-18-is-pattern $a #Pattern "addressTo" $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-25 $a #Pattern kore-element-var-x0 $.
typecode-cache-Pattern-49 $a #Pattern kore-element-var-K1 $.
typecode-cache-Pattern-120 $a #Pattern kore-element-var-K2 $.
typecode-cache-Pattern-191 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortMap ) \top ) ) $.
typecode-cache-Pattern-193 $a #Pattern ( \kore-symbol-Lbl'Unds'Map'Unds' kore-element-var-K1 kore-element-var-K2 ) $.
typecode-cache-Pattern-194 $a #Pattern ( \kore-symbol-Lbl'Unds'Map'Unds' kore-element-var-K2 kore-element-var-K1 ) $.
sorting-rearrange-313 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortMap ) \top ) ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortMap ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-equals \kore-sort-SortMap kore-sort-var-R ( \kore-symbol-Lbl'Unds'Map'Unds' kore-element-var-K1 kore-element-var-K2 ) ( \kore-symbol-Lbl'Unds'Map'Unds' kore-element-var-K2 kore-element-var-K1 ) ) ) ) $.
typecode-cache-Pattern-195 $a #Pattern ( \kore-symbol-Lbl'Unds'Map'Unds' kore-element-var-x0 kore-element-var-K2 ) $.
typecode-cache-Pattern-196 $a #Pattern ( \kore-symbol-Lbl'Unds'Map'Unds' kore-element-var-K2 kore-element-var-x0 ) $.
substitution-607 $a #Substitution ( \imp ( \and ( \in-sort kore-element-var-x0 \kore-sort-SortMap ) \top ) ( \kore-valid kore-sort-var-R ( \kore-equals \kore-sort-SortMap kore-sort-var-R ( \kore-symbol-Lbl'Unds'Map'Unds' kore-element-var-x0 kore-element-var-K2 ) ( \kore-symbol-Lbl'Unds'Map'Unds' kore-element-var-K2 kore-element-var-x0 ) ) ) ) ( \imp ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortMap ) \top ) ( \kore-valid kore-sort-var-R ( \kore-equals \kore-sort-SortMap kore-sort-var-R ( \kore-symbol-Lbl'Unds'Map'Unds' kore-element-var-K1 kore-element-var-K2 ) ( \kore-symbol-Lbl'Unds'Map'Unds' kore-element-var-K2 kore-element-var-K1 ) ) ) ) kore-element-var-x0 kore-element-var-K1 $.
sorting-cache-692 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortMap ) \top ) ) ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortMap ) \top ) ) ) $.
sorting-rearrange-812 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortMap ) \top ) ) ( \exists kore-element-var-V0 ( \eq kore-element-var-V0 ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "12345" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "200" ) ) ) ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "10" ) ) ) ) ) ) ) ) $.
sorting-cache-1238 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortMap ) \top ) ) ( \and ( \in-sort ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "12345" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "200" ) ) ) ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "10" ) ) ) ) ) \kore-sort-SortMap ) \top ) ) $.
${ sorting-rearrange-813 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortMap ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-equals \kore-sort-SortMap kore-sort-var-R ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "12345" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "200" ) ) ) ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "10" ) ) ) ) ) kore-element-var-K2 ) ( \kore-symbol-Lbl'Unds'Map'Unds' kore-element-var-K2 ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "12345" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "200" ) ) ) ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "10" ) ) ) ) ) ) ) ) ) $= ( IMP-sort-17-is-pattern BASIC-K-sort-1-is-pattern kore-dv-is-pattern kore-inj-is-pattern IMP-sort-23-is-pattern IMP-symbol-218-is-pattern IMP-symbol-194-is-pattern string-literal-18-is-pattern string-literal-12-is-pattern string-literal-17-is-pattern string-literal-15-is-pattern string-literal-14-is-pattern string-literal-13-is-pattern kore-element-var-K1-elementvariable IMP-sort-14-is-pattern typecode-cache-Pattern-0 element-var-is-var typecode-cache-Pattern-120 top-is-pattern in-sort-is-pattern and-is-pattern kore-equals-is-pattern substitution-disjoint kore-valid-is-pattern typecode-cache-Pattern-49 typecode-cache-Pattern-191 kore-element-var-x0-elementvariable typecode-cache-Pattern-193 typecode-cache-Pattern-194 substitution-var-same kore-element-var-V0-elementvariable IMP-symbol-194-substitution sorting-cache-692 sorting-cache-1238 rule-and-intro-alt2-sugar typecode-cache-Pattern-195 typecode-cache-Pattern-196 typecode-cache-Pattern-25 sorting-rearrange-812 sorting-rearrange-313 substitution-in-sort substitution-and substitution-kore-equals substitution-kore-valid substitution-imp substitution-607 functional-substitution-alt rule-imp-transitivity ) ABUHABUHCDCJEFGDGKEFHCDCLEFGDGMEFHCDCNEFGDGOEFHIIQUBUAUCUCARQARCDCJEFGDGKEFHCDCLEFGDGMEFHCDCNEFGDGOEFHIIBTIBTCDCJEFGDGKEFHCDCLEFGDGMEFHCDCNEFGDGOEFHIIIUDUFABUHABUHCDCJEFGDGKEFHCDCLEFGDGMEFHCDCNEFGDGOEFHIIQUBUAUCABUOABUPUQCDCJEFGDGKEFHCDCLEFGDGMEFHCDCNEFGDGOEFHIIARQARPBUJPBUKUDUFARQARCDCJEFGDGKEFHCDCLEFGDGMEFHCDCNEFGDGOEFHIIBTIBTCDCJEFGDGKEFHCDCLEFGDGMEFHCDCNEFGDGOEFHIIIUDUFARQARBUIURBUIUSUDUFABUHPUGQUBUAUCCDCJEFGDGKEFHCDCLEFGDGMEFHCDCNEFGDGOEFHIIQUBUAUCUIUTQUBUAUCUMPUIAUMBVAAPBVBCDCJEFGDGKEFHCDCLEFGDGMEFHCDCNEFGDGOEFHIICDCJEFGDGKEFHCDCLEFGDGMEFHCDCNEFGDGOEFHIIQUBUAUCARQARCDCJEFGDGKEFHCDCLEFGDGMEFHCDCNEFGDGOEFHIIBTIBTCDCJEFGDGKEFHCDCLEFGDGMEFHCDCNEFGDGOEFHIIIUDUFPUGQUBUAUCARQARPBUJPBUKUDUFPSCDCJEFGDGKEFHCDCLEFGDGMEFHCDCNEFGDGOEFHIICDCJEFGDGKEFHCDCLEFGDGMEFHCDCNEFGDGOEFHIIQUBUAPUGQUBUAPSCDCJEFGDGKEFHCDCLEFGDGMEFHCDCNEFGDGOEFHIICDCJEFGDGKEFHCDCLEFGDGMEFHCDCNEFGDGOEFHIIQPUGQPSCDCJEFGDGKEFHCDCLEFGDGMEFHCDCNEFGDGOEFHIIPSULQCDCJEFGDGKEFHCDCLEFGDGMEFHCDCNEFGDGOEFHIIPSUEVCUACDCJEFGDGKEFHCDCLEFGDGMEFHCDCNEFGDGOEFHIIPSUEVDARQARCDCJEFGDGKEFHCDCLEFGDGMEFHCDCNEFGDGOEFHIIBTIBTCDCJEFGDGKEFHCDCLEFGDGMEFHCDCNEFGDGOEFHIIIUDARQARPBUJPBUKUDCDCJEFGDGKEFHCDCLEFGDGMEFHCDCNEFGDGOEFHIIPSARCDCJEFGDGKEFHCDCLEFGDGMEFHCDCNEFGDGOEFHIIPSUEQARCDCJEFGDGKEFHCDCLEFGDGMEFHCDCNEFGDGOEFHIIBTIBTCDCJEFGDGKEFHCDCLEFGDGMEFHCDCNEFGDGOEFHIIIQARPBUJPBUKCDCJEFGDGKEFHCDCLEFGDGMEFHCDCNEFGDGOEFHIIPSQCDCJEFGDGKEFHCDCLEFGDGMEFHCDCNEFGDGOEFHIIPSUEARCDCJEFGDGKEFHCDCLEFGDGMEFHCDCNEFGDGOEFHIIPSUEPSCDCJEFGDGKEFHCDCLEFGDGMEFHCDCNEFGDGOEFHIICDCJEFGDGKEFHCDCLEFGDGMEFHCDCNEFGDGOEFHIIBTPUGBTCDCJEFGDGKEFHCDCLEFGDGMEFHCDCNEFGDGOEFHIIPSULBTCDCJEFGDGKEFHCDCLEFGDGMEFHCDCNEFGDGOEFHIIPSUEUNPSCDCJEFGDGKEFHCDCLEFGDGMEFHCDCNEFGDGOEFHIIBTCDCJEFGDGKEFHCDCLEFGDGMEFHCDCNEFGDGOEFHIIBTPUGBTCDCJEFGDGKEFHCDCLEFGDGMEFHCDCNEFGDGOEFHIIPSUECDCJEFGDGKEFHCDCLEFGDGMEFHCDCNEFGDGOEFHIIPSULUNVEVFVGAPBUIVHVIVJ $. $}
