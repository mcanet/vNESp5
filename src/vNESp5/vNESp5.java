package vNESp5;

import processing.core.*;
import vNES.InputHandler;
import vNES.KbInputHandler;
import vNES.vNES;
import vNES.*;
import vNESp5.*;

;/*
 * vNESp5 library is written by Mar Canet (mar.canet@gmail.com)
 * This library for processing want to help do experimental games with this old games.
 * 
 * Use of this program subject to GNU GPL, Version 3.
 * 
 * List modifications to original vNES library for update to newer versions:
 *  
 *  vNES.java (some changes)
 *  - delete the applet variables in -> readParams(), defining some safe default values 
 *  - add constructor method vNES
 *  - Globals.p = p;
 *  - add method getFramerate()
 *  
 *  Globals.java (line: 51)
 *  - public static PApplet p;
 *  
 *  PPU.java (line: 607):
 *  - for (int pix = 0; pix < (256*240); pix++){ pixelEndRender[pix] = buffer[pix];} 
 * 
 *  KbInputHandler (line 23):¼¼¼ 
 *  -  make public var: public boolean[] allKeysState;
 * 
 * */

public class vNESp5 {

    private vNES myEmulador;
    private PImage img;
    private Boolean start; 
    private PApplet p;
	private keyPressAndRelease myKeyPressAndRelease[];
	private int width;
	private int height;
	private boolean isEnabledAutoReleaseKeys;
    
    //------------------------

    public vNESp5(PApplet p) 
    {
        this.p = p;
        width = 256;
        height = 240;
        img = p.createImage(width, height, p.RGB);
        myEmulador = new vNES(p);    
        myEmulador.init();
        // autoReleaseKey Settings
        myKeyPressAndRelease = new  keyPressAndRelease[8];
        for(int i=0;i<myKeyPressAndRelease.length;i++){
			myKeyPressAndRelease[i] = new keyPressAndRelease(this);
		}
		isEnabledAutoReleaseKeys = false;
    }
    
	//------------------------
    
    public void enabledAutoReleaseKeys() 
    {
    	for(int i=0; i<myKeyPressAndRelease.length; i++){
			myKeyPressAndRelease[i].start();
		}
		isEnabledAutoReleaseKeys = true;
    }
    
    //------------------------
    
    public void disableAutoReleaseKeys() 
    {
    	for(int i=0; i<myKeyPressAndRelease.length; i++){
			myKeyPressAndRelease[i].stop();
		}
		isEnabledAutoReleaseKeys = false;
    }
    
    //------------------------
    
    public void loadRom( String  file) 
    {
        file = p.dataPath(file);
        if(!myEmulador.started) 
        {
            myEmulador.rom = file;
            myEmulador.start(); 
        }else {
            myEmulador.nes.loadRom(file);
        }
    }
    
    //------------------------
  
    public void draw() 
    {
        drawPixels(0, 0);
    }
    
    //------------------------
    
    public void draw(int x, int y) 
    {
        drawPixels(x, y);
    }
    
    //------------------------
    
    public void draw(int x, int y, int width, int height) 
    {
        updateFrameBuffer();
        p.image(getFrameBuffer(), x, y,width,height);
    }
    
    //------------------------
    
    private void drawPixels(int x, int y)    
    {
        updateFrameBuffer();
        p.image(img, x, y);
    }
    
    //------------------------
      
    public PImage getFrameBuffer() 
    {  
        return img;
    }  
    
    //------------------------

    public void updateFrameBuffer() 
    {  
        int pix[] = myEmulador.nes.ppu.pixelEndRender;
        img.loadPixels();
        for (int i = 0; i < img.pixels.length; i++) 
        {
            int alpha = (pix[i] >> 24) & 0xff;
            int red   = (pix[i] >> 16) & 0xff;
            int green = (pix[i] >>  8) & 0xff;
            int blue  = (pix[i]      ) & 0xff;

            img.pixels[i] = p.color(blue,green,red) ; 
        }
        img.updatePixels();
    }
      
    //------------------------
    
    public void enableSound( boolean enabled ) 
    {
        myEmulador.nes.enableSound( enabled);
    }
    
    //------------------------
    
