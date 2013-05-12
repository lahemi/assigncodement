
A small project, using st7920 128x64 LCD display screen
and Arduino Duemilanove.

Primitive Python program(coordinator.py) takes care of
executing shell scripts which gather and parse data from
the system. The Python part then sends them to Arduino,
which listens constantly, to be displayed on the LCD screen.

Currently, the C/C++ part(recv_dpy.ino) has a fixed text buffer.
However, dynamic allocation will be added later on.

More system gatherers will follow, too.

There is currently a bug in cpu.sh, the calculations do not
seem to function properly as static, that when run only once
(adding a loop and running the script on normal system,
it functions as it's supposed to, though).

GPLv2, 2013, Ilkka Jylhä & Lauri Peltomäki,
Haaga-Helia University of applied sciences, on Arduino
course of Tero Karvinen(http://terokarvinen.com/).

