#!/usr/bin/env bash
# GPLv2, 2013, Ilkka Jylhä & Lauri Peltomäki

printf "Uptime: %.1fh\0" $(awk 'NR' /proc/uptime|awk '{printf("%.0f", $1/60/60)}')

