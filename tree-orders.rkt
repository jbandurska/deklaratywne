#lang racket
(define (left t) (cadr t))
(define (right t) (caddr t))

(define (preorder t)
    (if (empty? t) 
        ;then
        '()
        ;else
        (append
            ;t na początku
            (cons (car t) (preorder (left t)))
            (preorder (right t))
        )
    )
)

(define (inorder t)
    (if (empty? t) 
        ;then
        '()
        ;else
        (append
            ;t w środku
            (inorder (left t))
            (cons (car t) (inorder (right t)))
        )
    )
)

(define (postorder t)
    (if (empty? t) 
        ;then
        '()
        ;else
        (append
            ;t na końcu
            (postorder (left t))
            (append (postorder (right t)) (cons (car t) '()))
        )
    )
)

(define tree '(4 (3 () ()) (2 (9 () ()) (7 () ()))))
(preorder tree)
(inorder tree)
(postorder tree)
