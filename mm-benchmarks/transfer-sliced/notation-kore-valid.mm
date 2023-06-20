$c #Notation #SetVariable #ElementVariable #Symbol \eq #Variable #Pattern \inh \kore-valid ) \kore-top ( $.
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
eq-is-pattern $a #Pattern ( \eq ph0 ph1 ) $.
inh-is-pattern $a #Pattern ( \inh ph0 ) $.
${ notation-eq.0 $e #Notation ph0 ph2 $.
   notation-eq.1 $e #Notation ph1 ph3 $.
   notation-eq $a #Notation ( \eq ph0 ph1 ) ( \eq ph2 ph3 ) $. $}
${ notation-inh.0 $e #Notation ph0 ph1 $.
   notation-inh $a #Notation ( \inh ph0 ) ( \inh ph1 ) $. $}
kore-valid-is-pattern $a #Pattern ( \kore-valid ph0 ph1 ) $.
kore-valid-is-sugar $a #Notation ( \kore-valid ph0 ph1 ) ( \eq ph1 ( \kore-top ph0 ) ) $.
kore-top-is-pattern $a #Pattern ( \kore-top ph0 ) $.
kore-top-is-sugar $a #Notation ( \kore-top ph0 ) ( \inh ph0 ) $.
${ notation-kore-valid.0 $e #Notation ph0 ph2 $.
   notation-kore-valid.1 $e #Notation ph1 ph3 $.
   notation-kore-valid $p #Notation ( \kore-valid ph0 ph1 ) ( \kore-valid ph2 ph3 ) $= ( kore-top-is-pattern eq-is-pattern inh-is-pattern kore-valid-is-pattern notation-symmetry notation-transitivity kore-valid-is-sugar kore-top-is-sugar notation-inh notation-eq ) ABJBAGHCDJABMCDJBAGHCDJDCGHBAGHCDMBAGHDCGHBAGDCGFAGAICGANCGAICGCIAICNAICIACEOKLKLPKLKL $. $}
