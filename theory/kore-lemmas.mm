$[ theory/kore.mm $]
$[ theory/kore-substitution.mm $]
$( $[ theory/kore-propositional.mm $] $)
$[ theory/kore-sorting.mm $]
$[ theory/kore-notation.mm $]
$[ theory/kore-predicate.mm $]
$[ theory/matching-logic-membership.mm $]
$[ theory/matching-logic-disjointness.mm $]

$( ${
    $e |- ( \imp th0 ph0 ) $.

    $e |- ( \imp th0 th1 ) $.

    ph3 is a functional pattern in sort ph2
    $e |- ( \imp th1 ( \kore-valid ph1 ( \kore-exists ph2 ph1 x ( \kore-equals ph2 ph1 x ph3 ) ) ) ) $.

    $e #Substitution ph4 ( \imp th0 ph0 ) ph3 y $.

    $p |- ph4 $.
$} $)


kore-dup-and $p |- ( \imp ( \kore-is-sort x ) ( \kore-valid x ( \kore-equals ph0 x ( \kore-and ph0 ph1 ph1 ) ph1 ) ) ) $= ? $.

${
    kore-rewrites-ignore-ensures.0 $e |- ( \imp th0 ( \in-sort ph3 ph0 ) ) $.
    kore-rewrites-ignore-ensures.1 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites ph0 ph1 ( \kore-and ph0 ph2 ph3 ) ) ) ) $.
    kore-rewrites-ignore-ensures   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites ph0 ph1 ph3 ) ) ) $= ? $.
$}

${
    kore-rewrites-subsumption-lhs.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph1 ph2 ) ) ) $.
    kore-rewrites-subsumption-lhs.1 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites ph0 ph2 ph3 ) ) ) $.
    kore-rewrites-subsumption-lhs   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites ph0 ph1 ph3 ) ) ) $= ? $.
$}

${
    kore-rewrites-subsumption-rhs.0 $e |- ( \imp th0 ( \in-sort ph2 ph0 ) ) $.
    kore-rewrites-subsumption-rhs.1 $e |- ( \imp th0 ( \in-sort ph3 ph0 ) ) $.
    kore-rewrites-subsumption-rhs.2 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites ph0 ph1 ph2 ) ) ) $.
    kore-rewrites-subsumption-rhs.3 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph2 ph3 ) ) ) $.
    kore-rewrites-subsumption-rhs   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites ph0 ph1 ph3 ) ) ) $= ? $.
$}

${
    kore-and-top-alt.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
    kore-and-top-alt.1 $e |- ( \imp th0 ( \in-sort ph2 ph0 ) ) $.
    kore-and-top-alt $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ( \kore-and ph0 ( \kore-and ph0 ph1 ( \kore-top ph0 ) ) ph2 ) ( \kore-and ph0 ph1 ph2 ) ) ) ) $= ? $.
$}

${
    $( constraint before rewriting can be passed to the term after rewriting $)
    $( kore-rewrites-constraint-lemma.0 $e |- ( \kore-is-predicate ph0 ph1 ) $. $)
    kore-rewrites-constraint-lemma.1 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites ph0 ( \kore-and ph0 ph1 ph2 ) ph3 ) ) ) $.
    kore-rewrites-constraint-lemma   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites ph0 ( \kore-and ph0 ph1 ph2 ) ( \kore-and ph0 ph1 ph3 ) ) ) ) $= ? $.
$}

${
    $d X ph0 $.
    $d X ph2 $.
    kore-rewrites-star-intro.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
    kore-rewrites-star-intro.1 $e |- ( \imp th0 ( \in-sort ph2 ph0 ) ) $.
    kore-rewrites-star-intro.2 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites ph0 ph1 ph2 ) ) ) $.
    kore-rewrites-star-intro $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ph1 ph2 ) ) ) $= ? $.
$}

${
    kore-implies-reflexivity.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
    kore-implies-reflexivity $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph1 ph1 ) ) ) $= ? $.
$}

