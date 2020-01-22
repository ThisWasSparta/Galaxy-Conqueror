//This code was written by Sam Spronk
class Health {
  float x;
  float y = height - height / 40;
  float heartW;
  float heartH;
  float defaultHeartWidth = 54 * sizeFactor;
  float defaultHeartHeight = 42 * sizeFactor;

  PImage texture;

  void playerHealth() {
    if (heartNumber == 3) {                                                //displays the number of hearts you have left
      for (int i = 0; i < 3; i++) {
        heart[i].x = width / 60 + width / 100 * 3 * i;
        image(heart[i].texture, heart[i].x + visuals.magnitudeX, heart[i].y + visuals.magnitudeY, heart[i].heartW, heart[i].heartH);
      }
    }
    if (heartNumber == 2) {
      for (int i = 0; i < 2; i++) {
        heart[i].x = width / 60 + width / 100 * 3 * i;
        image(heart[i].texture, heart[i].x + visuals.magnitudeX, heart[i].y + visuals.magnitudeY, heart[i].heartW, heart[i].heartH);
      }
    }
    if (heartNumber == 1) {
      heart[0].x = width / 60 + width / 100 * 3;
      image(heart[0].texture, heart[0].x + visuals.magnitudeX, heart[0].y + visuals.magnitudeY, heart[0].heartW, heart[0].heartH);
    }
  }

  Health() {
    texture = loadImage("Heart.png");
  }
}
