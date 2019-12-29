class Text_Particles { //This class is about the score's text display when an enemy touches the bottom of the screen. It was written by Dylan Kleton
  int textTimer = 0;
  boolean duringTextTimer;
  void drawText ()
  {
    if (millis() - 750 > textTimer) {
      duringTextTimer = false;
    } else {
      duringTextTimer = true;
    }
    if (duringTextTimer) {
     fill(255, 0, 0);
     textSize(65);
     text("-100", tX + visuals.magnitudeX+100, tY / 0.5 + visuals.magnitudeY -50);
     }
  }

  void spawnText() {
    textTimer = millis();
  }
}
