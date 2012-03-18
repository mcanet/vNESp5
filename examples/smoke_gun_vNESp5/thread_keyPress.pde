
keyPressAndRelease myKeyPressAndRelease = new keyPressAndRelease();
Thread loadThread = new Thread(myKeyPressAndRelease);

class keyPressAndRelease implements Runnable {
  
  boolean pressKeyRIGHT = false;
  boolean pressKeyLEFT = false;
  boolean pressKeyUP = false;
  boolean pressKeyDOWN = false;
  boolean pressKeyA = false;
  boolean pressKeyB = false;
  boolean pressKeySTART = false;
  boolean pressKeySELECT = false;
  
  boolean releaseKeyRIGHT = false;
  boolean releaseKeyLEFT = false;
  boolean releaseKeyUP = false;
  boolean releaseKeyDOWN = false;
  boolean releaseKeyA = false;
  boolean releaseKeyB = false;
  boolean releaseKeySTART = false;
  boolean releaseKeySELECT = false;
  
  boolean running = true;
  int waitingTime = 350;
  
  public keyPressAndRelease() {
    
  }
  
  void pressAndRelease_KEY_SELECT()
  {
    pressKeySELECT = true;
    waitingTime = 350;
  }
  
  void pressAndRelease_KEY_START()
  {
    pressKeySTART = true;
    waitingTime = 2000;

  }
  
  void pressAndRelease_KEY_A()
  {
    pressKeyA = true;
    waitingTime = 350;
  }
  
  void pressAndRelease_KEY_B()
  {
    pressKeyB = true;
    waitingTime = 350;
  }
  
  void pressAndRelease_KEY_UP()
  {
    pressKeyUP = true;
    waitingTime = 350;
  }
  
  void pressAndRelease_KEY_DOWN()
  {
    pressKeyDOWN = true;
    waitingTime = 350;
  }

  void pressAndRelease_KEY_LEFT()
  {
    pressKeyLEFT = true;
    waitingTime = 350;

  }
  
  void pressAndRelease_KEY_RIGHT()
  {
    pressKeyRIGHT = true;
    waitingTime = 350;
  }
  
  public void run() {
    
    while(running)
    {
       try {
         
         //PRESS KEYS 
         if(pressKeyLEFT){ myEmulator.press_KEY_LEFT(); pressKeyLEFT = false; releaseKeyLEFT= true; }       
         if(pressKeyRIGHT){ myEmulator.press_KEY_RIGHT(); pressKeyRIGHT = false; releaseKeyRIGHT = true; } 
         if(pressKeyUP){ myEmulator.press_KEY_UP(); pressKeyUP = false; releaseKeyUP= true; }       
         if(pressKeyDOWN){ myEmulator.press_KEY_DOWN(); pressKeyDOWN = false; releaseKeyDOWN = true; }
         if(pressKeyA){ myEmulator.press_KEY_A(); pressKeyA = false; releaseKeyA = true; }
         if(pressKeyB){ myEmulator.press_KEY_B(); pressKeyB = false; releaseKeyB = true; }
         if(pressKeySTART){ myEmulator.press_KEY_START(); pressKeySTART = false; releaseKeySTART = true; println("pressStart"); }
         if(pressKeySELECT){ myEmulator.press_KEY_SELECT(); pressKeySELECT = false; releaseKeySELECT= true; }
         
         loadThread.sleep( waitingTime);
         
         //RELEASE KEYS
         if(releaseKeyLEFT){ myEmulator.release_KEY_LEFT();  releaseKeyUP = false;}       
         if(releaseKeyRIGHT){myEmulator.release_KEY_RIGHT(); releaseKeyRIGHT = false;} 
         if(releaseKeyUP){   myEmulator.release_KEY_UP();    releaseKeyUP = false; }       
         if(releaseKeyDOWN){ myEmulator.release_KEY_DOWN();  releaseKeyDOWN = false; }
         if(releaseKeyA){    myEmulator.release_KEY_A();     releaseKeyA = false; }
         if(releaseKeyB){    myEmulator.release_KEY_B();     releaseKeyB = false; }
         if(releaseKeySTART){ myEmulator.release_KEY_START(); releaseKeySTART = false; println("releaseStart"); }
         if(releaseKeySELECT){ myEmulator.release_KEY_SELECT(); releaseKeySELECT = false;  }
         
         loadThread.sleep( waitingTime);
         //println("thread");
         
       } catch(InterruptedException e) {
         e.printStackTrace();
       }
    }
    
  }

}

