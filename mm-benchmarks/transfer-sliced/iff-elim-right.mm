$c #Notation \iff #SetVariable #ElementVariable #Symbol #Variable #Pattern \imp ( |- ) \and $.
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
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
iff-is-pattern $a #Pattern ( \iff ph0 ph1 ) $.
iff-is-sugar $a #Notation ( \iff ph0 ph1 ) ( \and ( \imp ph0 ph1 ) ( \imp ph1 ph0 ) ) $.
and-elim-right-sugar $a |- ( \imp ( \and ph0 ph1 ) ph1 ) $.
${ iff-elim-right $p |- ( \imp ( \iff ph0 ph1 ) ( \imp ph1 ph0 ) ) $= ( imp-is-pattern and-is-pattern iff-is-pattern notation-reflexivity and-elim-right-sugar iff-is-sugar notation-symmetry notation-transitivity notation-imp notation-proof ) ABCBACDBACCABEBACCABCBACGABEBACABCBACDBACABEABCBACDABCBACDABHABCBACDABCBACDABCBACDFIJBACFKL $. $}
