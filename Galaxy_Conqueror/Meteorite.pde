//Deze class is geschreven door Dennis
class Meteoriet {
  float x, y, startX, startY;
  float size;
  float speed = random(6, 10);
  float hitBoxX;
  float hitBoxY;
  float hitBoxW;
  float hitBoxH;

  PImage meteorite;

  Meteoriet() {
    x = random(1, width); 
    y = random(1, 10); //Deze waardes regelen de positie van de meteoriet
    startY = y;
    startX = x; //Deze waardes regelen de startpositie van de meteoriet
    size = random(40, 60);  // size word random geregeld tussen 40 en 60
    hitBoxX = x;
    hitBoxY = y; //deze waardes zijn voor de hitbox positie
    hitBoxH = size;
    hitBoxW = size; //deze waardes regelen de grootte van de hitbox
    rectMode(CENTER);
  }

  //regelt de movement van de meteoriet
  void update() {

    y += speed;
    hitBoxY += speed;

    if (startX > width/2) {
      x -= speed/2;
      hitBoxX -= speed/2;
    }

    if (startX < width/2) {
      x += speed;
      hitBoxX += speed;
    }
  }

  //tekent de meteoriet
  void drawM() {
    noStroke();
    fill(255, 255, 255, 0);
    rect(hitBoxX, hitBoxY, hitBoxW, hitBoxH);
    //fill(131,69,46);
    //ellipse(x, y, size, size);
    image(meteoriet.meteorite, x + visuals.magnitudeX, y + visuals.magnitudeY, 62, 48);
  }
}
