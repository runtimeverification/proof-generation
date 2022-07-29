$[ theory/matching-logic-prelude.mm $]

$( Vectors and Linear Operations $)

$c \vector $.
vector-is-symbol $a #Symbol \vector $.

$( Other sorts that are used $)

$c \nat $.
nat-is-symbol $a #Symbol \nat $.

$c \matrix $.
matrix-is-symbol $a #Symbol \matrix $.

$c \term $.
term-is-symbol $a #Symbol \term $.

$c \layer $.
layer-is-symbol $a #Symbol \layer $.

$( Subsort relation $)

axiom-subsort-vec-term $a |- ( \included ( \inh \vector ) ( \inh \term ) ) $.

$( Binary Partial Function $)

$c \is-binary-partial-function $.
is-binary-partial-function-is-pattern $a #Pattern ( \is-binary-partial-function ph0 ph1 ph2 ph3 ) $.
${
    $d x y z ph0 $.
    $d x y z ph1 $.
    $d x y z ph2 $.
    $d x y z ph3 $.
    is-binary-partial-function-is-sugar $a #Notation ( \is-binary-partial-function ph0 ph1 ph2 ph3 )
                                          ( \sorted-forall x ph1
                                          ( \sorted-forall y ph2
                                          ( \sorted-exists z ph3 ( \included ( \app ph0 x y ) z ) ) ) ) $.
$}

$( Linear Operations $)

$c \projection $.
projection-is-symbol $a #Symbol \projection $.

vec-projection-is-pattern $a #Pattern ( \projection \vector \nat \vector ) $.
${
    $d x y z \projection $.
    $d x y z \vector $.
    $d x y z \nat $.
    vec-projection-is-sugar $a #Notation ( \projection \vector \nat \vector )
                                          ( \sorted-forall x \vector
                                          ( \sorted-forall y \nat
                                          ( \sorted-exists z \vector ( \included ( \app \projection x y ) z ) ) ) ) $.
$}

$c \addition $.
addition-is-symbol $a #Symbol \addition $.

vec-addition-is-pattern $a #Pattern ( \addition \vector \vector \vector ) $.
${
    $d x y z \addition $.
    $d x y z \vector $.
    vec-addition-is-sugar $a #Notation ( \addition \vector \vector \vector )
                                          ( \sorted-forall x \vector
                                          ( \sorted-forall y \vector
                                          ( \sorted-exists z \vector ( \included ( \app \addition x y ) z ) ) ) ) $.
$}

$c \matMult $.
matMult-is-symbol $a #Symbol \matMult $.

vec-matMult-is-pattern $a #Pattern ( \matMult \matrix \vector \vector ) $.
${
    $d x y z \matMult $.
    $d x y z \matrix $.
    $d x y z \vector $.
    vec-matMult-is-sugar $a #Notation ( \matMult \matrix \vector \vector )
                                          ( \sorted-forall x \matrix
                                          ( \sorted-forall y \vector
                                          ( \sorted-exists z \vector ( \included ( \app \matMult x y ) z ) ) ) ) $.
$}

$c \eval $.
eval-is-symbol $a #Symbol \eval $.

term-eval-is-pattern $a #Pattern ( \eval \term \layer \vector ) $.
${
    $d x y z \eval $.
    $d x y z \term $.
    $d x y z \layer $.
    $d x y z \vector $.
    term-eval-is-sugar $a #Notation ( \eval \term \layer \vector )
                                          ( \sorted-forall x \term
                                          ( \sorted-forall y \layer
                                          ( \sorted-exists z \vector ( \included ( \app \eval x y ) z ) ) ) ) $.
$}

axiom-constant-term $a |- ( \sorted-forall x \vector 
                          ( \sorted-forall y \layer ( \eq ( app \eval x y ) x ) ) ) $.


$( Linear Operations Lift to Terms $)

term-projection-is-pattern $a #Pattern ( \projection \term \nat \term ) $.
${
    $d x y z \projection $.
    $d x y z \term $.
    $d x y z \nat $.
    term-projection-is-sugar $a #Notation ( \projection \term \nat \term )
                                          ( \sorted-forall x \term
                                          ( \sorted-forall y \nat
                                          ( \sorted-exists z \term ( \included ( \app \projection x y ) z ) ) ) ) $.
$}

term-addition-is-pattern $a #Pattern ( \addition \term \term \term ) $.
${
    $d x y z \addition $.
    $d x y z \term $.
    term-addition-is-sugar $a #Notation ( \addition \term \term \term )
                                          ( \sorted-forall x \term
                                          ( \sorted-forall y \term
                                          ( \sorted-exists z \term ( \included ( \app \addition x y ) z ) ) ) ) $.
$}

term-matMult-is-pattern $a #Pattern ( \matMult \matrix \term \term ) $.
${
    $d x y z \matMult $.
    $d x y z \matrix $.
    $d x y z \term $.
    term-matMult-is-sugar $a #Notation ( \matMult \matrix \term \term )
                                          ( \sorted-forall x \matrix
                                          ( \sorted-forall y \term
                                          ( \sorted-exists z \term ( \included ( \app \matMult x y ) z ) ) ) ) $.
$}

axiom-term-projection $a |- ( \sorted-forall x \term 
                            ( \sorted-forall y \nat
                            ( \sorted-forall z \layer 
                            ( \eq ( \app \eval ( \app \projection x y ) z ) ( \app \projection ( \app \eval x z ) y ) ) ) ) ) $.

axiom-term-addition $a |- ( \sorted-forall x \term 
                          ( \sorted-forall y \term
                          ( \sorted-forall z \layer 
                          ( \eq ( \app \eval ( \app \addition x y ) z ) ( \app \addition ( \app \eval x z ) ( \app \eval y z ) ) ) ) ) ) $.

axiom-term-matmult $a |- ( \sorted-forall x \term 
                         ( \sorted-forall y \matrix
                         ( \sorted-forall z \layer 
                         ( \eq ( \app \eval ( \app \matMult y x ) z ) ( \app \matMult y ( \app \eval x z ) ) ) ) ) ) $.

$( Dynamic Propagation $)