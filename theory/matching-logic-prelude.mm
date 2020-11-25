$[ theory/matching-logic.mm $]

$( MATCHING LOGIC PRELUDE $)
$(
    Part 1. More Syntactic Sugar for Vanilla Matching Logic
    Part 2. Definedness
$)

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
