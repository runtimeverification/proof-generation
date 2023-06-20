$c #SetVariable #ElementVariable #Symbol #Variable #Pattern \imp |- \bot ) ( $.
$v ph0 ph2 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
bot-is-pattern $a #Pattern \bot $.
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
${ proof-rule-mp.0 $e |- ( \imp ph0 ph1 ) $.
   proof-rule-mp.1 $e |- ph0 $.
   proof-rule-mp $a |- ph1 $. $}
imp-reflexivity $a |- ( \imp ph0 ph0 ) $.
imp-transitivity $a |- ( \imp ( \imp ph0 ph1 ) ( \imp ( \imp ph1 ph2 ) ( \imp ph0 ph2 ) ) ) $.
not-elim $a |- ( \imp ph0 ( \imp ( \imp ph0 \bot ) \bot ) ) $.
contrapositive $a |- ( \imp ( \imp ph0 ph1 ) ( \imp ( \imp ph1 \bot ) ( \imp ph0 \bot ) ) ) $.
not-elim-alt $a |- ( \imp ( \imp ph0 \bot ) ( \imp ph0 ph1 ) ) $.
or-elim $a |- ( \imp ( \imp ph0 ph2 ) ( \imp ( \imp ph1 ph2 ) ( \imp ( \imp ( \imp ph0 \bot ) ph1 ) ph2 ) ) ) $.
${ rule-and-intro-alt.0 $e |- ph0 $.
   rule-and-intro-alt $p |- ( \imp ph1 ( \imp ( \imp ( \imp ( \imp ph0 \bot ) \bot ) ( \imp ph1 \bot ) ) \bot ) ) $= ( imp-is-pattern bot-is-pattern proof-rule-mp not-elim imp-transitivity contrapositive or-elim not-elim-alt imp-reflexivity ) BEDEDAEDEDBEDDEDDBAEDEDBEDDEDDBBEDEDDBEDEDAEDEDBEDDEDDBAEDEDBEDDEDDDBBEDEDAEDEDBEDDEDHBGFAEDEDBEDDBEDDBEDEDAEDEDBEDDEDDAEDEDBEDDBEDIBEDBEDDAEDEDBEDDBEDDAEDBEDDBEDBEDDAEDEDBEDDBEDDDAEDBEDBEDJAEDEDAEDBEDDAEDBEDKAAEDEDAGCFFFBEDLFFF $. $}
