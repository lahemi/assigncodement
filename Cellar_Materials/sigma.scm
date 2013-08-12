; sigma - summation. 1+2+3+...+n
; Should probably be done in a single procedure.
; Purpose of this is to be easily graspable, though.
(define sig
  (lambda (limit sum)
    (cond ((= limit 0) sum)
          (#t (sig (- limit 1) (+ sum limit))))))
(define sigma
  (lambda (limit)
    (sig limit 0)))
(begin
  (display (sigma 100))
  (newline))
(exit)
