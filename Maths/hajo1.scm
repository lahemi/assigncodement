#! /usr/bin/guile -s
!#

(load "persomathlib.scm")

(define year-2004
  '(9225 6580 5716 75903 193 1582
    1668 20238 74359 45577 806 253
    10406 14348 7865 18430 3693
    8633 695 2227 3352 8634 43474
    1 1169 5237))

(define year-2011
  '(2059 6669 6395 243 1638 22478
    733 269 349 7763 9819 17633
    4237 5044 689 2431 3882 11379
    56617 3076 18320 1457 5882))

(define trunc-round
  (lambda (x)
    (inexact->exact (round x))))

(define mean-2004 (trunc-round (apply arith-mean year-2004)))
(define mean-2011 (trunc-round (apply arith-mean year-2011)))
(define median-2004 (apply median year-2004))
(define median-2011 (apply median year-2011))
(define std-dev-2004 (trunc-round (apply standard-deviation year-2004)))
(define std-dev-2011 (trunc-round (apply standard-deviation year-2011)))

(prtln "Railway, yearly rates of passenger kilometres...")
(newline)
(prtln "The final values have been rounded to nearest integers.")
(prtln "The upper value is for 2004, the second for 2011.")
(newline)
(prtln "Arithmetic mean:")
(prtln mean-2004)
(prtln mean-2011)
(newline)
(prtln "Median:")
(prtln median-2004)
(prtln median-2011)
(newline)
(prtln "Standard deviation:")
(prtln std-dev-2004)
(prtln std-dev-2011)
(newline)
(prtln "75%-point, ie. upper quartile:")
(prtln (apply quartile-75 year-2004))
(prtln (apply quartile-75 year-2011))
