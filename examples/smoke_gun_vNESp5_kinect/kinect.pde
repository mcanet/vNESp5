void kinectSetup(){
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableUser(SimpleOpenNI.SKEL_PROFILE_ALL);
  kinect.setMirror(false);
  kinect.enableRGB();
  
  //size(640, 480);
  smooth();

  handImage = loadImage("hand.png");
}

void kinectDraw(){
  kinect.update();
  image(kinect.rgbImage(), 0, 0);
  IntVector userList = new IntVector();
  kinect.getUsers(userList);
  
  if (userList.size() > 0) {
    int userId = userList.get(0);
    
   
    kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_TORSO, torsoPos);
    kinect.convertRealWorldToProjective(torsoPos, torsoPos);

    rightArmAngle = getJointAngle(userId, SimpleOpenNI.SKEL_RIGHT_HAND, SimpleOpenNI.SKEL_RIGHT_ELBOW);
    PVector handPos = new PVector();
    kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_HAND, handPos);
    PVector convertedHandPos = new PVector();
    kinect.convertRealWorldToProjective(handPos, convertedHandPos);
    
    float newImageWidth = map(convertedHandPos.z, 500, 2000, handImage.width/6, handImage.width/12);
    float newImageHeight = map(convertedHandPos.z, 500, 2000, handImage.height/6, handImage.height/12);
    
    //float newImageWidth = convertedHandPos.z*0.1;
    //float newImageHeight = convertedHandPos.z*0.2;
    
    newImageWidth = constrain(newImageWidth, 75, 100);
    
    pushMatrix();
      translate(convertedHandPos.x, convertedHandPos.y);
      rotate(rightArmAngle*-1);
      rotate(PI/2);
      image(handImage, -1 * (newImageWidth/2), 0 - (newImageHeight/2), newImageWidth, newImageHeight);
    popMatrix();
  }
}

float getJointAngle(int userId, int jointID1, int jointID2) {
  PVector joint1 = new PVector();
  PVector joint2 = new PVector();
  kinect.getJointPositionSkeleton(userId, jointID1, joint1);
  kinect.getJointPositionSkeleton(userId, jointID2, joint2);
  return atan2(joint1.y-joint2.y, joint1.x-joint2.x);
} 

// user-tracking callbacks:
void onNewUser(int userId) {
  kinect.startPoseDetection("Psi", userId);
  println("Started pose detection.");
}

void onEndCalibration(int userId, boolean successful) {
  if (successful) {
    println("User calibrated.");
    kinect.startTrackingSkeleton(userId);
  }
  else {
    println("Failed to calibrate user.");
    kinect.startPoseDetection("Psi", userId);
  }
}

void onStartPose(String pose, int userId) {
  println("Started pose for user.");
  kinect.stopPoseDetection(userId);
  kinect.requestCalibrationSkeleton(userId, true);
}
