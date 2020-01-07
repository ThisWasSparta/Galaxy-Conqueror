//deze class is geschreven door Dennis
class Obstakel {

  int meteorietNumber = 6;
  int meteorScore = 25;
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
    if (tutorial) {
      time = millis();
      if (millis() > time+random(5000, 15000)) {
        meteorieten.add(new Meteoriet());
        time = millis();
      }
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

      for (int t = 0; t < PLAYER_BULLET_NUMBER; t++) {
        if (!meteorietHit && weapon[t].bulletXposition < meteorieten.get(i).hitBoxX + meteorieten.get(i).hitBoxW && weapon[t].bulletXposition > meteorieten.get(i).hitBoxX && weapon[t].bulletYposition < meteorieten.get(i).hitBoxY + meteorieten.get(i).hitBoxH && weapon[t].bulletYposition > meteorieten.get(i).hitBoxY) {
          meteorietHit = true;    //als de player bullet de meteoriet raakt, dan is deze boolean true
          if (meteorietHit) {
            meteorieten.remove(i);
            scoreObj.addScore(meteorScore * scoreMultiplier);
            if (heartNumber < 3) {
              heartNumber += 1;
            }
            break;
          }
        }
        if (!meteorietHit && weapon[t].laserXposition - weapon[t].laserWidth/2 < meteorieten.get(i).hitBoxX + meteorieten.get(i).hitBoxW && weapon[t].laserXposition + weapon[t].laserWidth/2 > meteorieten.get(i).hitBoxX && weapon[i].laserIsAlive) {
          meteorietHit = true;    //als de player bullet de meteoriet raakt, dan is deze boolean true
          if (meteorietHit) {
            meteorieten.remove(i);
            scoreObj.addScore(meteorScore * scoreMultiplier);
            if (heartNumber < 3) {
              heartNumber += 1;
            }
            break;
          }
        }
        if (!meteorietHit && weapon[t].rocketXposition < meteorieten.get(i).hitBoxX + meteorieten.get(i).hitBoxW && weapon[t].rocketXposition > meteorieten.get(i).hitBoxX && weapon[t].rocketYposition < meteorieten.get(i).hitBoxY + meteorieten.get(i).hitBoxH && weapon[t].rocketYposition > meteorieten.get(i).hitBoxY) {
          if (meteorietHit) {
            meteorieten.remove(i);
            scoreObj.addScore(meteorScore * scoreMultiplier);
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

      for (int t = 0; t < PLAYER_BULLET_NUMBER; t++) {
        if (!meteorietHit && weapon[t].bulletXposition < meteorieten.get(i).hitBoxX + meteorieten.get(i).hitBoxW && weapon[t].bulletXposition > meteorieten.get(i).hitBoxX && weapon[t].bulletYposition < meteorieten.get(i).hitBoxY + meteorieten.get(i).hitBoxH && weapon[t].bulletYposition > meteorieten.get(i).hitBoxY)
        {
          meteorietHit = true;    //als de player bullet de meteoriet raakt, dan is deze boolean true
          if (meteorietHit) {
            meteorieten.remove(i);
            scoreObj.addScore(meteorScore * scoreMultiplier);
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
