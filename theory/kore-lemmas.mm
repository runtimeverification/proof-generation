$[ theory/kore.mm $]

$( KORE LEMMAS $)

$(
    Substitution rules
$)

${
    $d xX y $.
    $d y ph6 $. $( this assumption is too strong for symbolic terms, it only needs to not occur free $)
    substitution-kore-exists.0 $e #Substitution ph0 ph3 ph6 xX $.
    substitution-kore-exists.1 $e #Substitution ph1 ph4 ph6 xX $.
    substitution-kore-exists.2 $e #Substitution ph2 ph5 ph6 xX $.
    substitution-kore-exists $p #Substitution ( \kore-exists ph0 ph1 y ph2 ) ( \kore-exists ph3 ph4 y ph5 ) ph6 xX $= ? $.
$}

${
    substitution-kore-exists-shadowed.0 $e #Substitution ph0 ph3 ph6 x $.
    substitution-kore-exists-shadowed.1 $e #Substitution ph1 ph4 ph6 x $.
    substitution-kore-exists-shadowed $p #Substitution ( \kore-exists ph0 ph1 x ph2 ) ( \kore-exists ph3 ph4 x ph5 ) ph6 x $= ? $.
$}

${
    $d xX y $.
    $d y ph6 $.
    substitution-kore-forall.0 $e #Substitution ph0 ph3 ph6 xX $.
    substitution-kore-forall.1 $e #Substitution ph1 ph4 ph6 xX $.
    substitution-kore-forall.2 $e #Substitution ph2 ph5 ph6 xX $.
    substitution-kore-forall $p #Substitution ( \kore-forall ph0 ph1 y ph2 ) ( \kore-forall ph3 ph4 y ph5 ) ph6 xX $= ? $.
$}

${
    substitution-kore-forall-shadowed.0 $e #Substitution ph0 ph3 ph6 x $.
    substitution-kore-forall-shadowed.1 $e #Substitution ph1 ph4 ph6 x $.
    substitution-kore-forall-shadowed $p #Substitution ( \kore-forall ph0 ph1 x ph2 ) ( \kore-forall ph3 ph4 x ph5 ) ph6 x $= ? $.
$}

${
    $d xX x $.
    $d x ph2 $.
    substitution-kore-forall-sort.0 $e #Substitution ph0 ph1 ph2 xX $.
    substitution-kore-forall-sort $p #Substitution ( \kore-forall-sort x ph0 ) ( \kore-forall-sort x ph1 ) ph2 xX $= ? $.
$}

substitution-kore-forall-sort-shadowed $p #Substitution ( \kore-forall-sort x ph0 ) ( \kore-forall-sort x ph0 ) ph1 x $= ? $.

${
    substitution-kore-valid.0 $e #Substitution ph0 ph2 ph4 xX $.
    substitution-kore-valid.1 $e #Substitution ph1 ph3 ph4 xX $.
    substitution-kore-valid $p #Substitution ( \kore-valid ph0 ph1 ) ( \kore-valid ph2 ph3 ) ph4 xX $= ? $.
$}

${
    substitution-kore-bottom.0 $e #Substitution ph0 ph1 ph2 xX $.
    substitution-kore-bottom $p #Substitution ( \kore-bottom ph0 ) ( \kore-bottom ph1 ) ph2 xX $= ? $.
$}

${
    substitution-kore-top.0 $e #Substitution ph0 ph1 ph2 xX $.
    substitution-kore-top $p #Substitution ( \kore-top ph0 ) ( \kore-top ph1 ) ph2 xX $= ? $.
$}

${
    substitution-kore-not.0 $e #Substitution ph0 ph2 ph4 xX $.
    substitution-kore-not.1 $e #Substitution ph1 ph3 ph4 xX $.
    substitution-kore-not $p #Substitution ( \kore-not ph0 ph1 ) ( \kore-not ph2 ph3 ) ph4 xX $= ? $.
$}

${
    substitution-kore-and.0 $e #Substitution ph0 ph3 ph6 xX $.
    substitution-kore-and.1 $e #Substitution ph1 ph4 ph6 xX $.
    substitution-kore-and.2 $e #Substitution ph2 ph5 ph6 xX $.
    substitution-kore-and $p #Substitution ( \kore-and ph0 ph1 ph2 ) ( \kore-and ph3 ph4 ph5 ) ph6 xX $= ? $.
$}

