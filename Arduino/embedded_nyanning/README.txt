
GPLv2, 2013,
Ilkka Jylhä
Lauri Peltomäki <lahemi.maki@gmail.com>
@ Learn Arduino course of Tero Karvinen, <terokarvinen.com>



Small project that got out of hand.


catread.py
creates a .txt file, into which it appends
what ever the script happens to read from the serial port.

pywrite.py and asciiread.ino

Three button GUI, sends messages to Arduino when buttons
are clicked.
Arduino is listening, and when it encounters certain kinds
of input, it'll print one of two different ASCII pictures
and lits leds accordingly.


nyangui.py and nyan.jpeg and asciinyan.ino + 2 screenshots.

Slightly more refined GTK GUI. Sends two kinds of messages
to Arduino. Depending which one, arduino will display
one of the pictures once(two smaller animals from earlier
or needlessly large ASCII Nyan cat).
Of screenshots, nyan_with_gui is the final version.
The other one shows intermediate stage, and also demonstrates
constant looping of the Nyan Cat.(Code is clearly visible, too.)

