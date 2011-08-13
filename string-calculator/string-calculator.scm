(require-extension test srfi-13 regex srfi-1)

(define number-regexp "-[0-9]+|[0-9]+")

; add : string -> number|string
(define (add string)
  (let* ((numbers (filter (lambda (val) (> 1000 val)) (string->numbers string)))
         (negatives (filter (lambda (val) (> 0 val)) numbers)))
    (if (not (null? negatives))
        (string-append "Negatives are not allowed. Negatives were " (list->string negatives))
        (sum numbers))))

; list->string : (numbers) -> string
(define (list->string a-list)
  (fold string-append "" (intersperse (map number->string a-list) ", ")))

; sum : (number) -> number
(define (sum alist)
  (fold + 0 alist))

; string->numbers : string -> (number)
(define (string->numbers string)
  (map string->number (string-split-fields number-regexp string)))

(test-group "string calculator test"
            (test '(1 2 3) (string->numbers "1,2,3"))
            (test 6 (sum '(1 2 3)))
            (test 6 (add "1,2,3"))
            (test 5 (add "1\n1,3"))
            (test 6 (add "//;\n1;2;3"))
            (test '(1 -2 3) (string->numbers "//;\n1;-2;3"))
            (test "Negatives are not allowed. Negatives were -3, -1" (add "-1,-3,2"))
            (test 2 (add "1111,2"))
            (test 6 (add " //[**][%uutéé]\\n1**2%uutéé3")))




