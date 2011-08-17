(require-extension srfi-1)
(define (sum liste) (fold + 0 liste))

(define (sumof1 liste val)
  (if (null? liste) #f
      (or
       (fold
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

(define (range n)
  (if (= n 0) '() (cons n (range (- n 1)))))

(define test-list (range 10000))

(define val 21)

(time (sumof test-list val))
(time (sumof1 test-list val))
