
int incomingByte = 0;

char* nyan[]={
"::@::::::::::::::::::::::::::@:::::::::::+::::::::::::::::::+:::::::@::",
"::::::::::::::::@:::::::::::::::::::::::::::::::::::::@@+::::::::::::::",
"##::::::::::::::::::::::::::::::::::::::::::::::::::::::::::@::::::::::",
"###::##:###:::::                                  :::::::::::::::::::::",
"#############:: ##################################  :::::::::::::::::::",
"===#########: ######################################  :::::::::::::::::",
"==--====-==== #####???()??????????????????????######  :::::::::::::::::",
"=====-======= ##??????????????????()?????????????###  ::::::::::::@::::",
"----========= ##?????????????????????????   ?()???##  :::   :::::::::::",
"============= ##?????????????()???????? ;;;; ?????##  ::  ;;; :::+:::::",
"----------=== ##??????????????????????? ;;;;; ????##    ;;;;; :::::::::",
"------------- ##??????????????????????? ;;;;;;;       ;;;;;;; :::::::::",
"++++++++----- ##?????????????????()???? ;;;;;;;;;;;;;;;;;;;;: :::::::::",
"+++++++++++   ##?????()??????????????? ;;;;@  ;;;;;;;;;;;@  ;; ::::::::",
"+++++++~~~~~~ ##???????????????()????? ;;;;   ;;;;;; ;;;;   ;;; :::::::",
"~~~~~~~~~~;;~ ####???????()??????????? ;(());;;;;;;;;;;;;;;(()) :::::::",
"$~~~;;;~~~~~; ######??????????????????? ;;;;;|______|_____|;;; ::::::::",
"$$$~~~~~;;~~~   ######################## ;;;;;;;;;;;;;;;;;;; ::::::::::",
"$$$$$$$$$$$~ ;;;                                            :::::::::::",
":::$$$$$$$$$ ;;; :: ;; ::::::::::::::::  ;; ::::  ;;;; ::::::::::::+:::",
"::::::::::::    ::::   ::::::::::::::::::   ::::::     ::::::::::::::::",
":@:::::::::::::::::::::::::::::::@:::::::::::::::::::::::::::::::@:::::",
":::::+:::::::::::::::::::@@::::::::::::::::::::::::::::::::::::::::::::",
"::::::::::::::::::::::::::::::::::::::::::::::::::+::::::::::::::::::::"};

char* legacies[]={
" /\\_/\\ ",
"( o.o )",
" > ^ < ",
"",
" |\\__/| ",
" |o   o| ",
" |__w__| "};


void setup() {
    Serial.begin(115200);
}


// @param, array of strings, iteration count(~=amount of strings).
void looper(char** str, int l) {
    for(int i=0;i<l;i++) {
        Serial.println(str[i]);
    }
    Serial.println("");
}


// We test if certain bytes are received and perform accordingly.
// Nested assignment of incomingByte is needed, otherwise
// the program hangs.
void loop() {
    if (Serial.available() > 0) {
        incomingByte = Serial.read();
        if (incomingByte == 55) {           // Ascii "7"
            incomingByte = 55;
            looper(nyan, 24);
        } else if (incomingByte == 49) {    // Ascii "1"
            incomingByte = 49;
            looper(legacies, 7);
        }
    }
}