${
    substitution-kore-or.0 $e #Substitution ph0 ph3 ph6 xX $.
    substitution-kore-or.1 $e #Substitution ph1 ph4 ph6 xX $.
    substitution-kore-or.2 $e #Substitution ph2 ph5 ph6 xX $.
    substitution-kore-or $p #Substitution ( \kore-or ph0 ph1 ph2 ) ( \kore-or ph3 ph4 ph5 ) ph6 xX $= ? $.
$}

${
    substitution-kore-implies.0 $e #Substitution ph0 ph3 ph6 xX $.
    substitution-kore-implies.1 $e #Substitution ph1 ph4 ph6 xX $.
    substitution-kore-implies.2 $e #Substitution ph2 ph5 ph6 xX $.
    substitution-kore-implies $p #Substitution ( \kore-implies ph0 ph1 ph2 ) ( \kore-implies ph3 ph4 ph5 ) ph6 xX $= ? $.
$}

${
    substitution-kore-ceil.0 $e #Substitution ph0 ph3 ph6 xX $.
    substitution-kore-ceil.1 $e #Substitution ph1 ph4 ph6 xX $.
    substitution-kore-ceil.2 $e #Substitution ph2 ph5 ph6 xX $.
    substitution-kore-ceil $p #Substitution ( \kore-ceil ph0 ph1 ph2 ) ( \kore-ceil ph3 ph4 ph5 ) ph6 xX $= ? $.
$}

${
    substitution-kore-floor.0 $e #Substitution ph0 ph3 ph6 xX $.
    substitution-kore-floor.1 $e #Substitution ph1 ph4 ph6 xX $.
    substitution-kore-floor.2 $e #Substitution ph2 ph5 ph6 xX $.
    substitution-kore-floor $p #Substitution ( \kore-floor ph0 ph1 ph2 ) ( \kore-floor ph3 ph4 ph5 ) ph6 xX $= ? $.
$}

${
    substitution-kore-equals.0 $e #Substitution ph0 ph4 ph8 xX $.
    substitution-kore-equals.1 $e #Substitution ph1 ph5 ph8 xX $.
    substitution-kore-equals.2 $e #Substitution ph2 ph6 ph8 xX $.
    substitution-kore-equals.3 $e #Substitution ph3 ph7 ph8 xX $.
    substitution-kore-equals $p #Substitution ( \kore-equals ph0 ph1 ph2 ph3 ) ( \kore-equals ph4 ph5 ph6 ph7 ) ph8 xX $= ? $.
$}

${
    substitution-kore-in.0 $e #Substitution ph0 ph4 ph8 xX $.
    substitution-kore-in.1 $e #Substitution ph1 ph5 ph8 xX $.
    substitution-kore-in.2 $e #Substitution ph2 ph6 ph8 xX $.
    substitution-kore-in.3 $e #Substitution ph3 ph7 ph8 xX $.
    substitution-kore-in $p #Substitution ( \kore-in ph0 ph1 ph2 ph3 ) ( \kore-in ph4 ph5 ph6 ph7 ) ph8 xX $= ? $.
$}

${
    substitution-kore-rewrites.0 $e #Substitution ph0 ph3 ph6 xX $.
    substitution-kore-rewrites.1 $e #Substitution ph1 ph4 ph6 xX $.
    substitution-kore-rewrites.2 $e #Substitution ph2 ph5 ph6 xX $.
    substitution-kore-rewrites $p #Substitution ( \kore-rewrites ph0 ph1 ph2 ) ( \kore-rewrites ph3 ph4 ph5 ) ph6 xX $= ? $.
$}

${
    substitution-kore-dv.0 $e #Substitution ph0 ph2 ph4 xX $.
    substitution-kore-dv.1 $e #Substitution ph1 ph3 ph4 xX $.
    substitution-kore-dv $p #Substitution ( \kore-dv ph0 ph1 ) ( \kore-dv ph2 ph3 ) ph4 xX $= ? $.
$}

$( Kore lemmas $)

