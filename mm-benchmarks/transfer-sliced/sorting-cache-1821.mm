$c \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \kore-sort-SortBool \kore-sort-SortKItem \imp ( \kore-is-sort |- ) \and $.
$v kore-sort-var-R ph0 ph2 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
proof-rule-prop-1 $a |- ( \imp ph0 ( \imp ph1 ph0 ) ) $.
${ proof-rule-mp.0 $e |- ( \imp ph0 ph1 ) $.
   proof-rule-mp.1 $e |- ph0 $.
   proof-rule-mp $a |- ph1 $. $}
top-is-pattern $a #Pattern \top $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
BASIC-K-sort-1-sort $a |- ( \kore-is-sort \kore-sort-SortKItem ) $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-32-is-pattern $a #Pattern \kore-sort-SortBool $.
IMP-sort-32-sort $a |- ( \kore-is-sort \kore-sort-SortBool ) $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
${ sorting-cache-1821 $p |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) \top ) ) ( \and ( \kore-is-sort \kore-sort-SortBool ) ( \kore-is-sort \kore-sort-SortKItem ) ) ) $= ( and-is-pattern kore-is-sort-is-pattern top-is-pattern typecode-cache-Pattern-0 IMP-sort-32-is-pattern BASIC-K-sort-1-is-pattern imp-is-pattern proof-rule-prop-1 proof-rule-mp IMP-sort-32-sort BASIC-K-sort-1-sort rule-and-intro-alt2-sugar ) AECDBAECDBDBBFCGCFCAECDBAECDBDBBFCHFCAECDBAECDBDBBIKJGCAECDBAECDBDBBGCHGCAECDBAECDBDBBILJM $. $}
