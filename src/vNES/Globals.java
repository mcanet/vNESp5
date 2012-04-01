package vNES;


import java.util.*;
import processing.core.*;

public class Globals {

    public static int soundBufferTimeToSleep = -1;

    public static double CPU_FREQ_NTSC = 1789772.5d;
    public static double CPU_FREQ_PAL = 1773447.4d;
    public static int preferredFrameRate = 60;
    
    // Microseconds per frame:
    public static int frameTime = 1000000 / preferredFrameRate;
    // What value to flush memory with on power-up:
    public static short memoryFlushValue = 0xFF;

    public static final boolean debug = true;
    public static final boolean fsdebug = false;

    public static boolean appletMode = true;
    public static boolean disableSprites = false;
    public static boolean timeEmulation = true;
    public static boolean palEmulation;
    public static boolean enableSound = true;
    public static boolean focused = false;

    public static HashMap keycodes = new HashMap(); //Java key codes
    public static HashMap controls = new HashMap(); //vNES controls codes

    public static NES nes;

    public static void println(String s) {
        nes.getGui().println(s);
    }
    
    // to communicated to PApplet from sNesp5
    public static PApplet p;
}