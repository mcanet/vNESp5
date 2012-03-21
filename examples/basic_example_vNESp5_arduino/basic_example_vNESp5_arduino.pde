import vNES.*;
import vNESp5.*;
import processing.serial.*;

vNESp5 myEmulador;
PImage pg;
boolean  started;

Serial myPort;  // Create object from Serial class
int val;      // Data received from the serial port

void setup()
{
  size(800,600);

  myEmulador = new vNESp5(this);
  myEmulador.loadRom("SuperMarioBros-DuckHunt.nes");  
  
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
}

//----------------------------------------------------

void draw()
{
  startGame();
  //myEmulador.draw(-8,-8);
  myEmulador.updateFrameBuffer();
  pg = myEmulador.getFrameBuffer();
  image(pg,0,0,width,height);
 
  while( myPort.available() > 0) {  // If data is available,
    val = myPort.read();
      if (val == 'R') {
      myEmulador.pressAndRelease_KEY_RIGHT();
      }    // read it and store it in val
      //myPort.clear();
  
  
  if (val == 'L') {
      myEmulador.pressAndRelease_KEY_LEFT();
      }    // read it and store it in val
      //myPort.clear();
  }
 // }
  //if(keyPressed && key=='s'){
   // myEmulador.pressAndRelease_KEY_LEFT();
  //}
 // if(keyPressed && key=='d'){
   // myEmulador.pressAndRelease_KEY_RIGHT();
  //ss}
  if(keyPressed && key=='e'){
    myEmulador.pressAndRelease_KEY_UP();
  }
  if(keyPressed && key=='x'){
    myEmulador.pressAndRelease_KEY_DOWN();
  }
  if(keyPressed && key=='q'){
    myEmulador.pressAndRelease_KEY_START();
  }
  if(keyPressed && key=='a'){
    myEmulador.pressAndRelease_KEY_SELECT();
  }
  if(keyPressed && key=='z'){
    myEmulador.pressAndRelease_KEY_A();
  }
  if(keyPressed && key=='c'){
    myEmulador.pressAndRelease_KEY_B();
  }
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

//----------------------------------------------------
