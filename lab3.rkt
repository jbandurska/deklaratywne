#lang racket
;10
(define (product term next a b)
(if (> a b) 1 (* (term a) (product term next (next a) b))))
(displayln (product identity (lambda (a) (+ 1 a)) 1 5))

;10 factorial
(define (factorial n) (product identity (lambda (a) (+ a 1)) 1 n))
(displayln (factorial 5))

;10 for pi
(define (product-pi n)
(* 4.0
(product (lambda (x) (/ (* (- x 1) (+ x 1)) (* x x))) (lambda (a) (+ a 2)) 3 n)
))
(displayln (product-pi 10))

;11
(define (accumulate combiner null-value term next a b)
(if (> a b) null-value (combiner (term a) (accumulate combiner null-value term next (next a) b))))

(define (accumulate-sum a b) (accumulate + 0 identity (lambda (a) (+ 1 a)) a b))
(displayln (accumulate-sum 2 5))

(define (accumulate-product a b) (accumulate * 1 identity (lambda (a) (+ 1 a)) a b))
(displayln (accumulate-product 2 5))

;12
(define (filter-accumulate combiner pred null-value term next a b)
(cond ((> a b) null-value)
 ((pred a) (combiner (term a) (filter-accumulate combiner pred null-value term next (next a) b)))
 (else (filter-accumulate combiner pred null-value term next (next a) b))
 )
)

(define (prime? a (i 2))
(cond ((> (* i 2) a) #t)
((= (modulo a i) 0) #f)
(else (prime? a (+ 1 i)))))

(display "\nDodaj kwadraty liczb pierwszych od 3 do 7 => ")
(displayln (filter-accumulate + prime? 0 (lambda (a) (* a a)) (lambda (a) (+ 1 a)) 3 7))

(define (nwd a b)
(cond ((= a b) a)
((> a b) (nwd (- a b) b))
(else (nwd a (- b a)))))

(define (smaller? i n) (< i n))
(define (pred-zad-12 i) (and (smaller? i 6) (= (nwd i 6) 1)))

(display "\nPomnóż liczby mniejsze od n=6 takie, że nwd(i,n)=1 => ")
(displayln (filter-accumulate * pred-zad-12 1 identity (lambda (a) (+ 1 a)) 1 9))

;13
(define (f g) (g 2))
(displayln (f (lambda (z) (+ z (* 3 z)))))
(displayln (2 2))
