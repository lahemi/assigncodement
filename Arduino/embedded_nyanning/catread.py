#!/usr/bin/env python
# Test to read data from Arduino using Python
# and saving it to a text file.
# GPLv2, 2013, Ilkka Jylhä & Lauri Peltomäki

import serial, sys

usbdev = "/dev/ttyUSB0"
baud = 115200

ser = serial.Serial(usbdev, baud)

while True:
    try:
        f = open("kissa.txt", "a+b")    # Append + binary mode.
        f.write(ser.read(1))            # One byte at a time.
    except serial.SerialException:
        pass
