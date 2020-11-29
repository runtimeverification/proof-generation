$[ theory/matching-logic-prelude.mm $]
$[ theory/matching-logic-prelude-lemmas.mm $]

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
kore-top-is-sugar $a #Equal ( \kore-top ph0 ) ( \inh ph0 ) $.

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

$( Kore lemmas $)

kore-top-valid $p |- ( \kore-valid ph0 ( \kore-top ph0 ) ) $= ph0-is-pattern inh-is-pattern ph0-is-pattern inh-is-pattern eq-is-pattern ph0-is-pattern ph0-is-pattern kore-top-is-pattern kore-valid-is-pattern ph0-is-pattern inh-is-pattern lemma-eq-reflexivity ph0-is-pattern ph0-is-pattern kore-top-is-pattern kore-valid-is-pattern ph0-is-pattern inh-is-pattern ph0-is-pattern kore-top-is-pattern eq-is-pattern ph0-is-pattern inh-is-pattern ph0-is-pattern inh-is-pattern eq-is-pattern ph0-is-pattern ph0-is-pattern kore-top-is-pattern kore-valid-is-sugar ph0-is-pattern inh-is-pattern ph0-is-pattern kore-top-is-pattern ph0-is-pattern inh-is-pattern ph0-is-pattern inh-is-pattern ph0-is-pattern inh-is-pattern equal-reflexivity ph0-is-pattern kore-top-is-sugar equal-eq equal-transitivity equal-proof $.
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

$( replace a subpattern with an equal one $)
${
    $d z ph0 $.
    kore-equality.0 $e |- ( \kore-forall-sort z ( \kore-valid z ( \kore-equals ph0 z ph1 ph2 ) ) ) $.
    kore-equality.1 $e |- ph3 $.
    kore-equality.2 $e #Substitution ph3 ph4 ph1 x $.
    kore-equality.3 $e #Substitution ph5 ph4 ph2 x $.
    kore-equality $p |- ph5 $= ? $.
$}

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
