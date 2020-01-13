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
    size = random(40, 60);  // size word random geregeld tussen 40 en 60
    startY = y;
    startX = x; //Deze waardes regelen de startpositie van de meteoriet
    hitBoxX = x;
    hitBoxY = y; //deze waardes zijn voor de hitbox positie
    hitBoxH = size+size/10;
    hitBoxW = size+size/10; //deze waardes regelen de grootte van de hitbox
    rectMode(CENTER);
  }

  //regelt de movement van de meteoriet
  void update() {

    y += speed;
    hitBoxY += speed;          //hier word de snelheid van de meteoriet geregeld

    if (startX > width/2) {    //als de startpositie rechts is van het scherm dan is de richting van de meteoriet links
      x -= speed/2;
      hitBoxX -= speed/2;
    }

    if (startX < width/2) {    //als de startpositie links is van het scherm dan is de richting van de meteoriet rechts
      x += speed;
      hitBoxX += speed;
    }
  }

  void drawM() {                  //tekent de meteoriet
    noStroke();
    fill(255, 255, 255, 0);
    rect(hitBoxX, hitBoxY, hitBoxW, hitBoxH);
    image(meteoriet.meteorite, x + visuals.magnitudeX, y + visuals.magnitudeY, 62, 48);
  }
}
