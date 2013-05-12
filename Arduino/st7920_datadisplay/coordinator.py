#!/usr/bin/env python2
# Primitive GUI that is used to send data to Arduino.
# GPLv2, 2013, Ilkka Jylha & Lauri Peltomaki

import gtk, serial, subprocess

baud = 115200
devtty = "/dev/ttyUSB0"
ser = serial.Serial(devtty, baud)


def uptime_event(widget):
    #ser.write(subprocess.check_output("bash uptimer.sh", shell=True))
    ser.write(subprocess.check_output("perl uptimer.pl", shell=True))

def mem_event(widget):
    ser.write(subprocess.check_output("bash mem.sh", shell=True))

def cpu_event(widget):
    ser.write(subprocess.check_output("bash cpu.sh", shell=True))

def unix_event(widget):
    ser.write(subprocess.check_output("bash unix.sh", shell=True))

def oss_event(widget):
    ser.write(subprocess.check_output("bash ossvol_greenjack.sh", shell=True))

def clear_event(widget):
    ser.write("\0")


def main():

    window = gtk.Window()
    window.connect("destroy", gtk.main_quit)
    window.set_size_request(300, 200)
    window.set_title("Click send data")
    window.set_position(gtk.WIN_POS_CENTER)

    b_up = gtk.Button("Uptime")
    b_up.connect("clicked", uptime_event)
    b_mem = gtk.Button("Mem")
    b_mem.connect("clicked", mem_event)
    b_cpu = gtk.Button("CPU")
    b_cpu.connect("clicked", cpu_event)
    b_unix = gtk.Button("Unix")
    b_unix.connect("clicked", unix_event)
    b_oss = gtk.Button("OSS")
    b_oss.connect("clicked", oss_event)
    b_clear = gtk.Button("Clear")
    b_clear.connect("clicked", clear_event)
    b_destroy = gtk.Button("Destroy")
    b_destroy.connect("clicked", gtk.main_quit)
    #b_destroy.set_size_request(60, 30)

    hboxhigh = gtk.HBox()
    hboxhigh.pack_start(b_clear, True, True, 1)
    hboxhigh.pack_start(b_destroy, True, True, 1)
    hboxlow = gtk.HBox()
    hboxlow.pack_start(b_up, True, True, 1)
    hboxlow.pack_start(b_mem, True, True, 1)
    hboxlow.pack_start(b_cpu, True, True, 1)
    hboxlow.pack_start(b_unix, True, True, 1)
    hboxlow.pack_start(b_oss, True, True, 1)
    vbox = gtk.VBox()
    vbox.pack_start(hboxhigh, True, True, 1)
    vbox.pack_start(hboxlow, True, True, 1)
    window.add(vbox)

    window.show_all()
    gtk.main()


if __name__ == "__main__":
    main()
