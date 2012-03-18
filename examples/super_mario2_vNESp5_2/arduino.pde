
  // The serial port

arduinoTreadmill myArduinoTreadmill;
Thread treadmillThread;
Serial myPort;

class arduinoTreadmill implements Runnable {
  
   boolean running = true;
  int waitingTime = 50;
  PApplet p;
  
  public arduinoTreadmill() 
  {


  }
  
  public void run() 
  {  
    while(running)
    {
       try{
            updateArduino();
            treadmillThread.sleep( waitingTime);
       } catch(InterruptedException e) {
         e.printStackTrace();
       }
    }    
  }


  void updateArduino() {
    while (myPort.available() > 0) {
      char inByte = myPort.readChar();
      if(inByte == '1'){ count++; }
      //println(count);
    }
  }

}


