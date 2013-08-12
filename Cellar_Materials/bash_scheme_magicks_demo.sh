#!/usr/bin/env bash
# We use chicken as our scheme implementation.
# Should run on guile if you just change the csi -q part.
# Helper function, makes it easier to change the interpreter.
function arger() {
    local ret=$(printf "$1"|csi -q)
    printf "$ret"
}
# Basically, we store some scheme into a string which we pass
# to the interpreter. Fancy thing here is, you can very
# easily use shell variables in these code snippets.
function floor() {
    local arg="(inexact->exact (floor $1))"
    arger "$arg"
}
function ceiling() {
    local arg="(inexact->exact (ceiling $1))"
    arger "$arg"
}
# In order to make this more useful with bash, if squareroot
# returns an integer, we strip decimal parts from it.
# And yes, scheme, or at least chicken, isn't too concerned
# about all those whitespaces, which is a blessing. :>
function sqrt() {
    local arg="((lambda (x)
                 (let ((s (sqrt x)))
                      (cond ((integer? s) (inexact->exact s))
                            (#t s))))
                $1)"
    arger "$arg"
}
function abs() {
    local arg="((lambda (x)
                  (cond ((< x 0) (- x))
                        (#t x)))
                $1)"
    arger "$arg"
}
# You can also define procedures and then use them no problem.
function fibonacci() {
    local arg="(define fib
                 (lambda (n)
                   (cond ((< n 2) n)
                         (#t (+ (fib (- n 1))
                                (fib (- n 2)))))))
               (fib $1)"
    arger "$arg"
}
function factorial() {
    local arg="(define fact
                 (lambda (n)
                   (cond ((< n 3) n)
                         (#t (* n (fact (- n 1)))))))
               (fact $1)"
    arger "$arg"
}

# Tests. Note the %s. That's shell for you.
printf "FLOOR(11.123)  %s\n"            $(floor 11.123)
printf "CEILING(11.123)  %s\n"          $(ceiling 11.123)
printf "SQRT_float(10)  %s\n"           $(sqrt 10)
printf "SQRT_int(9)  %s\n"              $(sqrt 9)
printf "Absolute(-2)  %s\n"             $(abs -2)
printf "Factorial(7)  %s\n"             $(factorial 7)
printf "Fibonacci sequence(17)  %s\n"   $(fibonacci 17)

list="'("first" 2 3 4)"     # or (quote ("first" 2 3 4))
printf "List, car and cdr. '("first" 2 3 4)\n"
printf "CAR:  %s\n"     $(printf "(car $list)"|csi -q)
printf "CADR:  %s\n"    $(printf "(car (cdr $list))"|csi -q)
printf "CADDDR:  %s\n"  $(printf "(cadddr $list)"|csi -q)
   
