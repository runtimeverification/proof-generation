$[ theory/matching-logic-prelude.mm $]
$[ theory/substitution.mm $]

$(
    Kore syntax https://github.com/kframework/kore/blob/master/docs/kore-syntax.md 
$)

$c \kore-bottom \kore-top \kore-not \kore-and \kore-or \kore-implies \kore-iff $.
$c \kore-exists \kore-forall \kore-forall-sort $.
$c \kore-mu \kore-nu $.
$c \kore-ceil \kore-floor \kore-equals \kore-in $.
$c \kore-next \kore-rewrites $.
$c \kore-dv $.
$c \kore-valid $.
$c \kore-is-sort $.

kore-exists-is-pattern $a #Pattern ( \kore-exists ph0 ph1 x ph2 ) $.
kore-exists-is-sugar $a #Equal ( \kore-exists ph0 ph1 x ph2 ) ( \sorted-exists x ph0 ph2 ) $.

kore-forall-is-pattern $a #Pattern ( \kore-forall ph0 ph1 x ph2 ) $.
kore-forall-is-sugar $a #Equal ( \kore-forall ph0 ph1 x ph2 ) ( \sorted-forall x ph0 ph2 ) $.

kore-forall-sort-is-pattern $a #Pattern ( \kore-forall-sort s0 ph0 ) $.
kore-forall-sort-is-sugar $a #Equal ( \kore-forall-sort s0 ph0 ) ( \forall-sort s0 ph0 ) $.

kore-valid-is-pattern $a #Pattern ( \kore-valid ph0 ph1 ) $.
kore-valid-is-sugar $a #Equal ( \kore-valid ph0 ph1 ) ( \eq ( \inh ph0 ) ph1 ) $.

kore-bottom-is-pattern $a #Pattern ( \kore-bottom ph0 ) $.
kore-bottom-is-sugar $a #Pattern ( \kore-bottom ph0 ) \bot $.

kore-top-is-pattern $a #Pattern ( \kore-top ph0 ) $.
kore-top-is-sugar $a #Equal ( \kore-top ph0 ) ( \and \top ( \inh ph0 ) ) $.

kore-not-is-pattern $a #Pattern ( \kore-not ph0 ph1 ) $.
kore-not-is-sugar $a #Equal ( \kore-not ph0 ph1 ) ( \and ( \not ph1 ) ( \inh ph0 ) ) $.

kore-and-is-pattern $a #Pattern ( \kore-and ph0 ph1 ph2 ) $.
kore-and-is-sugar $a #Equal ( \kore-and ph0 ph1 ph2 ) ( \and ph1 ph2 ) $.

kore-or-is-pattern $a #Pattern ( \kore-or ph0 ph1 ph2 ) $.
kore-or-is-sugar $a #Equal ( \kore-or ph0 ph1 ph2 ) ( \or ph1 ph2 ) $.

kore-implies-is-pattern $a #Pattern ( \kore-implies ph0 ph1 ph2 ) $.
kore-implies-is-sugar $a #Equal ( \kore-implies ph0 ph1 ph2 ) ( \and ( \imp ph1 ph2 ) ( \inh ph0 ) ) $.

kore-ceil-is-pattern   $a #Pattern ( \kore-ceil ph0 ph1 ph2 ) $.
kore-ceil-is-sugar $a #Equal ( \kore-ceil ph0 ph1 ph2 ) ( \and ( \ceil ph2 ) ( \inh ph1 ) ) $.

kore-floor-is-pattern  $a #Pattern ( \kore-floor ph0 ph1 ph2 ) $.
kore-floor-is-sugar $a #Equal ( \kore-floor ph0 ph1 ph2 ) ( \and ( \floor ph2 ) ( \inh ph1 ) ) $.

kore-equals-is-pattern $a #Pattern ( \kore-equals ph0 ph1 ph2 ph3 ) $.
kore-equals-is-sugar $a #Equal ( \kore-equals ph0 ph1 ph2 ph3 ) ( \and ( \eq ph2 ph3 ) ( \inh ph1 ) ) $.

kore-in-is-pattern $a #Pattern ( \kore-in ph0 ph1 ph2 ph3 ) $.
kore-in-is-sugar $a #Equal ( \kore-in ph0 ph1 ph2 ph3 ) ( \included ph2 ph3 ) $.

$c \kore-next-symbol $.
kore-next-is-symbol $a #Symbol \kore-next-symbol $.
kore-next-is-pattern $a #Pattern ( \kore-next ph0 ph1 ) $.
kore-next-is-sugar $a #Equal ( \kore-next ph0 ph1 ) ( \app \kore-next-symbol ph1 ) $.

kore-rewrites-is-pattern $a #Pattern ( \kore-rewrites ph0 ph1 ph2 ) $.
kore-rewrites-is-sugar $a #Equal ( \kore-rewrites ph0 ph1 ph2 ) ( \imp ph1 ( \kore-next ph0 ph2 ) ) $.

$c \kore-dv-symbol $.
kore-dv-is-symbol $a #Symbol \kore-dv-symbol $.
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-dv-is-sugar $a #Equal ( \kore-dv ph0 ph1 ) ( \app ( \app \kore-dv-symbol ph0 ) ph1 ) $.
