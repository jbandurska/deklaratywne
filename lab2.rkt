#lang racket
;6 a)

(define (factorial n)
(if (= n 1)
1
(* (factorial (- n 1)) n)
)
)

;6 b)

(define (factorial_help n i acc)
(if (< n i)
acc
(factorial_help n (+ i 1) (* i acc))))

(define (factorial_tail n)
(factorial_help n 1 1))

(display "Rec Factorial 4 => ")
(display (factorial 4))
(display "\nTailrec Factorial 4 => ")
(display (factorial_tail 4))

;7 a)
(define (fibonacci2 n (a 1) (b 1))
(cond ((= n 1) 0)
((= n 2) 1)
(else (+ (fibonacci2 (- n 1)) (fibonacci2 (- n 2))))
)
)

(display "\n\nRec Fibonacci 4 => ")
(display (fibonacci2 4))

;7 b)
(define (fibonacci n (a 0) (b 1))
(if (= n 1)
a
(fibonacci (- n 1) b (+ a b))
)
)

(display "\nTailrec Fibonacci 4 => ")
(display (fibonacci 4))

;8 a)
(define (exp b e)
(cond ((= e 0) 1)
((= (modulo e 2) 0) (* (exp b (/ e 2)) (exp b (/ e 2))))
(else (* (exp b (- e 1)) b))))
(display "\n\nRec Exp 2 6 => ")
(display (exp 2 6))

;8 b)
(define (exp2-helper b e acc i)
    (cond ((= e i) acc)
    ((< (* i 2) e) (exp2-helper b e (* acc acc) (* i 2)))
    (else (exp2-helper b e (* acc b) (+ i 1))))    
)

(define (exp2 b e)
    (cond ((= e 0) 1)
        ((= e 1) b)
        (else (exp2-helper b e b 1))
    )
)

(display "\nTailrec Exp 2 6 => ")
(displayln (exp2 2 6))

;9
; Nie może być tak zdefiniowane, ponieważ if najpierw sprawdza warunek a potem oblicza wynik,
; a cond najpierw oblicza wyniki, a potem sprawdza warunek.
(define (new-if condition consequence alternative)
(cond (condition consequence)
(else alternative)))

(displayln "\n\nIf and new-if difference:")
(display "if => ")
(if #t (display "1 ") (display "2 "))

(display "\nnew-if => ")
(new-if #t (display "1 ") (display "2 "))