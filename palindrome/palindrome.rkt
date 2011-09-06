#lang racket
(require rackunit)
(require rackunit/text-ui)

(define (palindrome? str)
  (let ((lst ((compose ((curry filter) char-alphabetic?) string->list string-upcase) str)))
    (equal? lst (reverse lst))))


(run-tests ( test-suite "palindrome"
                           (test-equal? "a : palindrome" (palindrome? "a") #t)
                           (test-equal? "ab : papalindrome" (palindrome? "ab") #f)
                           (test-equal? "bab : palindrome" (palindrome? "bab") #t)
                           (test-equal? "b a,b : palindrome" (palindrome? "b a,b") #t)
                           (test-equal? "Isä, älä myy myymälääsi. : palindrome en finnois" (palindrome? "Isä, älä myy myymälääsi.") #t)))

