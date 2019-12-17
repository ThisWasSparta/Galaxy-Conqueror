//Deze class is geschreven door Noah Verburg
class Interface {
  void drawInterface() {
    textSize(25);
    fill(191, 5, 26);
    text("A", width * 0.15 + visuals.magnitudeX, height * 0.05 + visuals.magnitudeY);
    fill(255, 255, 255);
    text("NEXT", width * 0.15 + visuals.magnitudeX, height * 0.1 + visuals.magnitudeY);
    text("WEAPON", width * 0.15 + visuals.magnitudeX, height * 0.15 + visuals.magnitudeY);

    fill(220, 177, 39);
    text("B", width * 0.05 + visuals.magnitudeX, height * 0.05 + visuals.magnitudeY);
    fill(255, 255, 255);
    text("SHOOT", width * 0.05 + visuals.magnitudeX, height * 0.1 + visuals.magnitudeY);

    textSize(15);
    text("HIT THE", width * 0.052 + visuals.magnitudeX, height * 0.91 + visuals.magnitudeY);
    text("METEORITE", width * 0.052 + visuals.magnitudeX, height * 0.93 + visuals.magnitudeY);
    text("FOR +1 HEALTH", width * 0.052 + visuals.magnitudeX, height * 0.95 + visuals.magnitudeY);
  }
}
