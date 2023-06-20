$c \exists #Substitution \top #SetVariable #ElementVariable #Symbol \eq #Variable #Pattern \and \imp \kore-is-sort |- \kore-sort-SortId \kore-valid ) \kore-equals \kore-inj \in-sort ( $.
$v z th2 th0 kore-sort-var-x0 th1 ph3 ph1 th3 kore-sort-var-R ph0 ph2 kore-sort-var-S2 x y kore-element-var-T kore-sort-var-S1 kore-sort-var-S3 $.
$d kore-sort-var-S3 z $.
$d kore-sort-var-S1 z $.
$d y z $.
$d kore-sort-var-S2 x $.
$d kore-sort-var-R kore-sort-var-x0 $.
$d kore-sort-var-R kore-sort-var-S2 $.
$d y kore-sort-var-S2 $.
$d z x $.
$d kore-element-var-T kore-sort-var-x0 $.
$d kore-sort-var-R kore-sort-var-S3 $.
$d kore-sort-var-S1 kore-element-var-T $.
$d y kore-sort-var-S3 $.
$d kore-element-var-T x $.
$d z kore-sort-var-x0 $.
$d kore-sort-var-S2 kore-sort-var-x0 $.
$d kore-sort-var-R kore-element-var-T $.
$d kore-sort-var-S1 kore-sort-var-S2 $.
$d z kore-sort-var-S2 $.
$d kore-sort-var-S2 kore-element-var-T $.
$d kore-sort-var-S3 kore-sort-var-S2 $.
$d kore-sort-var-R x $.
$d kore-sort-var-R kore-sort-var-S1 $.
$d y kore-sort-var-S1 $.
$d y x $.
$d kore-sort-var-S1 kore-sort-var-S3 $.
$d kore-sort-var-S3 x $.
$d kore-sort-var-S3 kore-sort-var-x0 $.
$d y kore-sort-var-x0 $.
$d kore-sort-var-S3 kore-element-var-T $.
$d x kore-sort-var-x0 $.
$d kore-sort-var-S1 kore-sort-var-x0 $.
$d kore-sort-var-R z $.
$d y kore-element-var-T $.
$d z kore-element-var-T $.
$d kore-sort-var-S1 x $.
$d y kore-sort-var-R $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
th0-is-pattern $f #Pattern th0 $.
th1-is-pattern $f #Pattern th1 $.
th2-is-pattern $f #Pattern th2 $.
th3-is-pattern $f #Pattern th3 $.
x-is-element-var $f #ElementVariable x $.
y-is-element-var $f #ElementVariable y $.
z-is-element-var $f #ElementVariable z $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
kore-valid-is-pattern $a #Pattern ( \kore-valid ph0 ph1 ) $.
kore-equals-is-pattern $a #Pattern ( \kore-equals ph0 ph1 ph2 ph3 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
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
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
kore-sort-var-x0-elementvariable $f #ElementVariable kore-sort-var-x0 $.
kore-sort-var-S3-elementvariable $f #ElementVariable kore-sort-var-S3 $.
kore-sort-var-S2-elementvariable $f #ElementVariable kore-sort-var-S2 $.
kore-sort-var-S1-elementvariable $f #ElementVariable kore-sort-var-S1 $.
kore-element-var-T-elementvariable $f #ElementVariable kore-element-var-T $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-1 $a #Pattern kore-sort-var-S2 $.
typecode-cache-Pattern-2 $a #Pattern kore-sort-var-S3 $.
typecode-cache-Pattern-3 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-S2 ) ( \and ( \kore-is-sort kore-sort-var-S3 ) \top ) ) $.
sorting-rearrange-0 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \kore-is-sort kore-sort-var-S2 ) ( \and ( \kore-is-sort kore-sort-var-S3 ) \top ) ) ) ( \exists x ( \eq x \kore-sort-SortId ) ) ) $.
typecode-cache-Pattern-5 $a #Pattern kore-sort-var-S1 $.
typecode-cache-Pattern-6 $a #Pattern kore-element-var-T $.
typecode-cache-Pattern-7 $a #Pattern ( \in-sort kore-element-var-T kore-sort-var-S1 ) $.
typecode-cache-Pattern-10 $a #Pattern ( \kore-inj kore-sort-var-S2 kore-sort-var-S3 ( \kore-inj kore-sort-var-S1 kore-sort-var-S2 kore-element-var-T ) ) $.
typecode-cache-Pattern-11 $a #Pattern ( \kore-inj kore-sort-var-S1 kore-sort-var-S3 kore-element-var-T ) $.
sorting-rearrange-1 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \kore-is-sort kore-sort-var-S2 ) ( \and ( \kore-is-sort kore-sort-var-S3 ) \top ) ) ) ( \and ( \kore-is-sort kore-sort-var-S1 ) ( \and ( \in-sort kore-element-var-T kore-sort-var-S1 ) \top ) ) ) ( \kore-valid kore-sort-var-R ( \kore-equals kore-sort-var-S3 kore-sort-var-R ( \kore-inj kore-sort-var-S2 kore-sort-var-S3 ( \kore-inj kore-sort-var-S1 kore-sort-var-S2 kore-element-var-T ) ) ( \kore-inj kore-sort-var-S1 kore-sort-var-S3 kore-element-var-T ) ) ) ) $.
typecode-cache-Pattern-12 $a #Pattern ( \kore-inj \kore-sort-SortId kore-sort-var-S2 kore-element-var-T ) $.
typecode-cache-Pattern-13 $a #Pattern ( \kore-inj \kore-sort-SortId kore-sort-var-S3 kore-element-var-T ) $.
typecode-cache-Pattern-14 $a #Pattern kore-sort-var-x0 $.
typecode-cache-Pattern-16 $a #Pattern ( \kore-inj kore-sort-var-S2 kore-sort-var-S3 ( \kore-inj kore-sort-var-x0 kore-sort-var-S2 kore-element-var-T ) ) $.
typecode-cache-Pattern-17 $a #Pattern ( \kore-inj kore-sort-var-x0 kore-sort-var-S3 kore-element-var-T ) $.
typecode-cache-Pattern-18 $a #Pattern ( \in-sort kore-element-var-T kore-sort-var-x0 ) $.
substitution-12 $a #Substitution ( \imp ( \and ( \kore-is-sort \kore-sort-SortId ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortId ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-equals kore-sort-var-S3 kore-sort-var-R ( \kore-inj kore-sort-var-S2 kore-sort-var-S3 ( \kore-inj \kore-sort-SortId kore-sort-var-S2 kore-element-var-T ) ) ( \kore-inj \kore-sort-SortId kore-sort-var-S3 kore-element-var-T ) ) ) ) ( \imp ( \and ( \kore-is-sort kore-sort-var-S1 ) ( \and ( \in-sort kore-element-var-T kore-sort-var-S1 ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-equals kore-sort-var-S3 kore-sort-var-R ( \kore-inj kore-sort-var-S2 kore-sort-var-S3 ( \kore-inj kore-sort-var-S1 kore-sort-var-S2 kore-element-var-T ) ) ( \kore-inj kore-sort-var-S1 kore-sort-var-S3 kore-element-var-T ) ) ) ) \kore-sort-SortId kore-sort-var-S1 $.
substitution-27 $a #Substitution ( \imp ( \and ( \kore-is-sort kore-sort-var-x0 ) ( \and ( \in-sort kore-element-var-T kore-sort-var-x0 ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-equals kore-sort-var-S3 kore-sort-var-R ( \kore-inj kore-sort-var-S2 kore-sort-var-S3 ( \kore-inj kore-sort-var-x0 kore-sort-var-S2 kore-element-var-T ) ) ( \kore-inj kore-sort-var-x0 kore-sort-var-S3 kore-element-var-T ) ) ) ) ( \imp ( \and ( \kore-is-sort kore-sort-var-S1 ) ( \and ( \in-sort kore-element-var-T kore-sort-var-S1 ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-equals kore-sort-var-S3 kore-sort-var-R ( \kore-inj kore-sort-var-S2 kore-sort-var-S3 ( \kore-inj kore-sort-var-S1 kore-sort-var-S2 kore-element-var-T ) ) ( \kore-inj kore-sort-var-S1 kore-sort-var-S3 kore-element-var-T ) ) ) ) kore-sort-var-x0 kore-sort-var-S1 $.
typecode-cache-Pattern-19 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-S3 ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortId ) \top ) ) $.
sorting-cache-115 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \kore-is-sort kore-sort-var-S2 ) ( \and ( \kore-is-sort kore-sort-var-S3 ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortId ) \top ) ) ) ) ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \kore-is-sort kore-sort-var-S2 ) ( \and ( \kore-is-sort kore-sort-var-S3 ) \top ) ) ) ( \and ( \kore-is-sort \kore-sort-SortId ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortId ) \top ) ) ) ) $.
${ sorting-rearrange-2 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \kore-is-sort kore-sort-var-S2 ) ( \and ( \kore-is-sort kore-sort-var-S3 ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortId ) \top ) ) ) ) ( \kore-valid kore-sort-var-R ( \kore-equals kore-sort-var-S3 kore-sort-var-R ( \kore-inj kore-sort-var-S2 kore-sort-var-S3 ( \kore-inj \kore-sort-SortId kore-sort-var-S2 kore-element-var-T ) ) ( \kore-inj \kore-sort-SortId kore-sort-var-S3 kore-element-var-T ) ) ) ) $= ( and-is-pattern typecode-cache-Pattern-0 kore-is-sort-is-pattern kore-sort-var-S1-elementvariable typecode-cache-Pattern-2 kore-sort-var-x0-elementvariable IMP-sort-17-is-pattern top-is-pattern kore-equals-is-pattern kore-valid-is-pattern typecode-cache-Pattern-1 typecode-cache-Pattern-3 typecode-cache-Pattern-6 in-sort-is-pattern typecode-cache-Pattern-12 kore-inj-is-pattern typecode-cache-Pattern-13 x-is-element-var typecode-cache-Pattern-19 sorting-cache-115 typecode-cache-Pattern-10 typecode-cache-Pattern-11 typecode-cache-Pattern-16 typecode-cache-Pattern-17 typecode-cache-Pattern-5 typecode-cache-Pattern-7 typecode-cache-Pattern-14 typecode-cache-Pattern-18 sorting-rearrange-0 sorting-rearrange-1 substitution-12 substitution-27 functional-substitution-alt rule-imp-transitivity ) AFGCOGBDUCEEAFGBCPEKGDQKRLEEEAFBIAFCOBICDSTBDUAMNABCDUDKAFBIAFBCHDUEBHDUFMNAFBIAFCOBICDSTBDUAMNAFBIAFJBCDUGJBDUHMNAFGBCPEHUIGHDUJLEEKGDQKRLEEJUKGJDULLEEUBHJUBABCUMABCHDUNABCHDUOAJBCHDUPUQUR $. $}