${
    kore-rewrites-star-constraint-simplification.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph1 ph2 ) ) ) $.
    kore-rewrites-star-constraint-simplification   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ( \kore-and ph0 ph1 ph3 ) ( \kore-and ph0 ph2 ph3 ) ) ) ) $= ? $.
$}

${
    kore-rewrites-star-transitivity.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
    kore-rewrites-star-transitivity.1 $e |- ( \imp th0 ( \in-sort ph2 ph0 ) ) $.
    kore-rewrites-star-transitivity.2 $e |- ( \imp th0 ( \in-sort ph3 ph0 ) ) $.
    kore-rewrites-star-transitivity.3 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ph1 ph2 ) ) ) $.
    kore-rewrites-star-transitivity.4 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ph2 ph3 ) ) ) $.
    kore-rewrites-star-transitivity $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ph1 ph3 ) ) ) $= ? $.
$}

kore-top-valid $p |- ( \kore-valid ph0 ( \kore-top ph0 ) ) $= ? $.

${
    kore-in-reflexivity.0 $e |- ( \imp th0 ( \in-sort ph2 ph0 ) ) $.
    kore-in-reflexivity $p |- ( \imp th0 ( \kore-valid ph1 ( \kore-in ph0 ph1 ph2 ph2 ) ) ) $= ? $.
$}

${
    kore-and-intro-alt.0 $e |- ( \imp th0 ( \kore-valid ph0 ph1 ) ) $.
    kore-and-intro-alt.1 $e |- ( \imp th0 ( \kore-valid ph0 ph2 ) ) $.
    kore-and-intro-alt $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-and ph0 ph1 ph2 ) ) ) $= ? $.
$}

${
    kore-mp.0 $e |- ( \imp th0 ( \kore-valid ph0 ph1 ) ) $.
    kore-mp.1 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph1 ph2 ) ) ) $.
    kore-mp $p |- ( \imp th0 ( \kore-valid ph0 ph2 ) ) $= ? $.
$}

${
    kore-and-top.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-and ph0 ph1 ( \kore-top ph0 ) ) ) ) $.
    kore-anp-top $p |- ( \imp th0 ( \kore-valid ph0 ph1 ) ) $= ? $.
$}

kore-equals-reflexivity $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-equals ph1 ph0 ph2 ph2 ) ) ) $=  ? $.

${
    kore-weakening.0 $e |- ( \imp th0 ( \kore-valid ph0 ph1 ) ) $.
    kore-weakening   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph2 ph1 ) ) ) $= ? $.
$}

${
    kore-imp-conj-simplify.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph1 ph2 ) ) ) $.
    kore-imp-conj-simplify.1 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph3 ( \kore-and ph0 ph1 ph4 ) ) ) ) $.
    kore-imp-conj-simplify   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph3 ( \kore-and ph0 ph2 ph4 ) ) ) ) $= ? $.
$}

${
    kore-equality-in-constraint.0 $e #Substitution ph6 ph5 ph3 x $.
    kore-equality-in-constraint.1 $e #Substitution ph7 ph5 ph4 x $.
    kore-equality-in-constraint   $p
        |- ( \imp th0 ( \kore-valid ph0 ( \kore-iff ph0
            ( \kore-and ph0 ( \kore-and ph0 ph8 ( \kore-equals ph2 ph0 ph3 ph4 ) ) ph6 )
            ( \kore-and ph0 ( \kore-and ph0 ph8 ( \kore-equals ph2 ph0 ph3 ph4 ) ) ph7 ) ) ) ) $= ? $.
$}

${
    kore-rewrites-star-reflexivity.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
    kore-rewrites-star-reflexivity $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ph1 ph1 ) ) ) $= ? $.
$}

${
    kore-rewrites-star-union.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ( \kore-and ph0 ph1 ph3 ) ph4 ) ) ) $.
    kore-rewrites-star-union.1 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ( \kore-and ph0 ph2 ph3 ) ph5 ) ) ) $.
    kore-rewrites-star-union   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ( \kore-and ph0 ( \kore-or ph0 ph1 ph2 ) ph3 ) ( \kore-or ph0 ph4 ph5 ) ) ) ) $= ? $.
$}

