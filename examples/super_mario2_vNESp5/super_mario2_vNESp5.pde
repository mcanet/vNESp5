import vNES.*;

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

//-----------------------------------------------------

ControllIO controllIO;
ControllDevice joypad;

//----------------------------------------------------

void setup()
{
  size(200,200);
  joystick_Start();
  startArduino();
  lastTime = millis();
  wasPressWalk = false;
}

//----------------------------------------------------

void draw()
{
  background(120);
  joystick_checkUPandDown();
  joystick_walk();
  updateArduino();
  
}


