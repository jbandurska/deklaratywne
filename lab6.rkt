#lang racket

;23
(define (square a) (* a a))

(define (+c z1 z2)
(make-rectangular (+ (real-part z1) (real-part z2))
(+ (imag-part z1) (imag-part z2))))

(define (-c z1 z2)
(make-rectangular (- (real-part z1) (real-part z2))
(- (imag-part z1) (imag-part z2))))

(define (*c z1 z2)
(make-polar (* (magnitude z1) (magnitude z2))
(+ (angle z1) (angle z2))))

(define (/c z1 z2)
(make-polar (/ (magnitude z1) (magnitude z2))
(- (angle z1) (angle z2))))

(define (attach-type type contents) (cons type contents))
(define (type datum) (car datum))
(define (contents datum) (cdr datum))
(define (rectangular? z) (eq? (type z) 'rectangular))
(define (polar? z) (eq? (type z) 'polar))
(define (make-rectangular x y)
(attach-type 'rectangular (cons x y)))
(define (make-polar x y)
(attach-type 'polar (cons x y)))

;;; Getting the Components
(define (real-part z)
(cond ((rectangular? z)
(real-part-rectangular (contents z)))
((polar? z)
(real-part-polar (contents z)))))

(define (imag-part z)
(cond ((rectangular? z)
(imag-part-rectangular (contents z)))
((polar? z)
(imag-part-polar (contents z)))))

(define (magnitude z)
(cond ((rectangular? z)
(magnitude-rectangular (contents z)))
((polar? z)
(magnitude-polar (contents z)))))

(define (angle z)
(cond ((rectangular? z)
(angle-rectangular (contents z)))
((polar? z)
(angle-polar (contents z)))))

(define (real-part-rectangular z) (car z))
(define (imag-part-rectangular z) (cadr z))

(define (magnitude-rectangular z)
(sqrt (+ (square (car z)) (square (cadr z)))))

(define (angle-rectangular z) (atan (cadr z) (car z)))
(define (real-part-polar z) (* (car z) (cos (cadr z))))
(define (imag-part-polar z) (* (car z) (sin (cadr z))))
(define (magnitude-polar z) (car z))
(define (angle-polar z) (cadr z))

; 24
(define (plus . l)
(define (help-plus l)
(if (empty? l) 0 (+ (car l) (help-plus (cdr l)))))
(help-plus l))

(define (par . f)
    (lambda (x) 
        (reverse (help-par x f '()))
    )
)

(define (help-par x f acc)
    (if (empty? f) acc (help-par x (cdr f) (cons ((car f) x) acc)))
)

(define (cube a) (* a a a))
(displayln ((par identity square cube) 3))

;25
(define (help-fibonacci n) 
    (let ([matrix '((1 1) (1 0))])
        (if (= n 0) matrix
            (multiply-matrix (help-fibonacci (- n 1)) matrix)
        )
    )
)

(define (fibonacci n)
    (ss (help-fibonacci n))
)

(define (multiply-matrix a b)
    (list 
        (list (+ (* (ff a) (ff b)) (* (fs a) (sf b)))
        (+ (* (ff a) (fs b)) (* (fs a) (ss b))))
        (list (+ (* (sf a) (ff b)) (* (ss a) (sf b)))
        (+ (* (sf a) (fs b)) (* (ss a) (ss b))))
    )
)

(define (first-row matrix) (car matrix))
(define (second-row matrix) (cadr matrix))
(define (first-elem row) (car row))
(define (second-elem row) (cadr row))
(define (ff m) (first-elem (first-row m)))
(define (fs m) (second-elem (first-row m)))
(define (sf m) (first-elem (second-row m)))
(define (ss m) (second-elem (second-row m)))

(displayln (fibonacci 0))
(displayln (fibonacci 4))
(displayln (fibonacci 7))