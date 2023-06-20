$c #Notation #SetVariable #ElementVariable #Symbol #Variable #Pattern \kore-implies \kore-or \inh \and \kore-not \not ) \kore-top ( $.
$v ph0 ph2 ph3 ph4 ph5 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
ph4-is-pattern $f #Pattern ph4 $.
ph5-is-pattern $f #Pattern ph5 $.
${ notation-symmetry.0 $e #Notation ph0 ph1 $.
   notation-symmetry $a #Notation ph1 ph0 $. $}
${ notation-transitivity.0 $e #Notation ph0 ph1 $.
   notation-transitivity.1 $e #Notation ph1 ph2 $.
   notation-transitivity $a #Notation ph0 ph2 $. $}
not-is-pattern $a #Pattern ( \not ph0 ) $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
inh-is-pattern $a #Pattern ( \inh ph0 ) $.
${ notation-not.0 $e #Notation ph0 ph1 $.
   notation-not $a #Notation ( \not ph0 ) ( \not ph1 ) $. $}
${ notation-and.0 $e #Notation ph0 ph2 $.
   notation-and.1 $e #Notation ph1 ph3 $.
   notation-and $a #Notation ( \and ph0 ph1 ) ( \and ph2 ph3 ) $. $}
${ notation-inh.0 $e #Notation ph0 ph1 $.
   notation-inh $a #Notation ( \inh ph0 ) ( \inh ph1 ) $. $}
kore-top-is-pattern $a #Pattern ( \kore-top ph0 ) $.
kore-top-is-sugar $a #Notation ( \kore-top ph0 ) ( \inh ph0 ) $.
kore-not-is-pattern $a #Pattern ( \kore-not ph0 ph1 ) $.
kore-not-is-sugar $a #Notation ( \kore-not ph0 ph1 ) ( \and ( \not ph1 ) ( \kore-top ph0 ) ) $.
kore-or-is-pattern $a #Pattern ( \kore-or ph0 ph1 ph2 ) $.
kore-implies-is-pattern $a #Pattern ( \kore-implies ph0 ph1 ph2 ) $.
kore-implies-is-sugar $a #Notation ( \kore-implies ph0 ph1 ph2 ) ( \kore-or ph0 ( \kore-not ph0 ph1 ) ph2 ) $.
${ notation-kore-or.0 $e #Notation ph0 ph3 $.
   notation-kore-or.1 $e #Notation ph1 ph4 $.
   notation-kore-or.2 $e #Notation ph2 ph5 $.
   notation-kore-or $a #Notation ( \kore-or ph0 ph1 ph2 ) ( \kore-or ph3 ph4 ph5 ) $. $}
${ notation-kore-implies.0 $e #Notation ph0 ph3 $.
   notation-kore-implies.1 $e #Notation ph1 ph4 $.
   notation-kore-implies.2 $e #Notation ph2 ph5 $.
   notation-kore-implies $p #Notation ( \kore-implies ph0 ph1 ph2 ) ( \kore-implies ph3 ph4 ph5 ) $= ( kore-not-is-pattern kore-top-is-pattern not-is-pattern kore-or-is-pattern and-is-pattern inh-is-pattern notation-symmetry notation-transitivity kore-implies-is-pattern kore-implies-is-sugar kore-not-is-sugar kore-top-is-sugar notation-not notation-inh notation-and notation-kore-or ) ABCRAABJCMDEFRABCSDEFRAABJCMDEFRDDEJFMAABJCMDEFSAABJCMDDEJFMAABJCDDEJFGABJBLAKNDEJABTDEJBLAKNDEJELDKNBLAKNDETBLAKNELDKNBLAKELDKBEHUBAKAODKAUADKAODKDOAODUAAODOADGUCPQPQUDPQPQIUEPQPQ $. $}
