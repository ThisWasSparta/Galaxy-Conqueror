//Deze class is geschreven door Noah Verburg
class Interface {
  void drawInterface() {
    textSize(25);
     fill(220, 177, 39);
     text("A", width * 0.95, height * 0.1);
     fill(255, 255, 255);
     text("NEXT", width * 0.95, height * 0.15);
     text("WEAPON", width * 0.95, height * 0.2);

    fill(191, 5, 26);
    text("B", width * 0.8, height * 0.1);
    fill(255, 255, 255);
    text("SHOOT", width * 0.8, height * 0.15);

    textSize(15);
    text("HIT THE", width * 0.052, height * 0.91);
    text("METEORITE", width * 0.052, height * 0.93);
    text("FOR +1 HEALTH", width * 0.052, height * 0.95);
  }
}
