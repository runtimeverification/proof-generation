$c #Notation \iff \top #SetVariable #ElementVariable #Symbol \or #Variable #Pattern \imp |- \bot \not ) ( $.
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
or-is-pattern $a #Pattern ( \or ph0 ph1 ) $.
or-is-sugar $a #Notation ( \or ph0 ph1 ) ( \imp ( \not ph0 ) ph1 ) $.
proof-rule-prop-1 $a |- ( \imp ph0 ( \imp ph1 ph0 ) ) $.
proof-rule-prop-3 $a |- ( \imp ( \imp ( \imp ph0 \bot ) \bot ) ph0 ) $.
${ proof-rule-mp.0 $e |- ( \imp ph0 ph1 ) $.
   proof-rule-mp.1 $e |- ph0 $.
   proof-rule-mp $a |- ph1 $. $}
top-is-pattern $a #Pattern \top $.
top-intro $a |- \top $.
${ rule-iff-intro.0 $e |- ( \imp ph0 ph1 ) $.
   rule-iff-intro.1 $e |- ( \imp ph1 ph0 ) $.
   rule-iff-intro $a |- ( \iff ph0 ph1 ) $. $}
${ or-complement $p |- ( \iff ( \or ( \not ph0 ) ph0 ) \top ) $= ( imp-is-pattern bot-is-pattern not-is-pattern or-is-pattern top-is-pattern notation-symmetry notation-reflexivity notation-transitivity proof-rule-prop-1 proof-rule-mp not-is-sugar notation-imp top-intro proof-rule-prop-3 or-is-sugar notation-proof rule-iff-intro ) ADAEFFADAEFBFADAEJNKADAEFADAEBADAEFJACBCBABADAEAOADAEADDABACBCBABADAPACBCBABADDABACBCBAADDAADDACBCBADDADCBACBCBADLACBCBADCBACBCADCADACBADACBACBALACBACBACBHGIGCHMGIGAHMGIQKR $. $}
