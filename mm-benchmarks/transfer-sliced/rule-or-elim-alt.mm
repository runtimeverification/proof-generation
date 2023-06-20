$c #SetVariable #ElementVariable #Symbol #Variable #Pattern \imp |- \bot ) ( $.
$v ph2 ph0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
bot-is-pattern $a #Pattern \bot $.
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
${ proof-rule-mp.0 $e |- ( \imp ph0 ph1 ) $.
   proof-rule-mp.1 $e |- ph0 $.
   proof-rule-mp $a |- ph1 $. $}
imp-transitivity $a |- ( \imp ( \imp ph0 ph1 ) ( \imp ( \imp ph1 ph2 ) ( \imp ph0 ph2 ) ) ) $.
contrapositive $a |- ( \imp ( \imp ph0 ph1 ) ( \imp ( \imp ph1 \bot ) ( \imp ph0 \bot ) ) ) $.
peirce-bot $a |- ( \imp ( \imp ( \imp ph0 \bot ) ph0 ) ph0 ) $.
${ rule-or-elim-alt.0 $e |- ( \imp ph0 ph2 ) $.
   rule-or-elim-alt.1 $e |- ( \imp ph1 ph2 ) $.
   rule-or-elim-alt.2 $e |- ( \imp ( \imp ph0 \bot ) ph1 ) $.
   rule-or-elim-alt $p |- ph2 $= ( imp-is-pattern bot-is-pattern proof-rule-mp imp-transitivity peirce-bot contrapositive ) CHGCGCCKAHGCGCHGCGCHGAHGGAHGCGCHGCGGCHGAHGCJACGCHGAHGGACLDIIBCGAHGCGAHGBGBCGAHGCGGAHGBCJFIEIII $. $}
