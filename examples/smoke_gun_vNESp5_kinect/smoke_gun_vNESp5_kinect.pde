import SimpleOpenNI.*;
import vNES.*;
import vNESp5.*;

SimpleOpenNI kinect;

PImage handImage;

PFont font;

// A variable for the color we are searching for.
int pixelSizeX;
int pixelSizeY;
int totalPixels;
PImage img;
PImage frame;
PImage gameOver;
boolean isGameOver = false;
boolean lastIsGameOver = false;
vNESp5 myEmulator;
boolean started = false;
boolean isPressStartAgain = false;
long gameOverMillis;
float rightArmAngle;
PVector torsoPos;

//----------------------------------------------------

void setup() 
{
  size(1024,768);
  kinectSetup();
  smooth();
  noStroke();
  font = loadFont("Serif-48.vlw"); 
  textFont(font); 
  frame = createImage(256, 240, RGB);
  myEmulator = new vNESp5(this);
  myEmulator.loadRom("Gun Smoke (E).nes");
  setRescale();
  gameOver = loadImage("gameOver.tif");

  gameOverMillis = 0;
  gameOver.loadPixels();
   
  myEmulator.setTimeAutoRelease_KEY_A(350);
  myEmulator.setTimeAutoRelease_KEY_B(350);
  myEmulator.setEnableSound(false);
  torsoPos = new PVector();
}

//----------------------------------------------------

void setRescale()
{
   pixelSizeX = 4;
   pixelSizeY = 4;
   totalPixels = (frame.width*pixelSizeX)*(frame.height*pixelSizeY);
   img = createImage((int)(frame.width*pixelSizeX), (int)(frame.height*pixelSizeY), ARGB);
}

//----------------------------------------------------

void rescale()
{
    img.loadPixels();
    frame.loadPixels();
    for(int h=0; h<frame.height;h++)
    {
        for(int w=0; w<frame.width; w++)
        {
            int pixelId = (h*frame.width)+((frame.width-1)-(w));
            int p4 = h*pixelSizeY;

            for(int _y=0; _y<pixelSizeY; _y++)
            {
                for(int _x=0; _x<pixelSizeX; _x++)
                {
                   int pixelId2 = ((((h*pixelSizeY)+_y)*(frame.width*pixelSizeX))) + (((frame.width-1)*pixelSizeX)-(w*pixelSizeX)+_x);
                   img.pixels[pixelId2] = frame.pixels[pixelId]; 
                }
            }
        }
    }
    pushMatrix();
    scale(1.1,0.9);
    img.updatePixels();
    image(img,-32, -50);
    popMatrix();
}

//----------------------------------------------------

void startGame()
{
  if(millis()> 16000 && millis()< 18000 )
  {
    myEmulator.pressAndRelease_KEY_START();
    println("releaseStart 1");
  }
}

//----------------------------------------------------

void startAgainGame()
{
  if((millis()-gameOverMillis)> 5000 && !isPressStartAgain )
  {
    myEmulator.press_KEY_START();  
    isPressStartAgain = true;
    println("pressStart");
  }
  if((millis()-gameOverMillis)> 6000 && (millis()-gameOverMillis)< 7000 && lastIsGameOver )
  {
    isPressStartAgain = false;
    myEmulator.release_KEY_START();  
    println("releaseStart");
  }
}

//----------------------------------------------------

void draw() 
{
  startGame(); 
  kinectDraw();
  if(isGameOver) startAgainGame();
  
   myEmulator.updateFrameBuffer();
   myEmulator.draw(0,0,width,height); 
   //frame = myEmulator.getFrameBuffer();
   //rescale();
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
   text(String.valueOf(	degreerRghtArmAngle)+":"+direction, 15, 30);
   
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


   /*
   if(keyPressed && key=='1'){
      //saveFrame("line-####.tif"); 
      detectFrame();
   }
   */
}
/*
void detectFrame()
{
    isGameOver = true;
    loadPixels();
    int startPixel = 545*width;
    for( int i=startPixel; i<(height*width); i++)
    {
      if( gameOver.pixels[i] != pixels[i] ){ 
        print(i/width);
        println(":not equal");
        isGameOver = false; 
        break;
      }
    }
    
    if(isGameOver && !lastIsGameOver)
    { 
        gameOverMillis = millis();
        println("isGameOver");
    }
    lastIsGameOver = isGameOver; 
}
*/





