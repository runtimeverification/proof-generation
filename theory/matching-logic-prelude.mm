$[ theory/matching-logic.mm $]

$( MATCHING LOGIC PRELUDE $)
$(
    Part 0. More Metavariables
    Part 1. More Syntactic Sugar for Vanilla Matching Logic
    Part 2. Definedness
    Part 3. Sorts and Inhabitants
    Part 4. Special Patterns (Singletons, Top, Bottom, Predicates)
    Part 5. Constant, Unary, and Binary Functions (internal use only)
    Part 6. Pairs
    Part 7. Tuples
    Part 8. Functions
$)

$( Part 0. More Metavariables $)

$v x0 x1 x2 x3 $.
x0-is-element-var $f #ElementVariable x0 $.
x1-is-element-var $f #ElementVariable x1 $.
x2-is-element-var $f #ElementVariable x2 $.
x3-is-element-var $f #ElementVariable x3 $.
$v s0 s1 s2 s3 $.
s0-is-element-var $f #ElementVariable s0 $.
s1-is-element-var $f #ElementVariable s1 $.
s2-is-element-var $f #ElementVariable s2 $.
s3-is-element-var $f #ElementVariable s3 $.


$( Part 1. More Syntactic Sugar for Vanilla Matching Logic $)

$c \top $.
top-is-pattern $a #Pattern \top $.
top-is-sugar   $a #Equal \top ( \not \bot ) $.

$c \iff $.
iff-is-pattern $a #Pattern ( \iff ph0 ph1 ) $.
iff-is-sugar   $a #Equal ( \iff ph0 ph1 ) ( \and ( \imp ph0 ph1 ) ( \imp ph1 ph0 ) ) $.

$c \forall $.
forall-is-pattern $a #Pattern ( \forall x ph0 ) $.
forall-is-sugar   $a #Equal ( \forall x ph0 ) ( \not ( \exists x ( \not ph0 ) ) ) $.

$c \nu $.
${
    nu-is-pattern.0 $e #Positive X ph0 $.
    nu-is-pattern   $a #Pattern ( \nu X ph0 ) $.
$}
${
    nu-is-sugar.0 $e #Substitution ph0 ph1 ( \not X ) X $.
    nu-is-sugar   $a #Equal ( \nu X ph1 ) ( \not ( \mu X ( \not ph0 ) ) ) $.
$}

$( Part 2. Definedness $)

$c \definedness $.
definedness-is-symbol $a #Symbol \definedness $.

$c \ceil $.
ceil-is-pattern $a #Pattern ( \ceil ph0 ) $.
ceil-is-sugar   $a #Equal ( \ceil ph0 ) ( \app \definedness ph0 ) $.

axiom-definedness $a |- ( \ceil x ) $.

$c \floor $.
floor-is-pattern $a #Pattern ( \floor ph0 ) $.
floor-is-sugar   $a #Equal ( \floor ph0 ) ( \not ( \ceil ( \not ph0 ) ) ) $.

$c \in $.
in-is-pattern $a #Pattern ( \in x ph0 ) $.
in-is-sugar   $a #Equal ( \in x ph0 ) ( \ceil ( \and x ph0 ) ) $.

$c \included $.
included-is-pattern $a #Pattern ( \included ph0 ph1 ) $.
included-is-sugar   $a #Equal ( \included ph0 ph1 ) ( \floor ( \imp ph0 ph1 ) ) $.

$c \eq $.
eq-is-pattern $a #Pattern ( \eq ph0 ph1 ) $.
eq-is-sugar   $a #Equal ( \eq ph0 ph1 ) ( \floor ( \iff ph0 ph1 ) ) $.

$( Part 3. Sorts and Inhabitants $)

$c \sort $.
sort-is-symbol $a #Symbol \sort $.

$c \inhabitant $.
inhabitant-is-symbol $a #Symbol \inhabitant $.

$c \inh $.
inh-is-pattern $a #Pattern ( \inh ph0 ) $.
inh-is-sugar   $a #Equal ( \inh ph0 ) ( \app \inhabitant ph0 ) $.

