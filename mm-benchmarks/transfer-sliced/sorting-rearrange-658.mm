$c \exists #Substitution \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' "amount" \top "12345" #Variable "10" \imp \kore-dv "0" \kore-is-sort |- \kore-sort-SortId \kore-valid ) \kore-equals \and \unit-sort #SetVariable #ElementVariable \kore-symbol-Lbl'Unds'Map'Unds' #Symbol \eq #Pattern \kore-sort-SortKItem \kore-inj \kore-sort-SortInt "addressTo" \kore-sort-SortMap "balanceTo" ( $.
$v z sg0 th2 th0 ph6 kore-sort-var-x0 th1 ph8 ph3 ptn0 ph1 th3 kore-sort-var-R ph0 ph2 xX x ptn1 y ph7 ph4 ph5 $.
$d y z $.
$d kore-sort-var-R kore-sort-var-x0 $.
$d z x $.
$d z kore-sort-var-x0 $.
$d kore-sort-var-R x $.
$d y x $.
$d y kore-sort-var-x0 $.
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
ptn0-pattern $f #Pattern ptn0 $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
ptn1-pattern $f #Pattern ptn1 $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-14-is-pattern $a #Pattern \kore-sort-SortMap $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-symbol-194-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds'Map'Unds' ptn0 ptn1 ) $.
IMP-symbol-218-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ptn0 ptn1 ) $.
kore-sort-var-x0-elementvariable $f #ElementVariable kore-sort-var-x0 $.
string-literal-1-is-pattern $a #Pattern "0" $.
string-literal-12-is-pattern $a #Pattern "12345" $.
string-literal-13-is-pattern $a #Pattern "10" $.
string-literal-14-is-pattern $a #Pattern "amount" $.
string-literal-17-is-pattern $a #Pattern "balanceTo" $.
string-literal-18-is-pattern $a #Pattern "addressTo" $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-14 $a #Pattern kore-sort-var-x0 $.
typecode-cache-Pattern-22 $a #Pattern ( \eq x \unit-sort ) $.
sorting-cache-129 $a |- ( \imp \top ( \and ( \kore-is-sort \unit-sort ) \top ) ) $.
sorting-cache-136 $a |- ( \imp ( \and \top ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ) ( \kore-is-sort kore-sort-var-R ) ) $.
substitution-83 $a #Substitution ( \and ( \kore-is-sort \unit-sort ) \top ) ( \and ( \kore-is-sort kore-sort-var-R ) \top ) \unit-sort kore-sort-var-R $.
substitution-87 $a #Substitution ( \and ( \kore-is-sort kore-sort-var-x0 ) \top ) ( \and ( \kore-is-sort kore-sort-var-R ) \top ) kore-sort-var-x0 kore-sort-var-R $.
substitution-140 $a #Substitution \kore-sort-SortMap \kore-sort-SortMap \unit-sort kore-sort-var-R $.
substitution-144 $a #Substitution \kore-sort-SortMap \kore-sort-SortMap kore-sort-var-x0 kore-sort-var-R $.
sorting-rearrange-657 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-valid kore-sort-var-R ( \kore-equals \kore-sort-SortMap kore-sort-var-R ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "10" ) ) ) ) ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "12345" ) ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "12345" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "10" ) ) ) ) ) ) ) ) $.
${ sorting-rearrange-658 $p |- ( \imp \top ( \kore-valid \unit-sort ( \kore-equals \kore-sort-SortMap \unit-sort ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "10" ) ) ) ) ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "12345" ) ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "12345" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "10" ) ) ) ) ) ) ) ) $= ( IMP-sort-17-is-pattern BASIC-K-sort-1-is-pattern kore-dv-is-pattern kore-inj-is-pattern IMP-sort-23-is-pattern IMP-symbol-218-is-pattern IMP-symbol-194-is-pattern kore-sort-var-R-elementvariable string-literal-17-is-pattern string-literal-1-is-pattern string-literal-14-is-pattern string-literal-13-is-pattern string-literal-18-is-pattern string-literal-12-is-pattern top-is-pattern typecode-cache-Pattern-0 unit-sort-is-symbol symbol-is-pattern kore-sort-var-x0-elementvariable and-is-pattern IMP-sort-14-is-pattern typecode-cache-Pattern-14 kore-is-sort-is-pattern element-var-is-var kore-equals-is-pattern kore-valid-is-pattern x-is-element-var substitution-var-same substitution-disjoint rule-weakening top-intro rule-and-intro-alt2-sugar rule-imp-transitivity substitution-kore-equals substitution-kore-valid substitution-imp sorting-cache-129 typecode-cache-Pattern-22 exists-is-pattern unit-sort-is-functional sorting-cache-136 sorting-rearrange-657 substitution-83 substitution-140 substitution-87 substitution-144 functional-substitution-alt ) OOQRUCOTTQRUAQRABAICDEBEJCDFABAKCDEBELCDFGABAMCDEBENCDFGABAMCDEBENCDFABAICDEBEJCDFABAKCDEBELCDFGGUEUFOOQRUCOTOOUKUJUQULQRHPUAHPABAICDEBEJCDFABAKCDEBELCDFGABAMCDEBENCDFGABAMCDEBENCDFABAICDEBEJCDFABAKCDEBELCDFGGUEUFQRUAQRABAICDEBEJCDFABAKCDEBELCDFGABAMCDEBENCDFGABAMCDEBENCDFABAICDEBEJCDFABAKCDEBELCDFGGUEUFSUBUASUBABAICDEBEJCDFABAKCDEBELCDFGABAMCDEBENCDFGABAMCDEBENCDFABAICDEBEJCDFABAKCDEBELCDFGGUEUFOHPUCOTQRUCOTSUBUCOTUGHSOUGURUGUSUGUTUJOHPUCOTTHPUCOTHPUAHPABAICDEBEJCDFABAKCDEBELCDFGABAMCDEBENCDFGABAMCDEBENCDFABAICDEBEJCDFABAKCDEBELCDFGGUEUFOHPUCOTTHPUCOHVAOHPUCOTTOUKUJULHVBUMQRQRUCOTQRUAQRABAICDEBEJCDFABAKCDEBELCDFGABAMCDEBENCDFGABAMCDEBENCDFABAICDEBEJCDFABAKCDEBELCDFGGUEUFHPUCOTHPUAHPABAICDEBEJCDFABAKCDEBELCDFGABAMCDEBENCDFGABAMCDEBENCDFABAICDEBEJCDFABAKCDEBELCDFGGUEUFHUDHVCQRUAQRABAICDEBEJCDFABAKCDEBELCDFGABAMCDEBENCDFGABAMCDEBENCDFABAICDEBEJCDFABAKCDEBELCDFGGUEHPUAHPABAICDEBEJCDFABAKCDEBELCDFGABAMCDEBENCDFGABAMCDEBENCDFABAICDEBEJCDFABAKCDEBELCDFGGUEQRHUDQRHUDUHUAQRABAICDEBEJCDFABAKCDEBELCDFGABAMCDEBENCDFGABAMCDEBENCDFABAICDEBEJCDFABAKCDEBELCDFGGUAHPABAICDEBEJCDFABAKCDEBELCDFGABAMCDEBENCDFGABAMCDEBENCDFABAICDEBEJCDFABAKCDEBELCDFGGQRHUDHVDQRHUDUHABAICDEBEJCDFABAKCDEBELCDFGABAMCDEBENCDFGQRHUDUIABAMCDEBENCDFABAICDEBEJCDFABAKCDEBELCDFGGQRHUDUIUNUOUPSUBSUBUCOTSUBUASUBABAICDEBEJCDFABAKCDEBELCDFGABAMCDEBENCDFGABAMCDEBENCDFABAICDEBEJCDFABAKCDEBELCDFGGUEUFHPUCOTHPUAHPABAICDEBEJCDFABAKCDEBELCDFGABAMCDEBENCDFGABAMCDEBENCDFABAICDEBEJCDFABAKCDEBELCDFGGUEUFHUDHSVESUBUASUBABAICDEBEJCDFABAKCDEBELCDFGABAMCDEBENCDFGABAMCDEBENCDFABAICDEBEJCDFABAKCDEBELCDFGGUEHPUAHPABAICDEBEJCDFABAKCDEBELCDFGABAMCDEBENCDFGABAMCDEBENCDFABAICDEBEJCDFABAKCDEBELCDFGGUESUBHUDSUBHUDUHUASUBABAICDEBEJCDFABAKCDEBELCDFGABAMCDEBENCDFGABAMCDEBENCDFABAICDEBEJCDFABAKCDEBELCDFGGUAHPABAICDEBEJCDFABAKCDEBELCDFGABAMCDEBENCDFGABAMCDEBENCDFABAICDEBEJCDFABAKCDEBELCDFGGSUBHUDHSVFSUBHUDUHABAICDEBEJCDFABAKCDEBELCDFGABAMCDEBENCDFGSUBHUDUIABAMCDEBENCDFABAICDEBEJCDFABAKCDEBELCDFGGSUBHUDUIUNUOUPVGUM $. $}
