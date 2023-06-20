$c \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \and \imp \kore-is-sort |- \kore-valid ) \kore-top ( $.
$v kore-sort-var-R ph0 ph2 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
imp-reflexivity $a |- ( \imp ph0 ph0 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
top-intro $a |- \top $.
and-elim-left-sugar $a |- ( \imp ( \and ph0 ph1 ) ph0 ) $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
${ rule-weakening.0 $e |- ph1 $.
   rule-weakening $a |- ( \imp ph0 ph1 ) $. $}
kore-valid-is-pattern $a #Pattern ( \kore-valid ph0 ph1 ) $.
kore-top-is-pattern $a #Pattern ( \kore-top ph0 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-top-valid $a |- ( \kore-valid ph0 ( \kore-top ph0 ) ) $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
${ sorting-rearrange-266 $p |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-top kore-sort-var-R ) ) ) $= ( typecode-cache-Pattern-0 and-is-pattern top-is-pattern kore-is-sort-is-pattern rule-imp-transitivity kore-top-is-pattern kore-valid-is-pattern and-elim-left-sugar rule-weakening imp-reflexivity top-intro rule-and-intro-alt2-sugar kore-top-valid ) ABEDCABEDCDCCABEDCABABGHABEDCABEDCDCCABEDABEDCABEDCDCCABEDCABEABEDCABEDCDCIABEDCABEABEABEDIABEKFFABEDCABEDCDCCDLJMABEDCABABGHABNJF $. $}
