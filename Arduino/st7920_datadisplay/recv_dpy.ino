/* Tiny piece of code, that listens serial input from the system,
 * displaying received text on st7920 128x64 LCD screen using
 * embedded graphics library called u8glib.
 * See http://code.google.com/p/u8glib/ for more info.
 * This code: GPLv2, 2013, Ilkka Jylhä & Lauri Peltomäki. */

#include <U8glib.h>

U8GLIB_ST7920_128X64_1X u8g(13, 12, 11); // E, R/W, RS

int i = 0;
char readBuffer[16];

void setup() {
    Serial.begin(115200);
    u8g.setColorIndex(1);   // Setting pixel on, on monochrome display.
}

void loop() {
    if (Serial.available() > 0) {
        // We "clear" the char array->possible to change display.
        for(i=0;i<16;i++) {
            readBuffer[i] = '\0';
        }
        for (i=0;;i++) {
            int c;
            c=Serial.read();
            if(c == '\0') break;
            readBuffer[i] = c;
        }
    }
   
    // The picture loop. See u8glib documentation.
    u8g.firstPage();
    do {
        u8g.setFont(u8g_font_unifont);
        u8g.drawStr( 0, 22, (char*)readBuffer );
    } while (u8g.nextPage());
    delay(1000);

    /* // Autoclear.
    if(!Serial.available()) {
        delay(500);
        readBuffer[0] = '\0';
    }
    */
}

