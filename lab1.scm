#lang racket
(define (nwd a b)
(cond ((= a b) a)
((> a b) (nwd (- a b) b))
(else (nwd a (- b a)))))

(define (nww a b)
(/ (* a b) (nwd a b)))

(define (odd x (isOdd #f))
(cond ((zero? x) isOdd)
(isOdd (odd (- x 1) #f))
(else (odd (- x 1) #t))))

(define (even x (isEven #t))
(cond ((zero? x) isEven)
(isEven (even (- x 1) #f))
(else (even (- x 1) #t))))

(define (same-values? p1 p2 x y)
(equal? (p1 x y) (p2 x y)))

(define (odd? x)
    (if (zero? x)
        #f
        (even? (- x 1))
    )
)

(define (even? x)
    (if (zero? x)
        #t
        (odd? (- x 1))
    )
)

(display (odd? 5))
(display (odd? 4))
(display "\n")
(display (even? 5))
(display (even? 4))