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
$c \kore-all-path-next $.
$c \kore-eventually $.
$c \kore-weak-eventually $.
$c \kore-always $.
$c \kore-well-founded $.
$c \kore-well-founded-alt $.
$c \kore-rewrites $.
$c \kore-rewrites-star $.
$c \kore-rewrites-plus $.
$c \kore-one-path-reaches-plus $.
$c \kore-one-path-reaches-star $.
$c \kore-circularity $.
$c \kore-non-terminating $.
$c \kore-all-path-next-nt $.
$c \kore-all-path-eventually $.
$c \kore-all-path-rewrites $.
$c \kore-all-path-rewrites-star $.
$c \kore-all-path-rewrites-plus $.
$c \kore-dv $.
$c \kore-valid $.
$c \kore-is-sort $.
$c \kore-inj $.
$c \kore-is-predicate $.
$c \kore-is-nonempty-sort $.

kore-exists-is-pattern $a #Pattern ( \kore-exists ph0 ph1 x ph2 ) $.
kore-exists-is-sugar $a #Notation ( \kore-exists ph0 ph1 x ph2 ) ( \and ( \sorted-exists x ph0 ph2 ) ( \inh ph1 ) ) $.

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

kore-ceil-is-pattern $a #Pattern ( \kore-ceil ph0 ph1 ph2 ) $.
kore-ceil-is-sugar $a #Notation ( \kore-ceil ph0 ph1 ph2 ) ( \and ( \ceil ph2 ) ( \kore-top ph1 ) ) $.

kore-floor-is-pattern $a #Pattern ( \kore-floor ph0 ph1 ph2 ) $.
kore-floor-is-sugar $a #Notation ( \kore-floor ph0 ph1 ph2 ) ( \kore-not ph1 ( \kore-ceil ph0 ph1 ( \kore-not ph0 ph2 ) ) ) $.

kore-equals-is-pattern $a #Pattern ( \kore-equals ph0 ph1 ph2 ph3 ) $.
kore-equals-is-sugar $a #Notation ( \kore-equals ph0 ph1 ph2 ph3 ) ( \kore-floor ph0 ph1 ( \kore-iff ph0 ph2 ph3 ) ) $.

kore-in-is-pattern $a #Pattern ( \kore-in ph0 ph1 ph2 ph3 ) $.
kore-in-is-sugar $a #Notation ( \kore-in ph0 ph1 ph2 ph3 ) ( \kore-floor ph0 ph1 ( \kore-implies ph0 ph2 ph3 ) ) $.

$c \kore-next-symbol $.
kore-next-is-symbol $a #Symbol \kore-next-symbol $.
kore-next-is-pattern $a #Pattern ( \kore-next ph0 ph1 ) $.
kore-next-is-sugar $a #Notation ( \kore-next ph0 ph1 ) ( \app \kore-next-symbol ph1 ) $.
kore-next-sorting $a |- ( \imp ( \in-sort ph1 ph0 ) ( \in-sort ( \kore-next ph0 ph1 ) ph0 ) ) $.

${
    kore-mu-is-pattern.0 $e #Positive X ph1 $.
    kore-mu-is-pattern   $a #Pattern ( \kore-mu ph0 X ph1 ) $.
$}
kore-mu-is-sugar $a #Notation ( \kore-mu ph0 X ph1 ) ( \and ( \mu X ph1 ) ( \inh ph0 ) ) $.

${
    kore-nu-is-pattern.0 $e #Positive X ph1 $.
    kore-nu-is-pattern   $a #Pattern ( \kore-nu ph0 X ph1 ) $.
$}
${
    kore-nu-is-sugar.0 $e #Substitution ph2 ph1 ( \kore-not ph0 X ) X $.
    kore-nu-is-sugar $a #Notation ( \kore-nu ph0 X ph1 ) ( \kore-not ph0 ( \kore-mu ph0 X ( \kore-not ph0 ph2 ) ) ) $.
$}

kore-all-path-next-is-pattern $a #Pattern ( \kore-all-path-next ph0 ph1 ) $.
kore-all-path-next-is-sugar $a #Notation ( \kore-all-path-next ph0 ph1 ) ( \kore-not ph0 ( \kore-next ph0 ( \kore-not ph0 ph1 ) ) ) $.

