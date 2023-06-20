$c \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \and \imp \kore-is-sort |- ) \in-sort \kore-sort-SortMap ( $.
$v kore-sort-var-R kore-element-var-V2 ph0 ph2 kore-element-var-V1 ph1 $.
$d kore-element-var-V2 kore-element-var-V1 $.
$d kore-sort-var-R kore-element-var-V2 $.
$d kore-sort-var-R kore-element-var-V1 $.
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
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
kore-element-var-V1-elementvariable $f #ElementVariable kore-element-var-V1 $.
kore-element-var-V2-elementvariable $f #ElementVariable kore-element-var-V2 $.
IMP-sort-14-is-pattern $a #Pattern \kore-sort-SortMap $.
typecode-cache-Pattern-35 $a #Pattern kore-element-var-V2 $.
typecode-cache-Pattern-36 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortMap ) \top ) ) $.
typecode-cache-Pattern-37 $a #Pattern kore-element-var-V1 $.
sorting-cache-260 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortMap ) \top ) ) ( \in-sort kore-element-var-V2 \kore-sort-SortMap ) ) $.
${ sorting-cache-261 $p |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortMap ) \top ) ) ( \and ( \in-sort kore-element-var-V1 \kore-sort-SortMap ) \top ) ) ( \and ( \in-sort kore-element-var-V1 \kore-sort-SortMap ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortMap ) \top ) ) ) $= ( IMP-sort-14-is-pattern in-sort-is-pattern typecode-cache-Pattern-37 and-is-pattern top-is-pattern typecode-cache-Pattern-36 typecode-cache-Pattern-35 rule-imp-transitivity and-elim-left-sugar rule-and-intro-alt2-sugar and-elim-right-sugar imp-reflexivity sorting-cache-260 top-intro rule-weakening ) ACIBFDEHGGBFDECJDEHGACIBFDEHGGBFDEHGBFDEACIBFDEHGNBFDEHGBFDEBFDEBFDEHLBFDEOKKACIBFDEHGGCJDEHACIBFDEHGGACICJDEACIBFDEHGLACPKACIBFDEHGGHQRMM $. $}
