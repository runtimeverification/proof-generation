$c \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \and \kore-sort-SortK \imp \kore-is-sort |- ) \in-sort ( $.
$v kore-sort-var-R ph0 ph2 kore-element-var-VE1 kore-element-var-VE0 ph1 $.
$d kore-sort-var-R kore-element-var-VE1 $.
$d kore-sort-var-R kore-element-var-VE0 $.
$d kore-element-var-VE0 kore-element-var-VE1 $.
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
top-intro $a |- \top $.
and-elim-left-sugar $a |- ( \imp ( \and ph0 ph1 ) ph0 ) $.
and-elim-right-sugar $a |- ( \imp ( \and ph0 ph1 ) ph1 ) $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
${ rule-weakening.0 $e |- ph1 $.
   rule-weakening $a |- ( \imp ph0 ph1 ) $. $}
BASIC-K-sort-0-is-pattern $a #Pattern \kore-sort-SortK $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
kore-element-var-VE0-elementvariable $f #ElementVariable kore-element-var-VE0 $.
kore-element-var-VE1-elementvariable $f #ElementVariable kore-element-var-VE1 $.
typecode-cache-Pattern-146 $a #Pattern kore-element-var-VE1 $.
typecode-cache-Pattern-148 $a #Pattern kore-element-var-VE0 $.
typecode-cache-Pattern-277 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortK ) \top ) ) $.
sorting-cache-1175 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortK ) \top ) ) ( \in-sort kore-element-var-VE1 \kore-sort-SortK ) ) $.
${ sorting-cache-1176 $p |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortK ) \top ) ) ( \and ( \in-sort kore-element-var-VE0 \kore-sort-SortK ) \top ) ) ( \and ( \in-sort kore-element-var-VE0 \kore-sort-SortK ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortK ) \top ) ) ) $= ( BASIC-K-sort-0-is-pattern in-sort-is-pattern typecode-cache-Pattern-148 and-is-pattern top-is-pattern typecode-cache-Pattern-277 typecode-cache-Pattern-146 rule-imp-transitivity and-elim-left-sugar rule-and-intro-alt2-sugar and-elim-right-sugar imp-reflexivity sorting-cache-1175 top-intro rule-weakening ) ACIBFDEHGGBFDECJDEHGACIBFDEHGGBFDEHGBFDEACIBFDEHGNBFDEHGBFDEBFDEBFDEHLBFDEOKKACIBFDEHGGCJDEHACIBFDEHGGACICJDEACIBFDEHGLACPKACIBFDEHGGHQRMM $. $}
