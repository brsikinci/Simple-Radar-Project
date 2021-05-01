import processing.serial.*; // Imports library for serial communication.
import java.awt.event.KeyEvent; // Imports library for reading the data from the serial port.
import processing.sound.*; // Imports library for radar sound.
import java.io.IOException;

Serial myPort;
SoundFile soundFile;
Constant Constant = new Constant();
Drawer drawer = new Drawer();

String angle="";
String distance="";
String data="";
String noObject;

int rotateAngle, cmDistance;
int index1=0;
int index2=0;
int smaller;
int bigger;

void setup() 
{
 fullScreen();
 smooth();
 myPort = new Serial(this,"COM4", 9600);
 myPort.bufferUntil('.'); // Reads the data from the serial port up to the character '.'. The packet looks like this: angle,distance.
 soundFile = new SoundFile(this, "radar_sound.mp3");
 soundFile.loop();
 
 // These two variables are for supporting both portrait and landscape mode
  smaller = displayWidth < displayHeight ? width : height;
  bigger =  displayWidth > displayHeight ? width : height;
 
  Constant.RadiusList = new float[]
  {
    smaller * 0.26, 
    smaller * 0.44, 
    smaller * 0.63, 
    smaller * 0.815
  };
  
  Constant.CircleColor     = color(0, 255, 0);
  Constant.LineColor       = color(0, 255, 0);
  Constant.TextColor       = color(0, 255, 0);
  Constant.RedLineColor    = color(255, 0, 0);
  Constant.InfoTextColor   = color(0, 255, 0);

  Constant.LineLength      = Constant.RadiusList[3] * 0.533;

  Constant.DistanceConst   = 80;
  Constant.MaxRange = 320;
}

void draw() 
{
  fill(0);
  noStroke();
  rect(0, 0, width, height);
  
  drawer.drawRadarCircles(); 
  drawer.drawRadarLines();
  drawer.drawLine();
  drawer.drawObject();
  drawer.drawInfoText();
  drawer.drawRadarDistanceNumbers();
  drawer.drawRadarDegreeNumbers();
}

void serialEvent (Serial myPort) 
{ 
  data = myPort.readStringUntil('.');
  data = data.substring(0, data.length()-1);
  
  index1 = data.indexOf(","); 
  angle= data.substring(0, index1); 
  distance= data.substring(index1 + 1, data.length());
  
  rotateAngle = int(angle);
  cmDistance = int(distance);
}
