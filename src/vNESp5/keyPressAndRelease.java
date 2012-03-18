package vNESp5;
import vNES.*;

class keyPressAndRelease extends Thread{
        
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
        int timeAutoReleaseKey = 150;
        
        vNESp5 myEmulador;
        
        public keyPressAndRelease(vNESp5 _myEmulador){
            myEmulador = _myEmulador;
        }
        
        public void setTimeAutoRelease(int value)
        {
          timeAutoReleaseKey = value;
        }
        
        public void pressAndRelease_key_SELECT()
        {
          pressKeySELECT = true;
        }
        
        public void pressAndRelease_key_START()
        {
          pressKeySTART = true;
        }
        
        public void pressAndRelease_key_A()
        {
          pressKeyA = true;
        }
        
        public void pressAndRelease_key_B()
        {
          pressKeyB = true;
        }
        
        void pressAndRelease_key_UP()
        {
          pressKeyUP = true;
        }
        
        void pressAndRelease_key_DOWN()
        {
          pressKeyDOWN = true;
        }

        void pressAndRelease_key_LEFT()
        {
          pressKeyLEFT = true;
        }
        
        void pressAndRelease_key_RIGHT()
        {
          pressKeyRIGHT = true;
        }
        
        public void run(){
          
          while(running)
          {
             try {
               
               //PRESS KEYS 
               if(pressKeyLEFT){     myEmulador.press_KEY_LEFT(); pressKeyLEFT = false; releaseKeyLEFT= true; }       
               if(pressKeyRIGHT){    myEmulador.press_KEY_RIGHT(); pressKeyRIGHT = false; releaseKeyRIGHT = true; } 
               if(pressKeyUP){       myEmulador.press_KEY_UP(); pressKeyUP = false; releaseKeyUP= true; }       
               if(pressKeyDOWN){     myEmulador.press_KEY_DOWN(); pressKeyDOWN = false; releaseKeyDOWN = true; }
               if(pressKeyA){        myEmulador.press_KEY_A(); pressKeyA = false; releaseKeyA = true; }
               if(pressKeyB){        myEmulador.press_KEY_B(); pressKeyB = false; releaseKeyB = true; }
               if(pressKeySTART){    myEmulador.press_KEY_START(); pressKeySTART = false; releaseKeySTART = true; }
               if(pressKeySELECT){   myEmulador.press_KEY_SELECT(); pressKeySELECT = false; releaseKeySELECT= true; }
               
               // Time wait to release the key
               Thread.sleep(timeAutoReleaseKey);
               
               //RELEASE KEYS
               if(releaseKeyLEFT){   myEmulador.release_KEY_LEFT();   releaseKeyUP = false;}       
               if(releaseKeyRIGHT){  myEmulador.release_KEY_RIGHT();  releaseKeyRIGHT = false;} 
               if(releaseKeyUP){     myEmulador.release_KEY_UP();     releaseKeyUP = false; }       
               if(releaseKeyDOWN){   myEmulador.release_KEY_DOWN();   releaseKeyDOWN = false; }
               if(releaseKeyA){      myEmulador.release_KEY_A();      releaseKeyA = false; }
               if(releaseKeyB){      myEmulador.release_KEY_B();      releaseKeyB = false; }
               if(releaseKeySTART){  myEmulador.release_KEY_START();  releaseKeySTART = false; }
               if(releaseKeySELECT){ myEmulador.release_KEY_SELECT(); releaseKeySELECT = false;  }
               
             }catch(InterruptedException e) {
               e.printStackTrace();
               Thread.currentThread().interrupt();
             }
          }
          
        }

}

