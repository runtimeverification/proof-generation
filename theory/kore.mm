$[ theory/matching-logic.mm $]

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

kore-exists-pattern $a #Pattern ( \kore-exists ph0 ph1 x ph2 ) $.
kore-forall-pattern $a #Pattern ( \kore-forall ph0 ph1 x ph2 ) $.
kore-forall-sort-pattern $a #Pattern ( \kore-forall-sort x ph0 ) $.
kore-valid $a #Pattern ( \kore-valid ph0 ph1 ) $.

kore-bottom-pattern $a #Pattern ( \kore-bottom ph0 ) $.
kore-top-pattern $a #Pattern ( \kore-top ph0 ) $.
kore-not-pattern $a #Pattern ( \kore-not ph0 ph1 ) $.
kore-and-pattern $a #Pattern ( \kore-and ph0 ph1 ph2 ) $.
kore-or-pattern $a #Pattern ( \kore-or ph0 ph1 ph2 ) $.
kore-implies-pattern $a #Pattern ( \kore-implies ph0 ph1 ph2 ) $.

kore-ceil-pattern   $a #Pattern ( \kore-ceil ph0 ph1 ph2 ) $.
kore-floor-pattern  $a #Pattern ( \kore-floor ph0 ph1 ph2 ) $.
kore-equals-pattern $a #Pattern ( \kore-equals ph0 ph1 ph2 ph3 ) $.
kore-in-pattern $a #Pattern ( \kore-in ph0 ph1 ph2 ph3 ) $.
kore-rewrites-pattern $a #Pattern ( \kore-rewrites ph0 ph1 ph2 ) $.
kore-dv-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.

$(
    Substitution rules
$)

${
    $d xX y $.
    $d y ph6 $. $( this assumption is too strong for symbolic terms, it only needs to not occur free $)
    kore-exists-substitution.0 $e #Substitution ph0 ph3 ph6 xX $.
    kore-exists-substitution.1 $e #Substitution ph1 ph4 ph6 xX $.
    kore-exists-substitution.2 $e #Substitution ph2 ph5 ph6 xX $.
    kore-exists-substitution $a #Substitution ( \kore-exists ph0 ph1 y ph2 ) ( \kore-exists ph3 ph4 y ph5 ) ph6 xX $.
$}

${
    kore-exists-substitution-shadowed.0 $e #Substitution ph0 ph3 ph6 x $.
    kore-exists-substitution-shadowed.1 $e #Substitution ph1 ph4 ph6 x $.
    kore-exists-substitution-shadowed $a #Substitution ( \kore-exists ph0 ph1 x ph2 ) ( \kore-exists ph3 ph4 x ph5 ) ph6 x $.
$}

${
    $d xX y $.
    $d y ph6 $.
    kore-forall-substitution.0 $e #Substitution ph0 ph3 ph6 xX $.
    kore-forall-substitution.1 $e #Substitution ph1 ph4 ph6 xX $.
    kore-forall-substitution.2 $e #Substitution ph2 ph5 ph6 xX $.
    kore-forall-substitution $a #Substitution ( \kore-forall ph0 ph1 y ph2 ) ( \kore-forall ph3 ph4 y ph5 ) ph6 xX $.
$}

${
    kore-forall-substitution-shadowed.0 $e #Substitution ph0 ph3 ph6 x $.
    kore-forall-substitution-shadowed.1 $e #Substitution ph1 ph4 ph6 x $.
    kore-forall-substitution-shadowed $a #Substitution ( \kore-forall ph0 ph1 x ph2 ) ( \kore-forall ph3 ph4 x ph5 ) ph6 x $.
$}

${
    $d xX y $.
    $d x ph2 $.
    kore-forall-sort-substitution.0 $e #Substitution ph0 ph1 ph2 xX $.
    kore-forall-sort-substitution $a #Substitution ( \kore-forall-sort x ph0 ) ( \kore-forall-sort x ph1 ) ph2 xX $.
$}

kore-forall-sort-substitution-shadowed $a #Substitution ( \kore-forall-sort x ph0 ) ( \kore-forall-sort x ph0 ) ph1 x $.

${
    kore-valid-substitution.0 $e #Substitution ph0 ph2 ph4 xX $.
    kore-valid-substitution.1 $e #Substitution ph1 ph3 ph4 xX $.
    kore-valid-substitution $a #Substitution ( \kore-valid ph0 ph1 ) ( \kore-valid ph2 ph3 ) ph4 xX $.
$}

${
    kore-bottom-substitution.0 $e #Substitution ph0 ph1 ph2 xX $.
    kore-bottom-substitution $a #Substitution ( \kore-bottom ph0 ) ( \kore-bottom ph1 ) ph2 xX $.
$}

