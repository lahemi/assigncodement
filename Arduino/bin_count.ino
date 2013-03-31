/*
 * Rough and ugly binary counter implementation
 * on Arduino Duemilanove, using four leds.
 * This isn't really C/C++.
 * The counting follows the following pattern:
 * 1,2,1,3,1,2,1,4,1,2,1,3,1,2,1 + all off.
 */

int leds[] = { 12, 11, 10, 9 };
int pinCount = 4;
int hs = 1318; // ~1318ms=1hexsecond

// Initialisation of leds.
void setup() {
    for (int cPin = 0; cPin < pinCount; ++cPin) {
        pinMode(leds[cPin], OUTPUT);
    }
}

void ld01() {
    digitalWrite(leds[0], HIGH);
    delay(hs);
    digitalWrite(leds[0], LOW);
    digitalWrite(leds[1], HIGH);
    delay(hs);
    digitalWrite(leds[0], HIGH);
    delay(hs);
}

void ld2() {
    digitalWrite(leds[0], LOW);
    digitalWrite(leds[1], LOW);
    digitalWrite(leds[2], HIGH);
    delay(hs);
}

void ld3() {
    for (int cPin = 0; cPin < 3; ++cPin) {
        digitalWrite(leds[cPin], LOW);
    }
    digitalWrite(leds[3], HIGH);
    delay(hs);
}

void endf() {
    for (int cPin = 0; cPin < pinCount; ++cPin) {
        digitalWrite(leds[cPin], LOW);
    }
    delay(hs);
}

// Unnecessary function to make the mainloop cleaner.
void cleaner(int a) {
    ld01();
    switch ( a ) {
        case 2:
            ld2();
            break;
        case 3:
            ld3();
            break;
        case 4:
            endf();
            break;
    }
}

void loop() {
    cleaner(2);
    cleaner(3);
    cleaner(2);
    cleaner(4);
}
