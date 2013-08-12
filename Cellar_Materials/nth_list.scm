; List. ()
; List of lists. ( . ( . ( . '())))
; Which is the same as ()
; Lists are actually terminated by an "invisible"
; empty list.

(define list1 '("hello" "world" "list"))

; which is: ("hello" ("world" ("list" . ())))

; Some helpers for better undestanding the concept.
(define first car)
(define rest cdr)

; You need a way to get certain elements of the list.
; Instead of using list1[index] like many more
; "traditional" languages do, we have to functions.
; car and cdr. car gives the first element, and cdr the rest.
; Remember a list is actually a nested multitude of lists.

(first list1)   ; prints "hello"
(rest list1)    ; prints ("world" "list")

; How do we access particular element from the rest then?
; Since lists are actually nested, you do it like this:

(first (rest list1))    ; prints "world"
; That is, first of the rest of the elements of the list!

(first (rest (rest list1))) ; prints "list"
(rest (rest (rest list1)))  ; prints (), an empty list
; any further call issues an error, as there is no elements left.

; But this is awfully inefficient and ugly.
; Let's take an example - get an element from a list by index.

(define nth-elem
  (lambda (lst n)
    (cond ((= n 1) (first lst))
          (else (nth-elem (rest lst) (- n 1))))))

; So what is going on here?
; We use recursion!
; We test if the required index is 1, if so, we get first.
; Otherwise, we call the function again from within,
; but, we drop the first element from the list by
; giving it only the rest of it as argument, hence making
; original index 2 to be of index 1 and so forth.
; We also decrement the required index the same way.
; Note that this function is sort of unsafe and lacks
; any out-of-bounds or non-positive argument tests.

(define re-nth-elem
  (lambda (lst n)
    (cond ((< n 1) "Non-positive index!")
          ((null? lst) "Out-of-bounds or empty list!")
          ((= n 1) (first lst))
          (else (re-nth-elem (rest lst) (- n 1))))))

; Note that the indexing we gave is completely arbitrary and
; you could have it begin from 0, -123 or whatever pleases you.
