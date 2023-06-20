$c #Notation \iff #SetVariable #ElementVariable #Symbol #Variable #Pattern \and \imp |- ) ( $.
$v ph0 ph2 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
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
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
iff-is-pattern $a #Pattern ( \iff ph0 ph1 ) $.
iff-is-sugar $a #Notation ( \iff ph0 ph1 ) ( \and ( \imp ph0 ph1 ) ( \imp ph1 ph0 ) ) $.
${ rule-and-intro-sugar.0 $e |- ph0 $.
   rule-and-intro-sugar.1 $e |- ph1 $.
   rule-and-intro-sugar $a |- ( \and ph0 ph1 ) $. $}
${ rule-iff-intro.0 $e |- ( \imp ph0 ph1 ) $.
   rule-iff-intro.1 $e |- ( \imp ph1 ph0 ) $.
   rule-iff-intro $p |- ( \iff ph0 ph1 ) $= ( imp-is-pattern and-is-pattern iff-is-pattern rule-and-intro-sugar iff-is-sugar notation-reflexivity notation-symmetry notation-transitivity notation-proof ) ABEBAEFABGABEBAECDHABGABEBAEFABEBAEFABIABEBAEFABEBAEFABEBAEFJKLM $. $}
