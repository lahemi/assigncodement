#!/usr/bin/env bash
# NULL terminator \0 is imperative since we use C/C++ for Arduino.
# Your sound device might be different, adjust accordingly.
# GPLv2, 2013, Ilkka Jylhä & Lauri Peltomäki

#printf "OSSvol: %.1fdB\0" $(ossmix|awk 'BEGIN{ORS=$4} /jack.green.front / {printf substr($4,0,4)}')
printf "OSSvol: %.1fdB\0" $(ossmix -c|awk 'BEGIN{FS=":"} /jack.green.front / {print $NF}')

