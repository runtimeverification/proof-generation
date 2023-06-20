$c #SetVariable #ElementVariable #Symbol #Variable #Pattern \imp |- \bot ) ( $.
$v ph0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
bot-is-pattern $a #Pattern \bot $.
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
${ proof-rule-mp.0 $e |- ( \imp ph0 ph1 ) $.
   proof-rule-mp.1 $e |- ph0 $.
   proof-rule-mp $a |- ph1 $. $}
contrapositive $a |- ( \imp ( \imp ph0 ph1 ) ( \imp ( \imp ph1 \bot ) ( \imp ph0 \bot ) ) ) $.
${ rule-contrapositive.0 $e |- ( \imp ph0 ph1 ) $.
   rule-contrapositive $p |- ( \imp ( \imp ph1 \bot ) ( \imp ph0 \bot ) ) $= ( imp-is-pattern bot-is-pattern contrapositive proof-rule-mp ) ABDBEDAEDDABFCG $. $}
