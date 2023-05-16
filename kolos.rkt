#lang racket
(define (delete x l)
    (if (empty? l)
        ;then
        '()
        ;else
        (if (= x (car l))
            ;then
            (cdr l)
            ;else
            (cons (car l) (delete x (cdr l)))
        )    
    )    
)

(delete 2 '(1 2 3 4 2 3 4))

(define (count x l)
    (if (empty? l)
        ;then
        0
        ;else
        (if (= x (car l))
            ;then
            (+ 1 (count x (cdr l)))
            ;else
            (count x (cdr l))
        )
    )
)

(count 2 '(1 2 3 4 2 3 4 2))

(define (filter pred l)
    (if (empty? l)
        ;then
        '()
        ;else
        (if (pred (car l))
            ;then
            (cons (car l) (filter pred (cdr l)))
            ;else
            (filter pred (cdr l))
        )
    )
)

(filter even? '(1 3 4 10 3 4 2))

(define (left t) (cadr t))
(define (right t) (caddr t))
(define (inorder t)
    (if (empty? t) 
        ;then
        '()
        ;else
        (append
            (inorder (left t))
            (cons (car t) (inorder (right t)))
        )
    )
)

(inorder '(4 (3 () ()) (2 (9 () ()) (7 () ()))))