${
    kore-top-substitution.0 $e #Substitution ph0 ph1 ph2 xX $.
    kore-top-substitution $a #Substitution ( \kore-top ph0 ) ( \kore-top ph1 ) ph2 xX $.
$}

${
    kore-not-substitution.0 $e #Substitution ph0 ph2 ph4 xX $.
    kore-not-substitution.1 $e #Substitution ph1 ph3 ph4 xX $.
    kore-not-substitution $a #Substitution ( \kore-not ph0 ph1 ) ( \kore-not ph2 ph3 ) ph4 xX $.
$}

${
    kore-and-substitution.0 $e #Substitution ph0 ph3 ph6 xX $.
    kore-and-substitution.1 $e #Substitution ph1 ph4 ph6 xX $.
    kore-and-substitution.2 $e #Substitution ph2 ph5 ph6 xX $.
    kore-and-substitution $a #Substitution ( \kore-and ph0 ph1 ph2 ) ( \kore-and ph3 ph4 ph5 ) ph6 xX $.
$}

${
    kore-or-substitution.0 $e #Substitution ph0 ph3 ph6 xX $.
    kore-or-substitution.1 $e #Substitution ph1 ph4 ph6 xX $.
    kore-or-substitution.2 $e #Substitution ph2 ph5 ph6 xX $.
    kore-or-substitution $a #Substitution ( \kore-or ph0 ph1 ph2 ) ( \kore-or ph3 ph4 ph5 ) ph6 xX $.
$}

${
    kore-implies-substitution.0 $e #Substitution ph0 ph3 ph6 xX $.
    kore-implies-substitution.1 $e #Substitution ph1 ph4 ph6 xX $.
    kore-implies-substitution.2 $e #Substitution ph2 ph5 ph6 xX $.
    kore-implies-substitution $a #Substitution ( \kore-implies ph0 ph1 ph2 ) ( \kore-implies ph3 ph4 ph5 ) ph6 xX $.
$}

${
    kore-ceil-substitution.0 $e #Substitution ph0 ph3 ph6 xX $.
    kore-ceil-substitution.1 $e #Substitution ph1 ph4 ph6 xX $.
    kore-ceil-substitution.2 $e #Substitution ph2 ph5 ph6 xX $.
    kore-ceil-substitution $a #Substitution ( \kore-ceil ph0 ph1 ph2 ) ( \kore-ceil ph3 ph4 ph5 ) ph6 xX $.
$}

${
    kore-floor-substitution.0 $e #Substitution ph0 ph3 ph6 xX $.
    kore-floor-substitution.1 $e #Substitution ph1 ph4 ph6 xX $.
    kore-floor-substitution.2 $e #Substitution ph2 ph5 ph6 xX $.
    kore-floor-substitution $a #Substitution ( \kore-floor ph0 ph1 ph2 ) ( \kore-floor ph3 ph4 ph5 ) ph6 xX $.
$}

${
    kore-equals-substitution.0 $e #Substitution ph0 ph4 ph8 xX $.
    kore-equals-substitution.1 $e #Substitution ph1 ph5 ph8 xX $.
    kore-equals-substitution.2 $e #Substitution ph2 ph6 ph8 xX $.
    kore-equals-substitution.3 $e #Substitution ph3 ph7 ph8 xX $.
    kore-equals-substitution $a #Substitution ( \kore-equals ph0 ph1 ph2 ph3 ) ( \kore-equals ph4 ph5 ph6 ph7 ) ph8 xX $.
$}

${
    kore-in-substitution.0 $e #Substitution ph0 ph4 ph8 xX $.
    kore-in-substitution.1 $e #Substitution ph1 ph5 ph8 xX $.
    kore-in-substitution.2 $e #Substitution ph2 ph6 ph8 xX $.
    kore-in-substitution.3 $e #Substitution ph3 ph7 ph8 xX $.
    kore-in-substitution $a #Substitution ( \kore-in ph0 ph1 ph2 ph3 ) ( \kore-in ph4 ph5 ph6 ph7 ) ph8 xX $.
$}

${
    kore-rewrites-substitution.0 $e #Substitution ph0 ph3 ph6 xX $.
    kore-rewrites-substitution.1 $e #Substitution ph1 ph4 ph6 xX $.
    kore-rewrites-substitution.2 $e #Substitution ph2 ph5 ph6 xX $.
    kore-rewrites-substitution $a #Substitution ( \kore-rewrites ph0 ph1 ph2 ) ( \kore-rewrites ph3 ph4 ph5 ) ph6 xX $.
$}

${
    kore-dv-substitution.0 $e #Substitution ph0 ph2 ph4 xX $.
    kore-dv-substitution.1 $e #Substitution ph1 ph3 ph4 xX $.
    kore-dv-substitution $a #Substitution ( \kore-dv ph0 ph1 ) ( \kore-dv ph2 ph3 ) ph4 xX $.
$}