${
    kore-rewrites-star-subsumption-rhs.0 $e |- ( \imp th0 ( \in-sort ph2 ph0 ) ) $.
    kore-rewrites-star-subsumption-rhs.1 $e |- ( \imp th0 ( \in-sort ph3 ph0 ) ) $.
    kore-rewrites-star-subsumption-rhs.2 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ph1 ph2 ) ) ) $.
    kore-rewrites-star-subsumption-rhs.3 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph2 ph3 ) ) ) $.
    kore-rewrites-star-subsumption-rhs   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ph1 ph3 ) ) ) $= ? $.
$}

${
    kore-rewrites-star-prune.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-not ph0 ph2 ) ) ) $.
    kore-rewrites-star-prune.1 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ph1 ( \kore-or ph0 ( \kore-and ph0 ph2 ph3 ) ph4 ) ) ) ) $.
    kore-rewrites-star-prune   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ph1 ph4 ) ) ) $= ? $.
$}

${
    kore-rewrites-star-branch.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ph1 ( \kore-or ph0 ph2 ph3 ) ) ) ) $.
    kore-rewrites-star-branch.1 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ph2 ph4 ) ) ) $.
    kore-rewrites-star-branch   $p |- ( \imp th0  ( \kore-valid ph0 ( \kore-rewrites-star ph0 ph1 ( \kore-or ph0 ph4 ph3 ) ) ) ) $= ? $.
$}

$( ${
    $d z ph0 $.
    $d z ph1 $.
    $d z ph2 $.
    $d z ph3 $.
    $d z ph5 $.
    $d z x $.
    kore-equality-h1.0 $e |- ( \imp th0 ( \kore-forall-sort z ( \kore-valid z ( \kore-equals ph0 z ph1 ph2 ) ) ) ) $.
    kore-equality-h1.1 $e |- ph3 $.
    kore-equality-h1.2 $e #Substitution ph3 ph4 ph1 x $.
    kore-equality-h1.3 $e #Substitution ph5 ph4 ph2 x $.
    kore-equality-h1.4 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
    kore-equality-h1.5 $e |- ( \imp th0 ( \in-sort ph2 ph0 ) ) $.
    kore-equality-h1.6 $e |- ( \kore-is-sort ph0 ) $.
    kore-equality-h1 $p |- ph5 $= ? $.
$}

${
    kore-forall-elim-h1.0 $e |- ( \imp th0 ( \kore-valid ph1 ph2 ) ) $.
    kore-forall-elim-h1.1 $e |- ( \imp th0 ( \kore-valid ph3 ( \kore-exists ph0 ph3 y ( \kore-equals ph0 ph3 y ph4 ) ) ) ) $.
    kore-forall-elim-h1.2 $e #Substitution ph5 ph2 ph3 x $.
    kore-forall-elim-h1.3 $e |- ( \imp th0 ( \in-sort ph3 ph0 ) ) $.
    kore-forall-elim-h1.4 $e |- ( \imp th0 ( \in-sort ph4 ph1 ) ) $.
    kore-forall-elim-h1   $p |- ( \imp th0 ( \kore-valid ph1 ph4 ) ) $= ? $.
$}

${
    kore-implies-reflexivity-h1.1 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
    kore-implies-reflexivity-h1   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph1 ph1 ) ) ) $= ? $.
$}

${
    $d x ph1 $.
    
    $d y ph1 $.
    $d y x $.

    kore-forall-sort-elim-h1.0 $e |- ( \imp th0 ( \kore-is-sort x ) ) $.
    kore-forall-sort-elim-h1.1 $e |- ( \imp th3 th2 ) $.

    kore-forall-sort-elim-h1.2 $e |- ( \imp th0 ph0 ) $.
    kore-forall-sort-elim-h1.3 $e |- ( \kore-is-sort ph1 ) $.
    kore-forall-sort-elim-h1.4 $e #Substitution ( \imp th2 ph2 ) ( \imp th1 ph0 ) ph1 x $.

    kore-forall-sort-elim-h1 $p |- ( \imp th3 ph2 ) $= ? $.
$} $)
