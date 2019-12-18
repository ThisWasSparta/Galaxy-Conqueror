class Text_Particles { //This class is about the score's text display when an enemy touches the bottom of the screen. It was written by Dylan Kleton

  void drawText ()
  {

    fill(255, 0, 0);
    textSize(55);
    text("-100", tX + visuals.magnitudeX+100, tY / 0.5 + visuals.magnitudeY -50);
  }
}
