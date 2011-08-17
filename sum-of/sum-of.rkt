#lang racket

(require rackunit)

(define (sum liste) (foldl + 0 liste))

(define (sumof1 liste val)
  (if (null? liste) #f
      (or
       (foldl
        (lambda (x y) (or x y)) #f
        (map (lambda (x) (equal? (+ (car liste) x) val)) (cdr liste)))
       (sumof (cdr liste) val))))

(define (sumof liste val)
  (if (or (= 1 (length liste)) (null? liste)) #f
      (or
       (let ((current (car liste)))
         (let loop ((front (cdr liste)))
           (cond
            ((null? front) #f)
            ((= (+ (car front) current) val) #t)
            (else (loop (cdr front))))))
       (sumof (cdr liste) val))))

(test-case "liste vide" (check-eq? (sumof '() 5) #f))
(test-case "liste de 2 elements" (check-eq? (sumof '(1 2) 3) #t))
(test-case "liste de 3 elements ok"(check-eq? (sumof '(1 2 1) 3) #t))
(test-case "liste de 3 elements ko" (check-eq? (sumof '(1 4 1) 3) #f))
(test-case "liste de 5 elements ordonnés" (check-eq? (sumof '(1 2 3 4 6) 10) #t))
(test-case "liste de 5 elements desordonnés" (check-eq? (sumof '(4 2 6 1 3) 10) #t))

(define (range n)
  (if (= n 0) '() (cons n (range (- n 1)))))

(define test-list (range 10000))

(define val 21)

(time (sumof test-list val))
(time (sumof1 test-list val))
