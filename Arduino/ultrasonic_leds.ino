/* Using HY-SRF05 ultrasonic sensor, five leds and
 * Arduino Duemilanove, we made a contraption that
 * lights up the leds according to the distance
 * registered by the sensor.
 * The code provided is 'as-is', with no warranty.
 * GPLv2, 2013 Ilkka Jylhä & Lauri Peltomäki
 */

#define ECHOPIN 2                            // Pin to receive echo pulse
#define TRIGPIN 3                            // Pin to send trigger pulse

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
 * or having to separately turn off only the lit up leds on each
 * each. This saves some code and makes things a bit simpler. */
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
    digitalWrite(TRIGPIN, LOW);         // Set the trigger pin to low for 2uS
    delayMicroseconds(2);
    digitalWrite(TRIGPIN, HIGH);        // Send a 10uS high to trigger ranging
    delayMicroseconds(10);
    digitalWrite(TRIGPIN, LOW);         // Send pin low again
    
    int dis = pulseIn(ECHOPIN, HIGH);   // Read in times pulse
    dis = dis/58;                       // Calculate distance from time of pulse
    Serial.println(dis);

    // Changing the amount of lit leds according to distance.
    if(dis == 0) {
        allOff();
    } else if(dis <= 3) {
        otherOn(5);
    } else if(dis > 3 && dis <= 6) {
        otherOn(4);
    } else if(dis > 7 && dis <= 9) {
        otherOn(3);
    } else if(dis > 10 && dis <= 14) {
        otherOn(2);
    } else if(dis > 15 && dis <= 20) {
        otherOn(1);
    } else {
        allOff();
    }
}
