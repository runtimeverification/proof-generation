$c #Notation #SetVariable #ElementVariable #Symbol #Variable #Pattern \inh \and \kore-not \not ) \kore-top ( $.
$v ph0 ph2 ph3 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
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
${ notation-kore-not.0 $e #Notation ph0 ph2 $.
   notation-kore-not.1 $e #Notation ph1 ph3 $.
   notation-kore-not $p #Notation ( \kore-not ph0 ph1 ) ( \kore-not ph2 ph3 ) $= ( kore-top-is-pattern not-is-pattern kore-not-is-pattern and-is-pattern inh-is-pattern notation-transitivity kore-not-is-sugar kore-top-is-sugar notation-symmetry notation-not notation-inh notation-and ) ABIBHAGJCDIABMBHAGJDHCGJCDIBHAGDHCGBDFPAGAKCGANAKCKCGACEQCGCKCNOLLRCDIDHCGJCDMOLL $. $}
