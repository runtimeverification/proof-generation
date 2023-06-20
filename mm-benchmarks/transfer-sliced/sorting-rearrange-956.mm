$c \top "balanceSender" \kore-sort-SortAExp #Variable \imp \kore-dv \kore-is-sort |- \kore-sort-SortId \kore-valid ) \kore-equals \and #SetVariable #ElementVariable #Symbol #Pattern \kore-sort-SortKItem \kore-inj ( $.
$v kore-sort-var-R ph0 ph2 th0 ph3 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
th0-is-pattern $f #Pattern th0 $.
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
kore-equals-is-pattern $a #Pattern ( \kore-equals ph0 ph1 ph2 ph3 ) $.
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
${ kore-equals-symmetry.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-equals ph1 ph0 ph3 ph2 ) ) ) $.
   kore-equals-symmetry $a |- ( \imp th0 ( \kore-valid ph0 ( \kore-equals ph1 ph0 ph2 ph3 ) ) ) $. $}
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
string-literal-10-is-pattern $a #Pattern "balanceSender" $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
sorting-cache-133 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ) $.
sorting-rearrange-16 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-valid kore-sort-var-R ( \kore-equals \kore-sort-SortKItem kore-sort-var-R ( \kore-inj \kore-sort-SortAExp \kore-sort-SortKItem ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ) ) ) $.
${ sorting-rearrange-956 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-valid kore-sort-var-R ( \kore-equals \kore-sort-SortKItem kore-sort-var-R ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortAExp \kore-sort-SortKItem ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ) ) ) ) $= ( and-is-pattern top-is-pattern typecode-cache-Pattern-0 kore-is-sort-is-pattern IMP-sort-17-is-pattern BASIC-K-sort-1-is-pattern kore-inj-is-pattern string-literal-10-is-pattern kore-dv-is-pattern IMP-sort-13-is-pattern rule-imp-transitivity rule-and-intro-alt2-sugar kore-equals-is-pattern kore-valid-is-pattern sorting-cache-133 top-intro rule-weakening and-elim-left-sugar imp-reflexivity sorting-rearrange-16 kore-equals-symmetry ) ADECBADECBADECBCBBADGADFGFIJHKGFKFIJHHNOADECBADECBADECBCBAPADECBADECBCAPADECBCQRMMADGFGFIJHKGFKFIJHHADECBADECBCBBADECBADECBCBBADECBADGADKGFKFIJHHFGFIJHNOADECBADECBCBBADECADECBADECBCBBADECBADEADECBADECBCBSADECBADEADEADECSADETLLADECBADECBCBBCQRMAUALUBL $. $}
