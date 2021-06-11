$[ theory/kore.mm $]

${
    $d x ph1 $.
    disjointness-exists.0 $e |- ( \not ( \and ph1 ( \sorted-exists x ph2 ph3 ) ) ) $.
    disjointness-exists   $p |- ( \imp ( \in-sort x ph2 ) ( \not ( \and ph1 ph3 ) ) ) $= ? $.
$}

${
    disjointness-to-not-in.0 $e |- ( \imp th0 ( \not ( \and ph1 ph2 ) ) ) $.
    disjointness-to-not-in   $p |- ( \imp th0 ( \kore-valid ph3 ( \kore-not ph3 ( \kore-in ph0 ph3 ph1 ph2 ) ) ) ) $= ? $.
$}
