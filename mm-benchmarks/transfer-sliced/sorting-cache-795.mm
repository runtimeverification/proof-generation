$c \top #SetVariable #ElementVariable #Symbol \kore-sort-SortStmt #Variable #Pattern \and \kore-sort-SortK \imp |- ) \kore-sort-SortGeneratedCounterCell \in-sort \kore-sort-SortStateCell ( $.
$v ph0 ph2 kore-element-var-VE1 kore-element-var-VE3 kore-element-var-VE2 kore-element-var-VE0 ph1 $.
$d kore-element-var-VE3 kore-element-var-VE1 $.
$d kore-element-var-VE2 kore-element-var-VE0 $.
$d kore-element-var-VE3 kore-element-var-VE0 $.
$d kore-element-var-VE0 kore-element-var-VE1 $.
$d kore-element-var-VE2 kore-element-var-VE1 $.
$d kore-element-var-VE3 kore-element-var-VE2 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
top-intro $a |- \top $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
${ rule-weakening.0 $e |- ph1 $.
   rule-weakening $a |- ( \imp ph0 ph1 ) $. $}
BASIC-K-sort-0-is-pattern $a #Pattern \kore-sort-SortK $.
kore-element-var-VE0-elementvariable $f #ElementVariable kore-element-var-VE0 $.
kore-element-var-VE2-elementvariable $f #ElementVariable kore-element-var-VE2 $.
kore-element-var-VE1-elementvariable $f #ElementVariable kore-element-var-VE1 $.
kore-element-var-VE3-elementvariable $f #ElementVariable kore-element-var-VE3 $.
IMP-sort-9-is-pattern $a #Pattern \kore-sort-SortStateCell $.
IMP-sort-10-is-pattern $a #Pattern \kore-sort-SortGeneratedCounterCell $.
typecode-cache-Pattern-146 $a #Pattern kore-element-var-VE1 $.
typecode-cache-Pattern-148 $a #Pattern kore-element-var-VE0 $.
typecode-cache-Pattern-178 $a #Pattern kore-element-var-VE3 $.
typecode-cache-Pattern-225 $a #Pattern ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortStmt ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) \top ) ) $.
sorting-cache-794 $a |- ( \imp ( \and ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortK ) ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortStmt ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) \top ) ) ) ( \and ( \in-sort kore-element-var-VE0 \kore-sort-SortGeneratedCounterCell ) \top ) ) ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ) $.
${ sorting-cache-795 $p |- ( \imp ( \and ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortK ) ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortStmt ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) \top ) ) ) ( \and ( \in-sort kore-element-var-VE0 \kore-sort-SortGeneratedCounterCell ) \top ) ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) \top ) ) $= ( and-is-pattern in-sort-is-pattern top-is-pattern typecode-cache-Pattern-146 BASIC-K-sort-0-is-pattern typecode-cache-Pattern-225 typecode-cache-Pattern-148 IMP-sort-10-is-pattern typecode-cache-Pattern-178 IMP-sort-9-is-pattern sorting-cache-794 top-intro rule-weakening rule-and-intro-alt2-sugar ) CHIFBDJEAKLFGEEDMNFGABCDOCHIFBDJEAKLFGEEGPQR $. $}