$(
    Kore lemmas
$)

kore-top-valid $p |- ( \kore-valid ph0 ( \kore-top ph0 ) ) $= ? $.

${
    $(
        ph0: rewrite sort
        ph1: rewrite condition (`requires` clause)
        ph2: LHS
        ph3: `ensures` clause
        ph4: RHS
    $)
    kore-rewrites-conditional.0 $e |- ( \kore-valid ph0 ( \kore-rewrites ph0 ( \kore-and ph0 ph1 ph2 ) ( \kore-and ph0 ph3 ph4 ) ) ) $.
    kore-rewrites-conditional.1 $e |- ( \kore-valid ph0 ph1 ) $.
    kore-rewrites-conditional.2 $e |- ( \kore-valid ph0 ph3 ) $.
    kore-rewrites-conditional $p |- ( \kore-valid ph0 ( \kore-rewrites ph0 ph2 ph4 ) ) $= ? $.
$}

$( forall elimination with no sort variables $)
${
    $d y z $.
    $d y ph0 $.
    $d y ph3 $.
    $d z ph0 $.
    $d z ph3 $.
    kore-forall-elim.0 $e |- ( \kore-valid ph1 ( \kore-forall ph0 ph1 x ph2 ) ) $.
    $( ph3 is functional and has sort ph0 $)
    kore-forall-elim.1 $e |- ( \kore-forall-sort z ( \kore-valid z ( \kore-exists ph0 z y ( \kore-equals ph0 z y ph3 ) ) ) ) $.
    kore-forall-elim.2 $e #Substitution ph4 ph2 ph3 x $.
    kore-forall-elim $p |- ( \kore-valid ph1 ph4 ) $= ? $.
$}

$( forall elimination with 1 sort variable $)
${
    $d x y $.
    $d z w $.

    $d x ph0 $.
    $d z ph0 $.
    $d y ph0 $.
    $d w ph0 $.

    $d z ph2 $.
    $d w ph2 $.

    kore-forall-elim-v1.0 $e |- ( \kore-forall-sort x ( \kore-valid ph4 ( \kore-forall ph0 ph4 y ph1 ) ) ) $.
    $( ph2 is functional and has sort ph0 $)
    kore-forall-elim-v1.1 $e |- ( \kore-forall-sort z ( \kore-valid z ( \kore-exists ph0 z w ( \kore-equals ph0 z w ph2 ) ) ) ) $.
    kore-forall-elim-v1.2 $e #Substitution ph3 ph1 ph2 y $.
    kore-forall-elim-v1 $p |- ( \kore-forall-sort x ( \kore-valid ph4 ph3 ) ) $= ? $.
$}

${
    kore-forall-sort-elim.0 $e |- ( \kore-forall-sort x ph0 ) $.
    kore-forall-sort-elim.1 $e |- ( \kore-is-sort ph1 ) $.
    kore-forall-sort-elim.2 $e #Substitution ph2 ph0 ph1 x $.
    kore-forall-sort-elim $p |- ph2 $= ? $.
$}

$( replace a subpattern with an equal one $)
${
    $d z ph0 $.
    kore-equality.0 $e |- ( \kore-forall-sort z ( \kore-valid z ( \kore-equals ph0 z ph1 ph2 ) ) ) $.
    kore-equality.1 $e |- ph3 $.
    kore-equality.2 $e #Substitution ph3 ph4 ph1 x $.
    kore-equality.3 $e #Substitution ph5 ph4 ph2 x $.
    kore-equality $p |- ph5 $= ? $.
$}

kore-equals-reflexivity $p |- ( \kore-forall-sort x ( \kore-valid x ( \kore-equals ph0 x ph1 ph1 ) ) ) $= ? $.

${
    kore-equals-symmetry.0 $e |- ( \kore-forall-sort x ( \kore-valid x ( \kore-equals ph0 x ph1 ph2 ) ) ) $.
    kore-equals-symmetry $p |- ( \kore-forall-sort x ( \kore-valid x ( \kore-equals ph0 x ph2 ph1 ) ) ) $= ? $.
$}

$( ph /\ ph = ph $)
kore-dup-and $p |- ( \kore-forall-sort x ( \kore-valid x ( \kore-equals ph0 x ( \kore-and ph0 ph1 ph1 ) ph1 ) ) ) $= ? $.

${
    kore-rewrites-trans.0 $e |- ( \kore-valid ph0 ( \kore-rewrites ph0 ph1 ph2 ) ) $.
    kore-rewrites-trans.1 $e |- ( \kore-valid ph0 ( \kore-rewrites ph0 ph2 ph3 ) ) $.
    kore-rewrites-trans $p |- ( \kore-valid ph0 ( \kore-rewrites ph0 ph1 ph3 ) ) $= ? $.
$}
