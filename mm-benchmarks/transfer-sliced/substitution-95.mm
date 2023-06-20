$c #Substitution \top #SetVariable #ElementVariable #Symbol #Variable #Pattern ( \kore-is-sort ) \kore-sort-SortInt \in-sort \and $.
$v ph0 xX ph2 x kore-element-var-T ph3 ph4 kore-sort-var-S1 ph1 $.
$d kore-sort-var-S1 kore-element-var-T $.
$d kore-element-var-T x $.
$d kore-sort-var-S1 x $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
ph4-is-pattern $f #Pattern ph4 $.
x-is-element-var $f #ElementVariable x $.
xX-is-var $f #Variable xX $.
element-var-is-var $a #Variable x $.
substitution-var-same $a #Substitution ph0 xX ph0 xX $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ substitution-and.0 $e #Substitution ph1 ph3 ph0 xX $.
   substitution-and.1 $e #Substitution ph2 ph4 ph0 xX $.
   substitution-and $a #Substitution ( \and ph1 ph2 ) ( \and ph3 ph4 ) ph0 xX $. $}
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
${ $d x ph0 $.
   $d x ph1 $.
   $d x ph2 $.
   $d x xX $.
   substitution-kore-is-sort.0 $e #Substitution ph0 ph1 ph2 xX $.
   substitution-kore-is-sort $a #Substitution ( \kore-is-sort ph0 ) ( \kore-is-sort ph1 ) ph2 xX $. $}
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
kore-sort-var-S1-elementvariable $f #ElementVariable kore-sort-var-S1 $.
kore-element-var-T-elementvariable $f #ElementVariable kore-element-var-T $.
typecode-cache-Pattern-5 $a #Pattern kore-sort-var-S1 $.
typecode-cache-Pattern-6 $a #Pattern kore-element-var-T $.
typecode-cache-Pattern-7 $a #Pattern ( \in-sort kore-element-var-T kore-sort-var-S1 ) $.
substitution-94 $a #Substitution ( \and ( \in-sort kore-element-var-T \kore-sort-SortInt ) \top ) ( \and ( \in-sort kore-element-var-T kore-sort-var-S1 ) \top ) \kore-sort-SortInt kore-sort-var-S1 $.
${ substitution-95 $p #Substitution ( \and ( \kore-is-sort \kore-sort-SortInt ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortInt ) \top ) ) ( \and ( \kore-is-sort kore-sort-var-S1 ) ( \and ( \in-sort kore-element-var-T kore-sort-var-S1 ) \top ) ) \kore-sort-SortInt kore-sort-var-S1 $= ( IMP-sort-23-is-pattern element-var-is-var kore-is-sort-is-pattern top-is-pattern and-is-pattern typecode-cache-Pattern-5 typecode-cache-Pattern-6 in-sort-is-pattern typecode-cache-Pattern-7 substitution-var-same substitution-kore-is-sort substitution-94 substitution-and ) CCEBICJFGAHEABKFGADCAHCADCADLMABNO $. $}
