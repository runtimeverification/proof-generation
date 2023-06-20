$c \top #SetVariable \kore-sort-SortAExp #ElementVariable #Symbol \kore-sort-SortStmt #Variable #Pattern \and \kore-sort-SortKItem \imp \kore-is-sort |- ) \in-sort \kore-sort-SortStateCell ( $.
$v kore-element-var-VE5 kore-element-var-VE4 ph0 ph2 kore-element-var-VE3 ph1 $.
$d kore-element-var-VE3 kore-element-var-VE4 $.
$d kore-element-var-VE5 kore-element-var-VE4 $.
$d kore-element-var-VE5 kore-element-var-VE3 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
proof-rule-prop-1 $a |- ( \imp ph0 ( \imp ph1 ph0 ) ) $.
${ proof-rule-mp.0 $e |- ( \imp ph0 ph1 ) $.
   proof-rule-mp.1 $e |- ph0 $.
   proof-rule-mp $a |- ph1 $. $}
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
BASIC-K-sort-1-sort $a |- ( \kore-is-sort \kore-sort-SortKItem ) $.
kore-element-var-VE3-elementvariable $f #ElementVariable kore-element-var-VE3 $.
kore-element-var-VE4-elementvariable $f #ElementVariable kore-element-var-VE4 $.
IMP-sort-9-is-pattern $a #Pattern \kore-sort-SortStateCell $.
IMP-sort-31-is-pattern $a #Pattern \kore-sort-SortStmt $.
IMP-sort-31-sort $a |- ( \kore-is-sort \kore-sort-SortStmt ) $.
kore-element-var-VE5-elementvariable $f #ElementVariable kore-element-var-VE5 $.
typecode-cache-Pattern-178 $a #Pattern kore-element-var-VE3 $.
typecode-cache-Pattern-324 $a #Pattern ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortAExp ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) \top ) ) $.
${ sorting-cache-2055 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortAExp ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) \top ) ) ) ( \and ( \kore-is-sort \kore-sort-SortStmt ) ( \kore-is-sort \kore-sort-SortKItem ) ) ) $= ( kore-is-sort-is-pattern typecode-cache-Pattern-178 IMP-sort-9-is-pattern in-sort-is-pattern typecode-cache-Pattern-324 and-is-pattern IMP-sort-31-is-pattern BASIC-K-sort-1-is-pattern imp-is-pattern proof-rule-prop-1 proof-rule-mp IMP-sort-31-sort BASIC-K-sort-1-sort rule-and-intro-alt2-sugar ) AEFGBCHIJDKDJDAEFGBCHIJDLJDAEFGBCHIMONKDAEFGBCHIKDLKDAEFGBCHIMPNQ $. $}
