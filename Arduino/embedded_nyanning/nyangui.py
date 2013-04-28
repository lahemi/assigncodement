#!/usr/bin/env python2
# Writing data to Arduino using Python, thus changing
# the predefined output accordingly.
# GPLv2, 2013, Ilkka Jylha & Lauri Peltomaki
# Unrevised version.


import gtk, serial

# Whatever your needs and device happens to be.
baud = 115200
devtty = "/dev/ttyUSB0"

ser = serial.Serial(devtty, baud)


def nyan_event(widget):
    print("Nyanned!")
    ser.write("7")      # Ascii 55, for no apparent reason.

def legacy_event(widget):
    print("Legacy creatures.")
    ser.write("1")      # Ascii 49


def main():

    window = gtk.Window()
    window.connect("destroy", gtk.main_quit)
    window.set_size_request(300, 200)
    window.set_title("Cats")
    window.set_tooltip_text("Cats hunt mice.")
    window.set_position(gtk.WIN_POS_CENTER)

    # We rescale the image programmingly.
    nyan_image = gtk.Image()
    pixbuf = gtk.gdk.pixbuf_new_from_file("nyan.jpeg")
    scaled_pix = pixbuf.scale_simple(200, 180, gtk.gdk.INTERP_BILINEAR)
    nyan_image.set_from_pixbuf(scaled_pix)

    b_nyan = gtk.Button("Nyan")
    b_nyan.connect("clicked", nyan_event)
    b_nyan.set_size_request(60, 30)
    b_legacy = gtk.Button("Legacy")
    b_legacy.connect("clicked", legacy_event)
    b_legacy.set_size_request(60, 30)
    b_destroy = gtk.Button("Destroy")
    b_destroy.connect("clicked", gtk.main_quit)

    # attach(child, left_attach, right_attach, top_attach, bottom_attach,
    #        xoptions=gtk.EXPAND|gtk.FILL, yoptions=gtk.EXPAND|gtk.FILL,
    #        xpadding=0, ypadding=0)
    table = gtk.Table(3, 2, False)
    table.attach(nyan_image, 0, 1, 0, 3, True, True)
    table.attach(b_nyan, 1, 2, 0, 1, False, False, 10, 0)
    table.attach(b_legacy, 1, 2, 1, 2, False, False, 10, 0)
    table.attach(b_destroy, 1, 2, 2, 3, False, False, 10, 0)
    window.add(table)

    window.show_all()
    gtk.main()


if __name__ == "__main__":
    main()
