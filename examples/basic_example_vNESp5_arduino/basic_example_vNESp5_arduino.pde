import vNES.*;
import vNESp5.*;

vNESp5 myEmulador;
PImage pg;
boolean  started;

void setup()
{
  size(1024,768);

  myEmulador = new vNESp5(this);
  myEmulador.loadRom("SuperMarioBros-DuckHunt.nes");  
}

//----------------------------------------------------

void draw()
{
  startGame();
  //myEmulador.draw(-8,-8);
  myEmulador.updateFrameBuffer();
  pg = myEmulador.getFrameBuffer();
  image(pg,0,0,width,height);
  
  if(keyPressed && key=='s'){
    myEmulador.pressAndRelease_KEY_LEFT();
  }
  if(keyPressed && key=='d'){
    myEmulador.pressAndRelease_KEY_RIGHT();
  }
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

