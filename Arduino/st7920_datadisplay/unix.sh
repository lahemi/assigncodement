#!/usr/bin/env bash
# Unix time, Year-OrdinalDate-H:M:S
# GPLv2, 2013, Ilkka Jylhä & Lauri Peltomäki

# Command fails without 'echo'. Odd.
FUN=$(echo ""|\
    awk 'BEGIN{NOW=systime()}
        {printf("%d-",NOW/60/60/24/365.25);
         printf("%d-",NOW/60/60/24%365.25);
         printf("%d:",NOW/60/60%24);
         printf("%d:",NOW/60%60);
         printf("%d",NOW%60);}')          

# NULL terminator imperative for Arduino.
printf "%s\0" $FUN

