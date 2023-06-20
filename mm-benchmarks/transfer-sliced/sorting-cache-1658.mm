$c \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \and \imp |- ) \kore-sort-SortInt \in-sort \kore-sort-SortStateCell ( $.
$v kore-element-var-VE4 ph0 ph2 kore-element-var-VE3 ph1 $.
$d kore-element-var-VE3 kore-element-var-VE4 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
imp-reflexivity $a |- ( \imp ph0 ph0 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
and-elim-left-sugar $a |- ( \imp ( \and ph0 ph1 ) ph0 ) $.
kore-element-var-VE3-elementvariable $f #ElementVariable kore-element-var-VE3 $.
kore-element-var-VE4-elementvariable $f #ElementVariable kore-element-var-VE4 $.
IMP-sort-9-is-pattern $a #Pattern \kore-sort-SortStateCell $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
typecode-cache-Pattern-178 $a #Pattern kore-element-var-VE3 $.
typecode-cache-Pattern-179 $a #Pattern kore-element-var-VE4 $.
${ sorting-cache-1658 $p |- ( \imp ( \and ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortInt ) \top ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) \top ) ) ( \in-sort kore-element-var-VE4 \kore-sort-SortInt ) ) $= ( in-sort-is-pattern typecode-cache-Pattern-179 IMP-sort-23-is-pattern top-is-pattern and-is-pattern typecode-cache-Pattern-178 IMP-sort-9-is-pattern and-elim-left-sugar rule-imp-transitivity imp-reflexivity ) BDECFGAHICFGGBDECFGBDECBDECFGAHICFGJBDECFGBDECBDECBDECFJBDECLKK $. $}
