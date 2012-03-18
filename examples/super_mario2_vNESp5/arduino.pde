import processing.serial.*;

Serial myPort;  // The serial port

void startArduino() {
  // List all the available serial ports
  println(Serial.list());
  // I know that the first port in the serial list on my mac
  // is always my  Keyspan adaptor, so I open Serial.list()[0].
  // Open whatever port is the one you're using.
  myPort = new Serial(this, Serial.list()[0], 9600);
}

void updateArduino() {
  while (myPort.available() > 0) {
    char inByte = myPort.readChar();
    if(inByte == '1'){ count++; }
  }
}
