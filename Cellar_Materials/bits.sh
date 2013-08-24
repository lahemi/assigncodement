#!/usr/bin/mksh
# Bitwise operations, in shell! A small example/learning set of
# addition and multiplication using bitwise operations.
## For bash compability, sort of. You could also just do something like
## awk '{gsub(/integer/,"typeset -i");gsub(/print /,"echo ");print}' bits.sh > bitsbashed.sh
## and hold hands and hope for the best.
#shopt -s expand_aliases
#alias integer='typeset -i'
#print() {
#    for i in "$@"; do
#        printf "%s" "$i"
#    done
#    printf "\n"
#}
# No guarantee that these work with bash, even though they should!

# Allows us to set multiple locals in a single line.
local() {
    for i in "$@"; do
        typeset "$i"
    done
}

# Addition using looping,AND,XOR,and left shift.
add() {
    local a b c
    integer a=$1        # integer = typeset -i
    integer b=$2
    integer c=0

    while test $a -gt 0; do
        ((c=$b&$a))
        ((b=$b^$a))
        ((c=$c<<1))
        ((a=$c))
    done

    print $b
}

# Demonstrating multiplication using addition and bit shifting.
# Note that you do not actually need to use $ before variable
# name inside double parentheses! I used them merely to keep
# the syntax highlighting uniform.
times2() {
    local src dst
    integer src=$1

    ((dst = $(add $src $src)))

    print $dst
}
times3() {
    local src dst
    integer src=$1

    ((dst = $(add $(($src<<1)) $src)))
    
    print $dst
}
times4() {
    local src dst
    integer src=$1

    ((dst = (( $(add $src $src) << 1))))

    print $dst
}
times5() {
    local src dst
    integer src=$1

    ((dst = $(add $(($src<<2)) $src)))

    print $dst
}
times6() {
    local src dst
    integer src=$1

    ((dst = (( $(add $(($src<<1)) $src) << 1))))

    print $dst
}
times7() {
    local src dst
    integer src=$1

    #((dst = $(add $(add $(($src<<1)) $src) $(( $(add $src $src) << 1)))))
    # Doing arithmetic in shell sure can be made to look a bit like lisp :>
    ((dst = $(add $(times3 $src) $(times4 $src))))

    print $dst
}
times8() {
    local src dst
    integer src=$1

    ((dst = (( $(add $src $src) << 2))))

    print $dst
}
times9() {
    local src dst
    integer src=$1

    ((dst = $(add $(($src<<3)) $src)))

    print $dst
}
times10() {
    local src dst
    integer src=$1

    ((dst = (( $(add $(($src<<2)) $src) << 1))))

    print $dst
}
times12() {
    local src dst
    integer src=$1

    ((dst = (( $(add $(($src<<1)) $src) << 2))))

    print $dst
}
# And so forth. You can also multiply by using the smaller "times"
# and then adding those together. See times7 for an example.
# Also, it'd be better to use some kind of more general looping
# function to do multiplication, instead of these separate ones!

# And multiplication by fractions!
fract1by8() {
    local src dst
    integer src=$1

    ((dst = $src >> 3))

    print $dst
}
fract1by4() {
    local src dst
    integer src=$1

    ((dst = $src >> 2))

    print $dst
}
fract3by8() {
    local src dst
    integer src=$1

    ((dst = (( $(add $(($src>>1)) $src) >> 2))))

    print $dst
}
fract1by2() {
    local src dst
    integer src=$1

    ((dst = $src >> 1))

    print $dst
}
fract5by8() {
    local src dst
    integer src=$1

    ((dst = (( $(add $(($src>>2)) $src) >> 1))))

    print $dst
}
fract3by4() {
    local src dst
    integer src=$1

    ((dst = (( $(add $(($src>>1)) $src) >> 1))))

    print $dst
}
# (3/4+1)/2 = 7/8
fract7by8() {
    local src dst
    integer src=$1

    ((dst = $(fract3by4 $src)))
    ((dst = (( $(add $dst $src) >> 1))))

    print $dst
}
