(assert (forall ((a Int) (b Int))
    (=> (and (> a 0) (> b 0))
        (= (* a (^ a (+ b (- 1)))) (^ a b)))
))

(assert (forall ((a Int) (b Int))
    (! (=> (= b 0) (= (^ a b) 1))
    :pattern ((^ a b)))
))
