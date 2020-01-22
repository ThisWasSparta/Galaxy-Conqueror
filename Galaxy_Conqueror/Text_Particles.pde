class Text_Particles { //This class is about the score's text display when an enemy touches the bottom of the screen. It was written by Dylan Kleton
  int textTimer = 0;
  boolean duringTextTimer; //This
  final int SHOW_TEXT = 700; // Ammount of miliseconds the text is shown

  void drawText () //This method draws the text for the score decrease
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
      // The -100 stands for the score decreasement. Sicne all enemies decrease the score by -100 I decided to not make it a seperate variable.
    }
  }
  //This method activates the timer for spawning the score decresement text.
  void spawnText() {
    textTimer = millis();
  }
}