    public void pressKey() 
    {
        if (p.key == p.CODED) {
            if (p.keyCode == p.UP) {
                press_KEY_UP();
                p.println("press:UP");
            } else if (p.keyCode == p.DOWN) {
                press_KEY_DOWN();
                p.println("press:DOWN");
            } else if (p.keyCode == p.LEFT) {
                press_KEY_LEFT();
                p.println("press:LEFT");
            } else if (p.keyCode == p.RIGHT) {
                press_KEY_RIGHT();
                p.println("press:RIGHT");
            } 
        }else{
            if(p.key=='z') press_KEY_A();
            if(p.key=='x') press_KEY_B();
            if(p.key=='c') press_KEY_START();
            if(p.key=='v') press_KEY_SELECT();
        } 
    }
    
    //------------------------

    private void pressKey( int kc ) 
    {
        KbInputHandler input =  (KbInputHandler)myEmulador.nes.getGui().getJoy1();
        input.allKeysState[input.keyMapping[kc]] = true;

		if (kc == input.keyMapping[InputHandler.KEY_LEFT]) {
            input.allKeysState[input.keyMapping[InputHandler.KEY_RIGHT]] = false;
        } else if (kc == input.keyMapping[InputHandler.KEY_RIGHT]) {
            input.allKeysState[input.keyMapping[InputHandler.KEY_LEFT]] = false;
        } else if (kc == input.keyMapping[InputHandler.KEY_UP]) {
            input.allKeysState[input.keyMapping[InputHandler.KEY_DOWN]] = false;
        } else if (kc == input.keyMapping[InputHandler.KEY_DOWN]) {
            input.allKeysState[input.keyMapping[InputHandler.KEY_UP]] = false;
        }
    }
    
    //------------------------
    
    public void releaseKey() 
    {
        if (p.key == p.CODED) {
            if (p.keyCode == p.UP) {
                release_KEY_UP();
                p.println("release:UP");
            } else if (p.keyCode == p.DOWN) {
                release_KEY_DOWN();
                p.println("release:DOWN");
            } else if (p.keyCode == p.LEFT) {
                release_KEY_LEFT();
                p.println("release:LEFT");
            } else if (p.keyCode == p.RIGHT) {
                release_KEY_RIGHT();
                p.println("release:RIGHT");
            }       
        }else{
            if(p.key=='z') release_KEY_A();
            if(p.key=='x') release_KEY_B();
            if(p.key=='c') release_KEY_START();
            if(p.key=='v') release_KEY_SELECT();
        }
    }
    
    //------------------------
    
    public void releaseKey( int kc) 
    {
        KbInputHandler input =  (KbInputHandler) myEmulador.nes.getGui().getJoy1();
        input.allKeysState[input.keyMapping[kc]] = false; 
    }
    
    //------------------------
    
    public void press_KEY_A()
    {
        pressKey( InputHandler.KEY_A );  
    }
    
    //------------------------
    
    public void press_KEY_B()
    {
        pressKey( InputHandler.KEY_B );
    }
    
    //------------------------
    
    public void press_KEY_START()
    {
        pressKey( InputHandler.KEY_START );
    }
    
    //------------------------
    
    public void press_KEY_SELECT()
    {
        pressKey( InputHandler.KEY_SELECT );
    }
    
    //------------------------
    
    public void press_KEY_UP()
    {
        pressKey( InputHandler.KEY_UP );   
    }

    //------------------------    

    public void press_KEY_DOWN()
    {
        pressKey( InputHandler.KEY_DOWN );
    }
    
    //------------------------
    
    public void press_KEY_LEFT()
    {
        pressKey( InputHandler.KEY_LEFT );
    }
    
    //------------------------
    
    public void press_KEY_RIGHT()
    {
        pressKey( InputHandler.KEY_RIGHT );
    }    
    
    //--------------------------
    
    public void release_KEY_A()
    {
        releaseKey( InputHandler.KEY_A );      
    }
    
    //------------------------
    
    public void release_KEY_B()
    {
        releaseKey( InputHandler.KEY_B );
    }
    
    //------------------------
    
    public void release_KEY_START()
    {
        releaseKey( InputHandler.KEY_START );
    }
    
    //------------------------
    
    public void release_KEY_SELECT()
    {
        releaseKey( InputHandler.KEY_SELECT );
    }
    
    //------------------------
    
    public void release_KEY_UP()
    {
        releaseKey( InputHandler.KEY_UP );   
    }
    
    //------------------------
    
    public void release_KEY_DOWN()
    {
        releaseKey( InputHandler.KEY_DOWN );
    }
    
    //------------------------
    
