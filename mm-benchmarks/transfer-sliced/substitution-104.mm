$c #Substitution \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \and \imp \kore-is-sort \kore-valid ) \kore-sort-SortInt \kore-equals \kore-inj \in-sort ( $.
$v kore-sort-var-R ph0 ph2 kore-sort-var-S2 xX x kore-sort-var-S3 kore-element-var-T ph3 ph4 kore-sort-var-S1 ph1 $.
$d kore-sort-var-S2 x $.
$d kore-sort-var-R kore-sort-var-S2 $.
$d kore-sort-var-R kore-sort-var-S3 $.
$d kore-sort-var-S1 kore-element-var-T $.
$d kore-element-var-T x $.
$d kore-sort-var-R kore-element-var-T $.
$d kore-sort-var-S1 kore-sort-var-S2 $.
$d kore-sort-var-S2 kore-element-var-T $.
$d kore-sort-var-S3 kore-sort-var-S2 $.
$d kore-sort-var-R x $.
$d kore-sort-var-R kore-sort-var-S1 $.
$d kore-sort-var-S1 kore-sort-var-S3 $.
$d kore-sort-var-S3 x $.
$d kore-sort-var-S3 kore-element-var-T $.
$d kore-sort-var-S1 x $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
ph4-is-pattern $f #Pattern ph4 $.
x-is-element-var $f #ElementVariable x $.
xX-is-var $f #Variable xX $.
element-var-is-var $a #Variable x $.
${ substitution-imp.0 $e #Substitution ph1 ph3 ph0 xX $.
   substitution-imp.1 $e #Substitution ph2 ph4 ph0 xX $.
   substitution-imp $a #Substitution ( \imp ph1 ph2 ) ( \imp ph3 ph4 ) ph0 xX $. $}
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
kore-valid-is-pattern $a #Pattern ( \kore-valid ph0 ph1 ) $.
kore-equals-is-pattern $a #Pattern ( \kore-equals ph0 ph1 ph2 ph3 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
kore-sort-var-S3-elementvariable $f #ElementVariable kore-sort-var-S3 $.
kore-sort-var-S2-elementvariable $f #ElementVariable kore-sort-var-S2 $.
kore-sort-var-S1-elementvariable $f #ElementVariable kore-sort-var-S1 $.
kore-element-var-T-elementvariable $f #ElementVariable kore-element-var-T $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-1 $a #Pattern kore-sort-var-S2 $.
typecode-cache-Pattern-2 $a #Pattern kore-sort-var-S3 $.
typecode-cache-Pattern-5 $a #Pattern kore-sort-var-S1 $.
typecode-cache-Pattern-6 $a #Pattern kore-element-var-T $.
typecode-cache-Pattern-7 $a #Pattern ( \in-sort kore-element-var-T kore-sort-var-S1 ) $.
typecode-cache-Pattern-10 $a #Pattern ( \kore-inj kore-sort-var-S2 kore-sort-var-S3 ( \kore-inj kore-sort-var-S1 kore-sort-var-S2 kore-element-var-T ) ) $.
typecode-cache-Pattern-11 $a #Pattern ( \kore-inj kore-sort-var-S1 kore-sort-var-S3 kore-element-var-T ) $.
typecode-cache-Pattern-26 $a #Pattern ( \kore-inj \kore-sort-SortInt kore-sort-var-S2 kore-element-var-T ) $.
typecode-cache-Pattern-27 $a #Pattern ( \kore-inj \kore-sort-SortInt kore-sort-var-S3 kore-element-var-T ) $.
substitution-95 $a #Substitution ( \and ( \kore-is-sort \kore-sort-SortInt ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortInt ) \top ) ) ( \and ( \kore-is-sort kore-sort-var-S1 ) ( \and ( \in-sort kore-element-var-T kore-sort-var-S1 ) \top ) ) \kore-sort-SortInt kore-sort-var-S1 $.
substitution-103 $a #Substitution ( \kore-valid kore-sort-var-R ( \kore-equals kore-sort-var-S3 kore-sort-var-R ( \kore-inj kore-sort-var-S2 kore-sort-var-S3 ( \kore-inj \kore-sort-SortInt kore-sort-var-S2 kore-element-var-T ) ) ( \kore-inj \kore-sort-SortInt kore-sort-var-S3 kore-element-var-T ) ) ) ( \kore-valid kore-sort-var-R ( \kore-equals kore-sort-var-S3 kore-sort-var-R ( \kore-inj kore-sort-var-S2 kore-sort-var-S3 ( \kore-inj kore-sort-var-S1 kore-sort-var-S2 kore-element-var-T ) ) ( \kore-inj kore-sort-var-S1 kore-sort-var-S3 kore-element-var-T ) ) ) \kore-sort-SortInt kore-sort-var-S1 $.
${ substitution-104 $p #Substitution ( \imp ( \and ( \kore-is-sort \kore-sort-SortInt ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortInt ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-equals kore-sort-var-S3 kore-sort-var-R ( \kore-inj kore-sort-var-S2 kore-sort-var-S3 ( \kore-inj \kore-sort-SortInt kore-sort-var-S2 kore-element-var-T ) ) ( \kore-inj \kore-sort-SortInt kore-sort-var-S3 kore-element-var-T ) ) ) ) ( \imp ( \and ( \kore-is-sort kore-sort-var-S1 ) ( \and ( \in-sort kore-element-var-T kore-sort-var-S1 ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-equals kore-sort-var-S3 kore-sort-var-R ( \kore-inj kore-sort-var-S2 kore-sort-var-S3 ( \kore-inj kore-sort-var-S1 kore-sort-var-S2 kore-element-var-T ) ) ( \kore-inj kore-sort-var-S1 kore-sort-var-S3 kore-element-var-T ) ) ) ) \kore-sort-SortInt kore-sort-var-S1 $= ( and-is-pattern typecode-cache-Pattern-0 IMP-sort-23-is-pattern typecode-cache-Pattern-2 kore-is-sort-is-pattern top-is-pattern kore-equals-is-pattern kore-valid-is-pattern typecode-cache-Pattern-6 in-sort-is-pattern typecode-cache-Pattern-1 typecode-cache-Pattern-26 kore-inj-is-pattern typecode-cache-Pattern-27 typecode-cache-Pattern-5 typecode-cache-Pattern-7 typecode-cache-Pattern-10 typecode-cache-Pattern-11 element-var-is-var substitution-95 substitution-103 substitution-imp ) HHJENHOKFFAGBIAGCPBICEQRBESLMDTJDEUAKFFAGBIAGBCDEUBBDEUCLMDUDDEUEABCDEUFUG $. $}
