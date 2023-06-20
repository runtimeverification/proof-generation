$c \exists #Substitution \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' "amount" \top "12345" #Variable "10" \imp \kore-dv "0" \kore-is-sort |- \kore-sort-SortId \kore-valid ) \kore-equals \and \unit-sort #SetVariable #ElementVariable \kore-symbol-Lbl'Unds'Map'Unds' #Symbol \eq #Pattern \kore-exists \kore-sort-SortKItem \kore-inj \kore-sort-SortInt "addressTo" \in-sort \kore-sort-SortMap "balanceTo" ( $.
$v z xX0 th2 th0 ph6 kore-element-var-x0 th1 ptn3 ptn2 kore-element-var-Val ph8 ph3 ptn0 ph1 th3 kore-sort-var-R ph0 ph2 xX x ptn4 ptn1 y kore-element-var-K3 ph7 ph4 ph5 kore-element-var-K2 $.
$d y z $.
$d kore-element-var-x0 kore-element-var-Val $.
$d kore-sort-var-R kore-element-var-Val $.
$d kore-element-var-K3 x $.
$d kore-element-var-x0 kore-element-var-K3 $.
$d kore-element-var-Val kore-element-var-K2 $.
$d z x $.
$d z kore-element-var-K3 $.
$d z kore-element-var-K2 $.
$d y kore-element-var-K3 $.
$d kore-element-var-K3 kore-element-var-Val $.
$d kore-sort-var-R kore-element-var-K2 $.
$d x kore-element-var-K2 $.
$d kore-element-var-Val x $.
$d z kore-element-var-Val $.
$d kore-sort-var-R x $.
$d y x $.
$d kore-element-var-x0 x $.
$d kore-element-var-x0 y $.
$d kore-element-var-x0 kore-element-var-K2 $.
$d kore-element-var-x0 kore-sort-var-R $.
$d y kore-element-var-Val $.
$d kore-element-var-x0 z $.
$d kore-element-var-K3 kore-element-var-K2 $.
$d y kore-element-var-K2 $.
$d kore-sort-var-R z $.
$d kore-sort-var-R kore-element-var-K3 $.
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
exists-is-pattern $a #Pattern ( \exists x ph0 ) $.
substitution-var-same $a #Substitution ph0 xX ph0 xX $.
${ substitution-imp.0 $e #Substitution ph1 ph3 ph0 xX $.
   substitution-imp.1 $e #Substitution ph2 ph4 ph0 xX $.
   substitution-imp $a #Substitution ( \imp ph1 ph2 ) ( \imp ph3 ph4 ) ph0 xX $. $}
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
eq-is-pattern $a #Pattern ( \eq ph0 ph1 ) $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
top-intro $a |- \top $.
and-elim-left-sugar $a |- ( \imp ( \and ph0 ph1 ) ph0 ) $.
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
${ $d x ph0 $.
   $d x ph1 $.
   kore-functional.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
   kore-functional.1 $e |- ( \imp th0 ( \kore-valid \unit-sort ( \kore-exists ph0 \unit-sort x ( \kore-equals ph0 \unit-sort x ph1 ) ) ) ) $.
   kore-functional $a |- ( \imp th0 ( \exists x ( \eq x ph1 ) ) ) $. $}
xX0-variable $f #Variable xX0 $.
ptn0-pattern $f #Pattern ptn0 $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
ptn1-pattern $f #Pattern ptn1 $.
ptn2-pattern $f #Pattern ptn2 $.
ptn3-pattern $f #Pattern ptn3 $.
ptn4-pattern $f #Pattern ptn4 $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-14-is-pattern $a #Pattern \kore-sort-SortMap $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-symbol-194-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds'Map'Unds' ptn0 ptn1 ) $.
${ IMP-symbol-194-substitution.0 $e #Substitution ptn1 ptn3 ptn0 xX0 $.
   IMP-symbol-194-substitution.1 $e #Substitution ptn2 ptn4 ptn0 xX0 $.
   IMP-symbol-194-substitution $a #Substitution ( \kore-symbol-Lbl'Unds'Map'Unds' ptn1 ptn2 ) ( \kore-symbol-Lbl'Unds'Map'Unds' ptn3 ptn4 ) ptn0 xX0 $. $}
IMP-symbol-218-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ptn0 ptn1 ) $.
kore-element-var-Val-elementvariable $f #ElementVariable kore-element-var-Val $.
kore-element-var-K2-elementvariable $f #ElementVariable kore-element-var-K2 $.
kore-element-var-K3-elementvariable $f #ElementVariable kore-element-var-K3 $.
string-literal-1-is-pattern $a #Pattern "0" $.
kore-element-var-x0-elementvariable $f #ElementVariable kore-element-var-x0 $.
string-literal-12-is-pattern $a #Pattern "12345" $.
string-literal-13-is-pattern $a #Pattern "10" $.
string-literal-14-is-pattern $a #Pattern "amount" $.
string-literal-17-is-pattern $a #Pattern "balanceTo" $.
string-literal-18-is-pattern $a #Pattern "addressTo" $.
sorting-cache-75 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "12345" ) ) ) \kore-sort-SortMap ) ) $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-25 $a #Pattern kore-element-var-x0 $.
typecode-cache-Pattern-31 $a #Pattern kore-element-var-Val $.
typecode-cache-Pattern-120 $a #Pattern kore-element-var-K2 $.
substitution-400 $a #Substitution kore-sort-var-R kore-sort-var-R kore-element-var-x0 kore-element-var-K2 $.
substitution-610 $a #Substitution \kore-sort-SortMap \kore-sort-SortMap kore-element-var-x0 kore-element-var-K2 $.
substitution-612 $a #Substitution ( \and ( \in-sort kore-element-var-x0 \kore-sort-SortMap ) \top ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortMap ) \top ) kore-element-var-x0 kore-element-var-K2 $.
typecode-cache-Pattern-209 $a #Pattern kore-element-var-K3 $.
typecode-cache-Pattern-210 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortMap ) ( \and ( \in-sort kore-element-var-K3 \kore-sort-SortMap ) \top ) ) ) $.
typecode-cache-Pattern-212 $a #Pattern ( \kore-symbol-Lbl'Unds'Map'Unds' kore-element-var-K2 kore-element-var-K3 ) $.
typecode-cache-Pattern-215 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K3 \kore-sort-SortMap ) \top ) ) $.
sorting-cache-740 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K3 \kore-sort-SortMap ) \top ) ) ( \kore-is-sort kore-sort-var-R ) ) $.
sorting-cache-742 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K3 \kore-sort-SortMap ) \top ) ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortMap ) \top ) ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortMap ) ( \and ( \in-sort kore-element-var-K3 \kore-sort-SortMap ) \top ) ) ) $.
typecode-cache-Pattern-216 $a #Pattern ( \kore-symbol-Lbl'Unds'Map'Unds' kore-element-var-x0 kore-element-var-K3 ) $.
substitution-647 $a #Substitution kore-element-var-K3 kore-element-var-K3 kore-element-var-x0 kore-element-var-K2 $.
substitution-648 $a #Substitution ( \kore-symbol-Lbl'Unds'Map'Unds' kore-element-var-x0 kore-element-var-K3 ) ( \kore-symbol-Lbl'Unds'Map'Unds' kore-element-var-K2 kore-element-var-K3 ) kore-element-var-x0 kore-element-var-K2 $.
sorting-cache-743 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K3 \kore-sort-SortMap ) \top ) ) ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K3 \kore-sort-SortMap ) \top ) ) ) $.
sorting-rearrange-546 $a |- ( \imp \top ( \kore-valid \unit-sort ( \kore-exists \kore-sort-SortMap \unit-sort kore-element-var-Val ( \kore-equals \kore-sort-SortMap \unit-sort kore-element-var-Val ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "12345" ) ) ) ) ) ) ) $.
sorting-cache-1047 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K3 \kore-sort-SortMap ) \top ) ) ( \in-sort ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "12345" ) ) ) \kore-sort-SortMap ) ) $.
sorting-rearrange-642 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortMap ) ( \and ( \in-sort kore-element-var-K3 \kore-sort-SortMap ) \top ) ) ) ( \kore-valid kore-sort-var-R ( \kore-equals \kore-sort-SortMap kore-sort-var-R ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "10" ) ) ) ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) kore-element-var-K2 ) kore-element-var-K3 ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "10" ) ) ) ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' kore-element-var-K2 kore-element-var-K3 ) ) ) ) ) $.
${ sorting-rearrange-643 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K3 \kore-sort-SortMap ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-equals \kore-sort-SortMap kore-sort-var-R ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "10" ) ) ) ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "12345" ) ) ) ) kore-element-var-K3 ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "10" ) ) ) ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "12345" ) ) ) kore-element-var-K3 ) ) ) ) ) $= ( IMP-sort-17-is-pattern BASIC-K-sort-1-is-pattern kore-dv-is-pattern kore-inj-is-pattern IMP-sort-23-is-pattern IMP-symbol-218-is-pattern IMP-symbol-194-is-pattern kore-element-var-K2-elementvariable string-literal-14-is-pattern string-literal-13-is-pattern string-literal-17-is-pattern string-literal-1-is-pattern string-literal-18-is-pattern string-literal-12-is-pattern IMP-sort-14-is-pattern typecode-cache-Pattern-0 typecode-cache-Pattern-209 element-var-is-var kore-element-var-x0-elementvariable typecode-cache-Pattern-120 top-is-pattern and-is-pattern in-sort-is-pattern typecode-cache-Pattern-25 typecode-cache-Pattern-215 kore-equals-is-pattern substitution-disjoint typecode-cache-Pattern-212 kore-valid-is-pattern IMP-symbol-194-substitution typecode-cache-Pattern-216 kore-element-var-Val-elementvariable rule-imp-transitivity substitution-var-same rule-and-intro-alt2-sugar top-intro rule-weakening kore-is-sort-is-pattern substitution-kore-equals substitution-kore-valid substitution-imp substitution-400 sorting-cache-743 sorting-cache-1047 typecode-cache-Pattern-31 eq-is-pattern exists-is-pattern sorting-cache-75 sorting-rearrange-546 kore-functional typecode-cache-Pattern-210 and-elim-left-sugar sorting-cache-740 sorting-cache-742 sorting-rearrange-642 substitution-in-sort substitution-and substitution-612 substitution-610 substitution-647 substitution-648 functional-substitution-alt ) ABUGABUGCDCOEFGDGPEFHQUEUCUDUDARQARCDCKEFGDGLEFHCDCMEFGDGNEFHICDCOEFGDGPEFHIBSICDCKEFGDGLEFHCDCMEFGDGNEFHICDCOEFGDGPEFHBSIIUHUKABUGABUGCDCOEFGDGPEFHQUEUCUDABVEABUGCDCOEFGDGPEFHQUEUCABVFABUGUCURUSUQUQCDCOEFGDGPEFHARQARCDCKEFGDGLEFHCDCMEFGDGNEFHIJUBIBSICDCKEFGDGLEFHCDCMEFGDGNEFHIJBUJIUHUKARQARCDCKEFGDGLEFHCDCMEFGDGNEFHICDCOEFGDGPEFHIBSICDCKEFGDGLEFHCDCMEFGDGNEFHICDCOEFGDGPEFHBSIIUHUKARQARCDCKEFGDGLEFHCDCMEFGDGNEFHIUAUFIBSICDCKEFGDGLEFHCDCMEFGDGNEFHIBUAUMIUHUKABUGJUBQUEUCUDCDCOEFGDGPEFHQUEUCUDUAUFQUEUCUDUNJUAABUGUCUNVGCDCOEFGDGPEFHVHUNVIABUGUCURUSQCDCOEFGDGPEFHUCUNVJUNVKVLUOABUGJUBQUEUCUDUDAJBVMARQARCDCKEFGDGLEFHCDCMEFGDGNEFHIJUBIBSICDCKEFGDGLEFHCDCMEFGDGNEFHIJBUJIUHUKABUGJUBQUEUCUDUDARUTJUBQUEBSQUEUCUDUDABUGJUBQUEUCUDUDABUGARUTABUGJUBQUEUCUDVNABVOUOAJBVPUQAJBVQUOCDCOEFGDGPEFHCDCOEFGDGPEFHQUEUCUDARQARCDCKEFGDGLEFHCDCMEFGDGNEFHICDCOEFGDGPEFHIBSICDCKEFGDGLEFHCDCMEFGDGNEFHICDCOEFGDGPEFHBSIIUHUKJUBQUEUCUDARQARCDCKEFGDGLEFHCDCMEFGDGNEFHIJUBIBSICDCKEFGDGLEFHCDCMEFGDGNEFHIJBUJIUHUKJTCDCOEFGDGPEFHCDCOEFGDGPEFHQUEUCJUBQUEUCJTCDCOEFGDGPEFHCDCOEFGDGPEFHQJUBQJTCDCOEFGDGPEFHJTUPQCDCOEFGDGPEFHJTUIVRUCCDCOEFGDGPEFHJTUIVSARQARCDCKEFGDGLEFHCDCMEFGDGNEFHICDCOEFGDGPEFHIBSICDCKEFGDGLEFHCDCMEFGDGNEFHICDCOEFGDGPEFHBSIIUHARQARCDCKEFGDGLEFHCDCMEFGDGNEFHIJUBIBSICDCKEFGDGLEFHCDCMEFGDGNEFHIJBUJIUHCDCOEFGDGPEFHJTARCDCOEFGDGPEFHJTUIQARCDCKEFGDGLEFHCDCMEFGDGNEFHICDCOEFGDGPEFHIBSICDCKEFGDGLEFHCDCMEFGDGNEFHICDCOEFGDGPEFHBSIIQARCDCKEFGDGLEFHCDCMEFGDGNEFHIJUBIBSICDCKEFGDGLEFHCDCMEFGDGNEFHIJBUJICDCOEFGDGPEFHJTQCDCOEFGDGPEFHJTUIARCDCOEFGDGPEFHJTUIJTCDCOEFGDGPEFHCDCKEFGDGLEFHCDCMEFGDGNEFHICDCOEFGDGPEFHIBSCDCKEFGDGLEFHCDCMEFGDGNEFHIJUBIBSJTCDCOEFGDGPEFHCDCKEFGDGLEFHCDCMEFGDGNEFHICDCOEFGDGPEFHCDCKEFGDGLEFHCDCMEFGDGNEFHIJUBCDCKEFGDGLEFHCDCMEFGDGNEFHICDCOEFGDGPEFHJTUICDCOEFGDGPEFHJTUPULBSCDCOEFGDGPEFHJTUIULJTCDCOEFGDGPEFHCDCKEFGDGLEFHCDCMEFGDGNEFHICDCOEFGDGPEFHBSICDCKEFGDGLEFHCDCMEFGDGNEFHIJBUJCDCKEFGDGLEFHCDCMEFGDGNEFHICDCOEFGDGPEFHJTUIJTCDCOEFGDGPEFHCDCOEFGDGPEFHBSJUBBSCDCOEFGDGPEFHJTUPBSCDCOEFGDGPEFHJTUIULULVAVBVCUAUFUAUFQUEUCUDARQARCDCKEFGDGLEFHCDCMEFGDGNEFHIUAUFIBSICDCKEFGDGLEFHCDCMEFGDGNEFHIBUAUMIUHUKJUBQUEUCUDARQARCDCKEFGDGLEFHCDCMEFGDGNEFHIJUBIBSICDCKEFGDGLEFHCDCMEFGDGNEFHIJBUJIUHUKJTJUAVTARQARCDCKEFGDGLEFHCDCMEFGDGNEFHIUAUFIBSICDCKEFGDGLEFHCDCMEFGDGNEFHIBUAUMIUHARQARCDCKEFGDGLEFHCDCMEFGDGNEFHIJUBIBSICDCKEFGDGLEFHCDCMEFGDGNEFHIJBUJIUHUAUFJTAJUAVDQARCDCKEFGDGLEFHCDCMEFGDGNEFHIUAUFIBSICDCKEFGDGLEFHCDCMEFGDGNEFHIBUAUMIQARCDCKEFGDGLEFHCDCMEFGDGNEFHIJUBIBSICDCKEFGDGLEFHCDCMEFGDGNEFHIJBUJIUAUFJTJUAWAAJUAVDJTUAUFCDCKEFGDGLEFHCDCMEFGDGNEFHIUAUFIBSCDCKEFGDGLEFHCDCMEFGDGNEFHIJUBIBSJTUAUFCDCKEFGDGLEFHCDCMEFGDGNEFHIUAUFCDCKEFGDGLEFHCDCMEFGDGNEFHIJUBCDCKEFGDGLEFHCDCMEFGDGNEFHIUAUFJTUIUAUFJTUPULJBUAWBULJTUAUFCDCKEFGDGLEFHCDCMEFGDGNEFHIBUAUMCDCKEFGDGLEFHCDCMEFGDGNEFHIJBUJCDCKEFGDGLEFHCDCMEFGDGNEFHIUAUFJTUIJBUAWCULVAVBVCWDUO $. $}
