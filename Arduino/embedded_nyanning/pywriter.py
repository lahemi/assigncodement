#!/usr/bin/env python2
# Testing serial.write with Arduino+Python.
# See asciiread.ino for the pseudo-C part.
# GPLv2, 2013, Ilkka Jylhä & Lauri Peltomäki


import gtk, serial


baud = 9600
devtty = "/dev/ttyACM0"

ser = serial.Serial(devtty, baud)


def cats(widget):
    ser.write("1")

def owls(widget):
    ser.write("5")


def main():
    window = gtk.Window()
    window.connect("destroy", gtk.main_quit)
    window.set_size_request(100, 135)
    window.set_position(gtk.WIN_POS_CENTER)
    window.set_title("Ascii animals")

    b_cat = gtk.Button("Cats")
    b_cat.connect("clicked", cats)
    b_cat.set_size_request(60, 30)
    b_owl = gtk.Button("Owl")
    b_owl.connect("clicked", owls)
    b_owl.set_size_request(60, 30)
    b_quit = gtk.Button("Quit")
    b_quit.set_size_request(60, 30)
    b_quit.connect("clicked", gtk.main_quit)

    fix = gtk.Fixed()
    fix.put(b_cat, 20, 10)
    fix.put(b_owl, 20, 50)
    fix.put(b_quit, 20, 90)
    window.add(fix)

    window.show_all()
    gtk.main()


if __name__ == "__main__":
    main()
