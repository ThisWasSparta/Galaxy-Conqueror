//Deze class is geschreven door Noah Verburg
class Interface {
  void drawInterface() {
    textSize(25);
    /*fill(255,0,0);
     text("A", width * 0.95, height * 0.9);
     fill(255, 255, 255);
     text("NEXT", width * 0.95, height * 0.93);
     text("WEAPON", width * 0.95, height * 0.96);*/

    fill(0, 255, 0);
    text("Y", width * 0.8, height * 0.9);
    fill(255, 255, 255);
    text("SHOOT", width * 0.8, height * 0.93);

    textSize(15);
    text("HIT THE", width * 0.052, height * 0.91);
    text("METEORITE", width * 0.052, height * 0.93);
    text("FOR +1 HEALTH", width * 0.052, height * 0.95);
  }
}
