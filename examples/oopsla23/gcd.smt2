(declare-fun gcd (Int Int) Int)

(assert (forall ((a Int) (b Int))
    (=> (and (> a 0) (> b 0) (> a b))
        (= (gcd a b) (gcd (- a b) b)))
))

(assert (forall ((a Int) (b Int)) (= (gcd a b) (gcd b a))))

(assert (forall ((a Int)) (= (gcd a a) a)))