$c \in-sort $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
in-sort-is-sugar   $a #Equal ( \in-sort ph0 ph1 ) ( \included ph0 ( \inh ph1 ) ) $.

$c \sorted-forall $.
sorted-forall-is-pattern $a #Pattern ( \sorted-forall x ph0 ph1 ) $.
sorted-forall-is-sugar   $a #Equal ( \sorted-forall x ph0 ph1 ) ( \forall x ( \imp ( \in-sort x ph0 ) ph1 ) ) $. 

$c \sorted-exists $.
sorted-exists-is-pattern $a #Pattern ( \sorted-exists x ph0 ph1 ) $.
sorted-exists-is-sugar   $a #Equal ( \sorted-exists x ph0 ph1 ) ( \exists x ( \and ( \in-sort x ph0 ) ph1 ) ) $.

$c \forall-sort $.
forall-sort-is-pattern $a #Pattern ( \forall-sort s0 ph0 ) $.
forall-sort-is-sugar   $a #Equal ( \forall-sort s0 ph0 ) ( \sorted-forall s0 \sort ph0 ) $.

$c \exists-sort $.
exists-sort-is-pattern $a #Pattern ( \exists-sort s0 ph0 ) $.
exists-sort-is-sugar   $a #Equal ( \exists-sort s0 ph0 ) ( \sorted-exists s0 \sort ph0 ) $.

