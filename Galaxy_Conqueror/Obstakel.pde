//deze class is geschreven door Dennis
class Obstakel {

  int meteorietNumber = 6;
  int time;
  boolean meteorietHit;
  float amountMeteorite = random(5, 8);

  ArrayList<Meteoriet> meteorieten = new ArrayList<Meteoriet> ();

  Obstakel() {
    meteoriet = new Meteoriet();
    time = millis();
    meteorietHit = false;
  }

  void placeMeteorite() {
    //op een random moment (voor zover je dit random kunt noemen) wordt er een meteoriet toegevoegd aan de arraylist
    if (millis() > time+random(5000, 15000)) {
      meteorieten.add(new Meteoriet());
      time = millis();
    }

    //hier wordt door de array geloopt om de meteoriet op het scherm te laten verschijnen
    for (int i = meteorieten.size() - 1; i > 0; i--) {
      Meteoriet m = meteorieten.get(i);
      m.update();
      if (meteorietHit == false) {
        m.drawM();
      } else if (meteorietHit == true) {
        meteorietHit = false;
      }

      for (int t = 0; t < playerBulletNumber; t++) {
        if (!meteorietHit && weapon[t].bX < meteorieten.get(i).hitBoxX + meteorieten.get(i).hitBoxW && weapon[t].bX > meteorieten.get(i).hitBoxX && weapon[t].bY < meteorieten.get(i).hitBoxY + meteorieten.get(i).hitBoxH && weapon[t].bY > meteorieten.get(i).hitBoxY)
        {
          meteorietHit = true;    //als de player bullet de meteoriet raakt, dan is deze boolean true
          if (meteorietHit) {
            meteorieten.remove(i);
            scoreObj.addScore(25 * scoreMultiplier);
            scoreObj.addScore(50 * scoreMultiplier);
            if (heartNumber < 3) {
              heartNumber += 1;
            }
            break;
          }
        }
      }
    }
  }

  void makeMeteoriteShower() {

    //op een random moment tussen de 30 en 60 sec komt de meteoriteshower event
    if (millis() > time+random(5000, 8000)) {
      for (int i = 0; i < amountMeteorite; i++) {
        meteorieten.add(new Meteoriet());
      }
      time = millis();
    }
    
    //hier wordt door de array geloopt om de meteoriet op het scherm te laten verschijnen
    for (int i = meteorieten.size() - 1; i > 0; i--) {
      Meteoriet m = meteorieten.get(i);
      m.update();
      if (meteorietHit == false) {
        m.drawM();
      } else if (meteorietHit == true) {
        meteorietHit = false;
      }

      for (int t = 0; t < playerBulletNumber; t++) {
        if (!meteorietHit && weapon[t].bX < meteorieten.get(i).hitBoxX + meteorieten.get(i).hitBoxW && weapon[t].bX > meteorieten.get(i).hitBoxX && weapon[t].bY < meteorieten.get(i).hitBoxY + meteorieten.get(i).hitBoxH && weapon[t].bY > meteorieten.get(i).hitBoxY)
        {
          meteorietHit = true;    //als de player bullet de meteoriet raakt, dan is deze boolean true
          if (meteorietHit) {
            meteorieten.remove(i);
            scoreObj.addScore(25 * scoreMultiplier);
            scoreObj.addScore(50 * scoreMultiplier);
            if (heartNumber < 3) {
              heartNumber += 1;
            }
            break;
          }
        }
      }
    }
    
  }

  void drawObstakel() {
    placeMeteorite();
  }
}
