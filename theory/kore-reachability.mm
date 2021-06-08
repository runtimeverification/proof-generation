$[ theory/kore.mm $]
$[ theory/kore-predicate.mm $]

${
    kore-rewrites-star-reflexivity.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
    kore-rewrites-star-reflexivity   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ph1 ph1 ) ) ) $= ? $.
$}

${
    kore-rewrites-star-union.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ( \kore-and ph0 ph1 ph3 ) ph4 ) ) ) $.
    kore-rewrites-star-union.1 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ( \kore-and ph0 ph2 ph3 ) ph5 ) ) ) $.
    kore-rewrites-star-union   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ( \kore-and ph0 ( \kore-or ph0 ph1 ph2 ) ph3 ) ( \kore-or ph0 ph4 ph5 ) ) ) ) $= ? $.
$}

${
    kore-rewrites-plus-union.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-plus ph0 ( \kore-and ph0 ph1 ph3 ) ph4 ) ) ) $.
    kore-rewrites-plus-union.1 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-plus ph0 ( \kore-and ph0 ph2 ph3 ) ph5 ) ) ) $.
    kore-rewrites-plus-union   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-plus ph0 ( \kore-and ph0 ( \kore-or ph0 ph1 ph2 ) ph3 ) ( \kore-or ph0 ph4 ph5 ) ) ) ) $= ? $.
$}

${
    kore-rewrites-star-subsumption-lhs.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph1 ph2 ) ) ) $.
    kore-rewrites-star-subsumption-lhs.1 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ph2 ph3 ) ) ) $.
    kore-rewrites-star-subsumption-lhs   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ph1 ph3 ) ) ) $= ? $.
$}

${
    kore-rewrites-star-subsumption-rhs.0 $e |- ( \imp th0 ( \in-sort ph2 ph0 ) ) $.
    kore-rewrites-star-subsumption-rhs.1 $e |- ( \imp th0 ( \in-sort ph3 ph0 ) ) $.
    kore-rewrites-star-subsumption-rhs.2 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ph1 ph2 ) ) ) $.
    kore-rewrites-star-subsumption-rhs.3 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph2 ph3 ) ) ) $.
    kore-rewrites-star-subsumption-rhs   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ph1 ph3 ) ) ) $= ? $.
$}

${
    kore-rewrites-plus-subsumption-lhs.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph1 ph2 ) ) ) $.
    kore-rewrites-plus-subsumption-lhs.1 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-plus ph0 ph2 ph3 ) ) ) $.
    kore-rewrites-plus-subsumption-lhs   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-plus ph0 ph1 ph3 ) ) ) $= ? $.
$}

${
    kore-rewrites-plus-subsumption-rhs.2 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-plus ph0 ph1 ph2 ) ) ) $.
    kore-rewrites-plus-subsumption-rhs.3 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph2 ph3 ) ) ) $.
    kore-rewrites-plus-subsumption-rhs   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-plus ph0 ph1 ph3 ) ) ) $= ? $.
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

${
    kore-rewrites-plus-branch.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-plus ph0 ph1 ( \kore-or ph0 ph2 ph3 ) ) ) ) $.
    kore-rewrites-plus-branch.1 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ph2 ph4 ) ) ) $.
    kore-rewrites-plus-branch   $p |- ( \imp th0  ( \kore-valid ph0 ( \kore-rewrites-plus ph0 ph1 ( \kore-or ph0 ph4 ph3 ) ) ) ) $= ? $.
$}

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
    kore-rewrites-star-intro   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ph1 ph2 ) ) ) $= ? $.
$}

${
    $d X ph0 $.
    $d X ph2 $.
    kore-rewrites-star-intro-alt.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
    kore-rewrites-star-intro-alt.1 $e |- ( \imp th0 ( \in-sort ph2 ph0 ) ) $.
    kore-rewrites-star-intro-alt.2 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-plus ph0 ph1 ph2 ) ) ) $.
    kore-rewrites-star-intro-alt   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ph1 ph2 ) ) ) $= ? $.
$}

${
    $d X ph0 $.
    $d X ph2 $.
    kore-rewrites-plus-intro.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
    kore-rewrites-plus-intro.1 $e |- ( \imp th0 ( \in-sort ph2 ph0 ) ) $.
    kore-rewrites-plus-intro.2 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites ph0 ph1 ph2 ) ) ) $.
    kore-rewrites-plus-intro   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-plus ph0 ph1 ph2 ) ) ) $= ? $.
$}

