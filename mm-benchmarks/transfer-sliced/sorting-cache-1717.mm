$c \kore-sort-SortBExp \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \kore-sort-SortBlock \and \kore-sort-SortK \imp \kore-sort-SortKItem |- ) \in-sort \kore-sort-SortStateCell ( $.
$v ph0 ph2 kore-element-var-VE1 kore-element-var-VE3 kore-element-var-VE2 kore-element-var-VE6 kore-element-var-VE5 kore-element-var-VE4 ph1 $.
$d kore-element-var-VE3 kore-element-var-VE1 $.
$d kore-element-var-VE3 kore-element-var-VE4 $.
$d kore-element-var-VE6 kore-element-var-VE2 $.
$d kore-element-var-VE5 kore-element-var-VE2 $.
$d kore-element-var-VE6 kore-element-var-VE1 $.
$d kore-element-var-VE4 kore-element-var-VE2 $.
$d kore-element-var-VE6 kore-element-var-VE3 $.
$d kore-element-var-VE6 kore-element-var-VE5 $.
$d kore-element-var-VE6 kore-element-var-VE4 $.
$d kore-element-var-VE5 kore-element-var-VE4 $.
$d kore-element-var-VE2 kore-element-var-VE1 $.
$d kore-element-var-VE4 kore-element-var-VE1 $.
$d kore-element-var-VE5 kore-element-var-VE3 $.
$d kore-element-var-VE3 kore-element-var-VE2 $.
$d kore-element-var-VE5 kore-element-var-VE1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
imp-reflexivity $a |- ( \imp ph0 ph0 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
and-elim-left-sugar $a |- ( \imp ( \and ph0 ph1 ) ph0 ) $.
and-elim-right-sugar $a |- ( \imp ( \and ph0 ph1 ) ph1 ) $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
BASIC-K-sort-0-is-pattern $a #Pattern \kore-sort-SortK $.
kore-element-var-VE2-elementvariable $f #ElementVariable kore-element-var-VE2 $.
kore-element-var-VE1-elementvariable $f #ElementVariable kore-element-var-VE1 $.
kore-element-var-VE3-elementvariable $f #ElementVariable kore-element-var-VE3 $.
kore-element-var-VE4-elementvariable $f #ElementVariable kore-element-var-VE4 $.
IMP-sort-9-is-pattern $a #Pattern \kore-sort-SortStateCell $.
IMP-sort-18-is-pattern $a #Pattern \kore-sort-SortBlock $.
IMP-sort-22-is-pattern $a #Pattern \kore-sort-SortBExp $.
kore-element-var-VE5-elementvariable $f #ElementVariable kore-element-var-VE5 $.
kore-element-var-VE6-elementvariable $f #ElementVariable kore-element-var-VE6 $.
typecode-cache-Pattern-146 $a #Pattern kore-element-var-VE1 $.
typecode-cache-Pattern-177 $a #Pattern kore-element-var-VE2 $.
typecode-cache-Pattern-178 $a #Pattern kore-element-var-VE3 $.
typecode-cache-Pattern-179 $a #Pattern kore-element-var-VE4 $.
typecode-cache-Pattern-357 $a #Pattern ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE6 \kore-sort-SortBlock ) \top ) ) $.
sorting-cache-1699 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortBlock ) ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortK ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortBExp ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE6 \kore-sort-SortBlock ) \top ) ) ) ) ) ) ( \in-sort kore-element-var-VE4 \kore-sort-SortBExp ) ) $.
sorting-cache-1716 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortBlock ) ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortK ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortBExp ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE6 \kore-sort-SortBlock ) \top ) ) ) ) ) ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE6 \kore-sort-SortBlock ) \top ) ) ) $.
${ sorting-cache-1717 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortBlock ) ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortK ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortBExp ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE6 \kore-sort-SortBlock ) \top ) ) ) ) ) ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortBExp ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE6 \kore-sort-SortBlock ) \top ) ) ) ) ) $= ( in-sort-is-pattern and-is-pattern typecode-cache-Pattern-178 IMP-sort-9-is-pattern typecode-cache-Pattern-179 IMP-sort-22-is-pattern typecode-cache-Pattern-357 typecode-cache-Pattern-177 BASIC-K-sort-0-is-pattern typecode-cache-Pattern-146 IMP-sort-18-is-pattern rule-imp-transitivity and-elim-right-sugar rule-and-intro-alt2-sugar and-elim-left-sugar imp-reflexivity sorting-cache-1699 sorting-cache-1716 ) BPQGANOGCIJGDKLGEFMHHHHCIJGDKLGEFMHBPQGANOGCIJGDKLGEFMHHHHANOGCIJGDKLGEFMHHHCIJGBPQGANOGCIJGDKLGEFMHHHSANOGCIJGDKLGEFMHHHCIJGDKLGEFMHHCIJGANOGCIJGDKLGEFMHHSCIJGDKLGEFMHHCIJGCIJGCIJGDKLGEFMHUACIJGUBRRRBPQGANOGCIJGDKLGEFMHHHHDKLGEFMABCDEFUCABCDEFUDTT $. $}
