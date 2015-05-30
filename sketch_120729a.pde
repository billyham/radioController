
//define input integers
int dialAnalog = 0;
int butPin = 7;

//define variables
int readDial=  0;
int readDialAvg = 0;
int oldDial = 0;
int dialState = 0;

int readButPin = 0;
int oldButPin = 0;
int butState = 0; //0 is play, while 1 is pause 

int timer = 1;

void setup() {
  pinMode(dialAnalog, INPUT);
  pinMode(butPin, INPUT);
  Serial.begin(9600);
}

void loop() {
  
  //read all inputs
  int readDial = analogRead(dialAnalog);
  readButPin = digitalRead(butPin);

  //check if new state in butPin
  if ((readButPin != oldButPin) && (timer > 750)){
    butState = 1; 
    oldButPin = readButPin;
    timer = 1;
  } 

  //average out readDial input 
  if (timer > 1700) {
   readDialAvg = (readDialAvg + readDial) / 2;
  }

  //check if new state in dialAnalog
  int value = (readDialAvg - oldDial);
  int absValue = abs(value);

  if ((absValue > 8)  && (timer > 1750)) {
    dialState = 1;
    oldDial = readDialAvg;
    timer = 1;
  }




  if (butState == 1) {
    if (readButPin == HIGH){
      Serial.print("xpausez");
    } 
    else {
      Serial.print("xplayz");
    }
    butState = 0;
    
  } else if (dialState ==  1){
     
      Serial.print("x");     
      Serial.print( int(readDial) );
      Serial.print("z");
      dialState = 0;
    
  }
  //add increment to timer
  timer = timer + 1;
}
