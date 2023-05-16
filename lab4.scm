#lang racket
;14
(define (root f a b)
(cond ((and (< (f (/ (+ a b) 2)) 0.00001) (> (f (/ (+ a b) 2)) -0.00001)) (/ (+ a b) 2.0))
((< (f (/ (+ a b) 2)) 0) (root f (/ (+ a b) 2) b))
(else (root f a (/ (+ a b) 2)))))
(displayln (root (lambda (x) (+ (* 2 x) 4)) -10 10))

;15
; ((comb square double) 5) => ((comb (lambda (n) (* n n)) double) 5) => ; ((comb (lambda (n) (* n n)) (lambda (n) (+ n n))) 5) =>
; ((lambda (x) ((lambda (n) (* n n)) (lambda (n) (+ n n)) x)) 5) => ; ((lambda (n) (* n n)) ((lambda (n) (+ n n)) 5)) => ; ((lambda (n) (* n n)) (+ 5 5)) => ((lambda (n) (* n n)) 10) => ; (* 10 10) => 100

;16
(define (iter f n)
(iter-helper f f n))

(define (iter-helper f-acum f n)
(if (= n 1) f-acum (iter-helper (lambda (x) (f (f-acum x))) f (- n 1))))

(displayln ((iter (lambda (x) (* 2 x)) 3) 4))
; f(x) = x*2
; f(f(f(4))) = f(f(8)) = f(16) = 32

; 17

(define (append l m)
    (cond ((and (empty? l) (empty? m)) `())
        ((empty? l) (cons (car m) (append l (cdr m))))
        (else (cons (car l) (append (cdr l) m)))
    )
)
(displayln (append `(1 2 3) `(4 5 6)))

(define (last l)
    (if (empty? (cdr l)) (car l) (last (cdr l)))
)
(displayln (last `(1 2 3)))

; (define (reverse l (acc `()))
;     (if (empty? l) 
;         acc
;         (reverse (cdr l) (cons (car l) acc))
;     )
; )
(define (reverse l)
    (if (empty? l) 
        `()
        (append (reverse (cdr l)) (cons (car l) `()))
    )
)
(displayln (reverse `(1 2 3 4 5 6)))

(define (delete x l)
    (cond
        ((empty? l) `())
        ((= (car l) x) (delete x (cdr l)))
        (else (cons (car l) (delete x (cdr l))))
    )
)
(displayln (delete 3 `(1 2 3 4 5)))

(define (pairing l1 l2)
    (if (empty? l1)
        `()
        (cons (cons (car l1) (cons (car l2) `())) (pairing (cdr l1) (cdr l2)))
    )
)
(displayln (pairing `(1 2 3) `(a b c)))
(displayln (pair? (car (pairing `(1 2 3) `(a b c))))) ; Jest parą więc może być

(define (inner-split x l l1 l2)
    (cond 
        ((empty? l) (cons l1 (cons l2 `())))
        ((< (car l) x) (inner-split x (cdr l) (cons (car l) l1) l2))
        (else (inner-split x (cdr l) l1 (cons (car l) l2))) 
    )
)
(define (split x l)
    (inner-split x l `() `())
)
(displayln (split 5 `(1 7 3 8 5 4 2 0 9)))