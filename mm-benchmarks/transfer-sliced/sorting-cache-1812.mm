$c \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \kore-sort-SortBool \imp ( \kore-is-sort |- ) \in-sort \and $.
$v kore-sort-var-R ph0 ph2 kore-sort-var-S3 kore-element-var-T ph1 $.
$d kore-sort-var-R kore-sort-var-S3 $.
$d kore-sort-var-R kore-element-var-T $.
$d kore-sort-var-S3 kore-element-var-T $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
top-intro $a |- \top $.
and-elim-left-sugar $a |- ( \imp ( \and ph0 ph1 ) ph0 ) $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
${ rule-weakening.0 $e |- ph1 $.
   rule-weakening $a |- ( \imp ph0 ph1 ) $. $}
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-32-is-pattern $a #Pattern \kore-sort-SortBool $.
kore-sort-var-S3-elementvariable $f #ElementVariable kore-sort-var-S3 $.
kore-element-var-T-elementvariable $f #ElementVariable kore-element-var-T $.
typecode-cache-Pattern-2 $a #Pattern kore-sort-var-S3 $.
typecode-cache-Pattern-6 $a #Pattern kore-element-var-T $.
typecode-cache-Pattern-381 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortBool ) \top ) ) $.
sorting-cache-1811 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortBool ) \top ) ) ( \in-sort kore-element-var-T \kore-sort-SortBool ) ) $.
${ sorting-cache-1812 $p |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortBool ) \top ) ) ( \and ( \kore-is-sort kore-sort-var-S3 ) \top ) ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortBool ) \top ) ) $= ( and-is-pattern top-is-pattern typecode-cache-Pattern-381 typecode-cache-Pattern-2 kore-is-sort-is-pattern typecode-cache-Pattern-6 IMP-sort-32-is-pattern in-sort-is-pattern and-elim-left-sugar sorting-cache-1811 rule-imp-transitivity top-intro rule-weakening rule-and-intro-alt2-sugar ) ACFBGHEDDCIJKEACFBGHEDDACFCIJKACFBGHEDLACMNACFBGHEDDEOPQ $. $}
