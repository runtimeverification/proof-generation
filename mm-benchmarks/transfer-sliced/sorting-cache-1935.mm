$c \top #SetVariable \kore-sort-SortAExp #ElementVariable #Symbol #Variable #Pattern \and \kore-sort-SortK \imp |- \kore-sort-SortId ) \kore-sort-SortGeneratedCounterCell \in-sort \kore-sort-SortStateCell ( $.
$v ph0 ph2 kore-element-var-VE1 kore-element-var-VE3 kore-element-var-VE2 kore-element-var-VE4 kore-element-var-VE0 ph1 $.
$d kore-element-var-VE3 kore-element-var-VE1 $.
$d kore-element-var-VE3 kore-element-var-VE4 $.
$d kore-element-var-VE4 kore-element-var-VE2 $.
$d kore-element-var-VE2 kore-element-var-VE0 $.
$d kore-element-var-VE3 kore-element-var-VE0 $.
$d kore-element-var-VE0 kore-element-var-VE1 $.
$d kore-element-var-VE2 kore-element-var-VE1 $.
$d kore-element-var-VE4 kore-element-var-VE1 $.
$d kore-element-var-VE3 kore-element-var-VE2 $.
$d kore-element-var-VE4 kore-element-var-VE0 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
and-elim-left-sugar $a |- ( \imp ( \and ph0 ph1 ) ph0 ) $.
BASIC-K-sort-0-is-pattern $a #Pattern \kore-sort-SortK $.
kore-element-var-VE0-elementvariable $f #ElementVariable kore-element-var-VE0 $.
kore-element-var-VE2-elementvariable $f #ElementVariable kore-element-var-VE2 $.
kore-element-var-VE1-elementvariable $f #ElementVariable kore-element-var-VE1 $.
kore-element-var-VE3-elementvariable $f #ElementVariable kore-element-var-VE3 $.
kore-element-var-VE4-elementvariable $f #ElementVariable kore-element-var-VE4 $.
IMP-sort-10-is-pattern $a #Pattern \kore-sort-SortGeneratedCounterCell $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
typecode-cache-Pattern-146 $a #Pattern kore-element-var-VE1 $.
typecode-cache-Pattern-148 $a #Pattern kore-element-var-VE0 $.
typecode-cache-Pattern-177 $a #Pattern kore-element-var-VE2 $.
typecode-cache-Pattern-179 $a #Pattern kore-element-var-VE4 $.
typecode-cache-Pattern-397 $a #Pattern ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortId ) \top ) ) $.
sorting-cache-1934 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortK ) ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortAExp ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortId ) \top ) ) ) ) ( \in-sort kore-element-var-VE4 \kore-sort-SortId ) ) $.
${ sorting-cache-1935 $p |- ( \imp ( \and ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortK ) ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortAExp ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortId ) \top ) ) ) ) ( \and ( \in-sort kore-element-var-VE0 \kore-sort-SortGeneratedCounterCell ) \top ) ) ( \in-sort kore-element-var-VE4 \kore-sort-SortId ) ) $= ( in-sort-is-pattern and-is-pattern typecode-cache-Pattern-146 BASIC-K-sort-0-is-pattern typecode-cache-Pattern-177 IMP-sort-13-is-pattern typecode-cache-Pattern-397 typecode-cache-Pattern-148 IMP-sort-10-is-pattern top-is-pattern typecode-cache-Pattern-179 IMP-sort-17-is-pattern and-elim-left-sugar sorting-cache-1934 rule-imp-transitivity ) CHIFBJKFDELGGAMNFOGGCHIFBJKFDELGGEPQFCHIFBJKFDELGGAMNFOGRBCDEST $. $}
