#!/usr/bin/env perl
# GPLv2, 2013, Ilkka Jylhä & Lauri Peltomäki

use strict;
use warnings;

open (my $uptime, "<" , "/proc/uptime") || die "Nope: $!";

while (<$uptime>)
{
    my @cols = split;
    my $res = $cols[0];
    printf("Uptime: %.1fh\0",$res/60/60);
}

