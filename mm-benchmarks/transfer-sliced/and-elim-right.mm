$c #SetVariable #ElementVariable #Symbol #Variable #Pattern \imp |- \bot ) ( $.
$v ph0 ph2 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
bot-is-pattern $a #Pattern \bot $.
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
proof-rule-prop-1 $a |- ( \imp ph0 ( \imp ph1 ph0 ) ) $.
proof-rule-prop-3 $a |- ( \imp ( \imp ( \imp ph0 \bot ) \bot ) ph0 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
${ rule-contrapositive.0 $e |- ( \imp ph0 ph1 ) $.
   rule-contrapositive $a |- ( \imp ( \imp ph1 \bot ) ( \imp ph0 \bot ) ) $. $}
${ and-elim-right $p |- ( \imp ( \imp ( \imp ( \imp ( \imp ph0 \bot ) \bot ) ( \imp ph1 \bot ) ) \bot ) ph1 ) $= ( imp-is-pattern bot-is-pattern proof-rule-prop-1 rule-contrapositive proof-rule-prop-3 rule-imp-transitivity ) ADCDCBDCCDCBDCDCBBDCADCDCBDCCBDCADCDCEFBGH $. $}
