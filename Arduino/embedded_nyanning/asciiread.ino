/* Code testing serial.write from Python to Arduino.
 * Both turns on/off according to data received and
 * display some ASCII 'art' to be displayed from
 * serial monitor or by using serial.read() from Python.
 * See pywriter.py for the Pythonic counterpart.
 * GPLv2, 2013, Ilkka Jylhä & Lauri Peltomäki
 */


int catLed = 13;
int owlLed = 12;
int incomingByte = 0;


void setup() {
    Serial.begin(9600);     
    pinMode(catLed, OUTPUT);
    pinMode(owlLed, OUTPUT);
}


void cat() {
    Serial.println("");
    Serial.println(" /\\_/\\ ");
    Serial.println("( o.o )");
    Serial.println(" > ^ < ");
    Serial.println("");
}

void owl() {
    Serial.println("");
    Serial.println(" |\\___/| ");
    Serial.println(" |o   o| ");
    Serial.println(" |__w__| ");
    Serial.println("");
}


// We test if certain bytes are received and perform accordingly.
void loop() {
    if (Serial.available() > 0) {
        incomingByte = Serial.read();
        if (incomingByte == 49) {           // Ascii "1"
            cat(); 	
            digitalWrite(catLed, HIGH); 
            digitalWrite(owlLed, LOW); 
        } else if (incomingByte == 53) {    // Ascii "5"
            owl();
            digitalWrite(catLed, LOW);
            digitalWrite(owlLed, HIGH); 
        } else {
            digitalWrite(catLed, LOW);
            digitalWrite(owlLed, LOW);
        }
    }
}
