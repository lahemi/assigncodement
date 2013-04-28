/* Using HY-SRF05 ultrasonic sensor, five leds and Arduino Duemilanove,
 * we made a contraption that lights up the leds according to the
 * distance registered by the sensor.
 * The code provided is 'as-is', with no warranty.
 * GPLv2, 2013 Ilkka Jylhä & Lauri Peltomäki
 * Revised, second version.
 */

const int ECHOPIN = 2;        // Echo pulse
const int TRIGPIN = 3;        // Trigger pulse
int leds[] = {13, 12, 11, 10, 9};
int ledCount = 5; 
int i;

void setup() {
    for(i = 0; i < ledCount; i++) {
        pinMode(leds[i], OUTPUT);
    }
    Serial.begin(9600);
    pinMode(ECHOPIN, INPUT);
    pinMode(TRIGPIN, OUTPUT);
}

void allOff() {
    for(i = 0; i < ledCount; i++) {
        digitalWrite(leds[i], LOW);
    }
}

/* We turn off all the leds before turning on the required amount
 * leds, in order to avoid the need to test how many leds are on
 * or having to separately turn off only the lit up leds */
void otherOn(int choice) {
    allOff();
    switch(choice) {
        case 1:
            digitalWrite(leds[0], HIGH);
            break;
        case 2:
            digitalWrite(leds[0], HIGH);
            digitalWrite(leds[1], HIGH);
            break;
        case 3:
            for(i=0;i<3;i++) {  // <3 Bob
                digitalWrite(leds[i], HIGH);
            }
            break;
        case 4:
            for(i=0;i<4;i++) {
                digitalWrite(leds[i], HIGH);
            }
            break;
        case 5:
            for(i=0;i<ledCount;i++) {
                digitalWrite(leds[i], HIGH);
            }
            break;
    }
}

/* We used this example code snippet to test if the sensor functions:
 * http://www.robot-electronics.co.uk/files/arduino_srf04.ino
 * and to print the distance of perceived object in cm. */
void loop() {
    // Sending extremely short sound pulse.
    digitalWrite(TRIGPIN, LOW);
    delayMicroseconds(2);
    digitalWrite(TRIGPIN, HIGH);
    delayMicroseconds(10);
    digitalWrite(TRIGPIN, LOW);
    
    int distance = pulseIn(ECHOPIN, HIGH);  // Time between pulse sent and received.
    distance = distance/58;                 // Speed of sound is 29 ms/cm.
                                            // d/29/2=d/(29*2)=d/58
    Serial.println(distance);

    if(distance == 0) {
        allOff();
    } else if(distance <= 3) {
        otherOn(5);
    } else if(distance > 3 && distance <= 6) {
        otherOn(4);
    } else if(distance > 7 && distance <= 9) {
        otherOn(3);
    } else if(distance > 10 && distance <= 14) {
        otherOn(2);
    } else if(distance > 15 && distance <= 20) {
        otherOn(1);
    } else {
        allOff();
    }
}
