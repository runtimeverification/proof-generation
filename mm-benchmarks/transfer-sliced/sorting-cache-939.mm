$c \top #SetVariable \kore-sort-SortAExp #ElementVariable #Symbol \kore-sort-SortStmt #Variable #Pattern \and \imp \kore-dv \kore-is-sort |- \kore-sort-SortId ) \kore-inj \in-sort \kore-sort-SortStateCell "balanceTo" ( $.
$v ph0 ph2 kore-element-var-VE3 kore-element-var-VE2 ptn1 kore-element-var-VE4 ptn2 ptn0 ph1 $.
$d kore-element-var-VE3 kore-element-var-VE4 $.
$d kore-element-var-VE4 kore-element-var-VE2 $.
$d kore-element-var-VE3 kore-element-var-VE2 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
proof-rule-prop-1 $a |- ( \imp ph0 ( \imp ph1 ph0 ) ) $.
${ proof-rule-mp.0 $e |- ( \imp ph0 ph1 ) $.
   proof-rule-mp.1 $e |- ph0 $.
   proof-rule-mp $a |- ph1 $. $}
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-dv-sorting $a |- ( \in-sort ( \kore-dv ph0 ph1 ) ph0 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
ptn0-pattern $f #Pattern ptn0 $.
ptn1-pattern $f #Pattern ptn1 $.
ptn2-pattern $f #Pattern ptn2 $.
kore-element-var-VE2-elementvariable $f #ElementVariable kore-element-var-VE2 $.
kore-element-var-VE3-elementvariable $f #ElementVariable kore-element-var-VE3 $.
kore-element-var-VE4-elementvariable $f #ElementVariable kore-element-var-VE4 $.
INJ-symbol-0-sorting $a |- ( \imp ( \and ( \and ( \kore-is-sort ptn0 ) ( \kore-is-sort ptn1 ) ) ( \in-sort ptn2 ptn0 ) ) ( \in-sort ( \kore-inj ptn0 ptn1 ptn2 ) ptn1 ) ) $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-31-is-pattern $a #Pattern \kore-sort-SortStmt $.
string-literal-17-is-pattern $a #Pattern "balanceTo" $.
typecode-cache-Pattern-177 $a #Pattern kore-element-var-VE2 $.
typecode-cache-Pattern-239 $a #Pattern ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortStmt ) \top ) ) $.
sorting-cache-931 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortStmt ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortStmt ) \top ) ) ) ( \and ( \kore-is-sort \kore-sort-SortId ) ( \kore-is-sort \kore-sort-SortAExp ) ) ) $.
${ sorting-cache-939 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortStmt ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortStmt ) \top ) ) ) ( \in-sort ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) \kore-sort-SortAExp ) ) $= ( IMP-sort-17-is-pattern in-sort-is-pattern string-literal-17-is-pattern and-is-pattern kore-dv-is-pattern IMP-sort-13-is-pattern typecode-cache-Pattern-177 IMP-sort-31-is-pattern typecode-cache-Pattern-239 kore-is-sort-is-pattern kore-inj-is-pattern sorting-cache-931 imp-is-pattern proof-rule-prop-1 kore-dv-sorting proof-rule-mp rule-and-intro-alt2-sugar INJ-symbol-0-sorting rule-imp-transitivity ) AJKEBCLGDMIMGDFHDEGDIDFHNIEAJKEBCLGDMIMGDFHDEABCODFHDEAJKEBCLGDFHDEPDFHDEAJKEBCLGQDFRSTDIDFHUAUB $. $}
