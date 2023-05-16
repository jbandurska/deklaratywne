#lang racket

;29
(define (counting-version f) 
    (define times 0)
    (lambda (x) 
        (cond
            ((eq? x 'how-often) times)
            ((eq? x 'reset) (begin (set! times 0) times))
            (else (begin (set! times (+ times 1)) (f x)))
        )
    )
)

(define (square a) (* a a))

(displayln "Zadanie 29:")

(define sq (counting-version square))
(sq 5)
(sq 7)
(sq 'how-often)
(sq 'reset)
(sq 'how-often)


;30
(displayln "\nZadanie 30:")

(define z0 (mcons 'a (mcons 'b '())))
(define z1 (mcons z0 z0)) ; {{a, b}, a, b}
(define z2 (mcons (mcons 'a (mcons 'b '()))
                    (mcons (mcons 'a (mcons 'b '())) '()))) ; {{a, b}, {a, b}}
(define z3 (mcons (mcons 'a (mcons 'b '()))
                    (mcons 'a (mcons 'b '())))) ; {{a, b}, a, b}

(display z1)
(set-mcar! (mcar z1) 'g) ; {{g b} g b}
(display " => ")
(displayln z1)

(display z2)
(set-mcar! (mcar z2) 'g) ; {{g b} {a b}}
(display " => ")
(displayln z2)

(display z3)
(set-mcar! (mcar z3) 'g) ; {{g b} a b}
(display " => ")
(displayln z3)

(displayln "\nZadanie 30:")
(define (mlist l) 
    (if (empty? l) 
        `()
        (mcons (car l) (mlist (cdr l)))
    )
)

(define l1 '(1 2 3))
(displayln l1)
(define ml1 (mlist l1))
(displayln ml1)

;31
(displayln "\nZadanie 31:")
(define (append! l m)
    (cond ((and (empty? l) (empty? m)) `())
        ((empty? l) (mcons (mcar m) (append! l (mcdr m))))
        (else (mcons (mcar l) (append! (mcdr l) m)))
    )
)

(define x '(a b)) 
(define y '(c d)) 
(append x y) 
(cdr x) 

(set! x (mlist x))
(set! y (mlist y))
(displayln (append! x y)) 
(displayln (mcdr x)) 

;32
(displayln "\nZadanie 32:")
(define (create-stack) (mcons '() '()))
(define (put-on-stack stack item)
    (if (empty? stack)
        (set-mcar! stack item)
        (set-mcdr! stack (append! (mcdr stack) (mcons item '())))
    )
)
(define (last-elem stack)
    (if (empty? (mcdr stack))
        (mcar stack)
        (last-elem (mcdr stack))
    )
)
(define (no-last-elem stack acc)
    (if (empty? (mcdr stack))
        acc
        (no-last-elem (mcdr stack) (mcons (mcar stack) acc))
    )
)
(define (pop stack)
    (if (empty? (mcdr stack))
        (begin
            (displayln "Cannot pop from empty stack.")
            null
        )
        (let ([popped-elem (last-elem stack)])
            (set-mcdr! stack (no-last-elem (mcdr stack) '()))
            popped-elem
        )
    )
)
(define (clear-stack stack)
    (set-mcdr! stack '())
)

(define my-stack (create-stack))
(display "Create stack: ")
(displayln my-stack)

(display "\nPut 1 on stack: ")
(put-on-stack my-stack 1)
(displayln my-stack)

(display "Put 2 on stack: ")
(put-on-stack my-stack 2)
(displayln my-stack)

(display "\nPop from the stack: ")
(define popped-elem (pop my-stack))
(displayln my-stack)
(display "Popped element: ")
(displayln popped-elem)

(display "\nPop from the stack: ")
(set! popped-elem (pop my-stack))
(displayln my-stack)
(display "Popped element: ")
(displayln popped-elem)

(display "\nPop from the stack: ")
(set! popped-elem (pop my-stack))
(displayln my-stack)
(display "Popped element: ")
(displayln popped-elem)

(display "\nPut 1, 2, 3 on stack: ")
(put-on-stack my-stack 1)
(put-on-stack my-stack 2)
(put-on-stack my-stack 3)
(displayln my-stack)

(display "Clear stack: ")
(clear-stack my-stack)
(displayln my-stack)