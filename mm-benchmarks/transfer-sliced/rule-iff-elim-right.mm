$c #Notation \iff #SetVariable #ElementVariable #Symbol \or #Variable #Pattern \and \imp |- \bot \not ) ( $.
$v ph0 ph2 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
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
not-is-pattern $a #Pattern ( \not ph0 ) $.
not-is-sugar $a #Notation ( \not ph0 ) ( \imp ph0 \bot ) $.
or-is-pattern $a #Pattern ( \or ph0 ph1 ) $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
and-is-sugar $a #Notation ( \and ph0 ph1 ) ( \not ( \or ( \not ph0 ) ( \not ph1 ) ) ) $.
${ proof-rule-mp.0 $e |- ( \imp ph0 ph1 ) $.
   proof-rule-mp.1 $e |- ph0 $.
   proof-rule-mp $a |- ph1 $. $}
iff-is-pattern $a #Pattern ( \iff ph0 ph1 ) $.
iff-is-sugar $a #Notation ( \iff ph0 ph1 ) ( \and ( \imp ph0 ph1 ) ( \imp ph1 ph0 ) ) $.
and-elim-right-sugar $a |- ( \imp ( \and ph0 ph1 ) ph1 ) $.
${ rule-iff-elim-right.0 $e |- ( \iff ph0 ph1 ) $.
   rule-iff-elim-right $p |- ( \imp ph1 ph0 ) $= ( imp-is-pattern not-is-pattern or-is-pattern bot-is-pattern and-is-pattern notation-symmetry notation-transitivity iff-is-pattern and-is-sugar not-is-sugar and-elim-right-sugar iff-is-sugar notation-reflexivity notation-proof proof-rule-mp ) ABDBADHBADABDBADNABKABDBADHCABDBADHABDEBADEFEABKABDBADLABKABDEBADEFEABKABDBADHABDEBADEFEABOABDEBADEFEABDBADHABDEBADEFEABDEBADEFGDABDBADHABDEBADEFMABDBADHABDEBADEFGDABDBADHABDEBADEFEABDEBADEFGDABDBADLABDEBADEFGDABDEBADEFEABDEBADEFEABDEBADEFGDABDEBADEFEABDEBADEFGDABDEBADEFGDABDEBADEFMABDEBADEFGDABDEBADEFGDABDEBADEFGDPIJIIJIJIJIJQR $. $}