    public void release_KEY_LEFT()
    {
        releaseKey( InputHandler.KEY_LEFT );
    }
    
    //------------------------
    
    public void release_KEY_RIGHT()
    {
        releaseKey( InputHandler.KEY_RIGHT );
    }    
	
	//------------------------
    
    public void pressAndRelease_KEY_SELECT()
    {
    	if(!isEnabledAutoReleaseKeys) enabledAutoReleaseKeys();
		myKeyPressAndRelease[0].pressAndRelease_key_SELECT();
    }
	
	//------------------------
    
    public void pressAndRelease_KEY_START()
    {
    	if(!isEnabledAutoReleaseKeys) enabledAutoReleaseKeys();
      	myKeyPressAndRelease[1].pressAndRelease_key_START();
    }
	
	//------------------------
    
    public void pressAndRelease_KEY_A()
    {
    	if(!isEnabledAutoReleaseKeys) enabledAutoReleaseKeys();
      	myKeyPressAndRelease[2].pressAndRelease_key_A();
    }
	
	//------------------------
    
    public void pressAndRelease_KEY_B()
    {
    	if(!isEnabledAutoReleaseKeys) enabledAutoReleaseKeys();
      	myKeyPressAndRelease[3].pressAndRelease_key_B();
    }
	
	//------------------------
    
    public void pressAndRelease_KEY_UP()
    {
    	if(!isEnabledAutoReleaseKeys) enabledAutoReleaseKeys();
      	myKeyPressAndRelease[4].pressAndRelease_key_UP();
    }
	
	//------------------------
    
    public void pressAndRelease_KEY_DOWN()
    {
    	if(!isEnabledAutoReleaseKeys) enabledAutoReleaseKeys();
      	myKeyPressAndRelease[5].pressAndRelease_key_DOWN();
    }
	
	//------------------------
    
    public void pressAndRelease_KEY_LEFT()
    {
    	if(!isEnabledAutoReleaseKeys) enabledAutoReleaseKeys();
      	myKeyPressAndRelease[6].pressAndRelease_key_LEFT();
    }
    
    //------------------------
    
    public void pressAndRelease_KEY_RIGHT()
    {
    	if(!isEnabledAutoReleaseKeys) enabledAutoReleaseKeys();
    	myKeyPressAndRelease[7].pressAndRelease_key_RIGHT();
    }
    
    //------------------------
    
    public void setTimeAutoReleaseAllKeys(int value)
    {
    	for(int i=0; i<myKeyPressAndRelease.length; i++){
			myKeyPressAndRelease[i].setTimeAutoRelease(value);
		}
    }
    
    	//------------------------
    
    public void setTimeAutoRelease_KEY_SELECT(int value)
    {
		myKeyPressAndRelease[0].setTimeAutoRelease(value);
    }
	
	//------------------------
    
    public void setTimeAutoRelease_KEY_START(int value)
    {
      myKeyPressAndRelease[1].setTimeAutoRelease(value);
    }
	
	//------------------------
    
    public void setTimeAutoRelease_KEY_A(int value)
    {
      myKeyPressAndRelease[2].setTimeAutoRelease(value);
    }
	
	//------------------------
    
    public void setTimeAutoRelease_KEY_B(int value)
    {
      myKeyPressAndRelease[3].setTimeAutoRelease(value);
    }
	
	//------------------------
    
    public void setTimeAutoRelease_KEY_UP(int value)
    {
      myKeyPressAndRelease[4].setTimeAutoRelease(value);
    }
	
	//------------------------
    
    public void setTimeAutoRelease_KEY_DOWN(int value)
    {
      myKeyPressAndRelease[5].setTimeAutoRelease(value);
    }
	
	//------------------------
    
    public void setTimeAutoRelease_KEY_LEFT(int value)
    {
      myKeyPressAndRelease[6].setTimeAutoRelease(value);
    }
    
    //------------------------
    
    public void setTimeAutoRelease_KEY_RIGHT(int value)
    {
      myKeyPressAndRelease[7].setTimeAutoRelease(value);
    }
    
    //------------------------
    
    public void setEnableSound(boolean enable)
    {
    	myEmulador.nes.enableSound(enable);
    }
    
    //------------------------
    
    public void setFramerate(int rate) {
    	myEmulador.nes.setFramerate(rate);
    }
    
    //------------------------
    
    public int getFramerate() {
    	return myEmulador.nes.getFramerate();
    }
}