import vNES.*;
import VNESp5.*;
import processing.video.*;

PFont font;

// Variable for capture device
Capture video;

// A variable for the color we are searching for.
color trackColor; 
color trackColor2;
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

void setup() 
{
  size(1024,768);
  video = new Capture(this,width,height,15);
  // Start off tracking for red
  trackColor = color(255,0,0);
  trackColor2 = color(0,0,255);
  smooth();
  noStroke();
  font = loadFont("ArialMT-12.vlw"); 
  textFont(font); 
  frame = createImage(256, 240, RGB);
  myEmulator = new vNESp5(this);
  myEmulator.loadRom("Gun Smoke (E).nes");
  setRescale();
  gameOver = loadImage("gameOver.tif");
  loadThread.start();
  gameOverMillis = 0;
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
  if(millis()> 5000 && !started )
  {
    myEmulator.press_KEY_START();  
   started = true; 
  }
  if(millis()> 6000 && millis()< 7000 )
  {
    myEmulator.release_KEY_START();  
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
  //println("draw");
  startGame(); 
  if(isGameOver) startAgainGame();
   
  // Capture and display the video
  if (video.available()) {
    video.read();
  }
  video.loadPixels();
  image(video,0,0);

  //method to find the closest colour (taken from Schiffman example)
  float worldRecord = 500; 
  float worldRecord2 = 500; 
  
  // XY coordinate of closest color
  int closestX = 0;
  int closestY = 0;
  
  int closestX2 = 0;
  int closestY2 = 0;

  // Begin loop to walk through every pixel
  for (int x = 0; x < video.width; x ++ ) {
    for (int y = 0; y < video.height; y ++ ) {
      int loc = x + y*video.width;
      int loc2 = x + y*video.width;
      // What is current color
      color currentColor = video.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      float r2 = red(trackColor);
      float g2 = green(trackColor);
      float b2 = blue(trackColor);
      
      color secondColor = video.pixels[loc2];
      float r3 = red(secondColor);
      float g3 = green(secondColor);
      float b3 = blue(secondColor);
      float r4 = red(trackColor2);
      float g4 = green(trackColor2);
      float b4 = blue(trackColor2);

      // Using euclidean distance to compare colors
      float d = dist(r1,g1,b1,r2,g2,b2); // We are using the dist( ) function to compare the current color with the color we are tracking.
      float d2 = dist(r3,g3,b3,r4,g4,b4); // We are using the dist( ) function to compare the current color with the color we are tracking.
      
      // If current color is more similar to tracked color than
      // closest color, save current location and current difference
      if (d < worldRecord) {
        worldRecord = d;
        closestX = x;
        closestY = y;
      }
      
      if (d2 < worldRecord2) {
        worldRecord2 = d2;
        closestX2 = x;
        closestY2 = y;
      }
    }
  }

  // We only consider the color found if its color distance is less than 10. 
  // This threshold of 10 is arbitrary and you can adjust this number depending on how accurate you require the tracking to be.
  if (worldRecord < 10) { 
    // Draw a circle at the tracked pixel
   
   strokeWeight(4.0);
     stroke(0);
     ellipse(closestX,closestY,16,16);
   }
  
   if (worldRecord2 < 10) { 
      // Draw a circle at the tracked pixel
      strokeWeight(4.0);
      stroke(0);
      ellipse(closestX2,closestY2,16,16);
    }

      rect(10, 10, 100, 60);
      fill(255, 255, 255);
     
    if(closestX < 200) {
      text("go right", 15, 30); 
      //pressKey_Right(); 
      myKeyPressAndRelease.pressAndRelease_KEY_RIGHT();
    }
    
    if(closestX > 400) {
      text("go left", 15, 30); 
      //pressKey_Left();  
      myKeyPressAndRelease.pressAndRelease_KEY_LEFT();
    }
    
    if(closestY < 200) {
      text("go up", 15, 30);
      //pressKey_Up(); 
      myKeyPressAndRelease.pressAndRelease_KEY_UP();
    }
    
     if(closestY > 400) {
      text("go down", 15, 30);
      //pressKey_Down();
      myKeyPressAndRelease.pressAndRelease_KEY_DOWN(); 
    }
    
     if(closestX2 < closestX) {
       text("shoot left", 15, 60);
       //pressKey_B(); 
       myKeyPressAndRelease.pressAndRelease_KEY_B();
     }
     
     if(closestX2 > closestX) {
       text("shoot right", 15, 60);
       //pressKey_A(); 
       myKeyPressAndRelease.pressAndRelease_KEY_A();
       
     }
     
    fill(0, 0, 0);
    
    //draw tracking grid
    line(200,0,200,480);
    line(400,0,400,480);
    line(0,200,640,200);
    line(0,400,640,400);
    stroke(126);
    
    myEmulator.updateFrameBuffer(); 
    frame = myEmulator.getFrameBuffer();
    rescale();
    detectFrame();
}

void detectFrame()
{
    gameOver.loadPixels();
    isGameOver = true;
    loadPixels();
    for( int i=((height*width)/4)*3; i<(height*width); i++)
    {
      if( gameOver.pixels[i] != pixels[i] ){ isGameOver = false; break;}
    }
    
    
    if(isGameOver && !lastIsGameOver)
    { 
        gameOverMillis = millis();
        println("isGameOver");
    }
    lastIsGameOver = isGameOver; 
}


//save the colours to be tracked by placing mouse cursor over colour and press the key
void keyPressed() {
  if(key == '1') {
    //Save color when a key is pressed
    int loc = mouseX + mouseY*video.width;
    trackColor = video.pixels[loc];
  }
  
  if(key == '2') {
     int loc2 = mouseX + mouseY*video.width;
     trackColor2 = video.pixels[loc2];
  }
  if(key == '3') {
    myEmulator.press_KEY_START();
  }
  if(key == '4') {
    myEmulator.release_KEY_START();
  }
}