kore-eventually-is-pattern $a #Pattern ( \kore-eventually ph0 ph1 ) $.
${
    $d X ph0 $.
    $d X ph1 $.
    kore-eventually-is-sugar $a #Notation ( \kore-eventually ph0 ph1 ) ( \kore-mu ph0 X ( \kore-or ph0 ph1 ( \kore-next ph0 X ) ) ) $.
$}

kore-weak-eventually-is-pattern $a #Pattern ( \kore-weak-eventually ph0 ph1 ) $.
${
    $d X ph0 $.
    $d X ph1 $.
    kore-weak-eventually-is-sugar $a #Notation ( \kore-weak-eventually ph0 ph1 ) ( \kore-not ph0 ( \kore-mu ph0 X ( \kore-not ph0 ( \kore-or ph0 ph1 ( \kore-next ph0 ( \kore-not ph0 X ) ) ) ) ) ) $.
$}

kore-always-is-pattern $a #Pattern ( \kore-always ph0 ph1 ) $.
${
    $d X ph0 $.
    $d X ph1 $.
    kore-always-is-sugar $a #Notation ( \kore-always ph0 ph1 ) ( \kore-not ph0 ( \kore-mu ph0 X ( \kore-not ph0 ( \kore-and ph0 ph1 ( \kore-all-path-next ph0 ( \kore-not ph0 X ) ) ) ) ) ) $.
$}

kore-well-founded-is-pattern $a #Pattern ( \kore-well-founded ph0 ) $.
${
    $d X ph0 $.
    kore-well-founded-is-sugar $a #Notation ( \kore-well-founded ph0 ) ( \kore-mu ph0 X ( \kore-all-path-next ph0 X ) ) $.
$}

kore-well-founded-alt-is-pattern $a #Pattern ( \kore-well-founded-alt ph0 ) $.
${
    $d X ph0 $.
    kore-well-founded-alt-is-sugar $a #Notation ( \kore-well-founded-alt ph0 ) ( \kore-mu ph0 X ( \kore-all-path-next ph0 ( \kore-always ph0 X ) ) ) $.
$}

kore-rewrites-is-pattern $a #Pattern ( \kore-rewrites ph0 ph1 ph2 ) $.
kore-rewrites-is-sugar $a #Notation ( \kore-rewrites ph0 ph1 ph2 ) ( \kore-implies ph0 ph1 ( \kore-next ph0 ph2 ) ) $.

kore-rewrites-star-is-pattern $a #Pattern ( \kore-rewrites-star ph0 ph1 ph2 ) $.
kore-rewrites-star-is-sugar $a #Notation ( \kore-rewrites-star ph0 ph1 ph2 ) ( \kore-implies ph0 ph1 ( \kore-eventually ph0 ph2 ) ) $.

kore-rewrites-plus-is-pattern $a #Pattern ( \kore-rewrites-plus ph0 ph1 ph2 ) $.
kore-rewrites-plus-is-sugar $a #Notation ( \kore-rewrites-plus ph0 ph1 ph2 ) ( \kore-implies ph0 ph1 ( \kore-next ph0 ( \kore-eventually ph0 ph2 ) ) ) $.

kore-one-path-reaches-star-is-pattern $a #Pattern ( \kore-one-path-reaches-star ph0 ph1 ph2 ) $.
kore-one-path-reaches-star-is-sugar $a #Notation ( \kore-one-path-reaches-star ph0 ph1 ph2 ) ( \kore-implies ph0 ph1 ( \kore-weak-eventually ph0 ph2 ) ) $.

kore-one-path-reaches-plus-is-pattern $a #Pattern ( \kore-one-path-reaches-plus ph0 ph1 ph2 ) $.
kore-one-path-reaches-plus-is-sugar $a #Notation ( \kore-one-path-reaches-plus ph0 ph1 ph2 ) ( \kore-implies ph0 ph1 ( \kore-next ph0 ( \kore-weak-eventually ph0 ph2 ) ) ) $.

kore-circularity-is-pattern $a #Pattern ( \kore-circularity ph0 ph1 ) $.
kore-circularity-is-sugar $a #Notation ( \kore-circularity ph0 ph1 ) ( \kore-all-path-next ph0 ( \kore-always ph0 ph1 ) ) $.

$( All-path variants of rewriting $)

