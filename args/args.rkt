#lang racket

(require rackunit)

;(define argstring "-l -p 8080 -d /usr/logs")
(define flag-id-regexp #px"-[\\D]")
(define (flag? string)
  (regexp-match? flag-id-regexp string))

(define (undefined? x) (null? x))

(define (integer-parser arg)
  (if (undefined? arg) 0 (string->number arg))) 
(define (string-parser arg)
  (if (undefined? arg) "default string" arg))
(define (boolean-parser arg) #t)

(define (new-spec)
  (let ((specdata (hash)))
    (define (this sel . args)
      (case sel
        ((add-binding) (set! specdata (hash-set specdata (car args) (cadr args))))
        ((value) specdata)
        ((empty) (set! specdata (hash)))))
    this))

(define (string->args-rec argslist)
  (cond ((null? argslist) (hash))
        ((and (flag? (first argslist)) (not (flag? (second argslist))))
         (hash-set (string->args-rec (cddr argslist)) (first argslist) (second argslist)))
        (else (hash-set (string->args-rec (cdr argslist)) (first argslist) '()))))
(define (string->args arg-string)
  (string->args-rec (regexp-split #px" " arg-string)))

(define (hash-map* a-hash func)
  (define (hash-map-rec* keys res)
    (cond ((null? keys) res)
          (else
           (let* ((key (car keys))
                  (value (hash-ref a-hash key)))
             (hash-map-rec* (cdr keys) (hash-set res key (func key value)))))))
  (hash-map-rec* (hash-keys a-hash) (hash)))

(define (parse arg-string spec)
  (let ((argmap (string->args arg-string)))
    (define (func key value)
      (let ((value (hash-ref argmap key '())))
        ((hash-ref spec key) value)))
    (hash-map* spec func)))

(define (parse* arg-string spec)
  (define argsmap (string->args arg-string))
  (define result (hash))
  (let loop ((next-flags (hash-keys spec)))
parser    (let ((value (hash-ref argsmap (car next-flags) '()))
          (parser (hash-ref spec (car next-flags))))
      (set! result (hash-set result (car next-flags) (parser value)))
      (if (null? (cdr next-flags)) result
          (loop (cdr next-flags))))))

(test-begin "test"
 (define argstring "-l -p 8080 -d /usr/logs")
 (define spec (new-spec))
 (spec 'add-binding "-p" integer-parser)
 (spec 'add-binding "-l" boolean-parser)
 (spec 'add-binding "-d" string-parser)
 (check-equal? (hash-keys (spec 'value)) '("-d" "-l" "-p"))
 (check-equal? (string->args argstring) #hash(("-d" . "/usr/logs") ("-l" . ()) ("-p" . "8080")))
 (check-equal? (flag? "-d") #t)
 (check-equal? (hash-map* #hash((10 . 1) (11 . 2)) (lambda (key value) (+ key value))) #hash((10 . 11) (11 . 13)))
 (check-equal? (parse argstring (spec 'value)) #hash(("-d" . "/usr/logs") ("-l" . #t) ("-p" . 8080)))
 (check-equal? (parse* argstring (spec 'value)) #hash(("-d" . "/usr/logs") ("-l" . #t) ("-p" . 8080))))

(test-begin "test2"
 (define argstring "-l -p 8080")
 (define spec (new-spec))
 (spec 'add-binding "-p" integer-parser)
 (spec 'add-binding "-l" boolean-parser)
 (spec 'add-binding "-d" string-parser)
 (check-equal? (hash-keys (spec 'value)) '("-d" "-l" "-p"))
 (check-equal? (string->args argstring) #hash(("-l" . ()) ("-p" . "8080")))
 (check-equal? (flag? "-d") #t)
 (check-equal? (hash-map* #hash((10 . 1) (11 . 2)) (lambda (key value) (+ key value))) #hash((10 . 11) (11 . 13)))
 (check-equal? (parse argstring (spec 'value)) #hash(("-d" . "default string") ("-l" . #t) ("-p" . 8080)))
 (check-equal? (parse* argstring (spec 'value)) #hash(("-d" . "default string") ("-l" . #t) ("-p" . 8080))))

