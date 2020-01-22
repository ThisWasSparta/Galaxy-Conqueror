//this class was written by Noah Verburg
class VisualEffects {
  int screenShakeTimer = 0;
  float magnitudeX;
  float maxMagnitudeX;
  float minMagnitudeX;
  float magnitudeY;
  float maxMagnitudeY;
  float minMagnitudeY;
  float randomMagnitudeX;
  float randomMagnitudeY;
  float inc = TWO_PI/25;
  float screenShakeFactor = 0.0;
  float xDirection;
  float yDirection;

  boolean screenShakeTest;

  void screenShake(int screenShakeMin, int screenShakeMax, boolean screenShakeStart) {  //this function makes the screen shake by changing the x & y positions of almost every object on screen.
    if (screenShakeStart && millis() - 100  > screenShakeTimer && !boss.bossDied) {
      xDirection = random(-1, 1);
      yDirection = random(-1, 1);
      visuals.maxMagnitudeX = xDirection * screenShakeMax;  //decides randomly if the screen shakes to the left or to the right first.
      visuals.maxMagnitudeY = yDirection * screenShakeMax;  //decides randomly if the screen shakes up or down first.
      visuals.minMagnitudeX = xDirection * screenShakeMin;
      visuals.minMagnitudeY = yDirection * screenShakeMin;
      
      //making sure the values used for calculation of the magnitude are positive, or the calculation won't work properly
      if (visuals.maxMagnitudeX < screenShakeMin && visuals.maxMagnitudeX > 0) {
        visuals.maxMagnitudeX = screenShakeMin;
      }
      if (visuals.maxMagnitudeX > -screenShakeMin && visuals.maxMagnitudeX < 0) {
        visuals.maxMagnitudeX = - screenShakeMin;
      }
      if (visuals.maxMagnitudeY < screenShakeMin && visuals.maxMagnitudeY > 0) {
        visuals.maxMagnitudeY = screenShakeMin;
      }
      if (visuals.maxMagnitudeY > -screenShakeMin && visuals.maxMagnitudeY < 0) {
        visuals.maxMagnitudeY = - screenShakeMin;
      }
      
      //these will determine the final magnitude of the screenshake
      randomMagnitudeX = random(visuals.minMagnitudeX, visuals.maxMagnitudeX);
      randomMagnitudeY = random(visuals.minMagnitudeY, visuals.maxMagnitudeY);
      screenShakeTimer = millis();
      screenShakeStart = false;
    }
    if (!screenShakeStart && !boss.bossDied) {  //this makes the screen shake less and less until it stops.
      visuals.magnitudeX = sin(visuals.screenShakeFactor) * randomMagnitudeX;  //the sinus function is the thing that makes the screen shake back and forth
      visuals.magnitudeY = sin(visuals.screenShakeFactor) * randomMagnitudeY;
      visuals.randomMagnitudeX *= 0.92;  //these make sure the screenshake magnitude reduces over time
      visuals.randomMagnitudeY *= 0.92;
      visuals.screenShakeFactor += visuals.inc;
    }

    if (!screenShakeStart && boss.bossDied) {  //this function is only for the boss' screenshake, and makes it shake less and less until it stops.
      visuals.magnitudeX = sin(visuals.screenShakeFactor) * randomMagnitudeX;  //the sinus function is the thing that makes the screen shake back and forth
      visuals.magnitudeY = sin(visuals.screenShakeFactor) * randomMagnitudeY;
      visuals.randomMagnitudeX *= 0.985;  //these make sure the screenshake magnitude reduces over time, though slower than normal
      visuals.randomMagnitudeY *= 0.985;
      visuals.screenShakeFactor += visuals.inc;
      if (visuals.randomMagnitudeX > -1 && visuals.randomMagnitudeY < 1) {
        boss.bossDied = false;
      }
    }
  }

  void testScreenShake() {
    if (screenShakeTest) {
      visuals.screenShake(10, 50, true);
    }
  }
}
