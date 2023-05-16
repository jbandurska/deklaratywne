#lang racket

;26

(define m 1)             
(define (p m)            
   (pp 5))                  
(define (pp x)                 
   (+ x m))                

(define n 1)
(define (q n)
  (define (qq x)
    (+ x n))
  (qq 5))

; p 11 -> 6?
; q 11 -> 16?

(displayln (p 11))
(displayln (q 11))

; Nie liczy się gdzie funkcja jest wywoływana, tylko gdzie jest zdefiniowana

;27

(define a 2)
(define (p.2 a)
  (define (pp.2 b)
    (set! a (+ b 1))
    (* a b))
  (pp.2 2))

; p 5 -> 6?
; a -> 2?

(displayln (p.2 5))
(displayln a)

; Zmienna a zostaje ustawiona na b+1 w scope'ie funkcji p, ponieważ jest podana jako parametr
; Z tego samego powodu zmienna a w zewnętrznym scope'ie nie zostaje zmieniona

;28
(define (make-account balance)
  (define (account operation-type)
    (cond
      ((eq? operation-type 'withdraw)
        (define (withdraw amount)
          (set! balance (- balance amount))
        )
        withdraw
      )
      ((eq? operation-type 'deposit)
        (define (deposit amount)
          (set! balance (+ balance amount))
        )
        deposit
      )
      ((eq? operation-type 'balance)
        balance
      )
    )
  )
  account
)

(displayln "\nKonto => 100 => 60 => 70")

(define k1 (make-account 100))
(k1 'balance)
((k1 'withdraw) 40)
(k1 'balance)
((k1 'deposit) 10)
(k1 'balance)

; Działa to na takiej zasadzie, że tworząc konto ustawiamy zmienną balance, która
; później jest dziedziczona przez funkcję "account" zwracaną przez "make-account"
; Dzięki temu tworzona jest zmienna prywatna, którą można modyfikować tylko
; poprzez zwróconą instancję funkcji

; Password protected

(define (make-account-2 balance set-password)
  (define (account password operation-type)
    (cond
      ((eq? operation-type 'withdraw)
        (define (withdraw amount)
          (if (eq? set-password password)
            (begin (set! balance (- balance amount)) balance)
            "incorrect password"
          )
        )
        withdraw
      )
      ((eq? operation-type 'deposit)
        (define (deposit amount)
          (if (eq? set-password password)
            (begin (set! balance (+ balance amount)) balance)
            "incorrect password"
          )
        )
        deposit
      )
      ((eq? operation-type 'balance)
        (if (eq? set-password password)
            balance
            "incorrect password"
        )
      )
    )
  )
  account
)

(displayln "\nPassword protected account => 100 => 60 => incorrect password")

(define k2 (make-account-2 100 'password))
(k2 'password 'balance)
((k2 'password 'withdraw) 40)
((k2 'wrong-password 'withdraw) 20)