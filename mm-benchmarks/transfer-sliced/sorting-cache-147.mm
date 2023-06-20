$c \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \and \imp \kore-is-sort |- ) \kore-sort-SortInt \in-sort ( $.
$v kore-sort-var-R ph0 ph2 kore-sort-var-S2 kore-sort-var-S3 kore-element-var-T ph1 $.
$d kore-sort-var-R kore-sort-var-S2 $.
$d kore-sort-var-R kore-sort-var-S3 $.
$d kore-sort-var-R kore-element-var-T $.
$d kore-sort-var-S2 kore-element-var-T $.
$d kore-sort-var-S3 kore-sort-var-S2 $.
$d kore-sort-var-S3 kore-element-var-T $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
and-elim-right-sugar $a |- ( \imp ( \and ph0 ph1 ) ph1 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
kore-sort-var-S3-elementvariable $f #ElementVariable kore-sort-var-S3 $.
kore-sort-var-S2-elementvariable $f #ElementVariable kore-sort-var-S2 $.
kore-element-var-T-elementvariable $f #ElementVariable kore-element-var-T $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-1 $a #Pattern kore-sort-var-S2 $.
typecode-cache-Pattern-2 $a #Pattern kore-sort-var-S3 $.
typecode-cache-Pattern-28 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-S3 ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortInt ) \top ) ) $.
sorting-cache-146 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-S3 ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortInt ) \top ) ) ( \kore-is-sort kore-sort-var-S3 ) ) $.
${ sorting-cache-147 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \kore-is-sort kore-sort-var-S2 ) ( \and ( \kore-is-sort kore-sort-var-S3 ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortInt ) \top ) ) ) ) ( \kore-is-sort kore-sort-var-S3 ) ) $= ( kore-is-sort-is-pattern typecode-cache-Pattern-28 typecode-cache-Pattern-1 and-is-pattern typecode-cache-Pattern-0 typecode-cache-Pattern-2 and-elim-right-sugar rule-imp-transitivity sorting-cache-146 ) AIECGEBDFHHCGEBDFHBJEAIECGEBDFHKCGEBDFHBDFBJECGEBDFKBDMLL $. $}
