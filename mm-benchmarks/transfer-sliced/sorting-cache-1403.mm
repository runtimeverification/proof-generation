$c \top #SetVariable \kore-sort-SortAExp #ElementVariable #Symbol #Variable #Pattern \and \kore-sort-SortKItem \imp \kore-is-sort |- \kore-sort-SortId ) \kore-sort-SortInt \in-sort \kore-sort-SortMap \kore-sort-SortStateCell ( $.
$v ph0 ph2 kore-element-var-VE3 kore-element-var-VE2 kore-element-var-VE5 kore-element-var-VE4 ph1 $.
$d kore-element-var-VE3 kore-element-var-VE4 $.
$d kore-element-var-VE5 kore-element-var-VE2 $.
$d kore-element-var-VE4 kore-element-var-VE2 $.
$d kore-element-var-VE5 kore-element-var-VE4 $.
$d kore-element-var-VE5 kore-element-var-VE3 $.
$d kore-element-var-VE3 kore-element-var-VE2 $.
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
kore-element-var-VE2-elementvariable $f #ElementVariable kore-element-var-VE2 $.
kore-element-var-VE3-elementvariable $f #ElementVariable kore-element-var-VE3 $.
kore-element-var-VE4-elementvariable $f #ElementVariable kore-element-var-VE4 $.
IMP-sort-9-is-pattern $a #Pattern \kore-sort-SortStateCell $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-13-sort $a |- ( \kore-is-sort \kore-sort-SortAExp ) $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-sort-23-sort $a |- ( \kore-is-sort \kore-sort-SortInt ) $.
kore-element-var-VE5-elementvariable $f #ElementVariable kore-element-var-VE5 $.
typecode-cache-Pattern-177 $a #Pattern kore-element-var-VE2 $.
typecode-cache-Pattern-178 $a #Pattern kore-element-var-VE3 $.
typecode-cache-Pattern-308 $a #Pattern ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortId ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortMap ) \top ) ) $.
${ sorting-cache-1403 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortId ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortMap ) \top ) ) ) ) ( \and ( \kore-is-sort \kore-sort-SortInt ) ( \kore-is-sort \kore-sort-SortAExp ) ) ) $= ( in-sort-is-pattern and-is-pattern kore-is-sort-is-pattern typecode-cache-Pattern-177 IMP-sort-9-is-pattern typecode-cache-Pattern-178 BASIC-K-sort-1-is-pattern typecode-cache-Pattern-308 IMP-sort-23-is-pattern IMP-sort-13-is-pattern imp-is-pattern proof-rule-prop-1 proof-rule-mp IMP-sort-23-sort IMP-sort-13-sort rule-and-intro-alt2-sugar ) AHIEBJKECDLFFMGNGMGAHIEBJKECDLFFMGOMGAHIEBJKECDLFFPRQNGAHIEBJKECDLFFNGONGAHIEBJKECDLFFPSQT $. $}
