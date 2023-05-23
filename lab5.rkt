#lang racket
;18

(define (square a) (* a a))

(define (square-list l)
(if (empty? l)
'()
(cons (square (car l)) (square-list (cdr l)))))

(displayln (square-list '(1 2 3 4 5)))

(define (mapf f l)
(if (empty? l)
'()
(cons (f (car l)) (mapf f (cdr l)))))

(define (plus-2 a) (+ a 2))

(displayln (mapf plus-2 '(1 2 3 4 5)))

(define (filter pred l)
(cond ((empty? l) '())
((pred (car l)) (cons (car l) (filter pred (cdr l))))
(else (filter pred (cdr l)))))

(displayln (filter odd? '(1 2 3 4 5)))

;19

(define drzewo '(2 (3 () (4 () ())) (1 () ())))
(define (left t) (cadr t))
(define (right t) (caddr t))

(define (memberTree? element t)
(cond ((empty? t) #f)
((= element (car t)) #t)
(else (or
(memberTree? element (left t))
(memberTree? element (right t))
)
)
))

(memberTree? 3 drzewo)
(memberTree? 5 drzewo)

(define (sumTree t)
(if (empty? t) 0
(+
(car t)
(sumTree (left t))
(sumTree (right t))
)
))

(sumTree drzewo)

(define (inorder t)
(if (empty? t) '()
(append
(inorder (left t))
(cons (car t) (inorder (right t)))
)
))

(inorder drzewo)

(define (mapTree f t)
(if (empty? t) '()
(list
(f (car t)) (mapTree f (left t)) (mapTree f (right t))
)
)
)

(mapTree square drzewo)

;20
(define (deriv exp var)
(cond ((constant? exp) 0)

    ((variable? exp)
    (if (same-variable? exp var) 1 0))

    ((sum? exp)
    (make-sum
    (deriv (second exp) var)
    (deriv (third exp) var)))

    ((product? exp)
    (make-product (second exp) (third exp) var))

    ((power? exp)
    (make-power (second exp) (third exp)))
))

(define (atom? x) (and (not (pair? x)) (not (null? x))))
(define (constant? exp) (number? exp))
(define (variable? exp) (symbol? exp))
(define (same-variable? x y)
(and (variable? x)
(variable? y)
(eq? x y)))

(define (sum? exp)
(if (not (atom? exp))
(eq? (car exp) '+)
(error ".....")))

(define (product? exp)
(if (not (atom? exp))
(eq? (car exp) '*)
(error ".....")))

(define (power? exp)
(if (not (atom? exp))
(eq? (car exp) '^)
(error ".....")))

(define (second sum) (cadr sum))
(define (third sum) (caddr sum))

(define (make-sum a b) 
    (cond ((eq? a 0) b)
    ((not (eq? b 0)) (list '+ a b))
    (else a))
)
(define (make-product a b var) 
    (cond 
        ((and (variable? a) (variable? b) (same-variable? a var)) b)
        ((and (variable? a) (variable? b) (same-variable? b var)) a)
        ((and (variable? a) (constant? b) (same-variable? a var)) b)
        ((and (constant? a) (variable? b) (same-variable? b var)) a)
        (else 0)
    )
)
(define (make-power x n) 
    (list '* n (list '^ x (- n 1)))
)

(displayln (deriv '(* x y) 'x))
(displayln (deriv '(* 5 y) 'x))
(displayln (deriv '(* 5 x) 'x))
(displayln (deriv '(+ (* a x) b) 'x))
(displayln (deriv '(^ x 4) 'x))

;21
(define (eval expression values)
    (cond ((eq? (typ expression) "Single") 
            (calculate-single (find-value values (cadr expression))))
        ((eq? (typ expression) "Double")
            (calculate-double (find-value values (cadr expression)) (find-value values (caddr expression)) (car expression)))
        ((eq? (typ expression) "Nested-Single") 
            (calculate-single (eval (second expression) values)))
        ((eq? (typ expression) "Nested-Double-First") 
            (calculate-double (eval (second expression) values) (find-value values (caddr expression)) (car expression)))
        ((eq? (typ expression) "Nested-Double-Second") 
            (calculate-double (find-value values (cadr expression)) (eval (third expression) values) (car expression)))
        ((eq? (typ expression) "Nested-Double-Both") 
            (calculate-double (eval (second expression) values) (eval (third expression) values) (car expression)))
    )
)

(define (sorb? x) (or (symbol? x) (boolean? x)))

(define (typ expression)
    (cond 
    ((empty? (cddr expression)) "Single")
    ((and (sorb? (second expression)) (sorb? (third expression))) "Double")
    ((null? (third expression)) "Nested-Single")
    ((sorb? (second expression)) "Nested-Double-Second")
    ((sorb? (third expression)) "Nested-Double-First")
    (else "Nested-Double-Both"))
)

(define (find-value values var)
    (cond ((boolean? var) var)
        ((eq? (caar values) var) (cdar values))
        (else (find-value (cdr values) var))
    )
)

(define (calculate-double val1 val2 operation) 
(if (eq? operation 'and) (and val1 val2) (or val1 val2)))

(define (calculate-single val) (not val))

(define values '((x . #f) (y . #t) (z . #f)))

(displayln (eval '(and y (not x)) values))
(displayln (eval '(and y (and (not x) z)) values))
(displayln (eval '(and y #t) values))

;22
(define (fold f e l)
    (if (null? l)
        e
        (f (car l) (fold f e (cdr l)))
    )
)

(define lista '(1 2 3 4 5))
(define (prod l)
  (fold * 1 l))

(displayln (prod lista))

(define (length l)
  (fold (lambda (x acc) (+ acc 1)) 0 l))

(displayln (length lista))

(define (delete x l)
    (fold (lambda (head tail) 
        (if (= head x) tail (cons head tail))
    ) '() l)
)

(displayln (delete 3 lista))

(define (reverse l)
    (fold (lambda (head tail) (append tail (cons head '()))) '() l)
)

(displayln (reverse lista))

(define (map f l)
    (fold (lambda (head tail) (cons (f head) tail)) '() l)
)

(displayln (map square lista))

(define (filter2 pred l)
    (fold (lambda (head tail) 
        (if (pred head) (cons head tail) tail)
    ) '() l)
)

(displayln (filter2 odd? lista))

(define (forall pred l)
    (fold (lambda (curr acc) 
        (and (pred curr) acc)
    ) #t l)
)

(displayln (forall odd? lista))
(displayln (forall odd? '(11 3 5 7 9)))