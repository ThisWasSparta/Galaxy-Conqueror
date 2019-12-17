class VisualEffects {
  int screenShakeTimer = 0;
  float magnitudeX;
  float maxMagnitudeX;
  float magnitudeY;
  float maxMagnitudeY;
  float inc = TWO_PI/25;
  float screenShakeFactor = 0.0;

  void screenShake(int screenShakeMin, int screenShakeMax, boolean screenShakeStart) {
    if (screenShakeStart && millis() - 100  > screenShakeTimer) {
      visuals.maxMagnitudeX = random(-screenShakeMax, screenShakeMax);
      visuals.maxMagnitudeY = random(-screenShakeMax, screenShakeMax);
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
      screenShakeTimer = millis();
      screenShakeStart = false;
    }
  }

  void updateScreenShake() {
    visuals.magnitudeX = sin(visuals.screenShakeFactor) * visuals.maxMagnitudeX;
    visuals.magnitudeY = sin(visuals.screenShakeFactor) * visuals.maxMagnitudeY;
    visuals.maxMagnitudeX *= 0.99;
    visuals.maxMagnitudeY *= 0.99;
    visuals.screenShakeFactor += visuals.inc;
  }
}
