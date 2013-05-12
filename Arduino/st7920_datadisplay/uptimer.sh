#!/usr/bin/env bash

printf "Uptime: %.1fh\0" $(awk 'NR' /proc/uptime|awk '{printf("%.0f", $1/60/60)}')