${
    kore-rewrites-star-transitivity.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
    kore-rewrites-star-transitivity.1 $e |- ( \imp th0 ( \in-sort ph2 ph0 ) ) $.
    kore-rewrites-star-transitivity.2 $e |- ( \imp th0 ( \in-sort ph3 ph0 ) ) $.
    kore-rewrites-star-transitivity.3 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ph1 ph2 ) ) ) $.
    kore-rewrites-star-transitivity.4 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ph2 ph3 ) ) ) $.
    kore-rewrites-star-transitivity   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ph1 ph3 ) ) ) $= ? $.
$}

${
    kore-rewrites-plus-transitivity.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
    kore-rewrites-plus-transitivity.1 $e |- ( \imp th0 ( \in-sort ph2 ph0 ) ) $.
    kore-rewrites-plus-transitivity.2 $e |- ( \imp th0 ( \in-sort ph3 ph0 ) ) $.
    kore-rewrites-plus-transitivity.3 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-plus ph0 ph1 ph2 ) ) ) $.
    kore-rewrites-plus-transitivity.4 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ph2 ph3 ) ) ) $.
    kore-rewrites-plus-transitivity   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-plus ph0 ph1 ph3 ) ) ) $= ? $.
$}

${
    $d X ph0 $.
    $d X ph2 $.
    kore-one-path-reaches-star-intro.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ph1 ph2 ) ) ) $.
    kore-one-path-reaches-star-intro   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-star ph0 ph1 ph2 ) ) ) $= ? $.
$}

${
    $d X ph0 $.
    $d X ph2 $.
    kore-one-path-reaches-star-intro-alt.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-plus ph0 ph1 ph2 ) ) ) $.
    kore-one-path-reaches-star-intro-alt   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-plus ph0 ph1 ph2 ) ) ) $= ? $.
$}

${
    kore-one-path-reaches-star-intro-alt2.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph1 ph2 ) ) ) $.
    kore-one-path-reaches-star-intro-alt2   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-star ph0 ph1 ph2 ) ) ) $= ? $.
$}

${
    $d X ph0 $.
    $d X ph2 $.
    kore-one-path-reaches-plus-intro.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-plus ph0 ph1 ph2 ) ) ) $.
    kore-one-path-reaches-plus-intro   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-plus ph0 ph1 ph2 ) ) ) $= ? $.
$}

${
    kore-one-path-reaches-star-transitivity.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
    kore-one-path-reaches-star-transitivity.1 $e |- ( \imp th0 ( \in-sort ph2 ph0 ) ) $.
    kore-one-path-reaches-star-transitivity.2 $e |- ( \imp th0 ( \in-sort ph3 ph0 ) ) $.
    kore-one-path-reaches-star-transitivity.3 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-star ph0 ph1 ph2 ) ) ) $.
    kore-one-path-reaches-star-transitivity.4 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-star ph0 ph2 ph3 ) ) ) $.
    kore-one-path-reaches-star-transitivity   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-star ph0 ph1 ph3 ) ) ) $= ? $.
$}

${
    kore-one-path-reaches-plus-transitivity.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
    kore-one-path-reaches-plus-transitivity.1 $e |- ( \imp th0 ( \in-sort ph2 ph0 ) ) $.
    kore-one-path-reaches-plus-transitivity.2 $e |- ( \imp th0 ( \in-sort ph3 ph0 ) ) $.
    kore-one-path-reaches-plus-transitivity.3 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-plus ph0 ph1 ph2 ) ) ) $.
    kore-one-path-reaches-plus-transitivity.4 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-star ph0 ph2 ph3 ) ) ) $.
    kore-one-path-reaches-plus-transitivity   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-plus ph0 ph1 ph3 ) ) ) $= ? $.
$}

${
    kore-one-path-reaches-star-reflexivity.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
    kore-one-path-reaches-star-reflexivity   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-star ph0 ph1 ph1 ) ) ) $= ? $.
$}

${
    kore-one-path-reaches-star-subsumption-lhs.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph1 ph2 ) ) ) $.
    kore-one-path-reaches-star-subsumption-lhs.1 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-star ph0 ph2 ph3 ) ) ) $.
    kore-one-path-reaches-star-subsumption-lhs   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-star ph0 ph1 ph3 ) ) ) $= ? $.
$}

${
    kore-one-path-reaches-star-subsumption-rhs.2 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-star ph0 ph1 ph2 ) ) ) $.
    kore-one-path-reaches-star-subsumption-rhs.3 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph2 ph3 ) ) ) $.
    kore-one-path-reaches-star-subsumption-rhs   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-star ph0 ph1 ph3 ) ) ) $= ? $.
$}

