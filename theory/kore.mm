$[ theory/matching-logic-prelude.mm $]
$[ theory/matching-logic-prelude-lemmas.mm $]

$(
    Kore syntax https://github.com/kframework/kore/blob/master/docs/kore-syntax.md 
$)

$c \kore-bottom $.
$c \kore-top $.
$c \kore-not $.
$c \kore-and $.
$c \kore-or $.
$c \kore-implies $.
$c \kore-iff $.
$c \kore-exists $.
$c \kore-forall $.
$c \kore-forall-sort $.
$c \kore-mu $.
$c \kore-nu $.
$c \kore-ceil $.
$c \kore-floor $.
$c \kore-equals $.
$c \kore-in $.
$c \kore-next $.
$c \kore-eventually $.
$c \kore-rewrites $.
$c \kore-rewrites-star $.
$c \kore-dv $.
$c \kore-valid $.
$c \kore-is-sort $.

kore-exists-is-pattern $a #Pattern ( \kore-exists ph0 ph1 x ph2 ) $.
kore-exists-is-sugar $a #Notation ( \kore-exists ph0 ph1 x ph2 ) ( \sorted-exists x ph0 ph2 ) $.

kore-forall-is-pattern $a #Pattern ( \kore-forall ph0 ph1 x ph2 ) $.
kore-forall-is-sugar $a #Notation ( \kore-forall ph0 ph1 x ph2 ) ( \sorted-forall x ph0 ph2 ) $.

kore-forall-sort-is-pattern $a #Pattern ( \kore-forall-sort s0 ph0 ) $.
kore-forall-sort-is-sugar $a #Notation ( \kore-forall-sort s0 ph0 ) ( \forall-sort s0 ph0 ) $. 

kore-valid-is-pattern $a #Pattern ( \kore-valid ph0 ph1 ) $.
kore-valid-is-sugar $a #Notation ( \kore-valid ph0 ph1 ) ( \eq ph1 ( \kore-top ph0 ) ) $.

kore-bottom-is-pattern $a #Pattern ( \kore-bottom ph0 ) $.
kore-bottom-is-sugar $a #Notation ( \kore-bottom ph0 ) \bot $.

kore-top-is-pattern $a #Pattern ( \kore-top ph0 ) $.
kore-top-is-sugar $a #Notation ( \kore-top ph0 ) ( \inh ph0 ) $.

kore-not-is-pattern $a #Pattern ( \kore-not ph0 ph1 ) $.
kore-not-is-sugar $a #Notation ( \kore-not ph0 ph1 ) ( \and ( \not ph1 ) ( \kore-top ph0 ) ) $.

kore-and-is-pattern $a #Pattern ( \kore-and ph0 ph1 ph2 ) $.
kore-and-is-sugar $a #Notation ( \kore-and ph0 ph1 ph2 ) ( \and ph1 ph2 ) $.

kore-or-is-pattern $a #Pattern ( \kore-or ph0 ph1 ph2 ) $.
kore-or-is-sugar $a #Notation ( \kore-or ph0 ph1 ph2 ) ( \or ph1 ph2 ) $.

kore-implies-is-pattern $a #Pattern ( \kore-implies ph0 ph1 ph2 ) $.
kore-implies-is-sugar $a #Notation ( \kore-implies ph0 ph1 ph2 ) ( \kore-or ph0 ( \kore-not ph0 ph1 ) ph2 ) $.

kore-iff-is-pattern $a #Pattern ( \kore-iff ph0 ph1 ph2 ) $.
kore-iff-is-sugar $a #Notation ( \kore-iff ph0 ph1 ph2 ) ( \kore-and ph0 ( \kore-implies ph0 ph1 ph2 ) ( \kore-implies ph0 ph2 ph1 ) ) $.

kore-ceil-is-pattern   $a #Pattern ( \kore-ceil ph0 ph1 ph2 ) $.
kore-ceil-is-sugar $a #Notation ( \kore-ceil ph0 ph1 ph2 ) ( \and ( \ceil ph2 ) ( \kore-top ph1 ) ) $.

kore-floor-is-pattern  $a #Pattern ( \kore-floor ph0 ph1 ph2 ) $.
kore-floor-is-sugar $a #Notation ( \kore-floor ph0 ph1 ph2 ) ( \kore-not ph1 ( \kore-ceil ph0 ph1 ( \kore-not ph0 ph2 ) ) ) $.

kore-equals-is-pattern $a #Pattern ( \kore-equals ph0 ph1 ph2 ph3 ) $.
kore-equals-is-sugar $a #Notation ( \kore-equals ph0 ph1 ph2 ph3 ) ( \kore-floor ph0 ph1 ( \kore-iff ph0 ph2 ph3 ) ) $.

kore-in-is-pattern $a #Pattern ( \kore-in ph0 ph1 ph2 ph3 ) $.
kore-in-is-sugar $a #Notation ( \kore-in ph0 ph1 ph2 ph3 ) ( \kore-floor ph0 ph1 ( \kore-implies ph0 ph2 ph3 ) ) $.

$c \kore-next-symbol $.
kore-next-is-symbol $a #Symbol \kore-next-symbol $.
kore-next-is-pattern $a #Pattern ( \kore-next ph0 ph1 ) $.
kore-next-is-sugar $a #Notation ( \kore-next ph0 ph1 ) ( \app \kore-next-symbol ph1 ) $.

kore-evetually-is-pattern $a #Pattern ( \kore-eventually ph0 ph1 ) $.
${
    $d X ph0 $.
    $d X ph1 $.
    kore-evetually-is-sugar $a #Notation ( \kore-eventually ph0 ph1 ) ( \mu X ( \kore-or ph0 ph1 ( \kore-next ph0 X ) ) ) $.
$}

kore-rewrites-is-pattern $a #Pattern ( \kore-rewrites ph0 ph1 ph2 ) $.
kore-rewrites-is-sugar $a #Notation ( \kore-rewrites ph0 ph1 ph2 ) ( \kore-implies ph0 ph1 ( \kore-next ph0 ph2 ) ) $.

kore-rewrites-star-is-pattern $a #Pattern ( \kore-rewrites-star ph0 ph1 ph2 ) $.
kore-rewrites-star-is-sugar $a #Notation ( \kore-rewrites-star ph0 ph1 ph2 ) ( \kore-implies ph0 ph1 ( \kore-eventually ph0 ph2 ) ) $.

$c \kore-dv-symbol $.
kore-dv-is-symbol $a #Symbol \kore-dv-symbol $.
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-dv-is-sugar $a #Notation ( \kore-dv ph0 ph1 ) ( \app ( \app \kore-dv-symbol ph0 ) ph1 ) $.

kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
${
    $d s0 ph0 $.
    kore-is-sort-is-sugar $a #Notation ( \kore-is-sort ph0 ) ( \exists-sort s0 ( \eq s0 ph0 ) ) $.
$}
