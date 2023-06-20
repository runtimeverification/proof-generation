$c #Notation #SetVariable #ElementVariable #Symbol \or #Variable #Pattern \imp |- \not ) ( $.
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
not-is-pattern $a #Pattern ( \not ph0 ) $.
or-is-pattern $a #Pattern ( \or ph0 ph1 ) $.
or-is-sugar $a #Notation ( \or ph0 ph1 ) ( \imp ( \not ph0 ) ph1 ) $.
imp-reflexivity $a |- ( \imp ph0 ph0 ) $.
${ rule-or-elim-alt-sugar.0 $e |- ( \imp ph0 ph2 ) $.
   rule-or-elim-alt-sugar.1 $e |- ( \imp ph1 ph2 ) $.
   rule-or-elim-alt-sugar.2 $e |- ( \or ph0 ph1 ) $.
   rule-or-elim-alt-sugar $a |- ph2 $. $}
${ rule-case.0 $e |- ( \imp ph0 ph1 ) $.
   rule-case.1 $e |- ( \imp ( \not ph0 ) ph1 ) $.
   rule-case $p |- ph1 $= ( not-is-pattern imp-is-pattern or-is-pattern imp-reflexivity or-is-sugar notation-reflexivity notation-symmetry notation-transitivity notation-proof rule-or-elim-alt-sugar ) AAEBCDAEAEFAAEGAEHAAEGAEAEFAEAEFAAEIAEAEFAEAEFAEAEFJKLMN $. $}
