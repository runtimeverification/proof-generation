$c \kore-sort-SortBExp \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \kore-sort-SortBlock \and \kore-sort-SortKItem \imp |- ) \in-sort ( $.
$v ph0 ph2 kore-element-var-VE6 kore-element-var-VE5 kore-element-var-VE4 ph1 $.
$d kore-element-var-VE6 kore-element-var-VE5 $.
$d kore-element-var-VE6 kore-element-var-VE4 $.
$d kore-element-var-VE5 kore-element-var-VE4 $.
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
and-elim-right-sugar $a |- ( \imp ( \and ph0 ph1 ) ph1 ) $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
${ rule-weakening.0 $e |- ph1 $.
   rule-weakening $a |- ( \imp ph0 ph1 ) $. $}
kore-element-var-VE4-elementvariable $f #ElementVariable kore-element-var-VE4 $.
IMP-sort-18-is-pattern $a #Pattern \kore-sort-SortBlock $.
IMP-sort-22-is-pattern $a #Pattern \kore-sort-SortBExp $.
kore-element-var-VE5-elementvariable $f #ElementVariable kore-element-var-VE5 $.
kore-element-var-VE6-elementvariable $f #ElementVariable kore-element-var-VE6 $.
typecode-cache-Pattern-179 $a #Pattern kore-element-var-VE4 $.
typecode-cache-Pattern-356 $a #Pattern kore-element-var-VE6 $.
typecode-cache-Pattern-357 $a #Pattern ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE6 \kore-sort-SortBlock ) \top ) ) $.
sorting-cache-1706 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE6 \kore-sort-SortBlock ) \top ) ) ( \in-sort kore-element-var-VE6 \kore-sort-SortBlock ) ) $.
${ sorting-cache-1746 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortBExp ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE6 \kore-sort-SortBlock ) \top ) ) ) ( \and ( \in-sort kore-element-var-VE6 \kore-sort-SortBlock ) \top ) ) $= ( in-sort-is-pattern typecode-cache-Pattern-357 typecode-cache-Pattern-179 IMP-sort-22-is-pattern and-is-pattern typecode-cache-Pattern-356 IMP-sort-18-is-pattern top-is-pattern and-elim-right-sugar sorting-cache-1706 rule-imp-transitivity top-intro rule-weakening rule-and-intro-alt2-sugar ) AFGDBCEHCIJDKAFGDBCEHBCECIJDAFGDBCELBCMNAFGDBCEHKOPQ $. $}
