#! /usr/bin/guile -s
!#
;;; Yet very much incomplete math and statistics
;;; library of mine, for school and general amusement.
;;; GPLv3, 2013, Lauri Peltomäki

; Locale according to user's settings, enables
; for example correct printing of ä and ö.
(setlocale LC_ALL "")

; Shortcut loader for interactive sessions.
(define lkhan
  (lambda ()
    (load "persomathlib.scm")))

; Helper printer
(define prtln
  (lambda (x)
    (display x)
    (newline)))

;;; Helper procedure for easier element access of lists.
;;; Naive, no handling of "exceptions".
(define nth-elem
  (lambda (lst n)
    (cond ((= n 1) (car lst))
          (#t (nth-elem (cdr lst) (- n 1))))))

;;; The basic "middle" points.
(define arith-mean
  (lambda args
    (exact->inexact ; For "decimal" notation.
      (/ (apply + args) (length args)))))

(define median
  (lambda args
    (let ((slist (sort args <))
          (len (length args)))
      (cond ((odd? len)
             (nth-elem slist (ceiling (/ len 2))))
            (#t (let ((fst (nth-elem slist (/ len 2)))
                      (snd (nth-elem slist (+ 1 (/ len 2)))))
                  (/ (+ fst snd) 2)))))))


;;; Mode - the most common|frequent number in a set.
;
; How to implement at least half way efficiently..?
;

;; TODO general quartile procedure or two more like this.
(define quartile-75
  (lambda args
    (let* ((slist (sort args <))
           (len (length args))
           (qpoint (ceiling (* 3 (/ len 4)))))
      (cond ((even? len)
             (nth-elem slist qpoint))
            (#t (let ((fst (nth-elem slist qpoint))
                      (snd (nth-elem slist (+ 1 qpoint))))
                  (/ (+ fst snd) 2)))))))
   

;;; Dispersions. Most primitive spread.
(define range-from
  (lambda args
    (- (apply max args) (apply min args))))

;;; Variance, small sigma squared.
;;; Take each of data points, and then compare with(subtract)
;;; the mean of the set and then square them, and finally
;;; divide by the amount of data points given.
;;; Population variance ?
(define variance
  (lambda args
    (letrec*   ; inexact->exact for integers.
      ((mean (inexact->exact (apply arith-mean args)))
       (count 0) (total 0)
       (calc
         (lambda (c tot)
           (let ((c (+ c 1)))
             (cond ((not (<= c (length args))) tot)
                   (#t (calc c (+ tot (expt (- (nth-elem args c) mean) 2)))))))))
      (/ (calc count total) (length args)))))

;;; Standard deviation == just the square root of variance!
(define standard-deviation
  (lambda args
    (sqrt (apply variance args))))

; But! Divide with one less than (length sset) !
(define unbiased-sample-variance
  (lambda args
    (letrec*   ; inexact->exact for integers.
      ((mean (inexact->exact (apply arith-mean args)))
       (count 0) (total 0)
       (calc
         (lambda (c tot)
           (let ((c (+ c 1)))
             (cond ((not (<= c (length args))) tot)
                   (#t (calc c (+ tot (expt (- (nth-elem args c) mean) 2)))))))))
      (/ (calc count total)
         (- (length args) 1))))) ; Sample variance, div by N-1 !

(define factorial
  (lambda (n)
    (cond ((< n 2) n)
          (#t (* n (factorial (- n 1)))))))

;;; Sum loop.
(define summation
  (lambda (limit)
    (letrec
      ((sig (lambda (lim sum)
              (cond ((= lim 0) sum)
                    (#t (sig (- lim 1) (+ sum lim)))))))
      (sig limit 0))))
