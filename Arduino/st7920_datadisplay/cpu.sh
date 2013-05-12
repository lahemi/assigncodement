#!/usr/bin/env bash
# See: man proc
# Bug. Some issues with updating the value if
# the script is not run continuously in a loop.

# Get data, discarding string "cpu" from the beginning.
CPU=$(awk 'NR' /proc/stat|\
    awk '/^cpu / {print substr($0, index($0,$2))}')
IDLE=$(echo $CPU|awk '{print $4}')

# Calculate the total CPU time, with fun!
FUN_TOTAL=$(echo $CPU|\
    awk 'func sum(s) {
             split(s,a);
             r=0;
             for(i in a) {
                 r+=a[i];
             }
             return r}
         {print sum($0)}')

# We use awk to do the percentage calculations here,
# to avoid complications with Bash and precision.
USAGE=$(echo $FUN_TOTAL $IDLE|\
    awk '{printf("%d",100*($1-$2)/$1)}')

# NULL terminator imperative, for Arduino.
printf "CPU: %d%%\0" $USAGE

