$c #Notation #SetVariable #ElementVariable #Symbol \or #Variable #Pattern \imp ( |- \not ) \and $.
$v ph0 ph2 ph3 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
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
or-is-pattern $a #Pattern ( \or ph0 ph1 ) $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
and-is-sugar $a #Notation ( \and ph0 ph1 ) ( \not ( \or ( \not ph0 ) ( \not ph1 ) ) ) $.
${ rule-contrapositive-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-contrapositive-sugar $a |- ( \imp ( \not ph1 ) ( \not ph0 ) ) $. $}
${ rule-imp-compat-in-or.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-compat-in-or.1 $e |- ( \imp ph2 ph3 ) $.
   rule-imp-compat-in-or $a |- ( \imp ( \or ph0 ph2 ) ( \or ph1 ph3 ) ) $. $}
${ rule-imp-compat-in-and.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-compat-in-and.1 $e |- ( \imp ph2 ph3 ) $.
   rule-imp-compat-in-and $p |- ( \imp ( \and ph0 ph2 ) ( \and ph1 ph3 ) ) $= ( not-is-pattern or-is-pattern and-is-pattern rule-contrapositive-sugar imp-is-pattern and-is-sugar notation-reflexivity notation-symmetry notation-transitivity rule-imp-compat-in-or notation-imp notation-proof ) AGCGHGBGDGHGKACIBDIKBGDGHAGCGHBGAGDGCGABEJCDFJPJACIBDIAGCGHGBGDGHGACIAGCGHGAGCGHGACLAGCGHGAGCGHGAGCGHGMNOBDIBGDGHGBGDGHGBDLBGDGHGBGDGHGBGDGHGMNOQR $. $}
