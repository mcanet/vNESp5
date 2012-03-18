
//----------------------------------------------------

void joystick_Start()
{
  controllIO = ControllIO.getInstance(this);
  joypad = controllIO.getDevice(0);  
  joypad.plug(this, "handleButton0Press", ControllIO.ON_PRESS, 0);
  joypad.plug(this, "handleButton0Release", ControllIO.ON_RELEASE, 0);
  joypad.plug(this, "handleButton1Press", ControllIO.ON_PRESS, 1);
  joypad.plug(this, "handleButton1Release", ControllIO.ON_RELEASE, 1);
  joypad.plug(this, "handleButton2Press", ControllIO.ON_PRESS, 2);
  joypad.plug(this, "handleButton2Release", ControllIO.ON_RELEASE, 2);
  joypad.plug(this, "handleButton3Press", ControllIO.ON_PRESS, 3);
  joypad.plug(this, "handleButton3Release", ControllIO.ON_RELEASE, 3);
  joypad.plug(this, "handleButton4Press", ControllIO.ON_PRESS, 4);
  joypad.plug(this, "handleButton4Release", ControllIO.ON_RELEASE, 4);
  joypad.plug(this, "handleButton5Press", ControllIO.ON_PRESS, 5);
  joypad.plug(this, "handleButton5Release", ControllIO.ON_RELEASE, 5);
  joypad.plug(this, "handleButton6Press", ControllIO.ON_PRESS, 6);
  joypad.plug(this, "handleButton6Release", ControllIO.ON_RELEASE, 6);
  joypad.plug(this, "handleButton7Press", ControllIO.ON_PRESS, 7);
  joypad.plug(this, "handleButton7Release", ControllIO.ON_RELEASE, 7);
  joypad.plug(this, "handleButton8Press", ControllIO.ON_PRESS, 8);
  joypad.plug(this, "handleButton8Release", ControllIO.ON_RELEASE, 8);
  joypad.plug(this, "handleButton9Press", ControllIO.ON_PRESS, 9);
  joypad.plug(this, "handleButton9Release", ControllIO.ON_RELEASE, 9);
  joypad.plug(this, "handleButton10Press", ControllIO.ON_PRESS, 10);
  joypad.plug(this, "handleButton10Release", ControllIO.ON_RELEASE, 10);
  joypad.plug(this, "handleButton11Press", ControllIO.ON_PRESS, 11);
  joypad.plug(this, "handleButton11Release", ControllIO.ON_RELEASE, 11);
}

//----------------------------------------------------

void handleButton0Press(){println("press 0");}
void handleButton0Release(){ println("release 0"); }

void handleButton1Press(){println("press 1"); pressKey_B_p(); }
void handleButton1Release(){ println("release 1"); pressKey_B_r(); }

void handleButton2Press(){println("press 2");  }
void handleButton2Release(){ println("release 2"); }

void handleButton3Press(){println("press 3");}
void handleButton3Release(){ println("release 3"); }

void handleButton4Press(){println("press 4"); pressed_Up_right = true;}
void handleButton4Release(){ println("release 4");  }

void handleButton5Press(){println("press 5"); pressed_Down_right = true;}
void handleButton5Release(){ println("release 5");  release_Down_right = false;}

void handleButton6Press(){println("press 6"); pressed_Down_left = true;}
void handleButton6Release(){ println("release 6"); release_Down_left = false;}

void handleButton7Press(){println("press 7"); pressed_Up_left = true;}
void handleButton7Release(){ println("release 7"); release_Up_left = false; }

void handleButton8Press(){println("press 8");}
void handleButton8Release(){ println("release 8"); }

void handleButton9Press(){println("press 9"); pressKey_A_p();}
void handleButton9Release(){ println("release 9"); pressKey_A_r(); }

void handleButton10Press(){println("press 10");}
void handleButton10Release(){ println("release 10"); }

void handleButton11Press(){println("press 11");}
void handleButton11Release(){ println("release 11"); }

//----------------------------------------------------

void joystick_checkUPandDown()
{
   if( release_Up_left && !release_Up_right || !release_Up_left && release_Up_right || pressed_Up_left && release_Up_left && release_Up_right || pressed_Up_right  && release_Up_left && release_Up_right ){
    pressKey_UP_r();
    println("press UP !!");
    
    release_Up_left = false;
    release_Up_right = false;
  }
  
 if( pressed_Up_left && pressed_Up_right ){
   
    pressKey_UP_p();
    println("press UP !!");
    
    pressed_Up_left = false;
    pressed_Up_right = false;
    
    release_Up_left = true;
    release_Up_right = true;
    lastTimeJump = millis();
  }
  /*
  if(millis()-lastTimeJump>230 && release_Up_left)
  {
    pressKey_UP_r();
    release_Up_left = false;
    release_Up_right = false;
  }
  */
 
 
  
  if(pressed_Down_left && pressed_Down_right ){
    pressKey_DOWN_p();
    println("press DOWN !!");
    pressed_Down_left = false;
    pressed_Down_right = false;
    release_Down_left = true;
    release_Down_right = true;
  }
  
  if( !release_Down_left && release_Down_right || release_Down_left && !release_Down_right){
    pressKey_DOWN_r();
    println("release DOWN !!");
    release_Down_left = false;
    release_Down_right = false;
  }
}

//----------------------------------------------------

void joystick_walk()
{
  if( (millis()-lastTime)>200 )
  {
    if(count>0) println(count);
    
    if(count>1){ pressKey_RIGHT_p(); println("press left"); wasPressWalk = true; }
    
    count = 0;
    lastTime = millis();  
  }
  if( (millis()-lastTime)>150 && wasPressWalk)
  {
    pressKey_RIGHT_r();
    wasPressWalk = false;
    println("release left");
  }
}

//----------------------------------------------------


