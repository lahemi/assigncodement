/* Code to test both extreme positions
 * and the center of the 180 degree
 * movement area of 3001HB analog servo.
 * The code provided 'as-is', with no warranty.
 * GPLv2, 2013 Ilkka Jylhä & Lauri Peltomäki
 */

int servoPin = 13;
int i = 0;

void setup() {
  Serial.begin(115200);
  pinMode(servoPin, OUTPUT);
}

/* We use Arduino IDE's serial monitor to "manually"
 * roughly estimate the required positions.
 * They are: 1380 for center
 * 600 for plus 90 & 2340 for minus 90. */
void loop() {
  for(i=100; i<2500; i++) {
    digitalWrite(servoPin, HIGH);
    delayMicroseconds(i);
    digitalWrite(servoPin, LOW);
    delayMicroseconds(i);
    Serial.println(i);
    delay(10);  // 10 microsec
  }
}
