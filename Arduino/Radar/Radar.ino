#include <Servo.h>

const int redPin  =  13;
const int greenPin = 12;
const int bluePin  = 11;

const int buzzerPin = 10;

const int trigPin = 5;
const int echoPin = 4;

const int motorPin = 3;

long duration;
int distance;

Servo motor;


void rgbColor(int red, int green, int blue)
{
  analogWrite(redPin, red);
  analogWrite(greenPin, green);
  analogWrite(bluePin, blue);
}


void setup() 
{
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  
  pinMode(redPin, OUTPUT);
  pinMode(greenPin, OUTPUT);
  pinMode(bluePin, OUTPUT);
  
  pinMode(buzzerPin, OUTPUT);
  
  Serial.begin(9600);
  
  motor.attach(motorPin);
}

void loop() 
{
  
  for(int i=0; i<=180; i++)
  {  
    motor.write(i);
    delay(10);
    distance = calculateDistance();
    mainEvent();
    Serial.print(i); 
    Serial.print(","); 
    Serial.print(distance);
    Serial.print(".");
  }
  
  for(int i=180; i>0; i--)
  {  
    motor.write(i);
    delay(10);
    distance = calculateDistance();
    mainEvent();
    Serial.print(i);
    Serial.print(",");
    Serial.print(distance);
    Serial.print(".");
  }
}

void mainEvent()
{
  distance = calculateDistance();
  ledRedOrGreen(distance);
  buzzOrNot(distance);
}

int calculateDistance()
{ 
  digitalWrite(trigPin, LOW); 
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH); 
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  duration = pulseIn(echoPin, HIGH);
  distance = duration*0.034/2;
  return distance;
}

inline boolean objectInRange(float distance)
{
  return distance < 320;
}

void ledRedOrGreen(float distance)
{
  if (objectInRange(distance))
    rgbColor(255, 0, 0);
  else
    rgbColor(0, 255, 0);
  delay(25);
}

void buzzOrNot(float distance)
{
   if (objectInRange(distance))
    tone(buzzerPin, 220, 100);
}
