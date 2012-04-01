import SimpleOpenNI.*;
import vNES.*;
import vNESp5.*;

SimpleOpenNI kinect;

PImage handImage;

PFont font;

// A variable for the color we are searching for.
boolean started = false;
long gameOverMillis;

vNESp5 myEmulator;
float rightArmAngle;
PVector torsoPos;

//----------------------------------------------------

void setup() 
{
  size(1024,768);
  kinectSetup();
  font = loadFont("Serif-48.vlw"); 
  textFont(font); 

  myEmulator = new vNESp5(this);
  myEmulator.loadRom("Gun Smoke (E).nes");
  // key set times
  myEmulator.setTimeAutoPressAndRelease_KEY_START(350, 150);
  myEmulator.setTimeAutoPressAndRelease_KEY_A(350, 50);
  myEmulator.setTimeAutoPressAndRelease_KEY_B(350, 50);
  myEmulator.setEnableSound(false);
  torsoPos = new PVector();
}


//----------------------------------------------------

void draw() 
{
  kinectDraw();
  
  myEmulator.draw(0,0,width,height); 
  
   float degreerRghtArmAngle = abs(degrees(rightArmAngle));
   String direction = "";
   
   if(degreerRghtArmAngle>0.01 && degreerRghtArmAngle<90){
     myEmulator.pressAndRelease_KEY_B();
     direction = " RIGHT";
   }
   if(degreerRghtArmAngle>90 && degreerRghtArmAngle<180){
     myEmulator.pressAndRelease_KEY_A();
     direction = " LEFT";
   }
   
   fill(255);
   text(String.valueOf(	int(degreerRghtArmAngle))+":"+direction, 15, 30);
   
   if(keyPressed && key==ENTER){
      myEmulator.pressAndRelease_KEY_START();  
   }
   if(keyPressed && key=='3'){
      myEmulator.pressAndRelease_KEY_A();  
   }
   if(keyPressed && key=='4'){
      myEmulator.pressAndRelease_KEY_B();   
   }
   
   if(torsoPos.x<(320-50)){
     myEmulator.pressAndRelease_KEY_RIGHT();
   }
   if(torsoPos.x>(320+50)){
     myEmulator.pressAndRelease_KEY_LEFT();
   }
   text(String.valueOf(	torsoPos.x)+":"+String.valueOf(	torsoPos.y), 15, 70);

}






