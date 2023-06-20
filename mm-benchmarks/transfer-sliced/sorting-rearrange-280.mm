$c \kore-and \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \and \imp \kore-is-sort |- \kore-valid ) \in-sort \kore-top ( $.
$v kore-sort-var-R ph0 ph2 th0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
th0-is-pattern $f #Pattern th0 $.
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
proof-rule-prop-1 $a |- ( \imp ph0 ( \imp ph1 ph0 ) ) $.
${ proof-rule-mp.0 $e |- ( \imp ph0 ph1 ) $.
   proof-rule-mp.1 $e |- ph0 $.
   proof-rule-mp $a |- ph1 $. $}
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
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
kore-and-is-pattern $a #Pattern ( \kore-and ph0 ph1 ph2 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-top-sorting $a |- ( \in-sort ( \kore-top ph0 ) ph0 ) $.
kore-top-valid $a |- ( \kore-valid ph0 ( \kore-top ph0 ) ) $.
${ kore-and-intro-alt.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
   kore-and-intro-alt.1 $e |- ( \imp th0 ( \in-sort ph2 ph0 ) ) $.
   kore-and-intro-alt.2 $e |- ( \imp th0 ( \kore-valid ph0 ph1 ) ) $.
   kore-and-intro-alt.3 $e |- ( \imp th0 ( \kore-valid ph0 ph2 ) ) $.
   kore-and-intro-alt $a |- ( \imp th0 ( \kore-valid ph0 ( \kore-and ph0 ph1 ph2 ) ) ) $. $}
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
sorting-cache-133 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ) $.
${ sorting-rearrange-280 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-valid kore-sort-var-R ( \kore-and kore-sort-var-R ( \kore-top kore-sort-var-R ) ( \kore-top kore-sort-var-R ) ) ) ) $= ( and-is-pattern typecode-cache-Pattern-0 top-is-pattern kore-is-sort-is-pattern kore-top-is-pattern rule-imp-transitivity in-sort-is-pattern kore-valid-is-pattern rule-weakening rule-and-intro-alt2-sugar and-elim-left-sugar sorting-cache-133 top-intro imp-is-pattern proof-rule-prop-1 kore-top-sorting proof-rule-mp imp-reflexivity kore-top-valid kore-and-is-pattern kore-and-intro-alt ) ACEDBACEDBACEDBACEDBDBBBACACACFACFUAIACEDBACEDBACEDBACEDBDBBAMACEDBACEDBACEDBDBAMACEDBACEDBDAMACEDBDNJKKKACACFACFACEDBACEDBACEDBDBBBACFACHACEDBACEDBACEDBDBBBACFACHOACFACHACEDBACEDBACEDBDBBBPACQRACFACHACEDBACEDBACEDBDBBBACFACHOACFACHACEDBACEDBACEDBDBBBPACQRACEDBACEDBACEDBDBBBACEDBACACFIACEDBACEDBACEDBDBBBACEDACEDBACEDBACEDBDBBBACEDBACEACEDBACEDBACEDBDBBLACEDBACEACEACEDLACESGGACEDBACEDBACEDBDBBBDNJKACEDBACACFIACTJGACEDBACEDBACEDBDBBBACEDBACACFIACEDBACEDBACEDBDBBBACEDACEDBACEDBACEDBDBBBACEDBACEACEDBACEDBACEDBDBBLACEDBACEACEACEDLACESGGACEDBACEDBACEDBDBBBDNJKACEDBACACFIACTJGUBG $. $}