${
    kore-one-path-reaches-plus-subsumption-lhs.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph1 ph2 ) ) ) $.
    kore-one-path-reaches-plus-subsumption-lhs.1 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-plus ph0 ph2 ph3 ) ) ) $.
    kore-one-path-reaches-plus-subsumption-lhs   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-plus ph0 ph1 ph3 ) ) ) $= ? $.
$}

${
    kore-one-path-reaches-plus-subsumption-rhs.2 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-plus ph0 ph1 ph2 ) ) ) $.
    kore-one-path-reaches-plus-subsumption-rhs.3 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph2 ph3 ) ) ) $.
    kore-one-path-reaches-plus-subsumption-rhs   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-plus ph0 ph1 ph3 ) ) ) $= ? $.
$}

${
    kore-one-path-reaches-star-branch.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-star ph0 ph1 ( \kore-or ph0 ph2 ph3 ) ) ) ) $.
    kore-one-path-reaches-star-branch.1 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-star ph0 ph2 ph4 ) ) ) $.
    kore-one-path-reaches-star-branch   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-star ph0 ph1 ( \kore-or ph0 ph4 ph3 ) ) ) ) $= ? $.
$}

${
    kore-one-path-reaches-plus-branch.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-plus ph0 ph1 ( \kore-or ph0 ph2 ph3 ) ) ) ) $.
    kore-one-path-reaches-plus-branch.1 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-star ph0 ph2 ph4 ) ) ) $.
    kore-one-path-reaches-plus-branch   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-plus ph0 ph1 ( \kore-or ph0 ph4 ph3 ) ) ) ) $= ? $.
$}

${
    kore-one-path-reaches-star-union.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-star ph0 ( \kore-and ph0 ph1 ph3 ) ph4 ) ) ) $.
    kore-one-path-reaches-star-union.1 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-star ph0 ( \kore-and ph0 ph2 ph3 ) ph5 ) ) ) $.
    kore-one-path-reaches-star-union   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-star ph0 ( \kore-and ph0 ( \kore-or ph0 ph1 ph2 ) ph3 ) ( \kore-or ph0 ph4 ph5 ) ) ) ) $= ? $.
$}

${
    kore-one-path-reaches-plus-union.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-plus ph0 ( \kore-and ph0 ph1 ph3 ) ph4 ) ) ) $.
    kore-one-path-reaches-plus-union.1 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-plus ph0 ( \kore-and ph0 ph2 ph3 ) ph5 ) ) ) $.
    kore-one-path-reaches-plus-union   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-plus ph0 ( \kore-and ph0 ( \kore-or ph0 ph1 ph2 ) ph3 ) ( \kore-or ph0 ph4 ph5 ) ) ) ) $= ? $.
$}

${
    kore-reachability-one-path-circularity-lemma.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ( \kore-circularity ph0 ph1 ) ph1 ) ) ) $.
    kore-reachability-one-path-circularity-lemma   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ( \kore-well-founded ph0 ) ph1 ) ) ) $= ? $.
$}

${
    kore-reachability-permits-non-wf $p |- ( \kore-valid ph0 ( \kore-implies ph0 ( \kore-implies ph0 ( \kore-well-founded ph0 ) ( \kore-one-path-reaches-plus ph0 ph1 ph2 ) ) ( \kore-one-path-reaches-plus ph0 ph1 ph2 ) ) ) $= ? $.
$}

$( ${
    kore-implies-compat-in-kore-forall.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph1 ph2 ) ) ) $.
    kore-implies-compat-in-kore-forall   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ( \kore-forall ph3 ph0 x ph1 ) ( \kore-forall ph3 ph0 x ph2 ) ) ) ) $= ? $.
$} $)

$( Reachability rules $)

${
    kore-reachability-one-path-transitivity.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ( \kore-circularity ph0 ph1 ) ( \kore-one-path-reaches-plus ph0 ph2 ph3 ) ) ) ) $.
    kore-reachability-one-path-transitivity.1 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ( \kore-always ph0 ph1 )      ( \kore-one-path-reaches-star ph0 ph3 ph4 ) ) ) ) $.
    kore-reachability-one-path-transitivity   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ( \kore-circularity ph0 ph1 ) ( \kore-one-path-reaches-plus ph0 ph2 ph4 ) ) ) ) $= ? $.
$}

${
    kore-reachability-one-path-case-star.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph1 ( \kore-one-path-reaches-star ph0 ph2 ph4 ) ) ) ) $.
    kore-reachability-one-path-case-star.1 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph1 ( \kore-one-path-reaches-star ph0 ph3 ph4 ) ) ) ) $.
    kore-reachability-one-path-case-star   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph1 ( \kore-one-path-reaches-star ph0 ( \kore-or ph0 ph2 ph3 ) ph4 ) ) ) ) $= ? $.
$}