$( Part 4. Special Patterns (Singletons, Top, Bottom, Predicates $)

$c \is-singleton $.
is-singleton-is-pattern $a #Pattern ( \is-singleton ph0 ) $.
${
    $d x ph0 $.
    is-singleton-is-sugar $a #Equal ( \is-singleton ph0 ) ( \exists x ( \eq ph0 x ) ) $.
$}

$c \is-top $.
is-top-is-pattern $a #Pattern ( \is-top ph0 ) $.
is-top-is-sugar   $a #Equal ( \is-top ph0 ) ( \eq ph0 \top ) $.

$c \is-bot $.
is-bot-is-pattern $a #Pattern ( \is-bot ph0 ) $.
is-bot-is-sugar   $a #Equal ( \is-bot ph0 ) ( \eq ph0 \bot ) $.

$c \is-predicate $.
is-predicate-is-pattern $a #Pattern ( \is-predicate ph0 ) $.
is-predicate-is-sugar   $a #Equal ( \is-predicate ph0 ) ( \or ( \is-top ph0 ) ( \is-bot ph0 ) ) $.

$c \is-singleton-or-bot $.
is-singleton-or-bot-is-pattern $a #Pattern ( \is-singleton-or-bot ph0 ) $.
is-singleton-or-bot-is-sugar   $a #Equal ( \is-singleton-or-bot ph0 ) ( \or ( \is-singleton ph0 ) ( \is-bot ph0 ) ) $.

$( Part 5. Constant, Unary, and Binary Functions (internal use only) $)

$c \is-constant $.
is-constant-is-pattern $a #Pattern ( \is-constant ph0 ph1 ) $.
${
    $d x ph0 $.
    $d x ph1 $.
    is-constant-is-sugar $a #Equal ( \is-constant ph0 ph1 )
                                   ( \sorted-exists x ph1 ( \eq ph0 x ) ) $.
$}

$c \is-unary-function $.
is-unary-function-is-pattern $a #Pattern ( \is-unary-function ph0 ph1 ph2 ) $.
${
    $d x y ph0 $.
    $d x y ph1 $.
    $d x y ph2 $.
    is-unary-function-is-sugar $a #Equal ( \is-unary-function ph0 ph1 ph2 )
                                         ( \sorted-forall x ph1
                                         ( \sorted-exists y ph2 ( \eq ( \app ph0 x ) y ) ) ) $.
$}

$c \is-binary-function $.
is-binary-function-is-pattern $a #Pattern ( \is-binary-function ph0 ph1 ph2 ph3 ) $.
${
    $d x y z ph0 $.
    $d x y z ph1 $.
    $d x y z ph2 $.
    $d x y z ph3 $.
    is-binary-function-is-sugar $a #Equal ( \is-binary-function ph0 ph1 ph2 ph3 )
                                          ( \sorted-forall x ph1
                                          ( \sorted-forall y ph2
                                          ( \sorted-exists z ph3 ( \eq ( \app ph0 x y ) z ) ) ) ) $.
$}

$( Part 6. Pairs $)

$c \pair-sort-symbol $.
pair-sort-symbol-is-symbol $a #Symbol \pair-sort-symbol $.

axiom-pair-sort-is-sort $a |- ( \is-binary-function \pair-sort-symbol \sort \sort \sort ) $.

$c \pair-sort $.
pair-sort-is-pattern $a #Pattern ( \pair-sort ph0 ph1 ) $.
pair-sort-is-sugar   $a #Equal ( \pair-sort ph0 ph1 ) ( \app ( \app \pair-sort-symbol ph0 ) ph1 ) $.

$c \pair-symbol $.
pair-symbol-is-symbol $a #Symbol \pair-symbol $.

axiom-pair-symbol-is-binary-function
  $a ( \forall-sort s0 ( \forall-sort s1 ( \is-binary-function \pair-symbol s0 s1 ( \pair-sort s0 s1 ) ) ) ) $.

$c \pair $.
pair-is-pattern $a #Pattern ( \pair ph0 ph1 ) $.
pair-is-sugar   $a #Equal ( \pair ph0 ph1 ) ( \app ( \app \pair-symbol ph0 ) ph1 ) $.

$c \pair-fst-symbol $.
pair-fst-symbol-is-symbol $a #Symbol \pair-fst-symbol $.

axiom-pair-fst-symbol-is-unary-function 
  $a ( \forall-sort s0 ( \forall-sort s1 ( \is-unary-function \pair-fst-symbol ( \pair-sort s0 s1 ) s0 ) ) ) $.

$c \pair-fst $.
pair-fst-is-pattern $a #Pattern ( \pair-fst ph0 ) $.
pair-fst-is-sugar   $a #Equal ( \pair-fst ph0 ) ( \app \pair-fst-symbol ph0 ) $.

$c \pair-snd-symbol $.
pair-snd-symbol-is-symbol $a #Symbol \pair-snd-symbol $.

axiom-pair-snd-symbol-is-unary-function 
  $a ( \forall-sort s0 ( \forall-sort s1 ( \is-unary-function \pair-snd-symbol ( \pair-sort s0 s1 ) s1 ) ) ) $.

$c \pair-snd $.
pair-snd-is-pattern $a #Pattern ( \pair-snd ph0 ) $.
pair-snd-is-sugar   $a #Equal ( \pair-snd ph0 ) ( \app \pair-snd-symbol ph0 ) $.

axiom-pair-fst $a |- ( \forall-sort s0 ( \forall-sort s1 
                     ( \sorted-forall x0 s0 ( \sorted-forall x1 s2
                     ( \eq ( \pair-fst ( \pair x1 x2 ) ) x1 ) ) ) ) ) $.
axiom-pair-snd $a |- ( \forall-sort s0 ( \forall-sort s1 
                     ( \sorted-forall x0 s0 ( \sorted-forall x1 s2
                     ( \eq ( \pair-snd ( \pair x1 x2 ) ) x2 ) ) ) ) ) $.
axiom-pair-inj $a |- ( \forall-sort s0 ( \forall-sort s1 
                     ( \sorted-forall x0 s0 ( \sorted-forall x1 s2
                     ( \sorted-forall x2 s0 ( \sorted-forall x3 s2 
                     ( \imp ( \eq ( \pair x0 x1 ) ( \pair x2 x3 ) )
                            ( \and ( \eq x0 x2 ) ( \eq x1 x3 ) ) ) ) ) ) ) ) ) $.
axiom-pair-sort-inh $a |- ( \forall-sort s0 ( \forall-sort s1 
                          ( \eq ( \inh ( \pair-sort s0 s1 ) ) ( \pair ( \inh s0 ) ( \inh s1 ) ) ) ) ) $.
