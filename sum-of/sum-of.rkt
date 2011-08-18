#lang racket

(require rackunit)

(define (sum liste) (foldl + 0 liste))

(define (sumof-false liste val)
  (if (null? liste) #f
      (or
       (foldl
        (lambda (x y) (or x y)) #f
        (map (lambda (x) (equal? (+ (car liste) x) val)) (cdr liste)))
       (sumof (cdr liste) val))))

(define (sumof1 liste val)
  (if (or (= 1 (length liste)) (null? liste)) #f
      (or
       (let ((current (car liste)))
         (let loop ((front (cdr liste)))
           (cond
            ((null? front) #f)
            ((= (+ (car front) current) val) (list (car front) current))
            (else (loop (cdr front))))))
       (sumof (cdr liste) val))))

(define (sumof liste val)
  (define sliste
    (if (null? liste) liste (sort liste (lambda (inf sup) (< sup inf)))))
  (define (sumof-rec liste)
    (cond ((or (= 1 (length liste)) (null? liste)) #f)
          (else (let ((first-last-sum (+ (car liste) (last liste))))
                  (cond ((= first-last-sum val) (list (car liste) (last liste)))
                        ((> first-last-sum val) (sumof-rec (cdr liste)))
                        (else
                         (let ((new-liste (take liste (- (length liste) 1))))
                           (sumof-rec new-liste))))))))
  (sumof-rec sliste))

(define (range n)
  (if (= n 0) '() (cons n (range (- n 1)))))

(define test-list (range 10000))

(define val 21)

(test-case "sumof liste vide" (check-eq? (sumof '() 5) #f))
(test-case "sumof liste de 2 elements" (check-equal? (sumof '(1 2) 3) '(2 1)))
(test-case "sumof liste de 3 elements ok"(check-equal? (sumof '(1 2 1) 3) '(2 1)))
(test-case "sumof liste de 3 elements ko" (check-equal? (sumof '(1 4 1) 3) #f))
(test-case "sumof liste de 5 elements ordonnés" (check-equal? (sumof '(1 2 3 4 6) 10) '(6 4)))
(test-case "sumof liste de 5 elements desordonnés" (check-equal? (sumof '(4 2 6 1 3) 10) '(6 4)))
(test-case "sumof liste de 5 elements desordonnés" (check-equal? (sumof test-list val) '(20 1)))

(test-case "sumof1 liste vide" (check-eq? (sumof1 '() 5) #f))
(test-case "sumof1 liste de 2 elements" (check-equal? (sumof1 '(1 2) 3) '(2 1)))
(test-case "sumof1 liste de 3 elements ok"(check-equal? (sumof1 '(1 2 1) 3) '(2 1)))
(test-case "sumof1 liste de 3 elements ko" (check-equal? (sumof1 '(1 4 1) 3) #f))
(test-case "sumof1 liste de 5 elements ordonnés" (check-equal? (sumof1 '(1 2 3 4 6) 10) '(6 4)))
(test-case "sumof1 liste de 5 elements desordonnés" (check-equal? (sumof1 '(4 2 6 1 3) 10) '(6 4)))
(test-case "sumof1 liste de 5 elements desordonnés" (check-equal? (sumof1 test-list val) '(20 1)))

(display "with sort : \n")
(time (sumof test-list val))
(display "with loop : \n")
(time (sumof1 test-list val))
