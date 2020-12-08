$[ theory/matching-logic-prelude.mm $]

${
    hyp-syllogism.0 $e |- ( \imp ph0 ph1 ) $.
    hyp-syllogism.1 $e |- ( \imp ph1 ph2 ) $.
    hyp-syllogism $p |- ( \imp ph0 ph2 ) $= ? $.
$}

${
    imp-compat-in-and.0 $e |- ( \imp ph0 ph1 ) $.
    imp-compat-in-and.1 $e |- ( \imp ph2 ph3 ) $.
    imp-compat-in-and $p |- ( \imp ( \and ph0 ph2 ) ( \and ph1 ph3 ) ) $= ? $.
$}

${
    iff-left.0 $e |- ( \iff ph0 ph1 ) $.
    iff-left $p |- ( \imp ph0 ph1 ) $= ? $.
$}

iff-reflexivity $p |- ( \iff ph0 ph0 ) $= ? $.

${
    iff-symmetry.0 $e |- ( \iff ph0 ph1 ) $.
    iff-symmetry $p |- ( \iff ph1 ph0 ) $= ? $.
$}

${
    iff-transitivity.0 $e |- ( \iff ph0 ph1 ) $.
    iff-transitivity.1 $e |- ( \iff ph1 ph2 ) $.
    iff-transitivity $p |- ( \iff ph0 ph2 ) $= ? $.
$}

${
    iff-compat-in-or.0 $e |- ( \iff ph0 ph1 ) $.
    iff-compat-in-or.1 $e |- ( \iff ph2 ph3 ) $.
    iff-compat-in-or $p |- ( \iff ( \or ph0 ph2 ) ( \or ph1 ph3 ) ) $= ? $.
$}

${
    iff-compat-in-and.0 $e |- ( \iff ph0 ph1 ) $.
    iff-compat-in-and.1 $e |- ( \iff ph2 ph3 ) $.
    iff-compat-in-and $p |- ( \iff ( \and ph0 ph2 ) ( \and ph1 ph3 ) ) $= ? $.
$}

${
    iff-compat-in-not.0 $e |- ( \iff ph0 ph1 ) $.
    iff-compat-in-not $p |- ( \iff ( \not ph0 ) ( \not ph1 ) ) $= ? $.
$}

imp-to-or $p |- ( \iff ( \imp ph0 ph1 ) ( \or ( \not ph0 ) ph1 ) ) $= ? $.
bot-to-and $p |- ( \iff \bot ( \and ph0 ( \not ph0 ) ) ) $= ? $.
top-to-or $p |- ( \iff \top ( \or ph0 ( \not ph0 ) ) ) $= ? $.
iff-to-and $p |- ( \iff ( \iff ph0 ph1 ) ( \and ( \or ( \not ph0 ) ph1 ) ( \or ( \not ph1 ) ph0 ) ) ) $= ? $.

and-associativity $p |- ( \iff ( \and ( \and ph0 ph1 ) ph2 ) ( \and ph0 ( \and ph1 ph2 ) ) ) $= ? $.
and-commutativity $p |- ( \iff ( \and ph0 ph1 ) ( \and ph1 ph0 ) ) $= ? $.

or-associativity $p |- ( \iff ( \or ( \or ph0 ph1 ) ph2 ) ( \or ph0 ( \or ph1 ph2 ) ) ) $= ? $.
or-commutativity $p |- ( \iff ( \or ph0 ph1 ) ( \or ph1 ph0 ) ) $= ? $.

or-left-distributivity $p |- ( \iff ( \or ( \and ph0 ph1 ) ph2 ) ( \and ( \or ph0 ph2 ) ( \or ph1 ph2 ) ) ) $= ? $.
or-right-distributivity $p |- ( \iff ( \or ph0 ( \and ph1 ph2 ) ) ( \and ( \or ph0 ph1 ) ( \or ph0 ph2 ) ) ) $= ? $.

de-morgan-and $p |- ( \iff ( \not ( \and ph0 ph1 ) ) ( \or ( \not ph0 ) ( \not ph1 ) ) ) $= ? $.
de-morgan-or $p |- ( \iff ( \not ( \or ph0 ph1 ) ) ( \and ( \not ph0 ) ( \not ph1 ) ) ) $= ? $.

double-negation $p |- ( \iff ( \not ( \not ph0 ) ) ph0 ) $= ? $.

or-idempotency $p |- ( \iff ( \or ph0 ph0 ) ph0 ) $= ? $.
and-idempotency $p |- ( \iff ( \and ph0 ph0 ) ph0 ) $= ? $.

or-complement $p |- ( \iff ( \or ( \not ph0 ) ph0 ) \top ) $= ? $.

and-top $p |- ( \iff ( \and \top ph0 ) ph0 ) $= ? $.
or-top $p |- ( \iff ( \or \top ph0 ) \top ) $= ? $.

and-bot $p |- ( \imp ( \and \bot ph0 ) \bot ) $= ? $.

and-elim-left $p |- ( \imp ( \and ph0 ph1 ) ph0 ) $= ? $.

contradiction $p |- ( \imp ( \imp ( \not ph0 ) \bot ) ph0 ) $= ? $.

$( three versions of resolution $)
resolution-1 $p |- ( \imp ( \and ( \or ( \not ph0 ) ph1 ) ( \or ph0 ph2 ) ) ( \or ph1 ph2 ) ) $= ? $.
resolution-2 $p |- ( \imp ( \and ( \or ( \not ph0 ) ph1 ) ph0 ) ph1 ) $= ? $.
resolution-3 $p |- ( \imp ( \and ( \not ph0 ) ( \or ph0 ph1 ) ) ph1 ) $= ? $.
resolution-4 $p |- ( \imp ( \and ( \not ph0 ) ph0 ) \bot ) $= ? $.
