$c \exists #Notation #SetVariable \ceil #ElementVariable #Symbol \sorted-exists #Variable #Pattern \included \inh \and \definedness \imp \app |- ) \in-sort \in ( $.
$v ph0 xX ph2 x sg0 y ph3 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
x-is-element-var $f #ElementVariable x $.
y-is-element-var $f #ElementVariable y $.
xX-is-var $f #Variable xX $.
sg0-is-symbol $f #Symbol sg0 $.
element-var-is-var $a #Variable x $.
var-is-pattern $a #Pattern xX $.
symbol-is-pattern $a #Pattern sg0 $.
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
app-is-pattern $a #Pattern ( \app ph0 ph1 ) $.
exists-is-pattern $a #Pattern ( \exists x ph0 ) $.
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
definedness-is-symbol $a #Symbol \definedness $.
ceil-is-pattern $a #Pattern ( \ceil ph0 ) $.
ceil-is-sugar $a #Notation ( \ceil ph0 ) ( \app \definedness ph0 ) $.
in-is-pattern $a #Pattern ( \in x ph0 ) $.
in-is-sugar $a #Notation ( \in x ph0 ) ( \ceil ( \and x ph0 ) ) $.
included-is-pattern $a #Pattern ( \included ph0 ph1 ) $.
inh-is-pattern $a #Pattern ( \inh ph0 ) $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
in-sort-is-sugar $a #Notation ( \in-sort ph0 ph1 ) ( \included ph0 ( \inh ph1 ) ) $.
sorted-exists-is-pattern $a #Pattern ( \sorted-exists x ph0 ph1 ) $.
sorted-exists-is-sugar $a #Notation ( \sorted-exists x ph0 ph1 ) ( \exists x ( \and ( \in-sort x ph0 ) ph1 ) ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
and-elim-left-sugar $a |- ( \imp ( \and ph0 ph1 ) ph0 ) $.
and-elim-right-sugar $a |- ( \imp ( \and ph0 ph1 ) ph1 ) $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
${ lemma-imp-compat-in-exists.0 $e |- ( \imp ph0 ph1 ) $.
   lemma-imp-compat-in-exists $a |- ( \imp ( \exists x ph0 ) ( \exists x ph1 ) ) $. $}
include-imp-in $a |- ( \imp ( \included x ph0 ) ( \in x ph0 ) ) $.
${ $d y ph0 $.
   membership-symbol-ceil-right-aux-0 $a |- ( \imp ( \exists y ( \and ( \ceil ( \and y ph0 ) ) y ) ) ph0 ) $. $}
${ $d x ph0 $.
   sorted-exists-to-inh $p |- ( \imp ( \sorted-exists x ph0 x ) ( \inh ph0 ) ) $= ( element-var-is-var var-is-pattern inh-is-pattern and-is-pattern in-sort-is-pattern ceil-is-pattern definedness-is-symbol symbol-is-pattern app-is-pattern exists-is-pattern included-is-pattern notation-symmetry in-is-pattern notation-transitivity imp-is-pattern notation-reflexivity sorted-exists-is-pattern ceil-is-sugar notation-imp notation-proof rule-imp-transitivity and-elim-left-sugar include-imp-in in-sort-is-sugar in-is-sugar and-elim-right-sugar rule-and-intro-alt2-sugar lemma-imp-compat-in-exists membership-symbol-ceil-right-aux-0 sorted-exists-is-sugar ) BCDAGBCDFBLAEQABCDBSAEQBCDAGBCDFBLBCDAEFHBCDFBLAEBCDAGBCDFBCDAEFHBCDFBBCDAGBCDFBCDAEFHBCDBCDAGBCDFBCDAGBCDAEFHBCDAGBCDUDBCDAEMAEBOQBCDAGBCDAEFHQAEBUEBCDAGBCDAEFHBCDAEMAEBOBCDAGBCDAEMBCDAEMBCDAUFBCDAEMBCDAEMBCDAEMRNPBCDAEFHIJBCDAEFKAEBOBCDAEFTAEBOIJBCDAEFKAEBOBCDAEFHIJBCDAEFKAEBUGIJBCDAEFKBCDAEFHBCDAEFHIJBCDAEFKBCDAEFHIJBCDAEFKIJBCDAEFKBCDAEFTIJBCDAEFKIJBCDAEFKIJBCDAEFKRNPNNPNPUAUBUCBCDAGBCDUHUIUJAEBUKUCABCDBSAEBCDAGBCDFBLAEABCDBSBCDAGBCDFBLBCDAGBCDFBLABCDBULBCDAGBCDFBLBCDAGBCDFBLBCDAGBCDFBLRNPAERUAUB $. $}