kore-top-valid $p |- ( \kore-valid ph0 ( \kore-top ph0 ) ) $= ? $.
kore-top-valid-v1 $p |- ( \kore-forall-sort x ( \kore-valid x ( \kore-top x ) ) ) $= x-is-element-var element-var-is-var var-is-pattern sort-is-symbol symbol-is-pattern in-sort-is-pattern x-is-element-var element-var-is-var var-is-pattern x-is-element-var element-var-is-var var-is-pattern kore-top-is-pattern kore-valid-is-pattern imp-is-pattern x-is-element-var forall-is-pattern x-is-element-var element-var-is-var var-is-pattern x-is-element-var element-var-is-var var-is-pattern kore-top-is-pattern kore-valid-is-pattern x-is-element-var kore-forall-sort-is-pattern top-is-pattern x-is-element-var element-var-is-var var-is-pattern sort-is-symbol symbol-is-pattern in-sort-is-pattern x-is-element-var element-var-is-var var-is-pattern x-is-element-var element-var-is-var var-is-pattern kore-top-is-pattern kore-valid-is-pattern imp-is-pattern x-is-element-var forall-is-pattern top-is-pattern x-is-element-var element-var-is-var var-is-pattern sort-is-symbol symbol-is-pattern in-sort-is-pattern x-is-element-var element-var-is-var var-is-pattern x-is-element-var element-var-is-var var-is-pattern kore-top-is-pattern kore-valid-is-pattern imp-is-pattern x-is-element-var x-is-element-var element-var-is-var var-is-pattern sort-is-symbol symbol-is-pattern in-sort-is-pattern x-is-element-var element-var-is-var var-is-pattern x-is-element-var element-var-is-var var-is-pattern kore-top-is-pattern kore-valid-is-pattern imp-is-pattern top-is-pattern x-is-element-var element-var-is-var var-is-pattern sort-is-symbol symbol-is-pattern in-sort-is-pattern x-is-element-var element-var-is-var var-is-pattern x-is-element-var element-var-is-var var-is-pattern kore-top-is-pattern kore-valid-is-pattern imp-is-pattern imp-is-pattern x-is-element-var element-var-is-var var-is-pattern sort-is-symbol symbol-is-pattern in-sort-is-pattern x-is-element-var element-var-is-var var-is-pattern x-is-element-var element-var-is-var var-is-pattern kore-top-is-pattern kore-valid-is-pattern imp-is-pattern top-is-pattern proof-rule-prop-1 x-is-element-var element-var-is-var var-is-pattern x-is-element-var element-var-is-var var-is-pattern kore-top-is-pattern kore-valid-is-pattern x-is-element-var element-var-is-var var-is-pattern sort-is-symbol symbol-is-pattern in-sort-is-pattern x-is-element-var element-var-is-var var-is-pattern x-is-element-var element-var-is-var var-is-pattern kore-top-is-pattern kore-valid-is-pattern imp-is-pattern x-is-element-var element-var-is-var var-is-pattern x-is-element-var element-var-is-var var-is-pattern kore-top-is-pattern kore-valid-is-pattern x-is-element-var element-var-is-var var-is-pattern sort-is-symbol symbol-is-pattern in-sort-is-pattern proof-rule-prop-1 x-is-element-var element-var-is-var var-is-pattern kore-top-valid proof-rule-mp proof-rule-mp bot-is-pattern bot-is-pattern imp-is-pattern top-is-pattern x-is-element-var element-var-is-var bot-is-pattern bot-is-pattern x-is-element-var element-var-is-var x-is-element-var element-var-is-var fresh-in-bot x-is-element-var element-var-is-var fresh-in-bot fresh-in-imp top-is-pattern bot-is-pattern not-is-pattern bot-is-pattern bot-is-pattern imp-is-pattern top-is-sugar bot-is-pattern not-is-sugar equal-transitivity equal-fresh lemma-forall-gen lemma-top proof-rule-mp x-is-element-var element-var-is-var var-is-pattern x-is-element-var element-var-is-var var-is-pattern kore-top-is-pattern kore-valid-is-pattern x-is-element-var kore-forall-sort-is-pattern x-is-element-var element-var-is-var var-is-pattern x-is-element-var element-var-is-var var-is-pattern kore-top-is-pattern kore-valid-is-pattern x-is-element-var forall-sort-is-pattern x-is-element-var element-var-is-var var-is-pattern sort-is-symbol symbol-is-pattern in-sort-is-pattern x-is-element-var element-var-is-var var-is-pattern x-is-element-var element-var-is-var var-is-pattern kore-top-is-pattern kore-valid-is-pattern imp-is-pattern x-is-element-var forall-is-pattern x-is-element-var element-var-is-var var-is-pattern x-is-element-var element-var-is-var var-is-pattern kore-top-is-pattern kore-valid-is-pattern x-is-element-var kore-forall-sort-is-sugar x-is-element-var element-var-is-var var-is-pattern x-is-element-var element-var-is-var var-is-pattern kore-top-is-pattern kore-valid-is-pattern x-is-element-var forall-sort-is-pattern sort-is-symbol symbol-is-pattern x-is-element-var element-var-is-var var-is-pattern x-is-element-var element-var-is-var var-is-pattern kore-top-is-pattern kore-valid-is-pattern x-is-element-var sorted-forall-is-pattern x-is-element-var element-var-is-var var-is-pattern sort-is-symbol symbol-is-pattern in-sort-is-pattern x-is-element-var element-var-is-var var-is-pattern x-is-element-var element-var-is-var var-is-pattern kore-top-is-pattern kore-valid-is-pattern imp-is-pattern x-is-element-var forall-is-pattern x-is-element-var element-var-is-var var-is-pattern x-is-element-var element-var-is-var var-is-pattern kore-top-is-pattern kore-valid-is-pattern x-is-element-var forall-sort-is-sugar sort-is-symbol symbol-is-pattern x-is-element-var element-var-is-var var-is-pattern x-is-element-var element-var-is-var var-is-pattern kore-top-is-pattern kore-valid-is-pattern x-is-element-var sorted-forall-is-sugar equal-transitivity equal-transitivity equal-proof $.

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