kore-non-terminating-is-pattern $a #Pattern ( \kore-non-terminating ph0 ) $.
kore-non-terminating-is-sugar $a #Notation ( \kore-non-terminating ph0 ) ( \kore-next ph0 ( \kore-top ph0 ) ) $.

$( Similar to all-path-next but does not include terminating states $)
kore-all-path-next-nt-is-pattern $a #Pattern ( \kore-all-path-next-nt ph0 ph1 ) $.
kore-all-path-next-nt-is-sugar $a #Notation ( \kore-all-path-next-nt ph0 ph1 ) ( \kore-and ph0 ( \kore-all-path-next ph0 ph1 ) ( \kore-non-terminating ph0 ) ) $.

kore-all-path-eventually-is-pattern $a #Pattern ( \kore-all-path-eventually ph0 ph1 ) $.
${
    $d X ph0 $.
    $d X ph1 $.
    kore-all-path-eventually-is-sugar $a #Notation ( \kore-all-path-eventually ph0 ph1 ) ( \kore-mu ph0 X ( \kore-or ph0 ph1 ( \kore-all-path-next-nt ph0 X ) ) ) $.
$}

kore-all-path-rewrites-is-pattern $a #Pattern ( \kore-all-path-rewrites ph0 ph1 ph2 ) $.
kore-all-path-rewrites-is-sugar $a #Notation ( \kore-all-path-rewrites ph0 ph1 ph2 ) ( \kore-implies ph0 ph1 ( \kore-all-path-next-nt ph0 ph2 ) ) $.

kore-all-path-rewrites-star-is-pattern $a #Pattern ( \kore-all-path-rewrites-star ph0 ph1 ph2 ) $.
kore-all-path-rewrites-star-is-sugar $a #Notation ( \kore-all-path-rewrites-star ph0 ph1 ph2 ) ( \kore-implies ph0 ph1 ( \kore-all-path-eventually ph0 ph2 ) ) $.

kore-all-path-rewrites-plus-is-pattern $a #Pattern ( \kore-all-path-rewrites-plus ph0 ph1 ph2 ) $.
kore-all-path-rewrites-plus-is-sugar $a #Notation ( \kore-all-path-rewrites-plus ph0 ph1 ph2 ) ( \kore-implies ph0 ph1 ( \kore-all-path-next-nt ph0 ( \kore-all-path-eventually ph0 ph2 ) ) ) $.

$c \kore-dv-symbol $.
kore-dv-is-symbol $a #Symbol \kore-dv-symbol $.
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-dv-is-sugar $a #Notation ( \kore-dv ph0 ph1 ) ( \app ( \app \kore-dv-symbol ph0 ) ph1 ) $.
kore-dv-sorting $a |- ( \in-sort ( \kore-dv ph0 ph1 ) ph0 ) $.

kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
${
    $d s0 ph0 $.
    kore-is-sort-is-sugar $a #Notation ( \kore-is-sort ph0 ) ( \exists-sort s0 ( \eq s0 ph0 ) ) $.
$}

kore-forall-is-pattern $a #Pattern ( \kore-forall ph0 ph1 x ph2 ) $.
kore-forall-is-sugar $a #Notation ( \kore-forall ph0 ph1 x ph2 ) ( \kore-not ph1 ( \kore-exists ph0 ph1 x ( \kore-not ph1 ph2 ) ) ) $.

$c \kore-inj-symbol $.
kore-inj-is-symbol $a #Symbol \kore-inj-symbol $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
kore-inj-is-sugar $a #Notation ( \kore-inj ph0 ph1 ph2 ) ( \app ( \app ( \app \kore-inj-symbol ph0 ) ph1 ) ph2 ) $.

kore-inj-id $a |- ( \eq ( \kore-inj ph0 ph1 ph2 ) ph2 ) $.

kore-is-predicate-is-pattern $a #Pattern ( \kore-is-predicate ph0 ph1 ) $.
kore-is-predicate-is-sugar $a #Notation ( \kore-is-predicate ph0 ph1 ) ( \or ( \kore-valid ph0 ph1 ) ( \is-bot ph1 ) ) $.

kore-is-nonempty-sort-is-pattern $a #Pattern ( \kore-is-nonempty-sort ph0 ) $.
kore-is-nonempty-sort-is-sugar $a #Notation ( \kore-is-nonempty-sort ph0 ) ( \ceil ( \inh ph0 ) ) $.
