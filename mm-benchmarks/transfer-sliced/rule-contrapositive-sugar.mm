$c #Notation #SetVariable #ElementVariable #Symbol #Variable #Pattern \imp |- \bot \not ) ( $.
$v ph0 ph2 ph3 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
bot-is-pattern $a #Pattern \bot $.
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
notation-reflexivity $a #Notation ph0 ph0 $.
${ notation-symmetry.0 $e #Notation ph0 ph1 $.
   notation-symmetry $a #Notation ph1 ph0 $. $}
${ notation-transitivity.0 $e #Notation ph0 ph1 $.
   notation-transitivity.1 $e #Notation ph1 ph2 $.
   notation-transitivity $a #Notation ph0 ph2 $. $}
${ notation-proof.0 $e |- ph0 $.
   notation-proof.1 $e #Notation ph1 ph0 $.
   notation-proof $a |- ph1 $. $}
${ notation-imp.0 $e #Notation ph0 ph2 $.
   notation-imp.1 $e #Notation ph1 ph3 $.
   notation-imp $a #Notation ( \imp ph0 ph1 ) ( \imp ph2 ph3 ) $. $}
not-is-pattern $a #Pattern ( \not ph0 ) $.
not-is-sugar $a #Notation ( \not ph0 ) ( \imp ph0 \bot ) $.
${ rule-contrapositive.0 $e |- ( \imp ph0 ph1 ) $.
   rule-contrapositive $a |- ( \imp ( \imp ph1 \bot ) ( \imp ph0 \bot ) ) $. $}
${ rule-contrapositive-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-contrapositive-sugar $p |- ( \imp ( \not ph1 ) ( \not ph0 ) ) $= ( imp-is-pattern bot-is-pattern not-is-pattern not-is-sugar notation-reflexivity notation-symmetry notation-transitivity rule-contrapositive notation-imp notation-proof ) BEDAEDDBFAFDABCKBFAFBEDAEDBFBEDBEDBGBEDBEDBEDHIJAFAEDAEDAGAEDAEDAEDHIJLM $. $}
