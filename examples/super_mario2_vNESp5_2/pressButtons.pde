
//----------------------------------------------------
void pressKey_A()
{
       try {
           Robot robot = new Robot();
           robot.keyPress(KeyEvent.VK_A);
           robot.delay(10);
           robot.keyRelease(KeyEvent.VK_A);
       } catch (AWTException e) {
           e.printStackTrace();
       }
}

void pressKey_A_p()
{
       try {
           Robot robot = new Robot();
           robot.keyPress(KeyEvent.VK_ENTER);
       } catch (AWTException e) {
           e.printStackTrace();
       }
}

void pressKey_A_r()
{
       try {
           Robot robot = new Robot();
           robot.keyRelease(KeyEvent.VK_ENTER);
       } catch (AWTException e) {
           e.printStackTrace();
       }
}
//----------------------------------------------------
void pressKey_B()
{
       try {
           Robot robot = new Robot();
           robot.keyPress(KeyEvent.VK_SHIFT);
           robot.delay(10);
           robot.keyRelease(KeyEvent.VK_SHIFT);
       } catch (AWTException e) {
           e.printStackTrace();
       }
}
void pressKey_B_p()
{
       try {
           Robot robot = new Robot();
           robot.keyPress(KeyEvent.VK_SHIFT);
       } catch (AWTException e) {
           e.printStackTrace();
       }
}
void pressKey_B_r()
{
       try {
           Robot robot = new Robot();
           robot.keyRelease(KeyEvent.VK_SHIFT);
       } catch (AWTException e) {
           e.printStackTrace();
       }
}
//----------------------------------------------------
void pressKey_UP()
{
       try {
           Robot robot = new Robot();
           robot.keyPress(KeyEvent.VK_ALT);
           robot.delay(10);
           robot.keyRelease(KeyEvent.VK_ALT);
       } catch (AWTException e) {
           e.printStackTrace();
       }
}

void pressKey_UP_p()
{
       try {
           Robot robot = new Robot();
           robot.keyPress(KeyEvent.VK_ALT);
       } catch (AWTException e) {
           e.printStackTrace();
       }
}

void pressKey_UP_r()
{
       try {
           Robot robot = new Robot();
           robot.keyRelease(KeyEvent.VK_ALT);
       } catch (AWTException e) {
           e.printStackTrace();
       }
}
//----------------------------------------------------
void pressKey_DOWN()
{
       try {
           Robot robot = new Robot();
           robot.keyPress(KeyEvent.VK_DOWN);
           robot.delay(10);
           robot.keyRelease(KeyEvent.VK_DOWN);
       } catch (AWTException e) {
           e.printStackTrace();
       }
}
void pressKey_DOWN_p()
{
       try {
           Robot robot = new Robot();
           robot.keyPress(KeyEvent.VK_DOWN);
       } catch (AWTException e) {
           e.printStackTrace();
       }
}
void pressKey_DOWN_r()
{
       try {
           Robot robot = new Robot();
           robot.keyRelease(KeyEvent.VK_DOWN);
       } catch (AWTException e) {
           e.printStackTrace();
       }
}
//----------------------------------------------------

void pressKey_LEFT()
{
       try {
           Robot robot = new Robot();
           robot.keyPress(KeyEvent.VK_LEFT);
           robot.delay(40);
           robot.keyRelease(KeyEvent.VK_LEFT);
       } catch (AWTException e) {
           e.printStackTrace();
       }
}
//----------------------------------------------------
void pressKey_RIGHT()
{
       try {
           Robot robot = new Robot();
           robot.keyPress(KeyEvent.VK_LEFT);
           robot.delay(10);
           robot.keyRelease(KeyEvent.VK_LEFT);
       } catch (AWTException e) {
           e.printStackTrace();
       }
}

void pressKey_RIGHT_p()
{
       try {
           Robot robot = new Robot();
           robot.keyPress(KeyEvent.VK_RIGHT);
       } catch (AWTException e) {
           e.printStackTrace();
       }
}

void pressKey_RIGHT_r()
{
       try {
           Robot robot = new Robot();
           robot.keyRelease(KeyEvent.VK_RIGHT);
       } catch (AWTException e) {
           e.printStackTrace();
       }
}

//----------------------------------------------------

