import fullscreen.*;
import japplemenubar.*;
import vNES.*;
import processing.serial.*;
import procontroll.*;
import net.java.games.input.*;
import java.awt.AWTException;
import java.awt.Robot;
import java.awt.event.InputEvent;

//-----------------------------------------------------

boolean pressed_Up_left = false;
boolean pressed_Up_right = false;

boolean pressed_Down_left = false;
boolean pressed_Down_right = false;

boolean release_Up_left = false;
boolean release_Up_right = false;

boolean release_Down_left = false;
boolean release_Down_right = false;

int count = 0;

long lastTime;
long lastTimeJump;

boolean wasPressWalk;

vNESp5 myEmulador;
boolean started = false;
FullScreen fs;
//-----------------------------------------------------

ControllIO controllIO;
ControllDevice joypad;
PGraphics pg;

//----------------------------------------------------
float factor = 3;
int screenWidth = (int)(240 * factor);
int screenHeight = (int)(220 * factor);
PImage img;
PImage frame;
int pixelSizeX;
int pixelSizeY;
int totalPixels;
PFont myFont;

void setup()
{
  size(1024,768);
  joystick_Start();
  //startArduino();
  lastTime = millis();
  wasPressWalk = false;
  myEmulador = new vNESp5(this);
  myEmulador.loadRom("SuperMarioBros-DuckHunt.nes");       
  // Create the fullscreen object
  fs = new FullScreen(this); 
  // enter fullscreen mode
  //fs.enter();
  frame = createImage(256, 240, RGB);
  frameRate(15);
  setRescale();
  myArduinoTreadmill = new arduinoTreadmill();
  treadmillThread = new Thread(myArduinoTreadmill);
  myPort = new Serial(this, Serial.list()[0], 9600);
  treadmillThread.start();
  //myArduinoTreadmill.run();
  myFont = createFont("Arial", 80);
  

}



//----------------------------------------------------

void draw()
{
  if(!started) startGame();
  
  background(120);
  joystick_checkUPandDown();
  joystick_walk();
  //updateArduino();
  //myEmulador.draw(-8,-8);
  
  myEmulador.updateFrameBuffer(); 
  frame = myEmulador.getFrameBuffer();
  rescale();
  
  textFont(myFont);
  text(count, 60, 150);
}
//----------------------------------------------------

void startGame()
{
  if(millis()> 5000 )
  {
    myEmulador.press_KEY_START();  
  }
  if(millis()> 6000 && millis()< 7000 )
  {
    myEmulador.release_KEY_START();  
  }
  if(millis()> 8000 )
  {
    myEmulador.press_KEY_START();  
   started = true; 
  }
  if(millis()> 8000 && millis()< 9000 )
  {
    myEmulador.release_KEY_START();  
    started = true; 
  }
}

