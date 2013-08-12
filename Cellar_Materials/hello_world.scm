; run for example using chicken: csi -s <file.scm>
; Needlessly contrived "Hello world".

(begin
  (display "Hello from a lone begin block.")
  (newline)
  (newline))

(define hello
  (lambda (x)
    (cond ((>= x 10) (begin
                      (display "End of Hello's!")
                      (newline)))
          ((= x 1) (begin
                     (display "Hello from recursion!")
                     (newline))
                   (hello (+ x 1)))
          (#t (begin
                (display "Hello!")
                (newline)
           (hello (+ x 1)))))))

(hello 1)
(exit)