$( ===================================== $)
$( I'm working on this part. ---- Xiaohong $)

$( I'm following [TR'19, Lemma 58] $)

${
    kore-definedness $p |- ( \kore-valid ph1 ( \kore-ceil ph0 ph1 x ) ) $= ? $.
$}

${
    kore-ph-implies-ceil-ph $p |- ( \kore-valid ph0 ( \kore-implies ph0 ph1 ( \kore-ceil ph0 ph0 ph1 ) ) ) $= ? $.
$}

${
    kore-equality-deduce-implies.0 $e |- ( \kore-valid ph0 ( \kore-equals ph0 ph0 ph1 ph2 ) )  $.
    kore-equality-deduce-implies $p |- ( \kore-valid ph0 ( \kore-implies ph0 ph1 ph2 ) )  $= ? $.
$}

${
    $d z ph0 $.
    kore-equality-to-eq.0 $e |- ( \kore-forall-sort z ( \kore-valid z ( \kore-equals ph0 z ph1 ph2 ) ) ) $.
    kore-equality-to-eq $p |- ( \eq ph1 ph2 ) $= ? $.
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

$( ===================================== $)

kore-equals-reflexivity $p |- ( \kore-valid ph0 ( \kore-equals ph1 ph0 ph2 ph2 ) ) $= ? $.
kore-equals-reflexivity-v1 $p |- ( \kore-forall-sort x ( \kore-valid x ( \kore-equals ph0 x ph1 ph1 ) ) ) $= ? $.

$( ph /\ ph = ph $)
kore-dup-and $p |- ( \kore-forall-sort x ( \kore-valid x ( \kore-equals ph0 x ( \kore-and ph0 ph1 ph1 ) ph1 ) ) ) $= ? $.

${
    kore-rewrites-trans.0 $e |- ( \kore-valid ph0 ( \kore-rewrites ph0 ph1 ph2 ) ) $.
    kore-rewrites-trans.1 $e |- ( \kore-valid ph0 ( \kore-rewrites ph0 ph2 ph3 ) ) $.
    kore-rewrites-trans $p |- ( \kore-valid ph0 ( \kore-rewrites ph0 ph1 ph3 ) ) $= ? $.
$}

$( ph0 /\ ph1 => ph0 $)
${
    kore-and-elim-left-v1.0 $e |- ( \kore-forall-sort x ( \kore-valid ph0 ( \kore-and ph0 ph1 ph2 ) ) ) $.
    kore-and-elim-left-v1 $p |- ( \kore-forall-sort x ( \kore-valid ph0 ph1 ) ) $= ? $.
$}

$( modus ponens with one sort variable $)
${
    kore-mp-v1.0 $e |- ( \kore-forall-sort x ( \kore-valid ph1 ph0 ) ) $.
    kore-mp-v1.1 $e |- ( \kore-forall-sort x ( \kore-valid ph1 ( \kore-implies ph1 ph0 ph2 ) ) ) $.
    kore-mp-v1 $p |- ( \kore-forall-sort x ( \kore-valid ph1 ph2 ) ) $= ? $.
$}
