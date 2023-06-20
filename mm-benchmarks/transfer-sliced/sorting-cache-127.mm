$c \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \and \imp \kore-is-sort |- ) ( $.
$v ph0 ph2 ph1 kore-sort-var-x0 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
imp-reflexivity $a |- ( \imp ph0 ph0 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
and-elim-left-sugar $a |- ( \imp ( \and ph0 ph1 ) ph0 ) $.
and-elim-right-sugar $a |- ( \imp ( \and ph0 ph1 ) ph1 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-sort-var-x0-elementvariable $f #ElementVariable kore-sort-var-x0 $.
typecode-cache-Pattern-14 $a #Pattern kore-sort-var-x0 $.
${ sorting-cache-127 $p |- ( \imp ( \and \top ( \and ( \kore-is-sort kore-sort-var-x0 ) \top ) ) ( \kore-is-sort kore-sort-var-x0 ) ) $= ( typecode-cache-Pattern-14 kore-is-sort-is-pattern top-is-pattern and-is-pattern rule-imp-transitivity and-elim-right-sugar and-elim-left-sugar imp-reflexivity ) DABCDEEABCDEABCDABCDEGABCDEABCABCABCDHABCIFF $. $}
