$c #Substitution #SetVariable #ElementVariable #Symbol "210" #Variable #Pattern \kore-dv ) \kore-equals \kore-sort-SortInt ( $.
$v ph0 xX ph2 x ph6 kore-sort-var-x0 kore-element-var-x1 ph7 ph8 ph3 ph4 kore-sort-var-x1 ph5 ph1 $.
$d kore-sort-var-x1 kore-sort-var-x0 $.
$d kore-element-var-x1 x $.
$d kore-sort-var-x1 kore-element-var-x1 $.
$d x kore-sort-var-x0 $.
$d kore-element-var-x1 kore-sort-var-x0 $.
$d kore-sort-var-x1 x $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
ph4-is-pattern $f #Pattern ph4 $.
ph5-is-pattern $f #Pattern ph5 $.
ph6-is-pattern $f #Pattern ph6 $.
ph7-is-pattern $f #Pattern ph7 $.
ph8-is-pattern $f #Pattern ph8 $.
x-is-element-var $f #ElementVariable x $.
xX-is-var $f #Variable xX $.
element-var-is-var $a #Variable x $.
substitution-var-same $a #Substitution ph0 xX ph0 xX $.
${ $d xX ph0 $.
   substitution-disjoint $a #Substitution ph0 ph0 ph1 xX $. $}
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
${ substitution-kore-equals.0 $e #Substitution ph0 ph4 ph8 xX $.
   substitution-kore-equals.1 $e #Substitution ph1 ph5 ph8 xX $.
   substitution-kore-equals.2 $e #Substitution ph2 ph6 ph8 xX $.
   substitution-kore-equals.3 $e #Substitution ph3 ph7 ph8 xX $.
   substitution-kore-equals $a #Substitution ( \kore-equals ph0 ph1 ph2 ph3 ) ( \kore-equals ph4 ph5 ph6 ph7 ) ph8 xX $. $}
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
kore-sort-var-x0-elementvariable $f #ElementVariable kore-sort-var-x0 $.
kore-element-var-x1-elementvariable $f #ElementVariable kore-element-var-x1 $.
typecode-cache-Pattern-14 $a #Pattern kore-sort-var-x0 $.
kore-sort-var-x1-elementvariable $f #ElementVariable kore-sort-var-x1 $.
typecode-cache-Pattern-23 $a #Pattern kore-element-var-x1 $.
typecode-cache-Pattern-24 $a #Pattern kore-sort-var-x1 $.
substitution-68 $a #Substitution kore-element-var-x1 kore-element-var-x1 kore-sort-var-x1 kore-sort-var-x0 $.
substitution-118 $a #Substitution \kore-sort-SortInt \kore-sort-SortInt kore-sort-var-x1 kore-sort-var-x0 $.
string-literal-20-is-pattern $a #Pattern "210" $.
${ substitution-1268 $p #Substitution ( \kore-equals \kore-sort-SortInt kore-sort-var-x1 kore-element-var-x1 ( \kore-dv \kore-sort-SortInt "210" ) ) ( \kore-equals \kore-sort-SortInt kore-sort-var-x0 kore-element-var-x1 ( \kore-dv \kore-sort-SortInt "210" ) ) kore-sort-var-x1 kore-sort-var-x0 $= ( IMP-sort-23-is-pattern typecode-cache-Pattern-24 string-literal-20-is-pattern kore-dv-is-pattern element-var-is-var typecode-cache-Pattern-23 typecode-cache-Pattern-14 substitution-118 substitution-var-same substitution-68 substitution-disjoint substitution-kore-equals ) DCEBIDFGDAJBIDFGCEAHACKCEAHLABCMDFGCEAHNO $. $}
