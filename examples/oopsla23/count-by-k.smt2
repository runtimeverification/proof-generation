(assert (forall ((a Int) (b Int)) (= (mod (+ a b) b) (mod a b))))

(assert (forall ((i Int) (l Int) (k Int))
    (=> (and (= (mod i k) 0)
             (not (< (+ i k) (* l k)))
             (< i (* l k)))
        (= (+ i k) (* l k)))
))

(assert (forall ((i Int) (l Int) (k Int))
    (=> (and (= (mod i k) 0)
             (< i (* l k)))
        (< (+ i k) (* l k)))
))
