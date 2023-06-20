$c #Substitution \unit-sort #SetVariable #ElementVariable #Symbol "210" #Variable #Pattern \kore-dv ) \kore-equals \kore-sort-SortInt ( $.
$v ph0 xX ph2 x sg0 ph6 kore-sort-var-x0 kore-element-var-x1 ph7 ph8 ph3 ph4 ph5 ph1 $.
$d kore-element-var-x1 x $.
$d x kore-sort-var-x0 $.
$d kore-element-var-x1 kore-sort-var-x0 $.
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
sg0-is-symbol $f #Symbol sg0 $.
element-var-is-var $a #Variable x $.
symbol-is-pattern $a #Pattern sg0 $.
substitution-var-same $a #Substitution ph0 xX ph0 xX $.
unit-sort-is-symbol $a #Symbol \unit-sort $.
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
typecode-cache-Pattern-23 $a #Pattern kore-element-var-x1 $.
substitution-62 $a #Substitution kore-element-var-x1 kore-element-var-x1 \unit-sort kore-sort-var-x0 $.
substitution-116 $a #Substitution \kore-sort-SortInt \kore-sort-SortInt \unit-sort kore-sort-var-x0 $.
string-literal-20-is-pattern $a #Pattern "210" $.
${ substitution-1267 $p #Substitution ( \kore-equals \kore-sort-SortInt \unit-sort kore-element-var-x1 ( \kore-dv \kore-sort-SortInt "210" ) ) ( \kore-equals \kore-sort-SortInt kore-sort-var-x0 kore-element-var-x1 ( \kore-dv \kore-sort-SortInt "210" ) ) \unit-sort kore-sort-var-x0 $= ( IMP-sort-23-is-pattern unit-sort-is-symbol symbol-is-pattern string-literal-20-is-pattern kore-dv-is-pattern element-var-is-var typecode-cache-Pattern-23 typecode-cache-Pattern-14 substitution-116 substitution-var-same substitution-62 substitution-disjoint substitution-kore-equals ) CDEBICFGCAJBICFGDEAHAKDEAHLABMCFGDEAHNO $. $}
