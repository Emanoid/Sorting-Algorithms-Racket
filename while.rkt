#lang racket
(provide while)

(define-syntax while
  (syntax-rules ()
    ((while condition body ...)
     (let loop ()
       (if condition
           (begin
             body 
             ...
             (loop))
           #f)))))


(define x 0)
(print x)
(newline)
(while (< x 5)
  (set! x (+ x 1))
  (print x)
  (newline))

(define n 'uninit)
(define fn2 'uninit)
(define fn1 'uninit)

; natnum --> natnum
(define (fib-imp N)
  (define n 'uninit)
  (define fn2 'uninit)
  (define fn1 'uninit)
  (begin
    (set! n N)
    (set! fn2 1)
    (set! fn1 1)
    (while (> n 1)
           (set! n (- n 1))
           (set! fn1 (+ fn2 fn1))
           (set! fn2 (- fn1 fn2)))
    fn1))

(for-each (lambda (n)
            (begin
              (display (fib-imp n))
              (newline)))
          '(0 1 2 3 4 5 6))

(define (fib n)
  (if (<= n 1)
      1
      (+ (fib (- n 1)) (fib (- n 2)))))

; natnum --> natnum
(define (imp-fib-bug N)
  (define n 'uninit)
  (define fn2 'uninit)
  (define fn1 'uninit)
  (begin
    (set! n N)
    (set! fn2 1)
    (set! fn1 1)
    (while (>= n 2)
           (set! n (- n 1))
           (set! fn1 (+ fn2 fn1))
           (set! fn2 fn1))
    fn1))

; fact: natnum \(\rightarrow\) natnum
; Purpose: To compute the factorial of the given natnum
(define (fact n)
  (local [; natnum
          ; Purpose: The next value to multiply into accum           
          ; Invariant: k \(\geq\) 0                                        
          (define k (void))
          ; natnum
          ; Purpose: The value of the product so far
          ; Invariant: accum = \(\Pi\sb\texttt{i=k+1}\sp\texttt{n} i\)
          (define accum (void))
          ; fact-while: natnum natnum \(\rightarrow\) natnum
          ; Purpose: To compute n!
          (define (fact-while)
            (begin
              (set! k n)
              (set! accum 1)
              (while (not (= k 0))
                (set! accum (* k accum))
                (set! k (sub1 k)))
              accum))]
    (fact-while)))

