#lang racket

(require rackunit)


(define (make-warriors number) (build-list number (lambda (x) (+ 1 x))))

(define (flavius nombre ecart)
  (let ((warriors (build-list nombre (lambda (x) (+ 1 x)))))
    (define (flavius-rec front back dead remaining)
      (cond ((and (null? front) (null? back)) (reverse dead))
            ((null? front) (flavius-rec back front dead remaining))
            ((equal? ecart remaining) (flavius-rec (cdr front) back (cons (car front) dead) 0))
            (else (flavius-rec (cdr front) (cons (car front) back) dead (+ 1 remaining)))))
    (flavius-rec warriors '() '() 0))) 
  
(check-equal? (length (make-warriors 9)) 9)
(check-equal? (flavius 0 3) '())
(check-equal? (flavius 1 3) '(1))
(check-equal? (flavius 2 3) '(1 2))
(check-equal? (flavius 3 3) '(3 2 1))
