$c \exists #Substitution \top #Variable \imp \kore-is-sort |- \kore-valid ) \kore-equals \and \kore-symbol-Lbl'Stop'Map #SetVariable #ElementVariable \kore-symbol-Lbl'Unds'Map'Unds' #Symbol \eq #Pattern \in-sort \kore-sort-SortMap ( $.
$v z th2 th0 kore-element-var-x0 th1 kore-element-var-Val ph3 ptn0 ph1 th3 kore-sort-var-R ph0 ph2 xX x ptn1 y ph4 kore-element-var-K $.
$d y z $.
$d kore-element-var-x0 kore-element-var-Val $.
$d kore-sort-var-R kore-element-var-K $.
$d kore-sort-var-R kore-element-var-Val $.
$d z x $.
$d kore-element-var-x0 kore-element-var-K $.
$d kore-element-var-Val x $.
$d z kore-element-var-Val $.
$d kore-sort-var-R x $.
$d y x $.
$d z kore-element-var-K $.
$d kore-element-var-x0 x $.
$d kore-element-var-x0 y $.
$d kore-element-var-x0 kore-sort-var-R $.
$d y kore-element-var-K $.
$d y kore-element-var-Val $.
$d kore-element-var-x0 z $.
$d kore-element-var-K x $.
$d kore-sort-var-R z $.
$d kore-element-var-Val kore-element-var-K $.
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
kore-valid-is-pattern $a #Pattern ( \kore-valid ph0 ph1 ) $.
kore-equals-is-pattern $a #Pattern ( \kore-equals ph0 ph1 ph2 ph3 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
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
ptn0-pattern $f #Pattern ptn0 $.
ptn1-pattern $f #Pattern ptn1 $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-14-is-pattern $a #Pattern \kore-sort-SortMap $.
IMP-symbol-124-is-pattern $a #Pattern \kore-symbol-Lbl'Stop'Map $.
IMP-symbol-194-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds'Map'Unds' ptn0 ptn1 ) $.
kore-element-var-Val-elementvariable $f #ElementVariable kore-element-var-Val $.
kore-element-var-K-elementvariable $f #ElementVariable kore-element-var-K $.
kore-element-var-x0-elementvariable $f #ElementVariable kore-element-var-x0 $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-25 $a #Pattern kore-element-var-x0 $.
sorting-cache-133 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ) $.
sorting-rearrange-304 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \exists kore-element-var-Val ( \eq kore-element-var-Val \kore-symbol-Lbl'Stop'Map ) ) ) $.
typecode-cache-Pattern-189 $a #Pattern kore-element-var-K $.
sorting-rearrange-305 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \in-sort kore-element-var-K \kore-sort-SortMap ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-equals \kore-sort-SortMap kore-sort-var-R ( \kore-symbol-Lbl'Unds'Map'Unds' kore-element-var-K \kore-symbol-Lbl'Stop'Map ) kore-element-var-K ) ) ) $.
substitution-581 $a #Substitution ( \and ( \in-sort \kore-symbol-Lbl'Stop'Map \kore-sort-SortMap ) \top ) ( \and ( \in-sort kore-element-var-K \kore-sort-SortMap ) \top ) \kore-symbol-Lbl'Stop'Map kore-element-var-K $.
substitution-582 $a #Substitution kore-sort-var-R kore-sort-var-R \kore-symbol-Lbl'Stop'Map kore-element-var-K $.
substitution-583 $a #Substitution ( \kore-equals \kore-sort-SortMap kore-sort-var-R ( \kore-symbol-Lbl'Unds'Map'Unds' \kore-symbol-Lbl'Stop'Map \kore-symbol-Lbl'Stop'Map ) \kore-symbol-Lbl'Stop'Map ) ( \kore-equals \kore-sort-SortMap kore-sort-var-R ( \kore-symbol-Lbl'Unds'Map'Unds' kore-element-var-K \kore-symbol-Lbl'Stop'Map ) kore-element-var-K ) \kore-symbol-Lbl'Stop'Map kore-element-var-K $.
substitution-587 $a #Substitution ( \and ( \in-sort kore-element-var-x0 \kore-sort-SortMap ) \top ) ( \and ( \in-sort kore-element-var-K \kore-sort-SortMap ) \top ) kore-element-var-x0 kore-element-var-K $.
substitution-592 $a #Substitution ( \kore-valid kore-sort-var-R ( \kore-equals \kore-sort-SortMap kore-sort-var-R ( \kore-symbol-Lbl'Unds'Map'Unds' kore-element-var-x0 \kore-symbol-Lbl'Stop'Map ) kore-element-var-x0 ) ) ( \kore-valid kore-sort-var-R ( \kore-equals \kore-sort-SortMap kore-sort-var-R ( \kore-symbol-Lbl'Unds'Map'Unds' kore-element-var-K \kore-symbol-Lbl'Stop'Map ) kore-element-var-K ) ) kore-element-var-x0 kore-element-var-K $.
sorting-cache-687 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \in-sort \kore-symbol-Lbl'Stop'Map \kore-sort-SortMap ) \top ) ) $.
${ sorting-rearrange-306 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-valid kore-sort-var-R ( \kore-equals \kore-sort-SortMap kore-sort-var-R ( \kore-symbol-Lbl'Unds'Map'Unds' \kore-symbol-Lbl'Stop'Map \kore-symbol-Lbl'Stop'Map ) \kore-symbol-Lbl'Stop'Map ) ) ) $= ( typecode-cache-Pattern-0 IMP-symbol-124-is-pattern kore-element-var-K-elementvariable IMP-sort-14-is-pattern and-is-pattern top-is-pattern typecode-cache-Pattern-189 IMP-symbol-194-is-pattern kore-equals-is-pattern kore-element-var-x0-elementvariable in-sort-is-pattern kore-valid-is-pattern typecode-cache-Pattern-25 kore-is-sort-is-pattern element-var-is-var kore-element-var-Val-elementvariable substitution-imp sorting-cache-133 sorting-cache-687 rule-and-intro-alt2-sugar sorting-rearrange-304 sorting-rearrange-305 substitution-581 substitution-582 substitution-583 substitution-kore-valid substitution-587 substitution-592 functional-substitution-alt rule-imp-transitivity ) ABOGFABOGFCELGFFABEABCCICJMABOGFABOGFCELGFASATUACABEABDHCIDHJMABEABCCICJMABEABKNCIKNJMABOGFDHELGFCELGFKNELGFQDKAQUBADUCCCELGFABEABCCICJMDHELGFABEABDHCIDHJMDPDUDABEABCCICJABEABDHCIDHJCDPADUEADUFUGRKNKNELGFABEABKNCIKNJMDHELGFABEABDHCIDHJMDPDKUHADKUIRUJUK $. $}
