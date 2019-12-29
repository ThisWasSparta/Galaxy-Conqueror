class Text_Particles { //This class is about the score's text display when an enemy touches the bottom of the screen. It was written by Dylan Kleton
  int textTimer = 0;
  boolean duringTextTimer;
  final int SHOW_TEXT = 700;
  
  void drawText ()
    
  {
    if (millis() - SHOW_TEXT > textTimer) {
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
